Return-Path: <netdev+bounces-209761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50124B10B73
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457793B464F
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25702D9484;
	Thu, 24 Jul 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4vRD5eu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99082D8DA6;
	Thu, 24 Jul 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363915; cv=none; b=psWcJ5br4yXtYvxiDthAoKkDPH3tB5iYQXush7oUiE+VOwf1w4sOX6W2DIDig83M+7GxhHYdM2o2eR8RHulqNAl7JdW7hSlbo0OF3MRBBtv0efysasc9ypNBc3v/UGyiWvclF/f/z5e75y9IFaUeojTBa34tpnvdaLxuQJTnShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363915; c=relaxed/simple;
	bh=FcD7CZDSoIc+qE94jXhoSUnNH0lTvdXvQcs5snIJchk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZZbwY6rb1RmVThc8+KF/tA27KZrxQ53hMouomWMef53xccJFZsw8HQpfHAgG5XTLDZ+5IWP9sLvOchhfcnRv0hdprjoG5a2T7R2I7gQXECp41oYkKuohIG9mQEaJy7uXhb5tS276N9nZsmRR9sX7rXNbeHkJ47PGcAxDpHN3fSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4vRD5eu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37914C4CEED;
	Thu, 24 Jul 2025 13:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753363915;
	bh=FcD7CZDSoIc+qE94jXhoSUnNH0lTvdXvQcs5snIJchk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=O4vRD5eucG3AGDGbo+8WaLkh72BU6+GviiIrbPSQV7DFLwBdCGRPK+wJdNSzA+SMo
	 9vyzfq+BhqZjhAB/1AIjy0QdWeUW0yEqhpeJkr+B6nu+HKsqGxwhPb2t/kwxkyCiPw
	 YJHlqWDJimFjfh1L50ZYWXOuky0eDMIr+P4orCjUyYSBNHdPjgFEYQMIA1hAZFbo3P
	 rTGYja8zukCqEag0fal+k5ySAswhMqLjIqEpbhXQg5LAzp99RrG2g+T/YtP+NJ8cTS
	 s0s0Fx8VvlL3LksBHkMjdnrkcNqKj/M+r5NjTPgUqN2sURmRAXjtQGw6OgoUUs8aTq
	 6MeogXobdx81w==
Date: Thu, 24 Jul 2025 06:31:52 -0700
From: Kees Cook <kees@kernel.org>
To: kernel test robot <lkp@intel.com>, Jakub Kicinski <kuba@kernel.org>
CC: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/6_net-next=5D_net=3A_Convert_proto?=
 =?US-ASCII?Q?=5Fops_bind=28=29_callbacks_to_use_sockaddr=5Funspec?=
User-Agent: K-9 Mail for Android
In-Reply-To: <202507241955.LuEWrXAU-lkp@intel.com>
References: <20250723231921.2293685-3-kees@kernel.org> <202507241955.LuEWrXAU-lkp@intel.com>
Message-ID: <2B9D5F9B-2AAD-4578-B87F-3ADD67EDA6BF@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On July 24, 2025 4:29:15 AM PDT, kernel test robot <lkp@intel=2Ecom> wrote=
:
>Hi Kees,
>
>kernel test robot noticed the following build warnings:
>
>[auto build test WARNING on next-20250723]
>[also build test WARNING on v6=2E16-rc7]
>[cannot apply to net-next/main bluetooth-next/master bluetooth/master bra=
uner-vfs/vfs=2Eall mkl-can-next/testing mptcp/export mptcp/export-net trond=
my-nfs/linux-next linus/master v6=2E16-rc7 v6=2E16-rc6 v6=2E16-rc5]
>[If your patch is applied to the wrong git tree, kindly drop us a note=2E
>And when submitting patch, we suggest to use '--base' as documented in
>https://git-scm=2Ecom/docs/git-format-patch#_base_tree_information]
>
>url:    https://github=2Ecom/intel-lab-lkp/linux/commits/Kees-Cook/net-ua=
pi-Add-__kernel_sockaddr_unspec-for-sockaddr-of-unknown-length/20250724-072=
218
>base:   next-20250723
>patch link:    https://lore=2Ekernel=2Eorg/r/20250723231921=2E2293685-3-k=
ees%40kernel=2Eorg
>patch subject: [PATCH 3/6 net-next] net: Convert proto_ops bind() callbac=
ks to use sockaddr_unspec
>config: x86_64-buildonly-randconfig-003-20250724 (https://download=2E01=
=2Eorg/0day-ci/archive/20250724/202507241955=2ELuEWrXAU-lkp@intel=2Ecom/con=
fig)
>compiler: gcc-12 (Debian 12=2E2=2E0-14+deb12u1) 12=2E2=2E0
>reproduce (this is a W=3D1 build): (https://download=2E01=2Eorg/0day-ci/a=
rchive/20250724/202507241955=2ELuEWrXAU-lkp@intel=2Ecom/reproduce)
>
>If you fix the issue in a separate patch/commit (i=2Ee=2E not just a new =
version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel=2Ecom>
>| Closes: https://lore=2Ekernel=2Eorg/oe-kbuild-all/202507241955=2ELuEWrX=
AU-lkp@intel=2Ecom/
>
>All warnings (new ones prefixed by >>):
>
>   net/packet/af_packet=2Ec: In function 'packet_bind_spkt':
>   net/packet/af_packet=2Ec:3340:33: error: 'struct __kernel_sockaddr_uns=
pec' has no member named 'sa_data_min'; did you mean 'sa_data'?
>    3340 |         char name[sizeof(uaddr->sa_data_min) + 1];
>         |                                 ^~~~~~~~~~~
>         |                                 sa_data
>   net/packet/af_packet=2Ec:3351:52: error: 'struct __kernel_sockaddr_uns=
pec' has no member named 'sa_data_min'; did you mean 'sa_data'?
>    3351 |         memcpy(name, uaddr->sa_data, sizeof(uaddr->sa_data_min=
));
>         |                                                    ^~~~~~~~~~~
>         |                                                    sa_data

Hmpf=2E My mistake -- I've been trying to send out subsets of these patche=
s so I don't spam netdev with 100 patches and I had the "make sockaddr a fi=
xed size" patch earlier in my larger series=2E I will get this adjusted and=
 retested=2E I'll wait for design feedback first, though=2E :)


--=20
Kees Cook


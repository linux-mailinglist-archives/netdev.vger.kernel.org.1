Return-Path: <netdev+bounces-101137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE4B8FD70B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32F11F22A08
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F64156F50;
	Wed,  5 Jun 2024 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjlnSwCZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6A5155356;
	Wed,  5 Jun 2024 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617968; cv=none; b=VNhZFshvSU1yDi/yrH7Z7tNemStU0LO/Hc1aiPKBJmlLdVvRTGE7suutIFsD3X6+2kX/c8LSYeqSAqaFbi4fPHI98kt6Dq+6C6EygagDtvnqWaggfvaK1TVkay1Ikycm0TaVKKtD4h+adLI6Or8AE2VQ/LWc5RKWGck7JZhSG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617968; c=relaxed/simple;
	bh=tcIV154yjEx+jZi6w1gwf86t72QgsTXPe1vDfXnptNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbhRV1m3+S0srhXvnOei6wjfjWekFNbLlfa0wCUHd3D2yd1oRR2+Oo8thOIikRrYQr24Ag5mNlhKfToUWv6uzitw0TpJqDN7gb+DbuX7avs9gK0Z9gm80H5ZLQC+9BGv13EmoMdGLEZyRP0vO+BwpEJ3mxXm607XYIdWkpDdw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjlnSwCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC328C2BD11;
	Wed,  5 Jun 2024 20:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717617968;
	bh=tcIV154yjEx+jZi6w1gwf86t72QgsTXPe1vDfXnptNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjlnSwCZ3QBn+iv6bMHUH81hwuZF4ddVoebpRp3oNUHaWIyj5D7tXJ5us/UaGcwQu
	 3dWqyQbno52GB0lf1+Y+PQvumgnJ2zb+Mj0nK3is/r37UiFc6PFD++cG7isW0GdaBM
	 M1Mo51dyfbb2qxEXDRlCAxvG+EJW9e5L3Dqvl+S/S3tCUdhcy5oM9R0+yq58dOXa8t
	 SCVWiByboBeyJkjHWQtBMtt/izj/vt+PSgEDX/8rUW+h9v5gxYXdfFIVbcbMdXfnzF
	 Xl4NuCMELC8BzSMsxsh9gbF7TlZ9JWFbahEVfq9MitPIV78rcDIHurx7ebWSeVKFiD
	 BzB/piWdTbFlg==
Date: Wed, 5 Jun 2024 21:06:02 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Cc: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
	dev@openvswitch.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
Message-ID: <20240605200602.GB791188@kernel.org>
References: <20240603185647.2310748-6-amorenoz@redhat.com>
 <202406050852.hDtfskO0-lkp@intel.com>
 <CAG=2xmOQBaUki43jpUnP7F-RvkxXroQ46_CuXvbQyps=MvvYAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=2xmOQBaUki43jpUnP7F-RvkxXroQ46_CuXvbQyps=MvvYAg@mail.gmail.com>

On Wed, Jun 05, 2024 at 07:31:55PM +0000, Adrián Moreno wrote:
> On Wed, Jun 05, 2024 at 08:29:22AM GMT, kernel test robot wrote:
> > Hi Adrian,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on net-next/main]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Moreno/net-psample-add-user-cookie/20240604-030055
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20240603185647.2310748-6-amorenoz%40redhat.com
> > patch subject: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
> > config: s390-randconfig-002-20240605 (https://download.01.org/0day-ci/archive/20240605/202406050852.hDtfskO0-lkp@intel.com/config)
> > compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406050852.hDtfskO0-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202406050852.hDtfskO0-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    s390x-linux-ld: net/openvswitch/actions.o: in function `do_execute_actions':
> > >> actions.c:(.text+0x1d5c): undefined reference to `psample_sample_packet'
> >
> 
> Thanks robot!
> 
> OK, I think I know what's wrong. There is an optional dependency with
> PSAMPLE. Openvswitch module does compile without PSAMPLE but there is a
> link error if OPENVSWITCH=y and PSAMPLE=m.
> 
> Looking into how to express this in the Kconfig, I'm planning to add the
> following to the next version of the series.
> 
> diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
> index 29a7081858cd..2535f3f9f462 100644
> --- a/net/openvswitch/Kconfig
> +++ b/net/openvswitch/Kconfig
> @@ -10,6 +10,7 @@ config OPENVSWITCH
>  		   (NF_CONNTRACK && ((!NF_DEFRAG_IPV6 || NF_DEFRAG_IPV6) && \
>  				     (!NF_NAT || NF_NAT) && \
>  				     (!NETFILTER_CONNCOUNT || NETFILTER_CONNCOUNT)))
> +	depends on PSAMPLE || !PSAMPLE
>  	select LIBCRC32C
>  	select MPLS
>  	select NET_MPLS_GSO
> 

Thanks Adrián,

I both agree that should work, and tested with the config at the link above
and found that it does work.


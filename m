Return-Path: <netdev+bounces-22134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20806766264
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 05:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD0C2825F5
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 03:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2E717F9;
	Fri, 28 Jul 2023 03:28:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FDE17EC
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF17DC433C9;
	Fri, 28 Jul 2023 03:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690514893;
	bh=NBjgBAVBACpOkwUBa3F+YOvXdcNdxUwGJPkJgXMPyZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aF79OitFL1etcnggv1KW3Zhz8mOvyiQRlTLEgK/Ykr9ZQqAVCo2LmNLMKQNddQ6AC
	 bND8eA7FyPtRmJ0t7wcRcbP9XWECPsYqMj39t8k7cCcu6P20vxI46GoH901NHkq+8/
	 VkMBfWH/hOvt6JUzJSU6oSC3m/b/cPzVR+A5UEqQUTsxYcj8Pxfk/UPvA77Z9JRsDJ
	 jKP5UQBcdtY8XxfZP6EpCZV3W9OfHPwVCK9/VSefIvRRMIINgTgEhVOnWTjY8lwXWa
	 MZjAfzfGgqTAWX551sLG7CzyFv49/eZd0HCzYg+TyYSUNq0n7ErHkK8U32MyRNU8HB
	 44s4f8eAgxseg==
Date: Thu, 27 Jul 2023 20:28:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 <netfilter-devel@vger.kernel.org>, Zhu Wang <wangzhu9@huawei.com>, Simon
 Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 1/5] nf_conntrack: fix -Wunused-const-variable=
Message-ID: <20230727202811.7b892de5@kernel.org>
In-Reply-To: <20230727133604.8275-2-fw@strlen.de>
References: <20230727133604.8275-1-fw@strlen.de>
	<20230727133604.8275-2-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Jul 2023 15:35:56 +0200 Florian Westphal wrote:
> When building with W=3D1, the following warning occurs.
>=20
> net/netfilter/nf_conntrack_proto_dccp.c:72:27: warning: =E2=80=98dccp_sta=
te_names=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  static const char * const dccp_state_names[] =3D {
>=20
> We include dccp_state_names in the macro
> CONFIG_NF_CONNTRACK_PROCFS, since it is only used in the place
> which is included in the macro CONFIG_NF_CONNTRACK_PROCFS.

FTR I can't say I see this with the versions of gcc / clang I have :S

> Fixes: 2bc780499aa3 ("[NETFILTER]: nf_conntrack: add DCCP protocol suppor=
t")

Nor that it's worth a Fixes tag?


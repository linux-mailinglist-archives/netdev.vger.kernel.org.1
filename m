Return-Path: <netdev+bounces-184269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6DA94048
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 01:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256851B642FE
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 23:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581BF248881;
	Fri, 18 Apr 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtWL9K4w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE222E01E
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745018993; cv=none; b=K4XAKyrenMLB0A36FTtZlyGV0c+uZiQ/Mojsa9GRMf+msyS7iQN4N0lgeNUurzBIzhzMstG/fE0R7WLunYXGJ2bLMwgpjey8RalSro2YX4plt5Wb7W1QqzEk36EJJPwIsnlDVtWf/9kFNs/B1FMc4eWw6n7E1MeRLfIKeDW295k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745018993; c=relaxed/simple;
	bh=MpYCIXYUXB3Tz3TKHUGlhXuZPTgdfhfu4BPjuqYWhdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sn6Hc6uENVrjRHnPRnUxQs6hjKAvuDExZ0SDfEmODWyMc/Z2WkjRkdv51syZevSoVJy3Ke0lk5Mokf0zHU4kw/upyLtZqWEGJyw7UTwUMy0Vw5exggqCfpooPxzR2DumiHY/5+NB0u3rBp8RzHgurp3d20NhHJDEI/Piog8kE0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtWL9K4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DCEC4CEE2;
	Fri, 18 Apr 2025 23:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745018993;
	bh=MpYCIXYUXB3Tz3TKHUGlhXuZPTgdfhfu4BPjuqYWhdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NtWL9K4wymwFa3Gv01ppYgN5HY7mx2FqE0jQ7R3G5U0WYg13djD58vFEuSjElxA48
	 9NYW8wsH5V6BgFY/JZUUL0mvPpRGaC7omo+v0EQdNwqmnwJ7FJdKuIxQREf4ssshFG
	 KQIKS3O25PBGNLhIO++Bv+by/Yc5E6CmAiVH6yjaRzlnDU1obJV4kRWgTIHkfGvGoC
	 J/uzNmyUju7UNUTky5Uk0lA79KOr+RLbYPcoty0U3TmC9CZUsUkXqMVpAQLsQ5ALkI
	 TphUEOeLjNwZN7UdW7Q54fhgExsx7vkT2pOp2WYbIz4qrtwNLICfkjY94i5vY7+uZ4
	 ukEVSL9xh6JVQ==
Date: Fri, 18 Apr 2025 16:29:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, yuyanghuang@google.com,
 sdf@fomichev.me, gnault@redhat.com, nicolas.dichtel@6wind.com,
 petrm@nvidia.com
Subject: Re: [PATCH net-next v2 12/13] tools: ynl: generate code for rt-addr
 and add a sample
Message-ID: <20250418162951.5d6dbd8e@kernel.org>
In-Reply-To: <20250418190431.69c10431@kmaincent-XPS-13-7390>
References: <20250410014658.782120-1-kuba@kernel.org>
	<20250410014658.782120-13-kuba@kernel.org>
	<20250418190431.69c10431@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Apr 2025 19:04:31 +0200 Kory Maincent wrote:
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org> =20
>=20
> Hello,
>=20
> This seems to broke the check-spec:
>=20
> $ make -C tools/net/ynl   =20
> ...
> rt-addr-user.c:62:10: error: =E2=80=98IFA_PROTO=E2=80=99 undeclared here =
(not in a function); did you mean =E2=80=98IFA_RTA=E2=80=99?
>    62 |         [IFA_PROTO] =3D { .name =3D "proto", .type =3D YNL_PT_U8,=
 },
>       |          ^~~~~~~~~
>       |          IFA_RTA
> rt-addr-user.c:62:10: error: array index in initializer not of integer ty=
pe
> rt-addr-user.c:62:10: note: (near initialization for =E2=80=98rt_addr_add=
r_attrs_policy=E2=80=99)
> rt-addr-user.c:62:23: warning: excess elements in array initializer
>    62 |         [IFA_PROTO] =3D { .name =3D "proto", .type =3D YNL_PT_U8,=
 },
>       |                       ^
> rt-addr-user.c:62:23: note: (near initialization for =E2=80=98rt_addr_add=
r_attrs_policy=E2=80=99)
>=20
> I found it through git bisect.

Sorry about that. I will send a fix shortly. We needed this first:
https://lore.kernel.org/all/20250416200840.1338195-1-kuba@kernel.org/
without it YNL couldn't include if_addr.h directly.


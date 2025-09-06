Return-Path: <netdev+bounces-220619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE3DB476E6
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 21:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E02A1B20956
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 19:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB756287504;
	Sat,  6 Sep 2025 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIcqwMkw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36921A76B1;
	Sat,  6 Sep 2025 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757186980; cv=none; b=kq68AlheaQmgqCGpS/dk5pyvzA12yAKzKhOwECIa0OSESOG/thI/bTy/4UZ3LRXmfYOqPb+5qCH9SMDAeEbZwMJhKhZ6NQ7eNEYQJfMdnm9MdIlBpcefS8BBu8pmyXM9JMUTY66J9jM//fOSFiynRdbagvQl0uGKYclhZvtywtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757186980; c=relaxed/simple;
	bh=oofUon7TKCp2rF2DC7eS4zrof2y9W5dAO3wKX4EvhrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZ0QAFPoJmMsp3Yi4HUzIHLR6UXbiYQY6JwVjGgba2BqBezqlHDMF/t0elcxNmNPmJCx3IHoBaSQPFWJ1j+Hn7+wrjhzfzk/4075DW9JdW1WGRo59bnwJey1af4PLVGf1Zf12rLmK7DVa2CreQGV6CrCFqMm0IvjC/SyMxU78FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIcqwMkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF204C4CEE7;
	Sat,  6 Sep 2025 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757186980;
	bh=oofUon7TKCp2rF2DC7eS4zrof2y9W5dAO3wKX4EvhrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pIcqwMkw5k9xWSuHn9pDlEmINSW4q4DYjjt2ItSD4v7Yz8NS+it5MtLNlarDproTL
	 uw1+5iKlQ2Zd5fWR8fvHjkFZB2hy8N2MArY3Zmb9qN4WjkOVQuSP6tWqaACMLNcLOy
	 KYHtg0muWAuD9cxgjjTFq/zg/Y7g5ZapXHEEqjA3zRW8YL6VnqnUvuCp2BkGLlmdYu
	 Si4Z6Z6s5MHdErLB6YusEAtXiwOPa1xnlDrXbATmDK8XJwhM0o2NI0ZH97nXUVcKox
	 awX5AG8E8SnsDyYXr4b/BxpjNLEaecsZOe11AataWHNdgbHMKvJwauyUqPtCc/hzC8
	 7g2EIM/4bU1+Q==
Date: Sat, 6 Sep 2025 12:29:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 06/11] tools: ynl-gen: don't validate nested
 array attribute types
Message-ID: <20250906122938.30566de3@kernel.org>
In-Reply-To: <0a9a7c41-7deb-4078-8cc9-aee8f8784443@fiberby.net>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-6-ast@fiberby.net>
	<20250905172334.0411e05e@kernel.org>
	<0a9a7c41-7deb-4078-8cc9-aee8f8784443@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 6 Sep 2025 13:22:01 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> > I don't understand, please provide more details.
> > This is an ArrayNest, right?
> >=20
> > [ARRAY-ATTR]
> >    [ENTRY]
> >      [MEMBER1]
> >      [MEMBER2]
> >    [ENTRY]
> >      [MEMBER1]
> >      [MEMBER2]
> >=20
> > Which level are you saying doesn't matter?
> > If entry is a nest it must be a valid nest.
> > What the comment you're quoting is saying is that the nla_type of ENTRY
> > doesn't matter. =20
>=20
> I will expand this in v2, but the gist of it is that this is part of the
> "split attribute counting, and later allocating an array to hold them" co=
de.
>=20
> The check that I remove for nested arrays, is an early exit during the
> counting phase. Later in the allocation and parse phase it validates the
> nested payload.
>=20
> In include/uapi/linux/wireguard.h:
>  > WGDEVICE_A_PEERS: NLA_NESTED
>  >   0: NLA_NESTED
>  >     WGPEER_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
>  >     [..]
>  >   0: NLA_NESTED
>  >     ...
>  >   ... =20
>=20
> The current check requires that the nested type is valid in the nested
> attribute set, which in this case resolves to WGDEVICE_A_UNSPEC, which is
> YNL_PT_REJECT, and it takes the early exit and returns YNL_PARSE_CB_ERROR.

I see your point now. We're validating ENTRY as an attribute in the
parent attribute set, but it's just a meaningless id.

I think we need more fixing here. The real parsing loop will only
validate what's _inside_ the [MEMBER]. Which doesn't matter all
that much to nests, but look at what happens if subtype is a scalar.
We'll just call ynl_attr_get_u32(), type is never really validate.

I think we need this, and make the codegen feed in the ARRAY-ATTR type
to validate ENTRY?

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 2a169c3c0797..e43167398c69 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -360,15 +360,15 @@ static int ynl_cb_done(const struct nlmsghdr *nlh, st=
ruct ynl_parse_arg *yarg)
=20
 /* Attribute validation */
=20
-int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *att=
r)
+int __ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *a=
ttr,
+			unsigned int type)
 {
 	const struct ynl_policy_attr *policy;
-	unsigned int type, len;
 	unsigned char *data;
+	unsigned int len;
=20
 	data =3D ynl_attr_data(attr);
 	len =3D ynl_attr_data_len(attr);
-	type =3D ynl_attr_type(attr);
 	if (type > yarg->rsp_policy->max_attr) {
 		yerr(yarg->ys, YNL_ERROR_INTERNAL,
 		     "Internal error, validating unknown attribute");
@@ -450,6 +450,11 @@ int ynl_attr_validate(struct ynl_parse_arg *yarg, cons=
t struct nlattr *attr)
 	return 0;
 }
=20
+int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *att=
r)
+{
+	return __ynl_attr_validate(yarg, attr, ynl_attr_type(attr));
+}
+
 int ynl_submsg_failed(struct ynl_parse_arg *yarg, const char *field_name,
 		      const char *sel_name)
 {


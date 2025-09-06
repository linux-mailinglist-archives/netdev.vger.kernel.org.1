Return-Path: <netdev+bounces-220518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C78FB4677E
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565AF189E59C
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7EF3594C;
	Sat,  6 Sep 2025 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0gNFZSR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6517E4;
	Sat,  6 Sep 2025 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757118216; cv=none; b=F4Ud556lOjUTE2gEPWO92GlaeihCBjjp+nsRz6Bz6p16wr+KH9W7eyTiLNAX/0WGiM44+t8wwU5zhB6FGt+GzhAQyeqdfXEprjFzQELqeyNTg/8OEePJuQ94WqPYibsFr05JGQ3RhOC4E4Gg+U8r3EuTze+JUDFd/4S0riAfATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757118216; c=relaxed/simple;
	bh=L8nEyxH2OcNHjbrIDBll/zbPI+80XGl4Dz7SH0zFTyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fT5K0SFxECpDxQGAl94QoCYvV4xLeY1pjODMOiQNtBSfAKenGPWDyhvyDC3qXSUMW+saOvM0EwJeKsHw2/gvNKvBNU3ukVR8qaPPGunlwEDYxh06/y6LN8zXEC5SaQ6jII39tacsXcZfLTmg/JRf8f91IBA1+iIXLJe5Jhy0h6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0gNFZSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0985FC4CEF1;
	Sat,  6 Sep 2025 00:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757118215;
	bh=L8nEyxH2OcNHjbrIDBll/zbPI+80XGl4Dz7SH0zFTyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B0gNFZSR3XJPLWuaVo28q+wVcijzhaCLZHZccf0DBwYO1070BBHZa4fJw0QwYMAYX
	 ngr3FLqEH/+cHxqKZxLgqRNkqs11hsx5YHSI5j3XbfWomKhG+02Ag6UlTKw1d6wxFI
	 brDhZXuhEIYW1oQVfr3MfavaH6sulC0w/ltogDS3NNuOGPooRBSkXmTAVeeot/KmCD
	 UscqXKUrkoFuj5Pj3aPRD97RI8m0axVHklXwTxjrxJ2pB9D4sJI3wqfsGCmzhtOunU
	 bvL9irJ/uFzQgpnKH0LJbYNAmRB2E+2zZqSAEOGXb8YDMUS9zxL7mAEQQAp+f8N/yX
	 6/Zxe12D5K5nw==
Date: Fri, 5 Sep 2025 17:23:34 -0700
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
Message-ID: <20250905172334.0411e05e@kernel.org>
In-Reply-To: <20250904220156.1006541-6-ast@fiberby.net>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-6-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  4 Sep 2025 22:01:29 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> In nested arrays don't require that the intermediate
> attribute type should be a valid attribute type, it
> might just be an index or simple 0, it is often not
> even used.
>=20
> See include/net/netlink.h about NLA_NESTED_ARRAY:
> > The difference to NLA_NESTED is the structure:
> > NLA_NESTED has the nested attributes directly inside
> > while an array has the nested attributes at another
> > level down and the attribute types directly in the
> > nesting don't matter. =20

I don't understand, please provide more details.
This is an ArrayNest, right?

[ARRAY-ATTR]
  [ENTRY]
    [MEMBER1]
    [MEMBER2]
  [ENTRY]
    [MEMBER1]
    [MEMBER2]

Which level are you saying doesn't matter?
If entry is a nest it must be a valid nest.
What the comment you're quoting is saying is that the nla_type of ENTRY
doesn't matter.


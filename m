Return-Path: <netdev+bounces-190712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB4AB8588
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BA43ADD22
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BEF205AA8;
	Thu, 15 May 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbbkFEfq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415511F16B;
	Thu, 15 May 2025 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310499; cv=none; b=nZY+5x/zZCNsgqLkr/tmJib4B/nPuinIdN7v9Qd8udsP1sYqcKqp4ErLCrNRa6qrG48RvSMZQuDXSbI+gHOI6SxGThjzixBX3BmAIPoq0KLrLq75yRPXD1iCFjVOYAsJZj4fxl+cm4o57X9BsyYYQzSEh+VUXl+5Oc6pY79Ml+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310499; c=relaxed/simple;
	bh=e5G8NoyYejh7bIRIp3fd5xF4gR7mdTNrW8fJ14jg26o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IgJfWQlqyYkXLg4Em23hejn+jTtenUNPX96vtTTVzTsO6BGxpd5w9ZNdg2+U5rRAI6mBBXp8vEaMSUQ51qr+Nz8DVmUSx9lnR2H6Bb78auhwwf0Rz8iayBSzAh0KGP3kULyDNrzVJL3UnzWxV/rCGPiponAWuc0s5ebt5XN/66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbbkFEfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4F0C4CEE7;
	Thu, 15 May 2025 12:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747310498;
	bh=e5G8NoyYejh7bIRIp3fd5xF4gR7mdTNrW8fJ14jg26o=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=sbbkFEfqIp+hUc6URcnxYNfrYG91eGJsW2BvjonemLcKnpIdN/KdEmlXBO3EHBGtl
	 mAj5fHbMojfpZveQLTI+dQD3Y9jn+3DiVDYKy4ezjcgq6EN3I6JiDKbvS6po9M2lBO
	 qm7EFzbW/6vuj/9zUi2CxxQiRJ1fvMUxrQZeZzQq91Qc9zCzZPbIixh2okUuj42QgD
	 EeOIpghHfGkKAo/z54CHl5qSNymy7xZTZZrxTyC7IJNIIKJqHvUYB045uk38GPFu9I
	 t9sEKZ0FJboQmuXpgahifkx6UQIGokUa/uDm7z0MsX+QntMkFPgzkd6LSR0d3pDZhr
	 ietuPLmcRnYOg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 May 2025 14:01:22 +0200
Message-Id: <D9WPVECZK7GQ.2HAJ6JDN7M3LQ@kernel.org>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, "Broadcom internal kernel review
 list" <bcm-kernel-feedback-list@broadcom.com>, =?utf-8?q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, "Andrei Botila" <andrei.botila@oss.nxp.com>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Sabrina Dubroca" <sd@queasysnail.net>, "Michael Klein"
 <michael@fossekall.de>, "Daniel Golle" <daniel@makrotopia.org>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [net-next PATCH v10 7/7] rust: net::phy sync with
 match_phy_device C changes
From: "Benno Lossin" <lossin@kernel.org>
To: "Christian Marangi" <ansuelsmth@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
 <20250515112721.19323-8-ansuelsmth@gmail.com>
 <D9WPMD7Q4XRN.32LF8UDPK1IBI@kernel.org>
 <6825d53b.df0a0220.36755a.ca22@mx.google.com>
In-Reply-To: <6825d53b.df0a0220.36755a.ca22@mx.google.com>

On Thu May 15, 2025 at 1:51 PM CEST, Christian Marangi wrote:
> On Thu, May 15, 2025 at 01:49:35PM +0200, Benno Lossin wrote:
>> On Thu May 15, 2025 at 1:27 PM CEST, Christian Marangi wrote:
>> > Sync match_phy_device callback wrapper in net:phy rust with the C
>> > changes where match_phy_device also provide the passed PHY driver.
>> >
>> > As explained in the C commit, this is useful for match_phy_device to
>> > access the PHY ID defined in the PHY driver permitting more generalize=
d
>> > functions.
>> >
>> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>> > ---
>> >  rust/kernel/net/phy.rs | 26 +++++++++++++++++++++++---
>> >  1 file changed, 23 insertions(+), 3 deletions(-)
>>=20
>> You probably should do this in the same commit as the C changes,
>> otherwise the in-between commits will error.
>>=20
>
> You are right, I will fix this in v11 but I would really want to know if
> the Rust changes are correct. It's not my main language so it's all
> discovering new stuff :D

No worries :) I have lost some context on the PHY Rust bindings, so
Fujita will probably have to review it, but if I find the time, I'll
take a look.

---
Cheers,
Benno


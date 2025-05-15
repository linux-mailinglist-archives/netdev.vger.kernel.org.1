Return-Path: <netdev+bounces-190708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34220AB853B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1413AF15C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593DB29826D;
	Thu, 15 May 2025 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doVvNYWc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294DA1C36;
	Thu, 15 May 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309798; cv=none; b=sO1LoCjMTNkZyc3FIqyxgui81jyRTzHsIVgBv/xo7ZuErM8iSPnUWuEBmopa6dlFvo5xI32+BJ4xaar0Jh0LiJrUor/6Ao7wcp6+dsJ/9GHNmvmL4jczwXbQ2m/ut67CzRqSr9hGnPA75JulaeW8nB6PN1iXYdRQLxmtfWfv9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309798; c=relaxed/simple;
	bh=twIU6Awl/78CP5Kz16PqgHQEF0dZE+yT7JiNb0lxBKg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=LgqNyOG4RT5S6UbXQArb5yvzzX2WAHitEECBwABrFV5NklFHW+sT6yyl2zlqNzqrVusVliT33pLijgyVdsiQY6crbkzhLyjD9aLjNfbEoqUjLjh60OQYQ2PEVTPFyUNUqKvhyC2PzxtnKEoN2wIYQcCCm1OH/UaNcgs8OI1nTC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doVvNYWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682D9C4CEE9;
	Thu, 15 May 2025 11:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747309797;
	bh=twIU6Awl/78CP5Kz16PqgHQEF0dZE+yT7JiNb0lxBKg=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=doVvNYWce7rcPlDh3ZJHjoZALo1aVHsreFjTSW5Cq556jOxNhVOLRzz+Yfa/GHusd
	 VU+1W6PpuF8tQ321mDe3rwqq1KygTqiCJmJYZ780UL5e3vdwI4lxaAnzldhiD3ylvw
	 Ufal2RB9z0riaHFpl3FuUZTClSzE9/s8Nka7DPkpMaaGCdY051JtUuqWBvIkiXFwVl
	 m3i5B0FEpsEx5uU3csClk9xH+Y5TP0IY69S7bPMMUtfwTBam0VoOopha4h4NcVCzeX
	 j+CHqG46B2PfqBv4acLpQCumhQA19PUdqBUMjLgLVA7K5WjVPjOu6AIUx44ZRgHTRZ
	 hW9sVfR/8snjQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 May 2025 13:49:35 +0200
Message-Id: <D9WPMD7Q4XRN.32LF8UDPK1IBI@kernel.org>
Subject: Re: [net-next PATCH v10 7/7] rust: net::phy sync with
 match_phy_device C changes
From: "Benno Lossin" <lossin@kernel.org>
To: "Christian Marangi" <ansuelsmth@gmail.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "Florian Fainelli"
 <florian.fainelli@broadcom.com>, "Broadcom internal kernel review list"
 <bcm-kernel-feedback-list@broadcom.com>, =?utf-8?q?Marek_Beh=C3=BAn?=
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
X-Mailer: aerc 0.20.1
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
 <20250515112721.19323-8-ansuelsmth@gmail.com>
In-Reply-To: <20250515112721.19323-8-ansuelsmth@gmail.com>

On Thu May 15, 2025 at 1:27 PM CEST, Christian Marangi wrote:
> Sync match_phy_device callback wrapper in net:phy rust with the C
> changes where match_phy_device also provide the passed PHY driver.
>
> As explained in the C commit, this is useful for match_phy_device to
> access the PHY ID defined in the PHY driver permitting more generalized
> functions.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  rust/kernel/net/phy.rs | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)

You probably should do this in the same commit as the C changes,
otherwise the in-between commits will error.

---
Cheers,
Benno


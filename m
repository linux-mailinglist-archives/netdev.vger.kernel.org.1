Return-Path: <netdev+bounces-191345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA3FABB05E
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 15:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3683B0B89
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A1B1D6188;
	Sun, 18 May 2025 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2lFSyVF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BC6EEAA;
	Sun, 18 May 2025 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747575092; cv=none; b=hBFxTYDjK+mDryVURnXSSCh1uyi85j+8X2lxZyQEJ+bfd5PJc02mtD1OYBaEVXhzyhtC6YCKXXKh/edoTpQIj0TOcTmXrlnVlvDVKySkSLx8PpHkMWer5qcfORDGy72dEEbJOfXOZvkMY/KDpZSS31AbkmaKxXutIOyDlQ6g6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747575092; c=relaxed/simple;
	bh=dV15awbD247lj6+VR3yfY/UUy8Kzmk0rr5ZokrGdYmw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Nu7fwKvyCtvcfQUfFGpg8EEWmIGbKtp9KKH0BEJ1YXgzbcJMKwypo0T8Dvjo7AFpSJrR88an1xY/USrTZFsV5SpNiQpw3iR7TDU30rH+ZaDuk4aBFcdavN/nqXG/zJbaM9QxAOo+VNoG5UYrXfs70T5n2Oclg3lRwknb50EzJ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2lFSyVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DAFC4CEE7;
	Sun, 18 May 2025 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747575091;
	bh=dV15awbD247lj6+VR3yfY/UUy8Kzmk0rr5ZokrGdYmw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=b2lFSyVFm403R0QirlXfajgv0Yq+HhXqzpmEF6GdZJp9ASL5IujhZ8VevggSQ18FM
	 uU67FccfDFcP+x5JrKcqy11TktdGYYrY6cAjICNUed0P6CHuZdLADBXTtgT04MhWLW
	 b3hxdQYWzvQTryICqfzrAfR9nuAEyORmcwSc5NpyEqjKLYoQ+CzuPBfLWm4F7go+Wm
	 1FDKmucHxK0PKkOFa03WQebvw54C9Wze2p1Qg7ZIe9xFLAgRIUBbgX6h/8xsRfPMaR
	 KMLWzUcveHW3Dy07olT3nU5TZUQV0fXwHjEIHqWnAQcDeBOCO4XKODQ6xeSNWI1/qT
	 5Z+RMrj5Iqt5Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 May 2025 15:30:50 +0200
Message-Id: <D9ZBNJ6VL5XL.2TIH5QSOI8ABL@kernel.org>
Subject: Re: [net-next PATCH v12 1/6] net: phy: pass PHY driver to
 .match_phy_device OP
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
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
X-Mailer: aerc 0.20.1
References: <20250517201353.5137-1-ansuelsmth@gmail.com>
 <20250517201353.5137-2-ansuelsmth@gmail.com>
In-Reply-To: <20250517201353.5137-2-ansuelsmth@gmail.com>

On Sat May 17, 2025 at 10:13 PM CEST, Christian Marangi wrote:
> Pass PHY driver pointer to .match_phy_device OP in addition to phydev.
> Having access to the PHY driver struct might be useful to check the
> PHY ID of the driver is being matched for in case the PHY ID scanned in
> the phydev is not consistent.
>
> A scenario for this is a PHY that change PHY ID after a firmware is
> loaded, in such case, the PHY ID stored in PHY device struct is not
> valid anymore and PHY will manually scan the ID in the match_phy_device
> function.
>
> Having the PHY driver info is also useful for those PHY driver that
> implement multiple simple .match_phy_device OP to match specific MMD PHY
> ID. With this extra info if the parsing logic is the same, the matching
> function can be generalized by using the phy_id in the PHY driver
> instead of hardcoding.
>
> Rust wrapper callback is updated to align to the new match_phy_device
> arguments.
>
> Suggested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/bcm87xx.c              |  6 ++++--
>  drivers/net/phy/icplus.c               |  6 ++++--
>  drivers/net/phy/marvell10g.c           | 12 ++++++++----
>  drivers/net/phy/micrel.c               |  6 ++++--
>  drivers/net/phy/nxp-c45-tja11xx.c      | 12 ++++++++----
>  drivers/net/phy/nxp-tja11xx.c          |  6 ++++--
>  drivers/net/phy/phy_device.c           |  2 +-
>  drivers/net/phy/realtek/realtek_main.c | 27 +++++++++++++++++---------
>  drivers/net/phy/teranetics.c           |  3 ++-
>  include/linux/phy.h                    |  3 ++-
>  rust/kernel/net/phy.rs                 |  1 +
>  11 files changed, 56 insertions(+), 28 deletions(-)

I haven't really looked at the C code, just the part that interfaces
with Rust, so:

Reviewed-by: Benno Lossin <lossin@kernel.org> # for Rust

---
Cheers,
Benno


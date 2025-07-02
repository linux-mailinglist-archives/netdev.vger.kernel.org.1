Return-Path: <netdev+bounces-203529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9163BAF64BA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81241C41D5F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0868B22FAC3;
	Wed,  2 Jul 2025 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz6KaTOn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6742DE6FC;
	Wed,  2 Jul 2025 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493738; cv=none; b=QfAaCEnnp1MZa6sUpbRmFaVx4Y3+wwdr0ecuj8YXk157fyIi2EtP4rYRiOEW1uExyfqx15wI907749eqqXJ05uSavwK2fSdQ5r0ZiPJAxiDOEegdfOmyI0+lj3yqniGYR0BuFKX1SmAHWcZ+wqYzoGy6uYL6vuyhLlVnmiuUFY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493738; c=relaxed/simple;
	bh=xeTgrPLNJbEYFyDVNYttaXsWH2eclECKsNKHT2+fuC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jH9VFg2RGTme5MWyQ9T5cAltL8W9ZjMYQJHyc73OUE6fmG0ti+pbHGa6il1WMqbA9rn5N+kjqFmbIszyfGedWWxEf6YyEUlu2cJb582XMu8t5Wr8IrccqoFrwjp5az31Wrd8htfFremqiKqOHl/y6dEF+2d5Pkch+U77iJ5gldY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz6KaTOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFDFC4CEE7;
	Wed,  2 Jul 2025 22:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751493738;
	bh=xeTgrPLNJbEYFyDVNYttaXsWH2eclECKsNKHT2+fuC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zz6KaTOnMIDhFXcFFu6zgW3TSDOvPG2xhDBjfb4KENd7mySsnY6gG+7GeFa9885Y5
	 lU8zvdd2RKUiwmhct7/LP9MSIXQwJ4uVDXhcln80ae7IrJXPGQl+Cmga5fXizpM3DX
	 Wb8+sfqqwDEqk7adrYXgsRqaMYNRfkdDtnokc2+NPcd0EXWiqTZkySscBFMiDpShE0
	 vt2EJeeO0/2B3O+w7zOHCjGJehSAe5YQpQo4TUz5szipzLyLJ2eMVHVmE9Ic9GYzOo
	 OMMrN+Ho1auYbGEVN5JHo21VuP4aSDQkcVvqg0zAh3SEgQrmpVE600gVCbZKZ3SHAU
	 N/7D/gLsgaXcg==
Date: Wed, 2 Jul 2025 15:02:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kamil =?UTF-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>,
 <florian.fainelli@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <f.fainelli@gmail.com>, <robh@kernel.org>, <andrew+netdev@lunn.ch>,
 <horms@kernel.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net v5 0/4] net: phy: bcm54811: Fix the PHY
 initialization
Message-ID: <20250702150216.2a5410b3@kernel.org>
In-Reply-To: <20250701075015.2601518-1-kamilh@axis.com>
References: <20250701075015.2601518-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Jul 2025 09:50:11 +0200 Kamil Hor=C3=A1k - 2N wrote:
> PATCH 1 - Add MII-Lite PHY interface mode as defined by Broadcom for
>    their two-wire PHYs. It can be used with most Ethernet controllers
>    under certain limitations (no half-duplex link modes etc.).
>=20
> PATCH 2 - Add MII-Lite PHY interface type
>=20
> PATCH 3 - Activation of MII-Lite interface mode on Broadcom bcm5481x
>    PHYs
>=20
> PATCH 4 - Fix the BCM54811 PHY initialization so that it conforms
>    to the datasheet regarding a reserved bit in the LRE Control
>    register, which must be written to zero after every device reset.
>    Also fix the LRE Status register reading, there is another bit to
>    be ignored on bcm54811.

I'm a bit lost why the first 3 patches are included in a series for net.
My naive reading is we didn't support this extra mode, now we do,
which sounds like a new feature.. Patch 4, sure, but the dependency
is not obvious.


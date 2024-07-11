Return-Path: <netdev+bounces-110896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF17292ED2B
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 18:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6086CB20DA6
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1E16D4F0;
	Thu, 11 Jul 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC8G0XaH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26416CD39;
	Thu, 11 Jul 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716979; cv=none; b=nt20iitGh8O1Rx4Dm7AcJoT2mt3C15ZxvsRJl9Y82PrsO3Pp5J0UEoNBWYWEdYtXMnCaezZKLr4X+j+4uG/cG0UApjDdjmlU4DzHc0toAAUHB3jFs9zOGoNlODVrOAl7svsPrSzF/h26PmHkGLhLgpAYvF75w8uWD6pmkq9J3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716979; c=relaxed/simple;
	bh=J2KGe6N9vuh1r0d6oyilC4ZZOD6P1XoN9qwVxXKfAEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Scpx6VtwuvKCu6A1/GP47ugpi0kIxo3S0EG+squ9hE8li4VcKxyKUPEoLQQOGzQRNR7c9ZSbna0I/jIj2B9M2FUgbZCB4p/PUUZ/pIGE4RqjG+4hgnbCNTUWB+u9iEu7kiYevvMkbhvyzNjimbcyAEE++CftK/GK1lxAgO49KxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC8G0XaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C1DC116B1;
	Thu, 11 Jul 2024 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720716979;
	bh=J2KGe6N9vuh1r0d6oyilC4ZZOD6P1XoN9qwVxXKfAEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gC8G0XaHHj0/YsNliAwpI7dr2QLw/AzFuKFrnQD5AXazPEnUapXefdRyCRH14fOXy
	 Hn75jZg2TlBXsh9TH3wP/8VBsB8Kn4FyhPlLr8AI/FUvXhQjmYXumaKxBEVjHCliaD
	 FjEtTJhzfn8vMxCZQjDrTrNqq9vMMWiu7b6a3UJES8NSxahtpRVKFiVyzOZ8Bx8/Ei
	 bkmAm/kyS9mRoYU9gjHNe7O/JAOLZTWkZSyGYwQfayLKLrZyT6okH/6Jr1z4xuusJ+
	 2MtF9amScndzR5EjL3OjORVcYFTQ/zApbgIbRXTu15etQ1JUv20NwXpnkYa/ra5uma
	 Zz9pcAYCXp+hQ==
Date: Thu, 11 Jul 2024 09:56:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>
Cc: "Kamil =?UTF-8?B?SG9yw6Fr?= (2N)" <kamilh@axis.com>,
 <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] net: phy: bcm54811: New link mode for
 BroadR-Reach
Message-ID: <20240711095617.4100e7fa@kernel.org>
In-Reply-To: <20240708102716.1246571-2-kamilh@axis.com>
References: <20240708102716.1246571-1-kamilh@axis.com>
	<20240708102716.1246571-2-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024 12:27:13 +0200 Kamil Hor=C3=A1k (2N) wrote:
> Introduce a new link mode necessary for 10 MBit single-pair
> connection in BroadR-Reach mode on bcm5481x PHY by Broadcom.
> This new link mode, 10baseT1BRR, is known as 1BR10 in the Broadcom
> terminology. Another link mode to be used is 1BR100 and it is already
> present as 100baseT1, because Broadcom's 1BR100 became 100baseT1
> (IEEE 802.3bw).
>=20
> Signed-off-by: Kamil Hor=C3=A1k (2N) <kamilh@axis.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/phy/phy-core.c   | 3 ++-
>  include/uapi/linux/ethtool.h | 1 +
>  net/ethtool/common.c         | 3 +++

> +	ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT		 =3D 102,

Could we get an ack from phylib maintainers for the new mode?


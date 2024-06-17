Return-Path: <netdev+bounces-104142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660FC90B4EE
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BBC289284
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694DC157E6C;
	Mon, 17 Jun 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOkmJLck"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE028F3;
	Mon, 17 Jun 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637439; cv=none; b=ZMSUxmoMc4jQQOwFTeSSIbZDhNbHiLIPqoN0GUkkqTXcPMF2fqsuklYNJPmYj5ps9nKB5h1FCm1OXmENyiSVf9KjdAdTyX1iJwgjVfJAIVLmr0ED9mHkAtmb0LJrek61xwVEB+r6zP+aGHhRyMmLI5U/1mHI8VKJOcynYtDquTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637439; c=relaxed/simple;
	bh=j/ICI7Yq4Ovs9RcOtASdlDvF1NTyk5EhUxXvqJdSzZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiXMFYTkad33mnCz8sks65Q2kghQD0L0G4jhWaE+pBRiKKBTA3B1WpnsSoF0ydejXk9Fgy4iHhOEU7lQvyZCYEkpwisqzogFYZ9+zj4xvigUTnJGBTcPNCH8TS7uQvBUbNdB4bXEpPpu+bVGDp/kXgcxWoZV4DDTYz6OuBQbYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOkmJLck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98028C2BD10;
	Mon, 17 Jun 2024 15:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718637438;
	bh=j/ICI7Yq4Ovs9RcOtASdlDvF1NTyk5EhUxXvqJdSzZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOkmJLckwpXrWq5QiVdZI4ydJyka2LiM7oXyMcqK/TOUBwUS3jKkTvpRQ6OBFtvAr
	 ZrStizh31wlf2osxmhWWTY2qKM2zaQQr4B1fRbS2vCwzeb0mSmxYSxfAvVFmsfC46L
	 MrUJL6dkcy3Ml7ii7swuEm0iT0D3i0yXtB+P7vJ7SmlI0MswoWEQoAgpNEGB/cTLdH
	 wMVF0DYkts3dZYGbVeKe/JNdG5VaIcB+2eufYn3d2hi1e7qcAyxO6xjXg3ACj3zdeS
	 4VfS+Bpeb17nnw6yVDNe9AtNUgXiWDSXc2yXhI0LBSrUL2lU/qfPGhKi6JdR3gBghc
	 KIRjNyupivc9A==
Date: Mon, 17 Jun 2024 16:17:13 +0100
From: Simon Horman <horms@kernel.org>
To: Kamil =?utf-8?B?SG9yw6Fr?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <20240617151713.GW8447@kernel.org>
References: <20240617113841.3694934-1-kamilh@axis.com>
 <20240617113841.3694934-5-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617113841.3694934-5-kamilh@axis.com>

On Mon, Jun 17, 2024 at 01:38:41PM +0200, Kamil Horák - 2N wrote:
> Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
> Create set of functions alternative to IEEE 802.3 to handle configuration
> of these modes on compatible Broadcom PHYs.
> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>

...

> +/**
> + * lre_update_link - update link status in @phydev
> + * @phydev: target phy_device struct
> + *
> + * Description: Update the value in phydev->link to reflect the
> + *   current link value.  In order to do this, we need to read
> + *   the status register twice, keeping the second value.
> + *   This is a genphy_update_link modified to work on LRE registers
> + *   of BroadR-Reach PHY
> + */

Hi Kamil,

A minor nit from my side:

Please consider adding a "Returns:" section to this kernel doc.
Doing so as a follow-up would be fine IMHO.

Flagged by kernel-doc -none -Wall

> +static int lre_update_link(struct phy_device *phydev)

...


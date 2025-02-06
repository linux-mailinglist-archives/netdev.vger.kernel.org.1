Return-Path: <netdev+bounces-163393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D117A2A1C0
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BDF18885EF
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 07:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E362253EE;
	Thu,  6 Feb 2025 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0HR6UGUE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C447224AFB;
	Thu,  6 Feb 2025 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825462; cv=none; b=uIHDZaY8dfl98fC0t8UiwbeyDc4pxuTflY7GpP664rpEyBWnt7kryPAUmEQNCwO4WU1l7I7bL4w9M7uLqhMo1b7+eHBAKy7QbbqaTMgv4kLHursXc/68rD2l/4uBwI7EaVl5nBTwKDEy6gyInnMeO87KT91R+4cQmeSzChCsMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825462; c=relaxed/simple;
	bh=z3jSlx7G4GOebp+k9kJHxvWHZrNfmNOO0oqerpxnx5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg3TD9qy5jOH3X1Cp5hp7afrCyWLTBxYCm/Jr2C0EQOvbgycNINiQBACJKuSiIqJr/uMIXppWtamAfcr3YX0uTXy1vJ+NObrMQ/rQKnKB4aB5Qt7uhVtcaijd/TZK/SMDcMgwLy5+rudXF5GYWqlq/NI9PI0mfLigqNbt4mx7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0HR6UGUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5864CC4CEE0;
	Thu,  6 Feb 2025 07:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738825461;
	bh=z3jSlx7G4GOebp+k9kJHxvWHZrNfmNOO0oqerpxnx5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0HR6UGUEbtaqPtL3a48f3B2Qk5vTfEh9Vfd6ARWeRSrGqVeD1+X8aZhVVBczAWdgS
	 NfwN9V4lofRmKg4lJ7HCAd2t+68oMcYYDG7TNE7JoIEj8hPw7LiT/Jsb0IBvcHye0k
	 9XAABS33Z4pyDWrUmYzD5udR8vA6Y38u0b3DdUUc=
Date: Thu, 6 Feb 2025 08:03:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Santosh Puranik <spuranik@nvidia.com>
Subject: Re: [PATCH net-next 1/2] usb: Add base USB MCTP definitions
Message-ID: <2025020633-antiquity-cavity-76e8@gregkh>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
 <20250206-dev-mctp-usb-v1-1-81453fe26a61@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-dev-mctp-usb-v1-1-81453fe26a61@codeconstruct.com.au>

On Thu, Feb 06, 2025 at 02:48:23PM +0800, Jeremy Kerr wrote:
> Upcoming changes will add a USB host (and later gadget) driver for the
> MCTP-over-USB protocol. Add a header that provides common definitions
> for protocol support: the packet header format and a few framing
> definitions. Add a define for the MCTP class code, as per
> https://usb.org/defined-class-codes.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---
>  MAINTAINERS                  |  1 +
>  include/linux/usb/mctp-usb.h | 28 ++++++++++++++++++++++++++++
>  include/uapi/linux/usb/ch9.h |  1 +
>  3 files changed, 30 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 79756f2100e001177191b129c48cf49e90173a68..f4e093674cf07260ca1cbb5a8873bdff782c614d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13775,6 +13775,7 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/networking/mctp.rst
>  F:	drivers/net/mctp/
> +F:	include/linux/usb/mctp-usb.h
>  F:	include/net/mctp.h
>  F:	include/net/mctpdevice.h
>  F:	include/net/netns/mctp.h
> diff --git a/include/linux/usb/mctp-usb.h b/include/linux/usb/mctp-usb.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..ad58a7edff8d5228717f9add22615c3fad7d4cde
> --- /dev/null
> +++ b/include/linux/usb/mctp-usb.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * mctp-usb.h - MCTP USB transport binding: common definitions.
> + *
> + * These are protocol-level definitions, that may be shared between host
> + * and gadget drivers.

Perhaps add a link to the spec?

> + *
> + * Copyright (C) 2024 Code Construct Pty Ltd

It's 2025 now :)

thanks,

greg k-h


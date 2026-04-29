Return-Path: <netdev+bounces-282194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJi3BKtl8WlfggEAu9opvQ
	(envelope-from <netdev+bounces-282194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:58:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A636D48E2CA
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E988830457C1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4740735F16B;
	Wed, 29 Apr 2026 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cjZsd7oV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC322A80D;
	Wed, 29 Apr 2026 01:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427867; cv=none; b=ZZq2XVAozshRRkwlhmJ/SuzIbSm/oEA4KCwxhPL7/p66/VUkjn5FkdmowbEfC4fuPsdOmSFzQfwiY0WyLT0T5ugu7aPdyMK5joGkTWFPsnZJ3dGCRZILO32HchEV3yvVjDvR8Wc6Ehk1+0xq1ZMUVyTuMOX1qz7sTxy5arT3SU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427867; c=relaxed/simple;
	bh=1OCg6gv0s9a4rmryuF3WO72m1ZcTPRKGn69AF8kNNqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2QQzN7NU+UveQzCrfoUg/uE9TgZHzifNwnMM4FhMx06OUGVO+aSFDpqBi0mVZFD3ZdVwUiVAlZyMqvKL8n4mMuthJP/0tD72rxYLPGHlY7xYN0CUQvsIX9rtpdUfdiGRK7qxLw8uSQ2XrVdWN6S5cJnCzHksiBhY+LQjRwFP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cjZsd7oV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ABXuMMIgTfQ5OtNDHGIn2rIDcXtUvbW4R29/GTY4DW8=; b=cjZsd7oVat20nuCKlTwBoZA64P
	xdGQiijMUUs9Pk4RZ5RACN3M8b9+/VuD/LxIKQCKIRi8sW1c8ONbDnvH6pMupRwfPRBSo1I0qpCSd
	P0bvL+JeaDOvROwsLHIUyH1lO8uzq3/ZMcEcOiHOqTCam4zNnm+kiho/bFbPpUD+Z8hk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHuBH-000RqS-T8; Wed, 29 Apr 2026 03:57:39 +0200
Date: Wed, 29 Apr 2026 03:57:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next 4/4] r8152: Add firmware upload capability for
 RTL8157/RTL8159
Message-ID: <d9d69a5a-be6e-4566-9ec3-e742f745a530@lunn.ch>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-4-52d03927b46f@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-rtl8159_net_next-v1-4-52d03927b46f@birger-koblitz.de>
X-Rspamd-Queue-Id: A636D48E2CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282194-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid,birger-koblitz.de:email]

On Tue, Apr 28, 2026 at 05:47:24AM +0200, Birger Koblitz wrote:
> The RTL8159 requires firmware for its PHY in order to work at
> connection speeds > 5GBit. Add support for uploading firmware for
> the PHYs using the existing rtl8152_apply_firmware() function
> in r8157_hw_phy_cfg() and set up the correct names for the firmware
> files.
> 
> If no firmware is found, both the RTL8157 and the RTL8159 will continue
> to work.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> ---
>  drivers/net/usb/r8152.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 08cc3c1dae0facb2400890ba4d093c97ed56d40b..56e00fe6f32405ce753df3e03e54a7daaf1a29ac 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -4663,10 +4663,11 @@ static bool rtl8152_is_fw_phy_speed_up_ok(struct r8152 *tp, struct fw_phy_speed_
>  	case RTL_VER_11:
>  	case RTL_VER_12:
>  	case RTL_VER_14:
> -	case RTL_VER_16:
>  		goto out;
>  	case RTL_VER_13:
>  	case RTL_VER_15:
> +	case RTL_VER_16:
> +	case RTL_VER_17:

Is that a bug fix?

	Andrew


Return-Path: <netdev+bounces-293776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLhXKvuNHWqpcAkAu9opvQ
	(envelope-from <netdev+bounces-293776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:49:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A45620469
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 15:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D032F3045EFF
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 13:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC3C3ACEF7;
	Mon,  1 Jun 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="gCvAfVgu"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0E39E167;
	Mon,  1 Jun 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321215; cv=none; b=jtddWAHmCHhBPqaPGTcuilg6KPqAK4x0aPvH983aoU1NOupvX8gedtdxvzYdDnmRNKqPx2H4wBdgHfgfWwrJ4bL3wZb/kwC69tRTg9U47FRsFcmd0IbmxDeEJwjhhAvh0m1NkMAzvxi5h841+NHhdAoA+neimcPcy80RRRg/fFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321215; c=relaxed/simple;
	bh=9QmMVApa80Dz7FYX50J8INRCOU4btLNLHCrtKqa0L5g=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TZm/MXaVpXwu1c0M0D5fR5Ihqaq9rkRbSLMRv2H5ZpU+ShCJIihpa1vkCGzPelWtDGDkfHoi/fyxkVSVHwDzbZttHhiXQjFxU23Vl8hrF7P8xUOjWptpIYQv8NLPvsY3YrXa/Eg/jzc4cM2AndYUW7+OwpMXEhjnlmz9JuA2HC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=gCvAfVgu; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3AD91A08DA;
	Mon,  1 Jun 2026 15:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780321211; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=i0wjg1kLqHhQKBGucPZwcnk8V+TZKZyX3rATVJjEHtM=;
	b=gCvAfVguNprAHJMweAIER3v3B2P/HosPkstOYHx1ULc170mCtlQmhPiUP2V69CvcGXx21H
	ylxAaXtPHjhea4qigMMvLhliJBY4XZKC3HfDEQy3Lbth9q+iNV+iu5Z3MOzV/RLpOml/lL
	GuM0g1fAZrkwqeCaLU1MooafzoB8lCpXQW1G5EsFqJK9ms+EmptW8UKmT9xxUbcNQLcAhF
	LVsouCizuzV2VNqUtBjG0WCxO9/v+NuC7XvAnSqlagh3Q1bp8qoJWxGEq8YqXQSGvl7yY2
	Z+eT3cp3uWcoWpJBDT4dPfVSQ6NM9L74Pri/Y9eTXEEiwts5pwXbfFBaM407oA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 01 Jun 2026 15:40:09 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut
 <marex@denx.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Simon
 Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Fidelio Lawson
 <fidelio.lawson@exotec.com>
Subject: Re: [PATCH net-next v8 1/3] net: dsa: microchip: implement KSZ87xx
 Module 3 low-loss cable errata
In-Reply-To: <20260601-ksz87xx_errata_low_loss_connections-v8-1-cfa102cf62c0@exotec.com>
References: <20260601-ksz87xx_errata_low_loss_connections-v8-0-cfa102cf62c0@exotec.com>
 <20260601-ksz87xx_errata_low_loss_connections-v8-1-cfa102cf62c0@exotec.com>
Message-ID: <085361bb51b2dd20ee4b57cf11da5684@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-293776-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:dkim,exotec.com:email,microchip.com:url]
X-Rspamd-Queue-Id: 25A45620469
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fidelio

On 1.6.2026 13:54, Fidelio Lawson wrote:
> Implement the KSZ87xx short cable workaround.
> 
> This patch implements the KSZ87xx short cable erratum
> described in Microchip document DS80000687C for KSZ87xx switches
> and the following support article:
> 
> Link: 
> https://support.microchip.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family
> 
> The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
> where the PHY receiver equalizer may amplify high-amplitude signals
> excessively, resulting in internal distortion and link establishment
> failures.
> 
> KSZ87xx devices require a workaround for the Module 3 low-loss cable
> condition, controlled through the switch TABLE_LINK_MD_V indirect
> registers.
> 
> This change models the erratum handling as vendor-specific Clause 22 
> PHY
> registers, virtualized by the KSZ8 DSA driver and accessed via
> ksz8_r_phy() / ksz8_w_phy(). The following controls are provided:
> 
> - A boolean “short-cable” preset, which applies a documented and
>   conservative configuration (LPF 62 MHz bandwidth and DSP EQ initial
>   value 0), and is the recommended interface for typical use cases.
> 
> - Separate LPF bandwidth and DSP EQ initial value controls intended for
>   advanced or experimental tuning. These are orthogonal and 
> independent,
>   and override the corresponding settings without requiring any 
> specific
>   ordering.
> 
> The preset and tunables act as simple setters with no implicit state
> machine or invalid combinations, keeping the API predictable and 
> aligned
> with the KISS principle.
> 
> The erratum affects the shared PHY analog front-end and therefore 
> applies
> globally to the switch.
> 
> Fixes: e66f840c08a2 ("net: dsa: ksz: Add Microchip KSZ8795 DSA driver")

Do we need/want a Fixes: tag for a net-next patch?  AFAIU the only thing
actually fixed is the TABLE_LINK_MD vs TABLE_LINK_MD_V macro, and that
macro was not referenced anywhere before this patch.

> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
> ---
>  drivers/net/dsa/microchip/ksz8.c       | 89 
> ++++++++++++++++++++++++++++++++++
>  drivers/net/dsa/microchip/ksz8_reg.h   | 23 ++++++++-
>  drivers/net/dsa/microchip/ksz_common.h |  4 ++
>  3 files changed, 115 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8.c 
> b/drivers/net/dsa/microchip/ksz8.c
> index 0f84b2e7d25d..b8a7b9004142 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c

> [...]

> @@ -2070,6 +2155,10 @@ static int ksz8_setup(struct dsa_switch *ds)
>  			return ret;
>  	}
> 
> +	/* Initialize KS87xx short-cable preset control */

Should be KSZ87xx.

> [...]

Besides from the above:

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai


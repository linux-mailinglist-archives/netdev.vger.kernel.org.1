Return-Path: <netdev+bounces-292670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKQuOUUrGGqwfAgAu9opvQ
	(envelope-from <netdev+bounces-292670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:47:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 627175F17F7
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9A9B30A04C0
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2B3E5584;
	Thu, 28 May 2026 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="jtx6pVUJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9453E5568;
	Thu, 28 May 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968615; cv=none; b=FeCUp8yXrjPN6roDak7aX7+4LBpM1/oal2bcYpCrHi/nee42/6GLGScI4g/+175jwf0E2/X8FEozLx4NOBOCSVfXDywlgPAQQFHQbSyj0Z9gOwaDWaM/sbAGT9iDn0yosNJBJXVSV7p7ax6/qEeEYYxkUvDd+NzrVwb9f8vFkWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968615; c=relaxed/simple;
	bh=fr491affJ425gBzutQw1fczuT6ketbpSdwG19DesXNI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FQS7S3CHzVIlh4AR/GOskxh/bqwUGOtXU0eeQW37lers2A74A7//1iEl3LVGJ/vsJDA20IwU4inumrL6/avee01dXHbs7qGP5kN/pNlaa+j+KesyToLDYRFXFqN7tbQ74VbDve37wk7MI64T+XKJFBtcKsUq66JBAt7SVFomyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=jtx6pVUJ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B36FCA00EA;
	Thu, 28 May 2026 13:43:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779968608; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R6spCzGf/LCX3ffI82dewWiNoHeMCwK14pSvO/gvUSs=;
	b=jtx6pVUJjUQ7ONTrP6zh9CZg/nTaZ75WGwQAtATC7LA4Pb8RqonM7xWxZ5TJ82VHuFDTEv
	UfzBiFlF1oLUDgWcivEzZqAWaC5QOoV3EsCq39wHO6bX79BVBJSoaMV5ZvPBhTEgLviNhr
	i0Rg8q4niZZK+vUiH8cVzsmH3ikxN/RlyHNSeDAOYv/VtKI5v07De1kNm/dp2y/r4nbnyT
	lNXS0/Oa6gQbp3V03Xp5UgfrfxtECcUaxG2p12baBJHyMnWObFc/Jm+HsvaIXD1dCX1E1K
	d+vzwDAodA1TewaC44U9CHsU60At3AhGwThyirBZ95/+JInXuzwnArS57m9uCA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 May 2026 13:43:23 +0200
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
Subject: Re: [PATCH net-next v7 1/3] net: dsa: microchip: implement KSZ87xx
 Module 3 low-loss cable errata
In-Reply-To: <20260524-ksz87xx_errata_low_loss_connections-v7-1-1cd49cfa24f0@exotec.com>
References: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
 <20260524-ksz87xx_errata_low_loss_connections-v7-1-1cd49cfa24f0@exotec.com>
Message-ID: <fbb60fec5bbeb5fb83e215adbc2dcbb3@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-292670-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tipi-net.de:mid,tipi-net.de:dkim,exotec.com:email]
X-Rspamd-Queue-Id: 627175F17F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fidelio,

A couple more from testing on a KSZ8794, in case they help while you
look at the register-document question.

On 24.5.2026 12:44, Fidelio Lawson wrote:
> Implement the "Module 3: Equalizer fix for short cables" erratum from
> Microchip document DS80000687C for KSZ87xx switches.
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
> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
> ---

> [...]

> +
>  /**
>   * ksz8_r_phy_ctrl - Translates and reads from the SMI interface to a 
> MIIM PHY
>   *		     Control register (Reg. 31).
> @@ -1046,6 +1077,22 @@ static int ksz8_r_phy(struct ksz_device *dev, 
> u16 phy, u16 reg, u16 *val)
>  		if (ret)
>  			return ret;
> 
> +		break;
> +	case PHY_REG_KSZ87XX_SHORT_CABLE:
> +		if (!ksz_is_ksz87xx(dev))
> +			return -EOPNOTSUPP;
> +		data = !!(dev->lpf_bw == KSZ87XX_PHY_LPF_62MHZ &&
> +				dev->eq_init == KSZ87XX_DSP_EQ_INIT_LOW_LOSS);

The cached state lives on struct ksz_device, but ksz8_r_phy() is
invoked per port. Setting the preset on one port is reported back as
active on the others:

   phytool write swp1/1/0x1a 1
   phytool read  swp1/2/0x1a -> 0x0001
   phytool read  swp1/3/0x1a -> 0x0001

The commit message already notes that the erratum applies switch-wide.
So writes from non-primary ports could either be rejected or at least 
produce
a dev_info_once() so userspace can see the setting is shared?

> +		break;
> +	case PHY_REG_KSZ87XX_LPF_BW:
> +		if (!ksz_is_ksz87xx(dev))
> +			return -EOPNOTSUPP;
> +		data = dev->lpf_bw;
> +		break;
> +	case PHY_REG_KSZ87XX_EQ_INIT:
> +		if (!ksz_is_ksz87xx(dev))
> +			return -EOPNOTSUPP;
> +		data = dev->eq_init;

dev->eq_init starts at zero from the kzalloc, but the header added by
this patch defines KSZ87XX_DSP_EQ_INIT_FACTORY = 0x0F as the hardware
default. After a fresh boot on my setup (no writes), the read returns 0:

   phytool read swp1/1/0x1c -> 0x0000

Should probe set dev->eq_init = KSZ87XX_DSP_EQ_INIT_FACTORY (and
dev->lpf_bw = KSZ87XX_PHY_LPF_90MHZ), or read the indirect registers
once on probe, so the cache reflects what the hardware actually holds?

> [...]

Thanks
Nicolai


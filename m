Return-Path: <netdev+bounces-289981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFmKJoHSDWpP3gUAu9opvQ
	(envelope-from <netdev+bounces-289981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:25:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57E590C60
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF70B31F4A11
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38E3FB073;
	Wed, 20 May 2026 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="OqnLjSPJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D83F58D6;
	Wed, 20 May 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289711; cv=none; b=Avy1fWxZeIQrlhM0pM7ZeVchMrQK1TuuPzpF0U4VtPyxFDTyTwJzxsXsPNyTt9hnozN81qdWgf1Zs/pyiIUfX2VZLjZe/wyzGvB8UQGwcypAsSG56/kbuwXBQW2txyXunp5SgaKkt72fAHZtc7WZsCEHuKrZIl6GYff4MFKLSps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289711; c=relaxed/simple;
	bh=x4mPsOCxn9KhDckqmC0Ir9ExNnXLDlCfF98Hm7mjVR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxQ7J1rRZwnx8iWJES8g0cLNfSAz09p2F2hxpIJ57RPYFnxyN4YPhtxzRdIw/wOAafumaUPW8Ap5s083I6Kz7JQphPVtbIG9vRkfL+2nWQjSCYI7fzCblnAjGeUT/HCzvfdglaP8sxC29DTgJh3E2BZKtlhS/D5lUMM7OQZELvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=OqnLjSPJ; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F8BC11491F;
	Wed, 20 May 2026 17:08:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779289700;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=8KpYenBxRuyIn0gHYdvx/R16eV5VvXl/6IFiYbeKdVU=;
	b=OqnLjSPJwf+3bTLUyTCEp1iQl/wiF3OY6g9Bfp2GDvoA3fE15dHlu4aS6Ss0zaMl/oiM0z
	piN3p1n6ae/Z6fTdieA0TKsvJmcLunicT4N345KO7tANCiH85rfa3ad7elxk3iHTLuCdKl
	FxNcLxMSlMHLmTAkfVoKCibL9Q8gC6bIm7tCIRH5jdyIlQQMAVyKhmtEQ+TXdKdDwlLt7L
	2zfzpOjQYMk/9gr6ZG0u/APmUG1++W6pyFQO538/995aW0AjhfWl1+iHpHm2ZR9LMS4aiX
	zNe7cTcObozcYOl5521Sl9svfvMunBCaFN/sxJXj1oiGjyCfTC9c10AJHJoCig==
Message-ID: <bb8004b1-b14f-4032-ac6e-121245b1a83d@nabladev.com>
Date: Wed, 20 May 2026 13:47:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260520-ksz87xx_errata_low_loss_connections-v6-0-43f33d4aaf0f@exotec.com>
 <20260520-ksz87xx_errata_low_loss_connections-v6-1-43f33d4aaf0f@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260520-ksz87xx_errata_low_loss_connections-v6-1-43f33d4aaf0f@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289981-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BA57E590C60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 10:48 AM, Fidelio Lawson wrote:
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
> This change models the erratum handling as vendor-specific Clause 22 PHY
> registers, virtualized by the KSZ8 DSA driver and accessed via
> ksz8_r_phy() / ksz8_w_phy(). The following controls are provided:
> 
> - A boolean “short-cable” preset, which applies a documented and
>    conservative configuration (LPF 62 MHz bandwidth and DSP EQ initial
>    value 0), and is the recommended interface for typical use cases.
> 
> - Separate LPF bandwidth and DSP EQ initial value controls intended for
>    advanced or experimental tuning. These are orthogonal and independent,
>    and override the corresponding settings without requiring any specific
>    ordering.
> 
> The preset and tunables act as simple setters with no implicit state
> machine or invalid combinations, keeping the API predictable and aligned
> with the KISS principle.
> 
> The erratum affects the shared PHY analog front-end and therefore applies
> globally to the switch.
> 
> Fixes: e66f840c08a2 ("net: dsa: ksz: Add Microchip KSZ8795 DSA driver")
> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
Reviewed-by: Marek Vasut <marex@nabladev.com>


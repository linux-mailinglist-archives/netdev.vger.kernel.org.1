Return-Path: <netdev+bounces-278523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPbEIE1i3mldDgAAu9opvQ
	(envelope-from <netdev+bounces-278523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:50:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFEB3FC209
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2752A3004438
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674A53E5EE4;
	Tue, 14 Apr 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="LqGv1Bu7"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010522F6918;
	Tue, 14 Apr 2026 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181830; cv=none; b=SNnxI6bcLlPoncZ/S5PN3iEmtzREUv4TmPrxC2yRPNnskHe328UlftHIYkVmoseO3vs2eAHTTPsLZ6+8N/vJoOQdyUslIoxrlCR/xp6xTJngAfPN4/s+ZuLSDGcLSmVNwfXhqXuOIvEa6w2WSK0S9QlSBNcMn9anwaxlb53RYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181830; c=relaxed/simple;
	bh=68bPKy+SygqPcosn9+8GzPCOUaqwLr7+GKRWMf4F39M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhUHtccWwT4I9LbOnRCA3MShrkv/47p2i7U+Hnsz2JmdyzoqRc9e2JTAw62L2r42+w9ilCZK2/JugucpelZ40bzSFTwUxcJoGL6OESH1+4UHlTTQZE5Qt73w1kLqcOLdf22H/FWaoGUEOwRbrtsPjBFdbA3elArxWrdI7MGZfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=LqGv1Bu7; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 866C310A419;
	Tue, 14 Apr 2026 17:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776181826;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=jgPuuEgRdOfdriSUf5lQZeYFkVppoqhQrClHdVEcIGU=;
	b=LqGv1Bu7fhEJwXdeus4H9OG5DfWOzGL41iVObE13xNsUaQhjiqNTI2AWyMGdB1UVdXyyh4
	iN1vIn8cF0Zjm/D4Jzn9oFRATzqnjvcct5HYQTYvZfwdBAFKTOWSmbRsaY+zeWQqQVPA7f
	o1b9kHPQzkMnsIRSSHWYLhe3KuwWNulG7RPoeN/5pYkvaVxj0LlVBabjCAyOcnY0XVAnKd
	eArLqld+4oPLRRydaDfamEXeckYFj3/p/6941gtFuNu9MSMB3G3P6rgTBf6x19ZpF3Qu2Q
	HyDx98DjRMFsldTmUstXxu9VFZA/Y7Ae+917DOmg3m486wKb4/Ekq160uiZXfg==
Message-ID: <aa8b889f-8586-4fdd-8f54-2cd935bc6170@nabladev.com>
Date: Tue, 14 Apr 2026 17:50:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Andrew Lunn <andrew@lunn.ch>, Fidelio LAWSON <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
 <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
 <ea90a671-70be-4d89-b842-1e54d687336f@nabladev.com>
 <d9b161dd-f698-4d7e-8ccb-9ec12411bf87@lunn.ch>
 <264667a8-bbb2-44ac-84e7-df6c506ae6fa@gmail.com>
 <d584bd42-ee6d-465f-b4f7-2edc992368d6@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <d584bd42-ee6d-465f-b4f7-2edc992368d6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278523-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nabladev.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:mid]
X-Rspamd-Queue-Id: 6FFEB3FC209
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 4:54 PM, Andrew Lunn wrote:
> On Tue, Apr 14, 2026 at 03:48:33PM +0200, Fidelio LAWSON wrote:
>> On 4/14/26 14:40, Andrew Lunn wrote:
>>> On Tue, Apr 14, 2026 at 01:05:49PM +0200, Marek Vasut wrote:
>>>> On 4/14/26 11:12 AM, Fidelio Lawson wrote:
>>>>> Implement the "Module 3: Equalizer fix for short cables" erratum from
>>>>> Microchip document DS80000687C for KSZ87xx switches.
>>>>>
>>>>> The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
>>>>> where the PHY receiver equalizer may amplify high-amplitude signals
>>>>> excessively, resulting in internal distortion and link establishment
>>>>> failures.
>>>>>
>>>>> KSZ87xx devices require a workaround for the Module 3 low-loss cable
>>>>> condition, controlled through the switch TABLE_LINK_MD_V indirect
>>>>> registers.
>>>>>
>>>>> The affected registers are part of the switch address space and are not
>>>>> directly accessible from the PHY driver. To keep the PHY-facing API
>>>>> clean and avoid leaking switch-specific details, model this errata
>>>>> control as vendor-specific Clause 22 PHY registers.
>>>>>
>>>>> A vendor-specific Clause 22 PHY register is introduced as a mode
>>>>> selector in PHY_REG_LOW_LOSS_CTRL, and ksz8_r_phy() / ksz8_w_phy()
>>>>> translate accesses to these bits into the appropriate indirect
>>>>> TABLE_LINK_MD_V accesses.
>>>>>
>>>>> The control register defines the following modes:
>>>>> 0: disabled (default behavior)
>>>>> 1: EQ training workaround
>>>>> 2: LPF 90 MHz
>>>>> 3: LPF 62 MHz
>>>>> 4: LPF 55 MHz
>>>>> 5: LPF 44 MHz
>>>> I may not fully understand this, but aren't the EQ and LPF settings
>>>> orthogonal ?
>>>
>>> What is the real life experience using this feature? Is it needed for
>>> 1cm cables, but most > 1m cables are O.K with the defaults? Do we need
>>> all these configuration options? How is a user supposed to discover
>>> the different options? Can we simplify it down to a Boolean?
>> We were seeing random link dropouts with the default settings, and since
>> enabling the workaround 2, the link has remained stable and we have not
>> observed any further issues.
> 
> So for you, a boolean which enables workaround 2 would be sufficient.
I agree with the observation from Fidelio, the hardware behaves that 
way. As for the rest format of the tunables, I now replied to previous 
email.


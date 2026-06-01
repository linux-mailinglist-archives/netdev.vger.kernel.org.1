Return-Path: <netdev+bounces-293613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDBMIGNDHWpbXwkAu9opvQ
	(envelope-from <netdev+bounces-293613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:31:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C276861B7DA
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4424300F9E2
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DA433F38B;
	Mon,  1 Jun 2026 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrG3TDu7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8616286891
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302649; cv=none; b=V+DrCvmjLHWvMbsS7ydUg+gbbonsQpkSvP707+rGIZLBeBKTsxhGvopqLdFMQeQKdwu+2IkJ8Tl8DyyzPI0fqch25aNX/XEcBDfzMScD+q03LYRszT8njozLid4WcaPFJvhbPlQkMbHClNz155EjQB+2vpKQk30Qose7tGyn6rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302649; c=relaxed/simple;
	bh=Y1qVp4utPKZXUH21/T3Oo88OLSEQl2daIWhaSnuy/Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyRBxRxUzZlHP+MnlnlycxBh6fDLttH/YAC+s7S5UWAV1MWubWyQRuT7/8gCeHWB1/mM+9UCpByhCFmxIuj6RLh8JNNcMik7DYNPcyusufR9GLWGkZ7sNDSbhdJ0XkFwL/qIpXox0/YItMR6dN9wQUqfh/4c16zceGAa+H3wh2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrG3TDu7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490ac357c55so4520285e9.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780302646; x=1780907446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwAHLZ3UgcsbO24XSXnLiyviM8jEF0gazKCXykLMo3A=;
        b=UrG3TDu7nOBXxRwlP4A223WWSeabGqtYiaP93eK92JG27fX3HBMHhXofZQKsPtarhT
         vTp2GyGwhAQf37z1fKMUp5TB5uQVqaO/GTJOUb2/MGPMQ/1pWxPhKKwD3N0zz2wEpwUq
         kEhc3m60pLbpj2Ac35ectndeCThI22cWJXUJxnRNAhdAxXVeC5BWWCiheEYVChxTeN66
         ZWi737hC75ERE803zkKvGiduWITnT63RDnYmKc8IrdG6n9XHVcZDF21Mrh1mJyfzo1e3
         PgOLvmg2sRwJ30g4cq4DVs3UEo+6aN7XEnhhacmBJMfLBv20U8Rse8zM0OJnhlcpyWk/
         miSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302646; x=1780907446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwAHLZ3UgcsbO24XSXnLiyviM8jEF0gazKCXykLMo3A=;
        b=r2eNYpD4hYpK5HRdNi5CUvJjlqiS0MeooSFwagaigmevKZl9HI9YLEZB9RZi/pgFPR
         PHfaRc/wWz1cG/LXFjtLHNLXabNefE3eU49IDPBlLTyVxWP+C+rUzDgWzBsTPmgO8kC5
         GegrYkVLra2PTmmsdS8KaQVWIvPtVMU855rnDxMtstm88u61WT9iXAVd6EBAGmROn2AS
         8C+vkR0oiVeBwXJ29bJVMmlxj9M/jaHoDY3fd42nBSNDryAmZWjSzoDAYv1Tyq63ukfV
         IDMbTJ3+ltKIun+AN8BoGuJoDTNvlspA1ytj6cBYCjZyn5cD+xH18KQxOpQCZ+CC1R2d
         MPog==
X-Forwarded-Encrypted: i=1; AFNElJ8rZ8fAkAO8sgMjpS6ICganQt8IQjTch28PvjEsLWWc+jj2OxGAYdu/Y8X+6eAT2kbV/8HZN8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBMuzDh0ncv+UuiIBFpJqG0GR7YfoLx1K9SXhjuvN8GpflXXmE
	UwWDGYaHbc2opXZUec696OvfbbfK9vlNbX/uskjXglk8NwSkq4SY5XPq
X-Gm-Gg: Acq92OEmcJxcgLyuFFbizCThsBvORGwckXPiba43MN/iZZubPNfGvQz9nsMjkaYdNHB
	caa7QxzHREI5dLmm1PQpuap1VmUk6CESTS5MLqi/45K1q7JlYiSS309vhrT9GUIjxBDUkazAYq3
	YSRUQ8bzrWA+KwfgAeIiQUcJQ8npPkgVwimPAWTgj1tCT1+z84sBFXE+ywz02BTjZjByAf+kcmj
	A0jytHUkpoIsG9h5V9jdlVFas4gZxSDb7464sSqO6uERyNR5QIOTn5bDhjDK0w8GHiP/RpPWT+m
	DJjp1ZMmtxeVNDFF6zicCIQ+EBuug+mQTQZUbgpsxMkyRk85QWYzIwGIn/DGHSoAHNpRZZmH2R1
	CA1QjmH9ptmP/CfGMOcEcfwibzoMUeaw3e1wZDMJqUcc8qCuoOVA1C70xKcbyPqVfXw5boBjC5l
	vLdp4sJzutFf+sJ8fCZ8Tg0MbUgJuwfBpFaNznMRIum5krbKH1/Hw44Xa5eGPx1+V+50rSaF8Ps
	7thkqvYcb5Ihs2GVx1B
X-Received: by 2002:a05:600c:a214:b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-490a2948f0cmr112272415e9.25.1780302645969;
        Mon, 01 Jun 2026 01:30:45 -0700 (PDT)
Received: from [10.1.0.164] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca6db64sm228497705e9.6.2026.06.01.01.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 01:30:45 -0700 (PDT)
Message-ID: <7b7616ef-026e-437b-89de-2a1f67356c5c@gmail.com>
Date: Mon, 1 Jun 2026 10:30:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/3] net: dsa: microchip: implement KSZ87xx
 Module 3 low-loss cable errata
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha
 <Tristram.Ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260524-ksz87xx_errata_low_loss_connections-v7-0-1cd49cfa24f0@exotec.com>
 <20260524-ksz87xx_errata_low_loss_connections-v7-1-1cd49cfa24f0@exotec.com>
 <77de607f2f8330ae6a593a4803887c8f@tipi-net.de>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <77de607f2f8330ae6a593a4803887c8f@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com];
	TAGGED_FROM(0.00)[bounces-293613-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:url]
X-Rspamd-Queue-Id: C276861B7DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 09:19, Nicolai Buchwitz wrote:
> Hi Fidelio
> 
> On 24.5.2026 12:44, Fidelio Lawson wrote:
>> Implement the "Module 3: Equalizer fix for short cables" erratum from
>> Microchip document DS80000687C for KSZ87xx switches.
> 
> The commit message says this implements Module 3 from DS80000687C, but
> the errata's Work Around 1 writes 0x15 to indirect register 0x3C
> ("PHY equalizer register"), and the patch never touches 0x3C. Could you
> please clarify which document the register addresses
> (KSZ87XX_REG_DSP_EQ = 0x08, KSZ87XX_REG_PHY_LPF = 0x4C) come from?
> 
> I checked against the the following document:
> https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ 
> ProductDocuments/Errata/KSZ87xx-Errata-DS80000687C.pdf
> 

Hi Nicolai,

Thanks for the review.
Regarding the register addresses the definitions used in the 
implementation are based on the following Microchip support article:

https://support.microchip.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family

I'll add that clarification to the commit message.

> This silently returns when enable = false and nothing is written to the 
> registers.
> Either I'm missing something or the short-cable preset cannot be cleared 
> through this tunable?
> 

You are correct that the current implementation does not restore any
configuration when 'enable' is set to false.

In the next revision, I will update this to apply the default
settings when disabling the preset, so that the tunable behaves as a
proper reversible configuration.

Thanks again for pointing these out.

Best regards,
Fidelio



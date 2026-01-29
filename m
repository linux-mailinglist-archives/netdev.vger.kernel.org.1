Return-Path: <netdev+bounces-254875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aObAE62Ze2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:32:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE49BB2F0B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBECD3016D2D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFC734FF47;
	Thu, 29 Jan 2026 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FkvI46SD"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8B34F48A
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707939; cv=none; b=fBQkISnIfZXMzWzhE/DH+8kbW4jZKi8fealvMV/HGmNN6Q32dHaiF2B3NB+Ui4kdpzntTHVH5TUearbmf3DvxhyYZ5Bt0HETknhlzfoFVqYeozzwmW6qObwlapf7xzQRMWuDsO+kkGz12lq/5ysm/nTFpp7khBpYxx83WVIHkFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707939; c=relaxed/simple;
	bh=pNyMwAitK1xdxu4JsBwQYguSf6D+OoodR5st+y3neBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=is1F3HDT19kgSoQwxpbaOnk8vBLMR+Lj4PAD+EsCOg9wsgbczLlRIlPLfLMRhvQmuvMha+kXzpnfAOrZRqF2122xwguuFwgsgztDUBaqH1FzwSAd6LrsL13zX0ybkQ1XzcL8OTq3AkhbeA3Lznk3bipFqNBRAMBRWd7IWBgDKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FkvI46SD; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <de1d615d-85a6-495d-b830-b169f7f8310a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769707924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DU0NlzLsv/ZHnOibbN99rSZRlseR1GJV4rT25Fxf2/I=;
	b=FkvI46SD3wOuXghjvLFqJjLSnRoZALqE+srW+2C8FJt3z4/2MQN6SmLWEiew5xhHrUsDyb
	8rfKWM8vJehR2uDSuWzMjYhXOyht0phVtcLkBRjXOYGg+tqWfO/FHpxh1u1JN0CsgPeiNI
	wPJs82cZQJ767Mw4Gz3Sir/siv2eoiY=
Date: Thu, 29 Jan 2026 12:32:00 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] net: phy: dp83867: Always program R/SGMII
 enable bits
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260129171205.3868605-1-sean.anderson@linux.dev>
 <20260129171205.3868605-3-sean.anderson@linux.dev>
 <aXuXWxhtR-1Hvlv4@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aXuXWxhtR-1Hvlv4@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,vger.kernel.org,kernel.org,redhat.com,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-254875-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.anderson@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE49BB2F0B
X-Rspamd-Action: no action

Hi Russell,

On 1/29/26 12:22, Russell King (Oracle) wrote:
> On Thu, Jan 29, 2026 at 12:12:05PM -0500, Sean Anderson wrote:
>> If the board designers have neglected to populate the appropriate
>> resistors on the strapping pins then the phy may default to the wrong
>> interface mode. Enable/disable the RGMII/SGMII enable bits as necessary
>> to select the correct interface.
>> 
>> The dp83867 strapping pins have four levels and typically configure two
>> features at once. LED_0 controls both port mirroring and whether SGMII
>> is enabled. If it is pulled to VDDIO, both port mirroring and SGMII
>> will be enabled. For variants of the dp83867 that do not support SGMII,
>> this will prevent data from being transferred. As we now explicitly set
>> the SGMII and RGMII enable bits, we do not need to detect whether SGMII
>> has been inadvertently enabled.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> Something to consider:
> 
> You have separate enable bits for SGMII and RGMII. The code you're
> submitting sets the SGMII enable before clearing the RGMII enable.
> Is it permitted to have both set?

Section 7.4.1 of SNLS504F says:

| The SGMII enable has higher priority than the RGMII enable. Table 7-1 is
| the configuration table for the MAC interfaces:
| 
| Table 7-1. Configuration Table for the MAC Interfaces
| SGMII ENABLE              RGMII ENABLE             DEVICE FUNCTIONAL MODE
| (REGISTER 0x0010, BIT 11) (REGISTER 0x0032, BIT 7)
| ========================= ======================== ======================
|                       0x1                      0x1 SGMII
|                       0x1                      0x0 SGMII
|                       0x0                      0x1 RGMII

So I don't think we will have any problems.

--Sean


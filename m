Return-Path: <netdev+bounces-289984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJMhDDfYDWqj4AUAu9opvQ
	(envelope-from <netdev+bounces-289984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:50:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F055913C4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09AA13327E56
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4173FC5CE;
	Wed, 20 May 2026 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="epQoSsun"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB33FB7F1;
	Wed, 20 May 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289713; cv=none; b=Gu6hlqRZJtjvQcgEYZ/qyyGUCh2dOfXeubVY9GHoNiNL35f2KdaoMUkkocQ/Ukqquq5m4/NDmlTeyZVgjtab96zQ5dfQoYINCg/eCggTuvXcQurd2NUN2XojQD38lKRKkeNH9tvWkPzQLF4SPhK02KXDwLSFgYCfzU/ab7kMGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289713; c=relaxed/simple;
	bh=p9X+iFTHyuYBV6afYZx0rGktw25xdXQraLZz7JLR3FY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfVN3MY7PkzVAuC3xWUeG52TdtxDLEMRcqyZWRwUpxYwngj5xCkmCeqTRBERBY0Ing1LOWev9w3LVfxqBbLtM366LgSeL/h2MQNcfjNVcRtIns2bJGX51azzW/iBo4t/bhoIKebUf8m+xmO9zv8CGehJTbfzZhybOlkOct4sbiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=epQoSsun; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6882C11580F;
	Wed, 20 May 2026 17:08:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779289705;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mocp92mHgcPsQ5QAbnot/7r1RJv76ZxVRr1KYJD1irM=;
	b=epQoSsuny1oAuuDJEuMX6RczcDsuNDsHDA3oI0yJV6Y6t0e4yHxpMq6NfEGEJBCvbeCVda
	RGh2W+wNulLxM0rgs9K3qdSW68t9vOo6Wq64vLWAVI2oUhq0tT1bQLuR+d/WbABD5FDyOO
	zsuJDvuwKUyTDnVIT0xQxi4zmi+i9qi338s114Pv8thstw4oFsMJJP4I//fR69HEO/Ldws
	JStMAyomojqzSSYBWtPXAIsFQA9kmEXurRazFBFX+F9C9D/QKqCG5iZf1+WocPxwqT+tX8
	vGYenPcDRqbPDQNXGKpvyW4LC0sV3DwPpzR/BZbcLJlPOda/zXVM4korzZtRrQ==
Message-ID: <260b4704-56ae-40d7-bd53-4547928b9d52@nabladev.com>
Date: Wed, 20 May 2026 14:01:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] ksz87xx: add support for low-loss cable equalizer
 errata
To: Fidelio LAWSON <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
 <fe01752d-95d4-4686-b536-0acc8a2046cb@nabladev.com>
 <ad1d07ed-2fe7-40c3-a043-dd6d2c1c4f8f@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <ad1d07ed-2fe7-40c3-a043-dd6d2c1c4f8f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289984-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nabladev.com:mid,nabladev.com:dkim]
X-Rspamd-Queue-Id: A5F055913C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 8:49 AM, Fidelio LAWSON wrote:
> On 5/16/26 03:44, Marek Vasut wrote:
>> Is there still anything left to do with this series ?
> 
> Hi, sorry for the delay I just got back from a trip.
> Thanks for your feedback! I’ll fix everything and submit a new version 
> today.
No worries. Thank you for V6 !


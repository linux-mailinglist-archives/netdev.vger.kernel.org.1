Return-Path: <netdev+bounces-258479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN2ALVUWjmmZ/AAAu9opvQ
	(envelope-from <netdev+bounces-258479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 19:05:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77867130254
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 19:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 317EF3031009
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 18:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0002A261393;
	Thu, 12 Feb 2026 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OItYGEKe"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480C211A28
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919495; cv=none; b=DvZZtFHANauBIiNo00P3ciUwByEjV/grBSI0MBNrdl7w3eQvb2X99soKHBvw0iinliBBu6LNurEH5UJE2EDAvlpH1zR8u70gDTjOixsgpmNAcsfVhsSuf/FphzCnEAG0m23itM1H3k3Hw1EE7/+zLU3bGo3FGr6SxKKF4v8OUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919495; c=relaxed/simple;
	bh=iIxaF8rWQGCPfS6LdRFFahqHDSeZVRfZJ/fq2OyTuW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRUkBxHHgZ/nGHVaGjUx0whEDloV+1phe1Vw8PasTMn7qT6ApMoXKIPAOlw+5Q/zOzf+MHcF63lUeBRbqPXjlmukZSLxZJ0dcPi/R87UTQVQTR2H75kPTLyxxivDnVc/GMaFreG9fa7yYTbyysOD0nwJZ3UJawnFksLBAZGaTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OItYGEKe; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AEC40C23DAB;
	Thu, 12 Feb 2026 18:05:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 35E75606B8;
	Thu, 12 Feb 2026 18:04:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EA37103688A1;
	Thu, 12 Feb 2026 19:04:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770919490; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+8kTUrc2o8wPYaMgFv2zk2qMqXHnJHp/twrSvkqJ9AQ=;
	b=OItYGEKeYLv6ENHxiFbDlStUJY+eiUIKrhRIS5s+oy9EWcwC4xSa+/ZCPbMxjYFOh11Qzu
	9b09NIO+0jumzK1YKqiygXfTR4T6SXEXIaJHLDf2tB2+XEVux6c5aqT9KGG+l3ZVcjZAU5
	2dlXo/7YhSPhuHum5WinVv79hCcg9Itzlilzp4rHFffcH9SP2UzU71do+LD1lveZ6c80ci
	waB/vcvME4XbrUrM6MmJStRzBRVxLwypl9nFIcZpRDHNSlxRKacGSbkLlzRFDaHXqEcRmV
	d0G5clrJ26QwXtQ+Ux8eqZwQP8X+Ak/6r4U1hstaxxncFeQXJJFo45TbY9mTDw==
Message-ID: <42049f4d-8258-4d9a-840c-a2d2eafc6bf6@bootlin.com>
Date: Thu, 12 Feb 2026 19:04:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sparx5/lan969x: fix PTP clock max_adj value
To: Daniel Machon <daniel.machon@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 Richard Cochran <richardcochran@gmail.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260212-sparx5-ptp-max-adj-v2-v1-1-06b200e50ce3@microchip.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260212-sparx5-ptp-max-adj-v2-v1-1-06b200e50ce3@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258479-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 77867130254
X-Rspamd-Action: no action

Hi Daniel,

On 12/02/2026 12:02, Daniel Machon wrote:
> The max_adj field in ptp_clock_info tells userspace how much the PHC
> clock frequency can be adjusted. ptp4l reads this and will never request
> a correction larger than max_adj.
> 
> On both sparx5 and lan969x the clock offset may never converge because
> the servo needs a frequency correction larger than the current max_adj
> of 200000 (200 ppm) allows. The servo rails at the max and the offset
> stays in the tens of microseconds.
> 
> The hardware has no inherent max adjustment limit; frequency correction
> is done by writing a 64-bit clock period increment to CLK_PER_CFG, and
> the register has plenty of range. The 200000 value was just an overly
> conservative software limit. The max_adj is shared between sparx5 and
> lan969x, and the increased value is safe for both.
> 
> Fix this by increasing max_adj to 10000000 (10000 ppm), giving the
> servo sufficient headroom.

That's arbitrary, but looks like there's plenty of other drivers that do
similar things :)

> Fixes: 0933bd04047c ("net: sparx5: Add support for ptp clocks")
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime



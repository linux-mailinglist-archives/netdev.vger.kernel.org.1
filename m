Return-Path: <netdev+bounces-300169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r8rRDc+XMmow2gUAu9opvQ
	(envelope-from <netdev+bounces-300169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:49:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B3C699DA1
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:49:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=DMiiXSW9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300169-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300169-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D4FB300E62F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16B53F0ABC;
	Wed, 17 Jun 2026 12:49:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6827A92D;
	Wed, 17 Jun 2026 12:49:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700556; cv=none; b=HnyTH3BPinzeXm98GGn5V2eP3XUfSGDUVXNeqQTL+B7v7oNiir/1rAiZNPhk4f2BXPdC7+MireOaMzxEBAGom81rbUDWbO5uTfg12AeKqnvrD7KcxsXEnU9cT3YbS0g4qxaQ+haAziAt2Edb3KsGaISeAnqUIYWasHCXQ5QCcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700556; c=relaxed/simple;
	bh=fDAMEHEJ9xrFqSiWPkHU8F7DrP2LgGpLQ1ELm2/EC70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLcLZv+Cr7Nxb3kxkBjfBZGehBNGpSaAdP7HdzZpxRDVkyp1XaDu+yxXMqfaZ4wxqOpzE+jVdbeErWHQQrrS675GDx6SZu3yJrNHSFwBpnNKGmqsL15mgoIxGtf4O0YMPMkdpNY6TOkwQ2EMM2ulsUtLeDegHSav0ukqADzGdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DMiiXSW9; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 461121A3970;
	Wed, 17 Jun 2026 12:49:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17DBB601AA;
	Wed, 17 Jun 2026 12:49:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67F12106C80FB;
	Wed, 17 Jun 2026 14:49:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781700551; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7U1EsqHD3joJo6K5RI3ZEt2ypT632SvDp/Xsssj+cJE=;
	b=DMiiXSW9s2vDf6Ix6fXMzCn1HqRGHNhwYwFtv0jOuvSZzYYZFOEoU/uvCMne62NW68yVTu
	AqIxz+Fr2S+CvoJrCmv33dwNE5T++PjJIi4zHwdfgj03mUs4bEclffQGL0mfMQpNWJiRMC
	F78GwoXF+7rp4AosqXxsffNDgojg5f4FlGYA6j5pe+OEpDL+Rf2izku+hlj3yFcgpwCUja
	1tSk53MA8ljPzzxtIsZFHaxzBuozYy9TZRiM8iPjGdzQds3fkkeevx7wiWr75zpNU2yxBP
	TXWRcYI3iwGbnC+PuStsuoOfYjFyBXBNBczgkCjPx3qWjjTuti/ogE2BTaBGdw==
Message-ID: <95249596-5f05-421c-9c8a-693c7b26c4f6@bootlin.com>
Date: Wed, 17 Jun 2026 14:49:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mvneta: free/request IRQ across suspend/resume
To: Yun Zhou <yun.zhou@windriver.com>, marcin.s.wojtas@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260617092028.1722407-1-yun.zhou@windriver.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260617092028.1722407-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300169-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[windriver.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,goodmis.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94B3C699DA1

Hi,

On 6/17/26 11:20, Yun Zhou wrote:
> On PREEMPT_RT, the mvneta IRQ handler is force-threaded. Under high
> network traffic, the IRQ can enter suspend with desc->depth == 1
> (masked by the oneshot mechanism between handler invocations).
> 
> During suspend, the kernel increments depth to 2 and masks the
> interrupt at the MPIC level (clearing the SRC_CTL CPU routing bit,
> due to IRQCHIP_MASK_ON_SUSPEND). On resume, depth is decremented
> back to 1, but since it does not reach 0, the unmask is never
> called. The MPIC CPU routing remains cleared, permanently disabling
> interrupt delivery.
> 
> Fix by freeing the IRQ in suspend and re-requesting it in resume.
> This ensures a clean IRQ state (depth=0, proper hardware routing)
> on every resume cycle, regardless of the pre-suspend depth. This
> follows the approach used by other drivers (e.g. igb).

This description makes it sound like it's not really a mvneta problem,
but rather a broader effect from  preempt-rt / irq management / suspend
interactions.

Is this the expected way to deal with that ?

Maxime



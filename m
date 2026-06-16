Return-Path: <netdev+bounces-299748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VgZxG+HnMGpVYgUAu9opvQ
	(envelope-from <netdev+bounces-299748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:06:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0795D68C5B3
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:06:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=tKtCWD8M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299748-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299748-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 755A03016743
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D859A3DB305;
	Tue, 16 Jun 2026 06:06:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10A3DA7C9;
	Tue, 16 Jun 2026 06:06:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589982; cv=none; b=SzTkWRXjAxUH81u11vNKOR5gAiwls1/0NBmpV2ZA6haddO8mCZRh6Q0JbymMXFjcHaT28vaD5WurmueMlYEuERhse0OzMy33BYt+0ZdzoknfxKbgCyBiGUfu/xltskHhd5ASSmen0FMaL7ELZw3QlhuRWxOorvfTC/vvhj7kkeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589982; c=relaxed/simple;
	bh=seX37K99Xlbg4QzKf4znQ2xGJNcZ2eJLQxIejn9hTgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQNsxDc4+cuvghPCRMnxHINpyoV67Q0Mflzh/QsvpxZBsabMUhO+V4dac4sC5lZdTtWL5PcA5YrpGg7MfqjCMZ0a5h0HSSYBK8/MRTbtGeiNZ9V/CLZTI1R7G/loXb+CP0YqKOH2qLa8F2BpxYjy1q6FV4GjERhRnMRsUC3Ek38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tKtCWD8M; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BC7FF4E42F11;
	Tue, 16 Jun 2026 06:06:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 836DC601A9;
	Tue, 16 Jun 2026 06:06:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 000FF106C82AB;
	Tue, 16 Jun 2026 08:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781589977; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=EhCnOp/a8CLqS7AnFHJ9AnJHnV2HM5LarR3vQI1n544=;
	b=tKtCWD8MAuA6CKZqNonYxGRET3aiNACGcBdbVxQdAdOc759D+rupxiaEOnxyzDHYHgY5sM
	N+usz2uTEsPmPW+xHryTDzwXsyCZQm81h8ybsnFHqkirGjMq7ChFBC+p22mGk5rRTYCPJE
	04bxPRZS46YwgaJuiqr6gBxyp4NzuONZmscHhIe7x9SbE/5L9IdPDMKC34W5R2jeUEl+Nm
	8nx4/+lRbe+bU/ENVuI1Bo/0plQGZrV1OT9epvl7hj9LBNK0LNe1knzNsoFtC2Ra4ZjmXB
	r4lRWFU/k5ZSprtbcr5bjjZ9rHM41a93aPtRlEMJQ0Z2qpk0KrKaspAfmAcMtA==
Message-ID: <fbe4294d-98af-4817-97de-9b20df89a240@bootlin.com>
Date: Tue, 16 Jun 2026 08:06:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] net: stmmac: L3/L4 filter bug fixes
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
References: <20260616042655.7782-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260616042655.7782-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299748-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime,altera.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0795D68C5B3

Hi Nazim,

On 6/16/26 06:26, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> This series fixes three bugs in the stmmac L3/L4 TC flower filter
> implementation for the XGMAC2 core. All three patches target net.
> 
> The L3/L4 filter match count statistics patch (originally patch 4/4)
> has been split out and will be sent separately against net-next per
> Andrew Lunn's review of v1.
> 
> Patch 1 fixes a register corruption bug in the L4 filter port configuration.
> The XGMAC_L4_ADDR register holds both source and destination port match
> values in a single register. The original code overwrites the entire register
> when setting either field, silently erasing the other. This is fixed by
> using a read-modify-write sequence.
> 
> Patch 2 fixes the basic flow match parser to properly reject unsupported
> offload requests with -EOPNOTSUPP instead of silently accepting them.
> Unsupported cases include partial protocol masks, non-IPv4 network proto,
> and non-TCP/UDP transport proto. Extack messages are now included so users
> know exactly which part of the match is unsupported. The -EOPNOTSUPP is
> also now returned directly instead of using break, which was silently
> discarding the error on FLOW_CLS_REPLACE operations.
> 
> Patch 3 fixes a stale action bug on filter deletion. When a filter entry
> with a drop action is deleted, the action field was not reset, causing
> it to persist and potentially affect subsequent filter configurations.
> 
> All three patches fix the original L3/L4 filter implementation introduced in
> 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower").
> 
> Changes in v3:
> - Patch 2: add extack messages to each -EOPNOTSUPP return (Jakub Kicinski)
> - Patch 2: return -EOPNOTSUPP directly instead of break to avoid silently
>   reporting success on unsupported FLOW_CLS_REPLACE (Sashiko review)

Please take a look at this page prior to reposting :

https://netdev.bots.linux.dev/net-next.html

There's also an announcement made on the netdev@ list when net-next
opens/closes.

You can't submit new series that target net-next during the merge window,
this revision will have to wait 2 weeks.

Maxime



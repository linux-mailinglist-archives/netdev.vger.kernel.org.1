Return-Path: <netdev+bounces-253358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JSQH74fd2ntcQEAu9opvQ
	(envelope-from <netdev+bounces-253358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:03:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B952853CD
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB4ED30038EB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC4255F5E;
	Mon, 26 Jan 2026 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C+k7IL2G"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0C226863
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769414586; cv=none; b=eFzl0Jm0sYi8p7d+m9rjOZmhOSDnyao41v+LLyx7iQZ5+HferQCaZ2WoCXnweBSWl0hHI0SpZVi4eRt7OF8zE9np9y4NHqmLLauIHi+2AbrtbQNj3p3g+dTOrwrNoN9mj/dmQ2rXAGqf+Dw31k0Xpt5EBg6JDVnEUPcP20wN9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769414586; c=relaxed/simple;
	bh=gvpacmcv3iaE3q5n99vE8YQiJO50/wdTysWKG3860JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4Srpw52h2aff+kmoM39gMFP7rWbmFZ8cfDkG9efK55pPu8MpWEs+vBZqx1yl4P6MyeGxVjxC6pSsrox4CBbPFFMc+5MAsr9uCAEL00qMWamjkfoai19Kf4lTXfMTu7jxBNKCDW/kbHitLVCXVFQ1jhVzygpR8QO455UL6WStwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C+k7IL2G; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8AA0FC225BA;
	Mon, 26 Jan 2026 08:02:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 04A1560717;
	Mon, 26 Jan 2026 08:02:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7FC9119A83F1;
	Mon, 26 Jan 2026 09:02:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769414575; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=mkvjlrFf1NHBrgWnTVPrjXycV0Uof3KMIgKwfPUxqQU=;
	b=C+k7IL2GrMhq0MoJ/zu5Pqbbj/EdVJPWbvpA+yaDHIbWD1dHQU1mhv44wkgllV7jhoLnAm
	3xnPCbfgdwQq8Qg/ZzHfF0FmVw+VXJGPAgAiy6ISUFDF3OphGGfMYXXiq7fhI5rR4/vHX5
	n31XclVnpqRN14WWStMLe0HxuZf91HJvuxToESomXIU1vqOaerStWODCB1sctZnUfBQf0u
	yYSTRld2nQPBiKeiavHL451aLkjRoBjlpnqlw6gPgsBo5/Gl+JAR1b/JnHvmFgMhzYJ9Ux
	2BcxNwVDRHiIK0feie+M9MwZxUcTTKt/RP2QF2XkVnlQsiNdqM4u1H6X6SVW4g==
Message-ID: <3f1bea58-46fb-42fe-bd5b-b6341ca66aeb@bootlin.com>
Date: Mon, 26 Jan 2026 09:02:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/8] net: dsa: microchip: Add support for
 KSZ8463's PTP interrupts
To: Jakub Kicinski <kuba@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260122-ksz8463-ptp-v2-0-b6683f5ce50b@bootlin.com>
 <20260122-ksz8463-ptp-v2-4-b6683f5ce50b@bootlin.com>
 <20260125133858.5fdb7532@kernel.org>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260125133858.5fdb7532@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,se.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253358-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B952853CD
X-Rspamd-Action: no action

Hi Jakub,

On 1/25/26 10:38 PM, Jakub Kicinski wrote:
> On Thu, 22 Jan 2026 14:27:38 +0100 Bastien Curutchet (Schneider
> Electric) wrote:
>> +int ksz8463_ptp_irq_setup(struct dsa_switch *ds)
>> +{
>> +	struct ksz_device *dev = ds->priv;
>> +	const struct ksz_dev_ops *ops = dev->dev_ops;
>> +	struct ksz_port *port1, *port2;
>> +	struct ksz_irq *ptpirq;
>> +	int ret;
>> +	int p;
>> +
>> +	port1 = &dev->ports[0];
>> +	port2 = &dev->ports[1];
>> +	ptpirq = &port1->ptpirq;
>> +
>> +	ptpirq->irq_num = irq_find_mapping(dev->girq.domain, KSZ8463_SRC_PTP_INT);
>> +	if (!ptpirq->irq_num)
>> +		return -EINVAL;
>> +
>> +	ptpirq->dev = dev;
>> +	ptpirq->nirqs = 4;
>> +	ptpirq->reg_mask = ops->get_port_addr(p, KSZ8463_PTP_TS_IER);
>> +	ptpirq->reg_status = ops->get_port_addr(p, KSZ8463_PTP_TS_ISR);
> 
> clang says:
> 
> drivers/net/dsa/microchip/ksz_ptp.c:1187:40: warning: variable 'p' is uninitialized when used here [-Wuninitialized]
>   1187 |         ptpirq->reg_mask = ops->get_port_addr(p, KSZ8463_PTP_TS_IER);
>        |                                               ^
> drivers/net/dsa/microchip/ksz_ptp.c:1175:7: note: initialize the variable 'p' to silence this warning
>   1175 |         int p;
>        |              ^
>        |               = 0

I thought gcc also reported this kind of warning, but I see here that it 
only reports it with W=2.

Anyway, I'll respin with this fixed.


Best regards,
Bastien


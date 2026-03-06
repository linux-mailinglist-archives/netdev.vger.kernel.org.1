Return-Path: <netdev+bounces-264715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGHLDy6cqmnPUQEAu9opvQ
	(envelope-from <netdev+bounces-264715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 10:19:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 893C121DC99
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 10:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BD0230474E2
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0133B6F1;
	Fri,  6 Mar 2026 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uGet1/zQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E83A26B973;
	Fri,  6 Mar 2026 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788704; cv=none; b=tHm5iZvMDeuCO0iu4stmrGgw6cN+PMdS3fnRl1yvYdzg6yw/1QsSwee90+OcbKrU6AKP75Afl9M+AeseJ3VpSRKHSVU9cmtIPpp1SRwQWveq2ApERWUQmrbf5btwwREseKG2mtgoMXSlT0tJqnaY88gCoegi4D7dU6unekm9R4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788704; c=relaxed/simple;
	bh=mirBdeEXdl+ET8tYFxbmmBqoF/YH/lor2YJmpLzFAmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzcLjsGB7rXplhP2z7Trr0NaJKjRQmvk4lhA61qGWr7t1Z+0mjs3ubEyXdL287KpWYke+fNGqq1rK1TRB8tQv9cIrzDaEVgJ5x1805cDCGac7TJWhXlj4wBLG5iiC2lCjWQMO3moLdpVKLKNbTjrxFXHYjvNpTFGL6VWTTmdT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uGet1/zQ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4AA3AC4042C;
	Fri,  6 Mar 2026 09:18:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4BC715FF92;
	Fri,  6 Mar 2026 09:18:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C1E110369836;
	Fri,  6 Mar 2026 10:18:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772788698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nmuW9T6sh5fJVTVSgbgK28G3JVKthJ1ltKE+Tzhsoos=;
	b=uGet1/zQn9WfkuyXQU/X/EBoE9GWN/icTEtsTgKmQXqUyeGY/q79XBqsjZzh3BtO5SQy7Y
	dRCP8jDdf+1DC8kJxXJosELzZHKp9sLEepVuozvJExLY+41OOeWQN277mYZkXbxgGajb47
	PUqRZX+wOnNSGMgr8w26DqSYY/SdhDMcZezoFinn9QxGOJrNWNsu5I+3ZNfmpUP9Fd81/g
	ZKoyn2NIr93Pj8VFfF2zxbPMerCHSlc7siFjUZZiU8DHlHfqgihgBSOtLFU/zMKcHLZniG
	1YzdEvK5dbWzgQMBOCqRedv+IwJrAbU06UuiLWz5/NGFt5l5RlZZD6aXadbG3w==
Message-ID: <86a3f259-8914-4652-96b5-3605afbc038b@bootlin.com>
Date: Fri, 6 Mar 2026 10:18:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/9] net: dsa: microchip: Decorrelate IRQ
 domain from port
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-2-3f4c47954c71@bootlin.com>
 <20260305100711.byyyubdk7vycq6uh@skbuf>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260305100711.byyyubdk7vycq6uh@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 893C121DC99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264715-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Vladimir,

On 3/5/26 11:07 AM, Vladimir Oltean wrote:
> On Wed, Mar 04, 2026 at 11:18:53AM +0100, Bastien Curutchet (Schneider Electric) wrote:
>> KSZ8463 has one register holding interrupt bits from both port 1 and 2.
>> So it has to use one IRQ domain for both of its ports. This conflicts
>> with the current initialization procedure that ties one IRQ domain to
>> each port.
>>
>> Decorrelate IRQ domain from port so a port can use an IRQ domain not
>> directly related to itself.
>>
>> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
>> ---
>>   drivers/net/dsa/microchip/ksz_ptp.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
>> index 4a2cc57a628f97bd51fcb11057bc4effda9205dd..64afe92a3479ec87b5afc66e489b92787a0fc715 100644
>> --- a/drivers/net/dsa/microchip/ksz_ptp.c
>> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
>> @@ -1099,18 +1099,18 @@ static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
>>   	irq_dispose_mapping(ptpmsg_irq->num);
>>   }
>>   
>> -static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
>> +static int ksz_ptp_msg_irq_setup(struct irq_domain *domain,
>> +				 struct ksz_port *port, u8 n)
>>   {
>>   	u16 ts_reg[] = {REG_PTP_PORT_PDRESP_TS, REG_PTP_PORT_XDELAY_TS,
>>   			REG_PTP_PORT_SYNC_TS};
>>   	static const char * const name[] = {"pdresp-msg", "xdreq-msg",
>>   					    "sync-msg"};
>>   	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
>> -	struct ksz_irq *ptpirq = &port->ptpirq;
>>   	struct ksz_ptp_irq *ptpmsg_irq;
>>   
>>   	ptpmsg_irq = &port->ptpmsg_irq[n];
>> -	ptpmsg_irq->num = irq_create_mapping(ptpirq->domain, n);
>> +	ptpmsg_irq->num = irq_create_mapping(domain, n);
> 
> Looking at this function, I think there's a pre-existing bug.
> If request_threaded_irq() later fails, irq_dispose_mapping() needs to be
> called, because ksz_ptp_msg_irq_free() only frees the IRQ domains that
> were already successfully set up.
I think you're right, I'll send a fix for this.


Best regards,
Bastien


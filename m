Return-Path: <netdev+bounces-254166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFvxC3vVeWntzwEAu9opvQ
	(envelope-from <netdev+bounces-254166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:23:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E0B9EC25
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43E993007BBD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F85342519;
	Wed, 28 Jan 2026 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GnG/sfck"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E75313959D;
	Wed, 28 Jan 2026 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592182; cv=none; b=gBplN6rDvsOW6GvwmTC28tY9MXjyxmNzvrA0+mtiSLlu2GfVHnVROQ80iM75fpH7IGMMaCP+CuwBdASzgV9wa9bAmNW7+RC6XUWe7PLRW7cZ4Ppe7TDrDiXa9Qy5ccmIvkGFOkrlU8YHNilqpEzBHx3zK5Yd6HFx4url2ZBoVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592182; c=relaxed/simple;
	bh=yxdJgcyAaZdNv2F+vvtMiEG2f16J1xKSCRg4XJXtNN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VV4c92o4hWbrslOkEVBr2lBpLAgj33FzAYvv323iNVBLsoASwtfPSgNh9R125EXb6jb/rHb8hiHZ4CdEuWbXWmdpPAeNAjC8X98ZcZowRC2HZazvzfFARRN3sCO8b/s/XlE+ZnflOF3rj3YoGj/TluJ+EyhzqGoDG/3Mf2lIOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GnG/sfck; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7DF6C4E422F3;
	Wed, 28 Jan 2026 09:22:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 536E46071A;
	Wed, 28 Jan 2026 09:22:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E38FF119A8695;
	Wed, 28 Jan 2026 10:22:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769592171; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=kfr+T6NkfKEu9kIgHzq6J+epCZO3duBfoXYVaEh4cnE=;
	b=GnG/sfckcsRl4lAH3d4XT/7hJr8X9TofMMVxxFdQK7sfgBH/PReb7TX4n/vvCc9oorcsid
	BJxuxb4IbW1ZL0qmBUpqsH3NLYGPskwRa79+Nai2hvZjD3ttFHNDOY87gTBE3a3tiUO90b
	WZTknPWr36SXI2IcwIkdf2UBzgm3vvE/4GqoWoFbYq1/AlBLGiIMmtlymAHH5jm1YD3dxk
	WYorsV2YndJtbn33dLywGkJEyfa/VG2km0jkkePvlvlkQxmNHCrf8obd0IFSXCas0HC7qe
	MC91DBirulm1xdB0AvQtw1XS3Dip3YEffYeAQS3GT22Cq4xGENg//phnLzkQhA==
Message-ID: <c9cb204b-e079-4f5b-b670-dcce14101390@bootlin.com>
Date: Wed, 28 Jan 2026 10:22:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/8] net: dsa: microchip: Add support for
 KSZ8463 global irq
To: Jakub Kicinski <kuba@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-1-652e021aae86@bootlin.com>
 <20260127190327.79d3f154@kernel.org>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260127190327.79d3f154@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,se.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254166-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: D1E0B9EC25
X-Rspamd-Action: no action

Hi Jakub,

On 1/28/26 4:03 AM, Jakub Kicinski wrote:
> On Tue, 27 Jan 2026 10:06:43 +0100 Bastien Curutchet (Schneider
> Electric) wrote:
>>   	/* Read interrupt status register */
>> -	ret = ksz_read8(dev, kirq->reg_status, &data);
>> +	ret = ksz_read16(dev, kirq->reg_status, &data);
> 
> AI code review points out that we're potentially over-reading here for
> !ksz_is_ksz8463(kirq->dev), I'm assuming the wider read is okay for all
> chips? Is this something that'll be obvious to all readers of this code
> or should we perhaps leave a relevant comment here? (assuming you need
> to respin, not sure its worth a respin by itself)

The loop below this read only iterates over the first kirq->nirqs bits, 
so I assume a wider read is fine. I wanted to avoid adding if 
(ksz_is_ksz8463()) branches as much as possible.

Indeed, a comment wouldn't hurt here; I'll add one if I need to respin.


Best regards,
Bastien





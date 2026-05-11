Return-Path: <netdev+bounces-286587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLUNIxSsAWqdhwEAu9opvQ
	(envelope-from <netdev+bounces-286587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:14:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B150BB3C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EACEF302A185
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169863C5DBF;
	Mon, 11 May 2026 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="JXICqYXC"
X-Original-To: netdev@vger.kernel.org
Received: from ixit.cz (ixit.cz [185.100.197.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C413345CCA;
	Mon, 11 May 2026 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.100.197.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494300; cv=none; b=mTtWzlUga51LBjIn7xLb8gfd5jqtIkeQKoynvyH/6ZsUSax165TGcFi+QuhvFCLKArAusH6PZgxxLVK/HE7RiTudV2P/JdNJ0ojkXYuHCQvrRwDMRPMxg9XM9yKzNY+7NWGStzjdDe1WmDtWNA4UBFse7e3k2FbWJTWNswC1fK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494300; c=relaxed/simple;
	bh=l0vdGhOqLyVutzl2nQHDvNJoUQY+JXv11i7MQz25Ncc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=umDCaJDxwXm6fhui6ZKpeHd+3ojXRxUIUxCqDvUX3CsQRJdKtLEswB0XpHFtTRc2EqkAN2KP3xXLbAYyLT0+sdjS8DO+H2KoS7fo/QIKFI6wEmrTHjKdmesFF01x3Z4+3+D5djo/Rsu7pqAVhGkuHb16o6z8jsnYuy0DA7BcCkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=JXICqYXC; arc=none smtp.client-ip=185.100.197.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [192.168.230.16] (194-212-160-78.customers.tmcz.cz [194.212.160.78])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 56AB7534055F;
	Mon, 11 May 2026 12:11:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1778494287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FNm7lzgEeE2l+/HbF+uWAtHsdZruB7aUCVyJrgiyDsE=;
	b=JXICqYXCsgDFp/KM+qcer/8Ch5Q4YzBDidj2ABZRmorYdDxeS/4YiifUM/xWH2kmwVShvM
	KZxySczEm3ZAnTWSn2u/Hu9xG3NlDYwBzTxCGGNDFhWuSpEF3tWb6MAfMOK7UbHsnCWdzx
	/35glsB1etgKkWSfCa9ZXy4JTnzGXYE=
Message-ID: <862b37a1-a25b-49d0-902d-cbb082e2822d@ixit.cz>
Date: Mon, 11 May 2026 12:11:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: nxp-nci: i2c: restore IRQ trigger fallback
To: Luca Stefani <luca.stefani.ge1@gmail.com>, Carl Lee <carl.lee@amd.com>,
 netdev@vger.kernel.org, krzk@kernel.org, peter.shen@amd.com,
 colin.huang2@amd.com
References: <20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com>
 <824cb117-1676-4a82-b77c-8908efdffa0e@gmail.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <824cb117-1676-4a82-b77c-8908efdffa0e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 098B150BB3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ixit.cz,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ixit.cz:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286587-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,amd.com,vger.kernel.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ixit.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@ixit.cz,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 11/03/2026 12:08, Luca Stefani wrote:
> 
> On 11/03/2026 10:26, Carl Lee wrote:
>> The driver previously relied on IRQF_TRIGGER_RISING when requesting
>> the interrupt. This was removed to rely on the trigger type provided
>> by firmware.
>>
>> However, some platforms do not propagate the interrupt trigger type
>> to the IRQ descriptor, resulting in interrupts not being triggered.
>>
>> Use the trigger type provided by firmware when available and fall
>> back to the historically used rising-edge trigger otherwise.
>>
>> Signed-off-by: Carl Lee<carl.lee@amd.com>
>> ---
>>   drivers/nfc/nxp-nci/i2c.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
>> index 6a5ce8ff91f0..6339586a6a1b 100644
>> --- a/drivers/nfc/nxp-nci/i2c.c
>> +++ b/drivers/nfc/nxp-nci/i2c.c
>> @@ -268,6 +268,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
>>       struct device *dev = &client->dev;
>>       struct nxp_nci_i2c_phy *phy;
>>       int r;
>> +    unsigned long irqflags;
>>       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>>           nfc_err(&client->dev, "Need I2C_FUNC_I2C\n");
>> @@ -303,9 +304,17 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
>>       if (r < 0)
>>           return r;
>> +    /* Prefer the trigger type configured by firmware.
>> +     * Some platforms do not provide it, so fall back to the
>> +     * historically used rising-edge trigger.
>> +     */
>> +    irqflags = irq_get_trigger_type(client->irq);
> Doesn't build, needs #include <linux/irq.h>
>> +    if (!irqflags)
>> +        irqflags = IRQF_TRIGGER_RISING;
>> +
>>       r = request_threaded_irq(client->irq, NULL,
>>                    nxp_nci_i2c_irq_thread_fn,
>> -                 IRQF_ONESHOT,
>> +                 irqflags | IRQF_ONESHOT,
>>                    NXP_NCI_I2C_DRIVER_NAME, phy);
>>       if (r < 0)
>>           nfc_err(&client->dev, "Unable to register IRQ handler\n");
>>
>> ---
>> base-commit: 7109a2155340cc7b21f27e832ece6df03592f2e8
>> change-id: 20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-cda942530c60
>>
>> Best regards,
> 
> My ACPI NXP1001 table specifies ActiveHigh that properly gets translated into 
> IRQF_TRIGGER_HIGH.

Hello Luca,

I'm looking into the issue, I wonder
would make sense to provide ACPI quirk then?

David
> 
> Sadly this seems to just show the same storm as before, I played a bit with the 
> driver and noticed that it is simply broken on my device, all I get are timeouts 
> if I read the NCI device.
> 
> I could get it working (reading tags) by hacking the driver a bit, first of all 
> I disable the irq as soon as I get it, otherwise I keep getting interrupts when 
> the device is in MODE_COLD that would end up setting hard_fault to EREMOTEIO. 
> With that in place I re-implemented the enable/disable routine in 
> nxp_nci_i2c_set_mode, and that seems to be enough to make it working.

-- 
David Heidelberg



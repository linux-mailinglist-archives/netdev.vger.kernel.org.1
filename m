Return-Path: <netdev+bounces-261061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDigN8FBn2laZgQAu9opvQ
	(envelope-from <netdev+bounces-261061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:38:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AE919C5D4
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A2DF300CC24
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DFC38F93A;
	Wed, 25 Feb 2026 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI72qYpQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rxF6Tzwm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8913D903F
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044585; cv=none; b=BWOm4XYQbQ5D+fVZYBVj7ABsRnwakOKYFkgnEZ3brxOM4ffZpSF6ofRxY3nzBlb/WzyrVVFwEarMcL6/8+yt5SsuDJg90M/L41Rz+6DHwq/vwI0cEyVgjqdmZcIQhgZGoAFaH+z0Q3zokqeITOSzT6+rXkXvbRO6dJmMBuGntCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044585; c=relaxed/simple;
	bh=rI0rE+WdtgiBVn/ny5ziQMEo4RvpjxZVFcquioG7EBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YsIiC6d6SiLMgZ2r3zqb9d7Dfm9rgWpub5u8RCxe2BDdAnZRl2i84HnR7YENh/wYXqFOu19WWnBtV/PH85Qjz4qGfv8iQlePHGO4UO+rCBTel+TtY54tFZgbvmir1lAThM05gnEfnc5Cs3WbdCbLdPhmPJHIQNxiuQzjEIUHyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gI72qYpQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rxF6Tzwm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772044582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+tY4fg+xkGNuyRJT4csHPFiykQ5+c/jKnFV0DwUDgHU=;
	b=gI72qYpQT6XLSbLE+EjS3pd3EbRvCuLoBZC7fGH3UQ+JpNXq1iuQVc1ebaAjKZRuuXAOQh
	geXcwZ1ICN+zBifI2PG+4Ui8i0cPVthpZKo53GbCF3xXC6LbdcdO645iuHRScdf4W0vXDX
	rw+haBijZ6Gcms4KBkAQOYGhrfXcY6E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-mM5MfS2NPjOzxpVC7CVNIw-1; Wed, 25 Feb 2026 13:36:13 -0500
X-MC-Unique: mM5MfS2NPjOzxpVC7CVNIw-1
X-Mimecast-MFC-AGG-ID: mM5MfS2NPjOzxpVC7CVNIw_1772044572
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-483a2db68caso471365e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772044572; x=1772649372; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tY4fg+xkGNuyRJT4csHPFiykQ5+c/jKnFV0DwUDgHU=;
        b=rxF6Tzwm1UYdmjxarUVEJHl7kg7uRFUkhGOJeBaechFgu4GIRtfQJlEKOFbKhezHKY
         gzl9IMre1vcfP8V6nisG/tuj3w6fkshL8mX4MJDRd/YUO61+Nn18JLRAJpk/HT/0GzbZ
         W+ALwp8o1P5ZfMbazlCR5WokRsp0R3hkBsyenJozoJxrUSBjjbDP2CRjHCJO9VnViHMd
         4+cJ6jRCPzWZ4XSCYKNqNyA4m4CCaRqGqTnERbclU3oO4hgE8HISvzuIjnxmYwy3QdAt
         GNhEmRX4BbNzGoQW1TAx/MlHEHOX/MeyUnApGPF1+NC/VtIqj7fkj3NV3ME6idZKjvFB
         S7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044572; x=1772649372;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tY4fg+xkGNuyRJT4csHPFiykQ5+c/jKnFV0DwUDgHU=;
        b=dBy37ryp0LGLp5mIFLS5pwEphWU2E2aKZn/CBp4cGtNcSNJlhKa1M1hQ9iRkjukY0U
         Bgr6mA/kxsUbnJ0LcQ04KUS51MtVO+cmT+heZZ1+XbkTlMwZO7TLbIvTsXlUeCalN+yW
         rQeCxt9vdYdVIcQVAnw493wWdskfj9ral6z0qNidPmGaxEnF3iOGiN7HeZQ7imAZgcmT
         cifecFRouFyvNCqVTWIUP/ENcQSyMFq8RmTt6rDU8Fq6ajeH7TGn+Oke0cabXnADkX9n
         vzs8aJvkedLLKwN/wBAqSjc2g4xKxirkSrdss9cFGzdZBzOql7CiaSWrPUAfbxco4HQT
         uQxA==
X-Forwarded-Encrypted: i=1; AJvYcCV5CrWPHxbFrSU/cgc3oswybsvepXkeUAfrFOjMRUM4lboIpKL1I+oLyhPuFFiyOJOnIt5x/94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg2LUlo1My3Umd7roDm7+5s7TjFtks4JIAInv3+KUR2G+e7CcM
	qWuH5GaW3wdrb70lmaCULljY66XgjlXFtWVq66UF0jTqj1pC9d7T6Z2FAxc/j2/TfMTbPpkCfE8
	ZjOLia/NzeMIlq+ua+0fBpMxjwLcBBcU1aauSSNpY+r39Yo76ySEK8JjbfQ==
X-Gm-Gg: ATEYQzwNyGhP2njCb5RG5JuwgpKmHmMlb5jWcx0C+4wTgzjxczGyNo6fWJqwqlESnWY
	RtzcNYs1Es4d9TqaRkpSyXeL97UKEHgKogcSeSZCjK0BIOan8u2/6VrSanvvSJHVoBX/W4HZ/2t
	QSih3DxdIjiP2CkkdkzJD6tXTlXd0ohfbSE9t+BQ1L2vxak51s6rfkm2jDWM+zMtjjXvboBBajy
	wKep5DF6eDVe/5Ef4uMoYEJ8ATg4CqkG+KBhXWlX6zyuneICJj/1bBLftLdejwokNhl3TM1GYLT
	fA34yZUoHuEAjcfT+MLiueMAiwAOQmzaKRB3Z6qichOPtrMME8xDw6iecIjl+UHvGh8kYJ70q0k
	rQlfG8A619JQUVkhJiRCVtagnj7mxS6T5ZuliBhJ+ll1mheAvUObCW284Z8U=
X-Received: by 2002:a05:600c:5486:b0:483:709e:f239 with SMTP id 5b1f17b1804b1-483a95dea69mr269419325e9.22.1772044572077;
        Wed, 25 Feb 2026 10:36:12 -0800 (PST)
X-Received: by 2002:a05:600c:5486:b0:483:709e:f239 with SMTP id 5b1f17b1804b1-483a95dea69mr269418865e9.22.1772044571569;
        Wed, 25 Feb 2026 10:36:11 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd733706sm82693095e9.13.2026.02.25.10.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:36:11 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com,
 edumazet@google.com, pabeni@redhat.com, theo.lebrun@bootlin.com,
 netdev@vger.kernel.org, lorenzo@kernel.org, andrew+netdev@lunn.ch
Subject: Re: [net-next,v2,7/8] net: macb: make tx path skb agnostic
In-Reply-To: <20260224000900.140571-1-kuba@kernel.org>
References: <20260223182632.1681809-8-pvalerio@redhat.com>
 <20260224000900.140571-1-kuba@kernel.org>
Date: Wed, 25 Feb 2026 19:36:10 +0100
Message-ID: <877bs0n011.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261061-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 48AE919C5D4
X-Rspamd-Action: no action

On 23 Feb 2026 at 04:09:00 PM, Jakub Kicinski <kuba@kernel.org> wrote:

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: macb: make tx path skb agnostic
>
> This commit renames the skb member of macb_tx_buff to ptr and introduces
> macb_tx_buff_type to identify the buffer type. This is preparatory work
> for XDP transmit support.
>
>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
>> index 4e3cc0e9ea87..67fef88af2c6 100644
>> --- a/drivers/net/ethernet/cadence/macb.h
>> +++ b/drivers/net/ethernet/cadence/macb.h
>
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> index f65f976123fd..50646ee90672 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>
> [ ... ]
>
>> @@ -1204,7 +1205,9 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
>>  		/* Process all buffers of the current transmitted frame */
>>  		for (;; tail++) {
>>  			tx_buff = macb_tx_buff(queue, tail);
>> -			skb = tx_buff->skb;
>> +
>> +			if (tx_buff->type == MACB_TYPE_SKB)
>> +				skb = tx_buff->ptr;
>>
>>  			/* First, update TX stats if needed */
>>  			if (skb) {
>
> In macb_tx_complete(), the local variable skb is declared without
> initialization at the start of the outer for loop. The patch changes the
> unconditional assignment to a conditional one based on tx_buff->type.
>
> When tx_buff->type is not MACB_TYPE_SKB, skb remains uninitialized with
> whatever garbage value was on the stack. The subsequent "if (skb)" check
> will likely evaluate as true on this garbage pointer, causing dereferences
> of skb->len, skb->data, and skb_shinfo(skb) on invalid memory.
>
> This could lead to a crash or memory corruption. Should skb be initialized
> to NULL at declaration?
>

The branch on MACB_TYPE_SKB is a bit redundant, so I guess we
can either remove that or initialize skb at declaration to improve
clarity. There should be no potential NULL dereference anyways
(for the note below).

Next patch initializes the local variable and should be fine as well.

> Note: While all buffers are MACB_TYPE_SKB in this commit, the commit message
> states this is the "last preparatory step for xdp xmit support," suggesting
> the next commit will introduce non-SKB buffer types that would trigger this
> issue.



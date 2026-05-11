Return-Path: <netdev+bounces-286873-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDHrGVhtAmqosgEAu9opvQ
	(envelope-from <netdev+bounces-286873-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:59:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A794517AC0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94A5D3010F0D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3B636A36C;
	Mon, 11 May 2026 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkUImqkp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD0364E81
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543711; cv=none; b=ia9jKRoaXorTPLFjvUHdFurGs8opHyNB8r/rFTwtgRkhCXDNel+4lqPZb36/chKPgLFenYSmIgdETAR5VEpBTOK3rkZv1yn4JKsitj4j7GLekjtJO9Iu4jRvso0R4XqjBBaJ7PphzmgzbrLtSQbffd0vZBLViZjhDBTn04tJy+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543711; c=relaxed/simple;
	bh=c5c6VJYFxr4gXyMsdf0CD90gzBTH/ae8/+dU8nI90Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J15X9Dk6ycGQXIAcqHPNKzaMuvTqSuJlamuJrIGv5j9R31/CjD7BQLsdG6FbxNAh7vkmWZOpmyBQ+/wzzuEKOaLrUqD0qqAjQhFlJxovu8EjZGIZlM+4EpCwxR3I6D93e0XwiXlk1Ryr95pgFKQQgigHeHn+oQZeLY3998krF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkUImqkp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b4000e51fdso49542686d6.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778543708; x=1779148508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVKiv42ea4PUaZatWHgrj9fNebioiFzvGiQqzihY2NE=;
        b=QkUImqkpSBJd2ai15eRu22u66AYK7cOY/6QqFNJLiwuwet5Sqcv/wEFz6+KD+U9kyp
         Fra9WlqQYnkwmhOUQ4toh1OqxmstDmQERqyt2MBcLNSuEB0ENr+nWE/csrx8e+8ptW+K
         mmJfDMaiaRxe8IatqdCpHed2JLdr8c2WGLga27fzMcwZUqmphiOwSSzSsgbMP5rcMJ4O
         5O9WGMsI2pOjlHhMJ/kQoUb28oYylwrtkdqCesVEbfdTFICdM0/9jHQmKbpbhmbEKvol
         7ps9/N8oourt04XLQUIQ1F1WQCVyhjqC+FIf2mmsUEJa1tEPk6LHHpZ1/SUVUrIUn3XW
         /iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543708; x=1779148508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVKiv42ea4PUaZatWHgrj9fNebioiFzvGiQqzihY2NE=;
        b=kqEdoWwQ4ToDDT8QgRhYYkAjiyvVWaHiDxju38tNVfRKjLIuQI6d2VRWbegW7vfdmT
         69iRdtkdHTI+jl1p+4jHdgXoCCP87eltzlCXrMWRU2O3hMlHVFAnNQWFTWbbQoD/21q4
         Y31IeRb3n/Nj83tSprL2VONeCFgA17YFPIpoV2zTF7PkcGXJy1RCijYIYqT/qIL7Fnix
         VVQi9G72ZnKAqoU464mEM7HiHa2GRctrcrlBTzYY0dT/eVfT+tefjXgTy7wq2WRYCRFw
         A3byksDBfs5zjXXo7+J5IA7dOF5AZoiZiCCqn+PmQVpQWk3AbpGW/B/hk+s8Y7bUhuRO
         EuUA==
X-Gm-Message-State: AOJu0YzvzIHKd7g5ADAfSWOX4xWYtJjM8qqBUuUXkciEGVvloI8i/cM0
	4H8CY2XE9ygbf0VJuL5jtViciJXm4K1CjDRZHstX88WN7jsjP42/CTBq
X-Gm-Gg: Acq92OGfVi0UcW//49HZ46UCX0hObMp9Em1h3Lif/pPmHk85appW/fhuxdGsYQ+J7QN
	qcczKrcr5U6m0FuYltvnqR1aYbgcX2pzQY+vCmxdlbeSkJ3IlgzvxJHcVdFOD/xonbW6qQZ8J5N
	vCUHxiQBAUTNSw66fkSy3A5HXFTVq3tLhjhjS+1xsoXO8svznB9jTFGkrZeITSGVOQvUIG7Ne9M
	fNdHUtgTawdMeDR1NfeSimqo+NOm3/lmoHphzzlOibDXvGcjkYsJUHl5p3xXwz0IBDdktlPRNxs
	PjWKlx8vGbKXxynfsBWAf5sZRLcpHTGqfpAIPYDFKUrLDrdRfRuhxUjkeoWA55T7mCdsfG81PkL
	bAJycFHZA8jgci9MHdqd6zexClmQW9YhlGl1YdkrB31oM8YSVuDuDnmTP8HrVh1UwYp5VdNB5y6
	j0E/QZ23aoSu+YzsDY888gqU6yissRsJaadoGy5IC9wc0wChcNZvdEC0cstyKfbG0iyH+U4A==
X-Received: by 2002:a05:6214:810a:b0:8ac:732b:6cf1 with SMTP id 6a1803df08f44-8c1a824b04fmr165374996d6.24.1778543707652;
        Mon, 11 May 2026 16:55:07 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11d1::1011? ([2620:10d:c091:400::5:9448])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf39c7e032sm108169106d6.32.2026.05.11.16.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 16:55:07 -0700 (PDT)
Message-ID: <08750de2-77d4-44c1-b16a-33603c3100dc@gmail.com>
Date: Mon, 11 May 2026 19:55:05 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] netdevsim: psp: implement kdf from psp spec
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-4-4b50ed09b794@gmail.com>
 <willemdebruijn.kernel.36d2fcc3d2e74@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <willemdebruijn.kernel.36d2fcc3d2e74@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A794517AC0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286873-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 5/11/26 3:49 PM, Willem de Bruijn wrote:
> Daniel Zahka wrote:
>> Implement the PSP key derivation function (KDF) per the PSP
>> Architecture Spec.
>>
>> The kdf is used to generate spi + session key pairs, and will also be
> Text is a bit ambiguous here: the kdf does not generate the spi. It
> derives a session key from the master key and spi.
>
>> used in the rx path to re-derive the tx key used by the peer.
>>
>> Also, remove support for psd->generation, as it is not needed for
>> netdevsim after removing the fake authentication hack.
> Is psd->generation only used inside driver code, not by the core PSP
> stack? Else it should be set to !!(ns->psp.spi & PSP_SPI_KEY_PHASE) on
> key rotation. If only used by the driver, no need to reset it on each
> rotation.


Core tries to 'suggest' a generation to the driver, which is the last 
generation + 1, before calling into key_rotate(), but this won't work 
for netdevsim. I could set the generation to !!(ns->psp.spi & 
PSP_SPI_KEY_PHASE) so that it aliases the device key selection bit, but 
I think this is basically the same as just setting it to 0. This series 
makes the generation field dead code in core. The old netdevsim 
implementation relied on it to do its fake authentication hack, but that 
is removed with this series. The only real hw implementation we have, 
mlx5, does not support device key generations. Maybe we need to just 
remove that until a real driver comes along as a user.


>> Assisted-by: Claude:claude-opus-4.6
>> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
>>   enum skb_drop_reason
>>   nsim_psp_handle_tx(struct sk_buff *skb, struct netdevsim *ns)
>>   {
>> @@ -155,7 +189,7 @@ nsim_rx_spi_alloc(struct psp_dev *psd, u32 version,
>>   		  struct netlink_ext_ack *extack)
>>   {
>>   	struct netdevsim *ns = psd->drv_priv;
>> -	int i;
>> +	unsigned int phase;
>>   
>>   	if ((ns->psp.spi ^ (ns->psp.spi + 1)) & PSP_SPI_KEY_PHASE) {
>>   		NL_SET_ERR_MSG(extack, "SPI space exhausted");
>> @@ -163,9 +197,11 @@ nsim_rx_spi_alloc(struct psp_dev *psd, u32 version,
>>   	}
>>   
>>   	assoc->spi = cpu_to_be32(++ns->psp.spi);
>> -	assoc->key[0] = psd->generation;
>> -	for (i = 1; i < PSP_MAX_KEY; i++)
>> -		assoc->key[i] = ns->psp.spi + i;
>> +	phase = !!(ns->psp.spi & PSP_SPI_KEY_PHASE);
>> +
>> +	/* dev_keys_lock not needed because of psd->lock */
> Can you elaborate a bit?
>
> Is dev_keys_lock only used to synchronize the writers, then? Which after
> device init would only be concurrent invocations of nsim_key_rotate. But
> that operation correctly also holds the device lock using
> psp_device_get_locked.


This is an error in splitting changes in the series on my part. The 
spinlock is used to synchronize the writer with the reader running the 
kdf in the napi_poll() path in the later aes-gcm commit. I should have 
added the spinlock stuff when that reader was introduced. The comment is 
just pointing out that all of the psp_dev_ops on a psd are serialized 
with the psd->lock. I'll fix that in the respin.



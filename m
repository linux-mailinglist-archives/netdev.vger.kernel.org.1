Return-Path: <netdev+bounces-274221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JzIGmxozWkkdQYAu9opvQ
	(envelope-from <netdev+bounces-274221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:48:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B8137F66F
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D76C300B982
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1E217F33;
	Wed,  1 Apr 2026 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HMXDrO+w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492118B0F
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069289; cv=none; b=dayWaPWCCBSJ+nsm7c8S8xxNVpIfRuMSFW/u9FecGAVAK3HkhaNH88VoR2pikjUOpfHuX83F6XoWSmMSOyg9j9Bi0PY4OieiVKwy6gPkAZWNJvfzdTCNeMUvwCp/x0O/eAfI4s4z4BOwbLPamjtibJpPQU+TisiAdMrnOuQkgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069289; c=relaxed/simple;
	bh=FOKUEB/UffH6n3Iz4odn5fkse2jUqaaOj2TMTFQxhF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWixdywTJnpoehZ/4Z1LTVWcsLZKUTcw+J/zp8WqNKCtISvX8bEzOsmLWmChUB6OeZtQ4bOEPLrsq7RD4PBa5XL8XTdJGfALFmQgNNEmxjMobGofjhSbEwuL6ZNA3UhlVDtT3kJRYWHB4hgewiMN0vNlZFRoMe+TWrvxsGfIdLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HMXDrO+w; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8cfc40e4158so11192285a.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 11:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775069287; x=1775674087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TneTP9hDRGxLGxhs1oY99LxNo+1xfildjhP6YX411o=;
        b=lZwSqQL0ev7EVgqeGLylGcbaTAoTAtLayz0clyxhvCyUQJn2HuOiphkiqRHd8U8qIf
         QY6H1wIVsL/c3DYrDXd9Rhp5zKavr0lPCXToEySxPYzgesQsa5LWZxyi0vjEaRGK2bbL
         CqAVoEJU1tA84JRgX281FwMUmTzKLERF2/ULgl48eheoZ2MCiNJp+Pb8EiMzxZPypytU
         OeW4cpgqvqTS2ghtl6VAS5ixuxhwfyJl+kFf+jgEuo8xIxQzjQFxt9VNMgHBCjNoqgOG
         +h80Qc76YNx2J0g81CRVsoMquC9tsyj/VqCpMDLu6cAmDDN9kQ1HBYz4LuTqMatfm6hH
         NoNg==
X-Gm-Message-State: AOJu0YxuAtiu8o7FCojFCC6BcCn9c9aeNs/Kllv+0oF8jSUAd+AL3dj3
	6Cu1gJIGN34adGWXjGqnvkNEIQIWa/QONUKqy3bi9xw0ivDV/n3lZpvm2UFwPx1rcZzwpFZGSvY
	ImL3zBvPniuq3xzsmM7TzAtgd91l5azb5jJ24lJdhr/tcOCeKPuJHCWSDA86U9Qg00AKS/kNjpm
	dh9KbgUVtyRmgwh/zFQr9RKfLAjzWfmUxN5+eVtoUHC/8BcX3sdft/j8uE9CKRh/uxBmRtEEDb9
	21mH7/Iiw==
X-Gm-Gg: ATEYQzw1v6g3gIK8hUdJAdCOWMznP70JpsFU3Kkgg/0PchfjZ8e3gsrzLpxX22B09Vu
	HNvBwmA/Bkh2LTUwSzsoFhISDHJS7lafplHVHuqo6SHhw1DLPpfxHDrBJ+Cx76QvaAx7iwP/muD
	VJAIlgb1hmnokH6SO05Yuf9BrK6JzLM/hFkG4lmNOkxozT/yKXJuMzx5uA8R64nOZDBrdvZmLP3
	uABwNxeVLaPJpqocELIy3zBgBTWkjtiad+no88r+KPJqiRY3zQAem4K/t0cQWxRskCnd7TAEOak
	tQBvNWUBFRPkIS4UBHSyoHHl0qiABrS34yFQdQ9oyC6iMieQwxmRAayjwb2GNIbT900zI1RLYg0
	8uBr8bTk8IplyALYcck4CLmicVMLAqOJGYScPrI06ZS36DxClwcpxvrJ8P4RX/Z6HzBKdj18T6u
	apidQ=
X-Received: by 2002:a05:6214:3306:b0:89c:5ab0:858d with SMTP id 6a1803df08f44-8a43b31f2e5mr76569286d6.58.1775069287111;
        Wed, 01 Apr 2026 11:48:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8a5932383ddsm427966d6.6.2026.04.01.11.48.06
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2026 11:48:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd722c1a69so29260285a.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775069286; x=1775674086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TneTP9hDRGxLGxhs1oY99LxNo+1xfildjhP6YX411o=;
        b=HMXDrO+wFaD7nTRuWcgSdF+kO/ywJqLfod+0EBA9JCqf0ltYfdezbLR7ClmdjUeAKL
         UP5p5DFv1hHMu8pONb72v6wt1rXM0D3DQ6VrEOT7l/35BpG99ft0hOQuIpShxLo+2lt2
         ZJhVP8WhEKXi545NeQVYClv7Ef8GonU1mqFZk=
X-Received: by 2002:a05:620a:7116:b0:8cf:cfdf:733e with SMTP id af79cd13be357-8d1b5bc2af0mr646362085a.32.1775069285907;
        Wed, 01 Apr 2026 11:48:05 -0700 (PDT)
X-Received: by 2002:a05:620a:7116:b0:8cf:cfdf:733e with SMTP id af79cd13be357-8d1b5bc2af0mr646359285a.32.1775069285391;
        Wed, 01 Apr 2026 11:48:05 -0700 (PDT)
Received: from [10.69.75.227] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5f47b3bsm40194585a.20.2026.04.01.11.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 11:48:05 -0700 (PDT)
Message-ID: <342750cc-d5b1-4446-a974-9feea4969f17@broadcom.com>
Date: Wed, 1 Apr 2026 11:48:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 4/4] net: bcmgenet: relax the xmit ring full case
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 opendmb@gmail.com
References: <20260401003840.3112454-1-justin.chen@broadcom.com>
 <20260401003840.3112454-5-justin.chen@broadcom.com>
 <71b87f5416d6d6d41396b5008702ccac@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <71b87f5416d6d6d41396b5008702ccac@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-274221-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D2B8137F66F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/26 12:47 AM, Nicolai Buchwitz wrote:
> On 1.4.2026 02:38, Justin Chen wrote:
>> We have a queue size of 32. If a packet is multiple fragments we can
>> run through this queue really quickly. Currently we stop the xmit
>> queue at SKB_FRAG_SIZE which by default can take up half the queue.
>> Instead lets just look at the incoming packet and freeze the queue
>> if the incoming packet has more fragments than free_bds. This will
>> relieve some of the queue timeouts we have been seeing.
>>
>> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
>> ---
>>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/ 
>> net/ethernet/broadcom/genet/bcmgenet.c
>> index 54f71b1e85fc..a1aa1278842e 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> @@ -2018,10 +2018,10 @@ static int bcmgenet_tx_poll(struct napi_struct 
>> *napi, int budget)
>>
>>      spin_lock(&ring->lock);
>>      work_done = __bcmgenet_tx_reclaim(ring->priv->dev, ring);
>> -    if (ring->free_bds > (MAX_SKB_FRAGS + 1)) {
>> -        txq = netdev_get_tx_queue(ring->priv->dev, ring->index);
>> +    txq = netdev_get_tx_queue(ring->priv->dev, ring->index);
>> +    if (netif_tx_queue_stopped(txq))
>>          netif_tx_wake_queue(txq);
>> -    }
>> +
>>      spin_unlock(&ring->lock);
>>
>>      if (work_done == 0) {
>> @@ -2224,9 +2224,6 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff 
>> *skb, struct net_device *dev)
>>
>>      netdev_tx_sent_queue(txq, GENET_CB(skb)->bytes_sent);
>>
>> -    if (ring->free_bds <= (MAX_SKB_FRAGS + 1))
>> -        netif_tx_stop_queue(txq);
>> -
> 
> With this removed, the only queue stop is the NETDEV_TX_BUSY path at
> entry. That means every ring-full hits BUSY and requeues rather than
> stopping proactively on the previous transmit.
> 
> Would it work to keep the proactive stop but base it on the actual
> packet size instead of MAX_SKB_FRAGS?
> 
>      if (ring->free_bds <= (nr_frags + 1))
>          netif_tx_stop_queue(txq);
> 
> That avoids reserving half the ring for the worst case while still
> preventing BUSY from becoming the normal path.
> 
>>      if (!netdev_xmit_more() || netif_xmit_stopped(txq))
>>          /* Packets are ready, update producer index */
>>          bcmgenet_tdma_ring_writel(priv, ring->index,
> 
> This wakes unconditionally even if only 1 BD was reclaimed. Combined
> with the above, it can create a tight stop/wake/BUSY thrash when the
> ring is near-full.
> 

That is fair. Let me drop this patch entirely. Seems like we are trading 
one problem for another problem. Maybe removing the priority queues 
entirely is the way to go. I will wait for the XDP patches to be applied 
first to avoid conflicts.

Thanks,
Justin

> Thanks
> 
> Nicolai



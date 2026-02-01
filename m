Return-Path: <netdev+bounces-255682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OPRGlzSf2lLyAIAu9opvQ
	(envelope-from <netdev+bounces-255682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 23:23:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFB9C75D9
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 23:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 654F93000FF9
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 22:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458052EBB86;
	Sun,  1 Feb 2026 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ir+QPGqt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3832D595D
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769984602; cv=none; b=P5i9gYcKRxlDVvE/oNfvQwP+6Uhc7cY74XH4m4QdPzFpoqvabNbAR/mvubueFDfEJuBCnTNjQP1ZPTI9YmtNHlrt2wIpWfgNBfoikguA90tsiwG7fgg/LD9oTV+KsXudXUqZdP8WAUSu3Uf2feNbtT+cWkF7nhFC1ZZ95A3Jo84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769984602; c=relaxed/simple;
	bh=0vohZDdn+2gjzL0EZoKOGCHLzqKq/PvaR476DJwbQQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX7LWRcI++a7yK8LFGlxPU+uv6a/RUewWOib3UvxzjFvdjcBu8rv4KmU//QnSXJBpzaWQEOe3RTJhlvIQWmfnY1QXwG+GgkkSirU0HDYDWsB2RgF9iVukab1ESOHs7iz1ZhU5TGWl1uK3qYHvKX71zXs1rhALALqX3kGOOYrCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ir+QPGqt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a8fba3f769so4647055ad.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 14:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1769984600; x=1770589400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idvi5OfakJy/H3dbVsXRcowQ0slCnw6CmVCHkgylru4=;
        b=ir+QPGqtOEBYbOs+usNNQrVfIOjniIW6pmPa1drPMbXbTbqbE0oYrF5yCRIZrOwSFN
         MvS7P8+/tiKgYXHm4xP2s1qltC2E4SyspcBW8Lf87/jiU+ztyLcbT2jM+PC08B/smxEE
         lvUQqa8ju2W7H6IRoWTMWP0M70ikoo+18P9UZ+kxTNU27woNqifSjd6PPJb9bOaR0g63
         Z3v5M2XkgbCvcd4pzGkLMTJkTT9c+6HtHemZHeYm6RL8dGixVwGhCY6yXmY6tMa2f4Vw
         5FmKbpuAK2OpCea77wW0h9vF28nOlIJtiOa0BB8dn42E8hqMNd47LuV8eIXvhfyLzBeq
         Lsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769984600; x=1770589400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idvi5OfakJy/H3dbVsXRcowQ0slCnw6CmVCHkgylru4=;
        b=tR6Gywe3zxGPtYy/XxItx9xrp2Qcll0/4YmXJHmeTjy+3w+B79D7htA34zfSQYAke7
         zEqHvMFFkc0R3R21pDx75c5DCwUL4a/Jy4yq2sesW7QpX2H6cdpl8QeB4iuGtuW11wHh
         m1nWqwBY9gIYKPLIPjSvNsFn9eNAJMx5KgKeD+hVcRZ+33oTNBtRj1eBNqw9Ddj5j1Lt
         OqhezUmRhbDxXxW9f5H10+6hhybO8UedYDvtCYz+VqYsxxOE2pztob4HstsI9ke5SK9T
         yP9qbQRX/uTfaPF6PT4ipMGjh+THoeFaSKB5t/Qq5z9tEYYxpno1TAAZLEuh8/T4mTQv
         oM/Q==
X-Gm-Message-State: AOJu0YxchOUCS1O6xRlssiF8LDKn/aTgajlC2z7+AjeT1rW/JNkzYyg6
	Iv7Mp5N3q59BapSM8BzhwhIO3Y1uBFSD59wm0wz7wQij1TXiGIfVf4TTzBYZqOu39JQ=
X-Gm-Gg: AZuq6aLCbuZ599DiAXRWPXKnUHXfbxBPup9+UTMa2lFd+OfEiiphGXebC2DuwfixNrl
	wP9QKSFLhMlHlleN63ALdUNqSYl1L1mE1W32p3vAwucac0s4diZq9QGbo7XaakKjDv6RdCPMcJ2
	RSR9jhc/Ng/XAPD9VdYx9oTXKEgpiY9mqsKNa3FIrU5ehsv0IczHJxf9NtWNJdKvNNVB79b/6rq
	4twYBlsAgbA608WFtH6ThKPtyTQxNC1SrFWOQjCkZ7qIqGPm9TeNY+hRNKNgw9gMdwkZTffs2tA
	TDBaZJdgUYJhCjV7Lt6rr+jRMUn4a4mtOW4xc8gmYDeW+JHatW4fy391Tv3kOdfi6Y81F8cLW7u
	9kGtmk7DARHQUgsuQ+LU8QjpE8jNtYRvTHxR8/88fVJ0xxQwMWxcoyZ/Dj2+RqOobQ4r44RVjYV
	TmgoWpNDVGuh6E3Cg6IyjPChML6XytOFxBIBdrDG11rYLUO3Eje9SEykdd0u7URf0kNNUVFwz9K
	z+nfaDmVSy2AIAhpA==
X-Received: by 2002:a17:903:124a:b0:2a9:db7:446e with SMTP id d9443c01a7336-2a90db74726mr19116715ad.45.1769984600381;
        Sun, 01 Feb 2026 14:23:20 -0800 (PST)
Received: from [192.168.100.174] (p94025-ipoefx.ipoe.ocn.ne.jp. [153.246.129.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d92a9sm124143805ad.69.2026.02.01.14.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 14:23:20 -0800 (PST)
Message-ID: <01509510-1248-468b-ad6c-50ab61d4a916@davidwei.uk>
Date: Mon, 2 Feb 2026 07:23:14 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 07/16] net: Proxy netdev_queue_get_dma_dev for
 leased queues
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260129222830.439687-1-daniel@iogearbox.net>
 <20260129222830.439687-8-daniel@iogearbox.net>
 <20260131160445.2e49e9d3@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260131160445.2e49e9d3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-255682-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFFB9C75D9
X-Rspamd-Action: no action

On 2026-02-01 09:04, Jakub Kicinski wrote:
> On Thu, 29 Jan 2026 23:28:21 +0100 Daniel Borkmann wrote:
>> - * Get dma device for zero-copy operations to be used for this queue.
>> + * Get dma device for zero-copy operations to be used for this queue. If the
>> + * queue is leased to a physical queue, we retrieve the latter's dma device.
>>    * When such device is not available or valid, the function will return NULL.
>>    *
>>    * Return: Device or NULL on error
>>    */
>>   struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
>>   {
>> -	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
>> +	const struct netdev_queue_mgmt_ops *queue_ops;
>>   	struct device *dma_dev;
>>   
>> +	if (idx < dev->real_num_rx_queues) {
>> +		struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, idx);
>> +
>> +		if (rxq->lease) {
>> +			rxq = rxq->lease;
>> +			dev = rxq->dev;
>> +			idx = get_netdev_rx_queue_index(rxq);
>> +		}
>> +	}
>> +
>> +	queue_ops = dev->queue_mgmt_ops;
> 
> We're gonna call physical device's op without locking it no?

Yeah, sorry about that. I'll change this to be similar to the new
mp_open.


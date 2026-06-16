Return-Path: <netdev+bounces-299879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id REBRCgliMWphiQUAu9opvQ
	(envelope-from <netdev+bounces-299879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:47:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A18690A86
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:47:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Nm0opJEK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299879-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299879-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A60730A19B9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6965139281D;
	Tue, 16 Jun 2026 14:43:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377837C91F
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:43:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621036; cv=none; b=LqQYnVcvuYmO+Zj4iTSLZGbuKRLPGBb2PX1H507EjlEq0zgI3ZPAWYnr7YM8IHCZjRI/psc3y/ngIyYmJOoXH2Y4FKc+6FiYqqGfXAz8KQdLKkkhwj2Eq1IP5OY50rgUakiPqHdBW/YE/5mc0Y7FqGht1q8iKVqH19+LtUUu5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621036; c=relaxed/simple;
	bh=1lvL5cDlAGzUVesMPoNtNmQEcI6fyKiPZjT5VrpViug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUSBDK1tqigYNmOsGPCwc6aGuDnztSioPoHDrxRbEAztrxc3VS4WAcegzl2C1SpAGIdot5AfBvO1m91FA4jLb4i5+ESbabNff9J8l8KtOLLWNPbqNO6hh6GolTYkxJJVZcGqan6NeTcZEEZQVp+KZUmcceHxaNQHbIzYNHBxxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nm0opJEK; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423f236418so2547040b3a.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781621034; x=1782225834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkd9lKRyopVrugwMVot3B/HiKXmkebEFxISTfLV9UhQ=;
        b=Nm0opJEKdGtiVHaJ83XZzlDwII1kjfhTqGP+yS8blcJ9gtQkhD7G+ak7rZ92N8vFAN
         9tmvLeQ1EOxQzQlos04V31LTkyKahINA9P9N59JgzpJbTXOo+fKrncJ/RsoaaMS0pqLV
         R07I0q6lB9nbWH826AlhQs2eIZJ7AgseJ/Afc3S+aqzHob84bH0mIoBg0wGRB1Pie0kb
         bxyRKqhPFY/SVX86ZGTOvBlmp7uP4SEnO3dLejgwglXXlxVgqoqPCWJhvC8AUFfGq3H4
         nB2E7+QsTQSjA78JBoN01JeyY8jFxYJMzIhfMKSyb4MrQ5qvCOEQ9eFZ9oi7QxW0a2W5
         BCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781621034; x=1782225834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkd9lKRyopVrugwMVot3B/HiKXmkebEFxISTfLV9UhQ=;
        b=PV59zE/3E0+JLMxi/gRLEUjGC+6DWbQ85o1BjWy7DD+XVdERcNhA7ZGUi5rAqA9Wj/
         3xqw/9ucR1YOiN2HOMWpszfXgiL1pwW0znvCmySZao5A3TzxTPeqb+P4ec1+7Jws/6Pq
         47Wgh8Cq+C2OpBdw2VHB7hn7yl2L+Ek4pUAsE4q2e3fuhbaWxerC5UV3HDmlW7wgx+Dx
         FlSYOuCH8c+sThHR0+4Dd71lQz9UXr/hLYhiLMI1fkJYc9cPYLn371miedgUVkFOUlfx
         YBgFho46C8088QW0FuhKQNkIYzukly67wepjNE9xuVzYBBbU8vDr9FR/3+SwQ55qHzLh
         uq2g==
X-Forwarded-Encrypted: i=1; AFNElJ+dOzq8ogWiLliykiYNjKQS9tSZ05PA6Te2UljKcd0jmt4BhNrbUgWcPJSu9NaRIcidytFOWB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2b3ICejIT6vJtfiUu52XsmbTWfBT92rTEoiLiI4WAVi96m2Nv
	nowJVI9iMdYzF6AJlXeXoGhWkVHsjXhHjVRMXv0SbZ3wF0x9LuOWdLij
X-Gm-Gg: Acq92OExFxn7lbKCcmfoIe74yV5jEFtKpnMvq5EEF8hGB3sARjtaC+IuRC9n7ROsLHd
	LiK0me0edZ/yNNtY9F/PR/snpjQ8304rWEUn24jgr/X+7xCB2PlLRZPQnhIOYsoXrrQFNu+dEnt
	ORjDFpcKl6P7eh7iTeDTjrR6oXkGV1t9MucsYXfE7oDtcCPU64z8Opr2/MCO4lBiwwe5ly79Ufe
	3ThS/sWy6J2h27aWg1JOs47UoU4AJ+YxWS/fPET9HBudVImsNiNZ5bwojb+k2P9bUPSETAQwSjp
	X5SX1UkHvkUKN/080bH9U5GkWyzZvqr6cyZgQ4HLUGF55YGfzPCTXrIUSL5WIrNTF8e9Ua3g8Wt
	OJL4nTW0jvqRBPC8DlEZpLXV+VVrtsvdm025zp4++w5umaw1Qm90gUgaxIp3dLLRQ1vlz4jxdaM
	T+At08ju0kPYP8+PWCcZg+Gzix/vQlaAOhMxFBsLwqZ70VHskZEdsivS/Kcmli3bvYgX0W+nsS5
	AcvCg==
X-Received: by 2002:a05:6a00:23cc:b0:835:3f51:730e with SMTP id d2e1a72fcca58-845153054c0mr4211420b3a.13.1781621034323;
        Tue, 16 Jun 2026 07:43:54 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0c:3090:6fa0:dfe4:1cab:bb2a? ([2001:ee0:4f0c:3090:6fa0:dfe4:1cab:bb2a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b00d4c7sm13288270b3a.40.2026.06.16.07.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 07:43:53 -0700 (PDT)
Message-ID: <01d04d25-9f6c-4a3e-9292-4f6e26ab2031@gmail.com>
Date: Tue, 16 Jun 2026 21:43:46 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] virtio-net: fix len check in receive_big()
To: Xiang Mei <xmei5@asu.edu>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 bestswngs@gmail.com, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com
References: <20260616042837.2249468-1-xmei5@asu.edu>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260616042837.2249468-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299879-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[minhquangbui99@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,gmail.com,linux.alibaba.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhquangbui99@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79A18690A86

On 6/16/26 11:28, Xiang Mei wrote:
> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len == 12 case.
>
> A malicious virtio backend can announce a len in that gap.  page_to_skb()
> then walks one frag past the page chain, storing a NULL page->private
> into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> write past the static frag array and a NULL frag handed up the rx path.
>
> Bound len by the size add_recvbuf_big() actually advertised.
>
> Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")

I think we should Cc: stable@vger.kernel.org

> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4: use easy to understand math to compute the max_len
> v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
> v2: add additiona check as 2/2
>
>   drivers/net/virtio_net.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..8f4562316aaa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,16 @@ static struct sk_buff *receive_big(struct net_device *dev,
>   				   struct virtnet_rq_stats *stats)
>   {
>   	struct page *page = buf;
> +	unsigned long max_len = (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE -
> +				sizeof(struct padded_vnet_hdr) + vi->hdr_len;
>   	struct sk_buff *skb;
>   
>   	/* Make sure that len does not exceed the size allocated in
>   	 * add_recvbuf_big.
>   	 */
> -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +	if (unlikely(len > max_len)) {
>   		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> -			 dev->name, len,
> -			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +			 dev->name, len, max_len);
>   		goto err;
>   	}
>   

Reviewed-by: Bui Quang Minh <minhquangbui99@gmail.com>

Thanks,
Quang Minh.



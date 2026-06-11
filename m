Return-Path: <netdev+bounces-298108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JZE4KG6nKmrUuQMAu9opvQ
	(envelope-from <netdev+bounces-298108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:17:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C30671C02
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:17:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="MLI4Pf+/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298108-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298108-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27E2E303F04A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490EE3019C8;
	Thu, 11 Jun 2026 12:17:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65731D74B
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:17:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180245; cv=none; b=KUdO6zTIIrV/PpDutvBXzt9HivTQNDN2pqm8OnKjDAnQTb1Wfyq+C39LXJdTwsHjFHxTtL1wrLo4ZeBDm67Kg8zbHJfVMDCWxc/nYiYC34aplNtmnP4NokrAnZAnchjx/ChunhqExLIkCap5l4Tgn7lLEYC3bow5RafoYwoCQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180245; c=relaxed/simple;
	bh=rgVYSbR9nGU825Ny5DIQRKXtJgO2UBjS+6c1oxdgHEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSzpo9e9axc0opA4HVbJHB8YF/pzA1Xvl9hyNg+CyWS9+Ba0DpLEsUd9dSak13Ht8k07kY7o1dOIQ5tS+dAHHdGtp3VDLSftgL6x53zj6NsLt5b8aV6nazgp1YoBl3M3pTw7KWTUMbdTO6QlzEh/MlbS5WCzyXoLQD4juAQc6pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLI4Pf+/; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b8d414666so4419149a91.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781180243; x=1781785043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKVTpr4aNyZx4lSh79VinADzKQEIbf4Ts/2xtaUoVwc=;
        b=MLI4Pf+/Fcbnmfr4ssc1QksgYABd3MMy4k4UjenxEnL18e7h5XGBBvIgroSZQLyel4
         QHbWXFigntayJpgq/OhKIJFUPhI7QI9vsimJx/2L/xmXbmoZ9yE8Ymn62k/QlPuu425Q
         xU3y38VKZ4BjKca2PGef3xlJLHnaNbYyf60PYM8CMoFwY6WMKZHnN7oFfNqqEy3Xno1X
         DTnmPdUDSHukAEQU7DEXKnHiXm8fLS1HjJkMNqEUjtaneP3EmvBZanh/na87xpUtp8eM
         5DOV/IVPNkZrUur9f1mOU6qpjRdiexJ40Y3eIPh4VFZCiYefm38OLYd7myNRjyvuoDhD
         h3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781180243; x=1781785043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKVTpr4aNyZx4lSh79VinADzKQEIbf4Ts/2xtaUoVwc=;
        b=T4kPxnX3E7RG/MfxE6rDTmwIzkb2ODcnfYh8iENhje+vZ+EGgdxzuWln3wanQqt5Pq
         szOhnwBCKjH3UeL2hDdeR6lpETuqIezSDkkcRHcYSUh1/wYDvyHu2MlEahQYjvhU8dck
         bcH1VJEssnL/ZRWjt0iWgZu/ZH8k77J+X33yQcN7PCiFC6d/45jB4TfRFNfesjxIj6aJ
         2OLtOu8uFFIpPkniD5qcQp4nFgMqw1HY5j5pJLib5IG83SWQ+uBZnfm7K7n/7+rvTD+F
         erEQfNDxwUf1rWkOzxTGPkRVAJJfTOWIMNMcci56/dPxLrdSv8Z/Bka+kcne9GZNV6nE
         Jv5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9IZp1CMzKM9VP4dQD/qCZ4P0EMSQIcXERZF49n+vkj6HURJ8UxHJHSb5kMvzZDSfwD3/dOtVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQwgAlKjp+pQWMGZOFAOjQ8yZKWR+JCpT6p5BhYvdfs1uWHk47
	D8RtSKwwa1RHipz4v3QD5h7gCJiO3x2iHJ5HfMRiIUojf76v1AKS20rf
X-Gm-Gg: Acq92OHiFeH42PHmRP8ZQIrfUfvZXJQl5L0/7ynsPQn/r7NGDBDK73CXqDCEIdXEw+r
	SpmCJB8BAoJGqRggSjYK7cM8HfC/Op5UdxcPKBZlpt/YV6oFlbNwrCwYVB13Bm+qVkmntbSk5tL
	7euyCTZhrPYNZewkxrTza3tJFCRu5M9kMmQfoxsaeYq3kyigKI3YbfKttY62Ij95fYmAMDf+DoU
	dqWeRl6n1d1KbX0mRAJ0a0ZOyGqAn3gA04C3Lq6zVCGqUlOdH4nZ2sPdF4HSEDtskOW9plmJIM7
	jXSmMv8zOqIOssvPNVuA/X4yO7yCGL5ZhFB3NnFjWoODHq/eM6C6sHoBDdzwHPrV/QBSJsUhghB
	XvgpKoxedmLoHdlc1SGJslMbQun7A01K1Fpe9TXiIOLyvNFff2HhpoZKNMC5y08KcbnhadszMmg
	WViMEsGs1G3cmoMAAzAvKLxtALSkEBvBpIlm8U3HBcoOvtjRfJ/YXF
X-Received: by 2002:a17:90b:5607:b0:35e:d015:d675 with SMTP id 98e67ed59e1d1-3779d7a1208mr3111460a91.7.1781180242867;
        Thu, 11 Jun 2026 05:17:22 -0700 (PDT)
Received: from [192.168.89.2] ([27.232.220.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3775558f317sm2486069a91.9.2026.06.11.05.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 05:17:22 -0700 (PDT)
Message-ID: <bfc283bc-a5db-4e96-a447-e8e79cc97d34@gmail.com>
Date: Thu, 11 Jun 2026 21:17:18 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] crypto: inside-secure: add EIP93 ESP packet backend
To: Simon Horman <horms@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Antoine Tenart <atenart@kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20260523121522.3023992-1-hurryman2212@gmail.com>
 <20260523121522.3023992-3-hurryman2212@gmail.com>
 <20260527100824.GJ2256768@horms.kernel.org>
Content-Language: en-US
From: Jihong Min <hurryman2212@gmail.com>
In-Reply-To: <20260527100824.GJ2256768@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-298108-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:ansuelsmth@gmail.com,m:atenart@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:steffen.klassert@secunet.com,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,gondor.apana.org.au,davemloft.net,lunn.ch,google.com,redhat.com,secunet.com,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2C30671C02



On 5/27/26 19:08, Simon Horman wrote:
> On Sat, May 23, 2026 at 09:15:21PM +0900, Jihong Min wrote:
>> Expose an EIP93 packet-mode IPsec backend for netdev drivers that need
>> ESP encapsulation and decapsulation offload without advertising EIP93
>> itself as a netdev.
>>
>> Add provider selection, capability reporting, SA lifecycle management,
>> IPsec request completion, and provider fault notification around the
>> existing EIP93 descriptor path.
>>
>> Assisted-by: Codex:gpt-5.5
>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> 
> ...
> 
>> diff --git a/drivers/crypto/inside-secure/eip93/eip93-ipsec.c b/drivers/crypto/inside-secure/eip93/eip93-ipsec.c
> 
> ...
> 
>> +static void eip93_ipsec_abort_requests(struct eip93_ipsec *ipsec, int err)
>> +{
>> +	struct eip93_ipsec_sa *sa;
>> +
>> +	while (true) {
>> +		bool found = false;
>> +
>> +		spin_lock_bh(&ipsec->lock);
>> +		list_for_each_entry(sa, &ipsec->sa_list, node) {
>> +			spin_lock(&sa->lock);
>> +			if (sa->aborting) {
>> +				spin_unlock(&sa->lock);
>> +				continue;
>> +			}
>> +
>> +			sa->aborting = true;
>> +			found = refcount_inc_not_zero(&sa->refcnt);
>> +			spin_unlock(&sa->lock);
>> +			if (found)
>> +				break;
>> +		}
>> +		spin_unlock_bh(&ipsec->lock);
>> +		if (!found)
>> +			return;
>> +
>> +		eip93_ipsec_abort_sa(sa, err);
>> +		eip93_ipsec_sa_put(sa);
> 
> sa is the iterator for the list_for_each_entry loop.
> However, here it is used outside of that context.
> 
> 	"If list_for_each_entry, etc complete a traversal of the list, the
> 	iterator variable ends up pointing to an address at an offset from
> 	the list head, and not a meaningful structure.  Thus this value
> 	should not be used after the end of the iterator.
> 
> 	https://www.spinics.net/lists/linux-kernel-janitors/msg11994.html
> 
> Flagged by Coccinelle.
> 

Hi Simon,

Thanks for the feedback, and sorry for noticing this mail so late.

Your point is correct. The `list_for_each_entry()` iterator should not
be used outside the loop like that. If I continued with this series, I
would fix it by keeping a separate selected SA pointer before dropping
the lock.

At this point, though, I think the right thing is to withdraw this
EIP93/Airoha series.

The reason is that many Airoha SoCs also have a higher-performance IP
block called SOE (Secure Offload Engine). I recently wrote and tested a
driver for that block, and I am currently carrying it here: [kernel: add
bonding LAG XFRM offload infrastructure and Airoha
support](https://github.com/hurryman2212/OpenW1700k-test/commit/fbfe8f919f836bb62b3849f803865a4d9b8dc76f).
With the EIP93 path I could get around 1 Gbps, while the SOE path can
reach about 5 Gbps in my current setup. Because of that, integrating
this EIP93 ESP packet path directly into `airoha_eth` is no longer the
most useful direction for Airoha Ethernet.

That said, SOE exists only on some Airoha SoCs. EIP93 can still be
useful on other platforms as a look-aside ESP packet offloader, but I
think that needs a cleaner infrastructure than this series had. The
look-aside offloader should be able to live as a separate module, not be
tied directly to one specific netdev driver, while still allowing
compatible netdevs to attach it into the XFRM path. I think that needs a
more general infrastructure extension, so I would rather revisit the
EIP93 work later on top of that kind of model.


Sincerely,
Jihong Min

>> +	}
>> +}
> 
> ...



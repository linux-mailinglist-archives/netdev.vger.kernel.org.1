Return-Path: <netdev+bounces-287797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /exrBANFBWrmTwIAu9opvQ
	(envelope-from <netdev+bounces-287797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 05:44:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B66E53D5E6
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 05:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61D4830378BA
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A273A3E94;
	Thu, 14 May 2026 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4jqvkI7Q"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6622DF15C
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 03:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778730239; cv=none; b=QoA6albRcf5v0xwFvfqWTNfGEsplNjZemJkXzj77KV1hCTSRwAy8bCUJA5RUpjs0YTf/k+rif5YpXoZwUEbBiOLRnvNogtSNKIroozXbENl8FoxdM7q7eslg1l/gB0ulasa9PK01RNDXqDBnzXvBYopfsMsvpYX/RXjdmWTXO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778730239; c=relaxed/simple;
	bh=aVE46NBxY3Fqb/PpvDd/Y690kXh/aX8o/o0O1h7eHYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UHjv84FBZhwN05Zkcf4x3F9AFL6CrK8m1VD6vSLmft9zvJbF7f5SfwPrIW9iNcVI8M3Afk+x3bTr8Ok8dqZuVDBkoVrxzIKsb1odB0UEjjOBPPykl0RPywV+/crqmyIWvcmmFDyfIIwL5nZgAyRbs8iQBfoZtYAGjTZo5kymTHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4jqvkI7Q; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+P54/1174kyjFyq6y+CweGj0R1nUd/S+rPnML7moSVA=;
	b=4jqvkI7QS6OhQ63klipk4nAhPHY3/W6i8avfwLZ7wFRNpFogUw3SQtx2dvKgD4jdRX/rMe3de
	MASqiFDwkxCCfc5pdHffUp9Qnk8t30HtxnVP0ju893vkwGAue6PK5imuVaGyXGLCbq0UiE81Weq
	PGoDZT8ePTI727pmftEzrNA=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gGGGQ55X3znTXc;
	Thu, 14 May 2026 11:36:46 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FFD540561;
	Thu, 14 May 2026 11:43:49 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 May 2026 11:43:48 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 May 2026 11:43:48 +0800
Message-ID: <c37967eb-7b98-4765-b166-9b6857a70b1f@huawei.com>
Date: Thu, 14 May 2026 11:43:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: xfrm: Fix dev refcnt leak in async resumption
To: Simon Horman <horms@kernel.org>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tpluszz77@gmail.com>, <netdev@vger.kernel.org>,
	<zhangchangzhong@huawei.com>
References: <20260509074443.104163-1-dongchenchen2@huawei.com>
 <20260513170755.253159-2-horms@kernel.org>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <20260513170755.253159-2-horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200002.china.huawei.com (7.202.195.90)
X-Rspamd-Queue-Id: 5B66E53D5E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287797-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: xfrm: Fix dev refcnt leak in async resumption
>
> This commit adds a dev_put() to the return path of xfrm_input() when afinfo
> is NULL during asynchronous resumption, aiming to prevent a device reference
> leak.
>
>> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
>> index f65291eba1f68..c98a29d80a534 100644
>> --- a/net/xfrm/xfrm_input.c
>> +++ b/net/xfrm/xfrm_input.c
>> @@ -765,6 +765,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>>   			return err;
> This return is reached when xfrm_gro is true and gro_cells_receive() has
> just consumed the skb.
>
> If afinfo is NULL, err remains -EAFNOSUPPORT (-97).
>
> When a negative error is returned back to the synchronous IPv4 input path
> (ip_protocol_deliver_rcu), doesn't the IP stack typically resubmit the
> packet using the negated error code (-err = 97) as the protocol number?
>
> Could this cause a use-after-free when the IP stack attempts to dereference
> the already-consumed skb?
>
> Also, since transport_finish() was skipped, could this inject an skb with
> unreset headers into the GRO engine?
>
> Would it be safer to jump to the drop label immediately if !afinfo?
>
>>   		}
>>   
>> +		if (unlikely(!afinfo) && async)
>> +			dev_put(skb->dev);
>>   		return err;
> In the asynchronous path, callers like the bottom-half crypto completion
> callbacks return void and ignore the return value of xfrm_input():
>
> net/ipv4/esp4.c:esp_input_done2() {
>      ...
>      xfrm_input_resume(skb, err);
> }
>
> Does this code leak the skb memory?
>
> Returning an error here drops the device reference but appears to leave the
> skb un-freed, as it is never passed to the next protocol layer or explicitly
> freed via kfree_skb() or by jumping to the drop label.

Yes, indeed.
We need to perform the goto drop operation before xfrm_gro is determined
to fix the skb leakage and the problem that xfrm_gro does not unset the
header. as bellow:

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index f65291eba1f6..109ee8893761 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -750,8 +750,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
                 err = -EAFNOSUPPORT;
                 rcu_read_lock();
                 afinfo = xfrm_state_afinfo_get_rcu(x->props.family);
-               if (likely(afinfo))
+               if (likely(afinfo)) {
                         err = afinfo->transport_finish(skb, xfrm_gro || async);
+               } else {
+                       rcu_read_unlock();
+                       goto drop;
+               }
                 rcu_read_unlock();
                 if (xfrm_gro) {
                         sp = skb_sec_path(skb);

Thanks a lot for your review! v2 will be submit
-------
Best regards
Dong Chenchen

>>   	}
>>


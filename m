Return-Path: <netdev+bounces-294072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHORLReLHmr0kgkAu9opvQ
	(envelope-from <netdev+bounces-294072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:49:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85170629EA4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 09:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 522E6313E8F5
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F394F30EF80;
	Tue,  2 Jun 2026 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QOFWtkJv"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57572314A86
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385917; cv=none; b=NhO5HJ26/TTx2ry32KJEIaDn6hRDTFKPhawTxQ3wRKddaf5KHvmF4eznpxPVav2Frl4yj3NKl7dD8hoW6Kwn9IJ0FrzZzDVwwwfEsayswEfz71qMIb2T1FKNxVnQbpY7BzHd0Hp/0aiWQHHyLoUD4EhafFuomlUpwPlYF1TzWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385917; c=relaxed/simple;
	bh=GuwvEaHv/4puRkbG+M42mOPtoSn0Rl/3sB6e+6n+qJM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=olDt6c9RRjYzuaTlgXj3++pzXB1JIkAwCMLJ79gfrApO/jawqwYT0AK9FHwwCDcmTnbindEhPvoyAwtIyv+Wyl2SCxEVzQVmo9krlrMnksoyFjOqjVHOHFMsce22n0foDUf4NvdAiwvCS61od8c98ty0gd29J3ZClOX/ujIaFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QOFWtkJv; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ya5TJtuCA5GMGwdA2KMdSyIAv6LYCKBGTUHVfxisHlg=;
	b=QOFWtkJveZgvq8fbsB9bheNmzwJHmaIr0QZv1vGu9hTXcpyR3AeXh1FlQOl1MRzK/osd+nFoa
	ZFsdFtzLmgVYHUkkikvLiYE2yQWuRWfb3iNLESuNTxncK8XEcTdomerLwVtQyLeWgYK9QEaFdjY
	YY0czX7+6TevFhqzVM3nNyk=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gV2YQ2sGzz12LfT;
	Tue,  2 Jun 2026 15:30:34 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id B8885201E9;
	Tue,  2 Jun 2026 15:38:30 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 15:38:30 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 15:38:29 +0800
Message-ID: <7c79c7a1-897a-490e-91e1-83a1ac5ad27a@huawei.com>
Date: Tue, 2 Jun 2026 15:38:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xfrm: Fix dev use-after-free in xfrm async resumption
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <tpluszz77@gmail.com>, <netdev@vger.kernel.org>,
	<zhangchangzhong@huawei.com>, <xuchunxiao3@huawei.com>
References: <20260529092111.1089315-1-dongchenchen2@huawei.com>
 <ah0nmpeq6TNHtQqd@secunet.com>
 <70a09730-69bc-49cd-aa61-89e63ba766e3@huawei.com>
In-Reply-To: <70a09730-69bc-49cd-aa61-89e63ba766e3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200002.china.huawei.com (7.202.195.90)
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
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294072-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 85170629EA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



>> On Fri, May 29, 2026 at 05:21:11PM +0800, Dong Chenchen wrote:
>>> xfrm async resumption hold skb->dev refcnt until after transport_finish.
>>> However, xfrm_rcv_cb may modify skb->dev to tunnel dev without taking
>>> device reference, such as vti_rcv_cb. The subsequent async resumption
>>> will decrement the tunnel device's reference count, which lead to uaf
>>> of tunnel dev and refcnt leak of orig dev as below:
>>>
>>> unregister_netdevice: waiting for vti1 to become free. Usage count = -2
>>>
>>> Release refcnt of the original dev after tunnel rcv modify skb->dev to
>>> fix it.
>>>
>>> Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish 
>>> NF_HOOK")
>>> Reported-by: Xu Chunxiao <xuchunxiao3@huawei.com>
>>> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
>>> ---
>>>   net/xfrm/xfrm_input.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
>>> index f65291eba1f6..c979872b6006 100644
>>> --- a/net/xfrm/xfrm_input.c
>>> +++ b/net/xfrm/xfrm_input.c
>>> @@ -467,6 +467,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, 
>>> __be32 spi, int encap_type)
>>>   {
>>>       const struct xfrm_state_afinfo *afinfo;
>>>       struct net *net = dev_net(skb->dev);
>>> +    struct net_device *dev = skb->dev;
>>>       int err;
>>>       __be32 seq;
>>>       __be32 seq_hi;
>>> @@ -730,6 +731,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, 
>>> __be32 spi, int encap_type)
>>>       if (err)
>>>           goto drop;
>>> +    if (async && skb->dev != dev) {
>>> +        dev_put(dev);
>>> +        async = 0;
>>> +    }
>>>       nf_reset_ct(skb);
>>>       if (decaps) {
>> Sashiko found issues with this patch:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/ 
>> patchset/20260529092111.1089315-1-dongchenchen2%40huawei.com
>>
>> Please review!
>>
> 
> Hi, Steffen! Thanks a lot for your review.
> 
> This patch indeed cannot fix all the issues in the branches.
> Maybe we can stash original skb->dev and move dev_put in
> transport_finish to xfrm_input to fix it.
> But there is a question, xfrm_rcv_cb modify skb->dev to tunnel or
> xfrmi dev without taking device reference. Is it safe to directly
> access the new dev from skb in the subsequent async resumption?
> Will this trigger the issue again mentioned in 1c428b038400 ("xfrm:
> hold dev ref until after transport_finish NF_HOOK")? It seems that
> it is difficult to protect new skb->dev within the xfrm_input process.
> 
> Best regards
> Dong Chenchen
> 
> 

Maybe we can fix it as bellow:
Stash the original dev to fix refcnt imbalance.  Add rcu protection
for new skb->dev set by xfrm_rcv_cb to fix potential race with device 
teardown.

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index c2eac844bcdb..f6f2a8ef3f88 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -76,8 +76,6 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
         NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
                 dev_net(dev), NULL, skb, dev, NULL,
                 xfrm4_rcv_encap_finish);
-       if (async)
-               dev_put(dev);
         return 0;
  }

diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 699a001ac166..89d0443b5307 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -71,8 +71,6 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
         NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
                 dev_net(dev), NULL, skb, dev, NULL,
                 xfrm6_transport_finish2);
-       if (async)
-               dev_put(dev);
         return 0;
  }

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index f65291eba1f6..c9b82519fc04 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -467,6 +467,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, 
__be32 spi, int encap_type)
  {
         const struct xfrm_state_afinfo *afinfo;
         struct net *net = dev_net(skb->dev);
+       struct net_device *dev = skb->dev;
         int err;
         __be32 seq;
         __be32 seq_hi;
@@ -493,7 +494,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, 
__be32 spi, int encap_type)
  
LINUX_MIB_XFRMINSTATEINVALID);

                         if (encap_type == -1)
-                               dev_put(skb->dev);
+                               dev_put(dev);
                         goto drop;
                 }

@@ -660,7 +661,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, 
__be32 spi, int encap_type)
                         nexthdr = x->type->input(x, skb);
                         if (nexthdr == -EINPROGRESS) {
                                 if (async)
-                                       dev_put(skb->dev);
+                                       dev_put(dev);
                                 return 0;
                         }

@@ -699,7 +700,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, 
__be32 spi, int encap_type)
                 err = xfrm_inner_mode_input(x, skb);
                 if (err == -EINPROGRESS) {
                         if (async)
-                               dev_put(skb->dev);
+                               dev_put(dev);
                         return 0;
                 } else if (err) {
                         XFRM_INC_STATS(net, 
LINUX_MIB_XFRMINSTATEMODEERROR);
@@ -726,10 +727,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, 
__be32 spi, int encap_type)
                 crypto_done = false;
         } while (!err);

+       rcu_read_lock();
         err = xfrm_rcv_cb(skb, family, x->type->proto, 0);
-       if (err)
+       if (err) {
+               rcu_read_unlock();
                 goto drop;
-
+       }
         nf_reset_ct(skb);

         if (decaps) {
@@ -739,8 +742,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, 
__be32 spi, int encap_type)
                 if (skb_valid_dst(skb))
                         skb_dst_drop(skb);
                 if (async)
-                       dev_put(skb->dev);
+                       dev_put(dev);
                 gro_cells_receive(&gro_cells, skb);
+               rcu_read_unlock();
                 return 0;
         } else {
                 xo = xfrm_offload(skb);
@@ -748,23 +752,22 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, 
__be32 spi, int encap_type)
                         xfrm_gro = xo->flags & XFRM_GRO;

                 err = -EAFNOSUPPORT;
-               rcu_read_lock();
                 afinfo = xfrm_state_afinfo_get_rcu(x->props.family);
                 if (likely(afinfo))
                         err = afinfo->transport_finish(skb, xfrm_gro || 
async);
-               rcu_read_unlock();
+
                 if (xfrm_gro) {
                         sp = skb_sec_path(skb);
                         if (sp)
                                 sp->olen = 0;
                         if (skb_valid_dst(skb))
                         if (skb_valid_dst(skb))
                                 skb_dst_drop(skb);
-                       if (async)
-                               dev_put(skb->dev);
                         gro_cells_receive(&gro_cells, skb);
-                       return err;
                 }

+               if (async)
+                        dev_put(dev);
+               rcu_read_unlock();
                 return err;
         }

@@ -772,7 +775,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, 
__be32 spi, int encap_type)
         spin_unlock(&x->lock);
  drop:
         if (async)
-               dev_put(skb->dev);
+               dev_put(dev);
         xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : 
nexthdr, -1);
         kfree_skb(skb);
         return 0;>



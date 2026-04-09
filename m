Return-Path: <netdev+bounces-277013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLUBBcau12kMRQgAu9opvQ
	(envelope-from <netdev+bounces-277013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 15:51:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4603CB903
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 15:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BB45300DA71
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53708385513;
	Thu,  9 Apr 2026 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LoERg2F6"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB9633BBA2;
	Thu,  9 Apr 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742226; cv=none; b=sSOFge/VNirAcvUJoP6Et8JxP9jqRR4XhAMU2hXAm6IWJUj2hsNVEygEJH4dJchHAovXL+AZDFXHLi0XvqP1qkon1EDEJqtwGs/lj2oBVqViYgJzECgY9teS1Tdwrxi4LUbDE8PN6lt6qGBcaDJSG7pqv+FMdx9DtEjKkaGK9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742226; c=relaxed/simple;
	bh=n3CpLk97LtDsZ0cI3+n3Ybw5XoyVOqFsSCOxiXAQZuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQheprpEanRl066ohn1b7La9mcS195hAYXRbwzR2YGJNICpOKH/VIm27E8uTENaBfEqfGpX0pRUULRIhKfaBD6FzMl9T67+pwWUgJOupnfm5S3sMUPSMJBb2g8K7ezmYkYRvtFZC+ijD3xQ+Z3v8rAmkepVCifxX2wZdYEW5br0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LoERg2F6; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mKUYgIaFNz8pbnf2XU9B3/tKrqrjJUecCZ/5IGn7BCg=; b=LoERg2F6vUZf7NGI+H67TxTMSP
	JZ9UZ4p9vSXdVgAy0DZO946sSsg9au2fyT10dJRJEe0xlBcyGEv0Zg+IvKEnWezcM/osta7rQMGd/
	YBU+KscerpFzmQcoUJP0BqfxI2IRTQiGEjWGxOMNc70A7JkSUG/+NDJCsYd3qEr+AwUhAw4TSkuG+
	zQbFqF7xgGCmJh09rnmtkos6TF8J5bz8ciV7eHmGEsytOX6RE4Ys7n43jf1KFE1+HjItq56jVXBBr
	5btXxATR7Nd3k6ovCXFf4lptobmlmpwRRw7GnzJmUayooA1qp/8pCmvHexwAZgih3EcwKC4l+mcy5
	C9SzkGRA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wApf9-000JxQ-1K;
	Thu, 09 Apr 2026 15:43:15 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wApf8-0002p0-0y;
	Thu, 09 Apr 2026 15:43:14 +0200
Message-ID: <731d2749-abf6-403c-a1f4-ffe9c8d1e8ad@iogearbox.net>
Date: Thu, 9 Apr 2026 15:43:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 03/14] net: Add lease info to queue-get
 response
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260402231031.447597-1-daniel@iogearbox.net>
 <20260402231031.447597-4-daniel@iogearbox.net>
 <20260407204017.3fc79d1b@kernel.org>
 <b9a046f8-cb02-4d54-9a7e-e8213339d720@iogearbox.net>
 <20260408151251.72bd2482@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260408151251.72bd2482@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27966/Thu Apr  9 08:24:43 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277013-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A4603CB903
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 12:12 AM, Jakub Kicinski wrote:
> On Wed, 8 Apr 2026 11:09:34 +0200 Daniel Borkmann wrote:
>>>> +void netif_put_rx_queue_lease_locked(struct net_device *orig_dev,
>>>> +				     struct net_device *dev)
>>>> +{
>>>> +	if (orig_dev != dev)
>>>> +		netdev_unlock(dev);
>>>> +}
>>>
>>> Pretty sure I already complained about these ugly helpers.
>>> I'll try to find the time tomorrow to come up with something better.
>>
>> Ok, sounds good. Happy to adapt if you find something better and then I'll
>> work this into the series, and also integrate the things mentioned in my
>> cover letter reply (netkit nl dump + additional tests).
> 
> Hi! How would you feel about something like the following on top?
> 
> --->8----------
> 
> net: remove the netif_get_rx_queue_lease_locked() helpers
> 
> The netif_get_rx_queue_lease_locked() API hides the locking
> and the descend onto the leased queue. Making the code
> harder to follow (at least to me). Remove the API and open
> code the descend a bit. Most of the code now looks like:
> 
>   if (!leased)
>       return __helper(x);
> 
>   hw_rxq = ..
>   netdev_lock(hw_rxq->dev);
>   ret = __helper(x);
>   netdev_unlock(hw_rxq->dev);
> 
>   return ret;
> 
> Of course if we have more code paths that need the wrapping
> we may need to revisit. For now, IMHO, having to know what
> netif_get_rx_queue_lease_locked() does is not worth the 20LoC
> it saves.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Thanks for looking into it! That looks good to me. I've also retested that
it still works.

Maybe small nits could be below to move the netif_is_queue_leasee into the
netdev_rx_queue.h header since its used outside of core and it might be
worth to also have the lock assertion in netdev_queue_get_dma_dev.

Do you want me to add your patch on top for a v12 of the series?

Thanks,
Daniel

  include/net/netdev_rx_queue.h | 2 ++
  net/core/dev.h                | 1 -
  net/core/netdev_queues.c      | 2 ++
  net/xdp/xsk.c                 | 2 --
  4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 9415a94d333d..e9f7f098609b 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -76,6 +76,8 @@ struct netdev_rx_queue *
  __netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq,
  			   enum netif_lease_dir dir);
  
+bool netif_is_queue_leasee(const struct net_device *dev);
+
  int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
  void netdev_rx_queue_lease(struct netdev_rx_queue *rxq_dst,
  			   struct netdev_rx_queue *rxq_src);
diff --git a/net/core/dev.h b/net/core/dev.h
index 376bac4a82da..95edb2d4eff8 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -101,7 +101,6 @@ int netdev_queue_config_validate(struct net_device *dev, int rxq_idx,
  
  bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx);
  bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx);
-bool netif_is_queue_leasee(const struct net_device *dev);
  
  void __netif_mp_uninstall_rxq(struct netdev_rx_queue *rxq,
  			      const struct pp_memory_provider_params *p);
diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index 5597af86591b..73fb28087a93 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -40,6 +40,8 @@ struct device *netdev_queue_get_dma_dev(struct net_device *dev,
  	struct netdev_rx_queue *hw_rxq;
  	struct device *dma_dev;
  
+	netdev_ops_assert_locked(dev);
+
  	/* Only RX side supports queue leasing today. */
  	if (type != NETDEV_QUEUE_TYPE_RX || !netif_rxq_is_leased(dev, idx))
  		return __netdev_queue_get_dma_dev(dev, idx);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 616cd7b42502..7da620aa11d6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -31,8 +31,6 @@
  #include <net/netdev_rx_queue.h>
  #include <net/xdp.h>
  
-#include "../core/dev.h"
-
  #include "xsk_queue.h"
  #include "xdp_umem.h"
  #include "xsk.h"
-- 
2.43.0




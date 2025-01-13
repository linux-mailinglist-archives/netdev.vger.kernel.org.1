Return-Path: <netdev+bounces-157898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C08A0C3ED
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7BB3A087B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D401C8FD7;
	Mon, 13 Jan 2025 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="OoH3M75j"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAF31C1AAA
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736804506; cv=none; b=NpONKlG8hxYR5VgxyEMFKc+7sc7tYxjcbqnxXRYFBQw23SDwC4qakQeKtQRaczEXmUglwu3vWdUZr8Ig9TuAQX20UpQ6Wk/Sv27qXks228IDdtiShKu86ZW6bh8rV16JwCJPopIxRcpboThbLrMiUrOu1tTkPOxit1tI9FS9+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736804506; c=relaxed/simple;
	bh=gXGgrSUagYCT/oKj9xO9oEdjFK/OctqqO5YZC7aAu78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTUuX1NTGERhvugHeR5926CRxdSgILnuurlfQPDHthBo7/+ipkg56GnW+hmu8bqVCDU2mkudv0azNGw8KtqqJtrAIV9++2S3o+P2exe4NqETz46RTY43HRRBsDspzF2upzWpDtdZZTXb4bb3mOFr0mh3wOqMqhXbJyx8p6BSgns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=OoH3M75j; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1736804499;
	bh=gXGgrSUagYCT/oKj9xO9oEdjFK/OctqqO5YZC7aAu78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OoH3M75jAYbE62Gho70iJY+EI/ZBYtONH+lR512Vjp/UeZY6sA+fyq5Mmil2/cKKH
	 Bf9ZXqIK4qvUET4LirK3eDGTN51CQoMU6PFsOQ/H0N3EKM1yX2tcp/Oq4R+epxPy5u
	 Me2CS5xFIAyW/PSjKnGQognUNjgMD4k15fDpFKYGk1znnO5RG6oBAfnmhRcYPHc4vq
	 RJBtZXUrhBPjFoLCkkfUgAvTRXuXNymFNBE1YO0M5RVGe/OsQZ6Z6IuXec/E1LXls4
	 dM6rHcEuFIvhj7SAHwW6apBhXrWTeM1OowNR/pnm4fFTnfD8iaAqaPQOmpwb3QiYZA
	 yMYjSDytuUT1w==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 44D8260078;
	Mon, 13 Jan 2025 21:41:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 038F62003D7;
	Mon, 13 Jan 2025 21:41:20 +0000 (UTC)
Message-ID: <8cf44ce9-e117-46fe-8bef-21200db97d0f@fiberby.net>
Date: Mon, 13 Jan 2025 21:41:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net] net: sched: refine software bypass handling in
 tc_run
To: Xin Long <lucien.xin@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Shuang Li <shuali@redhat.com>, network dev <netdev@vger.kernel.org>
References: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Xin,

With the concept turned on it's head, we properly shouldn't call it a bypass
anymore? Now that software processing is only enabled, if there are any rules
that needs it.

s/PATCHv2 net/PATCH v2 net/g, but I think my patch below pushes it
firmly into net-next territory, unless you can convince the maintainers that
usesw is always set correctly.

I will run it through some tests tomorrow with my patch applied.

On 1/13/25 6:42 PM, Xin Long wrote:
> [...]
> @@ -410,48 +411,17 @@ static void tcf_proto_get(struct tcf_proto *tp)
>   	refcount_inc(&tp->refcnt);
>   }
>   
> -static void tcf_maintain_bypass(struct tcf_block *block)
> -{
> -	int filtercnt = atomic_read(&block->filtercnt);
> -	int skipswcnt = atomic_read(&block->skipswcnt);
> -	bool bypass_wanted = filtercnt > 0 && filtercnt == skipswcnt;
> -
> -	if (bypass_wanted != block->bypass_wanted) {
> -#ifdef CONFIG_NET_CLS_ACT
> -		if (bypass_wanted)
> -			static_branch_inc(&tcf_bypass_check_needed_key);

This enabled the global sw bypass checking static key, when sw was NOT used.

> [...]
> @@ -2409,7 +2379,13 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
>   		tfilter_notify(net, skb, n, tp, block, q, parent, fh,
>   			       RTM_NEWTFILTER, false, rtnl_held, extack);
>   		tfilter_put(tp, fh);
> -		tcf_block_filter_cnt_update(block, &tp->counted, true);
> +		spin_lock(&tp->lock);
> +		if (tp->usesw && !tp->counted) {
> +			if (atomic_inc_return(&block->useswcnt) == 1)
> +				static_branch_inc(&tcf_bypass_check_needed_key);

This enables the global sw bypass checking static key, when sw IS used.

I think you are missing the below patch (not tested in anyway, yet):

This patch:
- Renames the static key, as it's use has changed.
- Fixes tc_run() to the new way to use the static key.

---
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index e4fea1decca1..4eb0ebb9e76c 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -75,7 +75,7 @@ static inline bool tcf_block_non_null_shared(struct tcf_block *block)
  }

  #ifdef CONFIG_NET_CLS_ACT
-DECLARE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
+DECLARE_STATIC_KEY_FALSE(tcf_sw_enabled_key);

  static inline bool tcf_block_bypass_sw(struct tcf_block *block)
  {
diff --git a/net/core/dev.c b/net/core/dev.c
index a9f62f5aeb84..3ec89165296f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2134,8 +2134,8 @@ EXPORT_SYMBOL_GPL(net_dec_egress_queue);
  #endif

  #ifdef CONFIG_NET_CLS_ACT
-DEFINE_STATIC_KEY_FALSE(tcf_bypass_check_needed_key);
-EXPORT_SYMBOL(tcf_bypass_check_needed_key);
+DEFINE_STATIC_KEY_FALSE(tcf_sw_enabled_key);
+EXPORT_SYMBOL(tcf_sw_enabled_key);
  #endif

  DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
@@ -4030,10 +4030,13 @@ static int tc_run(struct tcx_entry *entry, struct sk_buff *skb,
  	if (!miniq)
  		return ret;

-	if (static_branch_unlikely(&tcf_bypass_check_needed_key)) {
-		if (tcf_block_bypass_sw(miniq->block))
-			return ret;
-	}
+	/* Global bypass */
+	if (!static_branch_likely(&tcf_sw_enabled_key))
+		return ret;
+
+	/* Block-wise bypass */
+	if (tcf_block_bypass_sw(miniq->block))
+		return ret;

  	tc_skb_cb(skb)->mru = 0;
  	tc_skb_cb(skb)->post_ct = false;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 358b66dfdc83..617fcb682209 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -419,7 +419,7 @@ static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
  	tp->ops->destroy(tp, rtnl_held, extack);
  	if (tp->usesw && tp->counted) {
  		if (!atomic_dec_return(&tp->chain->block->useswcnt))
-			static_branch_dec(&tcf_bypass_check_needed_key);
+			static_branch_dec(&tcf_sw_enabled_key);
  		tp->counted = false;
  	}
  	if (sig_destroy)
@@ -2382,7 +2382,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
  		spin_lock(&tp->lock);
  		if (tp->usesw && !tp->counted) {
  			if (atomic_inc_return(&block->useswcnt) == 1)
-				static_branch_inc(&tcf_bypass_check_needed_key);
+				static_branch_inc(&tcf_sw_enabled_key);
  			tp->counted = true;
  		}
  		spin_unlock(&tp->lock);


Return-Path: <netdev+bounces-278428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMBlMZwr3mmTogkAu9opvQ
	(envelope-from <netdev+bounces-278428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:57:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC473F9B2A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61D353012E7B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A40396D28;
	Tue, 14 Apr 2026 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/9VYEJ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03237245008;
	Tue, 14 Apr 2026 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167818; cv=none; b=jmYMgZsw0HqjUi0WvIrzktL7PjOQlaVKG8fVx6U3Oeu7OoPGeTzMgOr7fGW87Gcy4UwiF7IMIbQ5kv+2/UKZngjsOUsP+szsTmvHHgVLC/KwH66zVSLdcOf+8woxyKX8fUn6z6BjfxX3G1wB3uZxoaDxETo7TyS1VoT4NfuQ1sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167818; c=relaxed/simple;
	bh=JVysYol+Gm3Vh2xJhQRrUjCz5H+7nJfBlTG8kPcwX90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ek1W6vjhxYIq9RTN13PsR2xAKdU+v3tjOZ/P9oSsYYfjFPXIjly+CFfPEGjANlqP9jfY99YvZYSIg8hYerxb1AvItwOvdEUXZoGfzvRjxj7TTh1kOSh16FU1uEGARRMXjI6jddsuq+Lh+m11L986bdudO/zZvfmldPNzcv6s0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/9VYEJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6DBC19425;
	Tue, 14 Apr 2026 11:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776167817;
	bh=JVysYol+Gm3Vh2xJhQRrUjCz5H+7nJfBlTG8kPcwX90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N/9VYEJ5cUwzaBpQxP32f/bZ2kj846Z4PbIgdw276uoeCb4o2mCGk+LNndcWEBa5u
	 mErzu2ejnhg2rLUmow34TC3m7DmYl/lD8J6DIyTMGnDs2Syu6JCm055/UIWXRfI+39
	 qARyCEHmWZL7YxMVhzD+YNsoQUDO+25la8+I8BLJGJFzmYL5fZ17NRSUJJ/Anl37tX
	 kZV6WXzHzVASeDZffFjxgZV8PKQeY7I7Sxsr2uZReGRV/QfrFQw1PJjNfcXNscHT/Q
	 rlM9LYaVfcwdG3oVAmuN74LxwbETUKtce0hSWi9I21C5DH+DxP/tEx9THa1glM8G/+
	 tPPJ/aM0ttlkQ==
Message-ID: <c999d076-1743-4665-a911-ddee27062d8f@kernel.org>
Date: Tue, 14 Apr 2026 13:56:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
To: Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Networking <netdev@vger.kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <adz0iX85FHMz0HdO@sirena.org.uk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <adz0iX85FHMz0HdO@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278428-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EC473F9B2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 13/04/2026 15.50, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>    include/net/sch_generic.h
> 
> between commit:
> 
>    a6bd339dbb351 ("net_sched: fix skb memory leak in deferred qdisc drops")
> 
> from the net tree and commit:
> 
>    ff2998f29f390 ("net: sched: introduce qdisc-specific drop reason tracing")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc include/net/sch_generic.h
> index 5fc0b1ebaf25c,5af262ec4bbd2..0000000000000
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@@ -1168,24 -1185,14 +1185,24 @@@ static inline void tcf_kfree_skb_list(s
>    }
>    
>    static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
> - 				      enum skb_drop_reason reason)
> + 				      enum qdisc_drop_reason reason)
>    {
>   +	struct Qdisc *root;
>   +
>    	DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
>    	DEBUG_NET_WARN_ON_ONCE(q->flags & TCQ_F_NOLOCK);
>    
>   -	tcf_set_qdisc_drop_reason(skb, reason);
>   -	skb->next = q->to_free;
>   -	q->to_free = skb;
>   +	rcu_read_lock();
>   +	root = qdisc_root_sleeping(q);
>   +
>   +	if (root->flags & TCQ_F_DEQUEUE_DROPS) {
> - 		tcf_set_drop_reason(skb, reason);
> ++		tcf_set_qdisc_drop_reason(skb, reason);

Change/merge looks sane to me :-)
--Jesper


>   +		skb->next = root->to_free;
>   +		root->to_free = skb;
>   +	} else {
>   +		kfree_skb_reason(skb, (enum skb_drop_reason)reason);
>   +	}
>   +	rcu_read_unlock();
>    }
>    
>    /* Instead of calling kfree_skb() while root qdisc lock is held,



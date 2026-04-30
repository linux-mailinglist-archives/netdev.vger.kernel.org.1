Return-Path: <netdev+bounces-282715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJu4I+4Y82nNxAEAu9opvQ
	(envelope-from <netdev+bounces-282715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:55:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0974249F814
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0196301BA7D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74203FD15E;
	Thu, 30 Apr 2026 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOy8SjMe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGLikinj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3403DBD71
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777539287; cv=none; b=Xqddmn5Es9qvWZIxHyST/9ogg3mDRABNZtXmzcFd8LhXNDZ8HKUaQA27/Iv8jT2jIGbquvAmi0xlaxPQr82qur8ayGmNyEHRrAsL2zp7UVW5gkOuA2ipgdSypo1D0vK0l4fSACvXF9ecHQ0e61Ov0T2w1CeUwIOnQJwlt9SYCV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777539287; c=relaxed/simple;
	bh=BXkjAEQH1pEX97etVeo1QwQJ+MmukyjYyoW3FfIXJsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nFM+GNJetO0woYeNAlPy1d/o6phPGQxfNoDi34b/sKEs+FXnXMUY13NB1ozlgbCPpFm3SUWksd4DRBp+J1p8ud/7qbjUNZgkkXZFR6rXSvZDfo9DfRMekePx2gyTS9fv7MrKXmcU2GhPyngCsbdwZC8e6MdvfiKlFW4Dxax8dqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOy8SjMe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGLikinj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777539285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GQwFPqdunk7GL7ROCqWeVKcEMJAeoTNuS9bxiITd8QA=;
	b=gOy8SjMe1Kcb0SYDpwdo6FWKLTL1IjoBOx+wAIc3NRGO6PUk1X98Wa7U/+v77P5DeUDeH6
	dd1hNV4q2EPpbx/gQqzSKoJiFtt50VzUARDcBfmb7US3VYG6gcLeLfQKFGZu4lCb8bedKo
	fDo2tvBYQFEwlQ9CVI8MdPRxL98Dn4g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-fINvrsy1PYu4qgfXrSRYZw-1; Thu, 30 Apr 2026 04:54:43 -0400
X-MC-Unique: fINvrsy1PYu4qgfXrSRYZw-1
X-Mimecast-MFC-AGG-ID: fINvrsy1PYu4qgfXrSRYZw_1777539282
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d56f87e8so5673585e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777539282; x=1778144082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQwFPqdunk7GL7ROCqWeVKcEMJAeoTNuS9bxiITd8QA=;
        b=NGLikinjC2Ru21sFkWbWpAXh91MY5LBogholgkzzArgA7YZBQM/1xAV1Jwq+NssUEr
         X2FJaL8lfa88sxlKjiyzIqwlcMBEnXHo620WJJ9RVQKKnrdXfqzSTA7qF3GxGZStlSpo
         oIXPjgRMV+lIGuteP5g2LW90Nyy+Hzz9C3vXB0GEUKZovjCJQ/Dh2NJIJOF7oGzPn+/B
         8KmYEHrqLK/yDlj3noe3r9w5iINCjxgcpnsVblc/p/Otvc9MulKWD9yT8tQ9+7sKKlfA
         gJ+hHDqASRpAGBuTkH+Rmf4d7piIqBv4/DBteqfPkJjgHaySwE6JczJ9/HpMiTOp3Otw
         D6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777539282; x=1778144082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQwFPqdunk7GL7ROCqWeVKcEMJAeoTNuS9bxiITd8QA=;
        b=e6BZWFqw7BJ/pF8nnMwq0Na7mLpvWXmdvRN/aPHTPJ7y62UjBKknp5oAOFk1cee1W+
         do1KSEDD1cjVtNVUzdNWJmbAM4YCHPIw7veapR7v706mLBb9FtFauulUeh7/QudV/twK
         pRfZEfXCjCUMpWdcXEfXM5OQNMLtpuqM8MtxAxyp4ECMJ/52hp233f+M4MuTCjmIxksw
         yuneMhOxkKKWsDYpAn0eE07pnnB/mTmbaQWDmdR9gp/M63jWZqvipUp6Ii9YtjJiteeY
         IH8gUHLEqYE5RC5tOl3R4GeE6UZhSh4vVRaI5iSuQtB25jpfqgJO1W+2RFjGgpb/Mk+6
         MWUw==
X-Forwarded-Encrypted: i=1; AFNElJ8eIsUquDUenL/MCAniSqR8XJ/1OGbm9JqRT/x7YSqlFGesc+/TKr+ke/uOpABN7PlqVttNCf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvczv2oUjLyMNpd8F7UYcdk472rucWnAf2LhJCSt/xGqAiZFbZ
	/eQX4SNwzsZAgXsf0l2dLE6vd11BDkW6EDjRJRRJVUpe4IPOPKRDv1ro/S9deWTmnPGu/HtSpbz
	s3fEwaKHv7Fkgfv2TckHtPzkt7POODH/ooSL/itAb+n/kXLBwFTJ7CPbLQg==
X-Gm-Gg: AeBDies79MNFJVle+A10xGryfnRrZYfL/FSztn8Sji38aM+2uFGeMK7WuV+pVckICJS
	p3lAQp+hPOyqSCN0KONey3dML7esrTAtAqUZOzQH0s3xZ6XUyEd8sOhKhFiawPgh550wZftfTWp
	sOsYOueuIV0OK+8bUoJEPHPcs/QCBOQn04J1wOhMx8OhlCzCtLSeg6Yq9ECIFyJ00OV5w0Xkag6
	XOujWqWyVZT1SnckvyyUmITfIa1Z0mIOEqjCgrGZgImiV4Bb0n+7d37grQcqa5REjkL2IlmHLm9
	gGm4on1+wZuoQ1vLe4s5Ehfa7kcX0x+7q9VWC3SGktqKq43UDjkyV+eyHYR5YSCl+yFrBiiQPts
	uo1jUma9rgDJKpn/y/+lntUhxuxV/OgrxJpNhw3HQ70vA+uH08htmnH6ZdcaMSetgOw==
X-Received: by 2002:a05:600c:a00e:b0:489:1b0c:8b43 with SMTP id 5b1f17b1804b1-48a83f6c8ddmr34258935e9.1.1777539282165;
        Thu, 30 Apr 2026 01:54:42 -0700 (PDT)
X-Received: by 2002:a05:600c:a00e:b0:489:1b0c:8b43 with SMTP id 5b1f17b1804b1-48a83f6c8ddmr34258295e9.1.1777539281465;
        Thu, 30 Apr 2026 01:54:41 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed6bafsm83284215e9.2.2026.04.30.01.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 01:54:41 -0700 (PDT)
Message-ID: <410c814a-399a-4eb9-a39a-d1e5fecd6b33@redhat.com>
Date: Thu, 30 Apr 2026 10:54:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ppp: consolidate RX skb queueing
To: Qingfang Deng <qingfang.deng@linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Guillaume Nault <gnault@redhat.com>,
 Breno Leitao <leitao@debian.org>, Taegu Ha <hataegu0826@gmail.com>,
 Kees Cook <kees@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260428024426.48605-1-qingfang.deng@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260428024426.48605-1-qingfang.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0974249F814
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282715-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,debian.org,gmail.com,linutronix.de,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]



On 4/28/26 4:44 AM, Qingfang Deng wrote:
> In ppp_input() and ppp_receive_nonmp_frame(), received skbs are queued
> for userspace delivery using the same open-coded pattern:
> 
> 	skb_queue_tail(&pf->rq, skb);
> 	while (pf->rq.qlen > PPP_MAX_RQLEN &&
> 	       (skb = skb_dequeue(&pf->rq)))
> 		kfree_skb(skb);
> 	wake_up_interruptible(&pf->rwait);
> 
> This has a potential race: skb_queue_tail() releases the queue lock,
> then qlen is read locklessly before skb_dequeue() re-acquires it.
> Another CPU enqueueing concurrently could cause the length check to see
> stale data. This race is benign, as it only causes extra skbs to be
> freed in the worst case.
> 
> Introduce ppp_file_queue_rx_skb() to perform the enqueue, length check,
> and trim atomically under a single pf->rq.lock critical section. As both
> callers have softirq disabled, plain spin_lock() can be used instead of
> _bh()/_irqsave() variants. Since only one skb is enqueued at a time, the
> queue can exceed PPP_MAX_RQLEN by at most one frame, so replace the
> while-loop with an if-statement. While at it, use skb_queue_len()
> instead of open-coding the qlen access.
> 
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>  drivers/net/ppp/ppp_generic.c | 37 ++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 57c68efa5ff8..6ab5011540a0 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -2307,6 +2307,27 @@ static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
>  	return !!pchb;
>  }
>  
> +/* Queue up and deliver a received skb to userspace.
> + * Must be called in softirq.
> + */
> +static void ppp_file_queue_rx_skb(struct ppp_file *pf, struct sk_buff *skb)
> +{
> +	spin_lock(&pf->rq.lock);
> +	__skb_queue_tail(&pf->rq, skb);
> +	/* limit queue length by dropping old frames */
> +	if (unlikely(skb_queue_len(&pf->rq) > PPP_MAX_RQLEN)) {
> +		struct sk_buff *old = __skb_peek(&pf->rq);
> +
> +		__skb_unlink(old, &pf->rq);
> +		spin_unlock(&pf->rq.lock);
> +		kfree_skb(old);
> +	} else {
> +		spin_unlock(&pf->rq.lock);

Note that after __skb_queue_tail(), skb_queue_len(&pf->rq) could be ==
PPP_MAX_RQLEN + 2, due to the slightly different check in
ppp_prepare_tx_skb().

I think the above it could/should be simplified to:
	while (unlikely(skb_queue_len(&pf->rq) > PPP_MAX_RQLEN))
		kfree_skb(__skb_dequeue(&pf->rq));
	spin_unlock(&pf->rq.lock);

And possibly it would make sense to consolidate the test in
ppp_prepare_tx_skb(), too for consistency - in that case an `if`
statement should become enough.

/P




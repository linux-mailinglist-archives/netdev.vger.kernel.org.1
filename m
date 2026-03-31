Return-Path: <netdev+bounces-273595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP/CFdS0y2kpKAYAu9opvQ
	(envelope-from <netdev+bounces-273595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:49:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B1B36917C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E07B306F788
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D383B52E7;
	Tue, 31 Mar 2026 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jzcz5EmG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nhii7LEG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA442BB13
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957186; cv=none; b=N0V1+U6cBZQBPZugtvuIHSBL7YiKFNc9bPwRpuDlsSk9NKu3/XPPeESgXE2DVLX4CiuLI5epVRrQ4qvGpcbU7pVfZwdWJJPwd7F/e4m0gKEnPe2Y0NHvuCJ5zPRYnK7izqi0MkBnjotSvcpgD2DKR4KLYF4wPp/IhQSIZq0fIPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957186; c=relaxed/simple;
	bh=6yZHMQHVo8YVl8AsJX1iCtaWwhzI9ucmsMAwk9i5M2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOWfY4QoikGDSJW0YBbGTBMZVpR9oAKr0ZcNIG07OygS9zYZbc5y6y6kPL2o3h2LpKXXfLCdEhAeQ4B6n13epMrD+zc6rTjaOL1i255OyMXHwuD4aYOvaA8x5neFrUrFYcYnTnwDHEHDnG67uRuywWQ7X1cOa4HFd2vOsIdtMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jzcz5EmG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nhii7LEG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774957183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gADZZTexDzvWNBXMgH5zi3qFnaBQBcWJbydn4Yeb0PQ=;
	b=Jzcz5EmGfvA5bGdZEEKV8EE2ayhBj6zLbBolgcaBJDN1jdiAyQ207WQoc7jDTReS15ltBx
	LnJBg39X8W8D3tuC70a7Ixh4wu7NXmUNqvSttlLvVCs0HCdIzELhyqd3LtdKcowqF9ON23
	i4d+Bc3ns+GnJKmwspDIPrXVFlH6q8A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-ALwbHEXLMxKyhlp0rV4ciA-1; Tue, 31 Mar 2026 07:39:42 -0400
X-MC-Unique: ALwbHEXLMxKyhlp0rV4ciA-1
X-Mimecast-MFC-AGG-ID: ALwbHEXLMxKyhlp0rV4ciA_1774957181
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so61134625e9.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774957181; x=1775561981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gADZZTexDzvWNBXMgH5zi3qFnaBQBcWJbydn4Yeb0PQ=;
        b=Nhii7LEGdCVZaV+AI0+7nV9gyb4Aw42DoEXQGLR6KrJ1D2bENO3m8n3gtP8ZC8zhPL
         mXeQmxHnX4Zi9QPICa0DsK9nHhc2e/7IQ04vEUlg/yMw4c2dtHkUvqHNJwedBcuIrWf1
         fHuedONtUlXBTGe39ZVcKaRVOTIjzvboMUX7v25DScXzLJDZ3nqW3q7aWkzzWHDe4Jg+
         dhk0IqFwwDJP1/na6/Th1h+HzDaR+y2ZLjBfTTo7aKrRjJaRUV9HbrtGhodhJdHpAdmg
         U5zokT07hqLY23OZL4p+t+0PfGdaX33gJCyCI2GnaZFRqne8wUv6YiUUvRulp39X2key
         cM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774957181; x=1775561981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gADZZTexDzvWNBXMgH5zi3qFnaBQBcWJbydn4Yeb0PQ=;
        b=Y6HdafwiZosR5C58hDRXOd09aCTRGNtZiyJzYdDYQdi55NYcjLQfx8Q9tcw28tZkNN
         hTU/E44Jzzvt2O9zcd52zfwjHiaLTXX89k5W3W9D1b8379uvi6NY0Z2pHa2FxDrdVkK8
         ZIZZXBX0kYpG0vOZ5H9bTm2B9T5M1XozdYezpKj+jLwnNYQwun7BulDpYWBklSxs3xNu
         4scynBDPdAazjsGmYCPRSRqfc8aG/sDzrW2HPa2SBtIemk6zeYT9FuKAPzYpxQac1WoN
         OBdqkplKetOPzBkDM6LPtEuZKWKZdAct9FWdtogjVbEWjujHjXJckeDyuVDgPVTogLrX
         yD+w==
X-Gm-Message-State: AOJu0YygoDNp1Wma5bqWGDVi+/yafGYkd1iEbqkBDesq3ReGdE0xhvJR
	i8GBiYUaCP/73FSZ9oual26f7WR6t0cwatUuLSJ7A+r4P3fj7UHzlUA+7zqMQpUNgwXTXQQEi9K
	rDuhb6oAipSzq7PfdoAu5cBNDWy9fUnb5oQY/hYB2nwVVgpVIrJlq9w4GoA==
X-Gm-Gg: ATEYQzzY509m1AJGZXYfz9zytVSGoU4SoVjub1BRRvWQ070YQJ0OokxI9eMfcp0vPGc
	7nR0mOQ90vFHcMxW/OFLiAmPMuPjsLWiplVMY/JbHNJvbL0V3nGrA1FQKw71OqK2af0Ul5kOJOq
	Pj0rg1tVNmZotXI6aYQd27ObQZWZdzxfjV771SXXFz8hJ8V77ZlBSDrJLMXnbc7ueh14fpc+iQ3
	VCHcJBHmh67/xshrwZ9cCZVTs9KiXISznXOjcv5B26X6kNS5XmV4SF7748k2XMyqlX0ZO0auZvE
	WtYoQbzdGywRwYmtbMhg2LqoSLe0AFkYPDxdh/xtfTX88sXODje/cwuyrJoL7d51MbzTIDaEtuU
	E50KljXPia7VXej12OB2bPtl3tf7T6DtuerrvC4KFCpGtMXPHRD2XwZwB
X-Received: by 2002:a05:600c:a00a:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-48727ea275emr256350065e9.13.1774957180863;
        Tue, 31 Mar 2026 04:39:40 -0700 (PDT)
X-Received: by 2002:a05:600c:a00a:b0:486:fcc7:d6a with SMTP id 5b1f17b1804b1-48727ea275emr256349515e9.13.1774957180365;
        Tue, 31 Mar 2026 04:39:40 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c77df84sm21683995e9.4.2026.03.31.04.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 04:39:39 -0700 (PDT)
Message-ID: <edbd653e-d7dc-4c49-a5fd-1954a8b21770@redhat.com>
Date: Tue, 31 Mar 2026 13:39:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net: add sysctl to toggle napi_consume_skb()
 alien skb defer
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, kuniyu@google.com,
 stfomichev@gmail.com
Cc: netdev@vger.kernel.org
References: <20260327153347.98647-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260327153347.98647-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-273595-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.958];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enp2s0f1:email]
X-Rspamd-Queue-Id: B0B1B36917C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 4:33 PM, Jason Xing wrote:
> Commit e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
> defers freeing of alien SKBs (alloc_cpu != current cpu) via
> skb_attempt_defer_free() on the TX completion path to reduce cross-NUMA
> SLUB spinlock contention to improve multi-queue UDP workloads.
> 
> However, this unconditionally impacts the napi_skb_cache fast recycle
> path for single-flow / few-flow workloads (e.g. AF_XDP benchmarks[1]):
> when the TX completion NAPI CPU differs from the SKB allocation CPU,
> SKBs are deferred instead of being returned to the local napi_skb_cache,
> forcing RX allocations back to the slow slab path.
> 
> The existing net.core.skb_defer_max=0 could disable this, but it is a
> global switch that also disables the defer mechanism in TCP/UDP/MPTCP
> recvmsg paths, losing its positive SLUB locality benefits there. AF_XDP
> can co-exist with other protocols. That's the reason why I gave up
> reusing skb_defer_disable_key. Besides, if the defer path is disabled,
> that means TCP/UDP/MPTCP in process path will trigger directly freeing
> skb with enabling/disabling bottom half(in kfree_skb_napi_cache())
> which could affect others. So my thinking is not to touch this path.
> 
> Add a dedicated sysctl net.core.napi_consume_skb_defer backed by a
> static key to selectively control the alien skb defer feature. Let
> users decide which is the best fit for their own requirements.
> 
> This patch also avoids touching local_bh* pair(in kfree_skb_napi_cache())
> to minimize the overhead.
> 
> [1]: taskset -c 0 ./xdpsock -i enp2s0f1 -q 1 -t -S -s 64
> 1) sysctl -w net.core.napi_consume_skb_defer=1 (as default)
>  sock0@enp2s0f1:1 txonly xdp-skb
>                    pps            pkts           1.00
> rx                 0              0
> tx                 1,851,950      20,397,952
> 
> 2)sysctl -w net.core.napi_consume_skb_defer=0
>  sock0@enp2s0f1:1 txonly xdp-skb
>                    pps            pkts           1.00
> rx                 0              0
> tx                 1,985,067      25,530,432
> 
> For AF_XDP scenario, it turns out to be around 6.6% improvement.

I'm not a big fan of multiple tunables around the same feature, but
possibly here the use-case extends beyond AF_XDP right? Do you observe
some measurable positive delta even with UDP? Possibly even with TCP,
when the bottleneck is the sender?

More data would be helpful.

> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
> V2
> Link: https://lore.kernel.org/all/20260326144249.97213-1-kerneljasonxing@gmail.com/
> 1. reuse proc_do_static_key() (Eric)
> 2. add doc (Stan)
> ---
>  Documentation/admin-guide/sysctl/net.rst | 13 +++++++++++++
>  net/core/net-sysfs.h                     |  1 +
>  net/core/skbuff.c                        |  5 ++++-
>  net/core/sysctl_net_core.c               |  7 +++++++
>  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> index 0724a793798f..42e06f93306f 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -368,6 +368,19 @@ by the cpu which allocated them.
>  
>  Default: 128
>  
> +napi_consume_skb_defer
> +----------------------
> +When set to 1 (default), napi_consume_skb() defers freeing SKBs whose
> +allocation CPU differs from the current CPU via skb_attempt_defer_free().
> +This reduces cross-NUMA SLUB spinlock contention for multi-queue workloads.
> +
> +Setting this to 0 disables the defer path in napi_consume_skb() only,
> +allowing SKBs to be returned to the local napi_skb_cache immediately.
> +This can benefit single-flow or few-flow workloads (e.g. AF_XDP TX)
> +where the defer detour hurts the fast recycle path.

I think it should be clarified that skb_defer_max takes priority, i.e.
no defer with skb_defer_max == 0. Also it would be great if you could
additional extend skb_defer_max documentation noting that 0 disable such
feature.

Thanks,

Paolo



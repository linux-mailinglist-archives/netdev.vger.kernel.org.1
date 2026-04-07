Return-Path: <netdev+bounces-276058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGzYEGwl1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:40:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD303B12A2
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CD17303FFF6
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4201439E6CB;
	Tue,  7 Apr 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBSAXmQW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nDrZWR1q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4CB3644B3
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576054; cv=none; b=I18DEAa6C/BstwY8xXf2j3RSd469XAX1MckUlfK/9ntJ7u2w4MtFf8JRRkOpX4cK1TIwkcyyuWRX89RrxslIJ17PFQF+C2dDKEFaHgfQPnRiPLEOtsEPUEkidh4cbHbjo/sPm6P40AHli9Lfso0+tu4uQ1R6oX+p8fAugbKltdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576054; c=relaxed/simple;
	bh=emtTneTFVkE4pjmv/p658dZ+xTb6Jw/XAktCB655R80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzBnrVm0wSt8kWRUfP4iFwOLkIDDCEBAP6OgZMcrDU8sHAwXJyjlvusQysT/Jt2Qw9P1HizxPDyyoz7qY9N8aZkF8LVVqzf040WfcLHnju3dUBbDsU0VH18O9fBecG7BWVKGmAbcXDPCQPGV6Wf3dV8w/rksnd4YL5ORfK7t0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBSAXmQW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nDrZWR1q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775576043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18QRVkQOlgUM0SqdTeH58o5Qj8GUKsltIAUn2fzUV8o=;
	b=PBSAXmQWSdWx8ier5sqRi+mErlDfip6JkL5IwfEkF1KsaL2vnCmcn01JA1Wh2zkqrwm6Co
	A/9TtNByCcsq26tttwZllnztJ6nIl9AxkqcrBlsJTsJUXfB88PY7fl4n7M/1pR4PAq6PC8
	GJpNc4HeH2umuIBI2eOUsNJTwlFch8E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-TdOkDxZkP92X8rJ7GwSjnQ-1; Tue, 07 Apr 2026 11:34:00 -0400
X-MC-Unique: TdOkDxZkP92X8rJ7GwSjnQ-1
X-Mimecast-MFC-AGG-ID: TdOkDxZkP92X8rJ7GwSjnQ_1775576039
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488ba2f4094so8393645e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775576038; x=1776180838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18QRVkQOlgUM0SqdTeH58o5Qj8GUKsltIAUn2fzUV8o=;
        b=nDrZWR1q/jjxycuB8lLlWEmp3i8o7KJyGZcGGXa9/c7knK2MQ0z1B3qAR5PF+2xcfG
         llK5aG2fE/FdgFbkvAfe5VgA2vsKsfJr6JI7haJMP5RohtSz6kb5BSAy7Pl2BhKgCT9w
         GFMcRgk+pW0DOW6663sALOBNs37a1mWRBa5F9psJFnSqEFZZ6ZMS6XGvEpQ9peSGZrFb
         3hXA97F1sof2jEKk4kVpusoyJo1Y8teiyvNRqglYz+f6WWRqqq68FoJOtGHeUAUIcnX9
         a93Y2tAQvayYSNknvgiOawV6Cf9qg88epFTOQ3BPBoqTQWzIgZ7t9N/buE9IJYCDCzxe
         KLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775576038; x=1776180838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18QRVkQOlgUM0SqdTeH58o5Qj8GUKsltIAUn2fzUV8o=;
        b=rrg6orFlEy1cHEAVYXHBRQ2whm8HyHgUAppORIJieDOgczhd+zKTKY+V/gRvyDfBnN
         dlTWODiKvfFQ1Ei7blhuwsdV8I6AVS4vCrucw5F8sSdEzgi8fpMkzEyu4B38Lo1XqjES
         fhmeOcsr3Bk+KOTT4qpy/l6DfCJo3OPnJqlOHU625Ec1Zf11kZ/CebsdW+c0E6OJc3R9
         Y7J2ECI75o85FfbwMI/FeshzcdTEkSucYfR4P5FLcBOfXP1K+Ay8JG6XugyMo5vSDtWD
         GYWdSLMa+tMtn0BkVmoXKqJSnAMpIcloH4nf8kh/5DbcjbjGKgMTRHDrmYmWoZI/SnSi
         KdUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe5u5NYIkvxzIjvG/M2hSbhf39ZKIxjKZBPoRGpXUox/EB5L6vvzqvBI7SyO+pZSNaD0c5Qq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCiTR/A/VKc0NLoFuq64/cXIN3LWvyZYnlzugyHarMm6RpSdNB
	JhuAlCtPxB8rhptFm48IhBgPPKA4r1kZ/tdzk9KsBhmxi2a8L631AxBSkcjnZpQuMGLDTDlHwce
	nVuDK0sZtDmFnxDHpthLjXOkLfRWH74xkCJMR5SEZ8uK7MDOkBjA3mFREJg==
X-Gm-Gg: AeBDiet51wrYiVzvEDHvE7DUgWZi7NTqMbWX9FJOD1m7IfHMQF3eBSSQR9dIhoEgOPC
	MtDNrt0oYao5pCqTpgK9r9blVSw0BEYWqnVunpRqdHiRoK7Q24JEKjPPnI4lljLcTTsxMn/Bddm
	S04hjj0SFIMhze6bkIXpDOHCnMKMi41O2fy8al/OoJxa7GwRItzHG5pR+c9m0/qdvXuJosxjCP8
	AZSgVyYAN6wLyZlxgPOms4AvfLrHnBrzxMNT+JH7Mz9ilooJb4+GfUpSA68GiHeEvDe7KTH1MA+
	V1AnmC7tpBxK0Np7dw0879qKqijt4+99lBaEJnQqmqHHb+VbgMeacAyTa/dVA2jqF9eRuq65oXG
	z/zwvUpqha5SXHIKLTmlNT85RCbmcbLE3eeNb3mqobfcX3dX2h4u3mEZFpg==
X-Received: by 2002:a05:600c:5292:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-488996d2309mr260481625e9.5.1775576038171;
        Tue, 07 Apr 2026 08:33:58 -0700 (PDT)
X-Received: by 2002:a05:600c:5292:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-488996d2309mr260480235e9.5.1775576037144;
        Tue, 07 Apr 2026 08:33:57 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e83682fsm588473115e9.7.2026.04.07.08.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 08:33:56 -0700 (PDT)
Message-ID: <0ab00cb4-8335-472d-b43e-3bbd99b41480@redhat.com>
Date: Tue, 7 Apr 2026 17:33:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] net: qrtr: ns: Fix use-after-free in driver
 remove()
To: manivannan.sadhasivam@oss.qualcomm.com,
 Manivannan Sadhasivam <mani@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260403-qrtr-fix-v2-0-f88a14859c63@oss.qualcomm.com>
 <20260403-qrtr-fix-v2-5-f88a14859c63@oss.qualcomm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403-qrtr-fix-v2-5-f88a14859c63@oss.qualcomm.com>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276058-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 8FD303B12A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 6:06 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> In the remove callback, if a packet arrives after destroy_workqueue() is
> called, but before sock_release(), the qrtr_ns_data_ready() callback will
> try to queue the work, causing use-after-free issue.
> 
> Fix this issue by saving the default 'sk_data_ready' callback during
> qrtr_ns_init() and use it to replace the qrtr_ns_data_ready() callback at
> the start of remove(). This ensures that even if a packet arrives after
> destroy_workqueue(), the work struct will not be dereferenced.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  net/qrtr/ns.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index dfb5dad9473c..c62d79e03d64 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -25,6 +25,7 @@ static struct {
>  	u32 lookup_count;
>  	struct workqueue_struct *workqueue;
>  	struct work_struct work;
> +	void (*saved_data_ready)(struct sock *sk);
>  	int local_node;
>  } qrtr_ns;
>  
> @@ -754,6 +755,7 @@ int qrtr_ns_init(void)
>  		goto err_sock;
>  	}
>  
> +	qrtr_ns.saved_data_ready = qrtr_ns.sock->sk->sk_data_ready;
>  	qrtr_ns.sock->sk->sk_data_ready = qrtr_ns_data_ready;
>  
>  	sq.sq_port = QRTR_PORT_CTRL;
> @@ -803,6 +805,10 @@ EXPORT_SYMBOL_GPL(qrtr_ns_init);
>  
>  void qrtr_ns_remove(void)
>  {
> +	write_lock_bh(&qrtr_ns.sock->sk->sk_callback_lock);
> +	qrtr_ns.sock->sk->sk_data_ready = qrtr_ns.saved_data_ready;
> +	write_unlock_bh(&qrtr_ns.sock->sk->sk_callback_lock);

Sashiko says:

---
Does this lock adequately protect against concurrent callback execution?
In the network receive path, __sock_queue_rcv_skb() typically evaluates
!sock_flag(sk, SOCK_DEAD) and invokes sk->sk_data_ready() locklessly,
without acquiring sk_callback_lock or being in an RCU read-side
critical section.
If a thread processing a packet fetches the qrtr_ns_data_ready pointer
and is preempted, could it resume and execute the callback after
qrtr_ns_remove() has already finished destroying the workqueue?
---

There are more remarks from sashiko:

https://sashiko.dev/#/patchset/20260403-qrtr-fix-v2-0-f88a14859c63%40oss.qualcomm.com

AFAICS they are pre-existing issues or false positive, but please have a
look.

/P



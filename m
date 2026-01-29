Return-Path: <netdev+bounces-254735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJmGG3o5e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:42:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10766AEF86
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73819304251C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFB4387365;
	Thu, 29 Jan 2026 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZv+PBDn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lt+EX4vF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBE387360
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682991; cv=none; b=MsygI/Unp3vt0A7j43Qjyno4bDN8jcUCVKHPCVVSIYQ7DlXlTanb6RWtfMwx5fT9rmaFkaFP/eyQNIvQzDfwWrKFKCTorXzLWGx2BWmIdLnprVfk4G6oCa7aA4yRLOxvvtyNbdUUMeOc6oC5A0u7Db2fHBiIvCHJ6TJdhHudEzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682991; c=relaxed/simple;
	bh=ORMq1a98cTwPBAVVEwo/Jio6keLY4fN9LD6pQpnlI1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8yLXbBMhIT6kYoZCdkmFoSZNbqVZKBb3tHE8fLe6vVygpEGhLFhu30Aj5wAClAPx/dJ3+lQesLvY45ngkVbTRzPOLpu7wlnLqcHrfSJXWg6oEhOqa6oN6p3DvwpcYaFL9TFjvML+0I/bFSlMONOXat7VG1qvLSsLwEQ2AP/GJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZv+PBDn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lt+EX4vF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769682989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMoHfRFbbXK/0vhOEDHA+PnSmMGpVXQNKt6LSogbWH0=;
	b=RZv+PBDnGwAkvTkpeQgR5X3YiNkCpX/JVIuqcrRjv6kNktZfHU6RjCAvEhabFXlsmIqBQN
	tUdv/Jt5iT1zcYovoMdZG47Q1+MQcOiDglSRPihZA7Ig5gZyTYz/zBB/MUhpfhd3wpNEqM
	AcI24qgqnTaR+G99k/ZSItvBbqsf1T0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-4kgUwzg9PCKvMYLWyDzlsQ-1; Thu, 29 Jan 2026 05:36:27 -0500
X-MC-Unique: 4kgUwzg9PCKvMYLWyDzlsQ-1
X-Mimecast-MFC-AGG-ID: 4kgUwzg9PCKvMYLWyDzlsQ_1769682987
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48071615686so5810575e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 02:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769682986; x=1770287786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMoHfRFbbXK/0vhOEDHA+PnSmMGpVXQNKt6LSogbWH0=;
        b=lt+EX4vFNhkhSg+dskBFI0EvrJLmR7xq9RzunYz5gGWMb3Jbsz5z4+mt6sVTWvT+vX
         XoS9gWTsv/yjh1g7K8PlJ0Ue85vpNolLUUB84GqZr2JF6E9kyZU0QICwR3Wy6U9uYw9j
         9UA6U4j2z6QAqYQkWMzszm/ibv+pzriOJcrwPswXF/WtAvxGWKbWyT9POrCvbgRbY42b
         RZAluk76mYSqgX10kP0MSzHPJBZ7ehg5NeexqeyywhQhW5/GYMjOIUIJ08NI8hNP7RyR
         9CNImXm/XkpPJc50B61mUaAqFFHu4LhEDhb44J4ub8kz1mlKxXVHNlKi2kQ7MpPcMzw1
         OD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769682986; x=1770287786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMoHfRFbbXK/0vhOEDHA+PnSmMGpVXQNKt6LSogbWH0=;
        b=fBcIj3qPwhs8uExnDkvBh5CWvVCZN34TL1ymhVxr0dFkKH9G5XC3bFQ5T70gF3smk2
         yPUR7Iqn+6L8NDP6et1Paxqhunvz/3O32Hy1vH20uAF/m3HQKLBXF5uGcEdhqC5+OxZo
         hK/Y9vaEFpK2JC1vsLPVJpf8P7m/cteTUzMyn9VRBi8h0mbPxnb4xTKxuPChFfxQ73sB
         7n0zmpCArrfQbt0HXBwH7SCmrN6oXRAwm67Syz9ZQ9GxmUx3Y8XQ5RO3Flq7dG9PA55C
         8FXVkujZ4wcEZQOXe6JD9Ud3q9xWGQAh4GfFAckcIDU/zZ5T2rVMoXeFWqhDn2UiQRUK
         FBsg==
X-Forwarded-Encrypted: i=1; AJvYcCXGHxOQllX2Qe1hDYpirOfil4vweZwayMweYH2bhTKF1qCJt9GjLZRHPmypZ/RSZRpjpM0n2Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7XmE5c0+090wN2kfs30Zph0QkVpHx+0EUNqokW2P/eyKCQuyD
	XGP0jn1Ug/kCW0RJLWR7AdV40kn1WQrH9C55hCePS7xb4YU4QDWcvG02z/vyuwGGRFM1PKFgQ3c
	nVyN/yYylqkNNHKDuV5TRd7gKzgA4HYBTg3X4/4cZC0IYdaBLAk79IkhCmQ==
X-Gm-Gg: AZuq6aJ5ja9Z9WDZXyiwutycp5ZXotil1DeVG4K3buph1yMEuXzRfjDY3BBRl4fXxax
	PILmlYi/XfeLLs4pFU3g2HzBe17pc3nQ6/SJJ5CUNg8V0alJJm5QXz5zQcuLr6mzeEKe5ik3TWl
	SLcrK9vefUPoIcten2EYbM2xKdLK0+RwibHIBHwimfz0RThAhrFVTar4kJXAXMgs7epZpZ6IDRS
	Auhj2PbVUwnMB7EBReceqNgA/Fma897fyI6P3Zg6eMUE3s96TzxMSsANW/IP9yIr9+30hpgdjAY
	+fIKcX/TUSXLv0bvpPkwmJpcCRZy+u0N3INrvsbOTQ2pbXR/K/g/xVP4CpLr5b42xEWmIaNVe1y
	LIePNlQIcD1wF
X-Received: by 2002:a05:600c:1990:b0:47b:deb9:15fb with SMTP id 5b1f17b1804b1-48069c8a660mr114625305e9.33.1769682986543;
        Thu, 29 Jan 2026 02:36:26 -0800 (PST)
X-Received: by 2002:a05:600c:1990:b0:47b:deb9:15fb with SMTP id 5b1f17b1804b1-48069c8a660mr114625035e9.33.1769682986149;
        Thu, 29 Jan 2026 02:36:26 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd78d3sm124547535e9.1.2026.01.29.02.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 02:36:25 -0800 (PST)
Message-ID: <78899cbc-3e1f-4f84-83a1-a2a5e6301c05@redhat.com>
Date: Thu, 29 Jan 2026 11:36:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: sched: sfq: add detailed drop reasons
 for monitoring
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>
Cc: bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 horms@kernel.org, jiri@resnulli.us, edumazet@google.com,
 xiyou.wangcong@gmail.com, jhs@mojatatu.com, carges@cloudflare.com,
 kernel-team@cloudflare.com
References: <176917072608.1186611.11185920960590396939.stgit@firesoul>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <176917072608.1186611.11185920960590396939.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254735-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,toke.dk,resnulli.us,google.com,gmail.com,mojatatu.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10766AEF86
X-Rspamd-Action: no action

On 1/23/26 1:18 PM, Jesper Dangaard Brouer wrote:
> Add specific drop reasons to SFQ qdisc to improve packet drop
> observability and monitoring capabilities. This change replaces
> generic qdisc_drop() calls with qdisc_drop_reason() to provide
> granular metrics about different drop scenarios in production
> environments.
> 
> Two new drop reasons are introduced:
> 
> - SKB_DROP_REASON_QDISC_SFQ_MAXFLOWS: Used when a new flow cannot
>   be created because the maximum number of flows (flows parameter)
>   has been reached and no free flow slots are available.
> 
> - SKB_DROP_REASON_QDISC_SFQ_MAXDEPTH: Used when a flow's queue
>   length exceeds the per-flow depth limit (depth parameter),
>   triggering either tail drop or head drop depending on headdrop
>   configuration.
> 
> The existing SKB_DROP_REASON_QDISC_OVERLIMIT is used in sfq_drop()
> when the overall qdisc limit is exceeded and packets are dropped
> from the longest queue.
> 
> The naming uses qdisc-specific drop reasons tied to SFQ tunables,
> following the pattern established by Eric's FQ commit 5765c7f6e317
> ("net_sched: sch_fq: add three drop_reason") which introduced
> FQ_BAND_LIMIT, FQ_HORIZON_LIMIT, and FQ_FLOW_LIMIT.
> 
> The new drop reasons are inserted in the middle of the enum after
> SKB_DROP_REASON_QDISC_CONGESTED to group all qdisc-related reasons
> together. While drop reason enum values are not UAPI, the enum
> names implicitly become UAPI as userspace tools rely on BTF to
> resolve names to values. This makes middle-insertion safe as long
> as names remain stable.
> 
> These detailed drop reasons enable production monitoring systems
> to distinguish between different SFQ drop scenarios and generate
> specific metrics for:
> - Flow table exhaustion (flows exceeded)
> - Per-flow congestion (depth limit exceeded)
> - Global qdisc congestion (overall limit exceeded)
> 
> This granular visibility allows operators to identify capacity
> planning needs, detect traffic patterns, and optimize SFQ
> configuration based on real-world drop patterns.
> 
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Given the lack of endorsing from any 3rd party, the possible BPF
alternative and the previous controversial conversation, I'm also not
going to apply this change, sorry.

Paolo



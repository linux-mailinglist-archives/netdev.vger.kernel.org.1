Return-Path: <netdev+bounces-178798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619E5A78F3B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28B0169CC2
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9EA1F37D8;
	Wed,  2 Apr 2025 12:57:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE24614375C;
	Wed,  2 Apr 2025 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598657; cv=none; b=uztJQ4A8GP0xsEAlUJM8vk6KiDjlAY0G4Bcqnq3C9h3szFMSfCTapjnvQVqbUiayfTqSjkUIjvw2sc2bid0+mO+clU8M7bZn4va/5VZQPm+Ka+gvP1RPlwki21Bb92cUlJQwbg2rvhJuq7Dobn5txTZ2H1Yid52Vy8iBjEw501A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598657; c=relaxed/simple;
	bh=ik2IjtfURe2w6QhkGLIGVHHi7oVBG/v4rhIczHBQhBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=or2Dix/7IbZZSWUcs/Cy+WfjAhE3BJHKRfFaIwDH+LhmyCA8K40JJrHPJekiU5ZYr47GW1mtn7N0c4G7tzgI6Fc6LRB3k8GDnZ008MmHwroGL28jK2gsKnyC/ynwdByH7Inf6raaX9FawnibXY6PooOWVNZRjlOlhFp3x/o9Yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac29af3382dso1059382266b.2;
        Wed, 02 Apr 2025 05:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743598653; x=1744203453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Bc9VsAJMetdRpVff8gDg9g8fS+wmCMfISwz4BSJKFc=;
        b=oNr1i8TxUuqqdwztvdhrE+dv/Rcvg8AApTAqkzvZjMFZGICeKqdNoVXFJTec+hKO+A
         5ekfGcrpRzmUZnifX/2e584qaH/7MIYF3e6g/44qyz2N28jIXCohG9jkNyoXsbRzfTGD
         Y29acCLdJIXdQSCy4QqXcnm/ospzSJdTrluLGkAWyQWyEtMKqMami48MpO3QTxyUWQXs
         209Y7KcrxK0t5tleT7iE92ie567yU2XFn4NhtYhHQ3X7dRZ/4WrrsZLXcXLiCo19BgkO
         fAxGmzzTe8y6zUwW8UPsBLakzyvqQm2+VbcZcIKNtDl+wIgNbSc3qFbf6N73sZTQB437
         2DfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQxSyWslAzerb0LrzReRivEaEir4K3rYghWLTaH4REseOSRzQZPS1VqyuRSmLRvGKlVMOXx/iCMk5i280R3zD3VO6b@vger.kernel.org, AJvYcCXMBOixNEY9aHpBR/QKJJRbJ13irB6RK/qIoEBJPW4UKToOouRSdNgeJ9nqhvOwoLESuMfgUBrx@vger.kernel.org, AJvYcCXsZbbxlCKZKpoQugAqaPDizCx9/1477wVVtv/YhhgnOVekYpedVlqi3EhcYKDpfzue6sd8YSXrN3gU914=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxubyo9aj79UJu+u+9xASb2OX+nYqpXCPhOfd6WRLvR7xdf8aVA
	mzkeYUxlenR11wG7TDNev49bUHxp2n2QX/UrY6egR75gdwgzrkxW
X-Gm-Gg: ASbGncvyEBAPPcIxykurnFMQLfwOyT8rpKfGgf7bfA9d6fUszCygsFjZqYLjCZooEiA
	l/ICOwd8k5RqP/F+7A3EWJSX5UKQ4cEDMTQC48BbCa3NIbLngB4zR19RZ7t+ZqJH8+Rd/7i6lKo
	ylEqBaX2Tyze1dgY4wBN2RTfU/eGWrGqSHc5LQ+XAljy3/8oVsmHNdoIYTSYjTIpqg73bnSDwKO
	95+RdlkSazPaxfjhEfczoNyUMPlJqVGFH4iw9wB6pkYlr+cSKziaEVmBxLzbNsO5DUcQTetu8t4
	8oih1mn2cW6dq9DjIpOTNBqwi0F0wVSKqf0=
X-Google-Smtp-Source: AGHT+IG/4wIl4JPN2dyUkFqJKwxxqJ6DEsuqTShNQ5zbZO5406Jee3HyER5pg/ol2fkpYHdrv5rFmg==
X-Received: by 2002:a17:907:7fac:b0:ac4:4d6:ea0a with SMTP id a640c23a62f3a-ac738a91226mr1624681066b.27.1743598652885;
        Wed, 02 Apr 2025 05:57:32 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961fdfbsm909965066b.113.2025.04.02.05.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 05:57:32 -0700 (PDT)
Date: Wed, 2 Apr 2025 05:57:29 -0700
From: Breno Leitao <leitao@debian.org>
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com, yonghong.song@linux.dev
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Message-ID: <Z+00OTntj9ALlxuj@gmail.com>
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org>
 <20250226-cunning-innocent-degu-d6c2fe@leitao>
 <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org>
 <20250226-daft-inchworm-of-love-3a98c2@leitao>
 <CANn89iKwO6yiBS_AtcR-ymBaA83uLh8sCh6znWE__+a-tC=qhQ@mail.gmail.com>
 <70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org>

On Wed, Feb 26, 2025 at 11:31:49AM -0700, David Ahern wrote:
> On 2/26/25 11:27 AM, Eric Dumazet wrote:
>
> ie., moving the tracepoint to tcp_sendmsg_locked should solve the inline
> problem. From there, the question is inside the loop or at entry to the
> function. Inside the loop has been very helpful for me.

I am happy to get it inside the loop. I am planning to send the
following patch when the MW opens. How does it sound?


    trace: tcp: Add tracepoint for tcp_sendmsg_locked()
    
    Add a tracepoint to monitor TCP sendmsg operations, enabling the tracing
    of TCP messages being sent.
    
    Meta has been using BPF programs to monitor tcp_sendmsg() for years,
    indicating significant interest in observing this important
    functionality. Adding a proper tracepoint provides a stable API for all
    users who need visibility into TCP message transmission.
    
    David Ahern is using a similar functionality with a custom patch[1]. So,
    this means we have more than a single use case for this request.
    
    The implementation adopts David's approach[1] for greater flexibility
    compared to the initial proposal.
    
    Link: https://lore.kernel.org/all/70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org/ [1]
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 1a40c41ff8c30..cd90a8c66d683 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -259,6 +259,29 @@ TRACE_EVENT(tcp_retransmit_synack,
 		  __entry->saddr_v6, __entry->daddr_v6)
 );
 
+TRACE_EVENT(tcp_sendmsg_locked,
+	TP_PROTO(struct msghdr *msg, struct sk_buff *skb, int size_goal),
+
+	TP_ARGS(msg, skb, size_goal),
+
+	TP_STRUCT__entry(
+		__field(__u64, skb)
+		__field(int, skb_len)
+		__field(int, msg_left)
+		__field(int, size_goal)
+	),
+
+	TP_fast_assign(
+		__entry->skb = (__u64)skb;
+		__entry->skb_len = skb ? skb->len : 0;
+		__entry->msg_left = msg_data_left(msg);
+		__entry->size_goal = size_goal;
+	),
+
+	TP_printk("skb %llx skb_len %d msg_left %d size_goal %d", __entry->skb,
+		__entry->skb_len, __entry->msg_left, __entry->size_goal)
+);
+
 DECLARE_TRACE(tcp_cwnd_reduction_tp,
 	TP_PROTO(const struct sock *sk, int newly_acked_sacked,
 		 int newly_lost, int flag),
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ea8de00f669d0..822cd40ce2b7f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1160,6 +1160,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (skb)
 			copy = size_goal - skb->len;
 
+		trace_tcp_sendmsg_locked(msg, skb, size_goal);
+
 		if (copy <= 0 || !tcp_skb_can_collapse_to(skb)) {
 			bool first_skb;
 


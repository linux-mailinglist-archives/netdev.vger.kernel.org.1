Return-Path: <netdev+bounces-179033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B75AA7A209
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 13:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F408166E3B
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC7024BD0C;
	Thu,  3 Apr 2025 11:38:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5C11F3BBF;
	Thu,  3 Apr 2025 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743680315; cv=none; b=iQ12hQPfVULicIxUACjr5efTFTgTwdZRYNV+9l1clSY+X9rffBhfav6vSqzNB4PzsR0ApHRXvB0+zEfNelZbGMSK2JDsrWuAGEeA2OoC8An+4I8hleKnSyGK328wAjhEasqJvW/bnH22Cxm3K/+NGPEZgqFhreYrWP2aTz5X+Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743680315; c=relaxed/simple;
	bh=P3qwWWIgJHkRaufVV8NzHGpCkb+treg1SBhZAXvUWAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R08RSXp2xHW5i6tqUDFzEd5LSHhxt378k/+ldXd76cmHSoklZncz6Nbb2RK58pscBOBgGxFhp+0XcGe5ufexYEfLd2gdtTzkBFX7XgNzDLJk8H/KV3QwTAQFI/MZghw2FuCr6Nh4HtX21cKYxUJM76EA5PAow5ZXKI3DeUYKqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac29fd22163so132107166b.3;
        Thu, 03 Apr 2025 04:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743680312; x=1744285112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRCkuNY75WbEzCCWBT9Lg3aLlVfJzuDRCusVmtZ/vHY=;
        b=rL4AY00G0RTETmO4BSmi2p6H36Y4CSOZQGVNLyhCnGxTd+t7pOLQtvkY3W0IbqJTK/
         bhdGVZXknhdOoZM+4IlOh1sP6HPgE53Bs2EqpmXdKGFSzkzj4lmKQzoPldFFsjyf4Nj+
         ypAjw4HEq5MoXJesg88j5vk+O57Hn9DdxnUVfjO4fELFqs0wA52fe4dbNB9mTufb+MpE
         UwLKJv3V4pFp+oE0zc5jEzqqXy2x7EqV+7OTMDOhH91xGnllBF1Qy3cNzFTSPlXLUD97
         uzHJ13qG6ljZe0J03O4xqIbulE+aWPnZCOWznj9hU+na9Grqz+nXRNHN2uLTPRLBaiui
         unrw==
X-Forwarded-Encrypted: i=1; AJvYcCWAInvJatnk4/83LsTBRuohwyrQ1hl5Odf6z8k2o/PtQfo+1/w0899K3VoiK/fFkdqrDPmzWASf@vger.kernel.org, AJvYcCXIESi0GvKXSirZESU04v7+FiOpEsFqZFwIFgtemVy5VH5StkQbRZNAuLXl3n41Wu2/CTLnK36imqPqlyAHjV0Gmfth@vger.kernel.org, AJvYcCXqYPR94tyITYjyIDE27fG7iQGmwd0OvlBtMb5pJ9jxcuBmlGoxp0fZVHgINQt0dfxKcKxEdZHNOp81ATQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypYiSrAjYdhhCdmgX2vhWOe+5CeP++2oFCQJJN4+CGHDfg6vOz
	Q08Dns7u+jM3vBo3E9AeJdvBwN4pivToyPQiMRvGtIW9UnAbc4JX
X-Gm-Gg: ASbGncvUJvMjn3/WIbFqdiRNtLbBA738lRaDG3SDJyfVk8V9w8MPPHYdao6T7msDhls
	4mjg8oj7sTktP0rSS+GCw5y7Cq8PVuRc1fQMnXOMKEPxT4GuIrQRWVXBT5E6Jp1yRbgqRs4Om/s
	2ne7KCLQniRKJUaR2JkfAgKLGiiUTvq3Y72gUo7KjlrIBJ/3qE+vMEy7tKvzxmQRnWZdVEdShtb
	VczUpuvF3zvrixV3zoMn31Ej7jU3V8IzPTYI9EAj2Get8POp9s9j8/w8D9X5y1a6CoqF4nhbLSJ
	CQiADxhmpWsD58k6LhCGkSN9ecaV8JbabgWax+Rt1JvNLZE=
X-Google-Smtp-Source: AGHT+IEzvD+fYUGQYhPsJoKz3xY4LFiZgNK2IcOx8AdDi/GNrdhsUzb0qBe0jyLBvR62xMHydj7VFw==
X-Received: by 2002:a17:906:16cc:b0:ac7:3912:5ea7 with SMTP id a640c23a62f3a-ac739125f2bmr1484800366b.60.1743680311538;
        Thu, 03 Apr 2025 04:38:31 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01bdf2bsm77835666b.162.2025.04.03.04.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 04:38:31 -0700 (PDT)
Date: Thu, 3 Apr 2025 04:38:28 -0700
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
Message-ID: <Z+5zNB6FO51CwlMW@gmail.com>
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org>
 <20250226-cunning-innocent-degu-d6c2fe@leitao>
 <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org>
 <20250226-daft-inchworm-of-love-3a98c2@leitao>
 <CANn89iKwO6yiBS_AtcR-ymBaA83uLh8sCh6znWE__+a-tC=qhQ@mail.gmail.com>
 <70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org>
 <Z+00OTntj9ALlxuj@gmail.com>
 <102dfbdc-4626-4a9c-ab8a-c8ce015a1f36@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102dfbdc-4626-4a9c-ab8a-c8ce015a1f36@kernel.org>

On Wed, Apr 02, 2025 at 08:11:03AM -0600, David Ahern wrote:
> On 4/2/25 8:57 AM, Breno Leitao wrote:
> > diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> > index 1a40c41ff8c30..cd90a8c66d683 100644
> > --- a/include/trace/events/tcp.h
> > +++ b/include/trace/events/tcp.h
> > @@ -259,6 +259,29 @@ TRACE_EVENT(tcp_retransmit_synack,
> >  		  __entry->saddr_v6, __entry->daddr_v6)
> >  );
> >  
> > +TRACE_EVENT(tcp_sendmsg_locked,
> > +	TP_PROTO(struct msghdr *msg, struct sk_buff *skb, int size_goal),
> 
> How about passing in the sk reference here; not needed for trace
> entries, but makes it directly accessible for bpf programs.

Right, so, without the trace entries, the output of
/sys/kernel/debug/tracing/events/tcp/tcp_sendmsg_locked/format
doesn't show it, right?

	field:__u64 skb;	offset:8;	size:8;	signed:0;
	field:int skb_len;	offset:16;	size:4;	signed:1;
	field:int msg_left;	offset:20;	size:4;	signed:1;
	field:int size_goal;	offset:24;	size:4;	signed:1;


This is what I've been testing now:

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
	index 1a40c41ff8c30..21529d5faf3b1 100644
	--- a/include/trace/events/tcp.h
	+++ b/include/trace/events/tcp.h
	@@ -259,6 +259,30 @@ TRACE_EVENT(tcp_retransmit_synack,
			__entry->saddr_v6, __entry->daddr_v6)
	);
	
	+TRACE_EVENT(tcp_sendmsg_locked,
	+	TP_PROTO(const struct sock *sk, const struct msghdr *msg,
	+		 const struct sk_buff *skb, int size_goal),
	+
	+	TP_ARGS(sk, msg, skb, size_goal),
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
	index ea8de00f669d0..270ce2c8c2d54 100644
	--- a/net/ipv4/tcp.c
	+++ b/net/ipv4/tcp.c
	@@ -1160,6 +1160,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
			if (skb)
				copy = size_goal - skb->len;
	
	+		trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);
	+
			if (copy <= 0 || !tcp_skb_can_collapse_to(skb)) {
				bool first_skb;


Plus this small dependency:

	net: pass const to msg_data_left()

	The msg_data_left() function doesn't modify the struct msghdr parameter,
	so mark it as const. This allows the function to be used with const
	references, improving type safety and making the API more flexible.

	Signed-off-by: Breno Leitao <leitao@debian.org>

	diff --git a/include/linux/socket.h b/include/linux/socket.h
	index c3322eb3d6865..3b262487ec060 100644
	--- a/include/linux/socket.h
	+++ b/include/linux/socket.h
	@@ -168,7 +168,7 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
		return __cmsg_nxthdr(__msg->msg_control, __msg->msg_controllen, __cmsg);
	}

	-static inline size_t msg_data_left(struct msghdr *msg)
	+static inline size_t msg_data_left(const struct msghdr *msg)
	{
		return iov_iter_count(&msg->msg_iter);
	}

Thanks for your help,
Breno


Return-Path: <netdev+bounces-180394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 980B3A8132D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD4B7B63DE
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C8E23C8C1;
	Tue,  8 Apr 2025 17:01:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B34238D39;
	Tue,  8 Apr 2025 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131672; cv=none; b=bJ/5vWMPGVhAwimNcsz56OagY4UhXKYzJX0aeircBJC3SH5sbymR7+eGbAgu3FmkFxF+vlcxDLixtRhDMFa3DjTUQz/qlAKgJg54W5wV3RGkX6sgBjH3NYixgpTjZYGOrCu16I/0ZddZoiIB8Gc2ml/34URR7B5A/8tlZd4jIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131672; c=relaxed/simple;
	bh=WgAC3NdMaIecTLeADsVuS5ebef9u2457qsKF7XllYzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGRE0e9PXwzXWZaTjKlapYBxHZnztppEpdYmIWIxXyIy26hUtyX9EvlmOhzE+4U37GCk3QZ0KZiQABP4dAD0TmfM0Pc/LENUQeHwh8XguJ5n+P3ARfTHm3VD5HK13IcrDCltLzR4fOtP9HENz/N045ythtQVEOz+NL1jEqyhESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso669746766b.3;
        Tue, 08 Apr 2025 10:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744131669; x=1744736469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3loSWOdm7A/muGSbHbp/mlDMJUWeJ6VlPIjx21/XSgA=;
        b=wN8Uuyi3uJJYrwBRQMY7FzUmt+mlZ/O+WW/ImORBiEMzR2JHBVYgU76hkzNxTKHlwp
         V4g/7ZHEu4vXfFTijdIu3CpBvfxkKohWWn+9V4opxJeRXkjioypSWV1c+xp9RXgWSqxv
         bGcE/6j7BofLiTR4pKWR4zZY/rjS1n6mv5TT1QFZ7lFmpugUJ8QpFbOiDg6YAOIBrfRU
         +R6If5SON+DktRlmnpi0/IcsHA+Mt9HMbdcwGuPW/5KiTNnnrS1Tr8Ktzk/Skca3C7Re
         Ovo/ynBMeYoJ5gjYmvoiaBOQhWm02U7P7Z2l51fuLTrQ5m8YgheUp72FtjkgwsL845jN
         g8dw==
X-Forwarded-Encrypted: i=1; AJvYcCUEdm9Tw2fSkrlwWFHeS6WJdjUUMHefUrLacc046hptJNpqtZ6wBpiq8MZ5eXf8U61WR4TemZ/of6enVlc=@vger.kernel.org, AJvYcCVd+b8s++npqtLBILgPdED8j2AQblxBCLB77cMQrrW4ycBybI1ZIGfmrvo2kPyXPcIYdrh73RYBkxM9GLR7YjjaMjJh@vger.kernel.org, AJvYcCVnRId1BGXgUOIQgSoQKPseJJ9bXUM9+h0lPthmrEb1YM3tLaH3ugpW7htIOlDTeroRQglfixEY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv4jcUl0ybxcrQqJjXm6xu+SnyFKN2plCzvtvHP7rFf7ccbzeR
	yj5JD3RHbwnef4ovE8925j5WKxMsGBLmLW7eTtXOsk3619iZdIIF
X-Gm-Gg: ASbGnct/6OI+Q7KurWr7GlYnVOsY6IWjYjhVhTflPxBscQsJavsB5uNKIYJ0Tj0qYLL
	8itjz9OxSf3EMJe406uay3mpNwGiD5mkV51yaKBQlviOt3VoMLQIY0XikJVa+tn0Zc4u4uIljjm
	HcPE+tVjDtQXay2sOCk8mIanphh4PF2L5hd0gn7zHZ6wkfn7XtVEpu2ILg1q/EV+coAPdOrq8PU
	ih+J5WYXNWj5p49T2XgCc3WqvnDKVycL9G4seQhGxr6MZdjhTAcGAEqHQ21cevMT4JBH9mDC0Ry
	KKGRIvv5bbub64FOv3oI7Tny/cmYx1Om
X-Google-Smtp-Source: AGHT+IHDbgqPfbcqHmYeawiEypB+7MDmdtDPRJCMoLpHc5sdwdwL6CJJJT6ib6Kw/XcApllac97xtw==
X-Received: by 2002:a17:907:9801:b0:ac7:33d0:dbe with SMTP id a640c23a62f3a-ac7d18cb7f9mr1744076266b.33.1744131668369;
        Tue, 08 Apr 2025 10:01:08 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01c10dcsm940755466b.180.2025.04.08.10.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:01:08 -0700 (PDT)
Date: Tue, 8 Apr 2025 10:01:05 -0700
From: Breno Leitao <leitao@debian.org>
To: David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kernel-team@meta.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, ncardwell@google.com, netdev@vger.kernel.org,
	pabeni@redhat.com, rostedt@goodmis.org, song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH net-next v2 2/2] trace: tcp: Add tracepoint for
 tcp_sendmsg_locked()
Message-ID: <Z/VWUVk+mHXTENms@gmail.com>
References: <20250407-tcpsendmsg-v2-2-9f0ea843ef99@debian.org>
 <20250408010143.11193-1-kuniyu@amazon.com>
 <Z/UyZNiYUq9qrZds@gmail.com>
 <b85ddaa3-6115-466c-8fc9-84b58d55e4b4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b85ddaa3-6115-466c-8fc9-84b58d55e4b4@kernel.org>

On Tue, Apr 08, 2025 at 09:16:51AM -0600, David Ahern wrote:
> On 4/8/25 8:27 AM, Breno Leitao wrote:
> > 
> > 	SEC("tracepoint/tcp/tcp_sendmsg_locked")
> 
> Try `raw_tracepoint/tcp/tcp_sendmsg_locked`.
> 
> This is the form I use for my tracepoint based packet capture (not tied
> to this tracepoint, but traces inside our driver) and it works fine.

Thanks. I was not able to get this crashing as well. In fact, the
following program fails to be loaded:

	SEC("raw_tracepoint/tcp/tcp_sendmsg_locked")
	int bpf_tcp_sendmsg_locked(struct bpf_raw_tracepoint_args *ctx)
	{
		void *skb_addr = (void *) ctx->args[0];

		bpf_printk("deref %d\n", *(int *) skb_addr);

		return 0;
	}

libbpf refuses to load it, and drumps:

	libbpf: prog 'bpf_tcp_sendmsg_locked': BPF program load failed: Permission denied
	libbpf: prog 'bpf_tcp_sendmsg_locked': -- BEGIN PROG LOAD LOG --
	0: R1=ctx() R10=fp0
	; void *skb_addr = (void *) ctx->args[0]; @ tcp_sendmsg_locked_bpf.c:18
	0: (79) r1 = *(u64 *)(r1 +0)          ; R1_w=scalar()
	; bpf_printk("deref %d\n", *(int *) skb_addr); @ tcp_sendmsg_locked_bpf.c:20
	1: (61) r3 = *(u32 *)(r1 +0)
	R1 invalid mem access 'scalar'
	processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
	-- END PROG LOAD LOG --
	libbpf: prog 'bpf_tcp_sendmsg_locked': failed to load: -13
	libbpf: failed to load object 'tcp_sendmsg_locked_bpf.o'
	Failed to load BPF object: -13

> As suggested, you might need to update raw_tp_null_args

Thanks for confirming it. I will update raw_tp_null_args, assuming that
the problem exists but I am failing to reproduce it.

I will send an updated version soon.

Thanks
--breno


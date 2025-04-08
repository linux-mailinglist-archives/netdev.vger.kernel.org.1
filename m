Return-Path: <netdev+bounces-180413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50D0A8143C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42729423986
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645AC23C8C7;
	Tue,  8 Apr 2025 18:06:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C71DE4C8;
	Tue,  8 Apr 2025 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744135574; cv=none; b=XwMo0OKyA/LqhssSxotnndtgVOZsYXv6SwQJ+BR9lfoQNtPL9gIMSnOuEI0wbbWxlSlh4JzhZnh0ks8pbwXdvQW6ZeWOgD14c/0DKhNAoTlbPHJR9xzfejR7+H1ERWTj8B/Q5oZaZLvB8M2lcIY575ZgEa8js4dRCP7ihl7Gug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744135574; c=relaxed/simple;
	bh=MEM3eLWv8YwIwPSTBm2ajJ9VUi67Pzml5rfhOmKhVo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5fyaLTtMTGXLPjU2+EIG2KsI3MdSyWYBhAOc4Y1ruhtquTeOYwDyIXywT5Y6TgrDvkmA3mY69eMigtg4wB0nzsXiYgcWpBqzItIRt2rPmPzQ7GPgtRmLcc78/RcLuBYTMWBUX5lDA4xI5JwCMxPe2HUQedj+x4FD7MgIDoEsLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac7bd86f637so1060650566b.1;
        Tue, 08 Apr 2025 11:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744135571; x=1744740371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQ7WvhSaBKz65YTYircyVA6dGRl86ZCozAY66YUdD6U=;
        b=p2dBEAmDaZb+sL8dYlnS9HDQDRRDSgz6M5TELKVIY1OOxQVp48zs2hNXtM2UYMGwbo
         7C7WR/OyxaCdJax9Hb2v3K4PM3no184H6F9Pli+4L9LeR6HN92yRdggsclwpzO1/cp40
         vJQrimUxmWRyvKlXxtmI5SiISGt+3NNfp9K7GeDe7oW4Uo5KfNxVDIzqjHWnVoCnBIaq
         n842+NZliGet4qLsTEADjVnlqGTDlPzPNpPwb+9x2lMAQDqBZ/RmEwBsdQmdopaphPfw
         plURmBkq3KBCBg8+fQaakboNaXLdoL2XvX2YsOdI55nKbNdc9n/t22Euqj/BxT9KAjIW
         GQFA==
X-Forwarded-Encrypted: i=1; AJvYcCVArnbb7nflEADh4FvsqwWWrshQpSkOHQh438nv0lVrFwbhmd2MwD5TAY1IcqqlqQbDxo8Ju/o1@vger.kernel.org, AJvYcCW7D//d3afnC+YU4A90FtnymMUwotfBImwbWrzHeGyGnZS+KW8DVxy4t7HXccjIn+tX9q1Ej8ICZdfCLwU=@vger.kernel.org, AJvYcCWff7d1Wd3eS7RDpSfS0E1owFp1epqftT3NHJhMIPMSEO4rxvG7HNhgKbHULtS2IzPK2w+BI2M34mF+x29Ud/rx8PpR@vger.kernel.org
X-Gm-Message-State: AOJu0YxPjdwUUsymngLdIjj9rseb4OVSQ36+ZtysNq0u4lHFvNnPYckS
	47jF97FB2oX4k6m9ION9sog6xQmGJIs0jwjlQDbMH9lWh+9sy7P1
X-Gm-Gg: ASbGncuInjuLw+t41CG06lS8lI2EGGTjLUjjPZfIc+MCmQtO1qx7Kpw2bLNw0bXEgjo
	klM9pWm3RbJkeLgY3hg0kVGNLXNf40s8o3x7LvRY8GIbwfW/obkaj8tDTFZM8yn0Vihci7biRzD
	4PY5vtlUX9crHkHapHwBbf9HGX2JsJOpw/XgcdB3lym76qpBQ9tbN1PkJUsDhDyZjnPBFr8KY21
	ExvxP/7XPvP7fEA8vyqY+MFACo1uIaxTmr2v1jnQjlAB+vdrZHeZFB2emSbWaMzLnRmtsyMOWUY
	tAJiu7sqtAoLHxXRs736LHm7uaDId+O/K6rS
X-Google-Smtp-Source: AGHT+IE7XyApbMkoq5dPAWGYwa2E3548c5jkf6HBcy+ewPwX4TKbincTREYaKorp7jTpFIKpzJxkQw==
X-Received: by 2002:a17:907:7f0b:b0:ac7:b8d3:df9c with SMTP id a640c23a62f3a-aca9bfb1039mr3878766b.1.1744135570441;
        Tue, 08 Apr 2025 11:06:10 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfee46fbsm952504766b.75.2025.04.08.11.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:06:10 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:06:07 -0700
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
	rostedt@goodmis.org, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [PATCH net-next v2 2/2] trace: tcp: Add tracepoint for
 tcp_sendmsg_locked()
Message-ID: <Z/Vlj7KPkwgEgsZu@gmail.com>
References: <Z/VWUVk+mHXTENms@gmail.com>
 <20250408171231.35951-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408171231.35951-1-kuniyu@amazon.com>

On Tue, Apr 08, 2025 at 10:12:14AM -0700, Kuniyuki Iwashima wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Tue, 8 Apr 2025 10:01:05 -0700
> > On Tue, Apr 08, 2025 at 09:16:51AM -0600, David Ahern wrote:
> > > On 4/8/25 8:27 AM, Breno Leitao wrote:
> > > > 
> > > > 	SEC("tracepoint/tcp/tcp_sendmsg_locked")
> > > 
> > > Try `raw_tracepoint/tcp/tcp_sendmsg_locked`.
> > > 
> > > This is the form I use for my tracepoint based packet capture (not tied
> > > to this tracepoint, but traces inside our driver) and it works fine.
> > 
> > Thanks. I was not able to get this crashing as well. In fact, the
> > following program fails to be loaded:
> > 
> > 	SEC("raw_tracepoint/tcp/tcp_sendmsg_locked")
> 
> Try SEC("tp_btf/tcp_sendmsg_locked") and access the raw argument
> (struct sk_buff *skb) instead of bpf_raw_tracepoint_args.

Nice, I was able to crash the host, with the following code:

	SEC("tp_btf/tcp_sendmsg_locked")
	int BPF_PROG(tcp_sendmsg_locked, struct sock *sk, struct msghdr *msg, struct sk_buff *skb, int size_goal)
	{
		bpf_printk("skb->len %d\n", skb->len);

		return 0;
	}

This is the unusually expected stacktrace. :-)

	 BUG: kernel NULL pointer dereference, address: 0000000000000070
	 #PF: supervisor read access in kernel mode                                                                                                                                            "virtme-ng" 11:03 08-Apr-25
	 #PF: error_code(0x0000) - not-present page
	 PGD 10ca78067 P4D 0
	 Oops: Oops: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
	 CPU: 13 UID: 0 PID: 1020 Comm: nc Tainted: G            E    N 6.14.0-upstream-05880-g14fbb7a1a500 #73 PREEMPT(undef)
	 Tainted: [E]=UNSIGNED_MODULE, [N]=TEST
	 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
	 RIP: 0010:bpf_prog_5b31430a4390397c_tcp_sendmsg_locked+0x18/0x37
	 Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 f3 0f 1e fa 48 8b 7f 10 <8b> 57 70 48 bf d8 d9 03 06 01 00 11 ff be 0d 00 00 00 e8 15 f4 4c
	 RSP: 0018:ffa0000003c03bd0 EFLAGS: 00010282
	 RAX: 5aab7562e1de3200 RBX: ffa0000003be4000 RCX: 0000000000000018
	 RDX: 0000000000000000 RSI: ffa0000003be4048 RDI: 0000000000000000
	 RBP: ffa0000003c03bd0 R08: 000000000006043d R09: ffffffffffffffff
	 R10: 0000000000000000 R11: ffffffffa000096c R12: ff11000104ae5b00
	 R13: ff1100010610a3c0 R14: ffffffff814d34ef R15: 0000000000000000
	 FS:  00007fd67d550740(0000) GS:ff110005a40a9000(0000) knlGS:0000000000000000
	 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	 CR2: 0000000000000070 CR3: 000000010d9ec002 CR4: 0000000000771ef0
	 PKRU: 55555554
	 Call Trace:
	  <TASK>
	  ? __die_body+0xaf/0xc0
	  ? page_fault_oops+0x35b/0x3c0
	  ? do_user_addr_fault+0x6d4/0x730
	  ? srso_alias_return_thunk+0x5/0xfbef5
	  ? exc_page_fault+0x5f/0xe0
	  ? asm_exc_page_fault+0x26/0x30
	  ? bpf_trace_run4+0xbf/0x240
	  ? 0xffffffffa000096c
	  ? bpf_prog_5b31430a4390397c_tcp_sendmsg_locked+0x18/0x37
	  bpf_trace_run4+0x14c/0x240
	  ? trace_event_raw_event_tcp_sendmsg_locked+0xc3/0xf0
	  __traceiter_tcp_sendmsg_locked+0x44/0x60
	  tcp_sendmsg_locked+0x10c8/0x15b0
	  ? __local_bh_enable_ip+0x166/0x1c0
	  ? srso_alias_return_thunk+0x5/0xfbef5
	  tcp_sendmsg+0x2c/0x50
	  ? __pfx_inet6_sendmsg+0x10/0x10
	  sock_sendmsg_nosec+0xa0/0x100
	  __sys_sendto+0x1b4/0x1f0
	  __x64_sys_sendto+0x26/0x30
	  do_syscall_64+0x83/0x170
	  entry_SYSCALL_64_after_hwframe+0x76/0x7e


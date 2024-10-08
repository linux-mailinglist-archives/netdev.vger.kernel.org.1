Return-Path: <netdev+bounces-133130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E899511B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2101F27495
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7231DF74E;
	Tue,  8 Oct 2024 14:07:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1384C97;
	Tue,  8 Oct 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396447; cv=none; b=qJcAh/A4dMowAS1d5XU6/4PhJ1WSneph3v0cKC1GXqnRpt1KXrBhkT5srA1zPZIP/HAi5lu9Ckv2cBrjwzXW5NVqJulAqeYtsRF9ymPiRLONwhyjjH2HYOb2KUNoHZN6SKMb00vf0MTHo30N0Djgb72fYKFBVfZMfvfJ+HHpxCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396447; c=relaxed/simple;
	bh=A322TLvDuBc6q3IvYSaYDY+JSLyk0a/pzMibgCmncNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6eH5L09TbZ2QdNw9melG8R/MX90WJ4aHYR0vCQleC4PEnVDatASp2IPaKjJ7DMjn4mRmpzAEd85jt4ywHAtssajVrUY7ig1MgGW1WP5gG7wMQPvyYouPH9/iPJYD/1LOguj7g5ZTGbOKCox68J9pMhR7NBOlk1o99sWBZFt2M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c883459b19so6643362a12.2;
        Tue, 08 Oct 2024 07:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396444; x=1729001244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZtZvBOjDjjOKrZe3zcEiruk4g5UhQ5of6IUEjbKhDU=;
        b=h9ehswTSGK+LOntnezUBccLDyB8z8MN4Qt1iQGMfBzei7+azwXkMgDk3lE95Wzjo1K
         wFI84RTUCLLFbPIyjBJKOWzI2r1D3omrTQBAraRZLsGKwVN6flpLU3Tf/oOersiNwMT6
         FSeT/25RUAN23njU1SNuQHY0HF450zWm7n/D3d1QAojcfL46KB0CiOjZP9N11RZxXgGI
         RecQMmhx9comxO/3CVtylJc1W9L50oaQLBEAFf88eFmKKTdqYW0dYjFvq4G3T86Ew2Ld
         s1dSAlTvBLGzgIDeNWTzfkjO+6eeR8EBSitOivjBD/ZyKCYmlviM+tJ7PR+Jh5Jtio72
         QuAA==
X-Forwarded-Encrypted: i=1; AJvYcCU8n7qHDqYfAvV5beIhRApK6yJ7op1eO7tPP5ukOKhsqfIye944trbjIAC11sONbQvvt+9GG0QI@vger.kernel.org, AJvYcCUQtnq43ds83nEHxMSYS8EUzFL5/udrKiLQKEmDYWlyy7qui6EXFU6dCCyLYH2el2/g5Don2w5n7InOzpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgX75TzGDK7uSisOsHAFikKuiKQUeuEvY7C9aSnUCfmHmHvmDF
	4kmWiMGKaFQazumHWyTPOQpjV1oFHlUGgfGiOFW9wESnjSkXMO7p
X-Google-Smtp-Source: AGHT+IFrHnTsL7P5fCjNM7OeH3Pgj6fE4kG4d1uv2IPt3Ek1mSUbmvABXEMHAkBoo6A+IYj06weYSg==
X-Received: by 2002:a05:6402:234b:b0:5c2:8249:b2d3 with SMTP id 4fb4d7f45d1cf-5c8d2e75c6amr15479743a12.26.1728396443083;
        Tue, 08 Oct 2024 07:07:23 -0700 (PDT)
Received: from gmail.com ([2620:10d:c092:500::7:e36b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05be8d2sm4366479a12.53.2024.10.08.07.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:07:21 -0700 (PDT)
Date: Tue, 8 Oct 2024 15:07:19 +0100
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, rmikey@meta.com,
	kernel-team@meta.com, horms@kernel.org,
	"open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: Optimize IPv6 path in ip_neigh_for_gw()
Message-ID: <ZwU8l8KSnVPIC5yU@gmail.com>
References: <20241004162720.66649-1-leitao@debian.org>
 <2234f445-848b-4edc-9d6d-9216af9f93a3@kernel.org>
 <20241004-straight-prompt-auk-ada09a@leitao>
 <759f82f0-0498-466c-a4c2-a87a86e06315@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <759f82f0-0498-466c-a4c2-a87a86e06315@redhat.com>

Hello Paolo,

On Tue, Oct 08, 2024 at 12:51:05PM +0200, Paolo Abeni wrote:
> On 10/4/24 19:37, Breno Leitao wrote:
> > On Fri, Oct 04, 2024 at 11:01:29AM -0600, David Ahern wrote:
> > > On 10/4/24 10:27 AM, Breno Leitao wrote:
> > > > Branch annotation traces from approximately 200 IPv6-enabled hosts
> > > > revealed that the 'likely' branch in ip_neigh_for_gw() was consistently
> > > > mispredicted. Given the increasing prevalence of IPv6 in modern networks,
> > > > this commit adjusts the function to favor the IPv6 path.
> > > > 
> > > > Swap the order of the conditional statements and move the 'likely'
> > > > annotation to the IPv6 case. This change aims to improve performance in
> > > > IPv6-dominant environments by reducing branch mispredictions.
> > > > 
> > > > This optimization aligns with the trend of IPv6 becoming the default IP
> > > > version in many deployments, and should benefit modern network
> > > > configurations.
> > > > 
> > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > > ---
> > > >   include/net/route.h | 6 +++---
> > > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/include/net/route.h b/include/net/route.h
> > > > index 1789f1e6640b..b90b7b1effb8 100644
> > > > --- a/include/net/route.h
> > > > +++ b/include/net/route.h
> > > > @@ -389,11 +389,11 @@ static inline struct neighbour *ip_neigh_for_gw(struct rtable *rt,
> > > >   	struct net_device *dev = rt->dst.dev;
> > > >   	struct neighbour *neigh;
> > > > -	if (likely(rt->rt_gw_family == AF_INET)) {
> > > > -		neigh = ip_neigh_gw4(dev, rt->rt_gw4);
> > > > -	} else if (rt->rt_gw_family == AF_INET6) {
> > > > +	if (likely(rt->rt_gw_family == AF_INET6)) {
> > > >   		neigh = ip_neigh_gw6(dev, &rt->rt_gw6);
> > > >   		*is_v6gw = true;
> > > > +	} else if (rt->rt_gw_family == AF_INET) {
> > > > +		neigh = ip_neigh_gw4(dev, rt->rt_gw4);
> > > >   	} else {
> > > >   		neigh = ip_neigh_gw4(dev, ip_hdr(skb)->daddr);
> > > >   	}
> > > 
> > > This is an IPv4 function allowing support for IPv6 addresses as a
> > > nexthop. It is appropriate for IPv4 family checks to be first.
> > 
> > Right. In which case is this called on IPv6 only systems?
> > 
> > On my IPv6-only 200 systems, the annotated branch predictor is showing
> > it is mispredicted 100% of the time.
> 
> perf probe -a ip_neigh_for_gw; perf record -e probe:ip_neigh_for_gw -ag;
> perf script
> 
> should give you an hint.

Thanks. That proved to be very useful.

As I said above, all the hosts I have a webserver running, I see this
that likely mispredicted. Same for this server:

	# cat /sys/kernel/tracing/trace_stat/branch_annotated | grep ip_neigh_for_gw
	 correct incorrect  %        Function                  File              Line
	       0    17127 100 ip_neigh_for_gw                route.h              393

It is mostly coming from ip_finish_output2() and tcp_v4. Important to
say that these machine has no IPv4 configured, except 127.0.0.1
(localhost).

Output of `perf script`:

	curl 3284017 [020] 342043.646674: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	curl 3284017 [020] 342043.646720: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_unicast_reply+0x3fc 
		 tcp_v4_send_reset+0x668 
		 tcp_v4_rcv+0xcdf 
		 ip_protocol_deliver_rcu+0x10e 
		 ip_local_deliver_finish+0x97 
		 ip_local_deliver+0x43 
		 ip_rcv+0x35 
		 process_backlog+0x1b8 
		 __napi_poll+0x30 
		 net_rx_action+0x180 
		 __kprobes_text_end+0xf2 
		 __local_bh_enable_ip+0xeb 
		 __dev_queue_xmit+0xc18 
		 ip_finish_output2+0x63a 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	isc-net-0000 3286356 [026] 342055.690384: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_skb+0x15 
		 udp_send_skb+0xd2 
		 udp_sendmsg+0xaa7 
		 __x64_sys_sendmsg+0x338 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_sendmsg+0x4d (/usr/lib64/libc.so.6)

	curl 3288713 [032] 342103.631991: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	curl 3288713 [032] 342103.632039: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_unicast_reply+0x3fc 
		 tcp_v4_send_reset+0x668 
		 tcp_v4_rcv+0xcdf 
		 ip_protocol_deliver_rcu+0x10e 
		 ip_local_deliver_finish+0x97 
		 ip_local_deliver+0x43 
		 ip_rcv+0x35 
		 process_backlog+0x1b8 
		 __napi_poll+0x30 
		 net_rx_action+0x180 
		 __kprobes_text_end+0xf2 
		 __local_bh_enable_ip+0xeb 
		 __dev_queue_xmit+0xc18 
		 ip_finish_output2+0x63a 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	isc-net-0000 3289126 [021] 342115.725482: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_skb+0x15 
		 udp_send_skb+0xd2 
		 udp_sendmsg+0xaa7 
		 __x64_sys_sendmsg+0x338 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_sendmsg+0x4d (/usr/lib64/libc.so.6)

	curl 3291018 [030] 342163.627633: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	curl 3291018 [030] 342163.627673: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_unicast_reply+0x3fc 
		 tcp_v4_send_reset+0x668 
		 tcp_v4_rcv+0xcdf 
		 ip_protocol_deliver_rcu+0x10e 
		 ip_local_deliver_finish+0x97 
		 ip_local_deliver+0x43 
		 ip_rcv+0x35 
		 process_backlog+0x1b8 
		 __napi_poll+0x30 
		 net_rx_action+0x180 
		 __kprobes_text_end+0xf2 
		 __local_bh_enable_ip+0xeb 
		 __dev_queue_xmit+0xc18 
		 ip_finish_output2+0x63a 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	isc-net-0000 3291256 [031] 342175.683527: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_skb+0x15 
		 udp_send_skb+0xd2 
		 udp_sendmsg+0xaa7 
		 __x64_sys_sendmsg+0x338 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_sendmsg+0x4d (/usr/lib64/libc.so.6)

	curl 3293421 [025] 342223.618198: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	curl 3293421 [025] 342223.618239: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_unicast_reply+0x3fc 
		 tcp_v4_send_reset+0x668 
		 tcp_v4_rcv+0xcdf 
		 ip_protocol_deliver_rcu+0x10e 
		 ip_local_deliver_finish+0x97 
		 ip_local_deliver+0x43 
		 ip_rcv+0x35 
		 process_backlog+0x1b8 
		 __napi_poll+0x30 
		 net_rx_action+0x180 
		 __kprobes_text_end+0xf2 
		 __local_bh_enable_ip+0xeb 
		 __dev_queue_xmit+0xc18 
		 ip_finish_output2+0x63a 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	isc-net-0000 3293659 [034] 342235.695019: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_skb+0x15 
		 udp_send_skb+0xd2 
		 udp_sendmsg+0xaa7 
		 __x64_sys_sendmsg+0x338 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_sendmsg+0x4d (/usr/lib64/libc.so.6)

	curl 3295399 [012] 342283.632642: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	curl 3295399 [012] 342283.632691: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_unicast_reply+0x3fc 
		 tcp_v4_send_reset+0x668 
		 tcp_v4_rcv+0xcdf 
		 ip_protocol_deliver_rcu+0x10e 
		 ip_local_deliver_finish+0x97 
		 ip_local_deliver+0x43 
		 ip_rcv+0x35 
		 process_backlog+0x1b8 
		 __napi_poll+0x30 
		 net_rx_action+0x180 
		 __kprobes_text_end+0xf2 
		 __local_bh_enable_ip+0xeb 
		 __dev_queue_xmit+0xc18 
		 ip_finish_output2+0x63a 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	isc-net-0000 3295746 [001] 342295.712436: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_skb+0x15 
		 udp_send_skb+0xd2 
		 udp_sendmsg+0xaa7 
		 __x64_sys_sendmsg+0x338 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_sendmsg+0x4d (/usr/lib64/libc.so.6)

	curl 3298603 [020] 342343.608814: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	curl 3298603 [020] 342343.608858: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_unicast_reply+0x3fc 
		 tcp_v4_send_reset+0x668 
		 tcp_v4_rcv+0xcdf 
		 ip_protocol_deliver_rcu+0x10e 
		 ip_local_deliver_finish+0x97 
		 ip_local_deliver+0x43 
		 ip_rcv+0x35 
		 process_backlog+0x1b8 
		 __napi_poll+0x30 
		 net_rx_action+0x180 
		 __kprobes_text_end+0xf2 
		 __local_bh_enable_ip+0xeb 
		 __dev_queue_xmit+0xc18 
		 ip_finish_output2+0x63a 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	isc-net-0000 3299252 [032] 342355.693816: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_skb+0x15 
		 udp_send_skb+0xd2 
		 udp_sendmsg+0xaa7 
		 __x64_sys_sendmsg+0x338 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_sendmsg+0x4d (/usr/lib64/libc.so.6)

	curl 3303255 [033] 342403.616685: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	curl 3303255 [033] 342403.616729: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_unicast_reply+0x3fc 
		 tcp_v4_send_reset+0x668 
		 tcp_v4_rcv+0xcdf 
		 ip_protocol_deliver_rcu+0x10e 
		 ip_local_deliver_finish+0x97 
		 ip_local_deliver+0x43 
		 ip_rcv+0x35 
		 process_backlog+0x1b8 
		 __napi_poll+0x30 
		 net_rx_action+0x180 
		 __kprobes_text_end+0xf2 
		 __local_bh_enable_ip+0xeb 
		 __dev_queue_xmit+0xc18 
		 ip_finish_output2+0x63a 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	isc-net-0000 3304989 [011] 342415.740580: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_skb+0x15 
		 udp_send_skb+0xd2 
		 udp_sendmsg+0xaa7 
		 __x64_sys_sendmsg+0x338 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_sendmsg+0x4d (/usr/lib64/libc.so.6)

	curl 3312952 [035] 342463.633808: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	curl 3312952 [035] 342463.633859: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_unicast_reply+0x3fc 
		 tcp_v4_send_reset+0x668 
		 tcp_v4_rcv+0xcdf 
		 ip_protocol_deliver_rcu+0x10e 
		 ip_local_deliver_finish+0x97 
		 ip_local_deliver+0x43 
		 ip_rcv+0x35 
		 process_backlog+0x1b8 
		 __napi_poll+0x30 
		 net_rx_action+0x180 
		 __kprobes_text_end+0xf2 
		 __local_bh_enable_ip+0xeb 
		 __dev_queue_xmit+0xc18 
		 ip_finish_output2+0x63a 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	isc-net-0000 3314546 [032] 342475.766762: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_skb+0x15 
		 udp_send_skb+0xd2 
		 udp_sendmsg+0xaa7 
		 __x64_sys_sendmsg+0x338 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_sendmsg+0x4d (/usr/lib64/libc.so.6)

	curl 3321983 [006] 342523.654221: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	curl 3321983 [006] 342523.654262: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_unicast_reply+0x3fc 
		 tcp_v4_send_reset+0x668 
		 tcp_v4_rcv+0xcdf 
		 ip_protocol_deliver_rcu+0x10e 
		 ip_local_deliver_finish+0x97 
		 ip_local_deliver+0x43 
		 ip_rcv+0x35 
		 process_backlog+0x1b8 
		 __napi_poll+0x30 
		 net_rx_action+0x180 
		 __kprobes_text_end+0xf2 
		 __local_bh_enable_ip+0xeb 
		 __dev_queue_xmit+0xc18 
		 ip_finish_output2+0x63a 
		 ip_output+0x73 
		 __ip_queue_xmit+0x504 
		 __tcp_transmit_skb+0xcfe 
		 tcp_connect+0xa1d 
		 tcp_v4_connect+0x463 
		 __inet_stream_connect+0x5b 
		 inet_stream_connect+0x36 
		 __sys_connect+0x8d 
		 __x64_sys_connect+0x16 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_connect+0x4b (/usr/lib64/libc.so.6)
			       0 [unknown] ([unknown])

	isc-net-0000 3323932 [025] 342535.718587: probe:ip_neigh_for_gw: ()
		 ip_finish_output2+0x150 
		 ip_output+0x73 
		 ip_send_skb+0x15 
		 udp_send_skb+0xd2 
		 udp_sendmsg+0xaa7 
		 __x64_sys_sendmsg+0x338 
		 do_syscall_64+0xc2 
		 entry_SYSCALL_64_after_hwframe+0x4b 
		    __libc_sendmsg+0x4d (/usr/lib64/libc.so.6)



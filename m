Return-Path: <netdev+bounces-306588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QdD+Hn8CUWqU9wIAu9opvQ
	(envelope-from <netdev+bounces-306588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:32:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC8B73BC27
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:32:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=PoAmJMis;
	dkim=pass header.d=redhat.com header.s=google header.b="rQVFCpy/";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306588-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306588-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E39C2300722E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919DB2F6184;
	Fri, 10 Jul 2026 14:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E163446C7
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 14:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693236; cv=none; b=hEh2JkkFN4/bB2jpLc4jwtraelqyHbQ+wF0vHET1SZukfR+PbNwOMi964sAwkrR2Gi8MeCaL68IFEC6aNc4dkk8Mpw3djgT8el7km9alM/OfdpY34kHgPFVmbmY/x8v3ThgScp3Fy6bkXABhT+42nr45PzvcVWfbqpvRlCa1kWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693236; c=relaxed/simple;
	bh=h+LMnzrsqa7+GZNi3/9pZ6wz925rg/gymRFvwE8GH7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfNanHRovMPnR6mcYGllOyGP3B5tHd876nvPqqWGCB/m1/aW+/IU2DU3BEYawO12PS9JshE7Fhggba4b9xTm6wcIyuk0lMsj8bZ5NMjTckm0pg73Kv7XEe+d52so+M+Zl8CZEwqtW0oMD5bP+n7hTDrQVN3IBKqjbwUHk6XdHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoAmJMis; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rQVFCpy/; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783693234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNIsf09Yja6/u+ZJJ0j1TaBQzngcrHOXq4v7jmyV9mg=;
	b=PoAmJMis/QOGUW6reSu6CTBrP+zBfexIzku4nybHVzpcPTtIZEqaFczQQmkZfSq+QiZdcO
	S0PFN1yS86RICPlLktSr1LqGKzmbxn+ENn9OV9mNj3LxQFtj3Ar4e5dhwXB/eJc21aWDvG
	dGNKmtxsEAOTLW2rUL/ZkRBkSwmHr/E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-eKGPmziyPwGdyMovs19wow-1; Fri, 10 Jul 2026 10:20:32 -0400
X-MC-Unique: eKGPmziyPwGdyMovs19wow-1
X-Mimecast-MFC-AGG-ID: eKGPmziyPwGdyMovs19wow_1783693231
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f24a50f0cso701184f8f.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783693231; x=1784298031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNIsf09Yja6/u+ZJJ0j1TaBQzngcrHOXq4v7jmyV9mg=;
        b=rQVFCpy/vArzP96ORIfsnhn5S71rXJ1ZLxv9blHja+RPkXXBDQqK9eGEtqwvkf0+iD
         zXdDuvIbb3TKFH8PXzdz1LWsMDXDg3xlN77CzYxz5O5Wyidl/1+4QoDkBiTYgsFYjdnr
         wvPhuqjzKwbvMR1oMlea1ouofQ7FEDI3ODURoUTir1nQMS9iY52SOGUyeE0fUmEqitQ8
         3JrrLakv8+dXVpf6glwORXzkpYaL6gjLvO4lJ0xGsZC5CDAY+SgSeCJESZVyE2CMmJOc
         h3XV7BBOCeuYbsNucNe/cnt++aVNwyU2yG+m2HzbmLjjvV+f/zGc7KRr+WozLJHXR1h9
         V7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783693231; x=1784298031;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNIsf09Yja6/u+ZJJ0j1TaBQzngcrHOXq4v7jmyV9mg=;
        b=QK4ntnly5OJX6HHxNxh3bRLMZ1WKPHXIRxOfqJ07lRQTDmNcvoI5WfaSy8mEMWCzdJ
         FCzK/k9sAIL/UeW6ttSXcUeLoI58PVSlG/S0wEJbgjvNi+uBjpPxdCH4yQYDHT4Q8tqY
         vpSYYxOYJP1C0mDL7uIuWRu2fjHn6/ahGnE98mK/pqo6YsR+dwzUl7vwvB9pJlTCYQ7T
         FWK1xyDehFeGE5+eXJPFGsSIW9X7o6CFoyfkXJcZVrEFzKT0/6FqwYjsN65OoK+fME7O
         JNWqI7+Hn6X8XMUN7aocBmziGktSmMRlna+OVtnqysoa8F3TpfqacfGJMjSctMeA1afy
         w2Mw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3aPXzjz3w2gIB6iFLT7XtNPWAtl0r80i2iB8Lgtuyp7TWqywvDJdBhtV+Ajcv986xEhkQgnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSriYEfe9kSAY+TNo5/jY3Q8XMWLHvS5vtD/uWQW9X8/kWvBM
	Lkg+gAQZuHxfN9xA5CkcsOGH6isGsVXu/Nj5gLA9E8ez+vTw5jdnkvkGdpw36iqxJOrRImkz9wy
	QnMnTZmRW+Ey6mNLcpIkfXzmU6fyYtKbVdLCHYfaZYZo7um0SToYDytYxHw==
X-Gm-Gg: AfdE7cnRpDi7qLrYSjTktDStxcuwzuDTaQwQONg1DmJoKf/QzENIuoGdjjg5feD/+x6
	Zg1AF2DnSO9XQ342BumveFf9Df+mKQJanu21Dd3TM4LMx9mVTDFFpxR7siYJQnCGrlS2nJ6dIUt
	a1XS19aTkjItmQUGDXyNiixZN6SOtMQ5CdAMFHTBKCLB09s/HeygJ0yJlfsrXHjUj9ufie1eVqF
	V/WjEwmGlhlGd1SIJKsttnQhATQBf+GWtt2zoSeVsp/zMajzUjjEESKpocY9IcKIrn5Fva8fKsC
	74fVdGP2IS+OgRQuhD1AEDisVIdInwgHFFV7pwynJlxUfiPWkmjiSY2mRPO3cg9qjFhyUC2H4hU
	gIJaXTARj03IoIqlg55M1EE5zayeLcoYBph1X1A6uEmyrNcpFXz7LP52vNWtAbwMTGlYp/jZh4l
	+eLs9/zCWVYFH8
X-Received: by 2002:a05:6000:2285:b0:475:f0c2:75ac with SMTP id ffacd0b85a97d-47df07baa0cmr13403346f8f.61.1783693231160;
        Fri, 10 Jul 2026 07:20:31 -0700 (PDT)
X-Received: by 2002:a05:6000:2285:b0:475:f0c2:75ac with SMTP id ffacd0b85a97d-47df07baa0cmr13403286f8f.61.1783693230586;
        Fri, 10 Jul 2026 07:20:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ad21sm59522649f8f.20.2026.07.10.07.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 07:20:29 -0700 (PDT)
Message-ID: <991ec032-c6fe-4236-be22-323a9e3cb07e@redhat.com>
Date: Fri, 10 Jul 2026 16:20:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] vxlan: RCU protect vxlan_config and enable
 RTNL-less fill_info
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260708160411.1355008-1-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260708160411.1355008-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,lunn.ch,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-306588-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EC8B73BC27

On 7/8/26 6:04 PM, Eric Dumazet wrote:
> This patch series converts VXLAN configuration (`struct vxlan_config`)
> to be RCU-protected, allowing lockless readers and enabling RTNL-less
> `vxlan_fill_info()` netlink link info dumping.
> 
> Work has been split into three distinct parts:
> 
> 1. Refactor helper functions in RX, TX, MDB, VNIFILTER, and OVS paths to
>    accept a `const struct vxlan_config *cfg` pointer (or pass specific
>    fields such as `flags`/`saddr_family`) rather than accessing
>    `vxlan->cfg` directly.
> 
> 2. Convert `vxlan->cfg` from an embedded struct into an RCU-protected
>    pointer (`struct vxlan_config __rcu *cfg`), dynamically allocated on
>    device creation or changelink, and freed via `kfree_rcu()`. Update
>    offload drivers (`mlxsw`) and OVS (`vport-vxlan.c`) accordingly.
> 
> 3. Update `vxlan_fill_info()` to run under `rcu_read_lock()` instead of
>    relying on RTNL lock, completing the transition to lockless link info
>    dumping for VXLAN devices.
I *suspect* this is triggering RCU splat in forwarding self-tests:

[ 1955.481960][T11074] =============================
[ 1955.482076][T11074] WARNING: suspicious RCU usage
[ 1955.482190][T11074] 7.2.0-rc2-virtme #1 Not tainted
[ 1955.482304][T11074] -----------------------------
[ 1955.482886][T11074] drivers/net/vxlan/vxlan_core.c:1872 suspicious rcu_dereference_check() usage!
[ 1955.483087][T11074] 
[ 1955.483087][T11074] other info that might help us debug this:
[ 1955.483087][T11074] 
[ 1955.483312][T11074] 
[ 1955.483312][T11074] rcu_scheduler_active = 2, debug_locks = 1
[ 1955.483489][T11074] 1 lock held by arping/11074:
[ 1955.483623][T11074]  #0: ffffffffbad91d60 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x204/0x1b90
[ 1955.483836][T11074] 
[ 1955.483836][T11074] stack backtrace:
[ 1955.483977][T11074] CPU: 0 UID: 0 PID: 11074 Comm: arping Not tainted 7.2.0-rc2-virtme #1 PREEMPT(full) 
[ 1955.483980][T11074] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[ 1955.483982][T11074] Call Trace:
[ 1955.483983][T11074]  <TASK>
[ 1955.483984][T11074]  dump_stack_lvl+0x6f/0xa0
[ 1955.483990][T11074]  lockdep_rcu_suspicious.cold+0x37/0x89
[ 1955.483995][T11074]  arp_reduce.isra.0+0x9b9/0x1080 [vxlan]
[ 1955.484003][T11074]  ? mark_usage+0x61/0x170
[ 1955.484007][T11074]  ? __lock_acquire+0x518/0xc20
[ 1955.484010][T11074]  ? vxlan_nl2conf+0x5b30/0x5b30 [vxlan]
[ 1955.484015][T11074]  ? lock_acquire.part.0+0xbc/0x260
[ 1955.484017][T11074]  ? find_held_lock+0x2b/0x80
[ 1955.484020][T11074]  ? __lock_release.isra.0+0x6b/0x1a0
[ 1955.484025][T11074]  ? vxlan_xmit+0x128b/0x1660 [vxlan]
[ 1955.484029][T11074]  vxlan_xmit+0x128b/0x1660 [vxlan]
[ 1955.484034][T11074]  ? rcu_lockdep_current_cpu_online+0x39/0x1b0
[ 1955.484039][T11074]  dev_hard_start_xmit+0xf4/0x620
[ 1955.484042][T11074]  ? validate_xmit_skb+0x72/0x9a0
[ 1955.484045][T11074]  __dev_queue_xmit+0xc1a/0x1b90
[ 1955.484047][T11074]  ? _copy_from_iter+0x1bb/0x1810
[ 1955.484052][T11074]  ? __alloc_skb+0x342/0x5f0
[ 1955.484055][T11074]  ? _copy_from_iter_flushcache+0x1970/0x1970
[ 1955.484057][T11074]  ? ref_tracker_alloc+0x2e7/0x430
[ 1955.484060][T11074]  ? netdev_core_pick_tx+0x2c0/0x2c0
[ 1955.484064][T11074]  ? packet_parse_headers+0x325/0x830
[ 1955.484067][T11074]  ? __asan_memset+0x27/0x50
[ 1955.484070][T11074]  ? packet_parse_headers+0x325/0x830
[ 1955.484073][T11074]  ? skb_copy_datagram_from_iter+0xf3/0x6a0
[ 1955.484075][T11074]  ? packet_release+0xc70/0xc70
[ 1955.484079][T11074]  packet_snd+0xfad/0x1990
[ 1955.484085][T11074]  ? tpacket_snd+0x19e0/0x19e0
[ 1955.484087][T11074]  ? __might_fault+0x97/0x140
[ 1955.484093][T11074]  ? __might_fault+0x97/0x140
[ 1955.484095][T11074]  ? __might_fault+0x97/0x140
[ 1955.484098][T11074]  __sys_sendto+0x2aa/0x400
[ 1955.484101][T11074]  ? __ia32_sys_getpeername+0xd0/0xd0
[ 1955.484110][T11074]  ? do_user_addr_fault+0x325/0xe30
[ 1955.484116][T11074]  __x64_sys_sendto+0xe4/0x1f0
[ 1955.484117][T11074]  ? trace_irq_enable.constprop.0+0x9b/0x160
[ 1955.484121][T11074]  ? lockdep_hardirqs_on+0x8c/0x130
[ 1955.484123][T11074]  ? do_syscall_64+0x82/0x590
[ 1955.484126][T11074]  do_syscall_64+0x117/0x590
[ 1955.484127][T11074]  ? trace_hardirqs_off+0xd/0x30
[ 1955.484129][T11074]  ? exc_page_fault+0xee/0x100
[ 1955.484132][T11074]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 1955.484134][T11074] RIP: 0033:0x7f138c3ec54e
[ 1955.484138][T11074] Code: 4d 89 d8 e8 b4 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
[ 1955.484139][T11074] RSP: 002b:00007ffc648f74e0 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[ 1955.484142][T11074] RAX: ffffffffffffffda RBX: 000000000000001c RCX: 00007f138c3ec54e
[ 1955.484143][T11074] RDX: 000000000000001c RSI: 00007ffc648f7560 RDI: 0000000000000005
[ 1955.484144][T11074] RBP: 00007ffc648f74f0 R08: 00007ffc648f79e0 R09: 0000000000000014
[ 1955.484145][T11074] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[ 1955.484146][T11074] R13: 00007ffc648f7910 R14: ffffffffffffffe8 R15: 0000000000000000

full log at:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/728082/83-test-vxlan-nh-sh/stderr

Tentatively setting the series to 'changes requested'

/P



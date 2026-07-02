Return-Path: <netdev+bounces-303983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IWm+BHT8RWrUHQsAu9opvQ
	(envelope-from <netdev+bounces-303983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 07:51:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EB26F3A2B
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 07:51:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=rO+mBtpZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303983-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303983-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E694F30616A6
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 05:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F4735E93E;
	Thu,  2 Jul 2026 05:49:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC0C363C6C
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 05:49:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782971398; cv=none; b=a1ZObRVPDSLs9EiJpJP/HSZO+wvd2GmB8PCaNAkA1l2U6RoCJ1O6v9sBHeOGakWdv1EqkcM0GiLx0mSUCW4vPqTIp01tpZzayDo7EnOb4gIvsYo0FsGCoAwJ+xVrktBP6ZxzxvBvNxDjRmrJrap5chHw5VbF6V1yPVnrFVGnPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782971398; c=relaxed/simple;
	bh=L0C3+rSNWpqX28URVZs4meNKDTVprxT11MRHCkWEBxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJz9/0NPzGHv6ikwUf8cvma6GAjq2dQV4l6Fldlmu2r1SKTi4qfwLG8/LzDERLDRSnnHWzWQskZ+Af/eCJ5xUsvVQlJZbDAnh+wIL1otFpkxkC/LwTDu8ogNgWBAZ48usxrSUurPuzAYcpbsO7T8QH00CJkjWyfCm68ce0qOGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rO+mBtpZ; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847a225cd91so1434692b3a.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 22:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782971396; x=1783576196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aS/9VmQWUzGE31JT9VCNaZ4dhsuSJsHqr8RJ/ilt9nw=;
        b=rO+mBtpZ81Br/krObRBzTQ7nzoHETY4/dqcf3Wpo6Pw52Cbfa4MaJq09SFmckzSWnZ
         UWblOrkmdhaNGvLJph4HRy+RDh7OZKaTMoQPQAwvve8o+SOTlF3f4ulrr8+drvvcgCRn
         TAIL4fFEYTE9k3WvHamz+UtHkxoX/Z8wgZAadmamoMNr0+6LqmQ6he/HgdPBFsXCVFed
         2ENpg8lRUT47SRLGZDliWUv5pUdrMH+IU+4Xwecp84kmwk1Owmn2g9qFdk2aWpO8iHrz
         2FwcUCVXdZiFKhlkMIy3SuUA8bhM3ikPq8I9cd0WKlMA4wVlF2gJzG4e1GPlyxoYFVc/
         fmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782971396; x=1783576196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aS/9VmQWUzGE31JT9VCNaZ4dhsuSJsHqr8RJ/ilt9nw=;
        b=su8G15DEZaIkgStLIVNuuqotMK787s9/u8+rMiz+ac1MOuPwLTjY/hp2ZToWAofMqt
         i9+DIhdvGZrIoTwIBn/FUpByWI5uL/HgIJg9S//cV/h/OJusfbT4+EkNsWSYMDyyET6o
         NLVFFP1cgxyMS7Xcezf+/Y8Hak2Q7a54zzd8D14ngW7YRPJmtAanSYhWrzgv8dzm9z7Q
         NZAtRGnn5uV3tg7vE+aZZUpXZv7Aj1fgpj3mxaBRleInxVDTgCK2o9TJFI03arII+VjB
         G38lPyJkQSGI2NGqTR2XmriYU2cvKnTrxO6N17iombNlCpdSMV5+q9i+P4Ee4UbIarJ5
         tQIw==
X-Forwarded-Encrypted: i=1; AFNElJ/g3kJ6PBxZupUEocwKVrx/13D5wdM2KtL+yQNasNsjXnjn2LWpi8ttY4Wks03ZpCbRcYg1YgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrqZeYVWUKY8LFLqlYVPwNW/yA3NxSWePt4kPlnbEpU2vtNot
	wiRI/6lG7iPVU2w3KKrkJ+4ZtHvpxzzt6JLtuDkeeOjtv2BXhLmWAzTnMHKw0KzoLQdNRi2RhbC
	mngWSxg==
X-Received: from pfbmy11-n1.prod.google.com ([2002:a05:6a00:6d4b:10b0:847:84bb:c71c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc7:b0:847:95a7:9b48
 with SMTP id d2e1a72fcca58-847c5071ae8mr3893776b3a.22.1782971395753; Wed, 01
 Jul 2026 22:49:55 -0700 (PDT)
Date: Thu,  2 Jul 2026 05:49:42 +0000
In-Reply-To: <20260701235014.73505-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701235014.73505-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702054952.639157-1-kuniyu@google.com>
Subject: Re: [PATCH net v3] ipv4: igmp: remove multicast group from hash table
 on device destruction
From: Kuniyuki Iwashima <kuniyu@google.com>
To: yuyanghuang@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, xiyou.wangcong@gmail.com, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:idosch@nvidia.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:stable@vger.kernel.org,m:xiyou.wangcong@gmail.com,m:kuniyu@google.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303983-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,nvidia.com,vger.kernel.org,redhat.com,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37EB26F3A2B

From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu,  2 Jul 2026 08:50:14 +0900
> When a device is destroyed under RTNL, ip_mc_destroy_dev() iterates through
> the multicast list and calls ip_ma_put() on each membership, scheduling
> them for RCU reclamation. However, they are not unlinked from the device's
> multicast hash table (mc_hash).
> 
> Since the device remains published in dev->ip_ptr until after
> ip_mc_destroy_dev() completes, concurrent RCU readers traversing mc_hash
> can still locate and access the multicast group after its refcount is
> decremented. If the RCU callback runs and frees the group while a reader is
> accessing it, a use-after-free occurs.
> 
> Fix this by unlinking the multicast group from mc_hash using
> ip_mc_hash_remove() before scheduling it for reclamation.
> 
> BUG: KASAN: slab-use-after-free in ip_check_mc_rcu+0x149/0x3f0
> Read of size 4 at addr ffff888009bf1408 by task mausezahn/2276
> 
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x67/0x90
>  print_report+0x175/0x7c0
>  kasan_report+0x147/0x180
>  ip_check_mc_rcu+0x149/0x3f0
>  udp_v4_early_demux+0x36d/0x12d0
>  ip_rcv_finish_core+0xb8b/0x1390
>  ip_rcv_finish+0x54/0x120
>  NF_HOOK+0x213/0x2b0
>  __netif_receive_skb+0x126/0x340
>  process_backlog+0x4f2/0xf00
>  __napi_poll+0x92/0x2c0
>  net_rx_action+0x583/0xc60
>  handle_softirqs+0x236/0x7f0
>  do_softirq+0x57/0x80
>  </IRQ>
> 
> Allocated by task 2239:
>  kasan_save_track+0x3e/0x80
>  __kasan_kmalloc+0x72/0x90
>  ____ip_mc_inc_group+0x31a/0xa40
>  __ip_mc_join_group+0x334/0x3f0
>  do_ip_setsockopt+0x16fa/0x2010
>  ip_setsockopt+0x3f/0x90
>  do_sock_setsockopt+0x1ad/0x300
> 
> Freed by task 0:
>  kasan_save_track+0x3e/0x80
>  kasan_save_free_info+0x40/0x50
>  __kasan_slab_free+0x3a/0x60
>  __rcu_free_sheaf_prepare+0xd4/0x220
>  rcu_free_sheaf+0x36/0x190
>  rcu_core+0x8d9/0x12f0
>  handle_softirqs+0x236/0x7f0
> 
> Fixes: e9897071350b ("igmp: hash a hash table to speedup ip_check_mc_rcu()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


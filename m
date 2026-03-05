Return-Path: <netdev+bounces-264601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ei4CEolqmkPMAEAu9opvQ
	(envelope-from <netdev+bounces-264601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:52:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3B421A07A
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEAC53094636
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 00:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC47D2EBB9E;
	Fri,  6 Mar 2026 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZcvEYh3g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C6B2F745C
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758282; cv=none; b=MheHcZAsFLZemEcEn3GbNrkcQgiQjdjEly47/n+gFLvoDLRcjr92WjTOO5G/A1val7KOfq7gRf4wTbIPMs3qF/d48I5duxtHOei1nYzzQNz3qSaOAzUQoEVwbiN3FEe4Zta9Rt3rfIVyqbFknCDtdjgaxlaiN9eD5ISMv7fI5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758282; c=relaxed/simple;
	bh=rEUuZZA4ANDMcvCg6pyW/UJTRU9oRAre4nZ6TiKNFLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eOAHBNzzqihTmRBIEzqVJGaP5aF8VYxcWcS1DYfDCOyo7iR9LKTlIxzxrCk5iJb4dhRuBywlFmAMn7nqxJAcy7D0dVQEx32Q/nFas9CMDbr2Xbi/72vFbhgg6l2TNEe/OtxF7waVfP4TscMfB/H6toSFs1XWeP2q/8QsDbr9R94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZcvEYh3g; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so98956915e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 16:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772758278; x=1773363078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8d5hpiYB7XUuEuXpz7M550s7MAxfMslNPphPrHEEiTQ=;
        b=ZcvEYh3gLKjlx654lRrOER6D8AZGEZ+xNWN4PakhPqieRawNzRQg8FOHhKmmMwosQq
         dSXHQWv2yc/banmAyts3YxUSTXf5uqiVG/LXhT/kBFwv0SJxYEDwrAy3SI8gHco0eGgU
         0tr0KeJwG1odZHj6MYl6EfpuWsv6C3yuabiA7mJs08jlkR8gjpYJpxgRidZXPlvumyeq
         i5QeFAal8l2mdopOCzU0sbHMsf7NfSxzXVtO7JDIxtmSlcJvVhAblch+hnXshQfJzNCy
         CN99e5x/54TYxs/6Lh+nSEzVry+3mEPkUYu5yLSI1R3oNLYQP4mUcA1NzP7TZPNSWZXB
         tYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772758278; x=1773363078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8d5hpiYB7XUuEuXpz7M550s7MAxfMslNPphPrHEEiTQ=;
        b=dZ+cz6dRzJMbx9xv/svs+ob8AQnysrjGLc91i9uaDwkGhnV3cXNDNsT04L4mVBP8VQ
         b+Qo8sTIS3OiN1G4fhIMJHZDG+4k6dtyxqol9KVUJYXFlUnSs6wd39E1xpksXPkxEaTa
         N/1nJ2FWGz22VbtoC5BgSVSZF2YIg0zP9DTzz5e3eBthQh8djvFQtc1E730R7d395ej+
         x+NXG1iP7MIP98avRKd4tq7o39zppZJXbZl2Ot/pAAR/gT9ChwpFSx9rqnZXzo/WHWfI
         qb+etEOYZ8YyAdYlgThyqcdXqZdMD8sfXA9xjb5PuIzFFC9rvNeUVfJHDwur7NrT+N7S
         4vkw==
X-Forwarded-Encrypted: i=1; AJvYcCVI56lo012dGI9rVJ8rec+1rDeIl98HmB93zfzYR2MAgKd9bFahPLzVTvDvdOPt982t8bU5x1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwtguXprGb6tpzvNeqmkIpA+q3A6ApW/qDUW66pkW8ypOyRQ0P
	ma0Rsv/QtbPmXXBHRa2e3ld2+OICAVfuGfBpEBcuuLtX8qVWtlC8+AfYs0LQYJo7CYk=
X-Gm-Gg: ATEYQzyvxQdLolRP29Trs+jbp+GzRJ0FvAwPXt9FJG8dJyHPgdepufm8JyLDB6U6ywF
	VS3IVEyXjgQDMrbMXyvipVU2BMTMxnMOUdHahYzf9MQRWtDbIzm1euulDtHUJ2BNGJDNGM3txjh
	fvVqRymm7ZgrnNfqNIPGKUEGOITfeY8c1kUKs5jXAtoDlwmfsnSK/FHeH7ao7a9HzkAAB/PQPhv
	CVsKmUnRnTqU7ZvUzcD0TiscnWPIkmZfgNac6/NAG2D0FQLN+7pZygdG8PVHiGSn+ICx9ZYXwHb
	GrQjvPDVzRvlIAx7/f8jrKeewCYGvmZiZUOH9goqwKnKa2/NNp1mjVTJqHySWnnvxgZRHoyGtBQ
	CjyBJZHhcN7NV6qg5AfkN+x4g7RUMRm79CwEg67zO2d0bFfRnR/rDL2+NF0pJUjEGeFrqFbFyIU
	3rgBFbf0m6sqwGoF5kN6ff
X-Received: by 2002:a05:600c:19d4:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-48526923b15mr3594985e9.8.1772758278421;
        Thu, 05 Mar 2026 16:51:18 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b087d9e69sm24485e0c.15.2026.03.05.16.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:51:17 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 05 Mar 2026 18:29:55 -0300
Subject: [PATCH net v3 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-net-nd_tbl_fixes-v3-1-fde28b30a744@suse.com>
References: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
In-Reply-To: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1772758271; l=2192;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=rEUuZZA4ANDMcvCg6pyW/UJTRU9oRAre4nZ6TiKNFLg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAqX5xIX1fDdNVLySfgqcNpq8zzpqBUX1kZwOhKrciL3jWWx4RUwsRhbdPvWDdjqg/5lFkWHs9/
 RWswQa5VhTQg=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Queue-Id: BE3B421A07A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264601-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called which
initializes it. If bpf_redirect_neigh() is called from tc with an explicit
nexthop of nh_family == AF_INET6, bpf_out_neigh_v4() takes the AF_INET6
branch and calls ip_neigh_gw6(), which relies on ipv6_stub->nd_tbl.

 BUG: kernel NULL pointer dereference, address: 0000000000000248
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:skb_do_redirect+0xb93/0xf00
 Call Trace:
  <TASK>
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __tcf_classify.constprop.0+0x83/0x160
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? tcf_classify+0x2b/0x50
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? tc_run+0xb8/0x120
  ? srso_alias_return_thunk+0x5/0xfbef5
  __dev_queue_xmit+0x6fa/0x1000
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? alloc_skb_with_frags+0x58/0x200
  packet_sendmsg+0x10da/0x1700
  ? srso_alias_return_thunk+0x5/0xfbef5
  __sys_sendto+0x1f3/0x220
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x101/0xf80
  ? exc_page_fault+0x6e/0x170
  ? srso_alias_return_thunk+0x5/0xfbef5
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

Fix this by adding an early check in the AF_INET6 branch of
bpf_out_neigh_v4(). If ipv6_stub->nd_tbl is NULL, unlock RCU and drop the
packet.

Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support supplying nexthop")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0d5d5a17acb2..4f8ff05c4ec4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2335,6 +2335,10 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 
 		neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
 	} else if (nh->nh_family == AF_INET6) {
+		if (unlikely(!ipv6_stub->nd_tbl)) {
+			rcu_read_unlock();
+			goto out_drop;
+		}
 		neigh = ip_neigh_gw6(dev, &nh->ipv6_nh);
 		is_v6gw = true;
 	} else if (nh->nh_family == AF_INET) {

-- 
2.53.0



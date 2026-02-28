Return-Path: <netdev+bounces-262183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAFbGzhHo2lM/AQAu9opvQ
	(envelope-from <netdev+bounces-262183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:51:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E271C76CB
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94C1B36B24A3
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91C4301BE;
	Sat, 28 Feb 2026 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NsTZTRUW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1324301BF
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300818; cv=none; b=KU0ixwCo14hhIBGaERSMscrN92DVOnG//dZ76sboYHnrJHkSi5LpWrq8hmElnuSdqCcHkFR1OGqGa3+VKvjk+kT39SwpoAruBHI7GuevZd/VccOJuRWzJVUvHQh8rbdo9dcua2UuxVFYA7gt1QzNjix55vIGs6JQYvC73SHNneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300818; c=relaxed/simple;
	bh=ucFGNhQbyvRgliJm2iclmlbV7LXFrBb9Ujgx98X8vXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rMT+v0cdntQnnjGNUF591A6Kc96WUMIGgYbJ0oqlfu3wili95xQYbM8oekCTDM0ujXGhWDnyvwHNZpgIMXyAfRTqRVo/B6iuBXhUxpiCiYmGLPEQdvZnYLHHLOBtZcgpjYGTyOLVHcBW0gXj8/zBZ74kiJ8HGcPf3gfFUzjbzfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NsTZTRUW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48379a42f76so24087375e9.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 09:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772300815; x=1772905615; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7g3kt179KaVjeiiNTGHXSByoR9j5QH912SUkq7k1du8=;
        b=NsTZTRUWKKQvZaSGJXfavNcGAC+2LOz8cSCD8iCBqxMC1KA3usvrImsbCw/7/dkZqq
         UydBcIUTnMPnOwizdf48XYmatQPhXAI+ikw53vxZG6D9bsYENXitL4AbWaJUmlT0cVUJ
         hFGrm5Er3elTIf040avIOlfMYHEKFFpOezN6LcVeWqzMq/L/UIEs+k5uWwWlZUG0hZEG
         ou8/FfDCY6QMx/SRv4hic4B8QtfbvUcbFeKEJfmyycmGwEcF7uwrok3X5M9yj0AO8zZ6
         VSyMk0h4Cclj1zEwbNSbDYlRMkJCPgzjmRy7Qer86a914XJxpZBtg0BFgaiUOjg4ZxhV
         Rjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772300815; x=1772905615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7g3kt179KaVjeiiNTGHXSByoR9j5QH912SUkq7k1du8=;
        b=v6Ut+9p+JY20XQQW0c3scuSw2pmSAwNfGGLhO4Vu/NVwWWyp35d0wYhTchwiw3d45c
         GK2TRF9JHSFmCltXi+e4XQIYNOl40AmUQh+zF3+ejpjnSnwLqPpN/X97N0/tJqDcpxjo
         VPcq+/YPchzuh5tm1ApiMD1P3ZoEkIQdjolj+CTRk0OIZ1+7vqbUwsx6uc6/v3/CI/0f
         /JjhYDpClkQsTl/IqW5udWPyjoM7Wvdpt+/T5EYnWgEDtruU2IRw0sS8dvaCypjUTbwA
         +F69Lmqaj/dbJ5lbvE5YKNIniFpGmZ5YDpFPiZ2xqVj/lumGM7orP7au7YBPS3My4siF
         g7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWU1AZA5CfgOVvGmPvb25MJQi1YjIqIZjOeM05jf4ovt/7WMNTQhT0BYo/uz0agW2F81ppjkak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQPEynYoceJxMNFfM7fhA2TmEmjLQy6RdnTb3ai247eFPSZn2
	72dj6M9CUKYpB95UbgBV3uOoEZQJLaZcjmCg1qPtV2sEB3r5RyI+f3H05Up7cIDsVMg=
X-Gm-Gg: ATEYQzw6WgcoKBPEnOvhuBM8fenSnsKIXlW7cbGZ3g4Ssarb+iQN3jgnhiUh8xdUV0M
	wTKsutMt79RVJXfdE9y1qOok1ISmxF4ZwBd37zia0T4wgMuoMhwafuvAQYsfLtIl/IVv774aTJS
	ZweY5LiF3gK5UOII/2Iel8dM17XInFL4QQjLl0S9WiqviPxuR0D4LZrV21ePb7w21frwLIfaCGZ
	1q6dng+NztHrNeI0ZnnWvJga88u1FK3zmAHTnqZq0HFXzE9juE7rXiRKaejKnR05pMN2yTcK4lJ
	27FP2UQ2g97hs7tKFl0VH1xWR6whNbcXe+8iYjtwnOLBLSFa53Zf4MyrlY92thz+FM8hWHDMcbb
	d8NA3n+r/DHWPZi2z3KGo4EsWkHtinfSonzO0fe8wC1xtNkuIoqnDdapSty4j1uD0Zaen4H2IKW
	LfTl5lk8md
X-Received: by 2002:a05:600c:3b22:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-483c9bff7b0mr109487805e9.22.1772300813862;
        Sat, 28 Feb 2026 09:46:53 -0800 (PST)
Received: from localhost ([189.99.238.12])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1ea116c8sm8808512137.10.2026.02.28.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 09:46:50 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Sat, 28 Feb 2026 14:46:26 -0300
Subject: [PATCH net 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference
 when IPv6 is disabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260228-net-nd_tbl_fixes-v1-1-2b2a274df9bb@suse.com>
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
In-Reply-To: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772300803; l=2182;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=ucFGNhQbyvRgliJm2iclmlbV7LXFrBb9Ujgx98X8vXQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLqZmcEzlqILSWD7UP8bPCY/O1xURrrkYnEZviyYV9TEw84KCTDDT97+pGEpf5s2Sx5NOTFb0HA
 dNu1zqk+zRwU=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262183-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 02E271C76CB
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
index 0d5d5a17acb2..9ab2fae3a0d9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2335,6 +2335,10 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 
 		neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
 	} else if (nh->nh_family == AF_INET6) {
+		if (!ipv6_stub->nd_tbl) {
+			rcu_read_unlock();
+			goto out_drop;
+		}
 		neigh = ip_neigh_gw6(dev, &nh->ipv6_nh);
 		is_v6gw = true;
 	} else if (nh->nh_family == AF_INET) {

-- 
2.53.0



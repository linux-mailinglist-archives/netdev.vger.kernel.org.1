Return-Path: <netdev+bounces-264602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODo2L3slqmkPMAEAu9opvQ
	(envelope-from <netdev+bounces-264602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:53:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B7C21A098
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CF8F30C0758
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 00:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59662F2914;
	Fri,  6 Mar 2026 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U7IjsFI6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815602F9D83
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758289; cv=none; b=uOh2T4bs3cg2Pqmlwqu9McsqNsLqTS8zOsGs1V7jRdxmHgzxEyArNWT0IfUbzXVkad8uGS57vR+u1YNywN4SuHrQEFFF5ndXqOZ8gBS7S0YTEdzetqr0FgLfKClX5CIa/hDUAJ2CSJHRnEbp8edBUFBst2kcKez9HxJTuPSbcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758289; c=relaxed/simple;
	bh=uY/cmt2Sth4SxjohY5zGzx4ELvftPGuex3rlN1K/nqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tWjcEYpps46y6uxvS4hyDv97ZYUh2MN4BhkVCK0pTQPnWhg7p3tdqQmnYBpgINR/3aHRFz7qu+/785sDbEjrf4kfwW59Ud6IYQ2spV7TTf/BGLsiZ/DGw14ii47lZ3tK02lfI9wOIEQmm3KYf+So7XCH8HW6mGr8q9zmclLCHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U7IjsFI6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483770e0b25so73607965e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772758282; x=1773363082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cj+T9d3Zgf3+ritNDiK94fhxI8rgFwWgGmiNKUx6cEs=;
        b=U7IjsFI6ZVhXKXQSlulUJAniGOY6cfVExehoDjuQI5Yc/glgmnzQRFqgGA81U9jmFr
         I4L8908AT0JDZckZDWklLZgH7mhn0OZjQiSkar0FqeA1h4sH5yrX1jy3tYgP5MJyT+XP
         KILxkoy/qcQUkxAV5JI/wmyTui/8HUAbHap7Zvv3cNmm0OXoreWRZOGZG1SLC/xhY4Cv
         h6n/HenZeto74K4ui47fN+pnU/v8MAjBNt2hrN69G2NbIcJVuYRefQoJwh9LglkOdble
         x28WyLjmIt3AMKRzL9jjmP9CqAMW13b5dXiMm7iR9MAbCZkMxydBtXPg7dpDMJKBvBiL
         OmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772758282; x=1773363082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cj+T9d3Zgf3+ritNDiK94fhxI8rgFwWgGmiNKUx6cEs=;
        b=vaVPHvTf79klaQtTEq+g3fUVBcEJRubrml6LYpZxgc11n34jdo2NUDIDy4CthnCcr7
         r9XMECUX4Qpuh1BmzECu6Oc2wxA7so5Y0+d7NTMjrdFwje67GrfKPcBPwmcB+nieAjsV
         QpMGPEN2f2xZ/II1RQP6hGIMOTnBmvn3DGmhs3oDv9/JmdurT6vOBoPiYP8DyFTo7If4
         etBlbw4Sbkkp4epHblCW805VcqNPHd4YbVoQIHVb9eItW6vvsvSCxE2AyWeZgZTJik76
         8xVM0t2bQWPcHRtXzhghADsl9JMfYXgYpbS04Zmg/5egmnzi1qwGF9Gr0qcSrVkFXYxC
         qZkg==
X-Forwarded-Encrypted: i=1; AJvYcCW+e7apsa+yJa9gFRh/G3xd36Iu4snUOAsggjixLwrDA9m6TBvZDSwo0EfywfTfpoyhROlSzag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyghzuqESSFx9zsFsWCkTOj16Zjtu9FItBqZQYNj7dOdYXLrLlF
	yteaXLiAKMO81WbvSLSbA684SGgcp3Ws9YLxCfmEXw1unbJsEyFlDp6bQrV3I1MNT0E=
X-Gm-Gg: ATEYQzzz1jqqmnjwUN1+qxHmBF79rmxwG+bYt8WipMsVkedEMd5232V1yaTuqZ4LrO7
	FqJ++SYoZxUTm6DNXTWPw6J80tTlX+bV5LfbTn4e1GT5xB4jqJaartHybI4P55/pffhUcAZjjKu
	nuk6jHdX2ZXrZmqHBPo/DUWhgPorEof2pFD2tp0KGJ5RgGTGZWOpPyILj/vZTo192J2ihnC9JpF
	d716SJ13M4Iumqbax3rYkqutkxnKeVCKVPB0NCGWdM/JU3+SXsrzxYd6CQnN/Qy5a4AKFrmp/Z5
	n/7BCjRNa2SPPei4rk7qrMV0rWxmDW1xDMuDhu+yjKdt4NDib1HcFSMlYymROzfdQV5HKoN9YNs
	WuehFP+mgVLG7ltGInaWiK5dn55+n8y0n4jcBp4CfCB2/XF92sSaV7PJs5R/AsupkNA4ySONS1d
	epnmzAKRV9ng==
X-Received: by 2002:a05:600c:8115:b0:480:52fd:d2e4 with SMTP id 5b1f17b1804b1-485268bcfb4mr4040065e9.0.1772758281849;
        Thu, 05 Mar 2026 16:51:21 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b0865825asm51909e0c.9.2026.03.05.16.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:51:21 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 05 Mar 2026 18:29:56 -0300
Subject: [PATCH net v3 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-net-nd_tbl_fixes-v3-2-fde28b30a744@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772758271; l=1999;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=uY/cmt2Sth4SxjohY5zGzx4ELvftPGuex3rlN1K/nqM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QF1Q1aDL07UnscOXXDba/eBfS/TWj0GNuavW/i1D9zrky1fKqHpr6myU7MaBBl1bEnmCjHaihP4
 uj5GNpCcc8QA=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Queue-Id: 21B7C21A098
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264602-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
initialized because inet6_init() exits before ndisc_init() is called which
initializes it. If bpf_redirect_neigh() is called with explicit AF_INET6
nexthop parameters, __bpf_redirect_neigh_v6() can skip the IPv6 FIB lookup
and call bpf_out_neigh_v6() directly. bpf_out_neigh_v6() then calls
ip_neigh_gw6(), which uses ipv6_stub->nd_tbl.

 BUG: kernel NULL pointer dereference, address: 0000000000000248
 Oops: Oops: 0000 [#1] SMP NOPTI
 RIP: 0010:skb_do_redirect+0x44f/0xf40
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
  packet_sendmsg+0x10da/0x1700
  ? srso_alias_return_thunk+0x5/0xfbef5
  __sys_sendto+0x1f3/0x220
  __x64_sys_sendto+0x24/0x30
  do_syscall_64+0x101/0xf80
  ? exc_page_fault+0x6e/0x170
  ? srso_alias_return_thunk+0x5/0xfbef5
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

Fix this by adding an early check in bpf_out_neigh_v6(). If
ipv6_stub->nd_tbl is NULL, drop the packet before neighbor lookup.

Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support supplying nexthop")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4f8ff05c4ec4..3be669347e62 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2228,6 +2228,9 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
 			return -ENOMEM;
 	}
 
+	if (unlikely(!ipv6_stub->nd_tbl))
+		goto out_drop;
+
 	rcu_read_lock();
 	if (!nh) {
 		dst = skb_dst(skb);

-- 
2.53.0



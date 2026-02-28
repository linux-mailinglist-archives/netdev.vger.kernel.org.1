Return-Path: <netdev+bounces-262184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHinEYFJo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:01:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E114A1C7C16
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89C0F3144232
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7122F4A13BF;
	Sat, 28 Feb 2026 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WR0rMLVu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4442E6E2
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300821; cv=none; b=b4Cz26EtOPvAyxiw3ADSr1MPQPm5cSrLzkfjqjPZTqM4GmuKrEvFrmJQdidAzYPM1VWDboGerMpkGv6kw4oBvE3zRlwI8xYbNrr1fShEpKeKe3veFiStXdK+nP+ePUSihYwmJYAul8vqeDDB7vhE45wPqBYWP6bxNNo0AezHKeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300821; c=relaxed/simple;
	bh=C4KUZeK1Hi7rfQcTxVhmRP3plJWRRKSRXeRWRjZLG2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixkDjI9Izw6eQEZAQBCXb8AHCG5DhEW0ljJlAeyErFTTiOFavRT3kaOq2Sx+F12rA7mZ6YLs+oj092/P6L6k2Qr/Vm2WiM7PcLizxzfZmlpfXFaWKELs/5lgeD5D2WaBCPD5EVYSYbfd0arEiZEznaSGBQmontXuZc3yfi4FkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WR0rMLVu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso20758975e9.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 09:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772300818; x=1772905618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esHyrvwDztyurGcqLZ4eAcc1uKLaDOcfnZVfPZ9eJ00=;
        b=WR0rMLVug6/retEeZ4mzTXnn48o25xqKGLiwjHPqvlo/kX6PJFxYflXgFbqKAxK7Uz
         nDFbJ6jfmTx/RDGzFEWUsVI3LyK+m/5u5Xax9Mjn64OkrfEQ7vAxlbyg9Z050PlQZ1MW
         VJCS/WrcxrGaQApnxGsgcL5eWGCxkDnr1bazWQ5TWDy7EJnO90OTpHgQNbDAqY/OgrwP
         IXrfAC5D4DKp0g+cjLshIeeBI95KEUmN8X1DdcORpp5v72437Kowxxw9uxg3QNxS0+Ze
         0/IwQacxxCOTOW+0k7S6ZMdSZA+hziLhsC4HMCp1/JO/mJwHEMwSXMhdEYGQoIBP9ec9
         dL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772300818; x=1772905618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=esHyrvwDztyurGcqLZ4eAcc1uKLaDOcfnZVfPZ9eJ00=;
        b=LTilI0N2QR2HUsaSgPR/vncFylmdRfnzCSZt3zT4snjq+eU+6h2lvz5ai8tZlB/tFs
         3PRUVT6eamFMI7rnlK4xoL6Xde/7RS7wkQ5v7zyIoqdEEy//Lg+d7Di6LUBzelllA4ht
         qCMTXrba8pW+r4WiwBBfLkQkN5o/Of3hy0vFgSsxYHJeglfFOwpUPa0J21ZYB/eKin4L
         QLhn+8h57xRcZ7xmNJlKUi3+2H8oZfkhQffMtb9yFWQJv9X2qaU3IkwvpFNovLP3k3RP
         1mzVot5XpnmD7AS66fJGDYUrj7r+Y6cQqlP1NrjNLSnWzWZC2AlCkVlrXb/min2ML5RS
         Ut/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCw/QNzegJqB4KT/04ikeNPSXFpRWyCvWY8yc0m+tVMWbjBUZ8ve3gdJ8ST20ZM/Yg2jm0avU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5A567n4rulC+m7qchjZWsOdk2faNTGv0+Fs/xJjFHJH8VuYHr
	6/6eAn5WhCyxGZjL5APBadFP2/RP/lRYVyLgfci3ixXYsITPbwR2Zm0nNM5phlJtV1I=
X-Gm-Gg: ATEYQzxQLKtrKryZ0ujw0bKxHPngI5ZpNvIjuiz4Uf6Yr89/JEWugpP954jqaiUQXlg
	An9MzicelZcRnksvaYAJ/ed73yr+JNkHKuOz2fzwIqxGKVHxti1mDP2KVlx4lf9cEdsWGVOHgGk
	gC3QzccIFlqt8YjNvPBpcbShV2v0WNzMskZ0rSmZZ9QLP/GZMqkbyU46JtFWrSsz7X6U0hnSIk6
	66By1cP1j6xfMWjeLsikC+2ZV2okPMEAz84x5ce6AS/YuaWjQ1LMm/0SK98T4vKpIC3zBnGVoZg
	3kZB5+9HODJ8BDxcsEdYcQn3l/j1PoiAVwd7yZGE1ujYQ9k4no2lPbYjbe0KGIXlrTJcZfNCOsI
	gmvbamrEBYHOBKEFxU7nBvmg+uRKn7Uc8lok3bLG/dfN2jQwpVDbRYBkSi3RFu99v8o0e1qyxMB
	yP/w/+KuSS
X-Received: by 2002:a05:600c:4256:b0:483:6fe3:bb49 with SMTP id 5b1f17b1804b1-483c3192683mr117862785e9.0.1772300818191;
        Sat, 28 Feb 2026 09:46:58 -0800 (PST)
Received: from localhost ([189.99.238.12])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df65782f4sm7474139241.11.2026.02.28.09.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 09:46:57 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Sat, 28 Feb 2026 14:46:27 -0300
Subject: [PATCH net 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference
 when IPv6 is disabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260228-net-nd_tbl_fixes-v1-2-2b2a274df9bb@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772300803; l=1989;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=C4KUZeK1Hi7rfQcTxVhmRP3plJWRRKSRXeRWRjZLG2E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QATSOt0MBqXmmfLN1fQuQPIpcZOIRw0awhFQgAxRXUZGNukQbfeMMEZkMUFe6uV+SU1Bf5CQenM
 12cyI8o7mnAQ=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262184-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: E114A1C7C16
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
index 9ab2fae3a0d9..ad87c40f1393 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2228,6 +2228,9 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
 			return -ENOMEM;
 	}
 
+	if (!ipv6_stub->nd_tbl)
+		goto out_drop;
+
 	rcu_read_lock();
 	if (!nh) {
 		dst = skb_dst(skb);

-- 
2.53.0



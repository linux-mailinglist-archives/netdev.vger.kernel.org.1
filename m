Return-Path: <netdev+bounces-301459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XRbIChHSOmpHHwgAu9opvQ
	(envelope-from <netdev+bounces-301459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:36:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D96B9776
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:36:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rbox.co header.s=selector2 header.b=pJPxf0sC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301459-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301459-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=rbox.co;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85EC23055C5C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 18:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE22038D402;
	Tue, 23 Jun 2026 18:35:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606CF3876C1;
	Tue, 23 Jun 2026 18:35:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782239752; cv=none; b=qjxodhw/+JT9GbLDs18ljorgAwopnvlv945Ssg3Jv+8PaC/Dm1j0WGFewpbM9urOHjpcEkDkR4tuVG/T2H83kR4FRdLzd2/hwhi7YRyTLN8K7oEy/eucsZ2MaHuq/zhVuJs3SmZli9PGYuNbO1teJXgRwzQyZjQFWFnKwdDWRTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782239752; c=relaxed/simple;
	bh=o2SHWTofhxRkanpNrEO5U0csdR5JtfU2ZtOrfn/cyTg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gwuuRzIr4ryOYuv6x57u2HuTx3FwqmDTL0mH49vTos8ltlToQ0OMA1nJ0V0L5j96JPgi1QVCA4f6UQNoY8jwBRGZ+8Rk6+e/leKHv7ZZnNCqk54bbTbS80lNhadRnHULorzHUPZg7yQ+c5xMOcSc4fUkzW//tcMTeqzJzXTSiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=pJPxf0sC; arc=none smtp.client-ip=185.226.149.38
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wc5Td-003ZpE-6b; Tue, 23 Jun 2026 20:04:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=JtRtCSPn/CTA9bmTH0wClGxUVvAD6YfA42NZj2PW6vk=
	; b=pJPxf0sCT8cUrRE9FLGbkiDjDuK9KioNF844/jQBReWzPg9O4OSPitDSou+KY9qvLQow4fsEM
	dkJuGAxSUKT+Wcs0lY2SlSF/tCUharPdWIOIods9vp7Y1pDHYYOuzrmI0+AFFn6gcocfgdYFDPzpJ
	b67riQiClwNrTfrnpLw8wXPZDh8cy0+K6ixjQKkYIJNiZK4ndB6Km2ASVugFYhMcf3jOqy/x1JkzM
	qNeYPULiNgWANfvdVdlbQWTs245q4jEgs6N6FCCCiBO+y04rWYUOWoNUn9IPveXcUg8eTRmj/aA+V
	f40Yg5niCsNgk41EdwHFos6U59Fg1rX5JWBd2Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wc5TW-0006hG-O0; Tue, 23 Jun 2026 20:03:55 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wc5TO-00GZY0-Jl;
	Tue, 23 Jun 2026 20:03:46 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf 0/2] bpf, sockmap: Fix sockmap leaking UDP socks
Date: Tue, 23 Jun 2026 20:03:08 +0200
Message-Id: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2oGm9CH+irhIJlMdo03INCKU/
 rtRd/dcOGcD5SyscGo2yPwSlbhUMIcG6GaXK6P4ytC13diOZkKNFJ424SPGUBIWXyfbgI56Hmj
 oj8ZPUO2UeZb3r3wGl2a4/E8t7s60fpuw7x8EZoOBgAAAAA==
X-Change-ID: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Cong Wang <cong.wang@bytedance.com>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301459-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com,linux.dev,davemloft.net,google.com,kernel.org,redhat.com,bytedance.com,iogearbox.net,etsalapatis.com];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:mhal@rbox.co,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rbox.co:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rbox.co:dkim,rbox.co:email,rbox.co:mid,rbox.co:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A75D96B9776

Fix for UDP sockets refcount asymmetry in sockmap lookup/release.
Accompanied by a selftest.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (2):
      bpf, sockmap: Don't leak UDP socks on lookup-bind-release
      selftests/bpf: Add test for UDP sock leak on sockmap lookup-bind-release

 net/ipv4/udp_bpf.c                                 |  3 ++
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 50 ++++++++++++++++++++++
 .../bpf/progs/test_sockmap_lookup_bind_release.c   | 37 ++++++++++++++++
 3 files changed, 90 insertions(+)
---
base-commit: 12091470c6b4c1c14b2de12dcbae2ada6cb6d20b
change-id: 20260617-sockmap-lookup-udp-leak-bc4e5c5481d7

Best regards,
--  
Michal Luczaj <mhal@rbox.co>



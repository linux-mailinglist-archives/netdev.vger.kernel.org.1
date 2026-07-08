Return-Path: <netdev+bounces-305937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rx+zG9eSTmrLPgIAu9opvQ
	(envelope-from <netdev+bounces-305937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:11:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA47D7296E0
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:11:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=FKIgk6y+;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305937-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305937-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E92CD3001497
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017C9370AD0;
	Wed,  8 Jul 2026 18:08:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434B226738C
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 18:08:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534123; cv=none; b=KEaRhts0mTNCbhveQd4R4QCLpYDQcbRAWgb5p/TX/of1hheGECiQbJA6yzFJHHjeVzhupd967CmPyR3FjtR/iZrEGX43PWqi9BDnPcyggSeQFveO4azs9wfSYonOwj69kfiegTRhgVwaxZtSDTf53rT9Cu4B4UvQwLBa6jqkkyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534123; c=relaxed/simple;
	bh=KbokKl5nrwSqS7Q/jI+MxYq0pfmbv1r0nrns1022QFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6ChGRlPc38i9lJq5lxmg7Cn0maQIb7BSdRY9DE38NdkRGPiOYHq3ZiU8GOZfuZ70ddUc1/JkXCWDMOuo/grmfH6Nbd8cBi/VIfgSC0npj+rKJ8tHPvnY4SOWqlVteFGQlskfWc/3nhmKgMuZRx0i+uCfiwSVG/v2QOyPF1HyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=FKIgk6y+; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so799285ad.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 11:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783534121; x=1784138921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TX0UR4nd5ReWUWVY7VHdaquK1A7gNg1IcwsjKOi92tM=;
        b=FKIgk6y+0DuEjLIEzZLU+I9Ul3gMGuBThZVnzkebqKww/kMhp2zw7svb50nKozDz0h
         NowvP4Vij1fI8QwhXpe+9x3Ze7tmVrY8EY7ZQ7Rt34q4SHCQO0CD8fs2Fphafryc+arc
         WitUpMQzVYk4UY7ICK419XImFQfVsO8HADT/BFSvHwdPu7LZqs8Qvz6dvdEkqBYNm5wM
         r10/ALqH0vPXewEqyKWXQPb/1r0TVf9nWsJYk8Et5o+KqCvNj7EVoqrLjTsYAKeHZN/0
         W5n6xH5lt0ScxOby69r4Af7D9VfD2II8Sk+EQWcl0pwAjl+pSK21TVYF2yKZU9GG9hrp
         uKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534121; x=1784138921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TX0UR4nd5ReWUWVY7VHdaquK1A7gNg1IcwsjKOi92tM=;
        b=fIKaVxiHpuY8MCKgtscKF655ubllLEzpqfsjv+6vJ1FotTE+tF1AlGd+vvW5vVJHXX
         sTPsK8PYepNRBS/uPOg+NDjcCNuRFkWpo6yhH//ViUhuybXHobcXt50n3xsVNVH24ECj
         YHAFce2fwMm4TyBXVMt3h1RSJLLH0Snf/cF+kNiOhNey7UU77b887T07gVlL921aUGeu
         sSqUjsRb1eb1UptUtvN2/+Jo8wWBPtBT1j7QTyju0XruWVbuxAvkOAxSByfVOU9Xaxi7
         +9RuA70o3rrVqdtiPfA5Ae9btlOWz5F1hLQ6vosGFS9MIuJSEn5t5813fmXrZXb8bQEM
         sdoA==
X-Gm-Message-State: AOJu0YzBJxsF0wsg6RqYUtVRtv1NRlco9EOCFeSLTvVBKi+uxJM6tWJH
	Kh8ppp/5sC/EWdN6VyuHqXsQvkedAMh15Nimh3UZTkgAkFG51qSdxgVGDTwuCdNX3W1vaqgmUjW
	HjFcfNQ68Hg==
X-Gm-Gg: AfdE7ckTmSpKPx12EDBrbEl5k4yfuGAnf+X2O8KKhg5GBq+/tZvbV257eygyHyivEK4
	ebu1m83mBlA1KCNXo3bUbkO3pLZoEp9bOBhVUt4bbA4obCbm5KaO5qXHXApfKrI2U1uBusRbzD4
	mS0PY6UWeRg0ek4ecJkysapNhnNQyI1hHObV+MB2UdAKVf/xpmwkN2haDQkG8csUi2VhfmZYRHK
	X7QvToWHHuyqYEZHGig6Zo4D1rXHBkPEUphe1Ni+NgfB+xiXfcviPoinQLUHBaZuqGEI8YAWAYx
	uZFU41nIuk20vXTj+MK2LnF5wpB5bpcqQLPEnPj4GBiX1jMxZBOCBe+77h2AMKQhiCIIjA6f1TE
	t/3wLUJsqlCjz6inDByVp8rc5mPydzWlSpuIoxc2/JPEhUNPHCXfBscXlmabhFJVixy6axaMOC3
	k3+zw6zK/Y
X-Received: by 2002:a17:90b:57cd:b0:37f:9ce1:7369 with SMTP id 98e67ed59e1d1-389416ec46emr3507540a91.31.1783534121438;
        Wed, 08 Jul 2026 11:08:41 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::7d75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm22158810eec.2.2026.07.08.11.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:08:41 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH net-next] net/tcp: Prevent inlining tcp_syn_ack_timeout()
Date: Wed,  8 Jul 2026 14:08:37 -0400
Message-ID: <20260708180837.9507-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-305937-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:emil@etsalapatis.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[etsalapatis.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,etsalapatis-com.20251104.gappssmtp.com:dkim,etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA47D7296E0

The tcp_syn_ack_timeout() function gets inlined by Clang,
preventing tracing. Since the call is not in the fast
path, prevent it from being inlined.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 net/ipv4/tcp_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index bf171b5e1eb3..f7215d53bbda 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -748,7 +748,7 @@ static void tcp_write_timer(struct timer_list *t)
 	sock_put(sk);
 }
 
-void tcp_syn_ack_timeout(const struct request_sock *req)
+noinline_for_tracing void tcp_syn_ack_timeout(const struct request_sock *req)
 {
 	struct net *net = read_pnet(&inet_rsk(req)->ireq_net);
 
-- 
2.54.0



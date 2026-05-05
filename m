Return-Path: <netdev+bounces-284534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAX5BScs+mlXKgMAu9opvQ
	(envelope-from <netdev+bounces-284534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:43:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 103344D23E1
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E9D5302F72C
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7084A3402;
	Tue,  5 May 2026 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="l119oRwX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69384A33EA
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002868; cv=none; b=q/VoTUdbSBvh0Us/4SQylTAPigb7B9ueR0CUvdptj3XxShJPgMgBDvon+U3ivOvVDS1xeUNzoNKOuoPHf3zRJsspmoXiWOAVAZB5RRS5IbVSZm2goWahl4a2YvILcWlXFKEdtGHBjqwmcIsD2misg40gEQRJwvzyLlijkwSRxIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002868; c=relaxed/simple;
	bh=OoNYBkVO32de2zHSO/KF+HizE4nI+dWFnqVhVZpP2GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUQ9zOUbl8YygC4e/Yw/LU8SDcvPnmxjbE0fPA6hWmSZBusf2At3hYaPimD3Uil76XqvbXITsEKu8oV+ZDoYQj+SItmmA7R1xVf87UqE49yJstGTdMm+XvDq6Zz+Q8fXhdiVwY2yrbPPbM7juLD0CM2oFywWanXA9OV8j0h6dMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=l119oRwX; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-479d9b155deso1862569b6e.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778002866; x=1778607666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LrOAChoW2iOrIQ7b1MLohFxd4l9nMJSCYcee/zzzHM=;
        b=l119oRwXtGsYN3lwfVGr9mG1cqHruiX7MVLSrX8rujqRLFoPXzy0BzrosjpZtgRmKt
         ar2XVQgBhwbiCQm3zk9SP9xRjuTqwcCBFU+Kw8xCGZC1r9SllORTd2aVmGbCzSSGFC7P
         vAsazn60hDsOM5cubmCKMyDuh7iRmdure7FFFFHhPa5WbDT75jUxa9ZV2KKkFPogZO/J
         eDJI13+s5ILU4FPXgsSpV48oExMEGxif3X2QkhfLygImLqUFaK7UH56eiApF9whK+UWW
         YFsBj4U1rnNP3IqwAKfF8TwCCtH/Ja6PmoaJR9OIQVQMWQxG6gFgUm6u1OkMjoXJLkAT
         UEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002866; x=1778607666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6LrOAChoW2iOrIQ7b1MLohFxd4l9nMJSCYcee/zzzHM=;
        b=rluvpq2amlWifxiACqsiT35eZjHpIHWLfeJEQ8PQPDpv0xfgHnVpqsqC29FmJPWjbt
         yyaxJL//l++zvZINyG5eU/N2k+1JX1B+kMvEbeemZ18Z9ezqT0AWsNSOJ4rIj/Ygq2F0
         nftF0e/SMkXWeLKa5jQqeU582ahAoY2DBQKZlevOfQ6D1zHCojaS9KtoDzQ0J/3HjiNx
         2n4SmbQsRBjYrdZ0IfxLtF7a/dUrOIU5Ey38E8tT/QALOUYZha1t4nbAUdw0CkcdIubP
         YLXU7+3wjNtslS5ScZHwux1uyLIKxovPKevF9VjIjSl69wZ3qWlpEmApEdBpNriNFViu
         NPsQ==
X-Gm-Message-State: AOJu0YwrNSL1MBUYXWuIauhsUIy+kQSpuF478XOZnIh7zIq2w+FSokoe
	Be2/HVk6TDgHLDugJJs8/jHXIhKRu3sDsbnf2YCP8R/kyzhbSvMfg9PazxeNghBF/QyqrrRjD7f
	7sS1c
X-Gm-Gg: AeBDievGvh2yL78kJHJl36Mi4ca+nDsk2bpN1mGOILVUhnGSiVflGs7FrBSKn4lEePW
	zIx37ad3mB3Ap9iW/6DxIDaOdHWvWA3XZ4Zv6i0Xt8/x0SIDRRdyreH5d9VC/KD2OXKegZo4E0g
	/uIQzb09XiW7Mv5ye5mxP5IoO0JO7oBvIkkIarLA562nVWoZqURZyNPX0VY96KaAPhEPI9EqlkQ
	Y8A/pl6QA8zjKl9W257YEsWJzP5fTS7c+/aSe1yXVFGv+CUrc/CN/uleRce2BJpdW9o2vplKfZj
	RemZ10BoWfMcouYdPepir8psg9uFIeY4Ov3zPUW4AgQjNxRtXrlx11pb+uaRdkLceCkcvbpf9hQ
	yPhRjFJvDMs45LFDhVGAfvdFUsnNqDSv6kf2viMeghz39y65RByGVCXiIWDcb00fHUULtzOJysr
	x/BchPlrZNuPg38wwaJbsQTQt6XOzazYv7xqnVcAdV0SQ=
X-Received: by 2002:a05:6808:181f:b0:479:eb19:6e6f with SMTP id 5614622812f47-47e33f648b2mr2011316b6e.45.1778002865857;
        Tue, 05 May 2026 10:41:05 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c769c9b12sm9006504b6e.17.2026.05.05.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:41:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 2/5] net/sched: netem: remove useless VERSION
Date: Tue,  5 May 2026 10:38:42 -0700
Message-ID: <20260505174059.651260-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505174059.651260-1-stephen@networkplumber.org>
References: <20260505174059.651260-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 103344D23E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284534-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,networkplumber.org:email]

The version printed was never updated and kernel version is
better indication of what is fixed or not.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 616d33879fdc..2b0b5c032e70 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -27,8 +27,6 @@
 #include <net/pkt_sched.h>
 #include <net/inet_ecn.h>
 
-#define VERSION "1.3"
-
 /*	Network Emulation Queuing algorithm.
 	====================================
 
@@ -1413,16 +1411,15 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 };
 MODULE_ALIAS_NET_SCH("netem");
 
-
 static int __init netem_module_init(void)
 {
-	pr_info("netem: version " VERSION "\n");
 	return register_qdisc(&netem_qdisc_ops);
 }
 static void __exit netem_module_exit(void)
 {
 	unregister_qdisc(&netem_qdisc_ops);
 }
+
 module_init(netem_module_init)
 module_exit(netem_module_exit)
 MODULE_LICENSE("GPL");
-- 
2.53.0



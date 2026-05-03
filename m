Return-Path: <netdev+bounces-283666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHe8KO6n92k/kQIAu9opvQ
	(envelope-from <netdev+bounces-283666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:54:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E64B7301
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20B94300617E
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D543A8723;
	Sun,  3 May 2026 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="C3XL8DrF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5B3A7835
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838036; cv=none; b=jZdFmONLJh2sA5TgqTLEhancgV/ld+lhoNiA6vSvAXIf4ojFS0JqXXU/flttHHCDe7t/2Mjozl1jHSs4VuoJOhL+urDLMrfm4DH0PjtBgyoRCTlbLqc35XKVA16FYo+uZSExAaJaxspckwLBPUgw0zZxFFXR2TQdV7nIleb0msg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838036; c=relaxed/simple;
	bh=OoNYBkVO32de2zHSO/KF+HizE4nI+dWFnqVhVZpP2GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stYE5Vkw4cp2/HkAUzM5S6Idf8Rz6aaJ+F7CKyUNxMfSXR66CMZWlMoP1IonEFSqc+mfM78zI5stEYNd/+sPV+9xci5dRP0M9xDiiMBWOUa2uBiIZl+1yVfSmZdB7CIa3hYoxOFCjKsw3cqywuRzHiYPTwcIj46Mi8HPrT8Jars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=C3XL8DrF; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso3128979eec.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777838035; x=1778442835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LrOAChoW2iOrIQ7b1MLohFxd4l9nMJSCYcee/zzzHM=;
        b=C3XL8DrFLqSpd/Q28PyK3i2LDs/Hg/qFpqidw5FgsXItpKNHU0li8xzteW3Rlh55tx
         BltOZVISSfRHEavcLf0ugHH6PngkEotvINYN7NplLGdc+2UJELLAUVjGAFFHNsRTHe5H
         Qrh4lyASc/PkmFeFfaxAagsAVxdad8XSHGmEqSDF6PJ0JtBq6RdHEm8WndAtGkVbI76m
         RzLF5OUR+Oc2hn+8hyX8QqOiD+ewwgcrTm2pLS4TA1fXIUrDZ5uIYlZgYeX9DTgFZ509
         ercNjjQWdHTjG90gSuJDz4ATZM1Q2xT7Dv5kh15W1aEoHIPQCvAtjBXvyhV4NB5telQs
         bSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777838035; x=1778442835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6LrOAChoW2iOrIQ7b1MLohFxd4l9nMJSCYcee/zzzHM=;
        b=cwhWB98bqzeMcO2diKUvxz6osdgXbQMPPemLeJOBsVqekCcbRKJmv/JFmXp8pobK3A
         fM+KgrU77sKWyw5SZysYT7SSWvhJdO2pAxyHmEtqmLqcoHo1YzA5DC+c0S5T5R61nvS1
         QAivBic5GJWFsk3gWlgTWDpUjqWX1ivXEIp17VCZT/ykHzDPVA5Gyn+diyXwdrWwUavH
         M7GVpIeJztDDrcIfyAHAXo8bAMyzkbyXWOfd+vw13spS+PuO8UbOetsapnS9mO8kd+z4
         So+XJb41TTDE4uM74ly/sdVDpBEM4MWTVbs4xZn6Q6NRA+LPRQX+Obcumt2ZNC2DFGrp
         Vnkg==
X-Gm-Message-State: AOJu0YzfG9nSj3UMI0y8BYU5yNs4iebhNJnJQPFvJAo6BIBxeCYUaePL
	jLDFOfEmKyTYlmxKqykqTquFLax3JXB7l9qFNwvUHxkC+DLmu6tIDkmclS1a+aqjJklN+uXtnW9
	qf7hK
X-Gm-Gg: AeBDieshpo02X8UdAopdZZeSJjAkcuUcL0wGY8QjfJe1YiyZ9Eu1km9VW8PtB4B7lAG
	xzZ/3pQfBdRBmoQZl2+NWc7H55gkAdDMEN3E3zTJjznT2Ddx5hYB39SKlTuOOTaURJi07b0qaRg
	RTPul7eadjJaqO7/ieqKPhC3165hOXC0uMPB1EHWGCjFnJ1KPSZZBO8tY5h5KYovm6KW3vmNdCv
	5ywYuTuxRhFMqmanaoZj71zBb790D2/BrQEWaqtaYekGypR4k+Np3f7Otbtp8UXb5a2zbgPPoaA
	/XSp+qXvHfdpUTrP8FGMmQmt7m8/mq1uYPvqt0Iv0v2rUHjEab/i3j2B+VpVUTmmJeI8tKnT6rn
	KnZ6NZY0TLER+uhrn5tqE25aApF6K0NW09SVbGX5OmvMYtWAWhzAi3bZms9YdEvLMNjArBCfBno
	IP5tzMvpzLwD9K3lRkTZCwN+sqWhAle2KaskaHallmeLI=
X-Received: by 2002:a05:7301:6786:b0:2e0:4edd:64e8 with SMTP id 5a478bee46e88-2efba29054fmr3245345eec.24.1777838034618;
        Sun, 03 May 2026 12:53:54 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3c24e738sm12834365eec.31.2026.05.03.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 12:53:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next v2 2/5] net/sched: netem: remove useless VERSION
Date: Sun,  3 May 2026 12:52:00 -0700
Message-ID: <20260503195348.521225-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503195348.521225-1-stephen@networkplumber.org>
References: <20260503195348.521225-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 508E64B7301
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283666-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber.org:email]

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



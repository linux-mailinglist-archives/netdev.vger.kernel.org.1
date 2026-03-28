Return-Path: <netdev+bounces-272818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NwhFthEyGkMjQUAu9opvQ
	(envelope-from <netdev+bounces-272818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:15:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB98E34FF97
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 22:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75DAE301C146
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EF6364929;
	Sat, 28 Mar 2026 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKqZH9Vt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0068329E46
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774732500; cv=none; b=f4NmlChA7fHufXHQB3R0awBzTbgtYh/E0KYTj1lhnrqcVAvjaE9f7Cwp2ALbwp/P4HralGAydq54pXOzCUTQeRg/0JbnNwNMm38sJ+tHhBdSIEswkYva74r+5Ch9SJzqHdeT+H5nCehbz+d7cr/PBGUAp9O7UmYFBC+o3kbZDlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774732500; c=relaxed/simple;
	bh=4e5mPa9ipNQFdSB2c2OxyejfNcXOupstsSGcGX/T4Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXgVG/qmnQaVF12zwk2aMx+cGgnL1UaFD5doRmLXNDyqFWh9qcOGntUhigY+J9LM2fOVVHbXguiMiCPdehweUyMp1jHp3f0iv1I6XtuCYWshpK/TkPuAyR13gOtI2jbMTWuzhrSJzG6mbBcdXLNpyrBAuREjfrnsWxMii+fBDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKqZH9Vt; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a1443780c4so3526745e87.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 14:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774732497; x=1775337297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6gCLSoGwa+Ad9PRbQ91A93sEC/N4yfYzEMmnT9fLIw=;
        b=qKqZH9VtD0WtY68GskY+cnetvQ7N8tFIzFZS8yBMCbfZBdT2rxryt/zLpr1WN72f7G
         wliBYktgIaKN9jE2olunt58NzSljTcUmF7vygT2rlDzaLc2Nl6UUrXt9MnpppRbeHJl+
         fejnriGyNaaD9JEHjsox3T/kYFKGkCL6W8+ve09/pGholQWrbzdCtWnfqBDX3e4a5+Zp
         gdqg3KlKrlYtPoeJLGmmpkV1ZS3zQD2OqQcYF9214DI3ComolZyyyQk0pRtffy6Hk372
         06/GiIH+BtLpULZM02E2WJAhEfvz8J32B5sG7RtSm9XZiCxkOGGt788DSL6XkpVz9PIV
         t4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774732497; x=1775337297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6gCLSoGwa+Ad9PRbQ91A93sEC/N4yfYzEMmnT9fLIw=;
        b=AARXJM/ibYYuuvyujMJYnhKbFgOt1nvk5GMZTohcECCAL8fjfhOcOhOGsueaQGKTWr
         WRybufvDjKJqeTmsQVYFcrRXCebNAGDucjSczVwO0vDh2pGzE9CEUJM0R1BwfuyCN54Q
         G9c3GEc1LsUOHSvi9TkzYvh/x6STsknNOxXz7fpBxqZYSAA4cyZAJYP/qlxHxcOwUkHU
         xVftE+dBjIUyrhbQkTHAD63RJHh006/+sw+7BOOuOJ7p3RPde472/j4C/tJ2T3K4wooz
         njnEW8xhMDYUqOL825m0ENdY8vGI87Y4JadL4UXZ2Lud6GrjbgvLSCXx4DI3RcX3nL95
         9sGg==
X-Forwarded-Encrypted: i=1; AJvYcCXKuJebdVrfkhWqY016gRcwSanV/vlFyYd0UpqwoZxj1cR5bHm8d0GcC43Ng6QTf9UOAWkcPEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9SnJVv7NNBkjBoYwBOwj2bmGCwZ313rUnG9baVEBbFrwlB3M
	etIGQNScqwVpESjiPo1Gyhq6WbxPnyIMfiRml31WU+1tccTRKX8XNr3Y
X-Gm-Gg: ATEYQzxPiCjRdQu0UEIkvRTcKMMB5PUHm12JtU5F2Rn9F9+OhpQ4Rn1ZDLIcqLQQRAC
	myk139Qn64IPLfJ8jjjNPR2Lx+Bs2vW3tMpXw7SddfrMvCn0erhbwYeZErUIhKO+8TbIe8wHrPs
	RBwD6TobqpUTHlNr6YJ43idnKsf2sAF1RiIMzNRzGXs9/0zHgdrlgN2P1tr4uwvGZ9tMbR2+qn5
	kh7rDv0hc6yOHPj/j8wiKwKM3q1wymJeoMS4pTuQF0oGKR7IzakH3yDYZrTBFQxT8ZJiz9tuxnP
	coSPScSmYmWqWXxB2sEqsADVAU+e6M5QDfVMTpTFyptxpyS7msQRQ+kYX3cZUa3rXG64Jyd3L/w
	9zQ8eMCMxa0lDkry6kZqIeswpTYIqEPvgAmmGJoGYtJXjhH1NNr2qsMgfLku1nwCPLFL18nC8Pm
	unIkJ6c2IO5pzEYzzN+pR1Jw==
X-Received: by 2002:a05:6512:3ca5:b0:5a1:3d08:cfab with SMTP id 2adb3069b0e04-5a2a508f103mr4507750e87.23.1774732496574;
        Sat, 28 Mar 2026 14:14:56 -0700 (PDT)
Received: from yepc2 ([87.68.133.22])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c83911aeasm6350691fa.41.2026.03.28.14.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 14:14:55 -0700 (PDT)
From: Yochai Eisenrich <echelonh@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Yochai Eisenrich <echelonh@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	security@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] net: sched: cls_api: fix tc_chain_fill_node to initialize tcm_info to zero to prevent an info-leak
Date: Sun, 29 Mar 2026 00:14:36 +0300
Message-ID: <20260328211436.1010152-1-echelonh@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,mojatatu.com,resnulli.us,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272818-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echelonh@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB98E34FF97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When building netlink messages, tc_chain_fill_node() never initializes
the tcm_info field of struct tcmsg. Since the allocation is not zeroed,
kernel heap memory is leaked to userspace through this 4-byte field.

The fix simply zeroes tcm_info alongside the other fields that are
already initialized.

Fixes: 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>

---
 net/sched/cls_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 4829c27446e3..20f7f9ee0b35 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2969,6 +2969,7 @@ static int tc_chain_fill_node(const struct tcf_proto_ops *tmplt_ops,
 	tcm->tcm__pad1 = 0;
 	tcm->tcm__pad2 = 0;
 	tcm->tcm_handle = 0;
+	tcm->tcm_info = 0;
 	if (block->q) {
 		tcm->tcm_ifindex = qdisc_dev(block->q)->ifindex;
 		tcm->tcm_parent = block->q->handle;
--
2.53.0


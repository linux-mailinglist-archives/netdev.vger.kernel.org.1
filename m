Return-Path: <netdev+bounces-286331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PVYBNuzAGohLwEAu9opvQ
	(envelope-from <netdev+bounces-286331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:35:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2646505218
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB7C300CC13
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A83ACA7E;
	Sun, 10 May 2026 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byym8Uok"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32235E922
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778430928; cv=none; b=FJvn3SfyUiSBKXLiXQNou/guHNDvWLOHQGRmMar4D8m74FKwYTxr/KD4vqt85HlTi8Jf6P1G9CZfOj1f/6Gvswj70w0oCevE/cCTMybyPr+e8ctG10doUf4eB03dboWag31y9YNqgf5aAHc8OTKHjvaSC3z9PyvEwfZIWB4jkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778430928; c=relaxed/simple;
	bh=dD6l8VmKuNQkIv7tvRgwMxIbtAjjBGjAsfRUM+v1bss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I342JU7WhN3xQtrsBTwcrmlJB6pzPgCCc1L8gdWEZymMVWalOLaAhLn50F38uXMfrhHTp1nhG7yf+r6jaGkskMTL8bqci+YrJEEYAMNTJYJxA58fsnY2qwr63A5hz3AAHpRGaxwWmoLE1hjbueDV2MVxRDJCKTVRnnm31aebMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Byym8Uok; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso31703225e9.3
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778430925; x=1779035725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66E1wRA9xWgEOR2dqWlyPjo6zh/YZ58R9fKD8OAxMUY=;
        b=Byym8UokMGbCigue6+UHQHftxYr4A1Ck8dCM5TM6lCjSw3uQm8fA4UducmVbErqPUd
         v1JvAcihawzU3zCdgZbLkVMM1/Ez/0OHe2/AaKqt5Y6LeYKfjxqD2CtVsQrqOiOApgos
         8hPsNmDq8ByqJ2re1VN//bpUTFteTHa6CDdbl1X7elx3XZuuoItbwx6qhPT3LLm7OpuB
         qrBFoAI2SGdmCKzdqwjlT7FSptud5jn2Wdl7KMbSdsLjeN4A9hzAc5KjpsyWFRpJRgP3
         bMfp73Q/ZzVbSCtJmVZYgbwr5vSK4NLTSurMKWQlMHsP+DKh077e14ZlKWlleUN84ksV
         226w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778430925; x=1779035725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66E1wRA9xWgEOR2dqWlyPjo6zh/YZ58R9fKD8OAxMUY=;
        b=T1Iqw4yBbk3BTTFSXfBNZv91InDJwMZheV/5o8ctUydhMYWBdfxaNPzjEAXpjyTjbk
         CTsn4qSK+YAnpHvnW3dzOVKcQjEx7LD5sPe1xtS+fUfuJqTHDib0cktrjimL1bXARo+t
         qvW7SoPsWi0GBhQB6tbveDnsOwOKrvYbcUNOLDFv7VYpXULJBc7PlypWXSS7fBgI3miC
         2v42QLggAdkCeqwbPvB/GgpnIm/KFvPjU6Ogc2B5ioHRsRK1ZF1Yak5t9TyuY9hYEJbN
         xst977Fi5qH/g4LsIuVojIE94QXm28CfEh8uRADTfMhfSxJncDQSmxblt+UjcHGwtoHF
         gaAA==
X-Forwarded-Encrypted: i=1; AFNElJ/MuB7q1h/c2KrhbwcE2JtqFHBL5UrEUs9EjHYq26KAiynMXlg80wgy2ZURu898mIen7Wjoykk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10Nj5Moh1gWUNE7CTv/d0Jcdin9dbkei/APDgeP9DR5O7Tw+n
	sUF+Iwwrsthu0QfKd3UZygFYLC/RfOiQ88DIYODD3BhtW0REdJQKDUZ0
X-Gm-Gg: Acq92OGxOzY8DdIaLagAGiUx20oK7JV9otit/X9gy+B4cKquUWoszUi7c1dQu//ikd9
	1ScF7iR9QfZ4Eu0UUIyBdp9YX+eck5v90k34NOBCEkF+7prqxW/PGJkgiWtFt1vs/HcpNZwTuVm
	mLxgxlxvKDThnA4jr8Gwswgj5Uki8POcE2AngIyjuzek3EFyh/pINO5am2jTPhEMWAfhltvSTDl
	IkF/wQMiYD7uvNLv3+Ok3ZL3u5hsG+2pQPC2bj45+aiHjApX474z21BcbEDXnzsZgGS3mnHnrfc
	hEDQxI4vaWFbsRvUYvY4kvxM7/nC2EP+AShm7I63motDhDZbbeG2+SNmluWjWeUsDu4ljPSGlqj
	126wRC00WP62wBBzXMb95IsLgfmiWFbn+accQSgEjkLT6uZ/PbAfenVJA7x8ZmSngs3D1EXQQL7
	tCxJg6J8QfADtXTZWTfN9zl/ixZBY6EH65qgt/6p2v7GKer/0IsRUfaaW8Snk=
X-Received: by 2002:a05:600c:696:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-48e51e215a4mr190222805e9.10.1778430924757;
        Sun, 10 May 2026 09:35:24 -0700 (PDT)
Received: from kali (93-41-117-77.ip81.fastwebnet.it. [93.41.117.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fffba52sm143706015e9.3.2026.05.10.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 09:35:24 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=B2=20Coccia?= <n.coccia96@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	nicolo.coccia@leonardo.com,
	=?UTF-8?q?Nicol=C3=B2=20Coccia?= <n.coccia96@gmail.com>
Subject: [PATCH v3] net/smc: fix sleep-inside-lock in __smc_setsockopt() causing local DoS
Date: Sun, 10 May 2026 12:34:13 -0400
Message-ID: <20260510163414.16651-1-n.coccia96@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B2646505218
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,linux.alibaba.com,vger.kernel.org,leonardo.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncoccia96@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

A logic flaw in __smc_setsockopt() allows a local unprivileged user to
cause a Denial of Service (DoS) by holding the socket lock indefinitely.

The function __smc_setsockopt() calls copy_from_sockptr() while holding
lock_sock(sk). By passing a userfaultfd-monitored memory page (or
FUSE-backed memory on systems where unprivileged userfaultfd is disabled)
as the optval, an attacker can halt execution during the copy operation,
keeping the lock held.

Combined with asynchronous tear-down operations like shutdown(), this
exhausts the kernel wq (kworkers) and triggers the hung task watchdog.

[  240.123456] INFO: task kworker/u8:2 blocked for more than 120 seconds.
[  240.123489] Call Trace:
[  240.123501]  smc_shutdown+...
[  240.123512]  lock_sock_nested+...

This patch moves the user-space copy outside the lock_sock() critical
section to prevent the issue.

Fixes: a6a6fe27bab4 ("net/smc: Dynamic control handshake limitation by socket options")

Signed-off-by: Nicolò Coccia <n.coccia96@gmail.com>
---
 v1 -> v3:
 - Resend via git send-email to fix webmail whitespace corruption
 - Rebased against netdev/net tree
 - Added Fixes tag
 net/smc/af_smc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 185dbed7de5d..da28652f6810 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3054,18 +3054,17 @@ static int __smc_setsockopt(struct socket *sock, int level, int optname,
 
 	smc = smc_sk(sk);
 
+	/* pre-fetch user data outside the lock */
+	if (optname == SMC_LIMIT_HS) {
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		if (copy_from_sockptr(&val, optval, sizeof(int)))
+			return -EFAULT;
+	}
+
 	lock_sock(sk);
 	switch (optname) {
 	case SMC_LIMIT_HS:
-		if (optlen < sizeof(int)) {
-			rc = -EINVAL;
-			break;
-		}
-		if (copy_from_sockptr(&val, optval, sizeof(int))) {
-			rc = -EFAULT;
-			break;
-		}
-
 		smc->limit_smc_hs = !!val;
 		rc = 0;
 		break;
-- 
2.53.0



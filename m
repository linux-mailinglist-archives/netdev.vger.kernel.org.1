Return-Path: <netdev+bounces-242332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA5C8F464
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0AD3A7F58
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B072BEFF8;
	Thu, 27 Nov 2025 15:30:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2E42BEC43
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257446; cv=none; b=ItphqcGp3qPybdCk/oPItMnTNnwbHNMxjSn5NZOipyspJyHVRIQJduoGYo7nHFwdFl+Z0AisfuD2sqc+vcQ/t/rxjUhsGilyRwMk962Lz8UVNjqsfV2tjXBfv4ydat6lvSFGcpD1aUrFxPFlqpdgVmdgL1nPRPWQgDu0HiWyRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257446; c=relaxed/simple;
	bh=QxWXz8I2QLGbWNLfwE68rNFGhHNA5j7MyCQzwVPeZ0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DzBJHdQ9roCH7HN5na1/WOtJaRW3GgTno6dyuSbpFmAiP7sj6b0ljLeOdFMHJlmBWrpd6F57ulJ6YX30j2Y/gMJ34erQGKpphQMR9QuxTDqIst2Ui+bi6s52OKj2asAXHilZe63ykiR/wR71CdkdlzE66oxhWO8FgIQTX9niHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3ec3e769759so203216fac.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 07:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257444; x=1764862244;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8Qg3/vkOFUP1Lt1PguyJULS0qEUFEpw0xRXueJJTxk=;
        b=goR5kUnJpukYV//mOhNhhqPygfuIZK6NLx1wQbUYCVvW+LxGmaw1gu3FsY/CDmrJYM
         6qApaimpu3ypscNBdAMrYTT2J2cnxZ+d9ACLtuKWunfnsqFAJbr50RgW2Vn8cmo7qbNK
         InACTM/ZjVeF4qadnLJyhgzdTdF2im38fGhL6t0dnB1nUkLFhbQUm39kTnRt6s7D6cP+
         YzjveCmjnSYjOwxuXsBlqarav4Tp3gS5x8+6BZRt9nSQcrJW8Mv0MVy4sNiug3FkptpH
         GJMDEcIajdY65X9XPCrniXg6cEstPJRV3JzPjz79vlTH5vq7nZ5sPdBkMMXa9itBVdZL
         Mmyg==
X-Gm-Message-State: AOJu0YzDutJfFtAacCGm+YJaWcDx8Ls/L70zhaRPNRAdeOUQKVcgNuv1
	IJILFJDLXY4+zCEDUDK5OJT/Pvq9vSOWT59TGxnTR6UANBq+aRHG5/R9
X-Gm-Gg: ASbGnctIFIxOChSLzxm+26LxIT78Zig0x+b4xvWQQe++M8Y8N1f/CFQSXcrj26YL5nk
	H8vIhZaFmQg0QtmSjLU9upoyMr22fgUoHgFUw/ioa+Q/PWFMlyoYgatdb+A+2vbjUXxMkO3NWJe
	YWcQOje7OlRAGb03flMCL1WExv6aIPPkku3ZWFxTgfNIwC5L+XQzEALjRdkv9a0QAWEzcK/iCC+
	QPefBhypnIE85V3hVnpooTSf69BppWCqO+2//6ycGXCvIKEsEJIn4p6DvoHpDRcCWnhqaANB4B4
	PI0BuLR/a1/UOMPyW7va4nhWi6fCRNxEeMkuszvDvT2Wq/AVZFZH2IE84Ac6ymAtqApLM+58zn1
	d6F5zvAJi5wADOQtamjsvk4xKZpcGmVkhcpgibEdLNxee43GBDXm8mI4QBbQZBQtyCe0RzXZqI8
	ffuWshVp9i8CqH+w==
X-Google-Smtp-Source: AGHT+IE1IykwWNaeiEry9VhtjSQOXUoWbhcJ5famo3M5NrucKs2+1V7YLL+7MzjnA8KRYH24RuRu1Q==
X-Received: by 2002:a05:6870:e189:b0:3e7:eee7:948f with SMTP id 586e51a60fabf-3ecbe28c234mr10135629fac.9.1764257444028;
        Thu, 27 Nov 2025 07:30:44 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dca01676sm681892fac.5.2025.11.27.07.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:30:43 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 27 Nov 2025 07:30:15 -0800
Subject: [PATCH net] net: netpoll: initialize work queue before error
 checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-netpoll_fix_init_work-v1-1-65c07806d736@debian.org>
X-B4-Tracking: v=1; b=H4sIAIduKGkC/x3MUQrDIBAFwKss7ztCldiAVylFilnbpWENKmkg5
 O6BzgHmQOMq3BDoQOVNmhRFIDsQ0uelbzYyIxDczXlr3WSU+1qWJWbZo6j0+Cv1azyPc74nP6X
 sMBDWyln2//uAcsfzPC8HDLrPbAAAAA==
X-Change-ID: 20251127-netpoll_fix_init_work-5e4df6c57cf2
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=leitao@debian.org;
 h=from:subject:message-id; bh=QxWXz8I2QLGbWNLfwE68rNFGhHNA5j7MyCQzwVPeZ0M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKG6iG0QG4IzWJfv7r7dibnjvjdDNxCeej7eHY
 NEmqg2RiteJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaShuogAKCRA1o5Of/Hh3
 beR4EACHVJ6a2Qdwmvsswtj8ylfPoezGyaIkHootvPBqM9calNRGBPjHRVM1qiqUWPaUBxbetVx
 rwVX7xpgbJXhyzL1NMsxaL4Gvfzyy/LdoUWdk7epv34GHXnGJyy0zZlDHr/67WvoMDbvRJqDdmE
 ZL2ZXw/uI4UbG57BCBl7MQb7w2QECbDiY8aUNKia0/dWTkgGDCCF/ck3W8X0zC+doVZgpDVzeaA
 idwra4nyB//J84l7UWkxKCrs1br/CStPjX9dzkl6JKMV3LcVR4RG72x/M17YXcMyktchjw1C1vv
 ZTmWF8dnHxCIPRqlw/y48y7a4DqQFZpE0VnxWZOeiRiUIMeX1zG2xEdsHe9G1Uv4XJ3yjc2S7Rt
 VOB7Zjhd6T0U2hZ7aHvzXdGrfG2wvmANEbSgE/JourJJkPIGaGdJOX3RW0bKLKhfWeZFqx2KA34
 lg09MwIqd2ZF2XP8mOT2BnWDtSrIF3M8aw4kKWgMmxRTznd24SeT1SadHUlf3XR1jQ8Gts7QeIX
 QEqJc8uo1PDpNeAzu49CQ+kXuMpqtYf0DcXVxVfoh4x2bAihiY3Bb8jSX9gxhhPF6fevhPdcJwi
 AFIVj8h3irSnLTsL6cgdrTboMRGI46p4oe9tLjgpr98OOLFs/HRKe+xgcJHn00m4Anfz48ZqSYg
 ZJp3Ys5d4nGP79A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Prevent a kernel warning when netconsole setup fails on devices with
IFF_DISABLE_NETPOLL flag. The warning (at kernel/workqueue.c:4242 in
__flush_work) occurs because the cleanup path tries to cancel an
uninitialized work queue.

When __netpoll_setup() encounters a device with IFF_DISABLE_NETPOLL,
it fails early and calls skb_pool_flush() for cleanup. This function
calls cancel_work_sync(&np->refill_wq), but refill_wq hasn't been
initialized yet, triggering the warning.

Move INIT_WORK() to the beginning of __netpoll_setup(), ensuring the
work queue is properly initialized before any potential failure points.
This allows the cleanup path to safely cancel the work queue regardless
of where the setup fails.

Fixes: 248f6571fd4c5 ("netpoll: Optimize skb refilling on critical path")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 331764845e8f..09f72f10813c 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -554,6 +554,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	int err;
 
 	skb_queue_head_init(&np->skb_pool);
+	INIT_WORK(&np->refill_wq, refill_skbs_work_handler);
 
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
@@ -591,7 +592,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 	/* fill up the skb queue */
 	refill_skbs(np);
-	INIT_WORK(&np->refill_wq, refill_skbs_work_handler);
 
 	/* last thing to do is link it to the net device structure */
 	rcu_assign_pointer(ndev->npinfo, npinfo);

---
base-commit: f07f4ea53e22429c84b20832fa098b5ecc0d4e35
change-id: 20251127-netpoll_fix_init_work-5e4df6c57cf2

Best regards,
--  
Breno Leitao <leitao@debian.org>



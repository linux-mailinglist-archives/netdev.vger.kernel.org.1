Return-Path: <netdev+bounces-275797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEesDNhT1GnhtAcAu9opvQ
	(envelope-from <netdev+bounces-275797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 02:46:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719363A881C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 02:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3157F30191AA
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 00:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC67C13635E;
	Tue,  7 Apr 2026 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blM9Ubte"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E834C6C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775522773; cv=none; b=qBReh6//XK0AFzNZ8nseOQXNCKXl8R++ySfNlRZfsMSz445IaKBKEMn8TsvPRxY26SVCwuAJPaT8BJrm5SlwlEGSB8kO7iPvO8Rl8KXqsQDq6zSKcVdwkA91v7Jt1C8ATDRErXegKHt7BOh26jrnEmERIZuv9gE6Xnea9oyNmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775522773; c=relaxed/simple;
	bh=WyhwNuIyCdlCDOdumhmrb3Ca9yjccs/vId8OlVdNMMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r+5xo3RIiDvT3nni/Vsu3tUQz3HO+o5+q+fL3NsMS0hhxxTN62s5QW5hu2k+hhhWpj1hxVb51Yi17NyXHDWvBDIsGU4+0VMtA4eTZ7KdmivwimB1ESMzHc8Bdiycvtfa6OiABoL1O3SZtgs3z452r5MhmkrjWUoGk30zYC0jeNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blM9Ubte; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89cc797547fso55243966d6.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 17:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775522771; x=1776127571; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tVClSKROVTZHGAQRCCvPATSi+gjnZ5F0+pvtkkRbZBY=;
        b=blM9UbteUt6qyPCyoSO5iMKVk8QHweBb35uXSAQl4REvdbbNim6EYzWgJhea1Yvgts
         sXVuwAsccr0S/rIY98h0fJT8QmRhkVepspRWBapEhocHxELw/DZzqUzSeL8l7npxysJH
         4oQBv7Qo2Ht6DyhNB9jFaOapnU6nHHzKBsRhUBtNC3VIICtMk/jvKG6Zt8NGwIBV2snK
         DEzGkffEWxCDyCc6iCbPLg534sSbXmJFNne1v10k+bW4QSWgdqostyfJk3Z0rqF5KVJB
         Pmd6TlPUQkyPVptX8j+booVzWJQeLyMDNCZMvojA7Jmxx4MhYEStvP5PXiaiJwxBF/lN
         jEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775522771; x=1776127571;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVClSKROVTZHGAQRCCvPATSi+gjnZ5F0+pvtkkRbZBY=;
        b=Bb1kZ9NEzckabKtXso3gugZ82uCpsrBb5Ycuxtte59cYTj+f5lPvX+wdhIz+dGeAWp
         JfNzH1Z9velcmPJgdwB3+VXuq8KyNPxG1LaGKDg/C9LGpu9Tg3jZ0DM4BHnO9z+sORdA
         hQK3uqYhpbRVFeqaSOAxWsX7L3MXxjyPRn0zLliNTPzsIKYtWF0l2/O5l+wi9aOopc11
         Qq9hautiZxkUBGxQ7BzWR7Qs6bjcPnXJPaow6fZwtxBi0l1Mudclcmg2uZt7YSe/sJG7
         FM2nDKXams00I2sT1Artmklwbbzs3ENUNf8qwNRvgmJHn0I5Q8w9pxNyf624/at0Ef85
         ZWdw==
X-Gm-Message-State: AOJu0YzIa+WrEaTgp2FyxKeIQ398ixYhxwc1d7GTyGdLwZ3FlnG0pNWf
	7OleaDCeggP6TXK0z2ugwfbUESppkqVgPU/vPhm226ebqCd3SgsBWEH+
X-Gm-Gg: AeBDiet4d5+2r9uE1D5jjd/euCNKWuH5xp3GVSoTFIV7Y8iDNNaiqwzyjroFxhHkWgV
	ekJYBWjJfjge3JU+ToKKHSwFhZOMTj0WrLpaquqSXvUM2tP5h8yXsyMzvv33p1c14rcWd2Ums/M
	+iT8BFoW9UrYVinxyw0UYXldAcmT3da2YXFSdLUpQlUs6obXG7hOy3kze40O9DtDjskiU6yjmkW
	MAN92stmfFGvwQR0AgPHBpKQ4HllV5P7v5BtdQCB+9CtvBC49jtQAkIJK5wW2Q5Vbq+DhQQm09K
	iCTRw4qADAolNWHtv/PUIs9PltBMkh1mzbQaz7bX6ECv5FWLS3ZDTdsRoctc5XzuHDV1JR480V7
	Cv32OUAJQZ699LfCl/qvIcrOJFUeLHYO8rAS1RTAPqBxRSVDj7/ynT2/EtL/l+zpI6sWNdKYGtb
	wYcohcsVG5l7BB8azrVTnO4nn+eIYsQal6
X-Received: by 2002:a05:6214:4992:b0:8a6:25ee:fc53 with SMTP id 6a1803df08f44-8a7020bd406mr260799546d6.5.1775522771182;
        Mon, 06 Apr 2026 17:46:11 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5974e8e8esm134853786d6.43.2026.04.06.17.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:46:10 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Tue, 07 Apr 2026 08:45:39 +0800
Subject: [PATCH net-next] net: macb: Use napi_schedule_irqoff() in IRQ
 handler
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-macb-napi-irqoff-v1-1-61bec60047d7@gmail.com>
X-B4-Tracking: v=1; b=H4sIALJT1GkC/yWMQQqDMBAAvyJ77kJMgyX9SukhiRu7gqtN0iKIf
 2+sx2GY2SBTYspwbzZI9OXMs1RoLw2El5OBkPvKoJXulFEGJxc8ilsYOb3nGLHV/hpNb2/Weqj
 Zkijy+l8+QKig0FrgeZr88SOFchxh33/pNnkgfgAAAA==
X-Change-ID: 20260404-macb-napi-irqoff-12b3f4d9799b
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275797-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 719363A881C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For non-PREEMPT_RT kernels, the IRQ handler runs with interrupts
disabled, allowing the use of napi_schedule_irqoff() to save a pair of
local_irq_{save,restore} operations. For PREEMPT_RT kernels,
napi_schedule_irqoff() behaves identically to napi_schedule().

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6ec7b110dc7219ca337de4c6f0cbe38bb11558b5..322545b3be23f8d2c4ca2e3da61e057496458eab 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2149,7 +2149,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			 */
 			queue_writel(queue, IDR, bp->rx_intr_mask);
 			macb_queue_isr_clear(bp, queue, MACB_BIT(RCOMP));
-			napi_schedule(&queue->napi_rx);
+			napi_schedule_irqoff(&queue->napi_rx);
 		}
 
 		if (status & (MACB_BIT(TCOMP) |
@@ -2162,7 +2162,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 				wmb(); // ensure softirq can see update
 			}
 
-			napi_schedule(&queue->napi_tx);
+			napi_schedule_irqoff(&queue->napi_tx);
 		}
 
 		if (unlikely(status & MACB_INT_MISC_FLAGS))

---
base-commit: 816f193dd0d95246f208590924dd962b192def78
change-id: 20260404-macb-napi-irqoff-12b3f4d9799b

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>



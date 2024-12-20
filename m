Return-Path: <netdev+bounces-153728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2699F9759
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 18:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1799D16862C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5C21C18D;
	Fri, 20 Dec 2024 16:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dPgu79rI"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A70621C184
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713853; cv=none; b=Ns4HVVeQuDhFJqgy4bHaNcLMRF2Gg5deDJ18trK0Qtm9bTLq0gXduvxWuv9Xs5JOSxv5knGg49neTnRgcjGxj+LFTPwR8/BC6LFuU2jAnnZxmBnBSIULzH5SckbqJ4iY1WiG7N2KiDIUMKJEx3Wtoic2oZHV344KBPrsKbmRDUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713853; c=relaxed/simple;
	bh=AOBd0F7Qx7Fxbmbd5Onnm0Dzrn/3mRnjriqMQSE4qoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hk5qIXmd4hTaC/69l4W5JrmTSBIgHR9lDICTEmPa7olS5dwZ+P3GLL4IMLcySR3PmbpwtNtq7AXAtc6OZZTpm9XI4ufB5AytF8FziwaU2HL8FWyqP7zJczjl0L2SmJHiubj7DSt9v8fcjQ2WMtQnbZN7EIG5HXkw2GlGudTPdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dPgu79rI; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 047F5C0004;
	Fri, 20 Dec 2024 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734713848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=THLHDzmAHxt/qZwMrTMralDc8lxghKhfxiCYeYGJvCA=;
	b=dPgu79rITDboi9CGw3HRO+W6rNNRVFN2gcUFd3MbG70Y6ylmyDlBsa/BF5bC2qprzgHe1E
	FF9GE112Lr/KU0g9xI7aKznxw0sTkgdDNn+IE4rlj10rD0gc+0SsU4dPUc2d971HBpoRfb
	YgmBUbi7ow0vFl4yjJyn8IO+F/UewInyHh/GorwIEC1k3Q/HOUVfZg+hNZiu2/pcyf7XXb
	S5VAkUnfZWyZQve6g60jNkqJ/7p46k/7Jh3RjsAKu9ryebS9Ng2hho5IBpVtItCqgiYAH5
	zWwDfudAuCMZE7RZZDIUQfvrF9bKcrnnLkXDRNRxOT2jZbmlzXLbva+04K3rKw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Fri, 20 Dec 2024 17:56:01 +0100
Subject: [PATCH iproute2-next] man: fix two small typos on xdp
 manipulations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241220-man-v1-1-2ac51fb859e1@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAKChZWcC/x3MQQqAIBBA0avErBN0EIquEi3ExppFKmoRiHdPW
 j74/AqZElOGZaiQ6OHMwXeocQB7Gn+Q4L0bUKJWiFJcxovZSqcnqdE6Db2MiRy//2UFjinchVB
 4egtsrX28C8zGZAAAAA==
X-Change-ID: 20241220-man-8c0f47042cf4
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 man/man8/ip-link.8.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 64b5ba21c222e12b9b0f6e087f85bddf7e374a4b..b40c9938f5a88a05ffa0f2c4628438668e7231dc 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2467,7 +2467,7 @@ loaded under
 .B xdpgeneric object "|" pinned
 then the kernel will use the generic XDP variant instead of the native one.
 .B xdpdrv
-has the opposite effect of requestsing that the automatic fallback to the
+has the opposite effect of requesting that the automatic fallback to the
 generic XDP variant be disabled and in case driver is not XDP-capable error
 should be returned.
 .B xdpdrv
@@ -2476,7 +2476,7 @@ also disables hardware offloads.
 in ip link output indicates that the program has been offloaded to hardware
 and can also be used to request the "offload" mode, much like
 .B xdpgeneric
-it forces program to be installed specifically in HW/FW of the apater.
+it forces program to be installed specifically in HW/FW of the adapter.
 
 .B off
 (or

---
base-commit: 19514606dce31e85039b3b19d538e576824a03f5
change-id: 20241220-man-8c0f47042cf4

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



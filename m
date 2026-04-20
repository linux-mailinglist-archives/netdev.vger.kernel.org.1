Return-Path: <netdev+bounces-279954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Yg3VLX+x5mldzwEAu9opvQ
	(envelope-from <netdev+bounces-279954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:06:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1973F434CA1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 423F13008799
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 23:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BC8378807;
	Mon, 20 Apr 2026 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="O4w8IPPp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C3175A89
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776726396; cv=none; b=tuKWCJb3IdEgkwPseasWUktnmdRMJYEAqEVYPeQlNYgn/lw8wHYs1GgAFlnl4eiJxUM7gKlmK5or8Eb57WUsNIBzDXwbFTa4Y6o/yI00xLZFULEt6qTp7JR+HGCOqUqzuQDgJheV6r49deN+PMz7VQYlT2BcgNZIqhf6efmFE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776726396; c=relaxed/simple;
	bh=pXp2o7ykhMdz8onvKJbZ3+CNj0qoao3WpLDwMtvLCQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rpzh7TvC0BJRmOaIM0YjK8zqDbq0Prmgctut4gUESLiZZS5XOP2H9C7c2zk45ZbguFXTpJDLlgia7xzybZIFV8h9/yUE8FgvRDbQxjCDDFPOFi3IVNpVxCADefn6cYWUepKCWSJt1huRIPT35sIJuOByn97415V+4a0gO9AKYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=O4w8IPPp; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6745a88eec7so4568733a12.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1776726393; x=1777331193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpRjN4cuiWAUZ2C57RWT8FrmEMcVyFUy6yGU1zLq6fs=;
        b=O4w8IPPpyEq/5yUiUbw049Fm42JLWl3yVrUPVhtBBfvnMTm3n9xi4iJlbygEUuQVAC
         M1tu0qkm3zQ/RZWeIhvMJMzZT2LkWoCmzHGFGMMu2u5xEMqUawQiU21XjyGtd6N6Yxsv
         wfFfevqXd4UFrUYWTRqb9SDHPJcZJrG+W0WZiR26hC3W2NSwYQgEJ7gQWfZ7syUixxp5
         XACugeu3Ah65iAb+6mDCym+9Xub0HjWISwiiylf0dvnSGMbxPOEvTOgpJNzE2SG1KnjP
         x0Y88Fko9Dd4PwIWo08trfvNVJIeB52lIEnqKQ9bY8alGpb3DowGzO7YnEN4+VaCdkxm
         idQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776726393; x=1777331193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpRjN4cuiWAUZ2C57RWT8FrmEMcVyFUy6yGU1zLq6fs=;
        b=WQFnc8nhlZ5WCVvivYxSn0UV0itdxvws+Gd3iI93rS3iNrnQ/sNSBkyLLJbI2eED3p
         3xwg5gBMBkWHCcMtoFRUpYfpo/1OrAQmEVbf6ySfuKeSlRQG2/8XwL5ELo4a7j5mxxoy
         8Bf+ix/L/+hZZZ64U7rD9AivQLblrbB2JnIPizmklJ4qOc2phYmpw5QEMmbLQkku5Y0e
         vJnfKgjehahALdAfHiYS/fJIA9id4v91YV2hsmt95me3Pb05EqzL5RkUwlhx6Gma19hx
         DTgWUskxQbjEYRPXmYSESKOsM0SZngda7IqyvZH+to5mXE2fH5NUmQ8TIOe86zpGz+qO
         kJ5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8/uQ2TsWsCb5jEQBhX1H5IjmTP3D/ewwVTVE84tNH9V81nFEhJk39CO4vtj8Zmz98ezRss6nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdwGM5kLPdrw+o+Q8IKgCfPOs87IDE6w+jaQrSeaNKhg6N3nVA
	p7IOYwRtO+ZPgWtELGZ1nz5TQn46bvr42XONl9Z/h6ONNXRVvgYx7l47iw3C7s5vQbk=
X-Gm-Gg: AeBDievnHedjDEXdSvqZnVmiZsTNLgm2N2vkSUTDs4hFHF9+2gD3DXLDTsJ/2TIK3N5
	0cenzZNYtfhPbpK2L8L6wifnesZrOFZWhaUuJs2Q4IMJXMGmFzzIOjKOieBQZaVPu7sVDJtK0Bo
	DO0fWYI1MyxrpgicsLHEx1TVf8kgJfS3yzxXr6vRiw8dAbIiGtBqc+tdASS2ZeReUgBY7LyAJwO
	cq9cSSjAK2fVLccbqThGpOuMt772tsyFQmCyEe96IbFZDkuyl/vQu8P3CTW61TDwrSKYMJhiSa0
	XXPEo8NvV+6B73hRcHHwle2tQySBVX28hmoCPN+0kDWlsT/iAIXQxmSTUcUPEGLaf7kFRfAukMZ
	oPquK/bd303ewKfIdrP4J0vx6Zx9S00vj7MJNSwyqAr6fAM46BnXfWR2aOU9G24sRblO8Cio0nI
	IbtlWumU87K8TybzrsWhGMo/U2i8vZ+aA=
X-Received: by 2002:a17:907:6e8c:b0:ba6:e18f:1568 with SMTP id a640c23a62f3a-ba6e18f1a53mr360000066b.32.1776726393443;
        Mon, 20 Apr 2026 16:06:33 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bd24sm382729166b.32.2026.04.20.16.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 16:06:33 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	John Stultz <jstultz@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [RESEND PATCH] connector/Kconfig: Enable CONFIG_CONNECTOR by default
Date: Tue, 21 Apr 2026 00:06:30 +0100
Message-Id: <20260420230630.205527-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[layalina-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279954-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[layalina.io];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qyousef@layalina.io,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[layalina-io.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1973F434CA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To make new tools that depend on it like schedqos [1] more reliable, it
is important to ensure users can find it by default on all system.

[1] https://lore.kernel.org/lkml/20260415000910.2h5misvwc45bdumu@airbuntu/

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---

Resending with sched maintainers as requested by Jacub

	https://lore.kernel.org/lkml/20260420230422.mdfy4icsuhjh7fe3@airbuntu/T/#mea6edb96570c5d5aa2af43a5d11f7c775d0c4dca

 drivers/connector/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/connector/Kconfig b/drivers/connector/Kconfig
index 0c2d2aa82d8c..bad247d47146 100644
--- a/drivers/connector/Kconfig
+++ b/drivers/connector/Kconfig
@@ -3,6 +3,7 @@
 menuconfig CONNECTOR
 	tristate "Connector - unified userspace <-> kernelspace linker"
 	depends on NET
+	default y
 	help
 	  This is unified userspace <-> kernelspace connector working on top
 	  of the netlink socket protocol.
-- 
2.34.1



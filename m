Return-Path: <netdev+bounces-115248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7CE94598F
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA61EB22D4A
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2B71C2327;
	Fri,  2 Aug 2024 08:07:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B261C2320;
	Fri,  2 Aug 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586059; cv=none; b=gXYhuzSdOaczflx8trxuNUG5fOD/vXa0Jx3XgvzOE7dmSlLpstxW62ksf8MoBPzOOSd51+W4HcokR05b8nem3XM5dLU7t5d6Lph4tPsynDq5ojWX9o+Hk7K/vo7+cWXvkbWh2kLcF+ziB76VKHLepxRhuIL2FmLwlrtvQeUzrLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586059; c=relaxed/simple;
	bh=pbHBycrVCFDsyq1V5V6Iy22R6+v1Cwgyg0R8xo/haNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogpiz1HaIQGsj0ZxSXP4EwQA5L7nUqQHmJ3833nUAl01TOO+99B7E8SpimyEjYECyEzVrDNPwJxUnSBc6YKtEddz4dJzKq1nWhvuEYPwl+ei8qlHkgBkqx42gn/diqbuoX2YCdYirXmnpse7zdtNoHpwjKvM+fiFlisDfeuWnu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso10970997a12.1;
        Fri, 02 Aug 2024 01:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722586054; x=1723190854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tW89l+b3r4SnTW2RmO8UaiObA20fmU+fo2Kiu5RwA4I=;
        b=MRk9VmGAe6Qw8JkzgH5QOF9xfsDb1tZtSuL8+GE1z5y0yy1jqjF93m5qg6Ae2aTutn
         RTBXRU4uI+I1t64zAbmQ7bjQUFI+G8iClyoUq4UiAeq1AjL147VioJeeUWjiKPil9YRm
         /B0TXMTttgU7d+bOCAYvJ6TPfXF03UGPtrxw+xzn4uyzDXiaYpk9XGAH/Lh6dVeOSM5J
         uYiKlFtmT/IMwwYaCccej7nvYdMBOd0mH5Q+qpUa+6m67+FOwriYwBeJvwH9pqsBSdoR
         KwnCtJQ3hJVuGxdW10yJrjHirazoyy8BN3lwDL++QEG+IMPCvPYJWs++s2JEYtR2stK7
         WyYg==
X-Forwarded-Encrypted: i=1; AJvYcCVArh1rGJTTiKEgAo14HyGoGrdKnay3lkkTfzR9tK9RyLI3DOQ8+MWxy8aDVPIZK1zO+Z4EEm8dAkCv/6dmFLTANBTxi5rguAFwYnQnmNexkiLP/KRVQACvrzJLE8lfC1awy1xN
X-Gm-Message-State: AOJu0Yxsy0Nspnm8ICkBM8OXzvdbU8cyjcbwm12CBA7lfiuFkGfRTn2p
	hjQkSgnlZuMURWckyqTInTfqZ1onJ50SXFk3Mm8gRKA7DMABxk8T0x+rRA==
X-Google-Smtp-Source: AGHT+IHvnSTZ6l2PbLFq+BB6u0sWAuAYIh1kX9sMG5lkaGeQb5lploa9+GYusl3HDvtqVxGQXuqDYA==
X-Received: by 2002:a17:907:9803:b0:a7a:be06:d8eb with SMTP id a640c23a62f3a-a7dc50a37f2mr208421266b.53.1722586053540;
        Fri, 02 Aug 2024 01:07:33 -0700 (PDT)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c67a43sm68767966b.96.2024.08.02.01.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:07:33 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: mpm@selenic.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: netconsole: Fix MODULE_AUTHOR format
Date: Fri,  2 Aug 2024 01:07:23 -0700
Message-ID: <20240802080723.1869111-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the MODULE_AUTHOR for netconsole, according to the format, as
stated in module.h:

	use "Name <email>" or just "Name"

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9c09293b5258..ffedf7648bed 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -38,7 +38,7 @@
 #include <linux/etherdevice.h>
 #include <linux/utsname.h>
 
-MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
+MODULE_AUTHOR("Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
 MODULE_LICENSE("GPL");
 
-- 
2.43.0



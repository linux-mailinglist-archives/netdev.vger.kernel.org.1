Return-Path: <netdev+bounces-130492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC898AAF3
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E43928A86C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48631196C86;
	Mon, 30 Sep 2024 17:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DFF1957FC
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716688; cv=none; b=cDjYxsOzPpAbpPI+/T75n+Nlv51M/6mf10REPxUCGzdHSJDoMvWMoaKQtoSYr76W6vLBVHvHfNw6h8eHYD4CrkLOz57YBWhefvRrjl/kuY8u8StMfiAqjKcb87h7bEFWjvvmxYR//kS5EH4wxGClwJgdAuDusaN5ZEzHt+rTfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716688; c=relaxed/simple;
	bh=mat5v89stmIyz1NOS6PrFFB6n20vGw2AVQ4ZCrezc30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMiY1NDoh+wOUsBeV5wS+9Vc8/QukEBQMAovWQVAqhdSLQi2LMdT0krA0WyeUdMNjFT+8zZQ/+zeqGepklQXBhrXnu+N621hyYvYEhFkk9RqJ+GMt1Sj+3VhUI5pCogiU2U+jGZunnirIA5JfJn1N/sWtnht1jsEOif/VbAxFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e399ca48f3so1375504b6e.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716685; x=1728321485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5K9amt/Km0z6IjkBF+yG1dWFEwRkvs0nmjjUE5BXEw=;
        b=TMBjRYQ/KNacqCDJTtum1UMN+rPMgh13149NVDW23xEIynJKWaHTb5WTyBDQCPChcJ
         NQ0Nfhl09PA6GaQg6ewVdo1jJd0ULyqVnEa7T3vFlOHZLHiSOrk8bPma/p0uV7g/q0ZM
         otxia9yiW/LRnfxlUnkG5yKVW/U3cImMkVY9MNRnAiSXWixWdbY8Itc+yNOuy3kyaHgC
         iFKRpkdhe8x7NhMKXySLJFVlOH+tjDYFrfg9RDQiUskv8sy1wM3KcN0Bl9ySqe6+h3bd
         J4H+yPdiy2JgcHaeoumYy0SRLZV+e2AcIwU+/CW0LNNboAu2swVrUNRuD4R7T4R8cZwf
         Fstw==
X-Gm-Message-State: AOJu0Yw7ps90k1zXfyNdqHo3EHo6zhrm9PFEZOufuUBK6E5V3SicMxO6
	SQDXiheatNlv827RxHTiilgBYg9wPPE7rlHiy+1UT7V0UxtmFLp6w/qz
X-Google-Smtp-Source: AGHT+IGS6eOfoUEDeWpBBJP7vuYC6XFegvNnzLp10Gnionp4cnjjo+K6iLWddYBGAYNjOAMUuAabPw==
X-Received: by 2002:a05:6808:238b:b0:3e2:70fb:2216 with SMTP id 5614622812f47-3e3939e1b38mr7139749b6e.41.1727716685606;
        Mon, 30 Sep 2024 10:18:05 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2c876dsm6811332a12.53.2024.09.30.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:18:05 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2 07/12] selftests: ncdevmem: Properly reset flow steering
Date: Mon, 30 Sep 2024 10:17:48 -0700
Message-ID: <20240930171753.2572922-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240930171753.2572922-1-sdf@fomichev.me>
References: <20240930171753.2572922-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntuple off/on might be not enough to do it on all NICs.
Add a bunch of shell crap to explicitly remove the rules.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 47458a13eff5..48cbf057fde7 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -207,13 +207,12 @@ void validate_buffer(void *line, size_t size)
 
 static int reset_flow_steering(void)
 {
-	int ret = 0;
-
-	ret = run_command("sudo ethtool -K %s ntuple off >&2", ifname);
-	if (ret)
-		return ret;
-
-	return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	run_command("sudo ethtool -K %s ntuple off >&2", ifname);
+	run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	run_command(
+		"sudo ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
+		ifname, ifname);
+	return 0;
 }
 
 static int configure_headersplit(bool on)
-- 
2.46.0



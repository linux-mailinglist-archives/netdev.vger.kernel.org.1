Return-Path: <netdev+bounces-15202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAB47461B0
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 19:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92AD1C209E6
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAC8107BE;
	Mon,  3 Jul 2023 17:59:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D086C10941
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 17:59:00 +0000 (UTC)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BF0E66;
	Mon,  3 Jul 2023 10:58:53 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-345a31bda6cso25663825ab.1;
        Mon, 03 Jul 2023 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688407133; x=1690999133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLDpvUuDt1pSQ6XZf1EhYr02Va2+zEjOqRg+3qDMtro=;
        b=hDaAixqAKj4dk/htPLAEJ9KdQiPhKmUvD0Hp88xsn8w62ORQttwJNDpAwL2akcx256
         TdMTM8A9KAdpHCrqLkqJnmh0bKaXw2k1YSR28Jllu6HTZKBRT2tsCfIOdpwmRfJkL3nK
         7h8lCVboOp8QxR5DeBBVLyPQ0aUt0LUNhy6LM5DuwU9RTyLkwAOrMUu8xPfX0rs8soeN
         DJgcgAj7DCX5iIANJmD4NJgv7lJSU1VD4u/8zgTji2fGy5YhnKx3g6f1N0MDZLg+Nl6L
         jnFYLbLCs9M9PUT7wGm/qEvuxpNGTL/DZRT49qinLaFulfQfgvV/E9jiz9Rbz15P7VYY
         S/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407133; x=1690999133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLDpvUuDt1pSQ6XZf1EhYr02Va2+zEjOqRg+3qDMtro=;
        b=fWFA5AwswwCr5mlrROs4549r10VUO/sdry4oap4rSPu0ZiI5K2wZUOewO7uxcMMK4e
         Vbw29xeLf7pF4yDHLVfReAk1gLL27ipLlrqp0/E0T36B9sMZ3yktJJmfg4biq0hvBMrt
         EX6I7nUlfYlCKB4Pxhy4XBIq4tyZyCg7KeoVteMZzVI1Khtec74sf03yVeBLi99nIZ7g
         BtvtYnTHNPg2C5cOxiGwYig5bFLHmqbQ91piSufCTQEBorkw77Lx3OXg0nFxUESYvsAK
         mZJ5kbJtx/W/lVfCM35Jbn9fivsN1/h1iLoudyIWw4AqyCm488KP2a/4lfwc2AAUBonx
         a4xA==
X-Gm-Message-State: ABy/qLbQo6ZIxIKQLhR8H9C9pvoIqsajswSLBqdrLjYXvy/sd5JxBuwE
	0DQktMHLmZ3OBP2oJWb/aXo=
X-Google-Smtp-Source: APBJJlFfacAGKjTvY0YAohkxmzRehPWyKSU/NiK6UBBNJFnogIMmYKWfcRujyiXL1/QU+n/0RG/A1g==
X-Received: by 2002:a92:d4c4:0:b0:340:b569:aec1 with SMTP id o4-20020a92d4c4000000b00340b569aec1mr10747253ilm.28.1688407132993;
        Mon, 03 Jul 2023 10:58:52 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id e5-20020a92d745000000b003424b3d6d37sm7004198ilq.24.2023.07.03.10.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 10:58:52 -0700 (PDT)
From: Azeem Shaikh <azeemshaikh38@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-hardening@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org
Subject: [PATCH] net: Replace strlcpy with strscpy
Date: Mon,  3 Jul 2023 17:58:40 +0000
Message-ID: <20230703175840.3706231-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 include/trace/events/fib.h  |    2 +-
 include/trace/events/fib6.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/fib.h b/include/trace/events/fib.h
index 76297ecd4935..20b914250ce9 100644
--- a/include/trace/events/fib.h
+++ b/include/trace/events/fib.h
@@ -65,7 +65,7 @@ TRACE_EVENT(fib_table_lookup,
 		}
 
 		dev = nhc ? nhc->nhc_dev : NULL;
-		strlcpy(__entry->name, dev ? dev->name : "-", IFNAMSIZ);
+		strscpy(__entry->name, dev ? dev->name : "-", IFNAMSIZ);
 
 		if (nhc) {
 			if (nhc->nhc_gw_family == AF_INET) {
diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
index 4d3e607b3cde..5d7ee2610728 100644
--- a/include/trace/events/fib6.h
+++ b/include/trace/events/fib6.h
@@ -63,7 +63,7 @@ TRACE_EVENT(fib6_table_lookup,
 		}
 
 		if (res->nh && res->nh->fib_nh_dev) {
-			strlcpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
+			strscpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
 		} else {
 			strcpy(__entry->name, "-");
 		}
-- 
2.41.0.255.g8b1d071c50-goog




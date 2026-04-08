Return-Path: <netdev+bounces-276316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI2FLB//1Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:09:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DD43B7E7C
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7159300B997
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63744377015;
	Wed,  8 Apr 2026 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/gp3Rac"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E50376483
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632146; cv=none; b=pJ4amI9Uxs5Q5rIUDcrpmaik6cxELjZGYzljJct6HYth5n8mXiEMsQwoPGkUFuugjw2uF1iADDHTdBz8qSVWup/0s+2hzIN0XEo4FucNIqFzjxgA4f+rgE81ksAd11qsGfL+e+a+kGk5rgSOXgaXcYzcy3vtZ0prx9CTK9aN0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632146; c=relaxed/simple;
	bh=VWRVAtFJu4VciOy0IrY8WqRDMCzC0pdtaBc6B4XdvM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7V6u1F1Ox5OgcyHZRG8YEjvx/+P4Q7e95tuDEgq1PosDRupzvCUDAeVJS+encxT033QOew7/bKJzlWxlL1PHJ+qfOm2yqSbLX0h0mDiLxRkNIVv9p3KPl2V+7SlUDJVBmjtA46K0anAqqNn8S2HcCuu30AA4KLHz/0Yvo9zoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/gp3Rac; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b24fdac394so57671665ad.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775632143; x=1776236943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0UuIfmemJrB2tpt/LluMWQs7qTsCKBTwZAZqA177Vg=;
        b=q/gp3RacFQdEo/v+ctzr3SscfVFxtLtCtVyHH9l1KeDpP8yOY43B0MZY4J6XrM1LGj
         JAz1BSCcS94b+u1agjtnMTykCbwRmpfgwiC5vz10y+52R6pxPhxUMVT0Bn5nYABf10Ch
         8NhTQNHzC3VFKOMpm+C6tvmxRkWYM0xcSdGTqtzbrjiVBERqcTD46xaV7c841A7Lkdl8
         WOGPTSaSXcDwnFvIAokIGDHgBm2jgHADxbg5JCRn0Mdk3VyVQYC3BLrvGtq+1rUjwMky
         r6/34Obe6nhf1oNpuD2cvne4oPS3fSsfUPN6fKA2o9q+XwCzjGQXPbVS3P95BlCuQxSM
         JIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775632143; x=1776236943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I0UuIfmemJrB2tpt/LluMWQs7qTsCKBTwZAZqA177Vg=;
        b=iBunv/0HyNCxc0I0VXMkCDznXQ8GG/sW/Yyopxpxwmg9RvoDSpGkYL7UXxYrJW3sWX
         XZA7SsD5JyPXpXqujZakm9XKFwLKkRuVbrllYo0OQN3bTrsZmhKqDac/UtMe2PK1/r8J
         Hr4PgTZc9rTPoyyf9b3O5/nKDio8PTsdB8wWUQCA7ujSIguQBBO7beRNJeA8Q/iQTRGW
         QkBvybB87rF5HD+55AvokxTGiebROJ3/RbzM2/Aici0zpgIQ00fM3glYbKkGkomYk6iA
         p0L2rRW4wDLvu/YO1ybot8+zioXFVscci8NU3YsXqaydjqlnbRsr62UBi/CExI6Bgrvl
         d0pA==
X-Gm-Message-State: AOJu0YxGItfyFK44N/pTQE3uIAHZToHCA2GgPbSz8ypSE5DG7XfsIPhr
	P7jbimdJnXyc2YXWTQCtXSc2Gx6ZL1yzTqCfjgCBA6qy8qAZe/vaIGRU
X-Gm-Gg: AeBDievlJ3C0YQX3LYTYYwaOIS5L6rkNY0QT90bd9O8Gtc8gVfOalF/pFZbfLcVnUSq
	hhoAJ9GfcNyN5RdCb9RlE6lrCw0AtcjSm98IZB5g2TLIGX7Sp2526EpAUylMwfEmAFpROUYrOFe
	uINLAH/hd+zVoK+VSGf2L8ybyXwqgAxmEJYq87MhwmR8poZ4g+KSJHfBGH9YEoLEnzUPWf8/IPC
	tQOzGH4yNOvC8FZ0M0ZKyOn6CyNa5hKMfejqREx4wz1uZUqKYfl6LaByy8WZvVagAN2VZe6hOyz
	umNCdNRm4lSblpKhEHpEkxi7kSH1RnY8afN40fGvy3Wl9oTrzzT6TwRwmA8C70Vv8VVvFrRp4Dt
	HsxaCyGJdYud2FXWh5XBLUzhoo2J05QNFTFlLS/m5DMwJg5iUCL0nFFjgn/rW3j+SuRfnnURTZv
	HR5+SohSBE6yqNFS5ZJZRTtY3QA9cEfzn8j9Z/blhocEphbEgo
X-Received: by 2002:a17:902:ef12:b0:2b2:4bf9:1766 with SMTP id d9443c01a7336-2b2817c061fmr220093605ad.33.1775632143494;
        Wed, 08 Apr 2026 00:09:03 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749b66aasm202917785ad.68.2026.04.08.00.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:09:02 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 08 Apr 2026 15:08:49 +0800
Subject: [PATCH net-next v2 1/5] tools: ynl: move ethtool.py to selftest
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-b4-ynl_ethtool-v2-1-7623a5e8f70b@gmail.com>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
In-Reply-To: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-276316-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31DD43B7E7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We have converted all the samples to selftests. This script is
the last piece of random "PoC" code we still have lying around.
Let's move it to tests.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/tests/Makefile              | 5 ++++-
 tools/net/ynl/{pyynl => tests}/ethtool.py | 2 +-
 tools/net/ynl/tests/test_ynl_ethtool.sh   | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/tests/Makefile b/tools/net/ynl/tests/Makefile
index 2a02958c7039..94bf0346b54d 100644
--- a/tools/net/ynl/tests/Makefile
+++ b/tools/net/ynl/tests/Makefile
@@ -36,7 +36,10 @@ TEST_GEN_FILES := \
 	rt-route \
 # end of TEST_GEN_FILES
 
-TEST_FILES := ynl_nsim_lib.sh
+TEST_FILES := \
+	ethtool.py \
+	ynl_nsim_lib.sh \
+# end of TEST_FILES
 
 CFLAGS_netdev:=$(CFLAGS_netdev) $(CFLAGS_rt-link)
 CFLAGS_ovs:=$(CFLAGS_ovs_datapath)
diff --git a/tools/net/ynl/pyynl/ethtool.py b/tools/net/ynl/tests/ethtool.py
similarity index 99%
rename from tools/net/ynl/pyynl/ethtool.py
rename to tools/net/ynl/tests/ethtool.py
index f1a2a2a89985..6eeeb867edcf 100755
--- a/tools/net/ynl/pyynl/ethtool.py
+++ b/tools/net/ynl/tests/ethtool.py
@@ -14,7 +14,7 @@ import re
 import os
 
 # pylint: disable=no-name-in-module,wrong-import-position
-sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
+sys.path.append(pathlib.Path(__file__).resolve().parent.parent.joinpath('pyynl').as_posix())
 # pylint: disable=import-error
 from cli import schema_dir, spec_dir
 from lib import YnlFamily
diff --git a/tools/net/ynl/tests/test_ynl_ethtool.sh b/tools/net/ynl/tests/test_ynl_ethtool.sh
index b826269017f4..b4480e9be7b7 100755
--- a/tools/net/ynl/tests/test_ynl_ethtool.sh
+++ b/tools/net/ynl/tests/test_ynl_ethtool.sh
@@ -8,7 +8,7 @@ KSELFTEST_KTAP_HELPERS="$(dirname "$(realpath "$0")")/../../../testing/selftests
 source "$KSELFTEST_KTAP_HELPERS"
 
 # Default ynl-ethtool path for direct execution, can be overridden by make install
-ynl_ethtool="../pyynl/ethtool.py"
+ynl_ethtool="./ethtool.py"
 
 readonly NSIM_ID="1337"
 readonly NSIM_DEV_NAME="nsim${NSIM_ID}"

-- 
Git-155)



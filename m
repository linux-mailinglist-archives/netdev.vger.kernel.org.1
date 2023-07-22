Return-Path: <netdev+bounces-20093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C875D92C
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 04:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908E62823C2
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660BC79DD;
	Sat, 22 Jul 2023 02:42:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FCD63C7
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 02:42:50 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9550F0
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:42:48 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1ba4460f0a4so2040124fac.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 19:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689993768; x=1690598568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3n3O3JK8EpoGMcQ/RFf0PRjwe4dMP1NMHm5O3sVAsVM=;
        b=5PiIhnV+G7aXwvKkg6DdEhu2tVS15zqxGzpL32TlXPl9/SBqSXayd1t4Jm3O0iy6X7
         RuSH25gEMaTP3tCtaSPIEGH70ZqLezCsTvLr5+z4ftUpeJxJBT2LQaGPMAto/pcCTwL1
         YRfGn97vm15VTSRdvNSlOSmpnz71CDtAX/lCOJGd2PuyA/0JPLEN6wcHzx5qVLUewWhP
         NlgubD0XDZ5EoEFsgqCaRaN4dAbXmobqPgquMPqUwfdNK4mLF81GddXs1my8uElQf2hc
         isHjczYHeqYvl9IFX3R9TdIEFyPx2kOZDy5a4eisKNcz/qM9jIqV3ixlS/Q9SV8HFuDn
         jn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689993768; x=1690598568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3n3O3JK8EpoGMcQ/RFf0PRjwe4dMP1NMHm5O3sVAsVM=;
        b=TkcgOt0cNUVkwkDRpHZ00oR32v9bGQ0BuFLqach4Ri9yrHZcIYBcnPFGDXsNJ6m9Aj
         p8UEfZ7kZfJNL+E+jrsPqXHkOSsItB7evSXiIgiJ08IK/rKgsbaJVNN3YFYjEaoR2qg8
         QyhNnRBGhDwcCxo9qSC4s4IWgvYuWJNOhO5tATcng3EZctmjie9I+c91BqOl0US8L/Vl
         dZgDHoLDpSaevfvyzuNRntcPeJ3c1eqQSfI5rrZFbkCkXlTtjyE33pofuTGBY6nwaSPw
         1Tv9zVpKCBUS/SADkIU94U7p9z7OCyF1kpckSNy+4s4+Ru7NXChXdXOitPCSxgO+kaqk
         ucJw==
X-Gm-Message-State: ABy/qLayfEUAPnR0m+6wF+ZdmXEgnpq00G1sl0Ot0ytEdOAZzZZxj1vW
	91kOv7Qnh1hg2WW7C2xcMxlvKKQnOQLnsZGnE/kU+g==
X-Google-Smtp-Source: APBJJlHg+wyHrgt4JN4TTMx4EygvGmVcKOJo85pg9fqnyRio9hvuNyKsFz8A+HHjFmgSqnkSVuNfcQ==
X-Received: by 2002:a05:6870:b622:b0:1b7:4523:2b0b with SMTP id cm34-20020a056870b62200b001b745232b0bmr3782865oab.4.1689993767901;
        Fri, 21 Jul 2023 19:42:47 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78748000000b00668738796b6sm3631154pfo.52.2023.07.21.19.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 19:42:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] Add missing SPDX headers
Date: Fri, 21 Jul 2023 19:42:36 -0700
Message-Id: <20230722024236.6081-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

All headers and source in iproute2 should be using SPDX license info.
Add a couple that were missed, and take off boilerplate.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/bpf_util.h   | 6 +-----
 include/cg_map.h     | 1 +
 include/json_print.h | 8 ++------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/bpf_util.h b/include/bpf_util.h
index 6a5f8ec6529c..1c924f501f5f 100644
--- a/include/bpf_util.h
+++ b/include/bpf_util.h
@@ -1,11 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * bpf_util.h	BPF common code
  *
- *		This program is free software; you can distribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		as published by the Free Software Foundation; either version
- *		2 of the License, or (at your option) any later version.
- *
  * Authors:	Daniel Borkmann <daniel@iogearbox.net>
  *		Jiri Pirko <jiri@resnulli.us>
  */
diff --git a/include/cg_map.h b/include/cg_map.h
index d30517fd3417..6293b50ed1c9 100644
--- a/include/cg_map.h
+++ b/include/cg_map.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __CG_MAP_H__
 #define __CG_MAP_H__
 
diff --git a/include/json_print.h b/include/json_print.h
index 49d3cc14789c..0b1d84f78749 100644
--- a/include/json_print.h
+++ b/include/json_print.h
@@ -1,10 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * json_print.h		"print regular or json output, based on json_writer".
- *
- *             This program is free software; you can redistribute it and/or
- *             modify it under the terms of the GNU General Public License
- *             as published by the Free Software Foundation; either version
- *             2 of the License, or (at your option) any later version.
+ * json_print.h		print regular or json output, based on json_writer.
  *
  * Authors:    Julien Fortin, <julien@cumulusnetworks.com>
  */
-- 
2.39.2



Return-Path: <netdev+bounces-29605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2871478400C
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 13:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A9E1C20ADB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34141BB55;
	Tue, 22 Aug 2023 11:50:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69968F78
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 11:50:41 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FA8E7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 04:50:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31c615eb6feso478072f8f.3
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 04:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692705003; x=1693309803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LdczRIWEjdjdpQ0WFFudZkvYLHAz3ldpMhlVEhe64Dc=;
        b=nxrGbgslA5a4V+TqmfyptDnrWhZW0OlLgc/qZ3co0IPfV3yGMImdT8IeQh+WFjNgTV
         xdnJJbe5cS2oCRUt3J5cluG0X/qysPblWCfyvhdzHBjFG4n29a6xJrTenBFwpITO8eFn
         3KsEWrXQAnuRXKyprXZ7M9LgMtpBiGIhkBTEtT+ch5rHzfOYGdh3ypwyIX8hJrHi+hyl
         Y4LIRAFN2b1Pn48FkL8ZhxmXcmy1fIrRwlAFYj/7dRWTS8w4XQXA9va1Zy1Vi1MIIkhs
         ImZhIKmg9dE0Pk9BOWq87Az2uYmfLEYJ6BisFPcIOJiE3sF0fctoDE0RBBeVHVBLU4Yy
         12vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692705003; x=1693309803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdczRIWEjdjdpQ0WFFudZkvYLHAz3ldpMhlVEhe64Dc=;
        b=E65XsB6Exbl6O9LQcj9dU9Gp9s75poe5MNrftxaV4CNhtTwvIXIU4fQy5pc17Pvy3+
         J1Y/lKnnmaXGIc5kuV3tYaUJhCcH+7xJ+7XvFguqPf2PnK3Ilo2CpLkIhPzzQiIT49hg
         R+qp/5+pAvx1JnqkkhvAPD7vRdNwihITDejIx/G8qsTGywVSb7UhRLLENWLkrfGnyLYq
         nkKT9RrN/hRTleH1poVgFcCZPydk/TF4SvN+sw+Qax6CJrqe/donejK6g7KRFAwbSepE
         EyKl7MofX82yeYKI6ejDeyFXs0kO0bSgwCyqAxuN2jgNq6QD9AKiijB+aPlEKxPyBMzk
         zsFg==
X-Gm-Message-State: AOJu0Yw9KPAY8iGNckKgggQDK1UayDWRm3ZaYrCnNJNWmAEsZ9k+NsBL
	bC32fIP9mu3kin6FxhjPTq58tkZWZvEXGBGB8d3PqEvC
X-Google-Smtp-Source: AGHT+IFIMoE/AuIBqNaDP0EiE5hZ7pQytizTGWCuyr3AnhUM9sXUR4sSncFmXrhC+YVjdo5GkmNqQQ==
X-Received: by 2002:a5d:410b:0:b0:314:2b0a:dabe with SMTP id l11-20020a5d410b000000b003142b0adabemr6964379wrp.30.1692705002803;
        Tue, 22 Aug 2023 04:50:02 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d4ec8000000b00317f3fd21b7sm15793254wrv.80.2023.08.22.04.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 04:50:01 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next] tools: ynl-gen: add "spec" arg to regen allowing to use only selected spec
Date: Tue, 22 Aug 2023 13:50:00 +0200
Message-ID: <20230822115000.2471206-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

ynl-regen git greps and re-generates all generated files. Introduce a
command line argument "spec" allowing the user to specify only one yaml
spec file to use as a source of re-generation.

Example:
$ tools/net/ynl/ynl-regen.sh -s Documentation/netlink/specs/devlink.yaml -f
	GEN kernel	net/devlink/netlink_gen.c
	GEN kernel	net/devlink/netlink_gen.h
	GEN user	tools/net/ynl/generated/devlink-user.c
	GEN user	tools/net/ynl/generated/devlink-user.h

This is handy while working on a specific spec.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/ynl-regen.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
index bdba24066cf1..ee77f6fcad60 100755
--- a/tools/net/ynl/ynl-regen.sh
+++ b/tools/net/ynl/ynl-regen.sh
@@ -5,11 +5,13 @@ TOOL=$(dirname $(realpath $0))/ynl-gen-c.py
 
 force=
 search=
+spec=
 
 while [ ! -z "$1" ]; do
   case "$1" in
     -f ) force=yes; shift ;;
     -p ) search=$2; shift 2 ;;
+    -s ) spec=$2; shift 2 ;;
     * )  echo "Unrecognized option '$1'"; exit 1 ;;
   esac
 done
@@ -24,6 +26,10 @@ for f in $files; do
     params=( $(git grep -B1 -h '/\* YNL-GEN' $f | sed 's@/\*\(.*\)\*/@\1@') )
     args=$(sed -n 's@/\* YNL-ARG \(.*\) \*/@\1@p' $f)
 
+    if [ ! -z "$spec" -a "$spec" != "${params[0]}" ]; then
+	continue
+    fi
+
     if [ $f -nt ${params[0]} -a -z "$force" ]; then
 	echo -e "\tSKIP $f"
 	continue
-- 
2.41.0



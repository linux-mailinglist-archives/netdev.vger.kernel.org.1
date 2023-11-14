Return-Path: <netdev+bounces-47760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6777EB468
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FC5281278
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 16:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C5C41779;
	Tue, 14 Nov 2023 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Bbpe7Klt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4341A96
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 16:05:44 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD6112C
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:05:42 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc3bb32b5dso51595375ad.3
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699977942; x=1700582742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwMnw/NInSlyVCXH0aLYAutfComTPi7viklnzsawBKE=;
        b=Bbpe7KltVz/VDwKB0jlbhOrkq/ZXhhFE6g96fH1f0U4c5X5PVkomy8tAZxYO7CHFwZ
         ZhwR/flly/KjbuheWnL3eiLcMRcg5ho38Cf5y7wuHIjf3uGnlYq6iXVMMEuYuLueBszk
         69FAUyQn6kdajQ2C7jYsvKsLgOlFZZagbfxiy393ATWpXspd26YPJ6KLdW7BoSkhvZ38
         Imri4PiVx5pHZIfHbKSbFeu3xep3LNQDS3YhNZSzjjnTz/1sS9uFUCU7MNbi7jPgVxwL
         g5iK609b3l1auSxPyCi96plW1maz6MjK6QcWeLr5nNLg6X0Bs1IQD0G4Krl2fG6g3DbM
         fYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977942; x=1700582742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwMnw/NInSlyVCXH0aLYAutfComTPi7viklnzsawBKE=;
        b=tMT8B2BEikCHWiGi2x32QpY1vFmdio+tBu3mV+iLpJRdlA8OFbApPr7Th0GxeCWmEh
         iuZYmsnqgdZlhhqod48DzY5DkP4jpqobFKKoslrGvnEgywsnN52KpbehR6oe3AnOgfba
         OPnriiFzNeA2NcCHJ+yuhHK41hwKaui4keP3OtMKL+LoW91NqcvAB8QrrcmujQwvsm3u
         Sd/Ej+uTrVPrxyqyKPxn+N4tkGQp6ToAlcSkR2JDjtoCz4FipArI7GT3lXm++qJJZMqL
         /XqGWu2C6d+LgOxvtoNrrurQxraJLTFN2vayHfWvMUQEGZQscMyHy1qEV3eQRZcqsnDW
         7utA==
X-Gm-Message-State: AOJu0YyAdhJZmOjhMC5pA3neVSLVSqHw/vkBbTKRTwtUn5ssAcRHg5Q9
	Rgo/iNH+vtVe8JfpDx5U/K0ISdNg5B0tT9YNfwY=
X-Google-Smtp-Source: AGHT+IHmA4VURn9OSeOirFAqOJABH+8KZmMenEN0bY/EuuEAzNRkJUWY/ilfdaOLl155MzbEKGxz+A==
X-Received: by 2002:a17:902:ce90:b0:1cc:787f:fb7 with SMTP id f16-20020a170902ce9000b001cc787f0fb7mr3569642plg.19.1699977941956;
        Tue, 14 Nov 2023 08:05:41 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:fa3f:3165:385:80b3])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001c46d04d001sm5833048plg.87.2023.11.14.08.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:05:41 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next 3/4] selftests: tc-testing: preload all modules in kselftests
Date: Tue, 14 Nov 2023 13:04:41 -0300
Message-Id: <20231114160442.1023815-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231114160442.1023815-1-pctammela@mojatatu.com>
References: <20231114160442.1023815-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While running tdc tests in parallel it can race over the module loading
done by tc and fail the run with random errors.
So avoid this by preloading all modules before running tdc in kselftests.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tdc.sh | 65 ++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index eb357bd7923c..ae08b7a47c42 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -1,7 +1,68 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-modprobe netdevsim
-modprobe sch_teql
+# If a module is required and was not compiled
+# the test that requires it will fail anyways
+try_modprobe() {
+   modprobe -q -R "$1"
+   if [ $? -ne 0 ]; then
+      echo "Module $1 not found... skipping."
+   else
+      modprobe "$1"
+   fi
+}
+
+try_modprobe netdevsim
+try_modprobe act_bpf
+try_modprobe act_connmark
+try_modprobe act_csum
+try_modprobe act_ct
+try_modprobe act_ctinfo
+try_modprobe act_gact
+try_modprobe act_gate
+try_modprobe act_ipt
+try_modprobe act_mirred
+try_modprobe act_mpls
+try_modprobe act_nat
+try_modprobe act_pedit
+try_modprobe act_police
+try_modprobe act_sample
+try_modprobe act_simple
+try_modprobe act_skbedit
+try_modprobe act_skbmod
+try_modprobe act_tunnel_key
+try_modprobe act_vlan
+try_modprobe cls_basic
+try_modprobe cls_bpf
+try_modprobe cls_cgroup
+try_modprobe cls_flow
+try_modprobe cls_flower
+try_modprobe cls_fw
+try_modprobe cls_matchall
+try_modprobe cls_route
+try_modprobe cls_u32
+try_modprobe em_canid
+try_modprobe em_cmp
+try_modprobe em_ipset
+try_modprobe em_ipt
+try_modprobe em_meta
+try_modprobe em_nbyte
+try_modprobe em_text
+try_modprobe em_u32
+try_modprobe sch_cake
+try_modprobe sch_cbs
+try_modprobe sch_choke
+try_modprobe sch_codel
+try_modprobe sch_drr
+try_modprobe sch_etf
+try_modprobe sch_ets
+try_modprobe sch_fq
+try_modprobe sch_fq_codel
+try_modprobe sch_fq_pie
+try_modprobe sch_gred
+try_modprobe sch_hfsc
+try_modprobe sch_hhf
+try_modprobe sch_htb
+try_modprobe sch_teql
 ./tdc.py -c actions --nobuildebpf
 ./tdc.py -c qdisc
-- 
2.40.1



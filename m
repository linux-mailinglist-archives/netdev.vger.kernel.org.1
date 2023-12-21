Return-Path: <netdev+bounces-59759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D90081C02B
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727201C248F6
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6714E7764A;
	Thu, 21 Dec 2023 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="tiQ7DHBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B576DDF
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3ba0dfc9001so515781b6e.2
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703194277; x=1703799077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OweWHV/5CZS5evwNoY0mtoHfID6J4Dc707NrSFW6I0=;
        b=tiQ7DHBx1Z8aZ0MrWFyqSjN2q74H4f1/a9XMI+YwiExI9gTW0s7oJI1GEibTp3KkK7
         slsN64+K+l2/sZMSlCPP79ANHD2XVdI+1cWT7qXDzr9VIJ+3iMpI2l5I/TANdsC1gSms
         jgWwyx0Y3W1DOsSUCpnMiMhNefRZ/WoQMP/lAqZPb5eX5BvzUo9Rwy9S2VbFeixgavnM
         0BLnACjWiGEXzgZ9tD1rnFI1oJU7e939YJJZnxHRm5OvAMfSnbavJYS7jw4tVPalpEnx
         byr4st1lshjgtAbI2P6+Vi6IE9laiGJ+hHQbi7hTmgRSL7A+STDALc30fp08KtN1Bpu2
         YHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194277; x=1703799077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OweWHV/5CZS5evwNoY0mtoHfID6J4Dc707NrSFW6I0=;
        b=tlyFQbNaGuvoDon/pLDd07CHCta5g4PSvTClaFUB9U/kKxc54ALrT0khfnfjaNDiXa
         35wmDxLuVpT0VaqjxOH+PLFiswYj7pnBhffGDI66J1gNuBNNtTnisdPpYEKoXSPkuRmo
         FKyN33ufheaif2GhYQPa7KB8DSvN6FJAH13vr+KCjjNo+T2fUXGcWNJuQz9rRvgElimc
         9e2zcNUM5QsJnwI+AcGtMYCpAcK6I2A+pU5RMtbSU3kmQce0Am2IuoSRrNpK6BuLALl+
         cNe8ZzqI+luvzb6PmFVmYU9VfYSqLj0KtEEoWoMpvgMpp3haqCN2OJ0pzSVgjQ4H2xk0
         7MfA==
X-Gm-Message-State: AOJu0YxhrnRbwv+/5o5Mt43DLcNwqehcuRfXh9vNaggOZPycO+EUk4yh
	MBeQoMxJ6B4XZNxWEbX8qPipxTBkjvYB
X-Google-Smtp-Source: AGHT+IFRDY5clwaEvC/u0LSvY/Dme7OXNVHoafgSdbLQbdUOldy1eowLXkdexMJrFHgyGEy7UNOdmA==
X-Received: by 2002:aca:2807:0:b0:3b9:e635:d638 with SMTP id 7-20020aca2807000000b003b9e635d638mr395785oix.10.1703194277021;
        Thu, 21 Dec 2023 13:31:17 -0800 (PST)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id k17-20020ad44511000000b0067f79b4c47bsm891617qvu.5.2023.12.21.13.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 13:31:16 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	stephen@networkplumber.org,
	dsahern@gmail.com,
	fw@strlen.de,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next 2/2] net/sched: Remove CONFIG_NET_ACT_IPT from default configs
Date: Thu, 21 Dec 2023 16:31:04 -0500
Message-Id: <20231221213105.476630-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213105.476630-1-jhs@mojatatu.com>
References: <20231221213105.476630-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we are retiring the IPT action.

Reviewed-by: Victor Noguiera <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 arch/loongarch/configs/loongson3_defconfig | 1 -
 arch/mips/configs/ip22_defconfig           | 1 -
 arch/mips/configs/malta_defconfig          | 1 -
 arch/mips/configs/malta_kvm_defconfig      | 1 -
 arch/mips/configs/maltaup_xpa_defconfig    | 1 -
 arch/mips/configs/rb532_defconfig          | 1 -
 arch/powerpc/configs/ppc6xx_defconfig      | 1 -
 arch/s390/configs/debug_defconfig          | 1 -
 arch/s390/configs/defconfig                | 1 -
 arch/sh/configs/titan_defconfig            | 1 -
 10 files changed, 10 deletions(-)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 33795e4a5bd6..9c333d133c30 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -304,7 +304,6 @@ CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_POLICE=m
 CONFIG_NET_ACT_GACT=m
 CONFIG_NET_ACT_MIRRED=m
-CONFIG_NET_ACT_IPT=m
 CONFIG_NET_ACT_NAT=m
 CONFIG_NET_ACT_BPF=m
 CONFIG_OPENVSWITCH=m
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index dc49b09d492b..e22e8b825903 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -173,7 +173,6 @@ CONFIG_NET_ACT_POLICE=y
 CONFIG_NET_ACT_GACT=m
 CONFIG_GACT_PROB=y
 CONFIG_NET_ACT_MIRRED=m
-CONFIG_NET_ACT_IPT=m
 CONFIG_NET_ACT_NAT=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SIMP=m
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 6f8046024557..4390d30206d9 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -202,7 +202,6 @@ CONFIG_NET_ACT_POLICE=y
 CONFIG_NET_ACT_GACT=m
 CONFIG_GACT_PROB=y
 CONFIG_NET_ACT_MIRRED=m
-CONFIG_NET_ACT_IPT=m
 CONFIG_NET_ACT_NAT=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SIMP=m
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 16a91eeff67f..d63d8be8cb50 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -206,7 +206,6 @@ CONFIG_NET_ACT_POLICE=y
 CONFIG_NET_ACT_GACT=m
 CONFIG_GACT_PROB=y
 CONFIG_NET_ACT_MIRRED=m
-CONFIG_NET_ACT_IPT=m
 CONFIG_NET_ACT_NAT=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SIMP=m
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 264aba29ea4f..338bb6544a93 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -203,7 +203,6 @@ CONFIG_NET_ACT_POLICE=y
 CONFIG_NET_ACT_GACT=m
 CONFIG_GACT_PROB=y
 CONFIG_NET_ACT_MIRRED=m
-CONFIG_NET_ACT_IPT=m
 CONFIG_NET_ACT_NAT=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SIMP=m
diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
index 02ec6c1a5116..517f1b060bf4 100644
--- a/arch/mips/configs/rb532_defconfig
+++ b/arch/mips/configs/rb532_defconfig
@@ -96,7 +96,6 @@ CONFIG_NET_ACT_POLICE=y
 CONFIG_NET_ACT_GACT=m
 CONFIG_GACT_PROB=y
 CONFIG_NET_ACT_MIRRED=m
-CONFIG_NET_ACT_IPT=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_HAMRADIO=y
 CONFIG_MTD=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index f279703425d4..66c7b28d7450 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -274,7 +274,6 @@ CONFIG_NET_ACT_POLICE=m
 CONFIG_NET_ACT_GACT=m
 CONFIG_GACT_PROB=y
 CONFIG_NET_ACT_MIRRED=m
-CONFIG_NET_ACT_IPT=m
 CONFIG_NET_ACT_NAT=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SIMP=m
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 438cd92e6080..d1c895785b6f 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -374,7 +374,6 @@ CONFIG_NET_ACT_POLICE=m
 CONFIG_NET_ACT_GACT=m
 CONFIG_GACT_PROB=y
 CONFIG_NET_ACT_MIRRED=m
-CONFIG_NET_ACT_IPT=m
 CONFIG_NET_ACT_NAT=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SIMP=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 1b8150e50f6a..8bc34d4474cb 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -364,7 +364,6 @@ CONFIG_NET_ACT_POLICE=m
 CONFIG_NET_ACT_GACT=m
 CONFIG_GACT_PROB=y
 CONFIG_NET_ACT_MIRRED=m
-CONFIG_NET_ACT_IPT=m
 CONFIG_NET_ACT_NAT=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_ACT_SIMP=m
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index 871092753591..c1032559ecd4 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -138,7 +138,6 @@ CONFIG_NET_ACT_POLICE=m
 CONFIG_NET_ACT_GACT=m
 CONFIG_GACT_PROB=y
 CONFIG_NET_ACT_MIRRED=m
-CONFIG_NET_ACT_IPT=m
 CONFIG_NET_ACT_PEDIT=m
 CONFIG_FW_LOADER=m
 CONFIG_CONNECTOR=m
-- 
2.34.1



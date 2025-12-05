Return-Path: <netdev+bounces-243689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB8ACA5EAA
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 03:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67AC530BA51E
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 02:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB412E36F1;
	Fri,  5 Dec 2025 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="MH2P33Un"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB62DEA73
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 02:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764902307; cv=none; b=Xf/YYidjjYaq10vunnpChBaCec288A7l8KTgKlHNZmUvvfG5QKud7O4bnlyNWWmJLAiUsyKp+j7LlVgxRn5biC/mdBUzl17gfv7UurgfBdyoBKwh5GgpF7Lv4UY5/oHEe4jZBlOi9oBi611GrjoosHTUEOC1L1uHsX5O2Cc+Cn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764902307; c=relaxed/simple;
	bh=xA21uJ8hK579237VIBgWeX8B5LdmVMMkhRxa8EN/R4Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjh8AIQ5lPN5rLJSgQniTk6EZ5gHW4DiO5ukHnJe8sU6Y757a4007Adq+s9wa1dmLKj9ZGAHhYPzzRhfsU3PcgQwJrkKgEoyutrpuNaZq6t+hy1o8DspNBzZwGpCCOJEFfMg/71z4GUsjlapphhWxJpbG9vrfcGWIb1mbXMbo6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=MH2P33Un; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6F3C7403F5
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 02:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764902303;
	bh=07f0xkCNmwNJrz/eEX3cuUQnuuKh8RK1i6IvKN6Ecls=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=MH2P33UneU/sR5VOK8ZKMwf9cgVMzoMDKCz3Tm5rP7WWsMXpMI7NyqTFQ+yEbnd3A
	 XgR2vOM+DRnzS/zI5Rg65oPldDHs0pQAEGypsTAjbsP7fFR4P2wtRXLOd5mmlyGvDA
	 PYCXhfWuqrQBA3zLEbF/SXFZUSmLG2vkENb5QgxT3gnMi+C1/UN9hM5nB62yyNHgVi
	 Ak0y5LmIKdphltZ+WvIdbXWF0btIsmoMhM6LibJ3NuepHVf41nQ3DLDa5pfHoF/K1s
	 Tr2AV1LHzyRYhyaByKgAdfweCx3y/HnTSCQw12tTvXiyCYvpyLTbMuBb5cgLAj0xod
	 Ac/MTd6uqdxS+z1SkNAdKpy3SJ0kWpYpjpGHDxjWOdFwSRIFaUDYdebgra2GXhFbU/
	 lNegiYanSVgsdgVIRg6tekRyU+gjYnxOxCzH3pbXXyQ1pe40vdL7i8GtUGeE+D/bB4
	 +MDX+OaF5MqhymOkeNISJTA1OJcVwDXD3LAcZefTJw454LfbZ0EDguuvm3xGZtYbWM
	 gSLKMsnlC8uCoOCGSwCp716hXaFrwMkx/emZ5/f8LwA7JNKALDLjhjRJKxVW68GlLT
	 EWKCGK9gHZAJHt4e5HeqlpxBPbisWot2T35FSNTjarrJQ2nfcUP2MT1BzUNigQcr85
	 ZeDrb+pbkBxxJbRTL3zR00tg=
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29846a9efa5so31600575ad.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 18:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764902301; x=1765507101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=07f0xkCNmwNJrz/eEX3cuUQnuuKh8RK1i6IvKN6Ecls=;
        b=f0ah0n2TOcwfm44gJmNEbqkJjC43HGwUGsm9ztE/UFjO50MjDDxxss2p9kHoMXAf9X
         wGniWiRGjqMLpq8U5aHCaIruMbKvz6GZCQKnG/ffNKQUzMNcHl0ijwX6Rl5wcMvJHymG
         dTEKZNuHZD0nfS0eo/PVfGUqHjpRCxDltnQmcn8rdCDVwMfyfVLyO/ChlKbDaij4A/kq
         XrCLSdDnHMUK62L7VJHfsCz8VcbukHzeUptUyv5A2oYFPAK9nYe2I83Nn2XU+b54YL98
         SQv32fBtPsiyliI/iJvT1Y2dYMDuxmhEjJMskKsJGcAen9e9w1vKYWXI1r7djJHBNGOI
         kF8g==
X-Forwarded-Encrypted: i=1; AJvYcCUlQ8CkwS+YAWjtYSH9giZgnt79HstzugN7E71sLuYAQTdhwhEWjxCilX4tVMX5/DdIFdcQmWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOtSaId2zz0liJC0G2eG2QlwP3zc57Sml21cj8lnS7z7dNX5i8
	s3MndnQ5WVSA9UV+Xv40Jl3EqY2O71IoGBiAIvl7hK1dzB9fr30EdFt8CS6ORJRW5iVTTdViM4K
	NqLqWSa3XTELlO8x0JFjDyTK9cs7ROdVWsHqv13DgyC0DSV82WoVphMCjlync8hItgNkrv1Jrsg
	==
X-Gm-Gg: ASbGncuXBxtJ/eXxwglpQ2vcEvOxBfrWNsTqo9tIKKtTIPtNuEoMZuZ996dVWo0Z8VO
	R0FrukvlwMx01uCf+p/5GIrSwFgvme1EOYj7rUhPWpRinwI/OSZNK2zEylDAozW/UXFiMNDE04w
	15U3ihqtQD08V4tIGu3ZoeyY/mg8bjsSnJEbJlfjio5QDqBXBSbnOBQ7A0p97W59YiCUG3Ka3G1
	dXTlTzcH0rvsPo/6ZJeiIpMR6trp6vlKAwoGeMxYlczm9Bbryuzm1IVvvuNm6FfVEUtS7jjSrbk
	NnYgTGRU8HYCnCaS2Sg6JBnkXhz7Ia2EmhXVubdZukFHIBw/6k1ABtjxdS7UcdoKLDDFL3wilVe
	21Mh/2NX7TKMG+2w9sj6lsjLQ
X-Received: by 2002:a17:903:3d05:b0:271:479d:3dcb with SMTP id d9443c01a7336-29d683398a5mr108135505ad.6.1764902301016;
        Thu, 04 Dec 2025 18:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3XlHEntu9FhXy6pJxOt+Oz3bkQTswSkU4qcAn23qCMgJeV9eurPihOGYATkBPAfwrBFvR4g==
X-Received: by 2002:a17:903:3d05:b0:271:479d:3dcb with SMTP id d9443c01a7336-29d683398a5mr108135205ad.6.1764902300638;
        Thu, 04 Dec 2025 18:38:20 -0800 (PST)
Received: from localhost.localdomain ([103.155.100.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f1cfsm32282785ad.55.2025.12.04.18.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 18:38:20 -0800 (PST)
From: Aaron Ma <aaron.ma@canonical.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ice: Initialize RDMA after rebuild
Date: Fri,  5 Dec 2025 10:37:57 +0800
Message-ID: <20251205023757.1541228-2-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205023757.1541228-1-aaron.ma@canonical.com>
References: <20251205023757.1541228-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After wakeup from suspend, IRDMA is initialized with error:

kernel: ice 0000:60:00.0: IRDMA hardware initialization FAILED init_state=4 status=-110
kernel: ice 0000:60:00.1: IRDMA hardware initialization FAILED init_state=4 status=-110
kernel: irdma.gen_2 ice.roce.1: probe with driver irdma.gen_2 failed with error -110
kernel: irdma.gen_2 ice.roce.2: probe with driver irdma.gen_2 failed with error -110

IRDMA times out because the initialization before the schedule reset.
The ice_init_rdma() function already calls ice_plug_aux_dev() internally,
ensuring proper initialization order.

Fixes: bc69ad74867db ("ice: avoid IRQ collision to fix init failure on ACPI S3 resume")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2533876f1a2fd..c6dd04d24ac09 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5677,11 +5677,6 @@ static int ice_resume(struct device *dev)
 	if (ret)
 		dev_err(dev, "Cannot restore interrupt scheme: %d\n", ret);
 
-	ret = ice_init_rdma(pf);
-	if (ret)
-		dev_err(dev, "Reinitialize RDMA during resume failed: %d\n",
-			ret);
-
 	clear_bit(ICE_DOWN, pf->state);
 	/* Now perform PF reset and rebuild */
 	reset_type = ICE_RESET_PFR;
@@ -7805,7 +7800,12 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ice_health_clear(pf);
 
-	ice_plug_aux_dev(pf);
+	/* Initialize RDMA after control queues are ready */
+	err = ice_init_rdma(pf);
+	if (err)
+		dev_err(dev, "Reinitialize RDMA after rebuild failed: %d\n",
+			err);
+
 	if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
 		ice_lag_rebuild(pf);
 
-- 
2.43.0



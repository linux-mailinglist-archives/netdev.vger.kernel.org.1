Return-Path: <netdev+bounces-31673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A7178F7AE
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 06:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C7528174E
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 04:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E011386;
	Fri,  1 Sep 2023 04:43:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BACEBE
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 04:43:10 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E960C0
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 21:43:10 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-573429f5874so902931eaf.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 21:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693543389; x=1694148189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv/gxxP2+2/w8vU76x/JHsorlvPMabnvvx4LWlXWG9U=;
        b=KPz5feLx4F6Lus9WopAuxp99Z3X3ZqyX5BZvqxzj7fHeuCImrXoZrTUmzErdNfvywy
         +M5ciFiyxlDag0skwOvOXb/rye/qtmNTDt0XW4W/eLVEL9Q69TKAu7A9w8UbRN6vPzat
         wWL4iZ6UV00yLfskidRlVcdOeUBb7m7jUR2YO0S5gklrQJO17i6u14OC+dSUqzJNViPc
         vNHDYrkRMv7hn9s33rZO1aii5MYtfobCOy+fr/1Nrr9e0Wueprz2J1HfJwrkgjW6bZ6X
         gaidVRPs9A15LpS2G5/Bas8z8iqYayrI/8tGWSmTzsZaifMqtbeM9U4MJ7IDZd3f1ZCd
         upJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693543389; x=1694148189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bv/gxxP2+2/w8vU76x/JHsorlvPMabnvvx4LWlXWG9U=;
        b=RXtVLQDRLPIwZjAUk2M2uhy4FxioM5V/25QwM7vhHpfxE2A1gaLI0DxXwN/uKzpFnv
         TCVa0qrn/StVm9QXoT7MEMkghqu0UZC3wXXuSwvN6eY2RkwhUIDaxIkW//l6/67ALPek
         5Mi2wJbm2QwmN7wfWTuBSk0e0eOS5mtWcnNNtehEiUBgJ1v30TJIYn4+T0vfkChCbkFP
         7SKQHRkYSzEjRpXjz1ubXA4w3hzqrsZrCvdrigiUSOkcmvVltbsrD69tmvPGgd11/eyF
         qartHftB2Uc2vjsePyR6pRhVhYh2iYD3iVf7ORRkaT7NHTBdZW5UwZcYee6uV0AKG2dI
         3o3g==
X-Gm-Message-State: AOJu0YyyeFSGv8xzOSW5/5YDNyewk8aKdrI0DbdJtk1NnEpAC7DhgBrP
	y3b7/AnKt8mQmepzqobNTZDyi8Ruchg5HA==
X-Google-Smtp-Source: AGHT+IGWpmsdhcovMvfcOTajo1f0ui2ObUA/bHF9/EgP+GcVAzYiindwrX2qOMGDV2o4nTK9cTho5g==
X-Received: by 2002:a05:6808:8c9:b0:3a7:26fd:b229 with SMTP id k9-20020a05680808c900b003a726fdb229mr1356835oij.48.1693543388777;
        Thu, 31 Aug 2023 21:43:08 -0700 (PDT)
Received: from xavier.lan ([166.70.251.153])
        by smtp.gmail.com with ESMTPSA id s16-20020a639250000000b0055fd10306a2sm2034463pgn.75.2023.08.31.21.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 21:43:08 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	jbohac@suse.cz,
	benoit.boissinot@ens-lyon.org,
	davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3] net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr
Date: Thu, 31 Aug 2023 22:41:27 -0600
Message-ID: <20230901044219.10062-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829054623.104293-2-alexhenrie24@gmail.com>
References: <20230829054623.104293-2-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The existing code incorrectly casted a negative value (the result of a
subtraction) to an unsigned value without checking. For example, if
/proc/sys/net/ipv6/conf/*/temp_prefered_lft was set to 1, the preferred
lifetime would jump to 4 billion seconds. On my machine and network the
shortest lifetime that avoided underflow was 3 seconds.

Fixes: 76506a986dc3 ("IPv6: fix DESYNC_FACTOR")
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
Changes from v2:
- Use conventional format for "Fixes" line
- Send separately and leave the other four patches for later
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 967913ad65e5..0b6ee962c84e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1378,7 +1378,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	 * idev->desync_factor if it's larger
 	 */
 	cnf_temp_preferred_lft = READ_ONCE(idev->cnf.temp_prefered_lft);
-	max_desync_factor = min_t(__u32,
+	max_desync_factor = min_t(long,
 				  idev->cnf.max_desync_factor,
 				  cnf_temp_preferred_lft - regen_advance);
 
-- 
2.42.0



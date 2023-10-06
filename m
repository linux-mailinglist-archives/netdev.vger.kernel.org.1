Return-Path: <netdev+bounces-38563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8566D7BB6DF
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F58728250B
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F43E1CA8C;
	Fri,  6 Oct 2023 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aipao1bB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942511CAA8
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 11:44:45 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78087FC
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 04:44:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ad8a822508so389340066b.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696592682; x=1697197482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9PEosJMsHWRSr2pDOgl6oCzuBJxkPTSWpQFLLDnNm4=;
        b=aipao1bBCFTrKzzD8b2ZqxiOpdWwns+ynXU0BXg24vIAIrv4VgFNs/DFeYQGxkzdNB
         QXyq0PUtEdQdG3SXBj6H4F34gn1pOgfJuapBKkkqIUfPHrkY0ksayGMUInGH715Vht56
         fffaLNa1MRMuInRbr7OnQiFK5sP2N4nrIBKTivh9YENeTSvXsRp1lwZe+4/yTtp/3hz5
         vR7GCERDOogWXLe65FlY7vuCRGHRJHzzVmgnK8DMJ5QCUm9+kPa9V3Eyv/wFYWAMjTtE
         RWC0f86xmf0kezU8t/IAlG5LgBg8sgVcu8wJSQQgjIK9Ta23dtiwgFsX4+pKAxSWtE+p
         e6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696592682; x=1697197482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9PEosJMsHWRSr2pDOgl6oCzuBJxkPTSWpQFLLDnNm4=;
        b=Bk5ycPlq67VOemIvXxhVe6lpuvT8PMyER43Sk0rB3Esp3hB3gQjgOuuE5gDKVees1K
         HoqOvrMhWdBK2cSYEG2eLApsuMhAjGME1FPBX1ZzT9zlKS8FiJUmTe6WLXPVFNpUvH0j
         0SJH8rZiT02KaXYEetKSzsm8Mt0AIkrEimro2mIoS6ayT1Akd/HdmfcHFIn8yy/gbTmS
         NySjyM9lEAdn21iNVybp0Ncm0mk/yyEXIn9ELjT2vmyudcpiPs+4YE79u2jMcN+4fl0A
         At13m6Kwye6SZGlqeEqvpVlVqiKN7BB88KlipRw1yPZ+rBbOL1uixIhTuBRV0swtEYxF
         r7TQ==
X-Gm-Message-State: AOJu0Yx7nxXeXiP0AzBKiJsXwHAAEy+O98BMfm+H+S6O6S96usYTx7uv
	S7UWXjiyka2dGAh63wHobbcQsiPtEQdLbHEpQbWN+Q==
X-Google-Smtp-Source: AGHT+IFkZo6dgEuWQvKKFQx8oe+sCHMcjSWpa3sttEw5VxQxEY3sxGbvXkpAlRQlCzZoHSmAyQ14iA==
X-Received: by 2002:a17:906:7484:b0:9b9:f980:8810 with SMTP id e4-20020a170906748400b009b9f9808810mr1696588ejl.34.1696592681992;
        Fri, 06 Oct 2023 04:44:41 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090616c800b009a1be9c29d7sm2771288ejd.179.2023.10.06.04.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:44:41 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	donald.hunter@gmail.com
Subject: [patch net-next v3 2/2] netlink: specs: remove redundant type keys from attributes in subsets
Date: Fri,  6 Oct 2023 13:44:36 +0200
Message-ID: <20231006114436.1725425-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006114436.1725425-1-jiri@resnulli.us>
References: <20231006114436.1725425-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

No longer needed to define type for subset attributes. Remove those.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
v1->v2:
- new patch
---
 Documentation/netlink/specs/devlink.yaml | 10 ----------
 Documentation/netlink/specs/dpll.yaml    |  8 --------
 Documentation/netlink/specs/ethtool.yaml |  3 ---
 3 files changed, 21 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index d1ebcd927149..86a12c5bcff1 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -199,54 +199,44 @@ attribute-sets:
     attributes:
       -
         name: reload-stats
-        type: nest
       -
         name: remote-reload-stats
-        type: nest
   -
     name: dl-reload-stats
     subset-of: devlink
     attributes:
       -
         name: reload-action-info
-        type: nest
   -
     name: dl-reload-act-info
     subset-of: devlink
     attributes:
       -
         name: reload-action
-        type: u8
       -
         name: reload-action-stats
-        type: nest
   -
     name: dl-reload-act-stats
     subset-of: devlink
     attributes:
       -
         name: reload-stats-entry
-        type: nest
   -
     name: dl-reload-stats-entry
     subset-of: devlink
     attributes:
       -
         name: reload-stats-limit
-        type: u8
       -
         name: reload-stats-value
-        type: u32
   -
     name: dl-info-version
     subset-of: devlink
     attributes:
       -
         name: info-version-name
-        type: string
       -
         name: info-version-value
-        type: string
 
 operations:
   enum-model: directional
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 8b86b28b47a6..1c1b53136c7b 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -278,36 +278,28 @@ attribute-sets:
     attributes:
       -
         name: parent-id
-        type: u32
       -
         name: direction
-        type: u32
       -
         name: prio
-        type: u32
       -
         name: state
-        type: u32
   -
     name: pin-parent-pin
     subset-of: pin
     attributes:
       -
         name: parent-id
-        type: u32
       -
         name: state
-        type: u32
   -
     name: frequency-range
     subset-of: pin
     attributes:
       -
         name: frequency-min
-        type: u64
       -
         name: frequency-max
-        type: u64
 
 operations:
   enum-name: dpll_cmd
diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 837b565577ca..5c7a65b009b4 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -818,13 +818,10 @@ attribute-sets:
     attributes:
       -
         name: hist-bkt-low
-        type: u32
       -
         name: hist-bkt-hi
-        type: u32
       -
         name: hist-val
-        type: u64
   -
     name: stats
     attributes:
-- 
2.41.0



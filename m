Return-Path: <netdev+bounces-30652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0600C78874A
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 14:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B945728182E
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52554D523;
	Fri, 25 Aug 2023 12:28:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A5D50B
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 12:28:56 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB7D2689;
	Fri, 25 Aug 2023 05:28:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fee87dd251so7848205e9.2;
        Fri, 25 Aug 2023 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692966488; x=1693571288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MK1Byut3C1YEHdomj44YxMiXWC4+UDN7N18c5nOb5bg=;
        b=UOe4iEOy29Ag+sQF+GSq/aoDM4Leo3JaebDuNkSYATFCFDoW3RcCEQfSBUuVxLrI0R
         eIOY7UcO2Uk55CFJ9HINNT6CeV9Mw9hVqNTNtnSAS6y61s+62ddW80MongQC3GfLHjvx
         jw8Xgc76YUvCTkfIBXCA4T3RzcwB35pkqdzh4Uetht2NSViRX/FoG786aTQmDKFj98d4
         e4z7bm7udA30j8ejNVozhoi8q/K63ct7aHhmv1ojIQTYT0ZSS6m0kQmmOsTJzESatKA6
         8EAkyD8bHsky0p2Dd87FaeYmDxF7pVUMz0WaM3RIeinmS0620xhq0eJHIQn0fwsHvjDs
         8uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966488; x=1693571288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MK1Byut3C1YEHdomj44YxMiXWC4+UDN7N18c5nOb5bg=;
        b=YceBu/MNWMGORDMmuehMXGoTMLGf0Y1o8cqdWdt96s1M4rUieQQiQ0O/xGbTAhw51m
         tGA7bIimmbAofT5BDzrrwvZDqfA95uAgcjh6PGdTiBMtpIJE7Vrmvq/77UB/BDTPxrVl
         1LG3hmZgMV/c92x/ggmwpExZnZ0U8e7bjbA+pYq0Ki9VCt+eBPciyUcP/QfkETbP6BiN
         Gbct3glQcfTXE9TiTVHhLoU8CcPMlfsdnAUKaDHsivnzItqPVUxV5vQkI3wHmR+AgnFs
         L8YoDuDwXJBaFDWG890k+ULrl/N6s0oH3W+mweQFX44M2cFlMHhV0GcpV+17Mc2SpPju
         LJ+Q==
X-Gm-Message-State: AOJu0YweYXXTCDPf4qgR9BTnxk2yTrwx5kfkXo8qfWzDbizOFwtRSBtg
	4TdQye+D44HuXnd5YW0Meu3rKSVS5Yw6qQ==
X-Google-Smtp-Source: AGHT+IESuJazCC+ViDD9RnoLTspnvguhRj7gR91MdVOwDq4ZQhRT7AU8fIsQGoGM54LSmtY16dkf5g==
X-Received: by 2002:a05:600c:3646:b0:401:bd2e:49f7 with SMTP id y6-20020a05600c364600b00401bd2e49f7mr166278wmq.21.1692966487826;
        Fri, 25 Aug 2023 05:28:07 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:88fe:5215:b5d:bbee])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c229000b003fff96bb62csm2089561wmf.16.2023.08.25.05.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:28:07 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v6 01/12] doc/netlink: Fix typo in genetlink-* schemas
Date: Fri, 25 Aug 2023 13:27:44 +0100
Message-ID: <20230825122756.7603-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825122756.7603-1-donald.hunter@gmail.com>
References: <20230825122756.7603-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix typo verion -> version in genetlink-c and genetlink-legacy.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/netlink/genetlink-c.yaml      | 2 +-
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 4c1f8c22627b..9806c44f604c 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -41,7 +41,7 @@ properties:
     description: Name of the define for the family name.
     type: string
   c-version-name:
-    description: Name of the define for the verion of the family.
+    description: Name of the define for the version of the family.
     type: string
   max-by-define:
     description: Makes the number of attributes and commands be specified by a define, not an enum value.
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 196076dfa309..12a0a045605d 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -41,7 +41,7 @@ properties:
     description: Name of the define for the family name.
     type: string
   c-version-name:
-    description: Name of the define for the verion of the family.
+    description: Name of the define for the version of the family.
     type: string
   max-by-define:
     description: Makes the number of attributes and commands be specified by a define, not an enum value.
-- 
2.41.0



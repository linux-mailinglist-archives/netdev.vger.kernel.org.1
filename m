Return-Path: <netdev+bounces-29986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DCD7856E1
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37071C20C74
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C4BA55;
	Wed, 23 Aug 2023 11:42:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941CBA4E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:42:18 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F123E5D;
	Wed, 23 Aug 2023 04:42:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fee51329feso25233745e9.0;
        Wed, 23 Aug 2023 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692790935; x=1693395735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzgGtNlOM1cvqfWM/EJhHUGF+FWBrjyYnlJyMWp5WUE=;
        b=IKbSNW4QnXPoSgymJztuM3DV8rOHJoBFYJzo40OVp2pAMGDHY9MrAFtLoomRK59nHW
         yKg4c0zWXVD1NlfWU/FHYjrHtdG7VX0Uv7aMBSqXOc4a6GfuJr1SVnUn+1maddpq/nGX
         Eha7ePOF0q3p2VGcqrihS2aFca7gwBr98877KFhfe9qZwFOvtvcWtbr6DfzltzkMI/9x
         I2QUPYdU8hUE0K1K6wdvESNxPUmFQ+B3F1fkYDpxNZliVZKjm8/66OElsISPez+iJoDd
         KtM96VUfSEtZ8KRqWtpVQhG8IH8AVHvKvktFTbuopIXfdMtWVXe28ry+3yHK2a9RM75z
         sesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692790935; x=1693395735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzgGtNlOM1cvqfWM/EJhHUGF+FWBrjyYnlJyMWp5WUE=;
        b=UPmrQfUEi2NFikLgN1m8t4pcrNhu41wkICTJEUFctLlIgSTt9DlsQMu6O1kfDxIG43
         XmdPrG2dzWVtqyf6D224Qh3eiNVsI8FuWMReWgihdS8QiBVPGPTo+YUdnJeYEz092KA/
         B/7yeT+TIDf8PQxawRZZURFKXbYJRfxu+M+2qhqpAeS9LvY1nuMgpDEDH5gBc8kjeIFh
         MIkE2D2QVyGxqNdgBXgh9IddCq9d6WBSd7ULQIXsSXG5BMln6FZvMo6JDc1dhk4akNGg
         734s0VDO9+OaAS9CoRMOg1UGCg8mBi5UVIIixOeXr3ZdjqRULz2P4P9/t3y/L9/OXT+P
         HSgA==
X-Gm-Message-State: AOJu0YwCssUNb2oQuYuyBm529MzVVs19i0ug2I72QOYmCvkisVynhJXq
	R+8LfM0a0sZTNkzQCf2Q/Dulsw+nuO4usw==
X-Google-Smtp-Source: AGHT+IE8XHeTN7mJ7ipg+hRrva+knqb5v6+kSRDdhWZNoMLz2QsIhF/nfZ6MU5AP9+2vK0Vo723ZOg==
X-Received: by 2002:a05:600c:2291:b0:3fb:f0b2:20eb with SMTP id 17-20020a05600c229100b003fbf0b220ebmr9180011wmf.1.1692790934535;
        Wed, 23 Aug 2023 04:42:14 -0700 (PDT)
Received: from imac.taild7a78.ts.net ([2a02:8010:60a0:0:e4cf:1132:7b40:4262])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003fed9b1a1f4sm559508wms.1.2023.08.23.04.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 04:42:13 -0700 (PDT)
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
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v4 01/12] doc/netlink: Fix typo in genetlink-* schemas
Date: Wed, 23 Aug 2023 12:41:50 +0100
Message-ID: <20230823114202.5862-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823114202.5862-1-donald.hunter@gmail.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
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



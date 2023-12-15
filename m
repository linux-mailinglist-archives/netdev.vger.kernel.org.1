Return-Path: <netdev+bounces-57833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBE48144AE
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 10:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531AE1C2292E
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40EC199CD;
	Fri, 15 Dec 2023 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mrumx3LT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D09208A0;
	Fri, 15 Dec 2023 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c236624edso4902585e9.1;
        Fri, 15 Dec 2023 01:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702633065; x=1703237865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qK1Vkv2KuH8YPeFhvfW3+ZdzBe8uXn3x+siF0cRb4I=;
        b=Mrumx3LTw1Yof1cI4wEeoL5z+5ocAs6Dkqz4eqR7v+RsK9Y3ufhJ7qiJx0M9iDe9G5
         AdMyynoEv2UHvajYNdI3l1vjP1T3JSjYxeL6o9BqFa9DV/Bylp+G5CPiBPxlghUgmUzU
         4qVcUZ38sTqJtwQg3F6mXCUNGwitqAR5kA8wpC8B71Hs9KVTrqnOyMb9lQSMezChT8i9
         N2wCdmiWuCmWlRztAUsU5Bo/Q3FFYZmkGOJ9y9HXXv0+/+UyAgN5yj3VPjW0SzOt8UTw
         cTKK6ghY3hkdY+k6laTkHVGjb5MtYRByilFtT3mTONhjM8yq9Mr4K5sGG52RcIB4YPFm
         vFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702633065; x=1703237865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qK1Vkv2KuH8YPeFhvfW3+ZdzBe8uXn3x+siF0cRb4I=;
        b=f3zu54ScSphjJlky63iuSMj3zP5I3NfXNzFLpWAFAd/ZPsv1N/2bP0bJGCezoANKyI
         FlDEZiCOIB0VdPxtNUk6lY1Bdf0M4K6L6UgKz6f8h3HfH7wMBuyfuRKR/baW6x5zkNdY
         tNaf9JouN1256EBTHKOQfj1hN+e6RswelszdwEMrJE6fWNe4iVpMTdaEytjxiZxkeFlB
         SqYo5YODhlFNrkUpaQdu8dwJ8S8UGQHMAW1LHdCnaBUZpVVrT/VtkbzuZVTSwp000IOi
         nVhhTJQrzX4+LdUOXDrB628fTZtgciAJdhJKb0GGPFj50q2KJ2ZHmyvv0SGClgAlFnsq
         HUnA==
X-Gm-Message-State: AOJu0YwlbLB9ayj0Tbg6a6eBJH65Ia9BdzLYBtgwq4SDjzTXBNT1w87y
	3wlDxLA8D3Tvl71OciLIVsOGRpoq/UeRaw==
X-Google-Smtp-Source: AGHT+IGC2u+URCvNi+iuProA9XdPgSmo7S29tRDU5VP3e9oGWsBt+BjCkhDGYXiriRrELqSvkgAmfA==
X-Received: by 2002:a05:600c:224b:b0:40c:35fd:be17 with SMTP id a11-20020a05600c224b00b0040c35fdbe17mr5486974wmm.23.1702633065240;
        Fri, 15 Dec 2023 01:37:45 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:b1d8:3df2:b6c7:efd])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b0040b38292253sm30748947wms.30.2023.12.15.01.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:37:44 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v5 09/13] doc/netlink: Regenerate netlink .rst files if ynl-gen-rst changes
Date: Fri, 15 Dec 2023 09:37:16 +0000
Message-ID: <20231215093720.18774-10-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215093720.18774-1-donald.hunter@gmail.com>
References: <20231215093720.18774-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ynl-gen-rst.py to the dependencies for the netlink .rst files in the
doc Makefile so that the docs get regenerated if the ynl-gen-rst.py
script is modified. Use $(Q) to honour V=1 in the rules that run
ynl-gen-rst.py

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5c156fbb6cdf..3885bbe260eb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -106,10 +106,10 @@ YNL_RST_FILES_TMP := $(patsubst %.yaml,%.rst,$(wildcard $(YNL_YAML_DIR)/*.yaml))
 YNL_RST_FILES := $(patsubst $(YNL_YAML_DIR)%,$(YNL_RST_DIR)%, $(YNL_RST_FILES_TMP))
 
 $(YNL_INDEX): $(YNL_RST_FILES)
-	@$(YNL_TOOL) -o $@ -x
+	$(Q)$(YNL_TOOL) -o $@ -x
 
-$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml
-	@$(YNL_TOOL) -i $< -o $@
+$(YNL_RST_DIR)/%.rst: $(YNL_YAML_DIR)/%.yaml $(YNL_TOOL)
+	$(Q)$(YNL_TOOL) -i $< -o $@
 
 htmldocs: $(YNL_INDEX)
 	@$(srctree)/scripts/sphinx-pre-install --version-check
-- 
2.42.0



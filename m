Return-Path: <netdev+bounces-30387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2B878715C
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A362B1C20E6B
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264EC111B0;
	Thu, 24 Aug 2023 14:22:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C28FCA7D
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 14:22:39 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A1311F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:22:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c71898109so1040300f8f.2
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692886952; x=1693491752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rX/+9gEu3kp9om7xLyNFnYy68Hxacg3OtkhTfAAHF5k=;
        b=VTdzIqnmD/RXSp/QkAG0WJL4DB+PoxGdkInTYEij3h6CliqlDi/z3FE5mJPKTVQppc
         lhwRZK1+vcE2FZXMcpvspHLKieEHwcZ6pVFolw1MEIQj6WuT3RTqhRTTfeA3Rd96WE5/
         il4AzoeqDp965uXZQOzAKEOZdoyUbtQpjeYSMfvl8+3N/G2TtrvSpTFdlFTY9WZG0E7A
         0Omf6QMTiJgN3ADVOPslRbvf1lDbKVqXQBSgfJOR4/vAqNaQ4hmyC+E95GOXDLsJWPf2
         slTUOOrFhXphzUNXb9nbq850/Ma2KS46W5esueu0bjXvk4TLSGTw7wrMC/t5HLZsN7k0
         Ivrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692886952; x=1693491752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rX/+9gEu3kp9om7xLyNFnYy68Hxacg3OtkhTfAAHF5k=;
        b=LS5oo0RvwGKfpgCKg92Dh4CnksfbID0BXhRmJl0MxpU2/fW85LO6++r2IpdUc8Er7M
         LK6inorHOzs+IZif5LxZFuWM2TfWaLoZNW1DLodK0czzPCoH2dYca7qUcdZtwFN77+EX
         sPJLBVH/yz9E/Aq+terjZmmehWC0r/XnyNTW/S10V5FV3b6dXilpFdz2RjgcyInWbtof
         jFFYsWZkVXQ04p79K6DFGAJRLz/V/60mYFlRKtw/WEeWX5wkYSppzUqLyKdru+ab6D+g
         UIlw+XZhX3MTIi5xflxAPRVhnlqJzZyEtBoCKZaOdV+txuE3SwUwKQw2O3OEQTBAdw3i
         Jyiw==
X-Gm-Message-State: AOJu0YzeUcOsOop4zzUp1uOxHg++FyUDfE99n6bXpKJRtfTYFLNNNGvo
	cfRJqLyipz2on8XAZuI6G16ZN6zGj0pRSQ==
X-Google-Smtp-Source: AGHT+IFg38zMT9lYi/La1AZhan67eRUPXqXV4sI4N1s3IM4jkT2RyM3lJnnHqYqIIGEt0DBLVWO+aA==
X-Received: by 2002:a5d:4950:0:b0:319:7b96:a1c0 with SMTP id r16-20020a5d4950000000b003197b96a1c0mr12532174wrs.21.1692886951860;
        Thu, 24 Aug 2023 07:22:31 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d6304000000b0031431fb40fasm22366617wru.89.2023.08.24.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 07:22:31 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1] doc/netlink: Add delete operation to ovs_vport spec
Date: Thu, 24 Aug 2023 15:22:21 +0100
Message-ID: <20230824142221.71339-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Add del operation to the spec to help with testing.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/ovs_vport.yaml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index ef298b001445..f65ce62cd60d 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -138,10 +138,21 @@ operations:
             - dp-ifindex
             - ifindex
             - options
+    -
+      name: del
+      doc: Delete existing OVS vport from a data path
+      attribute-set: vport
+      fixed-header: ovs-header
+      do:
+        request:
+          attributes:
+            - dp-ifindex
+            - port-no
+            - type
+            - name
     -
       name: get
       doc: Get / dump OVS vport configuration and state
-      value: 3
       attribute-set: vport
       fixed-header: ovs-header
       do: &vport-get-op
-- 
2.41.0



Return-Path: <netdev+bounces-34307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC3B7A3103
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 17:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C975A1C20D64
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FC11401F;
	Sat, 16 Sep 2023 14:58:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1FB14016
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 14:58:58 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CA41A3
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 07:58:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fb7fb537dso2885344b3a.2
        for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694876335; x=1695481135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WpodOmeKp5RqBS7oBk4fD2Dra6sgOsoqyhNFRKCGe6Q=;
        b=SsvbBIL+W/iK2KWYBjsACWnaxfXWKbxueMxBLKjMntWLh8RO8CP8feY6q+yXyjpkAb
         5qupu7Vhjxa+K0yAwO7X66Qu+9GxJAN9BjjkchlB5J8L6m0UxdZliAXQ8cfPg0CwhY6e
         4meqxAWXpccI5hr3KmD/Y3n0KcFENHtRDecRACcwWQgClxLIrk+mTjvOGcDs+al+CPix
         PLVLXEmwcenNdDcFm0D8rFwcBeuO8icu9noGwRE03I6rCLzKKg489hb/P9JNqP4IGU2h
         LY6IyTTmmN52v7yvuLyQltvMwWlhBbDN2579cmGT/pf9IqIM1PHGRmmi1licKRCv/Sxi
         iYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694876335; x=1695481135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpodOmeKp5RqBS7oBk4fD2Dra6sgOsoqyhNFRKCGe6Q=;
        b=w+jomU6zQcRJtUtXadfNkvWeMnkUkdzcLStKqt/LlFeGHbURt/pAV4Z+VbZf0E9P0m
         WwHtmqMgUnplYbUyH56m0LD5XBOI0ApRL6vt91Pu1YEj33Uor73GMYCPOXHeqI0ysfJU
         G25s2r+47W9LCEc2/FDekhtbDe1Rpb1dcgQpyIMrDMwjQO0zQc9Gt4UyLa/IgF7eTxgq
         br2Ew1SXBzxo8S/BkOQo1D+eWPZYx76aL9RoXSQEFeND+3LZk38IP9OcfpwXP0+MKejt
         X3twrOwS49x3ghxf1FW1ens7e7HvRqeRnHX9ZcJFSaaIpMi4MelepkA9k36rXBqtCsII
         nVwA==
X-Gm-Message-State: AOJu0YyCVmRkWvmoYEkOYsDgTX41W3s6kLc7a1GIGLHDxFrZMr2PXmTG
	4SPyaIDcoV6wkusqyJC1UVAVexGwGdLpRMswip8=
X-Google-Smtp-Source: AGHT+IGmTjtRPxk64+KOaezjdKZqQo6ODplGiept/NE4aQ8SxM8OoiQAc0TpV+PvawPPGOFXZMhMKw==
X-Received: by 2002:a05:6a00:1a86:b0:68c:3f2:6007 with SMTP id e6-20020a056a001a8600b0068c03f26007mr4732420pfv.8.1694876334901;
        Sat, 16 Sep 2023 07:58:54 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id d1-20020aa78681000000b0068c90e336ebsm4601195pfo.126.2023.09.16.07.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 07:58:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	idosch@nvidia.com
Subject: [PATCH iproute2] bridge: fix missing quote on man page
Date: Sat, 16 Sep 2023 07:58:44 -0700
Message-Id: <20230916145844.7743-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Noticed that emacs colorizing of bridge man page was messed up.
Problem was missing quoute in one macro.

Fixes: a3f4565e0a64 ("bridge: mdb: Add outgoing interface support")
Cc: idosch@nvidia.com
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/bridge.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index 58bb1ddbd26a..5b876c4f4cd7 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -160,7 +160,7 @@ bridge \- show / manipulate bridge addresses and devices
 .B src_vni
 .IR SRC_VNI " ] [ "
 .B via
-.IR DEV " ]
+.IR DEV " ]"
 
 .ti -8
 .BR "bridge mdb show" " [ "
-- 
2.39.2



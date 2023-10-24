Return-Path: <netdev+bounces-44012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 395397D5D22
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29B8B2107D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A064C3FE31;
	Tue, 24 Oct 2023 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9NQgHTO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B63F4D0
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 21:25:16 +0000 (UTC)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E836E133
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:25:15 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7a956887c20so93269739f.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698182715; x=1698787515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igsyGmdDg4YNoKJbIiB398saIC94EtgCOWNzzkFwfg8=;
        b=E9NQgHTOe6ltMQ8BuNuj4vi5dcOpM+0dvA3t+C9NIkWrDKzBZULTT6lsoBjrJTAezy
         IZKTpQQG2VJIKS0eMdWktaPXabRxe5dtLFc0KZZw43dbOYNCNOHhztq+xhcEYCGhbaug
         5yhFklktjc7O5LDLzQn5d9pdsq/1d7JleFJyY/AMql8udq/61LjzScnkUmpmOVrA79PV
         bk8V0suSeLt1CwFFwYN9OATeFGT8Vx6V4p6nfDuZRU36sUyMd73XYP0raC0B/AY2HCY5
         Yi6L5qLvLLtRmOHDI2tIVtvg8toWpCxYsUxlX6rMVfKJDEsVIBYKNnKs9P0LEqG/NF5c
         t1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182715; x=1698787515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igsyGmdDg4YNoKJbIiB398saIC94EtgCOWNzzkFwfg8=;
        b=Z8Crk9FZAcJqhXM2qeRvkgCN406eYLYCHZih2vHPgTCTVJ/tZRcNyE02ZkXWa7RaPN
         5f0M41UXwXiBzzPYnUQ/w0KwAYZpYGbbBX8kflCTFf65GdiBZuQ+XnSW733X1CVEz4Iw
         hmLQ+0RKMxa9wOrHcADflgNo32eRhkWPY532erB1yOx6BjprvDctB8OF5XDsfeCNos95
         iC+7rE9Sqd4bNPCRalrskw5fyym/yre85jlaZOqVqWq1Rw7RCNZ46BVdA/XeJ7HAcsuZ
         qwcntiOzY6e2SmwXhFN/3moxeW3Ldc3Va5t+PN2aSHAs/7PgjOX/vI65qUmEVXD6XYVX
         C0yg==
X-Gm-Message-State: AOJu0YzNEe0oMuCk0dnqhOPFXZONa6ACoF+fKBgtgMWzyfwO+KcMhKfX
	zl9VtJYPWCWS/x/kK020FwJmbk7hAcI=
X-Google-Smtp-Source: AGHT+IF9uazF5rN7IOCnVch5MXeO0erFfMPeKygu4aJRiBx/uLhvj7zjs6dpeOFBN/57C7wP9BirAg==
X-Received: by 2002:a05:6602:2e90:b0:7a6:a089:572c with SMTP id m16-20020a0566022e9000b007a6a089572cmr13684981iow.21.1698182715042;
        Tue, 24 Oct 2023 14:25:15 -0700 (PDT)
Received: from localhost.localdomain ([64.77.246.98])
        by smtp.gmail.com with ESMTPSA id ei3-20020a05663829a300b004332f6537e2sm3070830jab.83.2023.10.24.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:25:14 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/4] Documentation: networking: explain what happens if temp_prefered_lft is too small or too large
Date: Tue, 24 Oct 2023 15:23:10 -0600
Message-ID: <20231024212312.299370-5-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024212312.299370-1-alexhenrie24@gmail.com>
References: <20231024212312.299370-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 6134ff4561e8..4dfe0d9a57bb 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2509,7 +2509,11 @@ temp_valid_lft - INTEGER
 	Default: 172800 (2 days)
 
 temp_prefered_lft - INTEGER
-	Preferred lifetime (in seconds) for temporary addresses.
+	Preferred lifetime (in seconds) for temporary addresses. If
+	temp_prefered_lft is less than the minimum required lifetime (typically
+	5 seconds), the preferred lifetime is the minimum required. If
+	temp_prefered_lft is greater than temp_valid_lft, the preferred lifetime
+	is temp_valid_lft.
 
 	Default: 86400 (1 day)
 
-- 
2.42.0



Return-Path: <netdev+bounces-44011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311727D5D21
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC882821BD
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB443FB38;
	Tue, 24 Oct 2023 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHn/g0BK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD1D3F4B3
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 21:25:15 +0000 (UTC)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4726129
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:25:14 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a94a3b0a49so94314739f.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698182714; x=1698787514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rpv3Ig2r+Ey5CHWiqMkg2QYZg39Hp38jBFwE6JZRnWM=;
        b=iHn/g0BKOy5fYgsyI2u5m6XzQwNqwv3Imm7tqvTkj6WCqxtwpnyFv7//dpSb/tMavx
         DXPkwPbhP1wutg+ICCJm8grQjmMP6eM8jY9bIwRneRflqzIWoKfuu54M0AQJb7XEjR4X
         7dIdq8jvr+ZlgcHEfaOIrlLPHIUtxEBI1Rxh8vIaqQNdeDRvFOnFdDmiPsr/vXoCYGNt
         HTTbBqZbZn9KAWMjrmTNetNszUG6WoQoGTZMIdtHktJjA55zmGzL3H93zMVG3C57suLn
         6+aJ32JarZXyp/hGdSEgSa52Xfbt91LpFOb9RDkNJQBwH0FbVw0f68ZQBPZR6WBI1X8o
         rzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698182714; x=1698787514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rpv3Ig2r+Ey5CHWiqMkg2QYZg39Hp38jBFwE6JZRnWM=;
        b=ZRdIzvQMhBIqVuZCRD+pHAdJEMISqcfEOydVBGNfaQAqCAReL8H7ESFzkDWC6qqynu
         UBz5OQ8B/Rpgh9hOhwLlqRzJFcuywkpSDtSHTawRAwMbZgJKB9+yL+YuIJxcvrcXhD67
         W+ad7ismism5R6QsB1auLSpgXgXl4YfEJvyl/g9TR5XOOpRYRbfc7pcMpO4zJo8Z6Hum
         pg6XkEFavKPRCTMa41mL24meFygCW91PUltUIpiRaGQT28ZYa+o97fs9sw45VMcx9+Ov
         m1iZG/hyh9ul1KrVtf1HY4Ois/7EXq2ntqTo+4fh7z/coYVgFLwP/yOomXOgFflRKv+K
         zLvQ==
X-Gm-Message-State: AOJu0YyemwpGDt3skGgeCiv55Wi7WDvOJmFj2++npU1/hvkPnVMMI73h
	mXKnzxlkWwict7sW3XqANobOXKNaVF0=
X-Google-Smtp-Source: AGHT+IED0zQTeXLyiqoLkr5mSILi/5rEi4Tt04Q+NUs5Uy2MYasAL1fbpgtypDnI47R3KXj6Iwtp4Q==
X-Received: by 2002:a05:6602:2d92:b0:7a6:b272:fd78 with SMTP id k18-20020a0566022d9200b007a6b272fd78mr15638462iow.10.1698182713969;
        Tue, 24 Oct 2023 14:25:13 -0700 (PDT)
Received: from localhost.localdomain ([64.77.246.98])
        by smtp.gmail.com with ESMTPSA id ei3-20020a05663829a300b004332f6537e2sm3070830jab.83.2023.10.24.14.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:25:13 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/4] Documentation: networking: explain what happens if temp_valid_lft is too small
Date: Tue, 24 Oct 2023 15:23:09 -0600
Message-ID: <20231024212312.299370-4-alexhenrie24@gmail.com>
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
 Documentation/networking/ip-sysctl.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index e7ec9026e5db..6134ff4561e8 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2502,7 +2502,9 @@ use_tempaddr - INTEGER
 		* -1 (for point-to-point devices and loopback devices)
 
 temp_valid_lft - INTEGER
-	valid lifetime (in seconds) for temporary addresses.
+	valid lifetime (in seconds) for temporary addresses. If less than the
+	minimum required lifetime (typically 5 seconds), temporary addresses
+	will not be created.
 
 	Default: 172800 (2 days)
 
-- 
2.42.0



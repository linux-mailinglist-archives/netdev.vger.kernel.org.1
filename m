Return-Path: <netdev+bounces-46118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDE67E181B
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 01:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B68A0B20D24
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 00:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0DA18D;
	Mon,  6 Nov 2023 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7rW7sLw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E21181
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 00:14:18 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BC6B8
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 16:14:16 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32fa7d15f4eso2689716f8f.3
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 16:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699229655; x=1699834455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFOW/+2vvn9aeeXpUZsCKuB5/2F19dAyf7SGy9iWtDc=;
        b=g7rW7sLwqjQsSkUOmfkrcu0JzUBBezoNPCnpO09iSJBqEjRVUkqb4HkuWkJEWdzFll
         SUoMhp10g9f7dUKFQuy92aWWgFAJhVGMU41uV8YCtM/v2T8t0ZV1nHKjZIzTuPoaFCra
         TW5MAfJYSHzvqTgAfXXz1RLxH2Yw8W0Uk1iZcGLlTmUImnX77iSbAkkxWagBh042BkJy
         EfY8P6ENHh0MX+x+kEwWqTwgdUDP5IckDj2WNSHSMhmLKiA1TOlDEiVTCNDDHKpQsxBE
         spbdYO2vXj4QRMFzsGkPUClvPb+9INxDgaTAzZNzCRboDeow7Nn5BVUGEdFYX+uxpywW
         ANbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699229655; x=1699834455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFOW/+2vvn9aeeXpUZsCKuB5/2F19dAyf7SGy9iWtDc=;
        b=j8/8fnI+9XjUuyGNz/RQB3d6MgDBuWlGttx/+trvzJ3ggIGNdT+tyIAK9KnDgq+xVP
         lr/nfw7YHjlI3fxEw9mOYWvUyYojsDGAmNi7CDc4DNv5nTHfa1AThmzVacipnUg5VSW7
         nMH5WDXdAMq0RxisA5h0AS7ZQitK43zLxL35w+1uO8vLwo1ZA6AY6bAjMd6QSfBUemVo
         rccM4u+hlkLMKlnGXrK30JWOaWeQWwJQ8dCz4yCYwcHjsSEPiDpIifDVvQlRWWStDx21
         LxEYIuU+GkTSXEnfhaJwLZR7vMmfDZP72P6LJyX9YVI49Ez1OXOWQIfhmh0/8br0wMjR
         8jhg==
X-Gm-Message-State: AOJu0Ywbto1PjTrhEVIWUpTwq11DBjdkI13Dc25c1XU46DpTq0V3fqoK
	T8yhvwwXna5C14Oem/l/hNt6T1IGgVE=
X-Google-Smtp-Source: AGHT+IEU2thWg7i2aoczavvL+OzTkNNTr26lRi+tQ2G1X4LbL4nU3sW+ADSkvwnPak/shedJAjjofg==
X-Received: by 2002:a5d:43ca:0:b0:32d:9daf:3f94 with SMTP id v10-20020a5d43ca000000b0032d9daf3f94mr17133190wrr.53.1699229654776;
        Sun, 05 Nov 2023 16:14:14 -0800 (PST)
Received: from localhost ([137.220.119.58])
        by smtp.gmail.com with ESMTPSA id e4-20020adfef04000000b0032dde679398sm7992752wro.8.2023.11.05.16.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 16:14:14 -0800 (PST)
From: luca.boccassi@gmail.com
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	aclaudi@redhat.com
Subject: [PATCH iproute2] Revert "Makefile: ensure CONF_USR_DIR honours the libdir config"
Date: Mon,  6 Nov 2023 00:14:10 +0000
Message-Id: <20231106001410.183542-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Boccassi <bluca@debian.org>

LIBDIR in Debian and derivatives is not /usr/lib/, it's
/usr/lib/<architecture triplet>/, which is different, and it's the
wrong location where to install architecture-independent default
configuration files, which should always go to /usr/lib/ instead.
Installing these files to the per-architecture directory is not
the right thing, hence revert the change.

This reverts commit 946753a4459bd035132a27bb2eb87529c1979b90.

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 54539ce4..7d1819ce 100644
--- a/Makefile
+++ b/Makefile
@@ -17,7 +17,7 @@ endif
 PREFIX?=/usr
 SBINDIR?=/sbin
 CONF_ETC_DIR?=/etc/iproute2
-CONF_USR_DIR?=$(LIBDIR)/iproute2
+CONF_USR_DIR?=$(PREFIX)/lib/iproute2
 NETNS_RUN_DIR?=/var/run/netns
 NETNS_ETC_DIR?=/etc/netns
 DATADIR?=$(PREFIX)/share
-- 
2.39.2



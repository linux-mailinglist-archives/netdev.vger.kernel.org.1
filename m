Return-Path: <netdev+bounces-130488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AECE98AAEE
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F201F22DC1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC8198E9E;
	Mon, 30 Sep 2024 17:18:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF5198848
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716682; cv=none; b=ntCldeacQ8nIa+FNDI29LqY8MQY3OS4jra7QNzwmdLsufiGGktU5kHtSKxpDQJPef9AA5Nu8Snxr4+k2QN28A2ZUHscFsoWXtWe6Z+NS6du3L/cRPvtAmU1u2Mqu6Ek2UOzJI+AJpYvnwIShFvjcYqHs02l791ePrpCcofXIZwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716682; c=relaxed/simple;
	bh=OEiQjsd77/J4AUaRRSihKZZbIILV9i6MyEIBV3CYweI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcrdU6hpwj1l/HiIPIJBDk7sndp+CS+cVB+JxmZWmFtB+B5Z3umGegQRT1qqUkkBVGmfW54KMYFhoc3KAcb9Hw6Z6U/TZYu7TDWiqAhRq48Bb7jNGYSyCMkUml3sNIsw/wOXt7qqh4e1KpLzXHGmuMvSj8vPciGhv1PiG7fCpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so3090560a12.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716680; x=1728321480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOqtNZVQHyIAx4sh4ziq0pdIW94+VRMlBWI3BiRvwrw=;
        b=UKLIC4jCgD0RJjQIRiXphD40Mvlee7/IYXy4H0TQ3d7zKmQGLR4EADCGCqBYh+0Tju
         YjTDri3I0kFNmm9KkWk8rwYL4FJWdu7wXeMl3mLKHN3tDg03wWDt5K53mmBN0v4YX7Dc
         TGOApt1KdEmpzT/N3hFX8rfVeLpm6e8WjvDd2OIxpReAIJvbSFBDuFTm4HrH0rZmPSAp
         MUB0Wnenluh/P5yHLfbhdChVQdmRSj7JuFoxAc64FVTlBaYM7vgHjZTeeyYOrNvRguQE
         sBhjQQPauXt0ubolxkFlfSXZQdCC9qHJiAXWfv1PGe4FHz99Z7o9l46E27fRnASlu/tS
         LOTA==
X-Gm-Message-State: AOJu0YxTmbCymQMfBkCmgNzsCDCR6wYAEj42tAyfc05Yxb1v80rE6zAN
	X4X3SB0AzYvPHEWSTRxOLyhuj/01QsaV7QVe3bhnVMZRAtly4r5BwLmT
X-Google-Smtp-Source: AGHT+IFyLgssQn2gal5pMNvUGd1D/7MkfX5P5Rwm5FCOf142la99tCjDTddukMYhhgGzreU1tiCO2A==
X-Received: by 2002:a05:6a20:6f90:b0:1d5:2b7f:d2f8 with SMTP id adf61e73a8af0-1d52b7fd476mr811669637.13.1727716679728;
        Mon, 30 Sep 2024 10:17:59 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264d39e5sm6670783b3a.92.2024.09.30.10.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:17:59 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2 03/12] selftests: ncdevmem: Unify error handling
Date: Mon, 30 Sep 2024 10:17:44 -0700
Message-ID: <20240930171753.2572922-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240930171753.2572922-1-sdf@fomichev.me>
References: <20240930171753.2572922-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a bunch of places where error() calls look out of place.
Use the same error(1, errno, ...) pattern everywhere.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 557175c3bf02..7b56b13708d4 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -357,32 +357,32 @@ int do_server(struct memory_buffer *mem)
 
 	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
 	if (socket < 0)
-		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+		error(1, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
 
 	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
 	if (socket < 0)
-		error(errno, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
 
 	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
 			 sizeof(opt));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
 
 	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
 			 sizeof(opt));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
 
 	fprintf(stderr, "binding to address %s:%d\n", server_ip,
 		ntohs(server_sin.sin_port));
 
 	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
 
 	ret = listen(socket_fd, 1);
 	if (ret)
-		error(errno, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
 
 	client_addr_len = sizeof(client_addr);
 
-- 
2.46.0



Return-Path: <netdev+bounces-127888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98981976F59
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8B3B22AD9
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA51BFDEF;
	Thu, 12 Sep 2024 17:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924801BF800
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161180; cv=none; b=kECFnXfBFTjwhT2iuEF4tVLWXt9dD5pDeqWtIrCmy0k/3R7J9qvy92XYRZLjzGE1qW6t8/YTyLOe0cXsWrLM8OMU86hl09PJJ+nZA0Qx+k9cju4AV+WVAc4I/Vi0RmUs5t9ljULNnbAnRGgVUWjyrWgZyL5Wr8/HeoN1myDm4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161180; c=relaxed/simple;
	bh=/qkpkrMunVECO3NqnNNvX4ewF3vz3vycvMLZPT0TKe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBn5OZ+TCM7uX0Cyks1GWC79M3wRO0KV/tcaL0fDCeZA9LjTVUlcsQLCPHcHP3tUHOfa/1i2z2T+TkuObg2ejR88ktRxCtIz/XvUNjeCGjKEvCmj/2kXIXxJD+4LQt20BNqKu0gLgs0xcjJT1Ayui/MVuxbSQABdxzpUm/0hefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2068a7c9286so45595ad.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161179; x=1726765979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=965vafb/SxlbMCGVTQsZKXFKp1G88lIqDgorHSu9Pdg=;
        b=WvLVdLoyXZt6gAsPek5r3SiurJ+U6XEhJoh2ibV5mF1775KHMMFWCj/ub5AqbJfT1p
         y8OWGJIrH1ixQQc/IvWviCkr1la2v6Bx2cU14kKVNDVksl9KTK+Bevq8b+KlMljYCN7d
         hiA7omEodif0vSUFRe8YayYzF0gfIVyrlPOc4MN0XWYn18LGkbQw0PJNITStgd+KP2NQ
         Ls4z3JD/HDGej/WgrPJBUYEV0NJjM2if6+92PGWC4vs/G9+FJVN0bW0mSiFsi5Ifejys
         4r30C4rmJdr90gx0gGraUw0UZpv7wKz+n4CBuqvBTzD2zqO3ql2fe+8PNyP92+9Oymm/
         02hQ==
X-Gm-Message-State: AOJu0Yy3EXGgZ5s8gTNFyubgjtiPTy06EBoashdJt4ZNTafHvvbNQLtM
	OEBCqd3dmZDdwlCyUVYADmN8t7V6Up9MOPHEGIyD8C8pBPGDga73GPBD
X-Google-Smtp-Source: AGHT+IHqXA8bp8O5GYZpSFLJgxGTmXj+/oBYndyPRDu9q0jERA5JRokJxge92gXvRYOEPlEJLaiCWA==
X-Received: by 2002:a17:902:d4c7:b0:205:5410:5738 with SMTP id d9443c01a7336-2076e3944aamr43884675ad.27.1726161178419;
        Thu, 12 Sep 2024 10:12:58 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afdd41esm16485215ad.173.2024.09.12.10.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:12:58 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 05/13] selftests: ncdevmem: Unify error handling
Date: Thu, 12 Sep 2024 10:12:43 -0700
Message-ID: <20240912171251.937743-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912171251.937743-1-sdf@fomichev.me>
References: <20240912171251.937743-1-sdf@fomichev.me>
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
index a20f40adfde8..c0da2b2e077f 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -332,32 +332,32 @@ int do_server(struct memory_buffer *mem)
 
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



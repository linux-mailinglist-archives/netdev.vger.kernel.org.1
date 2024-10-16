Return-Path: <netdev+bounces-136296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620739A141A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4571F2256C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB7E2170CA;
	Wed, 16 Oct 2024 20:34:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89FF216A31
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110870; cv=none; b=WvsfW9Xjwr2IhMrGkhFqqhzHLqQPi8rXbHrwx3PkHYWIfBwNWBtVqQ8a74QA+O20Xhe7XIwX/YDRlJd8Q89iHPMkKIFPmu19c37vzmX3ZVFQohJNrZOI6YP95wx/Rrx3yBCLRWEck4o362qZsfVdZ/4PO/x9kdr/BHc9PFuIsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110870; c=relaxed/simple;
	bh=FmldFMIB4EfRQpjNGb4dcSgm3bpFknowStTac1Zm0Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc5Mo8EFv3u+VfL/SxfFpAxP4iqNEicrhJePKlpfWPo7l6JGcGNzTZGgPGEsUxt0EkrEngpPN2/2y2nSdS+w1E9O4vBHd/CbfDiXsgYXlFj5iaTSkpeJdEgG9g3qSashqc4VPcJP2RJuNm+x7Ymd5W2Tph/+hS9B2r+w7iK/BBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso182453a91.2
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110868; x=1729715668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrCMEjPsFSH2LyCZdX13Hj4AEMiB0VKRqhFYl7onOmE=;
        b=rm8fvuIR6QV+bA6opbD9RGqq7++v/g44bOcqql4LC3VwNTXYg0w8XHPvCS3wJkKKxK
         VdBYSix4DcT4Mu7ogGg6Z9mCmfm0pAiwO0h8pb/tZ7IqUGeK1/Y0hOkcD/HHnGcZTM+1
         DB76U02BBTqp+mGODLKs1K4u7rBGT/PgsbpMGfOfM6oKnw/sKWhV9BuKMtRTO9/5zrFn
         tGFjhxD+Z+X06LeE5UkVTR/EONmsmpeX/S14ysEnR6o6jHfBgATMb6WdXls9EG37V8C3
         jq567nvQgtUgdeax1SwmUClbuayt7v/JYLPdeiSLZnzmhhDM0ZiDtOegBYwx29DxQxle
         Z1vg==
X-Gm-Message-State: AOJu0Yxp1r0siYQyVPAvPyR89XfxgRUxLfEL3zv6NnGdY4pl6pIaGJQ6
	myf0DnKXZIM3MFDi8WVMyVCQ5EKdBKXF1pNCFUFTP2beGefLMxGTSj16fg4=
X-Google-Smtp-Source: AGHT+IGNQkeHeGkUPde5YNKceN1gJ+PAV3/k5uxlmOiN44jQ9rGMLiRDPSCscLeiRL4kameqFagSrQ==
X-Received: by 2002:a17:90a:db87:b0:2e2:ebbb:760c with SMTP id 98e67ed59e1d1-2e3152c05e1mr22117651a91.11.1729110868053;
        Wed, 16 Oct 2024 13:34:28 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08b17a1sm243935a91.9.2024.10.16.13.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:34:27 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v4 04/12] selftests: ncdevmem: Make client_ip optional
Date: Wed, 16 Oct 2024 13:34:14 -0700
Message-ID: <20241016203422.1071021-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016203422.1071021-1-sdf@fomichev.me>
References: <20241016203422.1071021-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support 3-tuple filtering by making client_ip optional. When -c is
not passed, don't specify src-ip/src-port in the filter.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 57437c34fdd2..2ee7b4eb9f71 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -62,7 +62,7 @@
  */
 
 static char *server_ip = "192.168.1.4";
-static char *client_ip = "192.168.1.2";
+static char *client_ip;
 static char *port = "5201";
 static size_t do_validation;
 static int start_queue = 8;
@@ -236,8 +236,14 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 
 static int configure_flow_steering(void)
 {
-	return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d >&2",
-			   ifname, client_ip, server_ip, port, port, start_queue);
+	return run_command("sudo ethtool -N %s flow-type tcp4 %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
+			   ifname,
+			   client_ip ? "src-ip" : "",
+			   client_ip ?: "",
+			   server_ip,
+			   client_ip ? "src-port" : "",
+			   client_ip ? port : "",
+			   port, start_queue);
 }
 
 static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
-- 
2.47.0



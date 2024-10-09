Return-Path: <netdev+bounces-133826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C2C9972BF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F8E1F22B6C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AFD1E0DAD;
	Wed,  9 Oct 2024 17:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60A1DFE0E
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493981; cv=none; b=nKP5wllaQx4Yjxu/LcEVH9OS7j1yz58JDBsQ0AEWwMfVyiBCFsR1paYqHNBMo5ae/ceRUOMMTvuWRtLVg0ZbzdUxmVNgRrDAqfm/orxsc//BNYJ+7NLKLrZyiHd5Cx80CmNjLBqsjLt0V+8z6BIw3yR1SFuHpf2IVe0zzhGE9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493981; c=relaxed/simple;
	bh=FmldFMIB4EfRQpjNGb4dcSgm3bpFknowStTac1Zm0Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMWvBot5jslrsk8NgYZOOLzOn1RxyhVzDydrgeavoSJKepqkm2GJ5Mz5Fhbj7NO/uFQnjoSFfpat6ruYDHm4TGWszvfulTa29+zsRqTfxhlRz4Ji/iZvv9/m0TEd8ERT7sOHNNVFRg2YFm95d6txZpk4LApkMKvb5ZVPe2bgQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b86298710so61344865ad.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493978; x=1729098778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrCMEjPsFSH2LyCZdX13Hj4AEMiB0VKRqhFYl7onOmE=;
        b=O9jwYquLFKM7VY+j8NDdIBZcg3TrEC8RWFwrjzmPsqURTCRmMwasBDHhq3kzx0jEVD
         Y+M3z3lqjnbcDzw1vlGWidAz2L/8OYJRAoHi+A7J6KBmTaros2a7RvUKAplHvYl66uwd
         9QrAGukIdvrYqoSFzBzUy19KaIKkjcdSw6X9o94hivc5vyOZGfu7uG1KPDcEpZeetjG0
         lt3ZjxIyy85I5yGIMJ83Vzb0sDWS4u7abwfPFfMwWkrEWcv+CO0eEkQ6utqRJQfW5cid
         LqqVLTQprS5xaiNbd5CuvQGkSh1bycV8+vsKvgFFfuPel2r0DyptPHIsisGFoWq+l9MS
         jV/A==
X-Gm-Message-State: AOJu0YwSmCQH5Qg+TXyPqOxXhGt1ojLyF6kEvT8O69B2GREFHeXFHfVn
	JFf/zantc2+Bf8iGRMOsAmd3HSdRHWq+VLO/nf5Wc9Z8KXDc0CgRhL2P
X-Google-Smtp-Source: AGHT+IHLSCy5s7aqUl4Qa2GzV1FEUjzHkhQDQF8mTpvv2xWpId/SLHsxUkmZtJjDdb/7K0lCI8xK7Q==
X-Received: by 2002:a17:903:244b:b0:20c:5909:cc48 with SMTP id d9443c01a7336-20c63780190mr36392235ad.40.1728493978087;
        Wed, 09 Oct 2024 10:12:58 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c60dc72c0sm16311165ad.100.2024.10.09.10.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:12:57 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v3 04/12] selftests: ncdevmem: Make client_ip optional
Date: Wed,  9 Oct 2024 10:12:44 -0700
Message-ID: <20241009171252.2328284-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241009171252.2328284-1-sdf@fomichev.me>
References: <20241009171252.2328284-1-sdf@fomichev.me>
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



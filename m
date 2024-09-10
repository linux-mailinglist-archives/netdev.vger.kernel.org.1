Return-Path: <netdev+bounces-126931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA950973120
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8CA282DC8
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC779199FA4;
	Tue, 10 Sep 2024 10:04:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019E190667;
	Tue, 10 Sep 2024 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962679; cv=none; b=NgHVaH/LNGe4cnG2v7zFauU+tPZMNv8GHPtgyF5dqtrHK8B9uKOg6uMdTfutw/LqIGo2TGrcA78TVfYF3w6TXziQdjAiWf6wHLpPfW/3IA+nwJKAzzpKvk4kUpsX4meBixO7rSHGpmOZAsZSja4/flbfleWuxrx9LIiANhM5d0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962679; c=relaxed/simple;
	bh=fVBe2+wvg1jvCIqi29qSEpWCHmDMPNeHFjsHpuV8Mhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ot0h/n89VPUqERRW9EubqQf2vioBcLT5MUtqwJaHW0MMlXsG1r01D2x1AR4mGVYzj7of1oht6w24NvNNeJIMsZIE448Kupxqq7orE9Y/pvRBz71bmLFI/gi/MNnjOd1iHmXeT8bJmsPRbG5LOA89LJ+stKqc3p/VLVCdUaYWHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bef295a45bso2336113a12.0;
        Tue, 10 Sep 2024 03:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962676; x=1726567476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdFM3/nkoHZB47AixIU8OcFNaXm8D7juybaooP167So=;
        b=W9vkgWUhYqYRwNhUBZUyTHcI4Wql7dYAHcpY0Fc2Qky4mPy8gi8YvHizfoM35tTUvA
         j4Df274Gk1neoIl2xcEltyCOzG2MClyRs5sgGlGa4kGh+xS8arAu3YDzf77Brn1F7G4q
         tT+XeXhlNxgk3GmFFejjUhHO4Cn4r145Q/62lHQbIMSvOwhy1x9rF8vEWiUwjuzUQh0t
         8T9mdmCYd2dXLJLmUX6JJCLbGfcVyGYiCxtt6QUyuEDVguQEIdzw2+3pdIuwvWBrEtNP
         BvXWXZqxyIm+jpjw/7mQDFbtCF+gcQArIDwdN7GWc6TPOyn48MIHEJNPkznvLLQklsgB
         gUWg==
X-Forwarded-Encrypted: i=1; AJvYcCX/qTLon4tkGac9xz+454J9OkgAOHcPyagCGECGE/Z/3xOoEfUPCiLF3G1NXI3YtXpZs8/fKRon@vger.kernel.org, AJvYcCXksWbepFCSZ17R9Us9EOpAxApsriCs4XCACWjUpqI9Tg43mXz6zbFlfbdQ0MXxEpxq/1TA5DH4nuM/jc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsBTikvfckaaqboDGfnFDdDxXrdag8NFOsEdizgHp5cKfSguov
	n7vhn+GQTFbklzrej9/SIVXGe9bJIcEkesHmbQrQyjQ60V8ISIc1
X-Google-Smtp-Source: AGHT+IHUY7tD9gZc0uoUw5kf66usXyJ9SYYRRKZ1mt6AggCfnzqOMbt3TBVGU+AWMNx5t/fwThZ78g==
X-Received: by 2002:a05:6402:1e93:b0:5be:d687:9e6c with SMTP id 4fb4d7f45d1cf-5c3dc7c9dbbmr10690001a12.36.1725962676147;
        Tue, 10 Sep 2024 03:04:36 -0700 (PDT)
Received: from localhost (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd41c36sm4078483a12.2.2024.09.10.03.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:04:35 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com
Subject: [PATCH net-next v3 08/10] net: netconsole: do not pass userdata up to the tail
Date: Tue, 10 Sep 2024 03:04:03 -0700
Message-ID: <20240910100410.2690012-9-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910100410.2690012-1-leitao@debian.org>
References: <20240910100410.2690012-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not pass userdata to send_msg_fragmented, since we can get it later.

This will be more useful in the next patch, where send_msg_fragmented()
will be split even more, and userdata is only necessary in the last
function.

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 2cdd2d6a2a18..1de547b1deb7 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1060,13 +1060,17 @@ static struct notifier_block netconsole_netdev_notifier = {
 
 static void send_msg_no_fragmentation(struct netconsole_target *nt,
 				      const char *msg,
-				      const char *userdata,
 				      int msg_len,
 				      int release_len)
 {
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
+	const char *userdata = NULL;
 	const char *release;
 
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	userdata = nt->userdata_complete;
+#endif
+
 	if (release_len) {
 		release = init_utsname()->release;
 
@@ -1094,17 +1098,18 @@ static void append_release(char *buf)
 
 static void send_msg_fragmented(struct netconsole_target *nt,
 				const char *msg,
-				const char *userdata,
 				int msg_len,
 				int release_len)
 {
+	const char *header, *msgbody, *userdata;
 	int header_len, msgbody_len, body_len;
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int offset = 0, userdata_len = 0;
-	const char *header, *msgbody;
 
-	if (userdata)
-		userdata_len = nt->userdata_length;
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	userdata = nt->userdata_complete;
+	userdata_len = nt->userdata_length;
+#endif
 
 	/* need to insert extra header fields, detect header and msgbody */
 	header = msg;
@@ -1201,12 +1206,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 			     int msg_len)
 {
-	char *userdata = NULL;
 	int userdata_len = 0;
 	int release_len = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	userdata = nt->userdata_complete;
 	userdata_len = nt->userdata_length;
 #endif
 
@@ -1214,10 +1217,9 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 		release_len = strlen(init_utsname()->release) + 1;
 
 	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
-		return send_msg_no_fragmentation(nt, msg, userdata, msg_len,
-						 release_len);
+		return send_msg_no_fragmentation(nt, msg, msg_len, release_len);
 
-	return send_msg_fragmented(nt, msg, userdata, msg_len, release_len);
+	return send_msg_fragmented(nt, msg, msg_len, release_len);
 }
 
 static void write_ext_msg(struct console *con, const char *msg,
-- 
2.43.5



Return-Path: <netdev+bounces-127889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746E6976F5A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72B51C23AC1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398881BF7EA;
	Thu, 12 Sep 2024 17:13:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B591BF7E8
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161182; cv=none; b=hh19/TaMDC+owai4PYkCNJFFTF/q8BLAH7/xiwqdPxtEH1aVWQRqGQSrhoi04Bpl8h5IxVxNRAXxPHF+bnJra9pZNvQcqZQp+ea4DHfP6Cnpfnb07Kqpl1VOJ8mf5NveMxg3OvXCwyTxUqxiPD/BUxGc9LYVisRRtxBJkH+ozms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161182; c=relaxed/simple;
	bh=DVzHYsp76hzKZntoTHzwpHhzyso+ZaOXyFoTe6z5YJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pv6Z0wQzxmpIW174AVoye89xif4ENcxjhSPpLQj1zC61IVL05uOChWkfD5hxRLGSI3X3vxsJVWL9xj31/0UG/fKoa7GyypuNTdyqAC/P/XTSSHfg25mxWHXhI6MsIyDhGTdl4q+OC8uO6gUJ3BVVeN3dCmaVWQjq/kTHj4L/fY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6e7b121be30so953630a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161180; x=1726765980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GrjV5gEwYp3sQT3vkyltKULjMmlJYoJQd5AnCA8UJg=;
        b=MJvTJPCJO2CYNkIHM0IMJ749Zwhkjr8W9HqDcySCgoh9XrMLkbys1fRG8FMlXcz/Y6
         gB1rSoJYuoBq2Gciur+OTH+WkkAmPaTBxMDkh93Qx09tW0bVEBeIolnvzKqykg+V8G+b
         SQpb7mdRAog1DXHQXk8oVevnSFTX4tOs6pIEvpXy7SavSSmAPzKHR8hQMP970/OUHIUI
         T9gdg3UZQHRrgrw/OpC5YOTW/Nf6AtykzGJjMeo13XLDDlhsItfX0/6TMbFyg3IZBmS8
         yiWXX3TMYLKegCKhnWHceAAjRWwSM75Bg+KBQmwIMffmqSfWEmlnhRNnWK4IHCygTq4p
         ivow==
X-Gm-Message-State: AOJu0Yw0+0dK6eqiA5AXh0O5bcQMhGzCPUd1EVH5JHk/hqh047SDZMeG
	kDudIsYGpUBBU1ghDBavs+tXarJT+xa5Yp24XxpX9gQVS6LSN5RkHm86
X-Google-Smtp-Source: AGHT+IGT019AEEyWUlzr95G+Ry5239IM9yBY+lqdvLZiabMV3fC8f3yeGSdbzYRc6DWz+Dfobysqzg==
X-Received: by 2002:a05:6a21:1813:b0:1cf:6c87:89e5 with SMTP id adf61e73a8af0-1cf764c2b90mr4230693637.48.1726161179742;
        Thu, 12 Sep 2024 10:12:59 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba4766sm1979878a12.12.2024.09.12.10.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:12:59 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 06/13] selftests: ncdevmem: Remove client_ip
Date: Thu, 12 Sep 2024 10:12:44 -0700
Message-ID: <20240912171251.937743-7-sdf@fomichev.me>
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

It's used only in ntuple filter, but having dst address/port should
be enough.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index c0da2b2e077f..77f6cb166ada 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -62,7 +62,6 @@
  */
 
 static char *server_ip = "192.168.1.4";
-static char *client_ip = "192.168.1.2";
 static char *port = "5201";
 static int start_queue = 8;
 static int num_queues = 8;
@@ -228,8 +227,8 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 
 static int configure_flow_steering(void)
 {
-	return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d >&2",
-			   ifname, client_ip, server_ip, port, port, start_queue);
+	return run_command("sudo ethtool -N %s flow-type tcp4 dst-ip %s dst-port %s queue %d >&2",
+			   ifname, server_ip, port, start_queue);
 }
 
 static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
@@ -553,9 +552,6 @@ int main(int argc, char *argv[])
 		case 's':
 			server_ip = optarg;
 			break;
-		case 'c':
-			client_ip = optarg;
-			break;
 		case 'p':
 			port = optarg;
 			break;
-- 
2.46.0



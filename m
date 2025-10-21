Return-Path: <netdev+bounces-231123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C81BF5779
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D58744F4D07
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89668329C6A;
	Tue, 21 Oct 2025 09:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C225524F
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038383; cv=none; b=ZqOufT9Qs1sczzTgWP31lFI4VsrXhLRN/zNsWvGdbSK/HoNZhyAD156x8UdlRecsi8W3PMrDrdoASxnck5WeUz0sszEJjtdRP+3BOncRYs8uPC/T77MKQiQ5DesrhTUJ6no51mTzckxQCUImC6EgyyFAXhyB5wjPOYe2gcxPVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038383; c=relaxed/simple;
	bh=PDNCgO0KptDKzAIo142wT9101j8XamBEfTu67d4oQb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KejvZwF1Fd1D0SHtQlyU20VMcyeQ9s4lqMQpVUGKJ/HtbnTn6O3O8l912ocP74wAKw7/MsyAHoOtFnz2v9f6UIxm8ppfMNXAMs0YW0NA2Ur97+lefiPCcpGb2X7TWYLOIqInBDEc+lWm4VnuR1jmyHrp1dMt7w82tqdK5EsZpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz21t1761038355t58d98a34
X-QQ-Originating-IP: NgiKUSFFFck2Y/SjgHNhg+CfznFlFdQoowiZfUuUCkg=
Received: from localhost.localdomain ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Oct 2025 17:19:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10265159055031246347
EX-QQ-RecipientCnt: 5
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Eran Ben Elisha <eranbe@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH net-next] net: add the ifindex for trace_net_dev_xmit_timeout
Date: Tue, 21 Oct 2025 17:19:00 +0800
Message-Id: <20251021091900.62978-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OSUW9vQLVhiZ6ut27O7vaqYU8rzb/7Muz9VxU6bkHH7EkvJ1svm+VPGU
	h6BEC4gYVBZtQyowwOWnAFqWhaDHmKpfJw0ndIGzCQmrs/agHhwS7XVG2N2xWQgTjJ9JxqJ
	085nOJXq6+j4H0IVo9S7hpYfZOwkASFpPRJ9BPVoK/NKHDiDaB3ekenBrRITK9hkpMS6FPc
	Q0roPfZEnRMj7wkkpvuVdXQDN+7uhZcoMGCQCBGiXTuviRphvCqeRVtesib6kx7C7IMT1Mg
	V0ddK0kdM3lg80hW9QkHoRfBSlE3nSQPT6gTvgXxj6LjhNlFNQdP3vuWFwnS9fD/evTwdcL
	/Ovb/qQet7MT/iqsMemoIVYodZFjgmiQFVoqNocXlzYqePW+gE6ZvhDp4yd+RPTunm4qG4d
	V9svTJfuHJgbV0gNlW0iJWvU4sM2r+UzcB8nfrgZnENvyRpngq9G2ZvEkpL033HnlWOE4Se
	8EIW2WMGg2ySQSZwqdxA32ozMj9rP+0EmKpiG7NFX6Y8A6yASlkSKS1gCcCs/iMrxuGbJtF
	l3M6AT6JRzcrUYiOqIGUz5BAPGnf3G3cdbY9NUV4NNaqpzil3vv8zVJ+3S2aHi6rXBmhAVW
	Bd0s9elExWeRAcjouhyOOd8ibMXPQE3fOQgsr2i0+StHe+uB2t7AqhT6boAJL8IutOA1tCm
	ebhQNVCyl/FCmNEOG9gn1I0Kj6O8G44aruI+Wb/3vOC5cLIOsaRTjexcsK2Tq3G9QaM6UnK
	KClu/Lpe16bvmLI+oKlN5CIXrUDu1EHkeGo2SywGq427XVQ5jBBJzRWTNjBUxrGSzN4/Q+8
	hIV2N349RlfUE4W1lgVPELiygH7WhKYM1kuagEEzclgru+7rK6vCCgNchUuK0rbJmk79SDT
	rHtQyZ1XtijGtnke6FCLNNQ1LVZw7e50et9Unf9ZIwe5k3ol00e3PjayOs2TJ7w4eAv9jvn
	RmURqNwnC2yvNYWjeRdR5ZalcTPwk8VOuAnsCo0KVJCJyD0RssRE1ZVKN3jDL0Miau+O3MA
	hrdbikpg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

In a multi-network card or container environment, provide more accurate information.

268.148239: net_dev_xmit_timeout: dev=eth0 ifindex=6 driver=virtio_net queue=10
274.292271: net_dev_xmit_timeout: dev=eth0 ifindex=6 driver=virtio_net queue=10
277.876231: net_dev_xmit_timeout: dev=eth1 ifindex=7 driver=virtio_net queue=10
279.924230: net_dev_xmit_timeout: dev=eth2 ifindex=8 driver=virtio_net queue=10
279.924233: net_dev_xmit_timeout: dev=eth0 ifindex=6 driver=virtio_net queue=10
282.996224: net_dev_xmit_timeout: dev=eth1 ifindex=7 driver=virtio_net queue=10

Cc: Eran Ben Elisha <eranbe@mellanox.com>
Cc: Jiri Pirko <jiri@mellanox.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
 include/trace/events/net.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/net.h b/include/trace/events/net.h
index d55162c12f90..49f9fce69dd7 100644
--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h
@@ -107,16 +107,19 @@ TRACE_EVENT(net_dev_xmit_timeout,
 		__string(	name,		dev->name	)
 		__string(	driver,		netdev_drivername(dev))
 		__field(	int,		queue_index	)
+		__field(	int,		ifindex		)
 	),
 
 	TP_fast_assign(
 		__assign_str(name);
 		__assign_str(driver);
 		__entry->queue_index = queue_index;
+		__entry->ifindex = dev->ifindex;
 	),
 
-	TP_printk("dev=%s driver=%s queue=%d",
-		__get_str(name), __get_str(driver), __entry->queue_index)
+	TP_printk("dev=%s ifindex=%d driver=%s queue=%d",
+		__get_str(name), __entry->ifindex,
+		__get_str(driver), __entry->queue_index)
 );
 
 DECLARE_EVENT_CLASS(net_dev_template,
-- 
2.34.1



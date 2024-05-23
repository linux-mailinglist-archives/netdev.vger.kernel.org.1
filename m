Return-Path: <netdev+bounces-97834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F358CD6DD
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE99283143
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579F1DDBB;
	Thu, 23 May 2024 15:17:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2CAB64C
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477469; cv=none; b=qivJOL9/b+qTw8yJ6nmBF8yKF7fBsST+gRbfZxWFUi1ZrALFw4qqG3/UFu+vP7ufQBwSmvVHyk/0k+8pxjcpicSWndCH2O9xQPKhboBVxYusINrxWQuKJpxQu/wVc+dNIVQe7THXIC4tAohWXNgHy9ejqBCbRCvS+hQjvBpvALM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477469; c=relaxed/simple;
	bh=k/1Irs1LXo0gg6+RNfJ+PNigWM3S0qjA8tzgRVBpNzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XG52tY1niSTAOBM746+9nUJcU/977eqmNXRJ0Iqm+hodrVS2WTXB0LKp9ydK/53ENSLCRbIoGZccgENBY2ruVNOdd5vgC2iAMX5Sxaj3LxksJ2IV/8AKdp0rVwZUQPewL5k8R5lrL2oegGVEzdJLgRwisBx2fX0VTYI/NtUvyGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from coffee.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	by smtp.chopps.org (Postfix) with ESMTP id 85DC67D12A
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:17:47 +0000 (UTC)
Received: by coffee.chopps.org (Postfix, from userid 1004)
	id 63BB0180EAC; Thu, 23 May 2024 11:17:47 -0400 (EDT)
X-Spam-Level: 
Received: from labnh.int.chopps.org (labnh.int.chopps.org [192.168.2.80])
	by coffee.chopps.org (Postfix) with ESMTP id 4205C180EA9;
	Thu, 23 May 2024 11:17:46 -0400 (EDT)
Received: by labnh.int.chopps.org (Postfix, from userid 1000)
	id 3EF5AC035DA30; Thu, 23 May 2024 11:17:46 -0400 (EDT)
From: Christian Hopps <chopps@labn.net>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	devel@linux-ipsec.org,
	Christian Hopps <chopps@chopps.org>,
	Christian Hopps <chopps@labn.net>
Subject: [PATCH iproute-next v1 2/2] xfrm: document new SA direction option
Date: Thu, 23 May 2024 11:17:07 -0400
Message-ID: <20240523151707.972161-3-chopps@labn.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523151707.972161-1-chopps@labn.net>
References: <20240523151707.972161-1-chopps@labn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Christian Hopps <chopps@labn.net>
---
 man/man8/ip-xfrm.8 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/man/man8/ip-xfrm.8 b/man/man8/ip-xfrm.8
index 6dc73d23..960779dd 100644
--- a/man/man8/ip-xfrm.8
+++ b/man/man8/ip-xfrm.8
@@ -36,6 +36,8 @@ ip-xfrm \- transform configuration
 .IR MASK " ] ]"
 .RB "[ " reqid
 .IR REQID " ]"
+.RB "[ " dir
+.IR SA-DIR " ]"
 .RB "[ " seq
 .IR SEQ " ]"
 .RB "[ " replay-window
@@ -165,6 +167,10 @@ ip-xfrm \- transform configuration
 .IR MODE " := "
 .BR transport " | " tunnel " | " beet " | " ro " | " in_trigger
 
+.ti -8
+.IR SA-DIR " := "
+.BR in " | " out
+
 .ti -8
 .IR FLAG-LIST " := [ " FLAG-LIST " ] " FLAG
 
-- 
2.45.1



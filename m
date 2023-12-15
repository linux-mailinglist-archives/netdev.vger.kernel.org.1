Return-Path: <netdev+bounces-58130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661D81536B
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 23:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90881C227AC
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 22:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934813B137;
	Fri, 15 Dec 2023 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="PfglqscU"
X-Original-To: netdev@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3547E18EA2
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CV1vr3m4fIZLwK9vwKjpVvscJsUuZPyG2bxDFrBslGo=; b=PfglqscUPH4XKj+VnaQ6xpCpA/
	JQh6/ssiN35B/Rb82bN00F0b3Y5vCSAR8fZImVJ+ianhdyioodUCJ58S8n67C4s9zqTCLo1ZRaBhk
	lkaBO/Nyd0+LkVr+ULguuazGpSds61+9vh9/9l2ZIlD1XPPZzriTbEiHWYBh1jT9A3E2+aWWkkSEU
	Q7emMq8OiZw50II8BlAe8afXB13Oz4vkDfHs6qLoxC1284UwDKXumRcvWSByTZNLvx+q3OzMokbqQ
	EOWU/rKmoXQiNUppe7exm7tw0M6UIBDzzV2U92+UHTtmNfSN1wI6IgeaUaJ/Q9fYIU2pkIStHOFJa
	z6GvFEng==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.94.2)
	(envelope-from <phil@nwl.cc>)
	id 1rEGWl-0001nU-6s; Fri, 15 Dec 2023 23:19:27 +0100
From: Phil Sutter <phil@nwl.cc>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Gioele Barabucci <gioele@svario.it>,
	netdev@vger.kernel.org
Subject: [iproute2 PATCH 1/2] man: ip-route.8: Fix typo in rt_protos location spec
Date: Fri, 15 Dec 2023 23:19:22 +0100
Message-ID: <20231215221923.24582-1-phil@nwl.cc>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RTPROTO description erroneously specified /etc/iproute2/rt_protos twice.

Fixes: 0a0a8f12fa1b0 ("Read configuration files from /etc and /usr")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 man/man8/ip-route.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 7a97d7447c6de..f9ed4918cd1e8 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -652,7 +652,7 @@ routes.
 the routing protocol identifier of this route.
 .I RTPROTO
 may be a number or a string from
-.BR "@SYSCONF_ETC_DIR@/rt_protos" or
+.BR "@SYSCONF_USR_DIR@/rt_protos" or
 .BR "@SYSCONF_ETC_DIR@/rt_protos" (has precedence if exists).
 If the routing protocol ID is not given,
 .B ip assumes protocol
-- 
2.43.0



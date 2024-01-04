Return-Path: <netdev+bounces-61557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7A082441C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29897285958
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF24219F1;
	Thu,  4 Jan 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaoAXmVC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D5223748
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67EFC433C7;
	Thu,  4 Jan 2024 14:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704379737;
	bh=Af7DdT5eEMauDDunfnrEyj1hkMu+AsMRi5DPlO86amc=;
	h=From:To:Cc:Subject:Date:From;
	b=LaoAXmVCe4EQuZQRgM2DIAhSexnPRdd349h66namuflcYQdcDlMqy4CupILMCUsTk
	 AgpyintPQLieoslYqaFYQMhQKsmGraOcTGLjbKlHaBhmzpnxDLv6gJ9VnHBn7vqiE1
	 zFX2sSxUiMxyE+1Ft22L+XIZHBeewbESILA+7fxUSdpnbhsDGFdHQDl1BKaWa1s3IU
	 rQEduB5HtNj/SWAFYQYJCo6lVY6f7MiMj2mH/vWzsc6Qy5d6mWf5zU4/C8TOCdGOk6
	 jP0+Hr/roQ02voZNn6YL7PVv2GNLpnDsPEm1z+tkvnNtlvJoMMwPpWChIUzSi8Gm5U
	 UIJtUCwJmAytw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	axboe@kernel.dk,
	kuniyu@amazon.com,
	dhowells@redhat.com,
	kbusch@kernel.org,
	syoshida@redhat.com
Subject: [PATCH net-next] net: fill in MODULE_DESCRIPTION()s for CAIF
Date: Thu,  4 Jan 2024 06:48:55 -0800
Message-ID: <20240104144855.1320993-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to all the CAIF sub-modules.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: axboe@kernel.dk
CC: kuniyu@amazon.com
CC: dhowells@redhat.com
CC: kbusch@kernel.org
CC: syoshida@redhat.com
---
 net/caif/caif_dev.c    | 1 +
 net/caif/caif_socket.c | 1 +
 net/caif/caif_usb.c    | 1 +
 net/caif/chnl_net.c    | 1 +
 4 files changed, 4 insertions(+)

diff --git a/net/caif/caif_dev.c b/net/caif/caif_dev.c
index 6a0cba4fc29f..24e85c5487ef 100644
--- a/net/caif/caif_dev.c
+++ b/net/caif/caif_dev.c
@@ -27,6 +27,7 @@
 #include <net/caif/cfcnfg.h>
 #include <net/caif/cfserl.h>
 
+MODULE_DESCRIPTION("ST-Ericsson CAIF modem protocol support");
 MODULE_LICENSE("GPL");
 
 /* Used for local tracking of the CAIF net devices */
diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index 9c82698da4f5..039dfbd367c9 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -27,6 +27,7 @@
 #include <net/caif/caif_dev.h>
 #include <net/caif/cfpkt.h>
 
+MODULE_DESCRIPTION("ST-Ericsson CAIF modem protocol socket support (AF_CAIF)");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(AF_CAIF);
 
diff --git a/net/caif/caif_usb.c b/net/caif/caif_usb.c
index bf61ea4b8132..5dc05a1e3178 100644
--- a/net/caif/caif_usb.c
+++ b/net/caif/caif_usb.c
@@ -20,6 +20,7 @@
 #include <net/caif/cfpkt.h>
 #include <net/caif/cfcnfg.h>
 
+MODULE_DESCRIPTION("ST-Ericsson CAIF modem protocol USB support");
 MODULE_LICENSE("GPL");
 
 #define CFUSB_PAD_DESCR_SZ 1	/* Alignment descriptor length */
diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
index f35fc87c453a..47901bd4def1 100644
--- a/net/caif/chnl_net.c
+++ b/net/caif/chnl_net.c
@@ -31,6 +31,7 @@
 /*This list is protected by the rtnl lock. */
 static LIST_HEAD(chnl_net_list);
 
+MODULE_DESCRIPTION("ST-Ericsson CAIF modem protocol GPRS network device");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_RTNL_LINK("caif");
 
-- 
2.43.0



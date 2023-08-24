Return-Path: <netdev+bounces-30171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7CF786443
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0011C20DA9
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 00:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E22515B7;
	Thu, 24 Aug 2023 00:31:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFEE17F3
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72902C433C8;
	Thu, 24 Aug 2023 00:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692837064;
	bh=OjWxWKSpGH2kApUXX5KAd9aLtW9yUX4FCMC+ee0zIgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0R4lbwsidXe8RqiB2NrCrjY9M0MTVtQ5vHpgKNcxrWMSveviMyHjMcBGqd/qWZBk
	 RiqIHpoctuI5TWf7bezNCWaCXCNjW0MfXVa3WgjoUWEibgqwIpkqQ0ErNfCTjzEvVW
	 lW2xp99CifO6XSj3OQVDDKQ9E+fjOIK9By4qSnD40r4cvTFg8KHp7DvrjK032UyNpP
	 NDGBqUqrPR83Rg/7uex2pnQmJH1tw75cehmAxKy3nZ3E3OnmjfVjJJNNu1HrZoSMiP
	 cN1ZtJtFsvS8ZGXSDmKZX5n4X4BAIkU6DptxyUtozW5qNz5azGOn3e5a2NgjQvoxNe
	 HKuMVchQAw2VA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] tools: ynl-gen: set length of binary fields
Date: Wed, 23 Aug 2023 17:30:53 -0700
Message-ID: <20230824003056.1436637-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824003056.1436637-1-kuba@kernel.org>
References: <20230824003056.1436637-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remember to set the length field in the request setters.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/generated/ethtool-user.h | 4 ++++
 tools/net/ynl/generated/fou-user.h     | 6 ++++++
 tools/net/ynl/ynl-gen-c.py             | 1 +
 3 files changed, 11 insertions(+)

diff --git a/tools/net/ynl/generated/ethtool-user.h b/tools/net/ynl/generated/ethtool-user.h
index d7d4ba855f43..ddc1a5209992 100644
--- a/tools/net/ynl/generated/ethtool-user.h
+++ b/tools/net/ynl/generated/ethtool-user.h
@@ -1422,6 +1422,7 @@ ethtool_wol_set_req_set_sopass(struct ethtool_wol_set_req *req,
 			       const void *sopass, size_t len)
 {
 	free(req->sopass);
+	req->_present.sopass_len = len;
 	req->sopass = malloc(req->_present.sopass_len);
 	memcpy(req->sopass, sopass, req->_present.sopass_len);
 }
@@ -4071,6 +4072,7 @@ ethtool_fec_set_req_set_stats_corrected(struct ethtool_fec_set_req *req,
 					const void *corrected, size_t len)
 {
 	free(req->stats.corrected);
+	req->stats._present.corrected_len = len;
 	req->stats.corrected = malloc(req->stats._present.corrected_len);
 	memcpy(req->stats.corrected, corrected, req->stats._present.corrected_len);
 }
@@ -4079,6 +4081,7 @@ ethtool_fec_set_req_set_stats_uncorr(struct ethtool_fec_set_req *req,
 				     const void *uncorr, size_t len)
 {
 	free(req->stats.uncorr);
+	req->stats._present.uncorr_len = len;
 	req->stats.uncorr = malloc(req->stats._present.uncorr_len);
 	memcpy(req->stats.uncorr, uncorr, req->stats._present.uncorr_len);
 }
@@ -4087,6 +4090,7 @@ ethtool_fec_set_req_set_stats_corr_bits(struct ethtool_fec_set_req *req,
 					const void *corr_bits, size_t len)
 {
 	free(req->stats.corr_bits);
+	req->stats._present.corr_bits_len = len;
 	req->stats.corr_bits = malloc(req->stats._present.corr_bits_len);
 	memcpy(req->stats.corr_bits, corr_bits, req->stats._present.corr_bits_len);
 }
diff --git a/tools/net/ynl/generated/fou-user.h b/tools/net/ynl/generated/fou-user.h
index d8ab50579cd1..a8f860892540 100644
--- a/tools/net/ynl/generated/fou-user.h
+++ b/tools/net/ynl/generated/fou-user.h
@@ -91,6 +91,7 @@ fou_add_req_set_local_v6(struct fou_add_req *req, const void *local_v6,
 			 size_t len)
 {
 	free(req->local_v6);
+	req->_present.local_v6_len = len;
 	req->local_v6 = malloc(req->_present.local_v6_len);
 	memcpy(req->local_v6, local_v6, req->_present.local_v6_len);
 }
@@ -99,6 +100,7 @@ fou_add_req_set_peer_v6(struct fou_add_req *req, const void *peer_v6,
 			size_t len)
 {
 	free(req->peer_v6);
+	req->_present.peer_v6_len = len;
 	req->peer_v6 = malloc(req->_present.peer_v6_len);
 	memcpy(req->peer_v6, peer_v6, req->_present.peer_v6_len);
 }
@@ -192,6 +194,7 @@ fou_del_req_set_local_v6(struct fou_del_req *req, const void *local_v6,
 			 size_t len)
 {
 	free(req->local_v6);
+	req->_present.local_v6_len = len;
 	req->local_v6 = malloc(req->_present.local_v6_len);
 	memcpy(req->local_v6, local_v6, req->_present.local_v6_len);
 }
@@ -200,6 +203,7 @@ fou_del_req_set_peer_v6(struct fou_del_req *req, const void *peer_v6,
 			size_t len)
 {
 	free(req->peer_v6);
+	req->_present.peer_v6_len = len;
 	req->peer_v6 = malloc(req->_present.peer_v6_len);
 	memcpy(req->peer_v6, peer_v6, req->_present.peer_v6_len);
 }
@@ -280,6 +284,7 @@ fou_get_req_set_local_v6(struct fou_get_req *req, const void *local_v6,
 			 size_t len)
 {
 	free(req->local_v6);
+	req->_present.local_v6_len = len;
 	req->local_v6 = malloc(req->_present.local_v6_len);
 	memcpy(req->local_v6, local_v6, req->_present.local_v6_len);
 }
@@ -288,6 +293,7 @@ fou_get_req_set_peer_v6(struct fou_get_req *req, const void *peer_v6,
 			size_t len)
 {
 	free(req->peer_v6);
+	req->_present.peer_v6_len = len;
 	req->peer_v6 = malloc(req->_present.peer_v6_len);
 	memcpy(req->peer_v6, peer_v6, req->_present.peer_v6_len);
 }
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index bdff8dfc29c9..e27deb199a70 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -428,6 +428,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
     def _setter_lines(self, ri, member, presence):
         return [f"free({member});",
+                f"{presence}_len = len;",
                 f"{member} = malloc({presence}_len);",
                 f'memcpy({member}, {self.c_name}, {presence}_len);']
 
-- 
2.41.0



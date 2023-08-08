Return-Path: <netdev+bounces-25550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A4F7749FA
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B701C20F19
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B80A168D7;
	Tue,  8 Aug 2023 20:09:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B28F69
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2479C433C7;
	Tue,  8 Aug 2023 20:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691525351;
	bh=+QP396W+Pc0eZFfdVrAcHaBr80FpvCdeqwy+r2gx0So=;
	h=From:To:Cc:Subject:Date:From;
	b=YXMl2rovB4VglrxsvdAGxuKN7mXOZ7nBD/Z+QIcZe0mL90Ise0libdL9mXwdnLg8P
	 ggGv1MHtctsPoVCKXZAjOeRAYbTHLyKTUmLdm5E4Ovqb1vp0OdPofBfzqRvxvTR7PK
	 oeB68nj82aWE3WrCITR6mMHt62nmEsHZ3fhwUeXBq/pVij+4ehFSC94GGF/usF43cM
	 7L9c6HVGMH8RyXP4r89UbsZd6LsLYsTMw1ssCg/viwvnHubclrEXwmANt9ACVp9Pw4
	 nDGBfCcchNqrrIP3SJmh3/FjoVcyct0E92nWN5dyg9PPrZ1CXQYMZbUNMX49c3zaM9
	 XhUhqDQgk4PIA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next] tools: ynl-gen: add missing empty line between policies
Date: Tue,  8 Aug 2023 13:09:07 -0700
Message-ID: <20230808200907.1290647-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're missing empty line between policies.
DPLL will need this.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: vadim.fedorenko@linux.dev
---
 tools/net/ynl/ynl-gen-c.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index e64311331726..85cf159d3074 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1871,6 +1871,7 @@ _C_KW = {
     for _, arg in struct.member_list():
         arg.attr_policy(cw)
     cw.p("};")
+    cw.nl()
 
 
 def kernel_can_gen_family_struct(family):
-- 
2.41.0



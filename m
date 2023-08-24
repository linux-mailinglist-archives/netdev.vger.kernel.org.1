Return-Path: <netdev+bounces-30172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B63A786444
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7BF1C20CD8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 00:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7E317D2;
	Thu, 24 Aug 2023 00:31:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3949291E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9C1C433C7;
	Thu, 24 Aug 2023 00:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692837066;
	bh=WnDbJhw2sxL+KT5WFYx0xN7dPmCUPw/Sc0nR65WS0Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ednJMvEGgSXoPuEXkF6RQmn7G2IDkFo2ejssum5TwCjkFz1xlUDerEQkk/A3WB09d
	 rmB3cmsP9Ob3ESiGUa9Lyi0ydek2yZ0kfx2YEB8hLqcaRurXsNabvwDvGGK9HTR2Ar
	 0Op947HuIx7/XcGy/PZjP60hyFzB+s1EPNwUurtN0x/3UUAJfaBbRalFCSU+Xr1C5z
	 Lgud9DgySC/9Amc5JHOaaLyw+8HGFs3Xsm29tDHimnXMPS6xDeGGRShrnlKJC5lkkh
	 SAHLf//sz5BvH+saHzynIer1aR+cAl4HsFGqbKF0QVMz6dNPZ7LS0Se6vtpmTD03wN
	 3eKMpvnx1skXA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] netlink: specs: fix indent in fou
Date: Wed, 23 Aug 2023 17:30:56 -0700
Message-ID: <20230824003056.1436637-6-kuba@kernel.org>
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

Fix up the indentation. This has no functional effect, AFAICT.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/fou.yaml | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 3e13826a3fdf..0af5ab842c04 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -107,16 +107,16 @@ kernel-policy: global
       flags: [ admin-perm ]
 
       do:
-        request:  &select_attrs
+        request: &select_attrs
           attributes:
-          - af
-          - ifindex
-          - port
-          - peer_port
-          - local_v4
-          - peer_v4
-          - local_v6
-          - peer_v6
+            - af
+            - ifindex
+            - port
+            - peer_port
+            - local_v4
+            - peer_v4
+            - local_v6
+            - peer_v6
 
     -
       name: get
-- 
2.41.0



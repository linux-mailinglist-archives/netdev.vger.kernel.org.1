Return-Path: <netdev+bounces-31661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7C178F6DD
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 03:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274F91C20B2B
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201710E3;
	Fri,  1 Sep 2023 01:51:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB11842
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 01:51:30 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 939D310F2;
	Thu, 31 Aug 2023 18:51:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 0628260338E84;
	Fri,  1 Sep 2023 09:51:07 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?net/socket:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20used?=
Date: Sun,  3 Sep 2023 02:22:28 +0800
Message-Id: <20230902182228.3124-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
	RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

used is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..743e54eba06f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -569,12 +569,12 @@ static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
 				size_t size)
 {
 	ssize_t len;
-	ssize_t used = 0;
+	ssize_t used;
 
 	len = security_inode_listsecurity(d_inode(dentry), buffer, size);
 	if (len < 0)
 		return len;
-	used += len;
+	used = len;
 	if (buffer) {
 		if (size < used)
 			return -ERANGE;
-- 
2.18.2



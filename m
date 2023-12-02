Return-Path: <netdev+bounces-53210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36846801A20
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B4A1F210A0
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46541C26;
	Sat,  2 Dec 2023 02:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20566E6
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 18:47:16 -0800 (PST)
From: Sam James <sam@gentoo.org>
To: netdev@vger.kernel.org
Cc: Sam James <sam@gentoo.org>
Subject: [iproute2 PATCH] configure: Add _GNU_SOURCE to strlcpy configure test
Date: Sat,  2 Dec 2023 02:47:04 +0000
Message-ID: <20231202024705.1375296-1-sam@gentoo.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>=glibc-2.38 adds strlcpy but it's guarded under a feature-test macro. Just
add _GNU_SOURCE to the configure test because we already pass _GNU_SOURCE unconditionally
in the Makefiles when building iproute2.

Signed-off-by: Sam James <sam@gentoo.org>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index eb689341..78bc52c0 100755
--- a/configure
+++ b/configure
@@ -445,6 +445,7 @@ EOF
 check_strlcpy()
 {
     cat >$TMPDIR/strtest.c <<EOF
+#define _GNU_SOURCE
 #include <string.h>
 int main(int argc, char **argv) {
 	char dst[10];
-- 
2.43.0



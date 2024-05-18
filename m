Return-Path: <netdev+bounces-97120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B528C92FF
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 00:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D155D1F21397
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 22:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9010854FBD;
	Sat, 18 May 2024 22:46:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74E12BB10
	for <netdev@vger.kernel.org>; Sat, 18 May 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.189.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716072378; cv=none; b=S75SA9RFjKrfYk1tdl2HsG4BGa5vWa7u9xFUog1tE5ejNDPRvdPdhHM1sRW/ZLaqz49bs24OHnagzECWYL1GVToiYm5SXFHDQZ5oJN00CF+Ij/ypoCk1pIeMkSg3IXLSvm+QQtIEbf1jj31jedC6YX918ZnfVB4VB1vuHaD9MiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716072378; c=relaxed/simple;
	bh=3msDpjBa/95VOPvvgmY/ZcvR11TsRKP+4LMG5M+NzfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJBpotwK8R+crKaBS+lKoOrLnFCV6QPiRL2Hvi1QXWuNxIJhO2odBW4GFWpestLZyGxqGhjDxxukAz3PvWTvXrSLLHUzadIsetd5O1RuEamWwehfDTI/ACGyMVO0U7i/N3bgkYdfTWtrq5HCsVQ6oCVi+uyBK+jaHpJdTLyJdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk; spf=pass smtp.mailfrom=iodev.co.uk; arc=none smtp.client-ip=46.30.189.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iodev.co.uk
Received: from localhost (222.red-83-46-228.dynamicip.rima-tde.net [83.46.228.222])
	by iodev.co.uk (Postfix) with ESMTPSA id CEF552E34C2;
	Sun, 19 May 2024 00:39:53 +0200 (CEST)
From: Ismael Luceno <ismael@iodev.co.uk>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Ismael Luceno <ismael@iodev.co.uk>
Subject: [iproute2 PATCH] Fix usage of poll.h header
Date: Sun, 19 May 2024 00:39:44 +0200
Message-ID: <20240518223946.22032-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the legacy <sys/poll.h> to <poll.h> (POSIX.1-2001).

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 misc/arpd.c   | 2 +-
 misc/ifstat.c | 2 +-
 misc/nstat.c  | 2 +-
 misc/rtacct.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc/arpd.c b/misc/arpd.c
index 65ac6a3828e6..3185620f7a74 100644
--- a/misc/arpd.c
+++ b/misc/arpd.c
@@ -14,7 +14,7 @@
 #include <netdb.h>
 #include <db_185.h>
 #include <sys/ioctl.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/uio.h>
diff --git a/misc/ifstat.c b/misc/ifstat.c
index 9b93ded32a61..faebe938e598 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -17,7 +17,7 @@
 #include <sys/file.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <signal.h>
diff --git a/misc/nstat.c b/misc/nstat.c
index 07d010dec35f..fce3e9c1ec79 100644
--- a/misc/nstat.c
+++ b/misc/nstat.c
@@ -17,7 +17,7 @@
 #include <sys/file.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <signal.h>
diff --git a/misc/rtacct.c b/misc/rtacct.c
index 08363bfd4f26..cd84b7f06b9b 100644
--- a/misc/rtacct.c
+++ b/misc/rtacct.c
@@ -16,7 +16,7 @@
 #include <sys/file.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
-- 
2.44.0



Return-Path: <netdev+bounces-76762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D41C86ED14
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 00:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAA42829FC
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 23:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20BE5F47B;
	Fri,  1 Mar 2024 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s23T2qcX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A1F5F479
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709337373; cv=none; b=jaroRQXIalCi6YMjvdz5vMsmL+mB01qU0VThZRHTD+DYmfGHMSPod4pAn8xfi3PYtHQ2ineQpMt7MiWYi5yKjVFLMi8uQllsGnXEuNRdFgZ+iC/Vc1NtnVuLi18DNu7VhMTCIqKFb/cKDPAZjN/u0JidqnoBA6FYp84JPdJmvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709337373; c=relaxed/simple;
	bh=eMPw+X9ZW5/xrSdloZr+aODe/j/fdzWw7phrET6UWtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/c4HYcKbbyfMCOT98EjjUIpAT2hnTAQMqAKGR6RXjSgOGKlD5nZO8dT0RapUl+VKVNTndBSYwe1Ri4jZ3575mir4G1k6CwK3Bn5lZEQbx7yDwta/Yt/jT+/UulUjVb6qZR80eJArWd9ZQdk+pkq8g9WI4mfBeMcrp7mfv22c0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s23T2qcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E467BC433B1;
	Fri,  1 Mar 2024 23:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709337373;
	bh=eMPw+X9ZW5/xrSdloZr+aODe/j/fdzWw7phrET6UWtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s23T2qcXEznY6MEMAJ1EBmArfXQpKiW3gIqaV10/BYmmKHxJj3CFIlKTLlIfSBv/d
	 uzBnmvdhzTGHNg533sbo42LiI8jg6kf/DYnPwtb490jUWzyXRq9bJZFmsKhn97gu3q
	 zn135sFvjDvVqqUQ6AtwzPnEk01BamlS3AHinoCGYskQ8oFRK8C0X2Jjxm/5UAbt2+
	 0z0FemRp0UHJHzOfwNXKS+EDaHIPv9zCnmNZtRuQoZCxafhTK5SUwCyo/6Gi1dmBAV
	 j5gpe9ZHGWqBsv0SDN610Qa7c/ehIbtpCqNxsWBlmggeLJ+oknd/Wz2dv83RQBLh4E
	 DXmpDJlTNXTWg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] tools: ynl: rename make hardclean -> distclean
Date: Fri,  1 Mar 2024 15:56:08 -0800
Message-ID: <20240301235609.147572-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301235609.147572-1-kuba@kernel.org>
References: <20240301235609.147572-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The make target to remove all generated files used to be called
"hardclean" because it deleted files which were tracked by git.
We no longer track generated user space files, so use the more
common "distclean" name.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/Makefile           | 2 +-
 tools/net/ynl/generated/Makefile | 4 ++--
 tools/net/ynl/lib/Makefile       | 2 +-
 tools/net/ynl/samples/Makefile   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index da1aa10bbcc3..1874296665e1 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -11,7 +11,7 @@ samples: | lib generated
 		$(MAKE) -C $@ ; \
 	fi
 
-clean hardclean:
+clean distclean:
 	@for dir in $(SUBDIRS) ; do \
 		if [ -f "$$dir/Makefile" ] ; then \
 			$(MAKE) -C $$dir $@; \
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 7135028cb449..713f5fb9cc2d 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -43,11 +43,11 @@ protos.a: $(OBJS)
 clean:
 	rm -f *.o
 
-hardclean: clean
+distclean: clean
 	rm -f *.c *.h *.a
 
 regen:
 	@../ynl-regen.sh
 
-.PHONY: all clean hardclean regen
+.PHONY: all clean distclean regen
 .DEFAULT_GOAL: all
diff --git a/tools/net/ynl/lib/Makefile b/tools/net/ynl/lib/Makefile
index d2e50fd0a52d..2201dafc62b3 100644
--- a/tools/net/ynl/lib/Makefile
+++ b/tools/net/ynl/lib/Makefile
@@ -18,7 +18,7 @@ ynl.a: $(OBJS)
 clean:
 	rm -f *.o *.d *~
 
-hardclean: clean
+distclean: clean
 	rm -f *.a
 
 %.o: %.c
diff --git a/tools/net/ynl/samples/Makefile b/tools/net/ynl/samples/Makefile
index 1d33e98e3ffe..3e81432f7b27 100644
--- a/tools/net/ynl/samples/Makefile
+++ b/tools/net/ynl/samples/Makefile
@@ -28,7 +28,7 @@ $(BINS): ../lib/ynl.a ../generated/protos.a $(SRCS)
 clean:
 	rm -f *.o *.d *~
 
-hardclean: clean
+distclean: clean
 	rm -f $(BINS)
 
 .PHONY: all clean
-- 
2.44.0



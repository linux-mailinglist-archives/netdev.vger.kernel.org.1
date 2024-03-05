Return-Path: <netdev+bounces-77342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4616987152F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF184283D38
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53EC45977;
	Tue,  5 Mar 2024 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtL+HWOL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0045953
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615616; cv=none; b=ctrVMjLsph1sU8t7/xtEJEwGtCMkdjrcOa1B9MxTE6IiLjG7J11nv1NmjEj19kfv32hLaD9dHBGWP2Q7cLDRQNyXoqZJsytNGVniJecLDlGM2nI3DcJJHrF5zeq6jG8n89zY82pQwcQijohXKZAbtYo6oZIrQ7AjHbnZhMcpcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615616; c=relaxed/simple;
	bh=eMPw+X9ZW5/xrSdloZr+aODe/j/fdzWw7phrET6UWtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYEwoWADvQ70YbPjulO2Su3a2AC3kPchbfMbNxlO5pM/nJ7UCW5ULXLnIaOoj2OXMWg7S5Ua4FQgSQwMI5kDN4pnvBbFnHCV4jMCtd9DxNH1tiWBgRJQFf2TMkzpTQwFyO110G3945auwm0c1A4AVA6GLtwNhmYi9sTfmC096us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtL+HWOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B3BC43394;
	Tue,  5 Mar 2024 05:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709615616;
	bh=eMPw+X9ZW5/xrSdloZr+aODe/j/fdzWw7phrET6UWtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtL+HWOLoeff9Sm0QqM32ZnVLeNRdYWpz7yPOKPqQPmQegt+L+Gq9L8Nt26tW0DH2
	 moGuw4Adl3hlsllfKK650Kb89VVbe+n38hEfH7J90miWzYhLtaoNkwVrm19210dMmz
	 IpFXEwMynYZi4VMXJQnx4HNsp+j/VR3oLfbiBS0I08XgwvIpg5wQtMLIJKxPRqTnhY
	 nfPL4nVzJ7z4a3jubhPcmA8d9gzAEPO97rwGlTXXKGNCHdYkJ1Cg7YSVQR83ZX4AA3
	 Zspr/1u7uQr5jHjXF7j10auUE3sCDSu94QEmXwwKe2Sgst8ncrunelbpQaEeL9N1BE
	 J9afu4Vudhx4g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/3] tools: ynl: rename make hardclean -> distclean
Date: Mon,  4 Mar 2024 21:13:26 -0800
Message-ID: <20240305051328.806892-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305051328.806892-1-kuba@kernel.org>
References: <20240305051328.806892-1-kuba@kernel.org>
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



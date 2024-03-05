Return-Path: <netdev+bounces-77343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76E871530
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9D91C20F89
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FED046424;
	Tue,  5 Mar 2024 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmJDonHd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACE345BE8
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709615617; cv=none; b=c6n5zYaKaCmtYCiewdnQ2HmgPvNF9Dlvv4X1c84N0ibQ2//LS6dzjuZ1aFxi0ZQ2wNGnM1Yn0JBsPPxAN/1WyDg4ad+F/8agDP0mBFvqATL6EwVRyOR5E6ZP909vdgayOne450ne4mlGmUuAoqYAUAWZQTiKugCzr5Texf9tTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709615617; c=relaxed/simple;
	bh=Ek0LEforhJgdx4L9n4iIabs1ZJbHtn1fikf79vXlfOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTySK3cim4Ieh749QmeMcDVPd2gvA+zm2x/Oxz72CfAO8gCQ9+raDtlteNrpXBG9YEFhu34CMHdTmOKNK47R35fIqCyzUshLJDCfRiKq0Q3W6EId6u3j6pt3fw3IFX71n5AKUdg2jAx2Wv4GSYw8LJX3kNxEc3v1Ejt4Alk1R4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmJDonHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6218CC43390;
	Tue,  5 Mar 2024 05:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709615616;
	bh=Ek0LEforhJgdx4L9n4iIabs1ZJbHtn1fikf79vXlfOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmJDonHdchmzIfgfUVS0L7GWK/xOt7/vXW7NWlMo3KfbFXhjB6Xo4dWk9B2h5RQm3
	 JZkpkS4zkEcxL5BeJuUU9WOPblzNfAO053Tfgh+iOytq878aszOH2YLizaJGSLWp2b
	 LLOOOJULeW0Vpi81rMMVIYiDBsJN7+UqVnpantaoVjIVWFpC/PoMngyG3WMHIUFJhM
	 7RBkVk3ruBmX1a60aLjdhh+eVIpZrONH6Jy4aAVbf+28IbselTuTawUWj7s6s+Q7Vj
	 pHeBiHQtkHfQSnfzKn8x0VSKtE/ndfJc4jJrP18+OnzVKRF2OeD23lamvh2Of6iheT
	 ieOyVy7y/GoAg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/3] tools: ynl: add distclean to .PHONY in all makefiles
Date: Mon,  4 Mar 2024 21:13:27 -0800
Message-ID: <20240305051328.806892-3-kuba@kernel.org>
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

Donald points out most YNL makefiles are missing distclean
in .PHONY, even tho generated/Makefile does list it.

Suggested-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: new patch
---
 tools/net/ynl/Makefile         | 2 +-
 tools/net/ynl/lib/Makefile     | 2 +-
 tools/net/ynl/samples/Makefile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 1874296665e1..8e9e09d84e26 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -18,4 +18,4 @@ samples: | lib generated
 		fi \
 	done
 
-.PHONY: clean all $(SUBDIRS)
+.PHONY: all clean distclean $(SUBDIRS)
diff --git a/tools/net/ynl/lib/Makefile b/tools/net/ynl/lib/Makefile
index 2201dafc62b3..1507833d05c5 100644
--- a/tools/net/ynl/lib/Makefile
+++ b/tools/net/ynl/lib/Makefile
@@ -24,5 +24,5 @@ distclean: clean
 %.o: %.c
 	$(COMPILE.c) -MMD -c -o $@ $<
 
-.PHONY: all clean
+.PHONY: all clean distclean
 .DEFAULT_GOAL=all
diff --git a/tools/net/ynl/samples/Makefile b/tools/net/ynl/samples/Makefile
index 3e81432f7b27..e194a7565861 100644
--- a/tools/net/ynl/samples/Makefile
+++ b/tools/net/ynl/samples/Makefile
@@ -31,5 +31,5 @@ $(BINS): ../lib/ynl.a ../generated/protos.a $(SRCS)
 distclean: clean
 	rm -f $(BINS)
 
-.PHONY: all clean
+.PHONY: all clean distclean
 .DEFAULT_GOAL=all
-- 
2.44.0



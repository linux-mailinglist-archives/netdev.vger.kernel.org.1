Return-Path: <netdev+bounces-91054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557F88B127A
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 20:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F2E1C22D33
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C155168C7;
	Wed, 24 Apr 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqY1UBb0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA514265
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983884; cv=none; b=TAyX1/Lp3BsrgHeocpsFzRIqqYZiLJuWdDrNheO1jDp72CMFdWGE8APR5ETeiJu8cjAOXm/sdC/4ytJXmES059dRmfQkRSz2XZ4xXUD8mld0v5XYvC/glrj0oZfVAaYyOS7jKN1gQpaxVo2GP3wijEhzJW5Hl6MJWi1QmwYPQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983884; c=relaxed/simple;
	bh=/AOw6wR2LJyrWNQChCyGN7XmBuf9TahIurOO+geTM54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ei0ULVpEACbj0JRStsuIMit2F0lKOc5cJIEBScB/WhXiFTNJvVhep9oAIj6jhLKjYEYp/PeS7UTaRJds+fN12FE+H9jZ6Hw+NXg4yJA870UAE8KCz3YJedW+AMzoxgRXEUwf2rUNVcfdjvvoIiL7FtWuH3ifMmLegXq0lul9pfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqY1UBb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993FEC113CD;
	Wed, 24 Apr 2024 18:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713983883;
	bh=/AOw6wR2LJyrWNQChCyGN7XmBuf9TahIurOO+geTM54=;
	h=From:To:Cc:Subject:Date:From;
	b=TqY1UBb0XACPpwYGNFAbOmHbE3tiGXUsmhXKRyb246kgpKbowveJPcNx/ITF2ph3x
	 NiVWVPf0Xee6j+DS+ev0RZtp/7dKcvoAbafShM/pZc4M0cLebbMW2/oeWbayxnrjvm
	 gYakOM3s9aEdIi6mZ7GxCgIelPKKt4cwmAL7voH91irWmuNgEkeGgxsomnSOJlNryb
	 2Tkyw8jkey+EjIJa1wjtuwciScmfb3jqMf3u/xXVItBhiqtfLIRpQ3aVTkEIVjnOGZ
	 5rRTb3nrIqitaFLliEI1qROB+gn4FyIgo+8zP/oWNDxQ8/RxUpLNQJofHIZo9qToOf
	 mWBwyqSpGpjJw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: add an explicit entry for YNL
Date: Wed, 24 Apr 2024 11:37:59 -0700
Message-ID: <20240424183759.4103862-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Donald has been contributing to YNL a lot. Let's create a dedicated
MAINTAINERS entry and add make his involvement official :)

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bddf6784c1f1..b0479ac841ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24482,6 +24482,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/har
 F:	Documentation/admin-guide/LSM/Yama.rst
 F:	security/yama/
 
+YAML NETLINK (YNL)
+M:	Donald Hunter <donald.hunter@gmail.com>
+M:	Jakub Kicinski <kuba@kernel.org>
+F:	Documentation/netlink/
+F:	Documentation/userspace-api/netlink/intro-specs.rst
+F:	Documentation/userspace-api/netlink/specs.rst
+F:	tools/net/ynl/
+
 YEALINK PHONE DRIVER
 M:	Henk Vergonet <Henk.Vergonet@gmail.com>
 L:	usbb2k-api-dev@nongnu.org
-- 
2.44.0



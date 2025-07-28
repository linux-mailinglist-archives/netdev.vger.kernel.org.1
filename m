Return-Path: <netdev+bounces-210588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F1B13F7B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650E13B70CE
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B79B27700C;
	Mon, 28 Jul 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbeGIWVn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA91274671;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718543; cv=none; b=qww0nfCgDiXNqN9RwJxNqh0EqDo6WOvn9+gWnNKX6RJYh+InNIRYRiix6ny2iVdl90jzNAsuhIqWMs7iiXI912iiLbWNhWjXQtnssSVbULShlItZ2gKx4iTUZqVAiFoJPoTY446zT70Ck7uvIlMQ5295AAXvM9msU8i/IQt8rmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718543; c=relaxed/simple;
	bh=I9xfKt4o8uiH29LP7HMJc0AeFwdIlfRvdpCS3v7bSi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEGh5ppZu/qpmaVtE+92Fi7yCL7WT/8Ax78Te2Y8PvfDdVTytCAvRxZI3CkYAorUFEPQTJiMCW5IWRHCM2YPrYB/uWpYmpw3oxiTxcICXvVA470VBTtzgy6GSS++opq1o5t07v5UKsH1o+4OYhdjkO4K9hhhm6NNF6fOmtGNP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbeGIWVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D90FC16AAE;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718542;
	bh=I9xfKt4o8uiH29LP7HMJc0AeFwdIlfRvdpCS3v7bSi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbeGIWVnlZWehVcKLjOJZu2Bty8X8Ic9W+JMytrFnoScOd5VHg1tvQlATG8MFKALr
	 b0IjAeXVGxmiJMt9eSONgrDWxLT0Y8Qso9Kjp5TaoK8b680xn3CubAtxl3XWhgKEIQ
	 HZgS9YEMaLmhVHuuN4yAFgfO4g0BAJc3Cwhm3j0jfU4Zu3icB0mtWeKZJ+w00zKBPv
	 8MJAgouNTqTS5a3s73GX15/Vc/+Unj85ojWsVEJ2CQIduqUXd6jkt7Lcl2/FA4Pt1n
	 dVU9ik1c897bqlac8IMulzWC7Xqf4uOla0oXwB9KgZLM8FtQMFMxH4u1ERMonQ3l5L
	 PQJ2V7KRtyyMA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugQIq-00000000Gd8-1xzg;
	Mon, 28 Jul 2025 18:02:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Message-ID :" <cover.1752076293.git.mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Marco Elver" <elver@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Simon Horman" <horms@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v10 10/14] MAINTAINERS: add netlink_yml_parser.py to linux-doc
Date: Mon, 28 Jul 2025 18:02:03 +0200
Message-ID: <c27f6113ba99e80427a77225d68061b34b6787d0.1753718185.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753718185.git.mchehab+huawei@kernel.org>
References: <cover.1753718185.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

The documentation build depends on the parsing code
at ynl_gen_rst.py. Ensure that changes to it will be c/c
to linux-doc ML and maintainers by adding an entry for
it. This way, if a change there would affect the build,
or the minimal version required for Python, doc developers
may know in advance.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b02127967322..f509a16054ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7202,6 +7202,7 @@ F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
+F:	tools/net/ynl/pyynl/lib/doc_generator.py
 F:	scripts/sphinx-pre-install
 X:	Documentation/ABI/
 X:	Documentation/admin-guide/media/
-- 
2.49.0



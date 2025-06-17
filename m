Return-Path: <netdev+bounces-198469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E67DCADC40C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4321897306
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECAC294A11;
	Tue, 17 Jun 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZyIK/Ta"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47BF28FAB5;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147352; cv=none; b=lxTep79uFI8QE1qVpvRpHCSAtL6D1HZk09fL5vcNRjMRSDaRuna9iwZLmJScNdpMI1c6L0CEwrI45KABR2eepBphrsLc8nqg+tBd+b8ssyqTe8g71iWGAklZ8Ye3X0YmM2Beil5Sbohix5ihFUtMxSNC4x/sCRdzYC4tW4HWb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147352; c=relaxed/simple;
	bh=2wpS1pJgr4e8EIQ3/QK7bcd03hAN/nvcFh7aQufz/C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1+LYKK2WqU6zfQNj8FbcuE1ufO7hgm0ltMaFqeIncpprn5ieHmcRRMjkddWmb6Ce89Vcz1Th9RX9sFuFtLCxRCHL2p3ieLQW20cqpTJuSTpf0CX2FQOH4+YLU2X3OX27qcTh7ZpQKOZkwhHsV7hv2TS0i/YUJyepAHxZauholA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZyIK/Ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A778C4CEFA;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147352;
	bh=2wpS1pJgr4e8EIQ3/QK7bcd03hAN/nvcFh7aQufz/C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZyIK/TalGBKsKZzFsFFlNCwzfFsIiVf9mLw0FUGE1ZoIyqeTHB3mX1VyAgAmjMWA
	 3h9pZAadJU6Pq4URI3Ukz9AWepHXnlWCoRcOmespX3Tj9THY+FpUUhcEvHEm/pBcZ+
	 +FSLWy/qn2FgCJU5l3bR/+WgfJV25zBbtZPW4Ox2VU8aEFEiwaKkxMcet9VqWSZTN6
	 QVnC4xgeb6nrGArVP/JS41VtGyjUDhOS+KV1zzkltB/Tc3M6UelGzCas5T6fnyJUbu
	 5p6uLK47lrM6k6EhRJksY50sHw6a8VUsZBtkeQdvUj/KhttLcSjpKzVfQJTY2Pt1LJ
	 IPlOToNcYTimA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRRH4-00000001vdk-1Gaq;
	Tue, 17 Jun 2025 10:02:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v5 15/15] MAINTAINERS: add netlink_yml_parser.py to linux-doc
Date: Tue, 17 Jun 2025 10:02:12 +0200
Message-ID: <0db3a4962bfba8eca4a7e0404331ce1398701f5d.1750146719.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750146719.git.mchehab+huawei@kernel.org>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The documentation build depends on the parsing code
at ynl_gen_rst.py. Ensure that changes to it will be c/c
to linux-doc ML and maintainers by adding an entry for
it. This way, if a change there would affect the build,
or the minimal version required for Python, doc developers
may know in advance.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..caa3425e5755 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7202,6 +7202,7 @@ F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
+F:	tools/net/ynl/pyynl/netlink_yml_parser.py
 F:	scripts/sphinx-pre-install
 X:	Documentation/ABI/
 X:	Documentation/admin-guide/media/
-- 
2.49.0



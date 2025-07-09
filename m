Return-Path: <netdev+bounces-205481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57192AFEE6D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1E2A1C463AB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF92EAB91;
	Wed,  9 Jul 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmOxka+b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF12E9EC5;
	Wed,  9 Jul 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076749; cv=none; b=R/+dYrbU8NLXDDaodTS2JqZWirncHGMSm7K7E1LPm9eZpRjJvrK4SbZlH1sTLnbhwMfV2jvxJc1AmM1rO5aoOBjU7xgWPce8tZe58eG6HQIfCacalz2GgFy8ydZLj6DmFQx/dVtK3lqHz132ktb2AsN3tsyeM8j0n7B7pwWxxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076749; c=relaxed/simple;
	bh=/8GKUg/hE6EZzmvBGeqtvN5XqiYkoQRfu9Nd+64B7DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uv9Lwx81oLsMDG6dCJXVjf+V5syJHZ7N14D47tQjMf0t1DixBwoPEBYHsJqlF/GSFgF8d4WrY0iX7BlQC6tNnzgSOn6baQwOKUZPnaf/aPzSPOF562N7G2fKRyZt37BqXlBR4FubEmI9KwqVJMmRUsyCBdefxLdaxCZm8ztln68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmOxka+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F08C4CEF8;
	Wed,  9 Jul 2025 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076748;
	bh=/8GKUg/hE6EZzmvBGeqtvN5XqiYkoQRfu9Nd+64B7DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmOxka+bI7KroNYOGk0WD8PzyPh94QQKEqSL3TAvGOzHeGC77Eg2d5DZWWJAgLqbr
	 ObAVEbYcppNLLAIZW/DkFZfg0gbgLj9XMD3nrKypI1g+cttp5LX85mRblSR0ivGUX8
	 udlQEZUff7Rn1UZjTVNBLEUCKCgpkoy1qenyZ0Tf0JrNXWuGWN6d3xqbefTyTLSEhk
	 5cRti9DzBBeB1obNdshUECXV8tePkayEJ7JTnjm53rT7T47pRrDkPyQvHTwIh15EAO
	 9YcfuLqMWueh69M64cDBBLD4fCgdP8eXUjSFjZHe1HaK8X+amROClrurSsuHKDdiry
	 rKcTpNuYFfVxQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZXCJ-00000000IhQ-290f;
	Wed, 09 Jul 2025 17:59:03 +0200
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
	"Paolo Abeni" <pabeni@redhat.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v9 13/13] docs: parser_yaml.py: fix backward compatibility with old docutils
Date: Wed,  9 Jul 2025 17:58:57 +0200
Message-ID: <27a53891fe151c97abd349ee7923892373c6d3a7.1752076293.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752076293.git.mchehab+huawei@kernel.org>
References: <cover.1752076293.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

As reported by Akira, older docutils versions are not compatible
with the way some Sphinx versions send tab_width. Add a code to
address it.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-doc/598b2cb7-2fd7-4388-96ba-2ddf0ab55d2a@gmail.com/
Tested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parser_yaml.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/sphinx/parser_yaml.py b/Documentation/sphinx/parser_yaml.py
index 8288e2ff7c7c..1602b31f448e 100755
--- a/Documentation/sphinx/parser_yaml.py
+++ b/Documentation/sphinx/parser_yaml.py
@@ -77,6 +77,10 @@ class YamlParser(Parser):
 
                 result.append(line, document.current_source, lineoffset)
 
+            # Fix backward compatibility with docutils < 0.17.1
+            if "tab_width" not in vars(document.settings):
+                document.settings.tab_width = 8
+
             rst_parser = RSTParser()
             rst_parser.parse('\n'.join(result), document)
 
-- 
2.49.0



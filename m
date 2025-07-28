Return-Path: <netdev+bounces-210584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DFEB13F78
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763213B6431
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C5A276030;
	Mon, 28 Jul 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXJSLu6L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17192741C2;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718542; cv=none; b=Jj8ocLNtAeJurhFXDF3CXHskg1ETeGYQQPZbLkAHvw3TaB7i1vcDs1aaM0o4nZi5Ztsj+Kx7FDXrbrDvMzG/gLZ4GoBYBDBvRRnogPKEb2LQkyAAXhmdUZzS7re0iQgUKYalgp5HD9yLp6h6VZXwbJ3O3at018JkKsKc5dMKZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718542; c=relaxed/simple;
	bh=/8GKUg/hE6EZzmvBGeqtvN5XqiYkoQRfu9Nd+64B7DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTfucKgjp/swqIuxjgXHtLvewWtA3VL0GYngopJOiZq04XVyjlwqbll0nts8bXl0twNxX0ZifVCEg1acFk4UpT+eEzrxTih/aeAG9+eTtWRDw4R+2hbKTn/JDx12AxhJZpe0/N6/wq2nEXN1Dppi+iPqUKUe3aJ/Mrg9u8dWNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXJSLu6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3865DC2BC87;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718542;
	bh=/8GKUg/hE6EZzmvBGeqtvN5XqiYkoQRfu9Nd+64B7DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXJSLu6LcGij5t1mTm16tztOBw7o78gJBAacpUCeCkX6tUKYT4GjlZbIzWHYIpUAA
	 nybwD/1FjADUS3DODns7P1MwMwuNDLtfFUtEh7Pnb4x/7fuSuALk2TGQm2NeUQpcWw
	 Luh6NXdK1ZOMYxEO+7ysOe5/31dh2Uqg6KIjKSQ8iLh86trwXhKn04WxbN0mddq3Ki
	 abs3u2qVI4gmcWQtbOgxvAgvYWOxZHOsW4eAJSfTrBOObqABB+T856ZOHXKEpr1Vk1
	 rpPXEhmijg6lyDz4ovQUpueDQwWDPpKBIxoQ8itWmURbtTHmEmtciwSAQ2OWG0PUF4
	 +aMJypVaoo1wQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugQIq-00000000GdH-2IKi;
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
Subject: [PATCH v10 13/14] docs: parser_yaml.py: fix backward compatibility with old docutils
Date: Mon, 28 Jul 2025 18:02:06 +0200
Message-ID: <9715e41c91302e2b8a9baf349903f3fcff726295.1753718185.git.mchehab+huawei@kernel.org>
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



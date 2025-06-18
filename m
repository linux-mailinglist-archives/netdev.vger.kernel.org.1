Return-Path: <netdev+bounces-199029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA04ADEAB8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47AD189F174
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675F32E763D;
	Wed, 18 Jun 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqOWMhVg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429C32DE1FF;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247212; cv=none; b=pUl1Th6N4ZHiR6xRrdcwlFsO6lIX7aMZyFjZYERlBGhdd4FaZ7TU7iMFPcSE4gl6kqCieCDFiedJhGil/xklfOE+wpTPa9YLuigy/KZNHiTBspumsutM2H2B8HB89YR3EheCKqWRRVdqbiSdvkbH9u4A4mLJFYiA9rHjOpZsmtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247212; c=relaxed/simple;
	bh=ogBoG80VZdRt95wsoC2snRc4eLHl6tjexBrTDr8vuXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKnrMxZmYFaJNImOHcjgndumG8B6/ttMkOezAAaaz+tmmWCAH0oSmM0OQZl0vZq1JZLvFAdShd809llE7SLrStJc0wNIwmHFbNspulyv1vohvh2HCbuj29to7owQfHPbm6cAb8gIpj8sHCePAs9iYcL3ieaJN56oDyEUS15el6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqOWMhVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77690C4CEF6;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=ogBoG80VZdRt95wsoC2snRc4eLHl6tjexBrTDr8vuXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MqOWMhVgXBtUsi8x3bQXCLmP94NqEgyxWvnIeILMT7qc6HHgMt2mJDyXWnEwzeHQj
	 5GfF8Z5RF+aXX6MqMfvgLZmfmUnw9x1AcwPrYgolcfB0SacsbH1VoTe7TjamxaS/ye
	 8TvEWjHleypjBES0T2g1okyv3ecZ4NIRsLqjtXUnTQuaEEr1qmL/WCBPH9nkR0BgXp
	 wE1ew5+oPICvrjkCTUFAYTb91+jPBnnTK2Ea9r6qRB6O0P+sap9rdwunUB8te/Ehkb
	 5Nrwsry0QB1FJpmN0QJBEUwuWRqh/gVaXoOpKVeJbVzV2INoG+5K5LiKKauy+ytUNV
	 e25+OsXt2vExQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036Uz-33Dh;
	Wed, 18 Jun 2025 13:46:49 +0200
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
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v6 11/15] docs: netlink: remove obsolete .gitignore from unused directory
Date: Wed, 18 Jun 2025 13:46:38 +0200
Message-ID: <f2cd5be5390d0e4588ed340ffe1dc6244202f605.1750246291.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750246291.git.mchehab+huawei@kernel.org>
References: <cover.1750246291.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The previous code was generating source rst files
under Documentation/networking/netlink_spec/. With the
Sphinx YAML parser, this is now gone. So, stop ignoring
*.rst files inside netlink specs directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/networking/netlink_spec/.gitignore | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore

diff --git a/Documentation/networking/netlink_spec/.gitignore b/Documentation/networking/netlink_spec/.gitignore
deleted file mode 100644
index 30d85567b592..000000000000
--- a/Documentation/networking/netlink_spec/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-*.rst
-- 
2.49.0



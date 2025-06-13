Return-Path: <netdev+bounces-197459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB4AD8B17
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3EF189D18F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE172EACE2;
	Fri, 13 Jun 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC+qX+iL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E1B2E7F15;
	Fri, 13 Jun 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814967; cv=none; b=PyuXZDN2dsAU4GBnW3HgmNx4wc6jsSqSLlLf5zy5tHK/otDywnwlQNAq4NSh2op9lL4jh0cOCmjg7RDUEFxZqdbzHfCLENzJbm3W1itIuQsYbB9m2Te6zbrERtYHNWJ9iEpsVcnrs+FIcbEi2lOUmFVP/GWRwLWqblPD6KDUZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814967; c=relaxed/simple;
	bh=1pNBoqfcOumx5Zb6O8muZgcXFYZBfhHDEKXQatZBLVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDzonkdX/wI20gqpIE6lqm47p45VYD3stOd4qN1F8smO4e8JugXfUVa0ExdIGRaMqXssOvTk1bJkTHVEqIyotw+FHRNLl48Gn3EGOnY6wH6aiI2JzzDIVVAdaj0mbNxoy7EGNZddRfKWi4EUPQ6xdcMJPB35QpDpvoExyPv38sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC+qX+iL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086C4C113D0;
	Fri, 13 Jun 2025 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749814967;
	bh=1pNBoqfcOumx5Zb6O8muZgcXFYZBfhHDEKXQatZBLVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FC+qX+iL8AD9wg7+jylIRsZLBYdwYXs+4AbkRTRw+RHA5jGUj5/2wDleAzz6MHvKZ
	 QeP+/t5JVs7hC8HtcwFpRvSKyJMkcJcvPnAMlXW4t9NtfNCAQYyIzFQ1tPHJOc9Hpv
	 neWJl1nHlYBwZ0e+3x1oVIMKY5dthSmYXvXXKGV9Sae9WYsjTaGwFvt7NOuPlnAfpZ
	 G3ktyUHa+BCB0E34FEDN2j2YeatfKLl5SFVfotpxGJEHQOsnwoVkoMBv/oWl2b4gi/
	 lI+AJo/WQaAvNeg1sO/4xIBSOFW4Vao/kL9YP6RySnq1gHYGQP3UdbWH32zo3VJqF3
	 7FXSaBUi0HJug==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQ2o1-00000005dFX-13RQ;
	Fri, 13 Jun 2025 13:42:45 +0200
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
Subject: [PATCH v3 13/16] docs: conf.py: add include_pattern to speedup
Date: Fri, 13 Jun 2025 13:42:34 +0200
Message-ID: <62f2de3a195dc47ba6919721e460a8dd7ae95bc3.1749812870.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749812870.git.mchehab+huawei@kernel.org>
References: <cover.1749812870.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that we have a parser for yaml, use include_pattern, adding
just yaml files from the only directory we currently process.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index b8668bcaf090..60e6998e49e1 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -222,10 +222,13 @@ language = 'en'
 
 # List of patterns, relative to source directory, that match files and
 # directories to ignore when looking for source files.
+include_patterns = [
+	'**.rst',
+	'netlink/specs/*.yaml',
+]
+
 exclude_patterns = [
 	'output',
-	'devicetree/bindings/**.yaml',
-	'netlink/*.yaml',
 ]
 
 # The reST default role (used for this markup: `text`) to use for all
-- 
2.49.0



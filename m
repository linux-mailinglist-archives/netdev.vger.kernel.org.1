Return-Path: <netdev+bounces-196963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A04DAD7251
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CA8178150
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCC724A07A;
	Thu, 12 Jun 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfUw60H5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72186248F6F;
	Thu, 12 Jun 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735701; cv=none; b=Sb/N4mxC8Bd7YYxJV3jNM3ZEYcdSKyhJJ23x5zCUef8J6Ph1rVfxEvkPI269Ch4+TM7rh4ZvaYLn7i6BTGP0MLszB3IOS0pz90EJcLJYQq5sZ1KEWOoDauJKAG+z4xTcEg+cHHNzNAxE6TVstgHkt+Uuj+Un76ziFiEgBgtHMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735701; c=relaxed/simple;
	bh=1pNBoqfcOumx5Zb6O8muZgcXFYZBfhHDEKXQatZBLVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwwlWXJJQgTSpgw/BV95iwrCKdyQ2vBMbDt5yXX5hX5iozpVDBjkH7Ui0lwK3+5hBKIudLTnC/Tib2COXs4/N87WKScomtEmGFl3erB4AP5IHk+poBW0sivaKxt5tGF/SFgdlH+Qbft2R8m3QeBkltYzEHCJqGaFFCQvRTUyB5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfUw60H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0755CC4CEEE;
	Thu, 12 Jun 2025 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749735701;
	bh=1pNBoqfcOumx5Zb6O8muZgcXFYZBfhHDEKXQatZBLVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfUw60H5DAvXwPfxYbtRRrJuUQ9Gb0MYNNprLXlwZY4b/XZgTQkKgR3B5zHzt+x91
	 Mso4IapG6iSAK4wb6SCE7qJM72CX5Eg+JwrWnQFA4j67yxGGufSPhtiS+kBHwxH/2z
	 nLvLqOUl3Ndq0fWbzlT1LZGF+lx4laYHKSLh8eXR2Xfv2UZwyLmv1nHFp/aa8Pgdym
	 5UjUEwXge9dUr0NxoLHSDjSsiB1fjuvgVRV3OCwIbkhujI5AFmnZ6BYFPZaKnWmtM3
	 QE8elo8nPBkiPDlTkVazUDXblLkitZ2+WMbXRKO71Gp4IXj+C0WSl3IRp+ltoFJLBD
	 9ODcEGBIsP2ng==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uPiBX-000000053q1-0XRv;
	Thu, 12 Jun 2025 15:41:39 +0200
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
Subject: [PATCH v2 1/2] docs: conf.py: add include_pattern to speedup
Date: Thu, 12 Jun 2025 15:41:30 +0200
Message-ID: <62f2de3a195dc47ba6919721e460a8dd7ae95bc3.1749735022.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749735022.git.mchehab+huawei@kernel.org>
References: <cover.1749735022.git.mchehab+huawei@kernel.org>
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



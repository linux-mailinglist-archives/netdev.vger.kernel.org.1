Return-Path: <netdev+bounces-205489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C60B3AFEE72
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB701C84FC0
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8172EAD07;
	Wed,  9 Jul 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRsdlGia"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE62EA736;
	Wed,  9 Jul 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076750; cv=none; b=O3wjy6aLUm4b4sUhP4Oroh8y+R/mfV4FkkDCIKLSVhTDvyCNXJyuDU584w3tj/3PdCBwGu/NdOlubhRgdF2kFGueyfCPzFBZQKUM77VWDOJMYg8tOsp77P1WaJrRz/XhCO+ZQqzpIha2heM4Q7XFDrQvHhHf+p4dpWhv6c0Ge54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076750; c=relaxed/simple;
	bh=ogBoG80VZdRt95wsoC2snRc4eLHl6tjexBrTDr8vuXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q777lPKj2Ar7pkjrn+F7lasypaBuveaZTWR+clo66X8wVQOOs7OVCdp0idH5hbKXljAOgY5DOOTetHI8WwC9dgSoEDk0KKDcpyvULu+9PEciIjf94Wfg3Gi+buvf+bBXTTlEvF2RpLnC7Avb6c2hZB0ZHtM21QpW4y0g7gpXY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRsdlGia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6959C4CEEF;
	Wed,  9 Jul 2025 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076749;
	bh=ogBoG80VZdRt95wsoC2snRc4eLHl6tjexBrTDr8vuXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRsdlGia62a1K2o88CKa9w6PzCofIFiV2z7ftKReT9V2H0TjhMbYQUxIZ/4gNaVl6
	 vwf4NMwnSWP2VGc/0C42WMZzNLI+20NsPjiQxkC/ScQB9LLP8FPQT+iDeExlDGeVN1
	 lBalFYjSONoP1ih9ZkwUzf7FrMHc81Ur0uiRnincsm759Yg0lq4WUQplf+kfXSopud
	 unexhzn/3ppHBBuDlpoCquvQtEvLV2aZ7qUt4PgNuEgDleuWZgwpd2OwsvZvj3pC3f
	 +LDjtX7sCjQf0BLKAShUviYw9Yw2WOvl5RzJcPmBircTDGTiUzzLmeGDKXRlbYAGCs
	 FxEwAdQom4U+A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZXCJ-00000000IhE-1hkB;
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
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v9 09/13] docs: netlink: remove obsolete .gitignore from unused directory
Date: Wed,  9 Jul 2025 17:58:53 +0200
Message-ID: <f3fe6423a4f15f275f10c3ab5d3236b70b6850f7.1752076293.git.mchehab+huawei@kernel.org>
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



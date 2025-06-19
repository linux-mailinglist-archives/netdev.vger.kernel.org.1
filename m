Return-Path: <netdev+bounces-199348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B31ADFE1B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0173D1BC1148
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8787F266B52;
	Thu, 19 Jun 2025 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBqdGUxa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7963924C68B;
	Thu, 19 Jun 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750315821; cv=none; b=tZ6hD4iWDAubDNrUpylOfA/owcGSvIvOkXnhOdTAB7z7EfShkEDDxYn+vdkyNpOqKtQTxiqTNPcEwciZDSJr94Q5jRs2fHjkhiJKoX+dvdto593ERYTyhfMTNhX1FaV71hxSHVJHK1A0aGHE0uOPFDzEiHFWFynnVTgkbfCx7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750315821; c=relaxed/simple;
	bh=ogBoG80VZdRt95wsoC2snRc4eLHl6tjexBrTDr8vuXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWNpgIT0qekSM6lksgWTiwdnKUiylSk8ZphK6a1QdOq1ED4UJauDxoAyvAthAwQykpE+DLZ1p6CHnZJapayMVad8CRvb8rb0S+JEemTY3t8GB79kOQOHdQqkpgIoDJvCN6ihKcrYSEVBYcgOTRxDqG7TJ+9XfW8IBrh8QFd/nU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBqdGUxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2771C4CEFC;
	Thu, 19 Jun 2025 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750315821;
	bh=ogBoG80VZdRt95wsoC2snRc4eLHl6tjexBrTDr8vuXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBqdGUxauHkjPdPkH1CLHlh8829DMsO/E/yRm7/fSfPdYVjj+Ds3Xl+SSU8FWZVAJ
	 caPJAcrxX+et7iyq52dQpTBAs62TjrDZoYRuHK1oi/8WWZCydUePumgda0NBcs/esJ
	 97flDxTJSaw5L75N+HckG9NE8UEGRaJENaGa3NBtYgGWFUxw4NHt97jK82y9le11x9
	 AQpErNXxrcLa0rC7S0n/3IZyYL6ZcVRIVn6kXHJosVHRSLwAGZjNOKRf86j+dmtKgu
	 Ll3xYShpSCKs3C7a3wtyfXCoq6+Fy/VVg+vCvkPnSnthz2BoTcBG6QxAEMN5CbNLO4
	 NkphEdBqLZzug==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uS96J-00000003dHE-0WgH;
	Thu, 19 Jun 2025 08:50:19 +0200
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
Subject: [PATCH v7 11/17] docs: netlink: remove obsolete .gitignore from unused directory
Date: Thu, 19 Jun 2025 08:49:04 +0200
Message-ID: <f2cd5be5390d0e4588ed340ffe1dc6244202f605.1750315578.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750315578.git.mchehab+huawei@kernel.org>
References: <cover.1750315578.git.mchehab+huawei@kernel.org>
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



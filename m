Return-Path: <netdev+bounces-196964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740EAAD725F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C963B13D3
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C8124BBEE;
	Thu, 12 Jun 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzbTTgxU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223424A041;
	Thu, 12 Jun 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735701; cv=none; b=duvHiUO13uwhrn6k71zltFsx4qg/LPtdhjGQkzR8/NfKzG2CxW2Vw6GSlavzF4YdKGOueXrJDjGKeGCd62YP+LwPs3UfyfhIcj5YOcOsCIfPPGgdUFHOCFHENizHOF1pM9Qe/R5KLBK0bzyXVkXE6tbIZ0Z5CiGZTFK0OUoepzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735701; c=relaxed/simple;
	bh=00F9KG3FuikbC/77I/aVEWzxRtC/68GGYQsrs3gqu00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMca1FWN9mu4wNWJkdeyIwvUHYPRdfyubtt/5zRkb8EA7q7/du8XTXxaKwITOKTp2xNr0PIt3fCWNSjFi0wIlE/M9KyflIUqT++zX7F06kClLVxCLS5Vrnl833g6d/D8LWw4r15DpHAh+ykfRxFKPPPF7WhqrGsVQvs5PWhyAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzbTTgxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05222C4CEEB;
	Thu, 12 Jun 2025 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749735701;
	bh=00F9KG3FuikbC/77I/aVEWzxRtC/68GGYQsrs3gqu00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzbTTgxUuP3N9AVCRYohTi5X5zxnC4JJWwzo5hbc9qI+2nLTu2JdJ3eVnGYNKN6vd
	 1aPFPIHqp1mhVOX+tyi5+7rY3ADXg/Ra08EFgPpUsrZGc/QT5j1u4LjkydkaHzGFvB
	 ZMGNWa3mYIMRkkHfg79O3Z6ohlP1VsDDAf36Qps+30Znr2me2B/y2YLJtQllxua3Uz
	 kCHN44HlfS0+Tr7+1nskhL67R1w2xctfbBLCtuGoACQbAl634WA37rFpr5fuvOSJxi
	 LVbqpCUmf2sBeDnz8y305ERbm0NzbP9aah3JIoSHNCxneNZTsZVlesgowt8f1AXWI9
	 jtYG9kkD/xyHA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uPiBX-000000053q5-0n9j;
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
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v2 2/2] docs: uapi: netlink: update netlink specs link
Date: Thu, 12 Jun 2025 15:41:31 +0200
Message-ID: <a770ff8faac7982fb65cd3be047dc7e9424676cd.1749735022.git.mchehab+huawei@kernel.org>
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

With the recent parser_yaml extension, and the removal of the
auto-generated ReST source files, the location of netlink
specs changed.

Update uAPI accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/userspace-api/netlink/index.rst | 2 +-
 Documentation/userspace-api/netlink/specs.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/netlink/index.rst b/Documentation/userspace-api/netlink/index.rst
index c1b6765cc963..83ae25066591 100644
--- a/Documentation/userspace-api/netlink/index.rst
+++ b/Documentation/userspace-api/netlink/index.rst
@@ -18,4 +18,4 @@ Netlink documentation for users.
 
 See also:
  - :ref:`Documentation/core-api/netlink.rst <kernel_netlink>`
- - :ref:`Documentation/networking/netlink_spec/index.rst <specs>`
+ - :ref:`Documentation/netlink/specs/index.rst <specs>`
diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
index 1b50d97d8d7c..debb4bfca5c4 100644
--- a/Documentation/userspace-api/netlink/specs.rst
+++ b/Documentation/userspace-api/netlink/specs.rst
@@ -15,7 +15,7 @@ kernel headers directly.
 Internally kernel uses the YAML specs to generate:
 
  - the C uAPI header
- - documentation of the protocol as a ReST file - see :ref:`Documentation/networking/netlink_spec/index.rst <specs>`
+ - documentation of the protocol as a ReST file - see :ref:`Documentation/netlink/specs/index.rst <specs>`
  - policy tables for input attribute validation
  - operation tables
 
-- 
2.49.0



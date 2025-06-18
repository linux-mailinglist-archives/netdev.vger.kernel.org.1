Return-Path: <netdev+bounces-199028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCA7ADEAD6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B30C7ADDB7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A142E7F38;
	Wed, 18 Jun 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3hKuiok"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B202DE208;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247212; cv=none; b=LbTyyT5vfJIlvkzglSXoOYgP1AOwbSLL91y9Osapw+P+P+iTaY00Q3MHZF30+enWl3+YgFQP6L9EJaT+t5MDBqMJ3f3lmdFX/ZR3PBIP9OOP5sPMaHeTiYppeHRnJDLDpufbZ+j68A/O07E1KY2z+PH5VVSz8Xak1V7Faj7VEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247212; c=relaxed/simple;
	bh=gCUujhjF05O4bN0j1mBzTOE2gqunIOFmC86Oe+w0BHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2R7Z0AJIvxgl24SXswsQ7OamKiqlEjvopychJsP4rjfFJrYfByjVc2a65+v7xTFcCCSRoAqwV78kiVSaHF0bBhJutsXiDIBUvEtUmBBtZqP+oSo7wzdTR7pynSOnQnOYjaKJDjAAnMBtpWf3LXtm/JmNpF19+/72KGSn8CuTeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3hKuiok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFA4C4CEF3;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=gCUujhjF05O4bN0j1mBzTOE2gqunIOFmC86Oe+w0BHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3hKuiokwUIAHVhJAbQbj6y9L1mM6iZ/ZUcWyLY3xwgpIheHmxnQ4iofjmpCbwUpR
	 rUHNjejo5Uo0qMow2ycK1THE2XibdqHxBrpDh+jjFreLRVxC2csqMWkp59iVWup7MF
	 /qOvhYTQ9FbyiYvqCbpGZhzdctfEGHiBKb7oQM/QyJF2S0+wX7B3YNt+chSpUSA4RI
	 dTCuONiUCxqmQdDvQdOIq65C5TF4QqEA3GFya27EK2WWI9WntN/IEjPBVbPXQ/NhPp
	 K28wx1IPMJO21OCLyu/4Ytf+MGt+c2AdIB7do3RNFdRWITQebfZV2jAuxVj/Q28pZT
	 h/AyfOFiwfU0A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036Up-2owX;
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
Subject: [PATCH v6 09/15] docs: uapi: netlink: update netlink specs link
Date: Wed, 18 Jun 2025 13:46:36 +0200
Message-ID: <1dbe019319a6fd9f0c672280e079ddad1149cbe4.1750246291.git.mchehab+huawei@kernel.org>
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

With the recent parser_yaml extension, and the removal of the
auto-generated ReST source files, the location of netlink
specs changed.

Update uAPI accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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



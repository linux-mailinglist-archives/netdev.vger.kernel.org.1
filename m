Return-Path: <netdev+bounces-199033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C9ADEACB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8B2189F4D7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB5B2EA14A;
	Wed, 18 Jun 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjEpijrh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2732DE215;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247212; cv=none; b=N2tOJfOvYZbYC/tycSeMMCAJTnhibLZf5QfU12omgyYB1sqEE5cWAku/FnBOx/+DW57Yufl+pTNjl1CZS+fsJxbL6d426brnqdIDvvC0ucUHDMTc2VvBxC7plC8GjvzdW41rhjZNPb+AOdOaN1SaBMKfyOF9gzxPdbeV7Ejfxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247212; c=relaxed/simple;
	bh=Eu6NvKMYNdmD8XfJnfUGiXHKuW5qDdQasrskHf5QPZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/38wzLXqEMtP7TPta0CAsbiXyrzWZ1BgzQV0WWP2BYTlBLDlWSyZJ1gOTJOFE1HtnY4B8iycwFCHJBc7JgmkHyCp2XU3+D39vNidxcCuA7ODUZeeHckN5UJ+pv8a49CUkWPtqU1yL1VhJ1O85rD0L9nW+y5EZDAKz1126vZ6iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjEpijrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920EDC116B1;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=Eu6NvKMYNdmD8XfJnfUGiXHKuW5qDdQasrskHf5QPZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjEpijrhqmBNi8KU6pghGSfrWjrHcK2mBeSSvc2NDXzB7WXtrfLdwY8ITSuZ0SLW4
	 UOflw5ezusNQkSFMEDNC7Lin8D068h2KUvM9OXhpG6uMfCZKWAwxbd/X8pGTRtUM5f
	 xxSn8zU6tdbY/GvwUziDCZHUxFyIH4YrtSLbpPKCCy8uKkOnoG/71aCc1i5k7ZkjcC
	 0WyFGvHe9i51p1Y8hXnnh+3hM/uYlsVEQGfw8fkirnoyVe5qxoByk3xrPJp4Q20KK4
	 Sfr4Sy7eDT/yGeAHl7Y5DOJXXYpsMmct0qoA5o4fy7lMEtttq6T9dimECUthi6IHQV
	 Iuxlo5NIn76lA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036VE-3W9N;
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
	Randy Dunlap <rdunlap@infradead.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v6 15/15] docs: sphinx: add a file with the requirements for lowest version
Date: Wed, 18 Jun 2025 13:46:42 +0200
Message-ID: <e5666ba0c2867a0e78ff91727e827d706ce08668.1750246291.git.mchehab+huawei@kernel.org>
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

Those days, it is hard to install a virtual env that would
build docs with Sphinx 3.4.3, as even python 3.13 is not
compatible anymore with it.

	/usr/bin/python3.9 -m venv sphinx_3.4.3
	. sphinx_3.4.3/bin/activate
	pip install -r Documentation/sphinx/min_requirements.txt

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/doc-guide/sphinx.rst        | 15 +++++++++++++++
 Documentation/sphinx/min_requirements.txt |  8 ++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/sphinx/min_requirements.txt

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 5a91df105141..13943eb532ac 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -131,6 +131,21 @@ It supports two optional parameters:
 ``--no-virtualenv``
 	Use OS packaging for Sphinx instead of Python virtual environment.
 
+Installing Sphinx Minimal Version
+---------------------------------
+
+When changing Sphinx build system, it is important to ensure that
+the minimal version will still be supported. Nowadays, it is
+becoming harder to do that on modern distributions, as it is not
+possible to install with Python 3.13 and above.
+
+The recommended way is to use the lowest supported Python version
+as defined at Documentation/process/changes.rst, creating
+a venv with it with, and install minimal requirements with::
+
+	/usr/bin/python3.9 -m venv sphinx_min
+	. sphinx_min/bin/activate
+	pip install -r Documentation/sphinx/min_requirements.txt
 
 Sphinx Build
 ============
diff --git a/Documentation/sphinx/min_requirements.txt b/Documentation/sphinx/min_requirements.txt
new file mode 100644
index 000000000000..89ea36d5798f
--- /dev/null
+++ b/Documentation/sphinx/min_requirements.txt
@@ -0,0 +1,8 @@
+Sphinx==3.4.3
+jinja2<3.1
+docutils<0.18
+sphinxcontrib-applehelp==1.0.4
+sphinxcontrib-devhelp==1.0.2
+sphinxcontrib-htmlhelp==2.0.1
+sphinxcontrib-qthelp==1.0.3
+sphinxcontrib-serializinghtml==1.1.5
-- 
2.49.0



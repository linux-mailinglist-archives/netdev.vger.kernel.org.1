Return-Path: <netdev+bounces-199340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6251ADFE14
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A642C3BFB0E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C19725F984;
	Thu, 19 Jun 2025 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dq3gzpca"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810032512FA;
	Thu, 19 Jun 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750315821; cv=none; b=IJy+5abq/G2ONGD0WEBQyeTmYGCoqf//gc7AMbjRTBRtk0SVSbcLHebVRiB/yVxfvGcUXi1+CvoUuHrr5XZOYBQ26nSGYyxGdBJZlVzb16Z9zydDHpBgRQeNOvaUyXNnKOBs0Bn8vF5EVHZHt84oZpXHIPqdJbRKG5OF81m11cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750315821; c=relaxed/simple;
	bh=Eu6NvKMYNdmD8XfJnfUGiXHKuW5qDdQasrskHf5QPZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/WgSli1eBK3ILLfdWSsZOy1RuMdFR3qHgcdcPU5F4poYA5SPb04CRzlgj86u7sifm9uBC3Fnk7E6eRTBqobU/xlc+O6hLWpkIjA5emy/yDiub2vKidWYiH4aqLnOlmNwzuJTJGt3NEY4iYXwEQOSUaY+qFS1h1ICaqKv32l3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dq3gzpca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F3AC116D0;
	Thu, 19 Jun 2025 06:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750315821;
	bh=Eu6NvKMYNdmD8XfJnfUGiXHKuW5qDdQasrskHf5QPZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dq3gzpca5BoYs3ihHNdTlUhvI/81TS2OWbjM6BidamCOFgLlMjIaaxJqmNDjd2tfd
	 XCB8SD5BaViIQDIDL6RgOhlRTKw04oRPq+nvnpIUz3guULiIUVVtZoz5qGHDtSfH/2
	 UqXD5qRfe1x/ilmzJOjSXAXL8YSk768MlwUrz918oxM6fMKnDSC/CunO9SyxO2dMIC
	 gEv9gNM1LYYX1qf9PEDvr/zuF/f8CpnZkhjzDJK9xgXjsEFLXMY2MTVFMmbF5ObRyR
	 IhQnNW4m2wiHtVsA53eGkJHIfucD0a70CpyZ15rGDEvmqpvsHbjm9AC4Pl1p1UKcgV
	 niC7U7PgG8zTw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uS96J-00000003dHU-113E;
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
	Randy Dunlap <rdunlap@infradead.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v7 15/17] docs: sphinx: add a file with the requirements for lowest version
Date: Thu, 19 Jun 2025 08:49:08 +0200
Message-ID: <e5666ba0c2867a0e78ff91727e827d706ce08668.1750315578.git.mchehab+huawei@kernel.org>
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



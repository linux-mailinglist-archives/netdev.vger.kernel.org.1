Return-Path: <netdev+bounces-197738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D3AD9B7B
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EE617BDC7
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7893298994;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhsYfHhI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351D1F4611;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749891378; cv=none; b=iAfSuIvIbRXsp9QNpzftaPZeIAyQEclibYsPlo7fuSkdKqdO4TN7fhU2aIBokyxzu0IBCP9n/GpSeiw+Th6SqDvAgYEzurphdDv9ByIioPns+BQKm/T84dhQ8zlxyY1wSd+1lq3/uCuGW4fdAnGHlG2/vjZkcj5nbeNyBtUbEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749891378; c=relaxed/simple;
	bh=QD8Rsu+UsGP24yUilsOKxXRMjFWVKCuqcRnv9JPpeUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=usL5/njrwQglT8XEoTzejZfmupi9VXhZf6QXMrq4zK8fU1zXTcmRF30d1Tp/vYd8haIrJdvhsi2owCVqCARjUtVVnIqYD0uDq80pehLm9HprYB9Pwm0McdVb/yMaGAFMGujaOMnJJRgLjv+wvP2icHHFtFeLGt1WOaZT1iFwWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhsYfHhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDF7C4CEEB;
	Sat, 14 Jun 2025 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749891377;
	bh=QD8Rsu+UsGP24yUilsOKxXRMjFWVKCuqcRnv9JPpeUk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZhsYfHhI7c/MfrKzr2kyVXsGEGitT680SQZYRVCMBMQ5LsehQy+sfg1RY1DUjsPJk
	 tMvPietxA71dPi6QRrsdsPpqa8fEf3gSTmG4i72TiMTLNkYr7twzK5wTsbasspaBS2
	 cjxEGpm6PsoBz2qfRJHkook2EKTcbZmpEss29KDvxiIhxY4aib/ZrmOiqkS3Ei2ESz
	 MMwLqwnREq7UhkjB95vOekcvEEtTWhYFuY/o9tLU4NcSOIqI4xujxwUWWrIvlUH78G
	 knYDgTIvYghkPXiXl2PRf58WbVHg87/28RiHYx4r54DawwCla1bRoeVaX1YWHHbhVw
	 tPXygophe/vCQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQMgR-000000064ad-3dui;
	Sat, 14 Jun 2025 10:56:15 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ignacio Encinas Rubio <ignacio@iencinas.com>,
	Marco Elver <elver@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jan Stancek <jstancek@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ruben Wauters <rubenru09@aol.com>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>
Subject: [PATCH v4 00/14] Don't generate netlink .rst files inside $(srctree)
Date: Sat, 14 Jun 2025 10:55:54 +0200
Message-ID: <cover.1749891128.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As discussed at:
   https://lore.kernel.org/all/20250610101331.62ba466f@foz.lan/

changeset f061c9f7d058 ("Documentation: Document each netlink family")
added a logic which generates *.rst files inside $(srctree). This is bad
when O=<BUILDDIR> is used.

A recent change renamed the yaml files used by Netlink, revealing a bad
side effect: as "make cleandocs" don't clean the produced files and symbols
appear duplicated for people that don't build the kernel from scratch.

This series adds an yaml parser extension. We opted to write such extension
in a way that no actual yaml conversion code is inside it. This makes it flexible
enough to handle other types of yaml files in the future. The actual yaml
conversion logic were placed at scripts/lib/netlink_yml_parser.py. The
existing command line tool was also modified to use the library ther.

With this version, there's no need to add any template file per netlink/spec
file, and the index is automatically filled using :glob: parameter.

---

v4:
- Renamed the YNL parser class;
- some minor patch cleanups and merges;
- added an extra patch to fix a insert_pattern/exclude_pattern logic when
   SPHINXDIRS is used.

v3:
- Two series got merged altogether:
  - https://lore.kernel.org/linux-doc/cover.1749723671.git.mchehab+huawei@kernel.org/T/#t
  - https://lore.kernel.org/linux-doc/cover.1749735022.git.mchehab+huawei@kernel.org

- Added an extra patch to update MAINTAINERS to point to YNL library
- Added a (somewhat unrelated) patch that remove warnings check when
  running "make cleandocs".

---

v2:
- Use a Sphinx extension to handle netlink files.

v1:
- Statically add template files to as networking/netlink_spec/<family>.rst


Mauro Carvalho Chehab (14):
  tools: ynl_gen_rst.py: create a top-level reference
  docs: netlink: netlink-raw.rst: use :ref: instead of :doc:
  docs: netlink: don't ignore generated rst files
  tools: ynl_gen_rst.py: make the index parser more generic
  tools: ynl_gen_rst.py: Split library from command line tool
  scripts: lib: netlink_yml_parser.py: use classes
  tools: ynl_gen_rst.py: move index.rst generator to the script
  docs: sphinx: add a parser for yaml files for Netlink specs
  docs: use parser_yaml extension to handle Netlink specs
  docs: conf.py: don't handle yaml files outside Netlink specs
  docs: uapi: netlink: update netlink specs link
  MAINTAINERS: add maintainers for netlink_yml_parser.py
  docs: Makefile: disable check rules on make cleandocs
  docs: conf.py: properly handle include and exclude patterns

 .pylintrc                                     |   2 +-
 Documentation/Makefile                        |  19 +-
 Documentation/conf.py                         |  61 ++-
 Documentation/netlink/specs/index.rst         |  13 +
 Documentation/networking/index.rst            |   2 +-
 .../networking/netlink_spec/.gitignore        |   1 -
 .../networking/netlink_spec/readme.txt        |   4 -
 Documentation/sphinx/parser_yaml.py           |  76 ++++
 Documentation/userspace-api/netlink/index.rst |   2 +-
 .../userspace-api/netlink/netlink-raw.rst     |   6 +-
 Documentation/userspace-api/netlink/specs.rst |   2 +-
 MAINTAINERS                                   |   2 +
 scripts/lib/netlink_yml_parser.py             | 360 ++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_rst.py            | 394 ++----------------
 14 files changed, 548 insertions(+), 396 deletions(-)
 create mode 100644 Documentation/netlink/specs/index.rst
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100755 Documentation/sphinx/parser_yaml.py
 create mode 100755 scripts/lib/netlink_yml_parser.py

-- 
2.49.0




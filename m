Return-Path: <netdev+bounces-198459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E9DADC3F5
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666AB1896197
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F6A28F93E;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRS/iG9r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1371D88AC;
	Tue, 17 Jun 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147352; cv=none; b=p+FXU2HKllALMMR3Ysf04uQTFNo/vWQsKFo47+uhsQkhJQhoRWL/9oS74otJ3+/TZf2g/aBsYAdaziH4inHkHlZnTYlxd/LU/f6mJ6Kff0Sm37S5PmCbcs87CZBfynMmVtCZltSJCKvwWKT7DFMRwSOEk/wEOAyFW5HfiGvelN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147352; c=relaxed/simple;
	bh=Bmc1dcL/vKMpcG3gmR7p+QTIxzrCe6x9Ewb/iBXx3i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jr6p/BxzIx37AAwbUlP0A6gYT6cFqqvSFdk2UnuRF8jcjFoQR7+TrXOrZixzdJ/1squBqlS+cuxpZ517Hx/CkKxLhjnbZ+Bb4Cyg212owAxjT7y1v1HOEUAexoq04SKuAyJFxyokiCfjbkACBBymFkkNZD/XtyJbx1aFRUJdxro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRS/iG9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C0CC4AF09;
	Tue, 17 Jun 2025 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750147351;
	bh=Bmc1dcL/vKMpcG3gmR7p+QTIxzrCe6x9Ewb/iBXx3i4=;
	h=From:To:Cc:Subject:Date:From;
	b=CRS/iG9rRgPnce4tyJMHGV9BjQMNm8HrVXKixDQywp13eFOqk2fvEcvfiRUsUWgJP
	 p9lPf4LghIe1yslQXDNg+PV/WIEY+gP8G/iEM5CNZmbiJ+xqkwFxiErJ49cbkYIFYh
	 v0Lyod+7IollBzGERTKzGoLS2vV8L+i272d37FBX1TQKq5iPf4E9Pgk5QHputHl1fV
	 qRzTSGDBibtMgBDs8W20NsTq/arXPxRGgsewZqVntd9d84Y7wndAYZJvMT2vtEbf2v
	 hOOVMJ5McR5etd2Ilk+u7ipJerJInE+4Lpz1JZtQjLDW3e1Kqmzk2bkKdgIzTlTT2x
	 ri/DEJ9nQFqAQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRRH3-00000001vcm-3bGt;
	Tue, 17 Jun 2025 10:02:29 +0200
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
Subject: [PATCH v5 00/15] Don't generate netlink .rst files inside $(srctree)
Date: Tue, 17 Jun 2025 10:01:57 +0200
Message-ID: <cover.1750146719.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

This series adds an yaml parser extension and uses an index file with glob for
*. We opted to write such extension in a way that no actual yaml conversion
code is inside it. This makes it flexible enough to handle other types of yaml
files in the future. The actual yaml conversion logic were placed at 
netlink_yml_parser.py. 

As requested by YNL maintainers, this version has netlink_yml_parser.py
inside tools/net/ynl/pyynl/ directory. I don't like mixing libraries with
binaries, nor to have Python libraries spread all over the Kernel. IMO,
the best is to put all of them on a common place (scripts/lib, python/lib,
lib/python, ...) but, as this can be solved later, for now let's keep it this
way.

---

v5:
- some patch reorg;
- netlink_yml_parser.py is now together with ynl tools;
- minor fixes.

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


Mauro Carvalho Chehab (15):
  docs: conf.py: properly handle include and exclude patterns
  docs: Makefile: disable check rules on make cleandocs
  tools: ynl_gen_rst.py: create a top-level reference
  docs: netlink: netlink-raw.rst: use :ref: instead of :doc:
  tools: ynl_gen_rst.py: make the index parser more generic
  tools: ynl_gen_rst.py: Split library from command line tool
  scripts: lib: netlink_yml_parser.py: use classes
  docs: netlink: index.rst: add a netlink index file
  tools: ynl_gen_rst.py: clanup coding style
  docs: sphinx: add a parser for yaml files for Netlink specs
  docs: use parser_yaml extension to handle Netlink specs
  docs: uapi: netlink: update netlink specs link
  tools: ynl_gen_rst.py: drop support for generating index files
  docs: netlink: remove obsolete .gitignore from unused directory
  MAINTAINERS: add netlink_yml_parser.py to linux-doc

 Documentation/Makefile                        |  19 +-
 Documentation/conf.py                         |  63 ++-
 Documentation/netlink/specs/index.rst         |  13 +
 Documentation/networking/index.rst            |   2 +-
 .../networking/netlink_spec/.gitignore        |   1 -
 .../networking/netlink_spec/readme.txt        |   4 -
 Documentation/sphinx/parser_yaml.py           |  76 ++++
 Documentation/userspace-api/netlink/index.rst |   2 +-
 .../userspace-api/netlink/netlink-raw.rst     |   6 +-
 Documentation/userspace-api/netlink/specs.rst |   2 +-
 MAINTAINERS                                   |   1 +
 tools/net/ynl/pyynl/netlink_yml_parser.py     | 360 ++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_rst.py            | 385 +-----------------
 13 files changed, 523 insertions(+), 411 deletions(-)
 create mode 100644 Documentation/netlink/specs/index.rst
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100755 Documentation/sphinx/parser_yaml.py
 create mode 100755 tools/net/ynl/pyynl/netlink_yml_parser.py

-- 
2.49.0




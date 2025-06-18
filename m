Return-Path: <netdev+bounces-199019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F246ADEAA6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B031B189E385
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304DC2DBF7C;
	Wed, 18 Jun 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoD8ewSe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D902BE7D1;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247211; cv=none; b=co2u3mFp8l8cMqcMJ0UiUtJDPH7KVv2yKytYP16H5/xMliJorMXpOjLUHTFS0xyKDyVI2z0gqtyfIF2d+e91IGcSjZEHeaWRYul0d9en4px8NwbwHDGuyqsAaUxs3oYFM8Yf8hOBM5Gu47o9uA55XfiZ1LsfpiEe4CNDHHjn6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247211; c=relaxed/simple;
	bh=8U1LMf5c24TeCW4LirK5pltegBhMZFHhjpje16TwVmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFx0SqfWu2TB7gcS3mgaUE+cFjSdbknTrCe3LQuxOsVG7ckNUAYOyQdntV45TlVzxtj50ZOnsRvA1WNH3U/CS8xrMN0dJtmS5idoY3jsizaEOimwk5kN29i5M/eIoy+4M4uRi76tXWQf+PQOU/i7rGXWl/rwUPzG5KJtKm0VuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoD8ewSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AD5C4CEF0;
	Wed, 18 Jun 2025 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750247211;
	bh=8U1LMf5c24TeCW4LirK5pltegBhMZFHhjpje16TwVmk=;
	h=From:To:Cc:Subject:Date:From;
	b=IoD8ewSeXHkL4fc88s0uZee5fexqOMyAhPEUbMf5NwIglb2QtKOaaAuBNPtCiOYgj
	 iSKiRTfz563oLhPD/1/e+/aMIWM2MMdPcOBgpodl+pmtvPcKz8hawdfquBdUbJWpzR
	 Seh7QXWRREFNE4c9BBShAh47AW2hnMFgr/5f4SE9YksmhKaD09ziedb6HH450998Kj
	 uyQ8JbH1FOg5q3ZZzyotisyaoqo448nsEken9NC65RhNxe03R2lhmQs2RqKjQjbhRO
	 U4yA820E3/HOcQqUVypw5DAxqijJNxBS9wvSpumDIvry0oeOErrAxMdyMyhGrFUOat
	 nD/XftwnsB5vw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uRrFh-000000036UG-1kgW;
	Wed, 18 Jun 2025 13:46:49 +0200
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
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <mchehab+huawei@kernel.org>
Subject: [PATCH v6 00/15] Don't generate netlink .rst files inside $(srctree)
Date: Wed, 18 Jun 2025 13:46:27 +0200
Message-ID: <cover.1750246291.git.mchehab+huawei@kernel.org>
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

v6:
- YNL doc parser is now at tools/net/ynl/pyynl/lib/doc_generator.py;
- two patches got merged;
- added instructions to test docs with Sphinx 3.4.3 (minimal supported
  version);
- minor fixes.

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
  docs: netlink: netlink-raw.rst: use :ref: instead of :doc:
  tools: ynl_gen_rst.py: Split library from command line tool
  docs: netlink: index.rst: add a netlink index file
  tools: ynl_gen_rst.py: cleanup coding style
  docs: sphinx: add a parser for yaml files for Netlink specs
  docs: use parser_yaml extension to handle Netlink specs
  docs: uapi: netlink: update netlink specs link
  tools: ynl_gen_rst.py: drop support for generating index files
  docs: netlink: remove obsolete .gitignore from unused directory
  MAINTAINERS: add netlink_yml_parser.py to linux-doc
  tools: netlink_yml_parser.py: add line numbers to parsed data
  docs: parser_yaml.py: add support for line numbers from the parser
  docs: sphinx: add a file with the requirements for lowest version

 Documentation/Makefile                        |  19 +-
 Documentation/conf.py                         |  87 +++-
 Documentation/doc-guide/sphinx.rst            |  15 +
 Documentation/netlink/specs/index.rst         |  13 +
 Documentation/networking/index.rst            |   2 +-
 .../networking/netlink_spec/.gitignore        |   1 -
 .../networking/netlink_spec/readme.txt        |   4 -
 Documentation/sphinx/min_requirements.txt     |   8 +
 Documentation/sphinx/parser_yaml.py           |  84 ++++
 Documentation/userspace-api/netlink/index.rst |   2 +-
 .../userspace-api/netlink/netlink-raw.rst     |   6 +-
 Documentation/userspace-api/netlink/specs.rst |   2 +-
 MAINTAINERS                                   |   1 +
 tools/net/ynl/pyynl/lib/__init__.py           |   2 +
 tools/net/ynl/pyynl/lib/doc_generator.py      | 398 ++++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_rst.py            | 384 +----------------
 16 files changed, 614 insertions(+), 414 deletions(-)
 create mode 100644 Documentation/netlink/specs/index.rst
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100644 Documentation/sphinx/min_requirements.txt
 create mode 100755 Documentation/sphinx/parser_yaml.py
 create mode 100644 tools/net/ynl/pyynl/lib/doc_generator.py

-- 
2.49.0




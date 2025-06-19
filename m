Return-Path: <netdev+bounces-199333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBEEADFDF6
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF427A2562
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E65248F43;
	Thu, 19 Jun 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGZ/adTi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF7242D6B;
	Thu, 19 Jun 2025 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750315821; cv=none; b=KlmWmt2WkWlIl45GgTU+HWimBVDDRBqagXQOMH/Dz8btpHXd5fJ6cU5EEugdiGzbLvQAcayL5sdLlJfm1ShoxoQ/r8dp9RBdSfLtkyDifVfxyTMSOazgFmV6BixLV+K56iFZt0jgSIHzchqHLJdLPGFISDDNbFwBXeDvPQ66dns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750315821; c=relaxed/simple;
	bh=5Dnu6TpCQ4ygTM0sZLc+NsZvx1CkGGvprr3pez370Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gD4oBSJQp34di+SpttoAE388/AQXAcysApei7B79k0qQJF1pTOimlMDAxGQ2ysimc0OophcLz/pJeY+QusH0sconA9uAp8F/T2ZwKKJEHt/Q9I/VbV7VOu3DLMNVgHNLEZL0Fv7/KxPJXkFel/FbHGseOKuH8h7RVkL/jtlfSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGZ/adTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6B5C4CEF0;
	Thu, 19 Jun 2025 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750315820;
	bh=5Dnu6TpCQ4ygTM0sZLc+NsZvx1CkGGvprr3pez370Qc=;
	h=From:To:Cc:Subject:Date:From;
	b=hGZ/adTiB/Q7nbBQqHtK4htpU9/KDgR+E2mKSyh59oV8p2aNmU3URZBo+wG1N1zON
	 i7qtThPuyHdYs0HOxORYlhuKvMllkwCIdhccAwtXhKAwL2fPcFzdysRrNXYwn8Y//l
	 WymdDDcVfo7bh/9T8ETNQfk/LHBWRWTlZYk/gnbH93O+ipB5geo/rCpnmuUpECKZw/
	 X5KPykHVWtpz4jGuDqf7hOK9WXYFfiPHat4Xn2gm/E+TxdhGJRzpr7bagM/Sk8TMYT
	 b8gXe+RrTdKO00e37gCoEPL2k9myRmRqxlUDYrC2j/WT6nW3rrOrR4jx5kmw4+eGIT
	 R97WwvS5CVnUg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uS96I-00000003dGX-3LRu;
	Thu, 19 Jun 2025 08:50:18 +0200
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
Subject: [PATCH v7 00/17] Don't generate netlink .rst files inside $(srctree)
Date: Thu, 19 Jun 2025 08:48:53 +0200
Message-ID: <cover.1750315578.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi Jon,

As I sent two additional patches after the v6 that depends on
it, I'm opting to resend the series together with those extra
stuff.

-

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

v7:
- Added a patch to cleanup conf.py and address coding style issues;
- Added a docutils version check logic to detect known issues when
  building the docs with too old or too new docutils version.  The
  actuall min/max vesion depends on Sphinx version.

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
Mauro Carvalho Chehab (17):
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
  docs: conf.py: several coding style fixes
  docs: conf.py: Check Sphinx and docutils version

 Documentation/Makefile                        |  19 +-
 Documentation/conf.py                         | 445 +++++++++++-------
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
 tools/net/ynl/pyynl/lib/doc_generator.py      | 398 ++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_rst.py            | 384 +--------------
 16 files changed, 804 insertions(+), 582 deletions(-)
 create mode 100644 Documentation/netlink/specs/index.rst
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100644 Documentation/sphinx/min_requirements.txt
 create mode 100755 Documentation/sphinx/parser_yaml.py
 create mode 100644 tools/net/ynl/pyynl/lib/doc_generator.py

-- 
2.49.0




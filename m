Return-Path: <netdev+bounces-197449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0089AD8AF7
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FF31E3ECC
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7E82E7F0D;
	Fri, 13 Jun 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqUHB8bq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46EA2E2F04;
	Fri, 13 Jun 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814967; cv=none; b=Z/UcePKcJwDljXMNJtSjMdqAZgm4CuH78zUTN2Fg8HLLP/GT+jDuFLR3kgCF52pgOq5VmYMYNITujIDMWI5bvgR3vsYMsGZr35b2il+ZP4Oc935crlKsGaVowR1MnJnNj/rVtT1zJz9Rf/xuFv4j9csLdvL0eXnmcufRjAa5EdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814967; c=relaxed/simple;
	bh=YJOiv9Fg+7StoSeQOc/lTArM4eisD34MNRqSXkmMMkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tIUcLz740Qd0ebaPpPjIYS1kqqJrnu1+wW1QQrGzOmUKcPwZ9ZcDYejlsHbEJsKRNlRGdnHT8G0BUFdNKUd2BR1X5yFyLOPRWYXRBF0JyoCs1WD0h1srrSeMN1Vyt9qGb+f4W1gYJKDlujqls96MXRSe/a+HtZcFBfDq+FR72UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqUHB8bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D96C4CEF0;
	Fri, 13 Jun 2025 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749814966;
	bh=YJOiv9Fg+7StoSeQOc/lTArM4eisD34MNRqSXkmMMkU=;
	h=From:To:Cc:Subject:Date:From;
	b=cqUHB8bqw4DK2f/8OGIXHCCCSWdMpwS6cPAggdH2sFYFQMtFIIDL/uwng7RKVrZrO
	 TDoFFHH5SBm2BnuP5rAy4sCsW7oePO2sEH9a6fhggs2eQxuRdO+ilImaPw1JTjnZPc
	 AyIEDBnM1Eo3RaxPAFCWmFf0lCfiZNJu+LPwCe8b13CoV1dx+3SuiRVNCT+vzFBBW0
	 SdLvMKeP724cJphj2nKQV5f+EJmqO7sTtmCjktSRS+yv+dn1jjFCB4cy10rei62MRe
	 GopmR3guFRJW4hKrpQ74c1CxL5cyEGKe4S8z2Q+SUwV984SlLFL9J1G3XSh6rl2zKr
	 hx2M3RAUnMHNA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQ2o0-00000005dEh-1q1E;
	Fri, 13 Jun 2025 13:42:44 +0200
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
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v3 00/16] Don't generate netlink .rst files inside $(srctree)
Date: Fri, 13 Jun 2025 13:42:21 +0200
Message-ID: <cover.1749812870.git.mchehab+huawei@kernel.org>
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

There are some possible solutions for that. The simplest one is to places
the build files inside Documentation/output. The changes to do that are
simple enough, but has one drawback, as it requires a (simple) template file
for every netlink family file from netlink/specs. This was done on version
1 of this series.

Since version 2, we're addressing it the right Sphinx way: adding an
yaml parser extension. We opted to write such extension in a way that no
actual yaml conversion code is inside it. This makes it flexible enough
to handle other types of yaml files in the future. The actual yaml
conversion logic were placed at scripts/lib/netlink_yml_parser.py. The
existing command line tool was also modified to use the library ther.

With this version, there's no need to add any template file per netlink/spec
file. Yet, the Documentation/netlink/specs/index.rst require updates as
spec files are added/renamed/removed. The already-existing script can
update running:

            tools/net/ynl/pyynl/ynl_gen_rst.py -x  -v -o Documentation/netlink/specs/index.rst

Alternatively, someone could manually update the file. I tried to do the
index generation at build time, but it didn't work properly (at least
when using SPHINXDOCS).

-

I took some time to check Sphinx performance. On a Ryzen 9 7900 machine
(24 CPU threads), building with default "-j auto" mode is about
30% slower than using "-j8". The time to build with "-j8" there is similar
to the time of building with "-jauto" on a notebook with 8 CPU threads.

Maybe we should change the default at Documentation/sphinx/parallel-wrapper.sh
to use a better default than "auto".

On my machine, running it on python3.13t (thread-free) takes 5:35 minutes:

	$ time make -j8 htmldocs
	...
	<frozen importlib._bootstrap>:488: RuntimeWarning: The global interpreter lock (GIL) has been enabled to load module 'yaml._yaml', which has not declared that it can run safely without the GIL. To override this behavior and keep the GIL disabled (at your own risk), run with PYTHON_GIL=0 or -Xgil=0.
	...
	real    5m35,125s
	user    12m21,973s
	sys     2m29,956s

The non-thread-free version is a little bit slower:

	real    6m21,788s
	user    12m44,493s
	sys     1m48,337s

But it is still taking about the same time as before this change.

Both tests were done with Sphinx 8.2.3.

---

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

Mauro Carvalho Chehab (16):
  tools: ynl_gen_rst.py: create a top-level reference
  docs: netlink: netlink-raw.rst: use :ref: instead of :doc:
  docs: netlink: don't ignore generated rst files
  tools: ynl_gen_rst.py: make the index parser more generic
  tools: ynl_gen_rst.py: Split library from command line tool
  scripts: lib: netlink_yml_parser.py: use classes
  tools: ynl_gen_rst.py: do some coding style cleanups
  scripts: netlink_yml_parser.py: improve index.rst generation
  docs: sphinx: add a parser template for yaml files
  docs: sphinx: parser_yaml.py: add Netlink specs parser
  docs: use parser_yaml extension to handle Netlink specs
  docs: conf.py: don't handle yaml files outside Netlink specs
  docs: conf.py: add include_pattern to speedup
  docs: uapi: netlink: update netlink specs link
  MAINTAINERS: add maintainers for netlink_yml_parser.py
  docs: Makefile: disable check rules on make cleandocs

 .pylintrc                                     |   2 +-
 Documentation/Makefile                        |  19 +-
 Documentation/conf.py                         |  20 +-
 Documentation/netlink/specs/index.rst         |  38 ++
 Documentation/networking/index.rst            |   2 +-
 .../networking/netlink_spec/.gitignore        |   1 -
 .../networking/netlink_spec/readme.txt        |   4 -
 Documentation/sphinx/parser_yaml.py           |  80 ++++
 Documentation/userspace-api/netlink/index.rst |   2 +-
 .../userspace-api/netlink/netlink-raw.rst     |   6 +-
 Documentation/userspace-api/netlink/specs.rst |   2 +-
 MAINTAINERS                                   |   2 +
 scripts/lib/netlink_yml_parser.py             | 394 ++++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_rst.py            | 378 +----------------
 14 files changed, 553 insertions(+), 397 deletions(-)
 create mode 100644 Documentation/netlink/specs/index.rst
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100755 Documentation/sphinx/parser_yaml.py
 create mode 100755 scripts/lib/netlink_yml_parser.py

-- 
2.49.0



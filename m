Return-Path: <netdev+bounces-196904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403E4AD6DCB
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5DA17E4EA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954CF239E8B;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEwHVk26"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8423371F;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724344; cv=none; b=TCXQlNq3D1vanixMclU0mBzWXBlPaTwEgsLmonr6EmjGkV6zMAol1qb+Rj7Q4A+VmxcO8b452V3VnX+u1Q8MZkVfhlhT50a0E//aXNePB2AyqarwnLIAJ8/JqK8P5v0UorI6QOs1ll1pkFoKNrbWj3llIMWMZ9nr3Vj1EQuec+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724344; c=relaxed/simple;
	bh=czv1ppWf51VQn/WLMI/drbyNbJm4kBBkat2r5H82qC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f6q/3L2uPGpGBoTnNZ9Q/sWnT53xB8oDLeh7A7reALwomqg8T7Mo0Ao04yw3WThjQhasOqSmidsBz8W/4tCf8pvpRePmHBh6V3nURnP/0CX31HwVe2BOYLtbhwY/X2/pobY1KJSWQIVKvRAAoBVvEdkXUC8cIaq3EowOf13DsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEwHVk26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDACC4CEEA;
	Thu, 12 Jun 2025 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749724343;
	bh=czv1ppWf51VQn/WLMI/drbyNbJm4kBBkat2r5H82qC4=;
	h=From:To:Cc:Subject:Date:From;
	b=UEwHVk2615OuggDiyVOWsOuwEKYFJBgDRG+0efTpTdA1BhknQiZsEuLzViZrXAWTO
	 EWNt3d4tpaWECxY4xaCUMAQYe1Qojr5XSK4pTTPQAGiEik+Q5aurt4l5kTW6tL34cS
	 INBv6mZtYT455rnv56pD5VF28HLWES9CAV1ru9r4iDUmzl1IqG3AATRNX80BxCwZ9X
	 ydRHt8tRVVva6Kmf/b8goIOC3Jq+qwvu2jjK9jPjmabgnftBErvBnhlwU3kTCRVtmU
	 glzvE92MN6xY5jMz6KGkYrKtMv1OUYxySrPR9g4SEu8zGRGC6XreejhJnaw72eWkyt
	 18uTaaRoFZKvQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uPfEL-00000004yv2-3ta7;
	Thu, 12 Jun 2025 12:32:21 +0200
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
Subject: [PATCH v2 00/12] Don't generate netlink .rst files inside $(srctree)
Date: Thu, 12 Jun 2025 12:31:52 +0200
Message-ID: <cover.1749723671.git.mchehab+huawei@kernel.org>
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
added a logic which generates *.rst files inside $(srctree). This is bad when
O=<BUILDDIR> is used.

A recent change renamed the yaml files used by Netlink, revealing a bad
side effect: as "make cleandocs" don't clean the produced files, symbols 
appear duplicated for people that don't build the kernel from scratch.

There are some possible solutions for that. The simplest one, which is what
this series address, places the build files inside Documentation/output. 
The changes to do that are simple enough, but has one drawback,
as it requires a (simple) template file for every netlink family file from
netlink/specs. The template is simple enough:

        .. kernel-include:: $BUILDDIR/networking/netlink_spec/<family>.rst

Part of the issue is that sphinx-build only produces html files for sources
inside the source tree (Documentation/). 

To address that, add an yaml parser extension to Sphinx.

It should be noticed that this version has one drawback: it increases the
documentation build time. I suspect that the culprit is inside Sphinx
glob logic and the way it handles exclude_patterns. What happens is that
sphinx/project.py uses glob, which, on my own experiences, it is slow
(due to that, I ended implementing my own glob logic for kernel-doc).

On the plus side, the extension is flexible enough to handle other types
of yaml files, as the actual yaml conversion logic is outside the extension.

With this version, there's no need to add any template file per netlink/spec
file. Yet, the Documentation/netlink/spec.index.rst require updates as
spec files are added/renamed/removed. The already-existing script can
handle it automatically by running:

            tools/net/ynl/pyynl/ynl_gen_rst.py -x  -v -o Documentation/netlink/specs/index.rst

---

v2:
- Use a Sphinx extension to handle netlink files.

v1:
- Statically add template files to as networking/netlink_spec/<family>.rst

Mauro Carvalho Chehab (12):
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

 .pylintrc                                     |   2 +-
 Documentation/Makefile                        |  17 -
 Documentation/conf.py                         |  17 +-
 Documentation/netlink/specs/index.rst         |  38 ++
 Documentation/networking/index.rst            |   2 +-
 .../networking/netlink_spec/.gitignore        |   1 -
 .../networking/netlink_spec/readme.txt        |   4 -
 Documentation/sphinx/parser_yaml.py           |  80 ++++
 .../userspace-api/netlink/netlink-raw.rst     |   6 +-
 scripts/lib/netlink_yml_parser.py             | 394 ++++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_rst.py            | 378 +----------------
 11 files changed, 544 insertions(+), 395 deletions(-)
 create mode 100644 Documentation/netlink/specs/index.rst
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100755 Documentation/sphinx/parser_yaml.py
 create mode 100755 scripts/lib/netlink_yml_parser.py

-- 
2.49.0




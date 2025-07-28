Return-Path: <netdev+bounces-210577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE85B13F61
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9927A3A7662
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A4D272803;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcFmZ33E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711B1FDA7B;
	Mon, 28 Jul 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718542; cv=none; b=aF7oqbLdLZwOEFe5YCOF7Lx6uAd4/80D1+T+1BTtt8LIgUSmR86i20pPk5uA2hHHaEFnfoA9OTSVdRfdr9hVefvwgvz9yhgfqh/ezwFoLB5uOz8GBYMsTvn7otRjc/+n92F+grJyljPRMuN7HkFgzb7CTno95ua4ha8968CeRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718542; c=relaxed/simple;
	bh=AXDSigOIfNgykO/qtF5oUAFKeW574QGoSB0Kj22ksb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTHLzeN9Gau+K/2cRf+iFq3KO2TxaGJe3miIKcJjQz7+G/UBjIDM01ddsRKaMvBHpDMJAEmEzxVC/R2hIca5OXP1pOrkTB7KBjNJdmb/O1mmRB2OIVvgFuzuCD9uj2y/iXsRet0UBS7wlVBEPPxZlNqfAbRniS3fC3blm5XMKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcFmZ33E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7A1C4CEFA;
	Mon, 28 Jul 2025 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753718542;
	bh=AXDSigOIfNgykO/qtF5oUAFKeW574QGoSB0Kj22ksb0=;
	h=From:To:Cc:Subject:Date:From;
	b=QcFmZ33EDYUSO87dN3I2D2LoOokxpl60i4AbVu0ES6uTFmCibtRMOhLXjuEnx0yGX
	 rmHyNknqm9Rm9DIU+wdVN2uWqIQXIy9ojMD2TrevxflEIJQ3aQQk1dVCD6En8cWvDF
	 XCtnnehMoaSDFDp9MECAPMrRTrJ/wcZJgDDWBypKjfzQOV7rhysBNsgdV++hgVKyUp
	 PUMSC1o8owq+U1IBBtWnJC40tuQfCZ9kNe87kMvxXgJ1q3EsnXAF8cRgJAE0zmlhpT
	 ZxguhYnASRN72cgnZzpyZ+4W/gfBoQMv6oHDWdjS/QpYd+csfyfeCTn4Vp3H8dzfIW
	 c2GjA0WCcZslQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugQIq-00000000Gce-0rIm;
	Mon, 28 Jul 2025 18:02:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Message-ID :" <cover.1752076293.git.mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
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
	Randy Dunlap <rdunlap@infradead.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v10 00/14] Don't generate netlink .rst files inside $(srctree)
Date: Mon, 28 Jul 2025 18:01:53 +0200
Message-ID: <cover.1753718185.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Hi Jon,

That's the v10 version of the parser-yaml series, addressing a couple of
issues raised by Donald.

It should apply cleanly on the top of docs-next, as I just rebased on
the top of docs/docs-next.

Please merge it via your tree, as I have another patch series that will
depend on this one.

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

v10:
- added a R-B from Donald on patch 5;
- added an extra patch fixing issues with line numbers. I opted to
  make  it a separate patch, as this was not a trivial fix, and 
  I wanted to have it documented why the original way doesn't
  work, as this information can be useful in the future.

v9:
- did some cleanups due to changes caused by rebases;
- added some reviewed-by/reported-by/tested-by tags;
- addressed some pylint problems at the line numbering patch.

v8:
- minor fixes based on Donald's feedback;
- removed unrelated patches.

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


Mauro Carvalho Chehab (14):
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
  docs: parser_yaml.py: fix backward compatibility with old docutils
  sphinx: parser_yaml.py: fix line numbers information

 Documentation/Makefile                        |  17 -
 Documentation/conf.py                         |  20 +-
 Documentation/netlink/specs/index.rst         |  13 +
 Documentation/networking/index.rst            |   2 +-
 .../networking/netlink_spec/.gitignore        |   1 -
 .../networking/netlink_spec/readme.txt        |   4 -
 Documentation/sphinx/parser_yaml.py           | 123 ++++++
 Documentation/userspace-api/netlink/index.rst |   2 +-
 .../userspace-api/netlink/netlink-raw.rst     |   6 +-
 Documentation/userspace-api/netlink/specs.rst |   2 +-
 MAINTAINERS                                   |   1 +
 tools/net/ynl/pyynl/lib/__init__.py           |   2 +
 tools/net/ynl/pyynl/lib/doc_generator.py      | 398 ++++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_rst.py            | 384 +----------------
 14 files changed, 565 insertions(+), 410 deletions(-)
 create mode 100644 Documentation/netlink/specs/index.rst
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100755 Documentation/sphinx/parser_yaml.py
 create mode 100644 tools/net/ynl/pyynl/lib/doc_generator.py

-- 
2.49.0




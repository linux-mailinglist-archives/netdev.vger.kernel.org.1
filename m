Return-Path: <netdev+bounces-201457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DE6AE97EA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793181899F58
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB0B286D49;
	Thu, 26 Jun 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxuKds5k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D728507F;
	Thu, 26 Jun 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925628; cv=none; b=hkiLGhhPbVcp/aOH40blc5QMf5TSDVWUu8BSzfgmy8cgV2AQuSG6/6iqXM55vaLe/2pQ+3qzLt6E7aiG8TC4RcTgsD6GVfZ1Ifw1/fLqA0MHz3lHLCDorPFLbkMFmjAJFxjmIa3904yIfV3yB3SMW2jtnkGXm9gS3oYcgRYhnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925628; c=relaxed/simple;
	bh=4Ds3CT7EXhrNleQL/kIBhch+8tojlXLg8nqd2db1DTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhaWa61jIcjIGaapzH69V0geFR1E+NONbwnUh7ecRwvkBZrxYEN3UJOkG0ogZ41ETSk5XnIxDksIv6z9Vz6Wwgg3O95fIk4cIngVVvgRrcECu2dkjUM30d7SHugbxjGP+K/+Y6NZp6Bn3Nya7puGUQcyvRZfVq7Yos/C2w4uxKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxuKds5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A08C4CEEE;
	Thu, 26 Jun 2025 08:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925628;
	bh=4Ds3CT7EXhrNleQL/kIBhch+8tojlXLg8nqd2db1DTA=;
	h=From:To:Cc:Subject:Date:From;
	b=ZxuKds5kacgMzSW3KQrWzWcICLXlMFfiA/Bqbtl/DEuo8MDnlPmQHIM8fuBR4dH/5
	 tbUfstfzpB6FHQqQwTw6ZgpV9oJyY07qnR8gTVYgHRpIoJ4V3dimPES8Mt78OZYcJD
	 0oqs1anrUjLS4TLl60MM1Vo37ZA/SCmuwYM1f4ROn3S6Wbt14Ji5yvmKGetlBJnXb/
	 RO3Hap/ps+TFhAe6BNUnsSIzyGxIsNbOjBFP5Dv2GVdNbTJc5oq2wZ+PgOrrAymYxs
	 v3TvwL8mh9fLbI8U4wmrN10AJRivSff5njO0XmVyFTV64mro4QsXpfgph0PySkT8P4
	 8ptXlSlfk5uhw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uUhjT-00000004svP-0nHH;
	Thu, 26 Jun 2025 10:13:19 +0200
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
	Randy Dunlap <rdunlap@infradead.org>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>
Subject: [PATCH v8 00/13] Don't generate netlink .rst files inside $(srctree)
Date: Thu, 26 Jun 2025 10:12:56 +0200
Message-ID: <cover.1750925410.git.mchehab+huawei@kernel.org>
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

That's the newest version of the parser-yaml series, addressing the points
raised by Donald.

I dropped patches unrelated to the YAML work.  Those were already
merged at docs-next.

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


Mauro Carvalho Chehab (13):
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

 Documentation/Makefile                        |  17 -
 Documentation/conf.py                         |  20 +-
 Documentation/netlink/specs/index.rst         |  13 +
 Documentation/networking/index.rst            |   2 +-
 .../networking/netlink_spec/.gitignore        |   1 -
 .../networking/netlink_spec/readme.txt        |   4 -
 Documentation/sphinx/parser_yaml.py           | 116 +++++
 Documentation/userspace-api/netlink/index.rst |   2 +-
 .../userspace-api/netlink/netlink-raw.rst     |   6 +-
 Documentation/userspace-api/netlink/specs.rst |   2 +-
 MAINTAINERS                                   |   1 +
 tools/net/ynl/pyynl/lib/__init__.py           |   2 +
 tools/net/ynl/pyynl/lib/doc_generator.py      | 398 ++++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_rst.py            | 384 +----------------
 14 files changed, 558 insertions(+), 410 deletions(-)
 create mode 100644 Documentation/netlink/specs/index.rst
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100755 Documentation/sphinx/parser_yaml.py
 create mode 100644 tools/net/ynl/pyynl/lib/doc_generator.py

-- 
2.49.0




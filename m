Return-Path: <netdev+bounces-212830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25910B22350
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE50017DDD0
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F852E8DE7;
	Tue, 12 Aug 2025 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf7fzn4L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF812E7BB1;
	Tue, 12 Aug 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991218; cv=none; b=pJQCDj667lCoQipV+hvU+BvG438Wy7dTY7ruuHDFE1mMByIwWqNiADVtSJRWd/WvWyA39vAVqkNMN6GLeuEaDGb6bG0UKUnF4qjKau6e7y9DhAWDUoyBsRIiclOZrgTQLiuiYH1H+ZGnoLPJHKb3wKJNI8e39F1gZrTmM8oUiAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991218; c=relaxed/simple;
	bh=awVECIkj//NC3B2TraxKMvGe3uB8kJQ4UisWIm+eQEc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZIt/cdGj6rzmHeglkzty4Fi8htmJPaJyeO7L6pO+DD5Xm1nQ+LCirUsZ/PI2nuqi/0Nx2kTTATekkb0kIo9JuJzzXqJ5lzPToEiWDx3ujMqIz8YWiKCTECUF5uuiJu6hgXcM+sG+AdAXVaDzR7yFFhYpnhy11F/QkKDMpGrFGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf7fzn4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6FCC4CEF6;
	Tue, 12 Aug 2025 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754991217;
	bh=awVECIkj//NC3B2TraxKMvGe3uB8kJQ4UisWIm+eQEc=;
	h=Date:From:To:Cc:Subject:From;
	b=pf7fzn4LaH5bQkMgjAiTtoP7T8keIrINlrcT/r7eagYQZjVIg9rmj6TIq0QJO5qq/
	 lqcF8U7lezBatG5vitwCuO09s+OVWKNcPfw5O738QqQoh0q6W1ow0OPcmC3U8DHrCT
	 AqqyIUSYmOqd0CBPkQz/7fOSISfQIy9Y6FhP2ZyASwV2PAJiVD5FNLiwiBiJyNkrsw
	 p2B8/sXnDkizhStV548h/jyNap1kTeeZ1C8KCzrkxYuQzP13gtbX568ZHtyNTPdhAP
	 vnyzJdK5obpPEMR+7OzHZntbzFX/Q4TJ5QaIdSvcooAuKO4ipSZ3jGag4Ye37zBCTl
	 iufHl20YZyiQg==
Date: Tue, 12 Aug 2025 11:33:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>
Cc: EDAC Mailing List <linux-edac@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, "David S. Miller" <davem@davemloft.net>, Ignacio
 Encinas Rubio <ignacio@iencinas.com>, Marco Elver <elver@google.com>, Shuah
 Khan <skhan@linuxfoundation.org>, Donald Hunter <donald.hunter@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jan Stancek <jstancek@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu, Breno Leitao <leitao@debian.org>, Randy Dunlap
 <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>
Subject: [GIT PULL for v6.17-rc2] add a generic yaml parser integrated with
 Netlink specs generation
Message-ID: <20250812113329.356c93c2@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jon/Jakub,

In case you both prefer to merge from a stable tag, please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git docs/v6.17-1

For:

- An YAML parser Sphinx plugin, integrated with Netlink YAML doc
  parser.

The patch content is identical to my v10 submission:

	https://lore.kernel.org/linux-doc/cover.1753718185.git.mchehab+huawei@kernel.org/

The tag was rebased on the top of v6.17-rc1 to make easier for it to be
merged on both docs and netlink trees. 

No code changes since v10.

Regards,
Mauro

---

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git tags/docs/v6.17-1

for you to fetch changes up to 47459937be8031aae6aaa17ac5f60985f7c9e1bd:

  sphinx: parser_yaml.py: fix line numbers information (2025-08-12 07:47:31 +0200)

----------------------------------------------------------------
[GIT PULL for v6.17-rc2] add a generic yaml parser integrated with Netlink specs generation

----------------------------------------------------------------
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

 Documentation/Makefile                             |  17 -
 Documentation/conf.py                              |  20 +-
 Documentation/netlink/specs/index.rst              |  13 +
 Documentation/networking/index.rst                 |   2 +-
 Documentation/networking/netlink_spec/.gitignore   |   1 -
 Documentation/networking/netlink_spec/readme.txt   |   4 -
 Documentation/sphinx/parser_yaml.py                | 123 +++++++
 Documentation/userspace-api/netlink/index.rst      |   2 +-
 .../userspace-api/netlink/netlink-raw.rst          |   6 +-
 Documentation/userspace-api/netlink/specs.rst      |   2 +-
 MAINTAINERS                                        |   1 +
 tools/net/ynl/pyynl/lib/__init__.py                |   2 +
 tools/net/ynl/pyynl/lib/doc_generator.py           | 398 +++++++++++++++++++++
 tools/net/ynl/pyynl/ynl_gen_rst.py                 | 384 +-------------------
 14 files changed, 565 insertions(+), 410 deletions(-)
 create mode 100644 Documentation/netlink/specs/index.rst
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100755 Documentation/sphinx/parser_yaml.py
 create mode 100644 tools/net/ynl/pyynl/lib/doc_generator.py


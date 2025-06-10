Return-Path: <netdev+bounces-196040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5769AD33F0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC891895EE5
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D60327F72C;
	Tue, 10 Jun 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jah7FvlS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FC38633F;
	Tue, 10 Jun 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552385; cv=none; b=njpDuDceRfplE2x8ma/rclsFBW0UFb1dehTHUueL4Ms2zgZeQ6SmlQbDNjbHQMrVFTfMRuGzcbB+dFt0UxZUUA580qR872sn2oyw8GOofzQ8bnZv0H57sFh/LcyK1PjpN8y/6rN44Jvxa1RF58d4FDHOXGcY0HXCWzTm7VYCmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552385; c=relaxed/simple;
	bh=F5ZJdtnuqszCHHCZyY87KKWQfWO3tidioj3+glAwUg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqmY/Zl5mJDeXKWLUE19vwwmCrT0C9G16v90VYclR9Va+mIn5Bz/WEzznT5lFMFo0Cria81dKCgorZitH8LsCh2J+SWFE72JmDWQnkpGhZRrYTasGLM3uPGLiSYm4OLD+TRhodI2uv3cucf3eb3ZX+uiUYvsBE3d/jMGD4/U8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jah7FvlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C280EC4AF0B;
	Tue, 10 Jun 2025 10:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749552384;
	bh=F5ZJdtnuqszCHHCZyY87KKWQfWO3tidioj3+glAwUg4=;
	h=From:To:Cc:Subject:Date:From;
	b=jah7FvlSBOEU1Tx/ubjiTY323LSIJaAKfLNoGWMOFPgT9K7pjiIhXLfNe12oROD1z
	 JpE7jeV4b9DsUkjACSGM+OTDNRtRawfIyrMAthZDIpzyOSRZ+yGLVZLKttz63e6wzv
	 wrmsrSv8Ytu3KwLCBoSkxwfPEYpZkmzi7Wqaja7Os6uu0lfivKGXs34JbHIbaVrHQM
	 cZngmdErsqCRNYLJ/lOi4wfXp6dUonrLhvqGD+/T7kju8mgdgBLKyaqmIwMod97X3L
	 b+QXZrkCqdVfgLZ9l2cI095eDGMyCIrHw5pZPnjfwl8P5HBsx2Pm2bAp1B+LeANXtj
	 ZBIzvppriCKcA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uOwUo-00000003jur-3Qzh;
	Tue, 10 Jun 2025 12:46:22 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	peterz@infradead.org,
	stern@rowland.harvard.edu,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ignacio Encinas Rubio <ignacio@iencinas.com>,
	lkmm@lists.linux.dev,
	Marco Elver <elver@google.com>,
	Breno Leitao <leitao@debian.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ruben Wauters <rubenru09@aol.com>,
	Simon Horman <mchehab+huawei@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH 0/4] Don't generate netlink .rst files inside $(srctree)
Date: Tue, 10 Jun 2025 12:46:03 +0200
Message-ID: <cover.1749551140.git.mchehab+huawei@kernel.org>
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
inside the source tree (Documentation/).  Well, such requirement
is already fulfilled, as we do have one *.yaml file per family inside
Documentation/netlink, but those aren't currently processed by Sphinx,
as Documentation/conf.py currently has only:

	source_suffix = ['.rst']

To address that, a long term solution is to add '.yaml' to source_suffix
and add an extension at Documentation/sphinx that parses *.yaml files.
Something similar to:

	https://github.com/Jakski/sphinxcontrib-autoyaml

This could internally call ynl_gen_rst.py, but some  care is needed, as 
the yaml extension is also used by devicetree. 

Mauro Carvalho Chehab (4):
  tools: ynl_gen_rst.py: create a top-level reference
  docs: netlink: netlink-raw.rst: use :ref: instead of :doc:
  docs: netlink: don't ignore generated rst files
  docs: netlink: store generated .rst files at Documentation/output

 Documentation/Makefile                        |  8 +++----
 .../networking/netlink_spec/.gitignore        |  1 -
 .../networking/netlink_spec/conntrack.rst     |  3 +++
 .../networking/netlink_spec/devlink.rst       |  3 +++
 .../networking/netlink_spec/dpll.rst          |  3 +++
 .../networking/netlink_spec/ethtool.rst       |  3 +++
 Documentation/networking/netlink_spec/fou.rst |  3 +++
 .../networking/netlink_spec/handshake.rst     |  3 +++
 .../networking/netlink_spec/index.rst         |  6 +++++
 .../networking/netlink_spec/lockd.rst         |  3 +++
 .../networking/netlink_spec/mptcp_pm.rst      |  3 +++
 .../networking/netlink_spec/net_shaper.rst    |  3 +++
 .../networking/netlink_spec/netdev.rst        |  3 +++
 .../networking/netlink_spec/nfsd.rst          |  3 +++
 .../networking/netlink_spec/nftables.rst      |  3 +++
 .../networking/netlink_spec/nl80211.rst       |  3 +++
 .../networking/netlink_spec/nlctrl.rst        |  3 +++
 .../networking/netlink_spec/ovpn.rst          |  3 +++
 .../networking/netlink_spec/ovs_datapath.rst  |  3 +++
 .../networking/netlink_spec/ovs_flow.rst      |  3 +++
 .../networking/netlink_spec/ovs_vport.rst     |  3 +++
 .../networking/netlink_spec/readme.txt        |  4 ----
 .../networking/netlink_spec/rt-addr.rst       |  3 +++
 .../networking/netlink_spec/rt-link.rst       |  3 +++
 .../networking/netlink_spec/rt-neigh.rst      |  3 +++
 .../networking/netlink_spec/rt-route.rst      |  3 +++
 .../networking/netlink_spec/rt-rule.rst       |  3 +++
 Documentation/networking/netlink_spec/tc.rst  |  3 +++
 .../networking/netlink_spec/tcp_metrics.rst   |  3 +++
 .../networking/netlink_spec/team.rst          |  3 +++
 .../userspace-api/netlink/netlink-raw.rst     |  6 ++---
 tools/net/ynl/pyynl/ynl_gen_rst.py            | 24 ++++++++++++-------
 32 files changed, 107 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore
 create mode 100644 Documentation/networking/netlink_spec/conntrack.rst
 create mode 100644 Documentation/networking/netlink_spec/devlink.rst
 create mode 100644 Documentation/networking/netlink_spec/dpll.rst
 create mode 100644 Documentation/networking/netlink_spec/ethtool.rst
 create mode 100644 Documentation/networking/netlink_spec/fou.rst
 create mode 100644 Documentation/networking/netlink_spec/handshake.rst
 create mode 100644 Documentation/networking/netlink_spec/index.rst
 create mode 100644 Documentation/networking/netlink_spec/lockd.rst
 create mode 100644 Documentation/networking/netlink_spec/mptcp_pm.rst
 create mode 100644 Documentation/networking/netlink_spec/net_shaper.rst
 create mode 100644 Documentation/networking/netlink_spec/netdev.rst
 create mode 100644 Documentation/networking/netlink_spec/nfsd.rst
 create mode 100644 Documentation/networking/netlink_spec/nftables.rst
 create mode 100644 Documentation/networking/netlink_spec/nl80211.rst
 create mode 100644 Documentation/networking/netlink_spec/nlctrl.rst
 create mode 100644 Documentation/networking/netlink_spec/ovpn.rst
 create mode 100644 Documentation/networking/netlink_spec/ovs_datapath.rst
 create mode 100644 Documentation/networking/netlink_spec/ovs_flow.rst
 create mode 100644 Documentation/networking/netlink_spec/ovs_vport.rst
 delete mode 100644 Documentation/networking/netlink_spec/readme.txt
 create mode 100644 Documentation/networking/netlink_spec/rt-addr.rst
 create mode 100644 Documentation/networking/netlink_spec/rt-link.rst
 create mode 100644 Documentation/networking/netlink_spec/rt-neigh.rst
 create mode 100644 Documentation/networking/netlink_spec/rt-route.rst
 create mode 100644 Documentation/networking/netlink_spec/rt-rule.rst
 create mode 100644 Documentation/networking/netlink_spec/tc.rst
 create mode 100644 Documentation/networking/netlink_spec/tcp_metrics.rst
 create mode 100644 Documentation/networking/netlink_spec/team.rst

-- 
2.49.0




Return-Path: <netdev+bounces-196901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4543AD6DC9
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E12174F5C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B3A2356CB;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Frmjlb8d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE922FAC3;
	Thu, 12 Jun 2025 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724344; cv=none; b=T95w6O2JBYqMn/YajTtugrle7AAxK6Qst/zp5a4sZ//rcNU9/uH3lpQVpIXsNe5fvaHWQyyEhgP+ow2iyupwv4Kl05NSACID8nC+blAPIUThsCmEkKkzjDYR/e+U5Lp9eVPNvCJRCQpmrcwiDkAkiV9Zfwq/r5TypQzxNtaGjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724344; c=relaxed/simple;
	bh=nVMNn0VSngYDSLAUJezTR2b19OzJ86I1XkvSWoGjSbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pirxhlxAC/a4lnpY40zq/PiWigU8HMe09RZP6vR0sqs7VpFQ4W7abdBpgzm0o2mqK8XGqZj8cj9jJ3v8QxidXfdraDmSOYfhzGvpPm2sjxeC7RYMTRekJX2ut61eObo+Bq7lCuCveM2d5xgeTjaPUsDAfdaf8G0a6ur+m1DzQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Frmjlb8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EB8C4CEF1;
	Thu, 12 Jun 2025 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749724344;
	bh=nVMNn0VSngYDSLAUJezTR2b19OzJ86I1XkvSWoGjSbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Frmjlb8dtgO48XvFAdPuTxYhDYKcBFzGt7ZRjxuCJhF4OXj9hpXofqzOG5hb7cMBW
	 q/J5fRL1xWnQwqkZGL5DhdoNQ/QqbowLv6NdDFqlQ2du9D6KyrmeoAt4dQsWBNL9m+
	 7YtC2txWNucD27ir6klSf84OifHPrzB3//NGvC5jCxWgrlLohvLWBy9XILJMi/p2vI
	 7toskAJFDyeA+amwI93kITiDd1A2/WK06bolb1Chq9WFI9noJ3noIgEAapuamHusIq
	 wKww2EHwIAPIBR0hc7kt06Z+wqemMRhdVVg4X1W4Z7wiM4vLBSB1wPTVN7Au896bh9
	 WBCk14dlxr1xA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uPfEM-00000004yvE-0SLU;
	Thu, 12 Jun 2025 12:32:22 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Donald Hunter" <donald.hunter@gmail.com>,
	"Eric Dumazet" <edumazet@google.com>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Jan Stancek" <jstancek@redhat.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Ruben Wauters" <rubenru09@aol.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH v2 03/12] docs: netlink: don't ignore generated rst files
Date: Thu, 12 Jun 2025 12:31:55 +0200
Message-ID: <1cf12ab4c027cf27decf70a40aafdd0e2f669299.1749723671.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749723671.git.mchehab+huawei@kernel.org>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Currently, the build system generates ReST files inside the
source directory. This is not a good idea, specially when
we have renames, as make clean won't get rid of them.

As the first step to address the issue, stop ignoring those
files. This way, we can see exactly what has been produced
at build time inside $(srctree):

        Documentation/networking/netlink_spec/conntrack.rst
        Documentation/networking/netlink_spec/devlink.rst
        Documentation/networking/netlink_spec/dpll.rst
        Documentation/networking/netlink_spec/ethtool.rst
        Documentation/networking/netlink_spec/fou.rst
        Documentation/networking/netlink_spec/handshake.rst
        Documentation/networking/netlink_spec/index.rst
        Documentation/networking/netlink_spec/lockd.rst
        Documentation/networking/netlink_spec/mptcp_pm.rst
        Documentation/networking/netlink_spec/net_shaper.rst
        Documentation/networking/netlink_spec/netdev.rst
        Documentation/networking/netlink_spec/nfsd.rst
        Documentation/networking/netlink_spec/nftables.rst
        Documentation/networking/netlink_spec/nl80211.rst
        Documentation/networking/netlink_spec/nlctrl.rst
        Documentation/networking/netlink_spec/ovs_datapath.rst
        Documentation/networking/netlink_spec/ovs_flow.rst
        Documentation/networking/netlink_spec/ovs_vport.rst
        Documentation/networking/netlink_spec/rt_addr.rst
        Documentation/networking/netlink_spec/rt_link.rst
        Documentation/networking/netlink_spec/rt_neigh.rst
        Documentation/networking/netlink_spec/rt_route.rst
        Documentation/networking/netlink_spec/rt_rule.rst
        Documentation/networking/netlink_spec/tc.rst
        Documentation/networking/netlink_spec/tcp_metrics.rst
        Documentation/networking/netlink_spec/team.rst

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/netlink_spec/.gitignore | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/networking/netlink_spec/.gitignore

diff --git a/Documentation/networking/netlink_spec/.gitignore b/Documentation/networking/netlink_spec/.gitignore
deleted file mode 100644
index 30d85567b592..000000000000
--- a/Documentation/networking/netlink_spec/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-*.rst
-- 
2.49.0



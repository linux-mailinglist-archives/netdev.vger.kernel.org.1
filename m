Return-Path: <netdev+bounces-197736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA58AD9B76
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9AB17BD85
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46CF298261;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVjE2+p6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634731E991B;
	Sat, 14 Jun 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749891378; cv=none; b=EN9SnkiHKDs7aJQ63AT5BrmyXEzqaZNfrB+6zZGcCUfq/Ybo0pPNn7bKokvT3+8l5hdbiQ32s3dUXKI0Aqv4pIi6Tj/5iVY4ZMIQh/83eboYdrj1QlkMeYWyyURnrD7Gpe+8Un05V8soJN/LAqRdl7v9I5+DWzul/PtitfV397s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749891378; c=relaxed/simple;
	bh=nVMNn0VSngYDSLAUJezTR2b19OzJ86I1XkvSWoGjSbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATgnxt1+Qz4CYs9vMj0eZmCnzG7v28Q470sf9rYATzacCxKyYFH9MkHGHP1aWLl7lOwG1/tQkgrHuDBWEDFTTkoUkEjvbHsDZCZ8fU5Eb1aDvHZPgXrwBlqGNAu/qyrMOI+gFIfoeUikNhwYY0WeQGEQaDn8gcB8aKSGOhWq4vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVjE2+p6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23C8C4CEF0;
	Sat, 14 Jun 2025 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749891378;
	bh=nVMNn0VSngYDSLAUJezTR2b19OzJ86I1XkvSWoGjSbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVjE2+p6DMNi0/6HW/eClvFnJuABscnX65t/MQFmNMtpkuKkOnjin6f2iw9AQTLke
	 xPqX+NBm6gUv6VohevhM87xaVRsLKE7Gg6sT+SHkMRhDXDEBG/AnPn3ucar2PQ9ME2
	 6SOfJXWMNP4XY2FMbt0HB3Xavt6hlp5uYmdJTtA6Vp/KEUHshiKBBmIBFO/Gzj1mmm
	 aMsluO/2zFcQAcFBC3bWmp4FxCr9VfgwuEzEqCny1oivUnAh8a+kkWtRol6Xq1nf7r
	 +XBIVis1Bo0y5LqDT4H7xPtMt88FEyIVyl+Z67TF2CRSyHVlA+YmGQIBf4UkEdVy0s
	 jwjc9bEKamQxA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQMgS-000000064ap-0CB8;
	Sat, 14 Jun 2025 10:56:16 +0200
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
Subject: [PATCH v4 03/14] docs: netlink: don't ignore generated rst files
Date: Sat, 14 Jun 2025 10:55:57 +0200
Message-ID: <1cf12ab4c027cf27decf70a40aafdd0e2f669299.1749891128.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749891128.git.mchehab+huawei@kernel.org>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
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



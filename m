Return-Path: <netdev+bounces-196042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113EAAD33F3
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D899B3A6294
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7409928C2C9;
	Tue, 10 Jun 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2mM573p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC5C1E1C1A;
	Tue, 10 Jun 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552385; cv=none; b=HkfYoWNTbx+fZ6AuOrCeirLl6L63IdzUolDTF1Jc7hmkcF52v3ajj4bGgGDaeM8cCynqxB8LwA+hB5NOeCS3JpoQGx7A5Sy9950O8IVyS1TM/XZ5Xk93UkfSpAOBx6ez/qs/eXljzGLqNh5IyRKvCxgNuTnR1NeQvddxq+yn/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552385; c=relaxed/simple;
	bh=nVMNn0VSngYDSLAUJezTR2b19OzJ86I1XkvSWoGjSbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoMFn5/ElIKExVSYzS36dU7uj0TZ/RvHCYeF2/12Hoy29i5Mj9eSgdCg7Uak5tQtrmgisy1AZNjtYwSulK7UmqB/KRf1OJ0CLLbhWdI6n8P/celEpCvF8u6mieC+17Gl4zAMp9S6WHIix1lBEiEDxWb4X1bwRgRDSx3YaiQ/VNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2mM573p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07F6C4CEF2;
	Tue, 10 Jun 2025 10:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749552384;
	bh=nVMNn0VSngYDSLAUJezTR2b19OzJ86I1XkvSWoGjSbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2mM573px73KHRx8sQXqbhIdJNRe3oVbZRNBz1N6TgLaGiBmkS+HVTR/Fyo2PHoe/
	 d6tY/TxNxbqFFMvtIJyhiCbvPOdticz3ELLdebqIiCN/CtcGEaa2zNC+aZ0KL1dB0a
	 FrrjQUcTRXx8lpUsI558zi0aQzpFN8EZn7o7dypOWNmtg9GSwXsXeCE305o4BRxCxg
	 K9ecy+bgD2pRQmx2DItTKQo/DebZ1zYFlhBnjz6LHtCbuhoJ5AsbIZyX8u6EqnPtl3
	 baq4cYqlgMohXdrnoXjr0eiBTGsJl8zObShPZR2Q2Er/nIqz6zEWEbnI/prDTKIDsO
	 EfgLcC0fURJeA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uOwUp-00000003jv3-04QX;
	Tue, 10 Jun 2025 12:46:23 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Breno Leitao" <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Ignacio Encinas Rubio" <ignacio@iencinas.com>,
	"Marco Elver" <elver@google.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	"Paul E. McKenney" <mchehab+huawei@kernel.org>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <mchehab+huawei@kernel.org>,
	joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: [PATCH 3/4] docs: netlink: don't ignore generated rst files
Date: Tue, 10 Jun 2025 12:46:06 +0200
Message-ID: <1cf12ab4c027cf27decf70a40aafdd0e2f669299.1749551140.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749551140.git.mchehab+huawei@kernel.org>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
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



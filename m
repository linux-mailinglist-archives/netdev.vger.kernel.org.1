Return-Path: <netdev+bounces-197446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51CCAD8B03
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A0E3BBD75
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6702E2F14;
	Fri, 13 Jun 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iseCSxCn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B12D8798;
	Fri, 13 Jun 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814967; cv=none; b=elsSeBWzMaSXSxanTYHthDQ5nNjPx6bZL8MmBy32V8papym5mNqGaydmtu1ysb1WYu7PUTymv3lUnHR8/KFz8/YayNN9IggTi2NxGiBpeTJSq10OaHFr7dBHgjW+Y3JvTZty7GUIlkYblltxuORIgN0ngM52pFDM7vNzT7z4EDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814967; c=relaxed/simple;
	bh=nVMNn0VSngYDSLAUJezTR2b19OzJ86I1XkvSWoGjSbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRpz+FtuZmlhBQXhZlHlt+B5dGSlsMEvrTKX4wBZ/KTvs1q7ezafuSq0dGEsdvsSB6RNg7G2gcnmZDQhmoGFx3nNQqSAe1BqodvpWYHbbF9t72XE9LjlapFoqi1KbuD36VY21EGymS9tg6rmKuGoj4Eqc1UnmnAm0BA1KOLCAf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iseCSxCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8848FC4CEF1;
	Fri, 13 Jun 2025 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749814966;
	bh=nVMNn0VSngYDSLAUJezTR2b19OzJ86I1XkvSWoGjSbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iseCSxCnlDuhCFoik+zsyW1hS+dvI8LFmQkqNzeKQXrmtIQMqVdQRfDsddXgoFyGr
	 vdFDu1+Fo2rnKsLmGt03+a6EL8sCxiw6FjwZBbb/FDBfqqAcbDHw6srZf/SZ8Wkfc8
	 LPN8AUDeHtE+zi17SL2y6EdGg6HVaBRO6Iop6dOkdqWAXoRK0wRPKrXWJZwZc23kAY
	 rDOCoFgTa3y2+QeJKmMIWCpv54OXB2bWWTwnax2iQkDt+V1Bi2euQieLaRinw/HHy2
	 kpAqJBLQmeh3021zP3dVWrMwTk2nszWTzitkMMjWEGOM/MxrGroeTym/RjtM4Bm4iq
	 4UuKTg1Ygk1dg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uQ2o0-00000005dEt-2cmm;
	Fri, 13 Jun 2025 13:42:44 +0200
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
Subject: [PATCH v3 03/16] docs: netlink: don't ignore generated rst files
Date: Fri, 13 Jun 2025 13:42:24 +0200
Message-ID: <1cf12ab4c027cf27decf70a40aafdd0e2f669299.1749812870.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749812870.git.mchehab+huawei@kernel.org>
References: <cover.1749812870.git.mchehab+huawei@kernel.org>
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



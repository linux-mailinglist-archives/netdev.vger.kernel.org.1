Return-Path: <netdev+bounces-295488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wkO5MXQYImq8SQEAu9opvQ
	(envelope-from <netdev+bounces-295488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:29:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 323416441C1
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 02:29:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="DW4A8I/X";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295488-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295488-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 208D430377A6
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 00:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EDF1990C7;
	Fri,  5 Jun 2026 00:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F021BCA6F
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 00:29:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619377; cv=none; b=hv3mv+6pykrieWTWlJu+hwp7qlJshxOqlv7ISDqUbgRe9XnAYDuw9/0wzYdvOD0jzPaOMUV9ZcJDwWHDFCvKzff7H8yW3RYPh6tMp5phVROqO2xW1gcacIyrH2EirH3pSfv8M1I/eUAluELXYdtyMJJqum/oyfCM3bpiey9Ov/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619377; c=relaxed/simple;
	bh=XDrIFfYejMWIXqRNlWgrd9Xs/2HYZ+u+Gc4pqx5Epn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmkqGAADjN/vrZ1VOt2SdbKtG0cC1Wmic1X/GtmGPdTzUqR9+O1+yTs0d34K06R+UcZ+iM+hdsSSwgMIZ2MSXSSxdHshBzq5x9JVYvHJtDPKPyC14EIXg2LLSjZL9NcpOT0h+/PJYn8q9XfNzlddxjJHRVrxQGFrvGVMC7rkJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW4A8I/X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68ED1F00893;
	Fri,  5 Jun 2026 00:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619375;
	bh=nnvVXOVQb6kAEUOzYlpn/ITzwYxCQs0dOmZ9v6+04pw=;
	h=From:To:Cc:Subject:Date;
	b=DW4A8I/Xct97EaBUdYICjjDrBVgds6Ee+3g/LqTgD9Ha5/Dwg8yb1ORh8m9YU5Ml5
	 6SiLRUQ8ywcEdj/IEwI/A2yVSh6P/jB0z0VA5R+wMal65DSaA1W1Cqj6aZ9qJ/bNQ7
	 fbbBlcmawfdyyWL/AF1Jx7LvL4EHZbOhpylWksOrbzB7GWfQuuU5TpImrQTMCXzbgH
	 yvDQGBa4IR0aLhLbjHQ+/z355T1j3gnOHdFe4rnI8JQ5uKMxIlkMPhZhFvKRDhsjIv
	 B3fHj7yXfdG7+lgmd0YyoKmEWdDlmeRP/p+D6XSGBiUUc2fqO1f0x+WlK60CcjUvbg
	 VzyJYNhC9lbUg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	hkallweit1@gmail.com,
	maxime.chevallier@bootlin.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	alexanderduyck@fb.com,
	willemb@google.com,
	jacob.e.keller@intel.com,
	kory.maincent@bootlin.com,
	sdf.kernel@gmail.com,
	jakub@cloudflare.com,
	nb@tipi-net.de,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 00/12] net: ethtool: let ops locked drivers run without rtnl_lock
Date: Thu,  4 Jun 2026 17:29:00 -0700
Message-ID: <20260605002912.3456868-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295488-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:kuba@kernel.org,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 323416441C1

With the ethtool_get_link_ksettings() situation hopefully ironed out
the previous series (commit 6a5d837f0ce2) let's return to the main
part of the series.

We have been slowly moving towards removing the rtnl_lock dependency
in driver ops since the concept of "ops-locked" drivers have been
introduced last year. Since last year will take the netdev instance
lock before invoking any ndo or ethtool op of "ops-locked" drivers.

We dipped our toes into rtnl_lock-less ops with the queue binding API.
Queue stats, NAPI, and other netdev-netlink objects are also queried
without holding rtnl_lock already. It's time to take the next logical
step and lift the requirement from ethtool ops.

The direct motivation for this patchset is that ethtool ops often
involve communicating with device FW, and may take a long time
to complete. Aggressive polling of device state on machines
with 10+ NICs have been shown to significantly increase rtnl_lock
pressure.

There's a handful of areas which still need rtnl_lock (see below).
I decided to convert everything to rtnl_lock-less by default, and
add a set of flags which let the drivers request rtnl_lock to still
be taken. I don't love this, but I'm worried that opt-in would be
even more confusing.

Known issues / exclusions:
 - qdiscs - qdisc configuration currently assumes rtnl_lock, this
   is mostly impacting set_channels callback. qdisc config is probably
   the easiest one of the exclusions to tackle, it's fairly self-contained.
 - features - even tho feature changes are (correctly) plumbed to
   the driver thru ndos they are part of ethtool uAPI. ethtool itself
   calls netdev_features_change() if it has spotted device feature change
   before vs after to the callback. Some drivers also call
   netdev_features_change() directly in response to various changes,
   e.g. setting priv flags.
   Since features have to propagate to upper and lower devices anything
   that touches features is quite hard to move from under rtnl_lock.
 - phylink - phylink and SFP depend on rtnl_lock today, I suspect
   that this is purely for historic reasons. I started poking at
   it and don't really see a need for a global lock. But accessing
   the netdev instance lock from the SFP entry points will require
   some attention from the phylink folks.
 - phydev - similar to phylink, looks quite doable. But no ops-locked
   driver currently has a phydev (fbnic only uses phylink) so phydev
   related paths retain a ASSERT_RTNL() for now.

Tested on mlx5, bnxt and fbnic.

Jakub Kicinski (12):
  net: ethtool: serialize broadcast notification sequence allocation
  net: ethtool: relax ethnl_req_get_phydev() locking assertion
  net: ethtool: make dev->hwprov ops-protected
  net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops
  net: ethtool: optionally skip rtnl_lock on Netlink path for SET ops
  net: ethtool: optionally skip rtnl_lock in cable test handlers
  net: ethtool: optionally skip rtnl_lock in ethnl_tsinfo_dumpit()
  net: ethtool: optionally skip rtnl_lock in ethnl_act_module_fw_flash()
  net: ethtool: optionally skip rtnl_lock in RSS context handlers
  net: ethtool: ioctl: concentrate the locking
  net: ethtool: optionally skip rtnl_lock on IOCTL path
  docs: net: ethtool: document ops-locked drivers and op_needs_rtnl

 Documentation/networking/netdev-features.rst  |   7 +
 Documentation/networking/netdevices.rst       |  17 ++-
 include/linux/ethtool.h                       |  36 ++++-
 include/linux/netdevice.h                     |   3 +
 include/linux/phy_link_topology.h             |   5 +
 include/net/netdev_lock.h                     |  11 ++
 net/ethtool/common.h                          |  76 +++++++++++
 net/ethtool/netlink.h                         |   8 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +
 drivers/net/ethernet/google/gve/gve_ethtool.c |   6 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   3 +
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   2 +
 .../mellanox/mlx5/core/ipoib/ethtool.c        |   2 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |   5 +
 .../ethernet/microsoft/mana/mana_ethtool.c    |   2 +
 drivers/net/netdevsim/ethtool.c               |   1 +
 drivers/net/phy/phy_device.c                  |   3 +
 drivers/net/phy/phy_link_topology.c           |  10 ++
 net/core/dev_ioctl.c                          |   4 +-
 net/ethtool/cabletest.c                       |  12 +-
 net/ethtool/ioctl.c                           | 123 ++++++++++++++----
 net/ethtool/mm.c                              |   5 +-
 net/ethtool/module.c                          |   6 +-
 net/ethtool/netlink.c                         |  62 ++++++---
 net/ethtool/phy.c                             |   1 -
 net/ethtool/rss.c                             |  21 +--
 net/ethtool/tsconfig.c                        |  10 +-
 net/ethtool/tsinfo.c                          |  32 +++--
 28 files changed, 363 insertions(+), 114 deletions(-)

-- 
2.54.0



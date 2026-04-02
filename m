Return-Path: <netdev+bounces-274723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP9UMfbzzmmzsAYAu9opvQ
	(envelope-from <netdev+bounces-274723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:55:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2432B38EE7C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64388301A385
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98723D47C1;
	Thu,  2 Apr 2026 22:55:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E88D395DB8
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170538; cv=none; b=FdLSmMJN1e3Uj0cQTve0gFr/uBoOyn862YShGpzHQos38N7RN0n6JsuML7iq1CFiUR/ASsywXkHXseAlyjDYm9f2NsVCy/wc+pVoHvhup5JEAbLRCTnWRSqJ/LtLXqn4oJToJT+UxLvSaxIjhTRJjpjTtTKBM9/TGQya/VgEQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170538; c=relaxed/simple;
	bh=8hqtSi+Bf3KCOzidUm6b9bgSwAQ2jTdUD2y3aViRsgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRz8Gxrv1AQABvenk63rFbdy6fxXv4eccrLPflyS+EBpRXk/KJ+ebVbc+gT6D/AnpfbyNEOc4Q5ZH4q03YUFuwcpbgD+VjuY0GbdJVi6+04URV6CpSXhYGE9s/UHYWH9ZjYmrItDz764r5LU9uXDF/SE85LeSAywIanLdBXAuCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2cbdd9852aaso551908eec.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170536; x=1775775336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKmb/TlwFnp6aM6zkeeeQezrPG4kRd3+fGqJs9mu71Q=;
        b=X4WWTmx7QMDgdJO236IUN3YzDKjwlIeOJLdvuqfz46DzWFVZ4LtHHH9l2d44TgTZww
         EWHQq7nCegS1zIAwgR5IcOzWOAQD7CMGm4VI5yYF/uu16MqqqkWA5WXCHe4FiSigthE1
         VDzAyG4KcI+Sqm+8v9ulZeDsigpyVDlpQIHJh8JJnTAAD2zdnULRDWUBLvZHbmOybC3A
         uRnmuz/mlEIM+bszXLPjkNM7QV8Q55PSJl3p4h9bbFeZXiBscJAaX16o87seRUER2ASp
         NEgTe5Oe9I8glAJJx/yagBaQflRIpuigHP1eIjjbyCpE9kFLmB3KcBVb3TEUVv5DEn5F
         GGnw==
X-Gm-Message-State: AOJu0Yy9rEJx9e0ifYTwUHQ5w+WDFYmnfaL2KE1/ym77cmSddz1toI/Y
	GjEPyNlYEb18Y2gdOWn5u7PU6GLA2KKCHdTvziGpBOsZCQa7HD8hCL2sEOD/
X-Gm-Gg: AeBDievNYQaNkxvZIxYYyei5wS2C5ulciYVBwNzYjvPAwGwden6gqKNVLZ6C7bxikwX
	NYARgApJ0bp+xaThwfoP9WClhWI5ZoHHCuLCXHrUqvkRaDnj8umYQOLNLSLKAdXItZ9fsQgirFV
	cih3IvopcdFVi4qv6B5KoaBnp+SZnb1AQrqAunHXdaSjBIuahGpIw1ZJ6DOupD58g4r4txaz8RH
	ZInXFsAktosTN3ZhZQ4fjofCNX9d3Q+f3orzWCgR0lPWpn/lKAxPPFY1yCBl+zd8sX7xZRQbQbM
	x3eddBLJrcPIZ2xUwdQPMvxsN9/dVr4RBDL2Pq4X8lOzdmRznuU7mbtDHexeGjXRYNIWdTPGgB/
	bXcrMcFx1mgPFJjwNtaaRSjiB0eD3lDhq6MuMg0gjqYKYGRZUeM9dWtqPC/Mk/+TO2TuBb6GIkH
	2g1fqm6VRhZID7aFjVS8HdcreteQMnVlLQq4qix3C2dmSTD1bSVPYljYE0vgK4m56Rjmxi9xdQn
	4eJSgJGw/eT69WJwg==
X-Received: by 2002:a05:7301:1f04:b0:2c5:b23e:48a2 with SMTP id 5a478bee46e88-2cbfa4c48f0mr615818eec.8.1775170536249;
        Thu, 02 Apr 2026 15:55:36 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df5ec7sm3522236eec.3.2026.04.02.15.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:55:35 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v5 00/14] net: sleepable ndo_set_rx_mode
Date: Thu,  2 Apr 2026 15:55:21 -0700
Message-ID: <20260402225535.4124525-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-274723-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2432B38EE7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds a new ndo_set_rx_mode_async callback that enables
drivers to handle address list updates in a sleepable context. The
current ndo_set_rx_mode is called under the netif_addr_lock spinlock
with BHs disabled, which prevents drivers from sleeping. This is
problematic for ops-locked drivers that need to sleep.

The approach:
1. Add snapshot/reconcile infrastructure for address lists
2. Introduce dev_rx_mode_work that takes snapshots under the lock,
   drops the lock, calls the driver, then reconciles changes back
3. Move promiscuity handling into the scheduled work as well
4. Convert existing ops-locked drivers to ndo_set_rx_mode_async
5. Add a warning for ops-locked drivers still using ndo_set_rx_mode
6. Add a selftest exercising the team+bridge+macvlan topology that
   triggers the addr_lock -> ops_lock ordering issue

v5:
- resolve 32 bit failure (Jakub)

v4:
- rebase on https://lore.kernel.org/netdev/20260319005456.82745-1-saeed@kernel.org/T/#u (Cosmin)
- reword ndo_set_rx_mode_async kdoc (Jakub)
- s/EXPORT_SYMBOL/EXPORT_SYMBOL_IF_KUNIT/ (Jakub)
- remove netif_up_and_present (Jakub)
- netif_addr_lists_snapshot + netif_addr_lists_reconcile to better
  explain mix-and-match between
  ndo_set_rx_mode/ndo_set_rx_mode_async/ndo_change_rx_flags (Jakub)
- s/cancel_work_sync/flush_work/ (Jakub)
- separate commit to cache snapshot entries (Jakub)
- add dev_addr_test_snapshot_benchmark (Jakub)
  - dev_addr_test_snapshot_benchmark: 1024 addrs x 1000 snapshots: 89872802 ns total, 89872 ns/iter
- remove redundant bnxt_uc_list_updated (Michael)
- switch to linkwatch-like work stealing (Jakub)

v3:
- module_export(__rtnl_unlock) (nipa)
- s/netdev_uc_count/netdev_hw_addr_list_count/ in bnxt (Aleksandr)

v2:
- wifi: cfg80211: use __rtnl_unlock in nl80211_pre_doit (syzbot)
- simplify mlx5e_sync_netdev_addr for !uc (Cosmin)
- switch to snapshot in bnxt_cfg_rx_mode (Michael)
- add team to net/config (Jakub)

Stanislav Fomichev (14):
  net: add address list snapshot and reconciliation infrastructure
  net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work
  net: move promiscuity handling into netdev_rx_mode_work
  net: cache snapshot entries for ndo_set_rx_mode_async
  fbnic: convert to ndo_set_rx_mode_async
  mlx5: convert to ndo_set_rx_mode_async
  bnxt: convert to ndo_set_rx_mode_async
  bnxt: use snapshot in bnxt_cfg_rx_mode
  iavf: convert to ndo_set_rx_mode_async
  netdevsim: convert to ndo_set_rx_mode_async
  dummy: convert to ndo_set_rx_mode_async
  net: warn ops-locked drivers still using ndo_set_rx_mode
  selftests: net: add team_bridge_macvlan rx_mode test
  selftests: net: use ip commands instead of teamd in team rx_mode test

 Documentation/networking/netdevices.rst       |  13 +
 drivers/net/dummy.c                           |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  62 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  14 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |  32 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  13 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  20 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |   2 +-
 drivers/net/netdevsim/netdev.c                |   8 +-
 include/linux/netdevice.h                     |  26 ++
 net/core/dev.c                                |  69 +---
 net/core/dev.h                                |   4 +
 net/core/dev_addr_lists.c                     | 373 ++++++++++++++++-
 net/core/dev_addr_lists_test.c                | 387 +++++++++++++++++-
 net/core/dev_api.c                            |   3 +
 net/core/dev_ioctl.c                          |   6 +-
 net/core/rtnetlink.c                          |   1 +
 .../selftests/drivers/net/bonding/lag_lib.sh  |  17 +-
 .../drivers/net/team/dev_addr_lists.sh        |   2 -
 tools/testing/selftests/net/config            |   3 +
 tools/testing/selftests/net/rtnetlink.sh      |  44 ++
 24 files changed, 976 insertions(+), 142 deletions(-)

-- 
2.53.0



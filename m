Return-Path: <netdev+bounces-273807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBG+H5lyzGn1SwYAu9opvQ
	(envelope-from <netdev+bounces-273807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:19:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BC73736D2
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F37E3033961
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8A51D8E01;
	Wed,  1 Apr 2026 01:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557CC3D994
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006357; cv=none; b=RGrO0A+y52dltT8epQUZyQ1UGLOihV7s+KKfKNCXZx8dPBJ4xKcSF35ydrTkgiCnf+LPjUMsrfhdDR5zmEv2ajULMKU2K9XQg61C4MRKnqJW04mC+0jkT1XmmD/hFbHMz+mFhMSSx7K/V/iuSb86NEy7sKRBzTDx82cXOPj7Na0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006357; c=relaxed/simple;
	bh=BmFMJVbMjB8yAUd6iDlaBqH0LPG3ZQdGUnb6LyUEoY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EzsajcF+ByKRmlJjpmEhUEdtJby6b/QYl3hTPhzrKzmv6yvcsBY+w6JiD3XzrAwHnMkDsprelUCzyUO+lJbqbOD+Bbw6phFiU0NqzF72AaBTBSf08tUBgSRL7BMx/b1J/rdp7c7YWb1bfdUAMmIS8GPCT+ccjhOeD1JfvDfb1dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso405460eec.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775006355; x=1775611155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNANywZgK12a0bHAMhwc/o5iExnroG81lBymkAI/CWQ=;
        b=lDnMUiiG0Z6biWDu7jlYWM6aYkXJYthgsnNPp9/QOVG2hoxkBfffrYAGwqf2lvxwGB
         5GVbH4biFfb+fFb8dMHG6KrHY7bQuP2yAW2e+P0X8Nf7JQ7ubQf8EtBB0QsEWJ9KxuIo
         K1Bj4ttMhMWFAY/yeFcxeV659viDO5NOePAft33Xse0l/tL5iN6Wn6kNEx1kgACJzTif
         bWYCLkB0p4PBXngQFnHs9rSw/hawXHiwOBNKBPghiIixt/tsWOVw2FQEwXNAGqEfMc6j
         QmIUqSBIcutTwmi54zAY82q11peeHDJYRRHJYgnoiavPC8yCGc28M5IwYxdDZv3mFqpX
         hlMw==
X-Gm-Message-State: AOJu0Yy9V2/tGkpqrWbkNsYb0+tWR0j7Z0np/zQJOgVqFud/hD5dJQPl
	ZJ0Oij6/PBGNg4L24Iy96Inf75TPrqrqYoPt653VKLPEo6b1UY8Z8HAThCYp
X-Gm-Gg: ATEYQzyZ+qh1svK9UYGYJLVH/92De27/XH4TiivIhWj2dugrMJ6ZmIJwLLeN6hMGhQb
	8Ohc9Jfl4klvLXCLVRXpODCqiNnVaotJMm1c7lG5O5NNRTcZiVMSu50vwnp7Ysw0LStydsZ5lm0
	MF7Ny3Sa4a6osZ7q2cIOgptnkuwyD6t6QmOf/Z73nUWvz7GiUN8GYYvS6Pj/1lGFYdWcDGqiENm
	fGq9FkXNzu9fchjV+31l9XQjXqMLGmNjCOYi41Dj5HaCHZn20nBOjT7rL83clygLwCeAVEmjZDx
	/+c8RGh2NMoEMQiwYnKXKVSllXsssbZASkC3lRBq+uu6dHGSIbtyQIutI56FODkNFee7pdwRblI
	lZMpEJA9AhMcw3wRneEfi1AGRCaBROssandyD9phwVAb+i+QqVuamVy7z4GnmIsbHqdDKwu2N9N
	RF4uX+MUme51Rreq8sDx9x4rUv8f6tlVyClD30gRA7zSfcezJPKewtow/OvelJ34m2n3iaGeFea
	N0C9k1jqri7zIPIBw==
X-Received: by 2002:a05:7300:cc12:b0:2c1:67e1:61a9 with SMTP id 5a478bee46e88-2c92b0237b1mr782307eec.13.1775006355109;
        Tue, 31 Mar 2026 18:19:15 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2ff2sm11670870eec.18.2026.03.31.18.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:19:14 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4 00/14] net: sleepable ndo_set_rx_mode
Date: Tue, 31 Mar 2026 18:19:00 -0700
Message-ID: <20260401011914.1716692-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-273807-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.453];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24BC73736D2
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
 net/core/dev_addr_lists_test.c                | 386 +++++++++++++++++-
 net/core/dev_api.c                            |   3 +
 net/core/dev_ioctl.c                          |   6 +-
 net/core/rtnetlink.c                          |   1 +
 .../selftests/drivers/net/bonding/lag_lib.sh  |  17 +-
 .../drivers/net/team/dev_addr_lists.sh        |   2 -
 tools/testing/selftests/net/config            |   3 +
 tools/testing/selftests/net/rtnetlink.sh      |  44 ++
 24 files changed, 975 insertions(+), 142 deletions(-)

-- 
2.53.0



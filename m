Return-Path: <netdev+bounces-267485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBCLJrontGkQiQAAu9opvQ
	(envelope-from <netdev+bounces-267485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:05:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57528285885
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 834463158C0B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EAA3A8733;
	Fri, 13 Mar 2026 14:51:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE073A6B95
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413477; cv=none; b=WjFhaEYhuzopxUYRJXWR1ktsRA3Q69Bnfc+ZXXdZx6fXAQblnjjp0zJ+970bsMW2G7c/LbddCokwyt4nD8f18R9FZDbOFwPfNRwsbynCcwNS1PY3a4qvKnkhK9bKPoCjeMooHuQkHOhP6jl8UUHQ82kCCBXlrNfZhA0snZwiPgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413477; c=relaxed/simple;
	bh=uQsnS6f/ZIsTY4r05EtB8ebE1XhXJjv4yNscoPT4SbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWP3AFMtTU4rEajWwFYMM1XJzB6qOwM5HjrO5hedUO/adlat21FdmX+xWeg3nVmITZEbyzDZWoosECVW9pBzRfugFM0h6Zoc///1qUtWjjeIwB62BWa449dXngcXlntQ331/5lq2qH0pcgqZnYSaCSFlTP9BDsUJMdibKuZbyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-128d2e3082eso1915477c88.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773413475; x=1774018275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgEd5DQNWcoeDQ3muOaNzQEhIzavfP9K/WHp+k+V18M=;
        b=AhCsiJVagLgnoZXAGcHTMKJpDnwNBOZQL0hsQYhtJGm6iWU/Zzn2RcRm7IgXLouspq
         Og1b5EOuiVC/pNHzI1T5SOKE7y3qXsEsNgj/c+LwL2NQjzrSPeCUlfhVdE//F40X+k4u
         avjQmYGMCo8F2Nf+32oWNWYTBdE2Fy8tmKBAfLL/rHRxBYb+S9NiKZK0+fAC6piiu3dB
         Buo9xa1rcF5KmDvmBDvIQu1mOr1VE1S6Ch/zTSuOhr+oVaXsSL/8pCDX/T7rLbxd574A
         Q40qHkOebygn3mljmedhHeEYTNf0PwVCxo9/Qk/vuohJtvO1beEnN5VE6TOupKgm6e2d
         PvQQ==
X-Gm-Message-State: AOJu0Yy2ZZeJYLrRqmy72JWuaZBgzoj0frl6wezIRd8uhG4DTYJ4PooM
	Y8GgaE22f82/BqnWJXaolS+Caiih3ycvYlfueo49wZdPcbE4pi0vK5mZVrbp
X-Gm-Gg: ATEYQzzBav6PNlO7huBCf5DmhiYRSQDCeHuXUb03WP2p5Sfmp5c/KvhdfgKwUKV+TGz
	Lyn88nb5bxtQ45Vj3THsU/M2oENY2PUmLW2KZDUr7YaT01ua+BD+KB76eziL6GUVFsHhusIXmgq
	rB1VUSGyoqGXYTZgc5HY/6SzuiRx6BVhA596tpiJkztFscy581EAmxl0IOYxkMpnYbuBleyt5I2
	0X01pF22nKOO9WBF39A3py9FOwtgctpt2cNOhAlH+hFW1aOmi6I+Dk0VuR/fWZ7T8QnlhOzDWIB
	cqWfegyVT5g9ptQpfM873EqL+yjc/EWOkQlPofOxRxJCGYaiwd1OodG7dxjx09zyDRKitTgGQ2h
	QbhkPT2S5nb8LqbRUsMJnkXWr/Uvj4v0SqsmjHzxv9SmM1gJW7146ND0FnBUOmd65jTjiU9AbeH
	PwUxWtQGzJhkwloEXrWUBlhBCnxvjNVJVxnfvdcRM8pZY8btilHaE+SL8eXaGrnojFp7fjGvROR
	z9bY3Y0nZ9fggSR+Q==
X-Received: by 2002:a05:7022:684:b0:11b:bf3f:5240 with SMTP id a92af1059eb24-128f3d1c3edmr1669362c88.9.1773413474974;
        Fri, 13 Mar 2026 07:51:14 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f63baa3dsm2626677c88.15.2026.03.13.07.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:51:14 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 00/11] net: sleepable ndo_set_rx_mode
Date: Fri, 13 Mar 2026 07:51:02 -0700
Message-ID: <20260313145113.1424442-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-267485-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fomichev.me:mid]
X-Rspamd-Queue-Id: 57528285885
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

Stanislav Fomichev (11):
  net: add address list snapshot and reconciliation infrastructure
  net: introduce ndo_set_rx_mode_async and dev_rx_mode_work
  net: move promiscuity handling into dev_rx_mode_work
  fbnic: convert to ndo_set_rx_mode_async
  mlx5: convert to ndo_set_rx_mode_async
  bnxt: convert to ndo_set_rx_mode_async
  iavf: convert to ndo_set_rx_mode_async
  netdevsim: convert to ndo_set_rx_mode_async
  dummy: convert to ndo_set_rx_mode_async
  net: warn ops-locked drivers still using ndo_set_rx_mode
  selftests: net: add team_bridge_macvlan rx_mode test

 Documentation/networking/netdevices.rst       |  12 +
 drivers/net/dummy.c                           |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  31 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  14 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |  33 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  16 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  20 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |   2 +-
 drivers/net/netdevsim/netdev.c                |   8 +-
 include/linux/netdevice.h                     |  26 ++
 net/core/dev.c                                | 175 ++++++++--
 net/core/dev.h                                |   1 +
 net/core/dev_addr_lists.c                     | 110 +++++-
 net/core/dev_addr_lists_test.c                | 321 +++++++++++++++++-
 tools/testing/selftests/net/rtnetlink.sh      |  44 +++
 18 files changed, 749 insertions(+), 83 deletions(-)

-- 
2.53.0



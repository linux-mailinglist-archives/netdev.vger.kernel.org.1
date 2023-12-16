Return-Path: <netdev+bounces-58218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DAF8158F8
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 13:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAFC285563
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 12:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9377623778;
	Sat, 16 Dec 2023 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vNrZ+To9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285D24A03
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a22deb95d21so181996466b.3
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 04:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702729803; x=1703334603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOCWfm9+y6B9bqhHGXar6f4TBMGU9OoOcuzYNXE7CZQ=;
        b=vNrZ+To9M2fx3M/OVYdMFVjbMOjTA02BtxGiRjiOAKWUtPwin5llX1x7VFvoLWjKAs
         nwNujyGgQjJOc3fQgAmkSDU5akfweDzohrsBMom7nxEkKg6sGhsvw5QyA4bSIPhBp3/L
         FnrFM0F4dDVw/dC3LBQFGMTjjd3dpUOLyA+ECHxcxjQLpi75cBtu6knQXmcPuXNdKpNB
         A8j598nrXAyhCh2ymOeiUHq1MlEZcdTO9Jnpm9LYiVMcodUD0hlmaLfPrB76F7QmWCgS
         BlUw4veytvc65CyAymZsemyRUuLpnmbicIfYfR3kT9bw4mX2zmrnKquCEHxwKac0D0zF
         7vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702729803; x=1703334603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOCWfm9+y6B9bqhHGXar6f4TBMGU9OoOcuzYNXE7CZQ=;
        b=Ej9OmJjB6qvKrJLZ4w7/VEWF0Vk/O+nvjMg5dQ/sOVw+BUuTFLoqJRlBXzx+lawyic
         oaf2exNPfOmjQxV7ruiuHRC8DPHPNLpxRrFK8d9inAnppvZNIO59FQUBeZNEJdrO68u4
         Nu/EQoEvMb/BSuZT6U9+M06pH50nN+jnZtP7UXZxuBf18WAhyDgZGz3gGoeJm6UpoOUG
         AcPVUETdjW8mMHfnnqMnBNXf2Wql/IgJtDjEBs/FAawAoYYcGMJWuZYJDNIIIzhIeFyn
         dv2vkCR5JVrL6JB4ZHJKXs8kmBSVzjBcibZL3FXI+jGCbErhbNpj7QNGT673C4JhXDjS
         zW3Q==
X-Gm-Message-State: AOJu0YzwSlMIf/nwkLc3ZSM8r2DNudr+qpDd16g8iWEyl8y3VCZMOC72
	TFEbuMWXmuVhmyPFS/VANtkC3dnthXlNu3URMhU=
X-Google-Smtp-Source: AGHT+IEVLjh56CccB3uMWzhmx49t5XrKbj4/0w1g4ViexKbSwM5Urwvt1q+NqI2UTPPNOdj5XAVaPQ==
X-Received: by 2002:a17:906:c116:b0:a19:d0b:b3c9 with SMTP id do22-20020a170906c11600b00a190d0bb3c9mr9615405ejc.34.1702729802840;
        Sat, 16 Dec 2023 04:30:02 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id rm6-20020a1709076b0600b00a1f6f120b33sm11317246ejc.110.2023.12.16.04.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 04:30:02 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [patch net-next v8 0/9] devlink: introduce notifications filtering
Date: Sat, 16 Dec 2023 13:29:52 +0100
Message-ID: <20231216123001.1293639-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently the user listening on a socket for devlink notifications
gets always all messages for all existing devlink instances and objects,
even if he is interested only in one of those. That may cause
unnecessary overhead on setups with thousands of instances present.

User is currently able to narrow down the devlink objects replies
to dump commands by specifying select attributes.

Allow similar approach for notifications providing user a new
notify-filter-set command to select attributes with values
the notification message has to match. In that case, it is delivered
to the socket.

Note that the filtering is done per-socket, so multiple users may
specify different selection of attributes with values.

This patchset initially introduces support for following attributes:
DEVLINK_ATTR_BUS_NAME
DEVLINK_ATTR_DEV_NAME
DEVLINK_ATTR_PORT_INDEX

Patches #1 - #4 are preparations in devlink code, patch #3 is
                an optimization done on the way.
Patches #5 - #7 are preparations in netlink and generic netlink code.
Patch #8 is the main one in this set implementing of
         the notify-filter-set command and the actual
         per-socket filtering.
Patch #9 extends the infrastructure allowing to filter according
         to a port index.

Example:
$ devlink mon port pci/0000:08:00.0/32768
[port,new] pci/0000:08:00.0/32768: type notset flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type eth flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type eth netdev eth3 flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type eth netdev eth3 flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type eth flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,new] pci/0000:08:00.0/32768: type notset flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable
[port,del] pci/0000:08:00.0/32768: type notset flavour pcisf controller 0 pfnum 0 sfnum 107 splittable false
  function:
    hw_addr 00:00:00:00:00:00 state inactive opstate detached roce enable

---
v7->v8:
- small return value change in patch #5
v6->v7:
- bigger changes in patch #5, moves the tracking to the family xarray
  with sock as index, makes all lot more nicer and fixes the race
  conditions
v5->v6:
- in patch #5 added family removal handling of privs destruction,
  couple other things, see the patch changelog for details
v4->v5:
- converted priv pointer in netlink_sock to genl_sock container,
  containing xarray pointer
- introduced per-family init/destroy callbacks and priv_size to allocate
  per-sock private, converted devlink to that
- see patches #5 and #8 for more details
v3->v4:
- converted from sk_user_data pointer use to nlk(sk)->priv pointer and
  allow priv to be stored for multiple generic netlink families, see
  patch #5 for more details
v2->v3:
- small cosmetical fixes in patch #6
v1->v2:
- added patch #6, fixed generated docs
- see individual patches for details

Jiri Pirko (9):
  devlink: use devl_is_registered() helper instead xa_get_mark()
  devlink: introduce __devl_is_registered() helper and use it instead of
    xa_get_mark()
  devlink: send notifications only if there are listeners
  devlink: introduce a helper for netlink multicast send
  genetlink: introduce per-sock family private storage
  netlink: introduce typedef for filter function
  genetlink: introduce helpers to do filtered multicast
  devlink: add a command to set notification filter and use it for
    multicasts
  devlink: extend multicast filtering by port index

 Documentation/netlink/specs/devlink.yaml |  11 ++
 drivers/connector/connector.c            |   5 +-
 include/linux/connector.h                |   3 +-
 include/linux/netlink.h                  |   6 +-
 include/net/genetlink.h                  |  46 +++++++-
 include/net/netlink.h                    |  31 ++++-
 include/uapi/linux/devlink.h             |   2 +
 net/devlink/dev.c                        |  13 +-
 net/devlink/devl_internal.h              |  59 +++++++++-
 net/devlink/health.c                     |  10 +-
 net/devlink/linecard.c                   |   5 +-
 net/devlink/netlink.c                    | 116 ++++++++++++++++++
 net/devlink/netlink_gen.c                |  16 ++-
 net/devlink/netlink_gen.h                |   4 +-
 net/devlink/param.c                      |   5 +-
 net/devlink/port.c                       |   8 +-
 net/devlink/rate.c                       |   5 +-
 net/devlink/region.c                     |   6 +-
 net/devlink/trap.c                       |  18 +--
 net/netlink/af_netlink.c                 |   3 +-
 net/netlink/genetlink.c                  | 144 ++++++++++++++++++++++-
 21 files changed, 463 insertions(+), 53 deletions(-)

-- 
2.43.0



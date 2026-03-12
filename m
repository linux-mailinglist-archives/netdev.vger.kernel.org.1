Return-Path: <netdev+bounces-266976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ps2DKaPsmlINgAAu9opvQ
	(envelope-from <netdev+bounces-266976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:04:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C53DB26FF61
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F31D301A7A2
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95483BE620;
	Thu, 12 Mar 2026 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GNOlJrt4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA563845DF
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309854; cv=none; b=t1dStZLewCaCNORDr4cci3xg5K/a2ZBVy66RFOcwzTe9SVYqgFtqwSYoqpUaTFkW1BSLjM6rHf0YK1VvfxIL+sLhmnPpVuGu3Oipgaz0vEJVZQetcqA1/K06XLA26cTWIr8Iu/sI8IVFvZRBcmHGWqXHdP3+PZZLD8sQgyU4sxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309854; c=relaxed/simple;
	bh=6VISSpzlZznNj9au7o+yMu5s+elbPaZGvkqibf2jiuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAdP4L7eSCkQkUcbzZWqtQWr1vIzTWtGBriFK0ij9xdHvLlgtHCkWWQ6m4YeQnQmlOzVcHsCusExQ8AMsyOfoqU26ymJbnqLccbpWx8aCU/t5VT8jNwI6xGQ4iyfUbHUQTxPXPYxZqhZjGrrDHKRWbzgIAC83EYjFFZsmJuukic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GNOlJrt4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so7490955e9.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309848; x=1773914648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XyRQtY5fUA7eA4hQxNQZFrII39g5Q1jSYxzqSfKvGA8=;
        b=GNOlJrt47uGW7S28r6cV9gLG1PD6OhoDYrZMB02dqPGuXvVUjSJDTLA3pjnHz+kMdt
         eXTz/9O9g5Gm975t/iye6AslQbT/ga/tkGY6FUDk2UY6y/lvD4ZFXHN+KsrAU7wUICyE
         WmDPefMpZbE4i3wlhDeDDvPzLfkG1sC7Id+LQDwEK2eSOOIiGbrMmGT+bpJ6yraaKftL
         DsX0UYXqPqHUV4jiW1E0yBOVlgn791GBd8ssoTFnnFtjUlRBw7+vfhiPcs3cEgXlcYgZ
         /MJoDMMSXRyn89Gtnfyd2kpIOf5Ix2uKKV7mGrgKCrmXTsu4aG3zngfmtzFCEKgo4Lh8
         9osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309848; x=1773914648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyRQtY5fUA7eA4hQxNQZFrII39g5Q1jSYxzqSfKvGA8=;
        b=OmsXpZo0E0TPfi/ej9nX5LCSUA4kkVFFVY5adGRKW9/12OGJXVA+bKQY8D6DRBC7vY
         4LubfJAvEsLh7IJ4dsZmauelNr39osJ8Ddcp7R0M+/R1FpgDktWdaYF02bJaz3NSRzPX
         txbP3F18EADehAt8h6PZQdgHnWLDsXZ3QJSinjZlnyP2HX/2nUW8fT/DLD5vgL5yTU5f
         YTpho8bjeNU6CRBDKfqGkmMkcu6H8lcC9kN6YppDU8oaPIVEJuU0gTg9vp70CwFJ1Pc6
         vNLQZounCozvc//X0BXBr7dlDLJe2zes5lX4tQwnA/Xl0bZmlbcEDPPe9DIbdhj4yiq+
         77/g==
X-Gm-Message-State: AOJu0Yx4Knguc9W/re/nEglPEtQI4j5QAMJ8vnXfFsOOBUdXFMmY3vx6
	mQXYhUEUOHNga2XbjgQ4a7rVQ0LoII4c1VnsyJM7K6ied1VdybI0KGz2VncYk/7q0vmgoOHtJSR
	ezuNOu3ByHw==
X-Gm-Gg: ATEYQzye4e9B8F8SkKA+lUnshJQ644UaNEIM4KkEikRExbioyayhfDIUTSYkXB9Csx0
	lvGfeqP7VM2NusZgfFZwCGHqg1L5U9qlzxHxZr4YDuyHHTr1gdoNDauoEy1CZV7TF3uly1B1CNi
	oi8NC9KmkYpXrOEZn3dKrR284mdrIUh2i9SUGq90lQBq+TzjXInS6oZn42gyokcxqx6cRU3K2MH
	38dIEvYSgmeuY38MoBkFqHbvH4dLpvfDJDFvZ0Jf3i/LO/obwAPYXK7Tm5jyR7sLI2QqWlMPt5p
	GUXVIWHMkLVK7WSM8ugSa2K2tj9jTWzNG/cubrngsmB9ovnlWyopB+edSw/TN70eJsvD63ri7w7
	Et0aCDuV0o/K0MyFrz83yBafOfqLtbj9jGO1ueCthvOo7hFZXGkpW2v3d5ZQm42oOtM17mOhdmQ
	vLfH8znnPGynQQHg==
X-Received: by 2002:a05:600c:3103:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-4854b0acb1amr86891245e9.5.1773309848490;
        Thu, 12 Mar 2026 03:04:08 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e92d5sm117363925e9.1.2026.03.12.03.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:08 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v4 00/13] devlink: introduce shared devlink instance for PFs on same chip
Date: Thu, 12 Mar 2026 11:03:54 +0100
Message-ID: <20260312100407.551173-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266976-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C53DB26FF61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs on a network adapter often reside on the same physical
chip, running a single firmware. Some resources and configurations
are inherently shared among these PFs - PTP clocks, VF group rates,
firmware parameters, and others. Today there is no good object in
the devlink model to attach these chip-wide configuration knobs to.
Drivers resort to workarounds like pinning shared state to PF0 or
maintaining ad-hoc internal structures (e.g., ice_adapter) that are
invisible to userspace.

This problem was discussed extensively starting with Przemek Kitszel's
"whole device devlink instance" RFC for the ice driver [1]. Several
approaches for representing the parent instance were considered:
using a partial PCI BDF as the dev_name (breaks when PFs have different
BDFs in VMs), creating a per-driver bus, using auxiliary devices, or
using faux devices. All of these required a backing struct device for
the parent devlink instance, which does not naturally exist - there is
no PCI device that represents the chip as a whole.

This patchset takes a different approach: allow devlink instances to
exist without any backing struct device. The instance is identified
purely by its internal index, exposed over devlin netlink. This avoids
fabricating fake devices and keeps the devlink handle semantics clean.

The first ten patches prepare the devlink core for device-less
instances by decoupling the handle from the parent device. The last
three introduce the shared devlink infrastructure and its first user
in the mlx5 driver.

Example output showing the shared instance and nesting:

  pci/0000:08:00.0: index 0
    nested_devlink:
      auxiliary/mlx5_core.eth.0
  devlink_index/1: index 1
    nested_devlink:
      pci/0000:08:00.0
      pci/0000:08:00.1
  auxiliary/mlx5_core.eth.0: index 2
  pci/0000:08:00.1: index 3
    nested_devlink:
      auxiliary/mlx5_core.eth.1
  auxiliary/mlx5_core.eth.1: index 4

[1] https://lore.kernel.org/netdev/20250219164410.35665-1-przemyslaw.kitszel@intel.com/

---
Decoupled from "devlink and mlx5: Support cross-function rate scheduling"
patchset to maintain 15-patches limit.

See individual patches for changelog.

Jiri Pirko (13):
  devlink: expose devlink instance index over netlink
  devlink: add helpers to get bus_name/dev_name
  devlink: avoid extra iterations when found devlink is not registered
  devlink: allow to use devlink index as a command handle
  devlink: support index-based lookup via bus_name/dev_name handle
  devlink: support index-based notification filtering
  devlink: introduce __devlink_alloc() with dev driver pointer
  devlink: add devlink_dev_driver_name() helper and use it in trace
    events
  devlink: add devl_warn() helper and use it in port warnings
  devlink: allow devlink instance allocation without a backing device
  devlink: introduce shared devlink instance for PFs on same chip
  documentation: networking: add shared devlink documentation
  net/mlx5: Add a shared devlink instance for PFs on same chip

 Documentation/netlink/specs/devlink.yaml      |  58 +++
 .../networking/devlink/devlink-shared.rst     |  97 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  17 +
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  61 +++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  12 +
 include/linux/mlx5/driver.h                   |   1 +
 include/net/devlink.h                         |  10 +
 include/trace/events/devlink.h                |  36 +-
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/Makefile                          |   2 +-
 net/devlink/core.c                            |  91 ++++-
 net/devlink/dev.c                             |   8 +-
 net/devlink/devl_internal.h                   |  34 +-
 net/devlink/netlink.c                         |  52 ++-
 net/devlink/netlink_gen.c                     | 355 +++++++++++-------
 net/devlink/port.c                            |  19 +-
 net/devlink/sh_dev.c                          | 161 ++++++++
 19 files changed, 815 insertions(+), 209 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
 create mode 100644 net/devlink/sh_dev.c

-- 
2.51.1



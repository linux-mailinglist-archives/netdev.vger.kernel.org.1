Return-Path: <netdev+bounces-60431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B8B81F3EA
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 02:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AFC284001
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 01:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A02B23BF;
	Thu, 28 Dec 2023 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="NFn0kWuH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F991FDE
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 01:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-594ce2083easo727665eaf.2
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 17:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703727997; x=1704332797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CKXVOXjl0Ca8AMo66yjd6xl8xQVFrxzbUq3g6xurRkQ=;
        b=NFn0kWuHpbFC/yo782mes8xa12ogxkLmoSd9U6D2LeRfuvilWXrex8M6WSRJe3dqhm
         j9ziuYhRPJxqTBAbjs5sDB4YPJmp0vKuwS//MkGL2HAL/6+aq4MuJWLnenDtzB4rO0OV
         M5lN1IHDowbiMeZ1GLU5L0OB21MtgFONsFbRr91dafM4oVxW1j8c5Nd08ndbBjrHagqf
         Y2qNb1JYBd2do1cPUCONXX1i4OT4LKlTnCfO01tnB8+CgrAOxevJBXf7uzxHj4BMwiTb
         QPfFOp3JZtH8gDJb4q8xp57SunTS8L211t8h6EkO/mQqWkHrXma52SRlWvtyFy8fxwk7
         6Pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727997; x=1704332797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKXVOXjl0Ca8AMo66yjd6xl8xQVFrxzbUq3g6xurRkQ=;
        b=rjexXnRiloQorFDI1PWBPZd+aTUOl/SDe5ukbE4ekpxvAmltAKit/Fnavo5saXWJLr
         kzMoHutp1qeND+0hlrmn58WxAnD0dXEuKE9IydMX61v6vxzZg/4BgL3nPDRfwhfyAme6
         AdbEFBLSAM9KWtzowh12dVXFyiCpU2H6VRu+qlKWUkpFRFc8GgVzax68wdkwUF0gme2f
         QSAs0sRA+NUS/wFPqRgHWL/p/6z6cruf6RkBiNcHleOrOty3G6ON1/Lo726G3mIkIBCK
         /n6BpwTSRziKdUuMuL6OwFmmkMQi1iqXiyEhWonMHXBXTClSl6Jg2dztEmYh0RJwjxHW
         d8gg==
X-Gm-Message-State: AOJu0Yw+8cvffld64BcKa28zKOZ0UUZ6bR0V0sC9jUN6/90GxSPGjomu
	w4KD9ejVN9b5c8JnFdvs+QpJAwLSL5cY0A==
X-Google-Smtp-Source: AGHT+IGzmKU/quU5NxM2lN6AUPYePdSRBlOW1XpSN4UXTEeH6GEm+OA9o78gwPcUUVf9rlftXjOwbQ==
X-Received: by 2002:a05:6358:103:b0:174:dc14:2dea with SMTP id f3-20020a056358010300b00174dc142deamr9307174rwa.47.1703727997032;
        Wed, 27 Dec 2023 17:46:37 -0800 (PST)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id r3-20020a62e403000000b006d997b5d009sm8911784pfh.69.2023.12.27.17.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:46:36 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v5 0/5] netdevsim: link and forward skbs between ports
Date: Wed, 27 Dec 2023 17:46:28 -0800
Message-Id: <20231228014633.3256862-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds the ability to link two netdevsim ports together and
forward skbs between them, similar to veth. The goal is to use netdevsim
for testing features e.g. zero copy Rx using io_uring.

This feature was tested locally on QEMU, and a selftest is included.

---
v4->v5:
- reduce nsim_dev_list_lock critical section
- fixed missing mutex unlock during unwind ladder
- rework nsim_dev_peer_write synchronization to take devlink lock as
  well as rtnl_lock
- return err msgs to user during linking if port doesn't exist or
  linking to self
- update tx stats outside of RCU lock

v3->v4:
- maintain a mutex protected list of probed nsim_devs instead of using
  nsim_bus_dev
- fixed synchronization issues by taking rtnl_lock
- track tx_dropped skbs

v2->v3:
- take lock when traversing nsim_bus_dev_list
- take device ref when getting a nsim_bus_dev
- return 0 if nsim_dev_peer_read cannot find the port
- address code formatting
- do not hard code values in selftests
- add Makefile for selftests

v1->v2:
- renamed debugfs file from "link" to "peer"
- replaced strstep() with sscanf() for consistency
- increased char[] buf sz to 22 for copying id + port from user
- added err msg w/ expected fmt when linking as a hint to user
- prevent linking port to itself
- protect peer ptr using RCU

David Wei (5):
  netdevsim: maintain a list of probed netdevsims
  netdevsim: allow two netdevsim ports to be connected
  netdevsim: forward skbs from one connected port to another
  netdevsim: add selftest for forwarding skb between connected ports
  netdevsim: add Makefile for selftests

 MAINTAINERS                                   |   1 +
 drivers/net/netdevsim/dev.c                   | 153 ++++++++++++++++--
 drivers/net/netdevsim/netdev.c                |  27 +++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/Makefile  |  18 +++
 .../selftests/drivers/net/netdevsim/peer.sh   | 124 ++++++++++++++
 6 files changed, 310 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.39.3



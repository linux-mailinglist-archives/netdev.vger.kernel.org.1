Return-Path: <netdev+bounces-33835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAEB7A06D2
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0695B20519
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF14224DB;
	Thu, 14 Sep 2023 14:02:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B7241E3
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:02:36 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272FD1A2
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:02:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c09673b006so7503515ad.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694700155; x=1695304955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5OzDSzdRu1O4maPEMdmZQx2ZhJtXZ9PbZNhycjjELrs=;
        b=p3xP25QamI7hiWfRnHRaRqnj3rYLtQ67JKu8h8BQIwKLr7JFEW+4kN7ziy+lTek+iY
         viVPluHS80Z4QY3TNBBCEg6oQDMPfXrbEn+iULRqz9gzs4masL/exgzfThXG4K9rIO1O
         8RrZ+UhssRJGfmk1BYsIP4aCPSUYk+bBUCywVzxA3SzpDdaF2WpDXRnMeoml8aNW31Za
         jwir7g5D7DNpgbAtOeiJwjoha05zY3O54hU9aSFy1nxLSu+JQcJM2yGbaSISNCL1gEbe
         SZ/uHXN1AHLMiJnvxbjZY64mUi7IYhkA5rixaRMKS38/88dr2+cdQNDpyBx3XTY7Bz9l
         PyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694700155; x=1695304955;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OzDSzdRu1O4maPEMdmZQx2ZhJtXZ9PbZNhycjjELrs=;
        b=Np8cxWdOo2EnKYdJsCxwZv95/K8timSeK4SojHbYz9JbxHipsIB0/SKzJRhPnOni95
         LD5gcQxQcdCsGW/xOfZgvLvewFZM0WoLrx0NsEM32bzOpA8Y4dVCnwakqiMdADqbRpHw
         qEEopmdgm89A3+EZcU5IYLQoiTqEAjXVBqlXkjfVcBIwND8ICp+9pGGgsOPR2EBlHieX
         qkPwFaOzDOPFcwxhZ8o8v2nTHw+cJO0MQ+zqxVgvN5IYe0fPawfVNt4XEA+xqUnVHzDv
         4R1YwDQRMdfm+eDaU4EvDsCvof3awMXrWAkInNbmMuF6s30iiQFJpKsgQTrcWE4iCL0D
         WckA==
X-Gm-Message-State: AOJu0YycEaB4xrpgmiFyt6AEXxduSqTGAzbOsrAdl91Q6Az3sfB4zyWQ
	cWaMr+lWRlludy0kJrY6lR08Zda2KQ3yZnfyUL+WXhW7GGM7YQ==
X-Google-Smtp-Source: AGHT+IFbOgwhuCBkOxQLaxlbU8Bv1UyTYUQZqHWZDrG9RoEeFj07emrKQi14bEhHZQ9RxBLm0/yJ2xSwYCIFfPWQY7Q=
X-Received: by 2002:a17:902:eccd:b0:1b8:5aba:509d with SMTP id
 a13-20020a170902eccd00b001b85aba509dmr5822760plh.21.1694700154973; Thu, 14
 Sep 2023 07:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yachen Liu <blankwonder@gmail.com>
Date: Thu, 14 Sep 2023 22:02:24 +0800
Message-ID: <CAPsLH6aHJGG7kAaZ7hdyKoSor4Ws2Fwujjjxog6E_bQrY1fA+w@mail.gmail.com>
Subject: [Bug][USB4NET] Potential Bug with USB4NET and Linux Bridging
To: netdev@vger.kernel.org
Cc: michael.jamet@intel.com, mika.westerberg@linux.intel.com, 
	YehezkelShB@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

I've noticed a potential issue with USB4NET when used in conjunction
with Linux bridging. I'm uncertain if it's a bug or a configuration
oversight on my part.

In essence, when the device at the other end of Thunderbolt sends
packets using the TSO mechanism (default behavior in macOS), the Linux
thunderbolt0 interface correctly receives this large packet. However,
the packet isn't properly forwarded to another device via bridging.

Detailed Description:

The test environment consists of three systems:

A: Mac Mini (M2): macOS Sonoma 14.0 RC
B: Proxmox VE 8.0. Kernel release: 6.2.16-3-pve, acting as the Host system.
C: Debian. A Guest system running within B.

System A and B are connected via USB4, while System C is a virtual
machine within B. On B, thunderbolt0 and tap102i0 are bridged to
establish a connection between A and C.

During an iperf3 speed test between A and B, I've achieved
bi-directional speeds of around 18Gbps. Between B and C, the speeds
are 100Gbps+ at their peak, with a minimum of 28Gbps.

However, when performing an iperf3 speed test between A and C, the
direction from C to A shows about 18Gbps, but from A to C, the speed
drops to just tens of Kbps, essentially making it unusable.

If tested using UDP, both directions achieve roughly 5Gbps. (I suspect
some buffer issue in macOS limiting the speed).

After various tests and investigations, I found that by setting
macOS's net.inet.tcp.tso to 0 (disabling TSO), speeds from A to C
improved to around 10Gbps.

Packet capture via tcpdump revealed that macOS writes large packets
(over 10000B) to Thunderbolt Networking using TSO. These packets are
correctly captured on thunderbolt0, but are missing from tap102i0,
resulting in significant packet loss.

Since ethtool doesn't support the thunderbolt0 device, further testing
has been hindered.

I'm unsure if this is a bug, or if it could be resolved via
configuration. If more information is needed, I am more than willing
to assist further with tests.

Thank you.

Warm regards,

Yachen Liu


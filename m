Return-Path: <netdev+bounces-17990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0D875401D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 19:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4949F1C20D84
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5233C1548D;
	Fri, 14 Jul 2023 17:02:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311D14A96
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 17:02:47 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC47F3594
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 10:02:46 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56344354e2cso1450199eaf.1
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1689354166; x=1691946166;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UyT4pxphNn2FlzXd2DzWtjbpV7urWvhVMBL3DLvilEY=;
        b=Hiv6RUfNSUmquWBtmKL7gEAx55j8VUnIlungCSKPcKBESO5B7+YEG7S+tKBEdcKK3x
         oOZFg2I4G/egbeo1dyln47DX8/Y3ZQqo799uPDoiVnqQDBimKhxzX11ZhILDNb9LUkLT
         piJZqTHngQdnU1WdEuxQnvt2GlvgqdFQe4NxUwZkKb8yAyBz0AHG97BRoZrr3a+nmixq
         d6GcFmyK1yT8USPbZEt7IldVo5cayLsbKdehzaybvaYzJfqVNhpcNZnzJYSymd+mv9en
         /OufUtsR+nxgfOePYmy22ZMHUj9It1phoEsuNJqigrGF2Okzg2lEiY2HyMlHk57PMvDi
         TD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689354166; x=1691946166;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UyT4pxphNn2FlzXd2DzWtjbpV7urWvhVMBL3DLvilEY=;
        b=BnOFHqFWhrPZo2WoHcn4iK/cUa9LYTOXKPYm1hVJT9/Kgnrdg3f+bQA+zcOb4cvV6t
         ldeRNJcecGD5V8UlJ+NUYdtRCkn+zKwMIqKW5aD3bFbFKEk6I7CRIKHO3lCkqWN7ASFg
         08691ai89fbVzgUVqneMAMK0kcEjjys8851MWCJaNYyHdNEFmj3qgmibVTIjcl4Na8R7
         +75eKTPUCLzZNR4zZW33fI71bZPgtRwA05BTJ/WCyWfaRDPtnjkOmW8p++XmbsA40M0e
         2KGm1AySLlQmVUaKGgijG84BKgrhIaJeiw4pmoq6UJBrqorO4sXrhLvvtQLcYmfJMgHH
         Phzg==
X-Gm-Message-State: ABy/qLZc20/CWkqjxfDoLhZuPhdgr9E7SH1S7uj9CzyQsZa/7AlSXhbv
	o397I4FslzoR+igKvukfbZnNrQ/rLFkAI+fEybo1PgU+MGQK/zDrX7w=
X-Google-Smtp-Source: APBJJlG4IkAx5sFVzCBGhIzbWgP/2Vh+0DCu8mP/2sPDdgfxmkgfyyQgEuCwy0TsCrcMECgTtIJKE0ne6F0LbDSFfyM=
X-Received: by 2002:a05:6358:c13:b0:134:5662:60a with SMTP id
 f19-20020a0563580c1300b001345662060amr7408579rwj.6.1689354165945; Fri, 14 Jul
 2023 10:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 14 Jul 2023 18:02:29 +0100
Message-ID: <CAPY8ntBEsfUhE7wHR7dOXh0=LiZkM0uBR9KxsmUspH2CAobtUg@mail.gmail.com>
Subject: Jumbo frames on Broadcom Genet network hardware
To: Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Doug, Florian, and everyone else.

At Raspberry Pi we've had a few queries about enabling jumbo frames on
Pi4 (BCM2711), which uses the Genet network IP (V5).

I've had a look through and can increase the buffer sizes
appropriately, but it seems that we get the notification of the packet
whenever the threshold defined in GENET_0_RBUF_PKT_RDY_THLD is hit.
The status block appears to be written at this point, so we end up
dropping the packet because the driver believes it is fragmented (SOP
but not EOP set [1]), and presumably any checksum offload is from that
point in the frame too.
Setting RBUF_PKT_RDY_THLD to 0xF0 (units of 16bytes) allows for 3840
byte buffers plus the 64byte status block, and that all seems to work.
(My hacking is available at [2])

Is this the right way to support jumbo frames on genet, or is there a
better approach? It appears that you can configure the buffers to be
up to 16kB, but I don't see how that is useful if you can't get beyond
3840 bytes sensibly before status blocks are written and the host CPU
notified.

Others have reported that before the status blocks were always enabled
[3] then larger buffer sizes worked without changing the value in
PKT_RDY_THLD. I haven't managed to reproduce that. They were also
hacking global defines to allow selection of larger MTUs, so I
wouldn't like to say if they broke anything else in the process, and
it was also quite a long time ago (pre 5.6).

Many thanks in advance.
  Dave

[1] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/broadcom/genet/bcmgenet.c#L2324
[2] https://github.com/6by9/linux/tree/rpi-6.4.y-genet/drivers/net/ethernet/broadcom/genet
[3] https://github.com/torvalds/linux/commit/9a9ba2a4aaaa4e75a5f118b8ab642a55c34f95cb


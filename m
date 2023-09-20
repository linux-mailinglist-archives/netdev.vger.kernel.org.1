Return-Path: <netdev+bounces-35309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7137A8B67
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 20:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465961C20E32
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 18:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338A3CCE5;
	Wed, 20 Sep 2023 18:13:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAFA3CCEE
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 18:13:50 +0000 (UTC)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B7CF;
	Wed, 20 Sep 2023 11:13:48 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79f292f0ac2so20751339f.1;
        Wed, 20 Sep 2023 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695233627; x=1695838427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1XbdgEmcO0SlJnN1RyDOHAwbdBCKSNfqwQQgVkoyPY=;
        b=jkIZORlLeh8yvR1utpc3Qm7nQ9KbsbwWMiVC3qlPm0GGHVJt163HIQn2HONt4RFXwm
         YNsguBMzxSdOL9w52DQk1dxkB5HhgDH5bsCwrhMD/YviNmZ8wSwYpD/B3Z61V+b2AuI1
         uHAEnVsDCZwCbLWzsZVtahFUpVr62ZD0SwHIkmb84lXtSv89Am4piEpcIaN+t8ZhjvdD
         3JFfMU6zb8vhmdhcgy/yk9S4CYD9AJgzSsroVaa9lcYiBijioMTkgtpoX+wWMYikwQp6
         cay0Cpx8CtjqNWYhgOWuxqMo2QyrCCh13JIA9rR+fPcJJ5ywZG2FVk57Hm+e9itJpCbT
         YNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695233627; x=1695838427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1XbdgEmcO0SlJnN1RyDOHAwbdBCKSNfqwQQgVkoyPY=;
        b=f8U3/D1ve+tMYv46UmpdvkbJJpfPZwjvd5HyZbs1IOZblHr1c1NyW2V5gOLGd++IG7
         +LE04ecDZuroyEXCn9u/irHMkwMrBYHYWpVLHP/kIGc9IlG+xJ4dpNN7y04dnxrx1Su/
         JU1eRn2FqCtGZ1qPuIklfh8SgyXN5zblqpIbaRc6lhau4iQ7t/cUXupD1ic5ywIy26hp
         EzpKld56T0CGw2WbRQFhs5v2xeqOQEwOrmtXn3yuTLUJ31BdiRuDjCCHQQVAaOWWrJMM
         VKKP0qNwizDYh3obpLvqezDguIWqokKW2KoxuBJuOXa74DOSKFdREzd/krn5DZ7KkrTX
         O4VQ==
X-Gm-Message-State: AOJu0Yz4O7p+zfgtfbFBVckLeRCGGu0XRJ/MpohpTgaLb+PBcEGS7HAJ
	CdAP+z1r7ruAcK43sR4MV5ameSkXbKA=
X-Google-Smtp-Source: AGHT+IHDueg5FZ+O66xfqhMtsY1d+Q7M4m63UVoB1ydRhuv7OUWNR5dW8FNQHzELxcUDZJnf+kP5Zw==
X-Received: by 2002:a92:c54a:0:b0:34f:963e:4484 with SMTP id a10-20020a92c54a000000b0034f963e4484mr5701905ilj.12.1695233627243;
        Wed, 20 Sep 2023 11:13:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id q23-20020a02c8d7000000b0043a0d66a80csm738720jao.24.2023.09.20.11.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 11:13:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull-request: bluetooth 2023-09-20
Date: Wed, 20 Sep 2023 11:13:44 -0700
Message-ID: <20230920181344.571274-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following changes since commit 4a0f07d71b0483cc08c03cefa7c85749e187c214:

  net/handshake: Fix memory leak in __sock_create() and sock_alloc_file() (2023-09-20 11:54:49 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-09-20

for you to fetch changes up to b938790e70540bf4f2e653dcd74b232494d06c8f:

  Bluetooth: hci_codec: Fix leaking content of local_codecs (2023-09-20 11:03:11 -0700)

----------------------------------------------------------------
bluetooth pull request for net:

 - Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
 - Fix handling of listen for ISO unicast
 - Fix build warnings
 - Fix leaking content of local_codecs
 - Add shutdown function for QCA6174
 - Delete unused hci_req_prepare_suspend() declaration
 - Fix hci_link_tx_to RCU lock usage
 - Avoid redundant authentication

----------------------------------------------------------------
Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
      Bluetooth: ISO: Fix handling of listen for unicast
      Bluetooth: hci_core: Fix build warnings
      Bluetooth: hci_codec: Fix leaking content of local_codecs

Rocky Liao (1):
      Bluetooth: btusb: add shutdown function for QCA6174

Yao Xiao (1):
      Bluetooth: Delete unused hci_req_prepare_suspend() declaration

Ying Hsu (2):
      Bluetooth: Fix hci_link_tx_to RCU lock usage
      Bluetooth: Avoid redundant authentication

 drivers/bluetooth/btusb.c        |  1 +
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 63 ++++++++++++++++++++++------------------
 net/bluetooth/hci_core.c         | 14 +++++++--
 net/bluetooth/hci_event.c        |  1 +
 net/bluetooth/hci_request.h      |  2 --
 net/bluetooth/hci_sync.c         | 14 ++++-----
 net/bluetooth/iso.c              |  9 ++++--
 8 files changed, 60 insertions(+), 46 deletions(-)


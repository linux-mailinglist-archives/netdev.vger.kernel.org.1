Return-Path: <netdev+bounces-58089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8C9814FC7
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 19:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C001F238E7
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 18:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADABB1CF8D;
	Fri, 15 Dec 2023 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQCnieUb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7A13C46B;
	Fri, 15 Dec 2023 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e4dc41ab59so3938287b3.3;
        Fri, 15 Dec 2023 10:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702665137; x=1703269937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRjwpVZkDiYveLBU3alcmnlTla2B39gK/IQD+D9ndaI=;
        b=hQCnieUb6IgP3+chWdZPxqkMlTAAbGO+fFTtx9WkEWdwCoisg4vhmgPZIE23BfEyj7
         Ch/RolZqCgvYptPyQr8QWanJcryjwcCkS/SlaW+5+6Ph8SKly6HPLd2kvPtUEA4mM9lU
         CJ/mJOtQzV3jk9g4nNfkWVz68aRyFtgVtWIky8jM1QwYvmW953wpzpUAuMMBz5dDCJZS
         8lZPAjdnbLS6ScgoXMMYxkXba11eP2ULsH91pxKpQhJMbWVjt+lHNcReXYtdOGirtNCW
         oQ7oPjicbPNsSq7QeIkqwZElJ2XOxPcaSXdQJo4QTdpX1ja+ka+xOI1UyEsV51wxvJ2a
         NRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702665137; x=1703269937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRjwpVZkDiYveLBU3alcmnlTla2B39gK/IQD+D9ndaI=;
        b=WDWEfXorKm5RmonUWSbNAZaHdILQhVt02UmfGuhsnaHSAuGw9bXa3sgd8WRKPVcMTc
         rgcL5IDKwpc2rC3LhemH9X/ffS66YciTwHA+vU6A+0cstxmxstBq/m8NB0410DffkqfE
         Ygig3n6SAIswZfqW4axT42vUqKrRKrLDM+ubzV7B+/cUPou34gWtpPHnWDvYabzz1dA3
         Ia2dcnaPzHBiZxBkWVptyWtbghDzpQVSFmEHF/AB6tLuHdbwhe3RvxMjOxneR+wGYayf
         J1IvuweJvYmiLzljp4QePayCBCXiMTzk9/vSgcshxXvHmSmXoLeO7bbyKDSkmrZMB7iw
         dEMA==
X-Gm-Message-State: AOJu0YyhpgIYa8BVWDjK6LB62NJpst49h8VUIOTgmNOvnfJtpQLVBGkg
	EZvQ9lLKcYdcMc4veeuVaQOQZ1fJJCc=
X-Google-Smtp-Source: AGHT+IHKUjhYfgy4WnqxJaIjG+2dOjbeva/k+mBe1XbCy0N0JxHX6kCxrLP2lRVVudzA5DUZbBHSlQ==
X-Received: by 2002:a81:84c8:0:b0:5d3:9f4d:dae0 with SMTP id u191-20020a8184c8000000b005d39f4ddae0mr9421226ywf.24.1702665137249;
        Fri, 15 Dec 2023 10:32:17 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id h4-20020a816c04000000b005e2dff985d5sm2206289ywc.33.2023.12.15.10.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 10:32:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull-request: bluetooth 2023-12-15
Date: Fri, 15 Dec 2023 13:32:13 -0500
Message-ID: <20231215183214.1563754-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 64b8bc7d5f1434c636a40bdcfcd42b278d1714be:

  net/rose: fix races in rose_kill_by_device() (2023-12-15 11:59:53 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-12-15

for you to fetch changes up to 2e07e8348ea454615e268222ae3fc240421be768:

  Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg (2023-12-15 11:54:18 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - Add encryption key size check when acting as peripheral
 - Shut up false-positive build warning
 - Send reject if L2CAP command request is corrupted
 - Fix Use-After-Free in bt_sock_recvmsg
 - Fix not notifying when connection encryption changes
 - Fix not checking if HCI_OP_INQUIRY has been sent
 - Fix address type send over to the MGMT interface
 - Fix deadlock in vhci_send_frame

----------------------------------------------------------------
Alex Lu (1):
      Bluetooth: Add more enc key size check

Arnd Bergmann (1):
      Bluetooth: hci_event: shut up a false-positive warning

Frédéric Danis (1):
      Bluetooth: L2CAP: Send reject on command corrupted request

Hyunwoo Kim (1):
      Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Luiz Augusto von Dentz (3):
      Bluetooth: Fix not notifying when connection encryption changes
      Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent
      Bluetooth: hci_core: Fix hci_conn_hash_lookup_cis

Xiao Yao (1):
      Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Ying Hsu (1):
      Bluetooth: Fix deadlock in vhci_send_frame

 drivers/bluetooth/hci_vhci.c     | 10 ++++++----
 include/net/bluetooth/hci_core.h |  9 +++++++--
 net/bluetooth/af_bluetooth.c     |  7 ++++++-
 net/bluetooth/hci_event.c        | 30 +++++++++++++++++++++---------
 net/bluetooth/l2cap_core.c       | 21 +++++++++++++++------
 net/bluetooth/mgmt.c             | 25 ++++++++++++++++++-------
 net/bluetooth/smp.c              |  7 +++++++
 7 files changed, 80 insertions(+), 29 deletions(-)


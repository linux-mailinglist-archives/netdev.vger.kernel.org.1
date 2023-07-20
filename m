Return-Path: <netdev+bounces-19622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5944275B753
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F417D281F0F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA5A19BCD;
	Thu, 20 Jul 2023 19:02:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF4E18C25
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 19:02:05 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F992711;
	Thu, 20 Jul 2023 12:02:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68336d06620so999917b3a.1;
        Thu, 20 Jul 2023 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689879724; x=1690484524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jYD8Cbd0ZfiUhPxUtrfX4bsBnVBoDDm69gYF6duSGk=;
        b=eLuDythDmUbaHKywBL5BEzNiO5bOZdkras7sm4xXHnvEVd5qJQ1/BdxxI0NH6iaR4q
         DYvDD33JDvLcsxryIr7JAf/ptL/8GAl+CEqbZpxiNI+NF9oThQQsdbnhOJUY7jkq4kzt
         jHzeR7bzdGxw6y/mAir9HcYZehLeG8g0OBMfnZUCSjGqeMHuxGL6qQvhdAE5oEDgK/kA
         +309DdzTAXY57fv/CiBP5zOPu2UJOeePodQ/EYeFpWCMZ6w0pDWD94vLpR6hzJxLEuOe
         hCSvMEH+BL+58IsNWsbd0Oq0SBHD0k+aK+TuCxA2jgeag5+HzQNb8YUzoi7ncrLUgLvH
         ifpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879724; x=1690484524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jYD8Cbd0ZfiUhPxUtrfX4bsBnVBoDDm69gYF6duSGk=;
        b=dngfYuDWkXCBFXOVZnfGitNmMIuivnhB+wu8iviw6TNgrkbJBvcxigyGvOOmHFeAhi
         W+KJsMRB4CbT9uJ0d/CJcXvpxtQaln77tL1zvtH2C21jIvskZgEJzwagD+bm69gMnCgy
         Fa9C1BOO+vHsIT3wyfvVGQYGa2lsaBMe/mJv8c/cNxuFVHv41BVZsRq1Ye3Y2ThWkjDH
         R/Oai1IEDMVf0L9SKTBWawEwbwm8EKo2CKZC7m2m5oBALOz3mjQ6ql3Doxwr0YefcITJ
         L8h1mDMedcPQ5DrYBhUAWHlxhzKsujF2Q7nnLM+Fphlkr1Q3KUCJMj8AG17Bod6hrLF4
         KxUw==
X-Gm-Message-State: ABy/qLZgVe/UAjm/ZyN9oH/BSlNx6xAvcmiMGGrM6GutBFwKd8DUNC3q
	/5NX0oZtjNanWj0V464Pmo4i7h2LJTc=
X-Google-Smtp-Source: APBJJlHUSJXIQdeYy8p3mqEcHM+9ke8edOj0tWXEcjee4iExZTWlXqtka6RCKCL96eNCEu0pmeVIaA==
X-Received: by 2002:a05:6a20:3d14:b0:130:d234:c914 with SMTP id y20-20020a056a203d1400b00130d234c914mr405189pzi.26.1689879723788;
        Thu, 20 Jul 2023 12:02:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id p21-20020a62ab15000000b00682b15d50a2sm1482627pff.215.2023.07.20.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:02:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: pull-request: bluetooth 2023-07-20
Date: Thu, 20 Jul 2023 12:02:00 -0700
Message-ID: <20230720190201.446469-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following changes since commit ac528649f7c63bc233cc0d33cff11f767cc666e3:

  Merge branch 'net-support-stp-on-bridge-in-non-root-netns' (2023-07-20 10:46:33 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-07-20

for you to fetch changes up to d1f0a9816f5fbc1316355ec1aa4ddfb9b624cca5:

  Bluetooth: MGMT: Use correct address for memcpy() (2023-07-20 11:27:22 -0700)

----------------------------------------------------------------
bluetooth pull request for net:

 - Fix building with coredump disabled
 - Fix use-after-free in hci_remove_adv_monitor
 - Use RCU for hci_conn_params and iterate safely in hci_sync
 - Fix locking issues on ISO and SCO
 - Fix bluetooth on Intel Macbook 2014

----------------------------------------------------------------
Andy Shevchenko (1):
      Bluetooth: MGMT: Use correct address for memcpy()

Arnd Bergmann (1):
      Bluetooth: coredump: fix building with coredump disabled

Douglas Anderson (1):
      Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()

Pauli Virtanen (4):
      Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync
      Bluetooth: hci_event: call disconnect callback before deleting conn
      Bluetooth: ISO: fix iso_conn related locking and validity issues
      Bluetooth: SCO: fix sco_conn related locking and validity issues

Siddh Raman Pant (1):
      Bluetooth: hci_conn: return ERR_PTR instead of NULL when there is no link

Tomasz Moń (1):
      Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014

 drivers/bluetooth/btusb.c        |   1 +
 include/net/bluetooth/hci_core.h |   7 ++-
 net/bluetooth/hci_conn.c         |  14 ++---
 net/bluetooth/hci_core.c         |  42 +++++++++++---
 net/bluetooth/hci_event.c        |  15 +++--
 net/bluetooth/hci_sync.c         | 117 +++++++++++++++++++++++++++++++++++----
 net/bluetooth/iso.c              |  53 ++++++++++--------
 net/bluetooth/mgmt.c             |  28 ++++------
 net/bluetooth/sco.c              |  23 ++++----
 9 files changed, 217 insertions(+), 83 deletions(-)


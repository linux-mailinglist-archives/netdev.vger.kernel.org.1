Return-Path: <netdev+bounces-13804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3882973D0B8
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 13:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692241C208BC
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3E6AA4;
	Sun, 25 Jun 2023 11:55:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22F63C5
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 11:54:59 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A246E6B
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 04:54:58 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b477e9d396so32640871fa.3
        for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 04:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687694096; x=1690286096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhxQZdVN9319Yfa6KgJPNli0v3mL7q28J47ozJNt/vc=;
        b=JfGu2MpzseImt04dPOPSIqQFQhA6hDsCQkUa3U2iVtnGebvh9RxBo49WEMqX7CwrRQ
         hkcItaixndpfWhGxmaKWZoTiXY8TE0BiBiNKyHY0rRn1MARox8gyGQ/ejhoFLcqHXP3w
         mYP5EfDbFYFBHibeQVFecz9qsJTCU50JMQRewHbx2WEdSrIzfW4z7Kni8rxAK5yri4Og
         IbmQKMk48Dft7PL4s5QfXD5dSdEQcblbxJgkalHG0RPzn/cGUPH9MvIZJQGCxz2HHVsA
         yuS2t+9jynw/82R0KXhHNaio/pRSYc67nsFv2LLwPpCD2wAHHTuls0Myo9QCrkfMxBpj
         429w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687694096; x=1690286096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhxQZdVN9319Yfa6KgJPNli0v3mL7q28J47ozJNt/vc=;
        b=A8DRivQe46ii1GN+sDdlyeqjm+zcHR9dZXMgYRVvmgZ9JWTZQPkfnQ/6XlieNG6IFq
         w3uVFHGqzFzbi16MtfVYi7QCQpu/k5u7YShlERmQGE/02IHRETVcCSr3N4H+c8xlvQEh
         2ifdvX8R5ofgVjDL6/7PT2x9e5+VBuJ83IO27nPC1mbDWq9H6qo1t0J+Mt0pXxYTecx/
         960h3K44pSSVuzbS9+x9y8W4wGDv+GCpDManQC2L0i0yqatmmFyuxLdYDmjDivXv06/b
         O5wvD1fllxbV6XSJvViQf4xYHTSkkO21/ZGncktHLWqTaCrvCWmwsyfAFmgdGzgPwVSs
         b5cA==
X-Gm-Message-State: AC+VfDxb3uK8Qt8LXfS9SHuXjR0h4gEuGINPECuDAKuH/i3AT1M7x6gW
	u7vurvuhXd4VRHtwhQc52eeNbd5Qlxxk8g==
X-Google-Smtp-Source: ACHHUZ67LmG6WrJ2uOcSjryY3iMqJ0A7voQX51CB0C8JxVVI/WBo9zbztAm6gX3ckmKXsuc+/HuMog==
X-Received: by 2002:a2e:3e08:0:b0:2b6:9ed0:46f4 with SMTP id l8-20020a2e3e08000000b002b69ed046f4mr495373lja.23.1687694096004;
        Sun, 25 Jun 2023 04:54:56 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9595000000b002b6993b9665sm416043ljh.65.2023.06.25.04.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 04:54:55 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>
Subject: [PATCH net-next v2 0/7] net: dsa: vsc73xx: Make vsc73xx usable
Date: Sun, 25 Jun 2023 13:53:43 +0200
Message-Id: <20230625115343.1603330-8-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625115343.1603330-1-paweldembicki@gmail.com>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series is focused on getting vsc73xx usable.

First patch was added in v2, it's switch from poll loop to
read_poll_timeout.

Second patch is simple convert to phylink, because adjust_link won't work
anymore.

Patches 3-6 are basic implementation of tag8021q funcionality with QinQ
support without vlan filtering in bridge and simple vlan aware in vlan
filtering mode.

STP frames isn't forwarded at this moment. BPDU frames are forwarded 
only from to PI/SI interface. For more info see chapter 
2.7.1 (CPU Forwarding) in datasheet.

Last patch fix wrong MTU configuration.
Pawel Dembicki (7):
  net: dsa: vsc73xx: use read_poll_timeout instead delay loop
  net: dsa: vsc73xx: convert to PHYLINK
  net: dsa: vsc73xx: add port_stp_state_set function
  net: dsa: vsc73xx: Add dsa tagging based on 8021q
  net: dsa: vsc73xx: Add bridge support
  net: dsa: vsc73xx: Add vlan filtering
  net: dsa: vsc73xx: fix MTU configuration

 drivers/net/dsa/Kconfig                |   2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 937 ++++++++++++++++++++-----
 drivers/net/dsa/vitesse-vsc73xx.h      |   2 +
 include/net/dsa.h                      |   2 +
 net/dsa/Kconfig                        |   6 +
 net/dsa/Makefile                       |   1 +
 net/dsa/tag_vsc73xx_8021q.c            |  87 +++
 7 files changed, 856 insertions(+), 181 deletions(-)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

-- 
2.34.1



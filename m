Return-Path: <netdev+bounces-35555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4377A9CE1
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2523B239B9
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B8C67BFB;
	Thu, 21 Sep 2023 18:34:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294254885B
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:34:52 +0000 (UTC)
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B57D483E
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:25:15 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-1dc27f7c838so1723018fac.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695320715; x=1695925515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7oiEzk8ZF/N/fLGrK1CVb3pAXd3Gw3hdWoPv5Oq9zyM=;
        b=L9QEQc83qGeGgpyCwipeCmdIh3adyEcpOzNMf4PsX/t2ZTfftz7hRJllvNVq2mYcJM
         Sas4YwXnFG8rCV5POEu5JJUvxvxm8OqRnUZzoRawT6edx5y03i/x62lGB0gADQ/o4z6K
         pwhDU/4at67yjZhQJt46Unzo8SO7RVv8TcVnKEsCuoGL6l14zHbATHOjiLXydxDJZU72
         0U258UbqusmTIJRhahiU/lsbeGG44h/xrVs2ZmJF9YW5yM6QGEzhk5Z/OCTU7NF0Ui39
         +AnWUNTDJV2ZbA+W8Je4XfYwfCBHAUFanPxrfVeEXDx9uSAcIf0ZRFdS1RWWQLzHqjig
         /ZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320715; x=1695925515;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7oiEzk8ZF/N/fLGrK1CVb3pAXd3Gw3hdWoPv5Oq9zyM=;
        b=AlNh/jrpcST5SLjnCI/MAyPMeHjeX8Yi1oqXJ7VaZPuk1PRBvba5yXX2a84AqD4R6g
         HD6VIE6gVhImOCmsEJWsxIQBp2jffSTBAAPK0VP6Pj+pwrMjVEfqfmHRux3tIlOjGaSL
         FIiLnVi6cP29vcHvKSBKX5PXm1kuy0zIHWRVxpgtqZKA2kObl89CjK7I70h7BHuyCGEV
         Z8uckGAzmo3zCIriqZ4kK00xtwumy2eqm363iiuk74sqA2eyxMr6Qi4OglreOTmoBs/Y
         JHN7/QZvCP8fL3TZIT6mBjJKYTQkXNqktm00qWc3YPjDhpSOegLesFGBsmuEVIm5qsOI
         HeAg==
X-Gm-Message-State: AOJu0Yx4SpH3SuDAC8zOIAbXJH8VNY08bVAh4flD/NkzSsZiedIDUWGv
	a9PWP103Je9NGe9foupWxesYPizJ0ARiUQ==
X-Google-Smtp-Source: AGHT+IF/Re9/4c7A3PY/aEEc/MGQVgRppCl646oOsdATu+vQYiYPtq/UlMTCkZNhqjd6Aox6ydpp7XzG4UqbHQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:e617:0:b0:d85:ac12:aadb with SMTP id
 d23-20020a25e617000000b00d85ac12aadbmr53861ybh.9.1695286340938; Thu, 21 Sep
 2023 01:52:20 -0700 (PDT)
Date: Thu, 21 Sep 2023 08:52:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921085218.954120-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/3] net: use DEV_STATS_xxx() helpers in
 virtio_net and l2tp_eth
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Inspired by another (minor) KCSAN syzbot report.
Both virtio_net and l2tp_eth can use DEV_STATS_xxx() helpers.

v2: removed unused @priv variable (Simon, kernel build bot)

Eric Dumazet (3):
  net: add DEV_STATS_READ() helper
  virtio_net: avoid data-races on dev->stats fields
  net: l2tp_eth: use generic dev->stats fields

 drivers/net/macsec.c      |  6 +++---
 drivers/net/virtio_net.c  | 30 +++++++++++++++---------------
 include/linux/netdevice.h |  1 +
 net/l2tp/l2tp_eth.c       | 34 ++++++++++++----------------------
 4 files changed, 31 insertions(+), 40 deletions(-)

-- 
2.42.0.459.ge4e396fd5e-goog



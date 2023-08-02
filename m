Return-Path: <netdev+bounces-23799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E5C76D99E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 23:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CED281DCF
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D29125C4;
	Wed,  2 Aug 2023 21:34:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B6512B65
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 21:34:02 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E272D65
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 14:33:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d05883d850fso222461276.3
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 14:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691012026; x=1691616826;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rgeTB4y9hGWZkzALzQ3Sny/Q79a5N1MZ3/fnmNvL19Y=;
        b=MsI06BlerFjfq6ELkalSG68UBMV2/E7CltM+o7dpndLmU5JLlRbe19Cw1xh/1MRg3z
         whr+TZYfNHvdkk5MwE02NMaXAyH3Id3IpquDQc9cvG01nEEB7R2l+8PvkQE3N6B7eECs
         6eBRlvsB8ZDTOYy7Lj06l+0c3C8pYmYM8v80imtkpaoItIItMufbBfy9Wy/ukqOt7ud3
         7vAD2ghXP1bu4llEcyQz7RTFu7MtM+bMWxDs8PlJllH79ysZU8XJyFPm3QHeaNjb3Y5k
         +WVz1aVeofEHcErnRCB6vbVv62Yqq5JuOnr3ITcDFkywxXa93zMmGvgCkKRwWOP/WMa8
         3n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691012026; x=1691616826;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgeTB4y9hGWZkzALzQ3Sny/Q79a5N1MZ3/fnmNvL19Y=;
        b=ieIIA+RyamyCcUkRYs1w8UuVNbd92rFQ9vvjKs6MJIQYP75llfYeE7Ysqjog7ghnuW
         O6zIqIW01CfMOS3oRCcyHOX3uY3JFgEKd2wxUYwUiQvQZ0zB5RkMc+xoh7O+JQIxGlDs
         fvCElok9iH1tH9ThWbluuROvBjudnEuxYHHpdKjtC1yGx6UHnVQ3g1ygCpKwyumEzYVO
         OAba6eDb22P2+FwiECba6rDrSn+/ID6KNzdnNxm/N69n7RzEGtzC5OYSmxHszCFmBbTU
         8Kc07zJ4qtd2BBNuUytNZxffcP9QLyhrK5AdVljC2xV+A9YVk3i+T3G1GyilOrqbk/fK
         c2tg==
X-Gm-Message-State: ABy/qLahUITF/ZcuoSj4to5ZPD4VKx8WfWuiJ7oDh/wkkJIdVh2a/iER
	uoXiGAYJEFxKEePfCJKlYMMEGbLgHish6v01AYFbPv4JWmP5TrFRdyQdDDQCQMc1QXbum5kO1Kl
	ExdUDx1/7jVXHlIQ8KEjBmYGNigj1Nq+6DMGRSLhY9HkHtrjtZm+jpHnYxskvw1G5
X-Google-Smtp-Source: APBJJlEsYdFBU+rFON7lWBSUz4fBlELErY0luuya55SxnL6xbaluG2Hb9cqaBc/Qraj953rt7nii/7QZX1/V
X-Received: from wrushilg.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2168])
 (user=rushilg job=sendgmr) by 2002:a25:dc94:0:b0:c10:8d28:d3ae with SMTP id
 y142-20020a25dc94000000b00c108d28d3aemr112847ybe.8.1691012026197; Wed, 02 Aug
 2023 14:33:46 -0700 (PDT)
Date: Wed,  2 Aug 2023 21:33:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802213338.2391025-1-rushilg@google.com>
Subject: [PATCH net-next 0/4] Add QPL mode for DQO descriptor format
From: Rushil Gupta <rushilg@google.com>
To: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	willemb@google.com, edumazet@google.com, pabeni@redhat.com
Cc: Rushil Gupta <rushilg@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

GVE supports QPL ("queue-page-list") mode where
all data is communicated through a set of pre-registered
pages. Adding this mode to DQO.

Rushil Gupta (4):
  gve: Control path for DQO-QPL
  gve: Tx path for DQO-QPL
  gve: RX path for DQO-QPL
  gve: update gve.rst

 .../device_drivers/ethernet/google/gve.rst    |   9 +
 drivers/net/ethernet/google/gve/gve.h         | 112 ++++-
 drivers/net/ethernet/google/gve/gve_adminq.c  |  93 +++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |  10 +
 drivers/net/ethernet/google/gve/gve_main.c    |  20 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 126 +++++-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  | 404 ++++++++++++++----
 7 files changed, 653 insertions(+), 121 deletions(-)

-- 
2.41.0.585.gd2178a4bd4-goog



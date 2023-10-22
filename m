Return-Path: <netdev+bounces-43323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8793F7D25EF
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 22:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A058D1C20938
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 20:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9367E134A2;
	Sun, 22 Oct 2023 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jWERYBoB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA6ADDDA
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 20:53:30 +0000 (UTC)
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E274114
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=LOuWi5SoYFF9kG
	o5fhGgFu4WQlhNarSy0u1SSM70AD0=; b=jWERYBoB9qTSaKPh70AOIr3UKSUF8W
	6ujFBSmV0BxdTL7X1HPgdRASO6urdT1aAI3SvSgsuPKzW9MYHT6DDPyxxM1q9JtW
	+jB0nvkOS5d/jcepDwkJVCAbExIJcfI6xhiknVIhuAomDbRKgFrWJzda7ap33AH9
	C07AkcyML060leR9Vy28jhWaOlZqXVsI0HAw6+VxfOlSfItDe/G88o4gCh3PLJg6
	fmI6Qji1lJtUUcX+SU6c2bH6lxm/5S9HyZWdgQfhFhg+Kpf478JZZRw3a2c0xNo+
	Bh6MIdmOC2Gx0UlUq6vQ6c3dOea5EsCVKd+2ckO6obRL5hkTUC4kDrxw==
Received: (qmail 1741642 invoked from network); 22 Oct 2023 22:53:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Oct 2023 22:53:24 +0200
X-UD-Smtp-Session: l3s3148p1@FZK8S1QInscujnvq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ethernet: renesas: infrastructure preparations for upcoming driver
Date: Sun, 22 Oct 2023 22:53:14 +0200
Message-Id: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before we upstream a new driver, Niklas and I thought that a few
cleanups for Kconfig/Makefile will help readability and maintainability.
Here they are, looking forward to comments.


Wolfram Sang (2):
  net: ethernet: renesas: group entries in Makefile
  net: ethernet: renesas: drop SoC names in Kconfig

 drivers/net/ethernet/renesas/Kconfig  | 9 +--------
 drivers/net/ethernet/renesas/Makefile | 4 +---
 2 files changed, 2 insertions(+), 11 deletions(-)

-- 
2.35.1



Return-Path: <netdev+bounces-13508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B31073BE23
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F38281C70
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C97101CC;
	Fri, 23 Jun 2023 17:55:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EAD8485
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 17:55:13 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A9C197;
	Fri, 23 Jun 2023 10:55:11 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1687542910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kzYyT1cWR3gyuTfd9yIpRtKiLdtO/zcU+/rIV46pyak=;
	b=VRh7pmicKbyTCON+SXI37uG4mB9Zj0ZyqGcv8pS4yjwgw3jhf0jvxBH1vIhGUBzII6VINr
	Gmz5ghc31rOaRhAdwjR1dbZobCA4AaiGBfsW0iZNLi+F8dKpBTaMAbTeg15+8LFilbdGe0
	MbMRzZkJwxuuWzu5qB2k3tSbpcWOpJBBUA7yEDBwA0oBV3nQAapvgq5UVn3qFplWAPY7Rn
	pZSRJufasBgroha/Wcu0cLWzqRr94zMeOaqSARk/EPjzaXqR3to+c/rgwA1nPOAw6v6CbG
	nh8kMiNtVkPSKNwTsECTG0qyt7kMTFhAdUVlgMLUMqUqWpd65/ckEbB3yx2gIQ==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD4181BF204;
	Fri, 23 Jun 2023 17:55:08 +0000 (UTC)
Date: Fri, 23 Jun 2023 19:55:06 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, netdev@vger.kernel.org,
 linux-wpan@vger.kernel.org
Subject: pull-request: ieee802154 for net-next 2023-06-23
Message-ID: <20230623195506.40b87b5f@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Dave, Jakub, Paolo.

As you know, we are trying to build a wpan maintainers group so here is
my first ieee802154 pull-request for your *net-next* tree.

Thanks,
Miqu=C3=A8l

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/wpan/wpan-next.git tags/=
ieee802154-for-net-next-2023-06-23

for you to fetch changes up to 18b849f12dcc34ec4cb9c8fadeb503b069499ba4:

  ieee802154: ca8210: Remove stray gpiod_unexport() call (2023-06-06 20:47:=
48 +0200)

----------------------------------------------------------------
Core WPAN changes:
* Support for active scans
* Support for answering BEACON_REQ
* Specific MLME handling for limited devices

WPAN driver changes:
* ca8210:
  - Flag the devices as limited
  - Remove stray gpiod_unexport() call

----------------------------------------------------------------
Andy Shevchenko (1):
      ieee802154: ca8210: Remove stray gpiod_unexport() call

Miquel Raynal (7):
      ieee802154: Add support for user active scan requests
      mac802154: Handle active scanning
      ieee802154: Add support for allowing to answer BEACON_REQ
      mac802154: Handle received BEACON_REQ
      net: ieee802154: Handle limited devices with only datagram support
      ieee802154: ca8210: Flag the driver as being limited
      Merge tag 'v6.4-rc4' into wpan-next/staging

 drivers/net/ieee802154/ca8210.c |  4 ++--
 include/net/cfg802154.h         |  3 +++
 include/net/ieee802154_netdev.h | 20 +++++++++++++++++++-
 net/ieee802154/header_ops.c     | 36 ++++++++++++++++++++++++++++++++++++
 net/ieee802154/nl802154.c       | 13 ++++++++++++-
 net/mac802154/ieee802154_i.h    | 21 +++++++++++++++++++++
 net/mac802154/main.c            |  2 ++
 net/mac802154/rx.c              | 70 +++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++-
 net/mac802154/scan.c            | 68 +++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++------
 9 files changed, 226 insertions(+), 11 deletions(-)


Return-Path: <netdev+bounces-39689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB3F7C40EC
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5BE1C2096C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C7229D11;
	Tue, 10 Oct 2023 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DA532196
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:11:57 +0000 (UTC)
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA2999;
	Tue, 10 Oct 2023 13:11:54 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p4fc2fcbd.dip0.t-ipconnect.de [79.194.252.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 85BF7C0695;
	Tue, 10 Oct 2023 22:11:50 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-wpan@vger.kernel.org,
	alex.aring@gmail.com,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org
Subject: pull-request: ieee802154 for net 2023-10-10
Date: Tue, 10 Oct 2023 22:09:43 +0200
Message-ID: <20231010200943.82225-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Dave, Jakub, Paolo.

An update from ieee802154 for your *net* tree:

Just one small fix this time around.

Dinghao Liu fixed a potential use-after-free in the ca8210 driver probe
function.

regards
Stefan Schmidt

The following changes since commit a2e52554c710b388df2d9d95b51cc1059af2aa22:

  Merge branch 'ravb-fix-use-after-free-issues' (2023-10-06 16:19:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git tags/ieee802154-for-net-2023-10-10

for you to fetch changes up to f990874b1c98fe8e57ee9385669f501822979258:

  ieee802154: ca8210: Fix a potential UAF in ca8210_probe (2023-10-07 20:37:38 +0200)

----------------------------------------------------------------
Dinghao Liu (1):
      ieee802154: ca8210: Fix a potential UAF in ca8210_probe

 drivers/net/ieee802154/ca8210.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)


Return-Path: <netdev+bounces-44854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 856387DA237
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADBAB21449
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D522A38F89;
	Fri, 27 Oct 2023 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVnv4XMZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3B36AFA
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 21:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38B5C433C7;
	Fri, 27 Oct 2023 21:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698441195;
	bh=rg3RxdUtf8o3A6gR+nUnqAcsQQvBqSZDkdMXGMA5884=;
	h=From:To:Cc:Subject:Date:From;
	b=cVnv4XMZgC7p9dRRn16TvMVcCP1iNQj829EdZTolihqDLZfQAH6zoB8LjlNtoUATD
	 /VGo+gy4C+duKCkx2xthgSOu2aLRBOoifzOp/hmIFnqXDFqyZERPjKPJk6ObEOv3Yf
	 E30xdtPgSoRM6ZGLn/WVQmS/qkdEiS8XLTCMKlBbe2MfNSy6AR0eY5xZ8q3dotKcid
	 kuFRI2jnCICpL94N+o0TQPrRjCryHpgyHzKDRCLKkQLu37WBp6VQroqIcTmaZHOfkg
	 tO6tZCILsojjSoJW0q55CMPJWCCWDKbWD/7LMKF6k3x7VGdMQZ83Ht05RzK/VxUhS5
	 cA/wf+DCaBExw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/4] net: fill in 18 MODULE_DESCRIPTION()s
Date: Fri, 27 Oct 2023 14:13:07 -0700
Message-ID: <20231027211311.1821605-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().

Fill in the first 18 that jumped out at me, and those missing
in modules I maintain.

v2: s/USD/USB/ in patch 1
v1: https://lore.kernel.org/all/20231026190101.1413939-1-kuba@kernel.org/

Jakub Kicinski (4):
  net: fill in MODULE_DESCRIPTION()s in kuba@'s modules
  net: fill in MODULE_DESCRIPTION()s under net/core
  net: fill in MODULE_DESCRIPTION()s under net/802*
  net: fill in MODULE_DESCRIPTION()s under drivers/net/

 drivers/net/amt.c                           | 1 +
 drivers/net/dummy.c                         | 1 +
 drivers/net/eql.c                           | 1 +
 drivers/net/ifb.c                           | 1 +
 drivers/net/macvtap.c                       | 1 +
 drivers/net/netdevsim/netdev.c              | 1 +
 drivers/net/sungem_phy.c                    | 1 +
 drivers/net/tap.c                           | 1 +
 drivers/net/wireless/mediatek/mt7601u/usb.c | 1 +
 net/802/fddi.c                              | 1 +
 net/802/garp.c                              | 1 +
 net/802/mrp.c                               | 1 +
 net/802/p8022.c                             | 1 +
 net/802/psnap.c                             | 1 +
 net/802/stp.c                               | 1 +
 net/8021q/vlan.c                            | 1 +
 net/core/dev_addr_lists_test.c              | 1 +
 net/core/selftests.c                        | 1 +
 18 files changed, 18 insertions(+)

-- 
2.41.0



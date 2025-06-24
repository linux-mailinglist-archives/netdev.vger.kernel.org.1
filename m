Return-Path: <netdev+bounces-200492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6BBAE5A4E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533643BC6FD
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 03:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA564D599;
	Tue, 24 Jun 2025 03:00:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F9E182BC;
	Tue, 24 Jun 2025 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734048; cv=none; b=pH4czZ2eZBxytKVId+B9J7H58HBMmWSppp8lJevKYVii4z6WuR3atm97TI+f9BNVQc9NQdqRHrqbHua3HTa+0/ttPLIXeK6MVT5uGTfklzVgawMXbvalHS4Ph9ROkXgfNq0H6m88D1+GeOreD0tzUApMsi6vKixOsktoVRe8V6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734048; c=relaxed/simple;
	bh=eEFc4F7xE1kxOscj3Caa6fs+2Wwo8rF7+/oxQOwlfMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8fUiYxtegQphwowKP5gqFacE14ggTi2QJ8K1o93/R8oWd5lGEL24tJDdozWZIh333AtKUriauRyRnRtZSEJ4f/OVvEGPiUdbG9K2rDgOw9GwmCtJ8kgjycjCY/5FoKQRauHkaURwZVyezS3zlg3N84jXFpSMFQII/aj1Ooe5w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201612.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202506241100315435;
        Tue, 24 Jun 2025 11:00:31 +0800
Received: from localhost.localdomain.com (10.94.6.249) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.57; Tue, 24 Jun 2025 11:00:30 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, chuguangqing <chuguangqing@inspur.com>
Subject: [PATCH 0/1] check the ioremap return value first (supplementary CC)
Date: Tue, 24 Jun 2025 10:58:53 +0800
Message-ID: <20250624025915.1692-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250624025915.1692-1-chuguangqing@inspur.com>
References: <3bf6df3b-affe-4f10-8b05-29f3393d19e0@intel.com>
 <20250624025915.1692-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025624110031415c3819e8b85ca5c6989f831ba4e68d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Always check ioremap() return value  before use.

chuguangqing (1):
  ixgbe: check the ioremap return value first

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.5



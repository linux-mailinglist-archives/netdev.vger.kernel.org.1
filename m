Return-Path: <netdev+bounces-122119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD9E95FF44
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 04:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F73B20E83
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 02:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514212B93;
	Tue, 27 Aug 2024 02:45:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6B747F
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726700; cv=none; b=Y4TQ6PVVxtL2e5jQIBwV0oTzEuUUYUcSciZJOT8gwdPuIixTkR5bO7Rcg7UIvtXAf1pDOUUz8LxzjuHMQnM6Fa37d8WagxLn7ARA73KS8xdyxY9BjpO6w1CtQrd5HaiirKPMIhVSTt+5pYDsLPDnixwwEBp9pMm5ZwPTCEp2f/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726700; c=relaxed/simple;
	bh=WkU3YUVyIE5OdXMRadChk32o9UunAmkBh10u/AyoyMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a/ovMZ0eQBLp08GZagbbKPr3eGmyilkIA/cnleKrWIkRxckg3wwkZ/CNs/EWGgsyUT/ge20Mvx9PECU9gG429ErEErkda/DNXKu3vpgqb9jRn0iJfv5LUDIi2bNG3l+x/bpaP3+o+soeyB6iXv9Fqsojmh2ADvAVKlBM45aftrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtBfj1w5zzfbYg;
	Tue, 27 Aug 2024 10:42:53 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 8516018007C;
	Tue, 27 Aug 2024 10:44:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 10:44:56 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <sam@mendozajonas.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <lihongbo22@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v2 0/2] net/ncsi: Use str_up_down to simplify the code
Date: Tue, 27 Aug 2024 10:52:44 +0800
Message-ID: <20240827025246.963115-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

In commit a98ae7f045b2, str_up_down() helper is introduced to
return "up" or "down" string literal, so we can use it to
simplify the code and fix the coccinelle warning.

v2:
 - change subject into net-next

v1: https://lore.kernel.org/netdev/20240823162144.GW2164@kernel.org/T/

Hongbo Li (2):
  net/ncsi: Use str_up_down to simplify the code
  net/ncsi: Use str_up_down to simplify the code

 net/ncsi/ncsi-aen.c    | 2 +-
 net/ncsi/ncsi-manage.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1



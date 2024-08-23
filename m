Return-Path: <netdev+bounces-121251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E4F95C5C2
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39E51C2338B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 06:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA3A13A409;
	Fri, 23 Aug 2024 06:45:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164958174E
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395527; cv=none; b=SCai15pdq8ikijz+s7duz7/Lm9K65sh5WkJWgCxdnBbPV4hqRN8J5S7ipM02iJrz7A+IuCyfuO9VKl0Xa7MLPbUrTNVTy8TXx3NW3trJuBs5zYcNwlxRVAeJAU3aFoABsog3zqgeWcJnwJGGY7FRWKhwbcTNYDu466rVfMeTMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395527; c=relaxed/simple;
	bh=kvX1GxGER0GSa+Du2oOAnz5V2Ou1lRoW+/WenpkG+NM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LM7+vXzjcoSBCxvhlGdPIL20FLLc6i4nwOR4yeqzgXebTeoUU4X/HVfQwm3cn0oZ4GchqqzBbVb0dd30FgDzOjDCw+h+knJ6WMTmur4boxIsB2n9ZiwuWl4g+5qKpr71y2ejfaGw/9xqB+qeDqSZWgsn978Fbmtp6fkvycw3OEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wqr8b16Dvz1HH3s;
	Fri, 23 Aug 2024 14:42:07 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 334A91401F1;
	Fri, 23 Aug 2024 14:45:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 14:45:21 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <sam@mendozajonas.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <lihongbo22@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH -next 0/2] net/ncsi: Use str_up_down to simplify the code
Date: Fri, 23 Aug 2024 14:52:57 +0800
Message-ID: <20240823065259.3327201-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

In commit a98ae7f045b2, str_up_down() helper is introduced to
return "up" or "down" string literal, so we can use it to
simplify the code and fix the coccinelle warning.

Hongbo Li (2):
  net/ncsi: Use str_up_down to simplify the code
  net/ncsi: Use str_up_down to simplify the code

 net/ncsi/ncsi-aen.c    | 2 +-
 net/ncsi/ncsi-manage.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1



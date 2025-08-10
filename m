Return-Path: <netdev+bounces-212357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E69BB1FA50
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 16:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC733BC6BE
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD019ABDE;
	Sun, 10 Aug 2025 14:01:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4826EF9EC;
	Sun, 10 Aug 2025 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754834492; cv=none; b=jAh2avzqq1BCeWWgynuQRhig96qK4exd/vk6vr8y403L4oYGx1cdMNfvatJP1df1IIh06x7BbuoHB4YNoAT3YM4R4Z7sop+rGpZJOdyVu+7+aJem17NLtbI/AMF58ADNB1sTfui6vMbu/pZKC1EahfEcQqnDr3SGoCvuNnmje4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754834492; c=relaxed/simple;
	bh=YjX6UTbc8Eyw4QDyGAmmhh1Q6RVEqo6xpmuStGehXEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRBdWTV0aC8nbs8VIObuUfh1R/xS5iEUT6SBzvdDCc2Nvfl4QclT39g5o0ecxHF/hObj5flQJ0mIzkiWRqWK4CPWq1kP4YMyjkB1QUZA4nrPxB0Z+WdyvaevRddPqX7dJC3RkUkzXfA13JQ1OaZN+H2UI4V5pX5QqN2qC8XavGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.209])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ee09b3ec;
	Sun, 10 Aug 2025 22:01:23 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: alsi@bang-olufsen.dk,
	amadeus@jmu.edu.cn,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	robh@kernel.org,
	ziyao@disroot.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to Radxa E24C
Date: Sun, 10 Aug 2025 22:01:15 +0800
Message-Id: <20250810140115.661635-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <db1f42c3-c8bb-43ef-a605-12bfc8cd0d46@kwiboo.se>
References: <db1f42c3-c8bb-43ef-a605-12bfc8cd0d46@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a989449398503a2kunmca8c4679547084
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSxpJVh0fT0tKSB4dTBlPT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVJS0JZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSEJVSktLVU
	pCS0tZBg++

Hi,

> I had only tested on a next-20250722 based kernel and on a vendor 6.1
> based kernel. And similar to your findings, on 6.1 based kernel there
> was no issue only on the newer kernel.
>
> I will probably drop the use of "/delete-property/ snps,tso" and include
> a note in commit message about the TSO and RX checksum issue for v2.

After my test, this problem is caused by commit 041cc86 ("net: stmmac: Enable TSO on VLANs")
https://github.com/torvalds/linux/commit/041cc86b3653cbcdf6ab96c2f2ae34f3d0a99b0a

It seems that this commit just exposed the TSO problem (with VLANs).

Thanks,
Chukun

--
2.25.1




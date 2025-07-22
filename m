Return-Path: <netdev+bounces-208760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EE6B0CF8F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 04:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667D51AA2899
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BD61DE4D2;
	Tue, 22 Jul 2025 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SkO6UoFh"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E262F5B;
	Tue, 22 Jul 2025 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753150198; cv=none; b=r9WD65PWmm5IR7l3yOWM+HvRrejVZ2UQowLO8TQ1qExnzIUpGuz8/afkG41vy8UrSaIXhN0mArSuXi0PeUR7Ep+mmY1veXh6r+P2XwmDW0u1JIC2iyMv/EVrqnoyzmT9qtZTLG5RacYPeHo29Dy/V3NwF+NSIz3iOnTuSQlg0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753150198; c=relaxed/simple;
	bh=XJ0YXRAaT/YlT9dd8vlyFihKQMyn4qZC4Pplx1s0Ncg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRufbtdLLyS2fm6UUONLtezXNZ7rg+efXEapmIqmiCQHhzYM4GBJmxW5qaVsOVQO+tGWyOthzlbdCVp6d0ON++QcVDlCH3ieM/kqf+Qedyk/xALhxa8r7dPPXHwC4irfnrMDTZ9YE4MUeuKNeV51Uq5YzpW5fQtHJdUjc0PC178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SkO6UoFh; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=XJ0YXRAaT/YlT9dd8vlyFihKQMyn4qZC4Pplx1s0Ncg=;
	b=SkO6UoFhGGnyV3gqyDsiPdhuuSrW7WtVVbfULH1tH9Vdifl3xwMfpV8oq41LIB
	lt/23mUeSodxJe/li4vBgS6RUAgrOsCJ3oHwHxJRpF3M3es/n7pLgaJyHygX68Yf
	ovW4rwyVci/auosy8GlQC9pH1QSQE/m2NCOvEDhbXFkDY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3vRPd8n5o_XtJGw--.30823S2;
	Tue, 22 Jul 2025 10:09:34 +0800 (CST)
From: yicongsrfy@163.com
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	oneukum@suse.com,
	yicong@kylinos.cn
Subject: Re: [PATCH] usbnet: Set duplex status to unknown in the absence of MII
Date: Tue, 22 Jul 2025 10:09:33 +0800
Message-Id: <20250722020933.1221663-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <496e1153-acac-468a-b39c-9ea138b2cf04@lunn.ch>
References: <496e1153-acac-468a-b39c-9ea138b2cf04@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vRPd8n5o_XtJGw--.30823S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrW3uFy8uF1Uur17uw1Utrb_yoW3GFbE9a
	1xJa1kA3W5Wr4xJr43KF1Fq39a9r4UZryUXw12grn2k3s5AanrArn5t3W0yw18Gr17ArZ0
	9rs7GayS9an7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnQtx3UUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiUA2S22h+6qH6qwAAsY

Thanks for your reply!

According to the "Universal Serial Bus Class Definitions for Communications Devices v1.2":
In Section 6.3, which describes notifications such as NetworkConnection and ConnectionSpeedChange,
there is no mention of duplex status.In particular, for ConnectionSpeedChange, its data payload
only contains two 32-bit unsigned integers, corresponding to the uplink and downlink speeds.

Since CDC has no way to obtain the duplex status of the device, ethtool displays a default
value of "Half". I think it would be better to display "unknown" instead of potentially showing
incorrect information — for example, my device is actually operating at 1Gbps Full-duplex,
but ethtool shows 1Gbps Half-duplex.



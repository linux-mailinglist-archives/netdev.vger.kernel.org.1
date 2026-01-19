Return-Path: <netdev+bounces-251105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B6D3AB72
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 617ED300912E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DF135E53F;
	Mon, 19 Jan 2026 14:16:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446D35B15F;
	Mon, 19 Jan 2026 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832197; cv=none; b=pa1XAZqNiv83S7VIndBe8yayswqmw9LK/w8bZYzCWM2zOmfq0AGGFelx0NB9/+e4Flpt5Vnf3rRfwE7rprcEUiJOT4OMJcYlVUe95C8ll8bh7e9rU3MIAo+a73yatSzGTuNbzsLiJokJcAokhAZYsTplUmmeRFLey5Wf/0es0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832197; c=relaxed/simple;
	bh=4FsYjzOy2OwoeEB6bDlUhD9xagzXLUPTGlJPIqnDYXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0/EGu5B+fAmOPz7ZR/6AbWj9kSluqo6VO+YWPqwQIbTym3urW8fdxAowSZxu6JqIf0niT3NTk2W+Dk96z4hmw5VgSGGGnQtp42Ys46pJVxvmAduS8dQ3qKeM6ZFSIM15l1E+Ho85Rf6wK9Ygys1QIz16Log7a093IPLwM9lW8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [116.25.94.187])
	by smtp.qiye.163.com (Hmail) with ESMTP id 312c49402;
	Mon, 19 Jan 2026 22:16:28 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: wangruikang@iscas.ac.cn
Cc: amadeus@jmu.edu.cn,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dlan@gentoo.org,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	spacemit@lists.linux.dev
Subject: Re: [PATCH 1/1] net: spacemit: Check netif_carrier_ok when reading stats
Date: Mon, 19 Jan 2026 22:16:20 +0800
Message-Id: <20260119141620.1318102-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e3890633-351d-401d-abb1-5b2625c2213b@iscas.ac.cn>
References: <e3890633-351d-401d-abb1-5b2625c2213b@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bd69d3e8a03a2kunm0c2bdb8b3281c6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHx0aVh9OSBgeHUoeQktIGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk1VSU5VQk9VSkNMWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUtKVUpLS1VLWQ
	Y+

Hi Andrew, Vivian,

> I am unable to reproduce this problem.
>
> Can you elaborate on what you mean by "not linked up"? I couldn't
> reproduce this on an unconnected interface.
>
> I would also appreciate more information on this in general - full
> kernel logs, hardware information (which board, what you were doing
> with cables, etc...)

I apologize for not expressing this question clearly.

I'm trying to run OpenWrt on OrangePi R2S and OrangePi RV2.
Unlike other Spacemit K1 boards, OrangePi uses the YT8531C PHY.

Read stats when the interface is not connected to a network cable:

root@OpenWrt:~# ethtool -S eth1
[   71.725539] k1_emac cac81000.ethernet eth1: Read stat timeout
NIC statistics:
     rx_drp_fifo_full_pkts: 0
     rx_truncate_fifo_full_pkts: 0

I just discovered that adding "motorcomm,auto-sleep-disabled" to disable
the sleep mode of the MotorComm PHY prevents the problem from occurring.

I will send a DT patch instead. Sorry for the noise.

Thanks,
Chukun


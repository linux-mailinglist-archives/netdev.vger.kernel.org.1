Return-Path: <netdev+bounces-102328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 689269026DC
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 18:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE361C22E53
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ECE145328;
	Mon, 10 Jun 2024 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fgRxu3ew"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADBE86255
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037549; cv=none; b=juWrYuwOn6g9hKjfvj76ZnuaWTiOp526r1j0ovWrvI7fwGc6kLQK+jG3K9vRfh0E1fVa4K7hnCHZQ+hnh2UcLEna1SEgOmNCpBs79LKB4muJs+bWlDITFLwZ215AbPaudP12J8x/ADlakbb4jcpjcrSUmjZx9CK2YBdjs+u4E2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037549; c=relaxed/simple;
	bh=1jjte/zmPiRRGiC8eAsegTkdEtMywjk+C/MWrdgsD18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CIqcJmdahIMfqi4gTUVItfeN0J0x6SZqi0nPrKU0D15gXVrhmm8Fzma92CUTUB5bAPj8kDydpW/ounp6DaU5gMjqQEcLR9z+AgfNYlpgcglR8ip85CEbzWPChFSX9XDrGljvwtp1LTQGqyO8iSrxhQ8r03gM7Yv9C2aYewpwHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fgRxu3ew; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=+bbHA+CZ/oTaN5j2od
	Rl+WvYbLmkD2t+3PMmULwfVlE=; b=fgRxu3ew4cy4qvAI6DC1OjWZ6pLB6pPvF2
	Sy1HVB33oXw9uQzdUTn807erR9bopLIZsASj0+aefluxvG60fd2jemQ7bgPzcx96
	v5+ICzESvIUJwKhulKvqUplpT686hFNJdjVoctR9A1bDsXkcfLyXzBuDDSsnlzrH
	AYzeeRfTQ=
Received: from yang-Virtual-Machine.mshome.net (unknown [175.2.43.125])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDnz8QfLGdmOxKOCA--.12761S2;
	Tue, 11 Jun 2024 00:38:55 +0800 (CST)
From: yangfeng <yangfeng59949@163.com>
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	yangfeng59949@163.com
Subject: Re: Re: [PATCH] net: phy: rtl8211f add ethtool set wol function
Date: Tue, 11 Jun 2024 00:38:55 +0800
Message-Id: <20240610163855.6877-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e43bacfc-0143-4291-97a6-34c02b92d059@lunn.ch>
References: <e43bacfc-0143-4291-97a6-34c02b92d059@lunn.ch>
X-CM-TRANSID:_____wDnz8QfLGdmOxKOCA--.12761S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUFZXOUUUUU
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiVgrxeGV4IoOLEgAFs1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

We want to set wol on/off via ethtool, if phy doesn't have set_gol and get_wol functions, ethtool shows up as "supports wake-on: d". 
And use the PMEB mode magic package for wol, however INTB mode can't be specified this way. 
Also, the PMEB mode register is not set in this code, the board is set to PMEB mode via bios.



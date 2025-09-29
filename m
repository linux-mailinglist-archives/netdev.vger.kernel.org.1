Return-Path: <netdev+bounces-227084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BFEBA8136
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 08:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930D917D559
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 06:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA8A23F40C;
	Mon, 29 Sep 2025 06:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="BgL5aZOZ"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4323D7DE;
	Mon, 29 Sep 2025 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759126481; cv=none; b=sA36ViWbxUMpk6h6dvUSXQejdxzhXdb9ywK6EIu9JCzgp3SebzUWksCmj1tpPuvI69T+j5FN3ll8Z0Ot57N2DzABlBIiiY6rZwLRE1o+Wmp3hd5RSeqvM9jeYzCJoTsobMsdW+S09MjIaay42OGRGwwoqGnD6ezZyJgmk4Iz61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759126481; c=relaxed/simple;
	bh=m0Z08O7L4boL8QADqC2bgGp3lx55U5GQ/wSA8X0zRr0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=o5q8I2RAUGThZhCGk/ld803U+w8Z+uN2UmlfhkY2HvnMQcJ3pD2Fi4J0SBOZ6OOt01HdAWNg/TukBfvo6bnOrWf//a4JKIy5v0l6rEMkBQcGhdlovw8hM1ZmPauCZyxrbCwWsjC7ju6VJIm7f2jaPIr++7DgAUoykeXkZmJ361w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=BgL5aZOZ; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LhCzfI3a33n71Q6JUjSWXwlIsTQV2S+5OVxI4ljc3rQ=; b=BgL5aZOZegqb7yw8oMLyOgEN6W
	0L7R+4xokCa4gOguoUICzDSzW0wojNvTFSycSChFuKxpvKLShygFcMk2tpFmUXGDDkYLrHXjCgCgC
	ALR9FVKwyNeEfrJ3VwGDAvn00SZ5xqWeAT8myQr37gG0mJz5IDDeI0znOTH3h3diaH+L1VYm3JXeR
	+pl0d2g0rg9TH7dYxb1A6kNGNa7wF9/E8c9rmbjDGzc6b3YQaJI+ZhbkABOiIkQCSIak2wBbpfMTK
	gvJVs25hcoqVmpkdBT6OnpgwK1Z6pd92BauEWWXASlvScLEvpbQ3G6NXHx3fIAjG6UacjGPn9aV7T
	+BxtYDhQ==;
Received: from [122.175.9.182] (port=8359 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1v379a-00000008fEe-21oW;
	Mon, 29 Sep 2025 02:14:30 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id D86761781F94;
	Mon, 29 Sep 2025 11:44:25 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id B9FEE17820F5;
	Mon, 29 Sep 2025 11:44:25 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z89e3CPQ0WEl; Mon, 29 Sep 2025 11:44:25 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 654E21781F94;
	Mon, 29 Sep 2025 11:44:25 +0530 (IST)
Date: Mon, 29 Sep 2025 11:44:25 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, kuba <kuba@kernel.org>, 
	pabeni <pabeni@redhat.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, pmohan <pmohan@couthit.com>, 
	basharath <basharath@couthit.com>, afd <afd@ti.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>, 
	parvathi <parvathi@couthit.com>
Message-ID: <1176879373.438342.1759126465054.JavaMail.zimbra@couthit.local>
In-Reply-To: <383e4a23-447e-4024-8dc9-fc52ea209025@lunn.ch>
References: <20250925141246.3433603-1-parvathi@couthit.com> <0080e79a-cf10-43a1-9fc5-864e2b5f5d7a@lunn.ch> <773982362.433508.1758892145106.JavaMail.zimbra@couthit.local> <383e4a23-447e-4024-8dc9-fc52ea209025@lunn.ch>
Subject: Re: [PATCH net-next 0/3] RSTP SWITCH support for PRU-ICSSM Ethernet
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC139 (Mac)/8.8.15_GA_3968)
Thread-Topic: RSTP SWITCH support for PRU-ICSSM Ethernet driver
Thread-Index: fliDJmawFSlr9+bMXgXTI3DYdqerOQ==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

>> No, this patch-set applies to both STP and RSTP. The driver and firmware
>> responds to the port-state transitions and FDB operations through the
>> standard Linux switchdev/bridge interfaces, with no STP/RSTP related
>> logic executed in driver/firmware.
>> 
>> We referred to RSTP in the commit message as it is our primary use case
>> and it implies support for STP as well.
> 
> I would not say RSTP implied STP, because the higher level
> implementation is very different. You need to know the low level
> details to understand they use the same driver API.
> 
> Please generalise the commit messages, mention STP as well as RSTP.
> 
> Thanks
> 	Andrew

Understood, we will update the commit message in the next version.


Thanks and Regards,
Parvathi.


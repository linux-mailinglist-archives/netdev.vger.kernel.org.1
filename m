Return-Path: <netdev+bounces-226664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B767BA3C38
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675D01B23208
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE82F5479;
	Fri, 26 Sep 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="aKx7BLn6"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1448E2512D7;
	Fri, 26 Sep 2025 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892155; cv=none; b=kPcV9YTwQhaWYNKB6E6HnZDwGrNUUwQ55i6bWv4K7ojvwh239faZIE8Onaxod4QsAC2GKRUG6oAgZp5C7Sn7g/h26/ccchfw8StODkhxU2VY6+e+Wqy33EQbYH7KL4guyhcaS8x0RJwVZHB8kM+tuU+NmyY/Ku9+J//3CJ5Cdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892155; c=relaxed/simple;
	bh=53woFpH+TVw3DizLII2sQ+dYrMreHr6/5VUUIMUfkXw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eaG5Tf6kzI9x78L7LjrqDkpWbhu9J9LWhZ2qu4Mpd2L9FwVZkbUXzI6d1T9PA15u9YpGruBj8J56ZxTtNFGsc4sl5ezyXWFVpjtBzy3ZQ5AnIStbNmT9U6IgtHdWjtCpjAMGE4nI4eH5i1j9JvfAvhJfd2ywGO9q3YZfv7Xm/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=aKx7BLn6; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PtyV6PRmbGQ26cR1Yf8W9GPsIiuuem2tM8ucnMedeAc=; b=aKx7BLn6PGRgrEIG0c/4hgZrk4
	JUaJCJaMZJEbJaMWjkT6lPwpj+QSYsUqFrnryxbzl5484EfHKV8YD2EvCRjVwJGeju9jg5f1ogXDP
	obOOvOQ/yJlBNKEg9iiuun3XXS3b+FF4obLwUqI9o4i20E4dJ/OV4DK3RE4SUIw66fmQXAZKYAQIh
	5kb8QsQsisYT2DN/nPHDA6WWvuPDbhRdvPSxyPuz8jMyI7vDkvhABKQWwCPOkoncq23O9oNGUpVDh
	x6Tigq9l4LSzX4Whu1m0wky27ZCLJrfPbRmZ4U/2qPcP2mU46vKsfoW3wAIsQygyt4TKr4K0kVppg
	Ap9VUmRg==;
Received: from [122.175.9.182] (port=48006 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1v28CF-00000006Ytd-0KRX;
	Fri, 26 Sep 2025 09:09:10 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 125421783FF9;
	Fri, 26 Sep 2025 18:39:06 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id E37941783FF3;
	Fri, 26 Sep 2025 18:39:05 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bvkrUVJt43l9; Fri, 26 Sep 2025 18:39:05 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 53A021781C3D;
	Fri, 26 Sep 2025 18:39:05 +0530 (IST)
Date: Fri, 26 Sep 2025 18:39:05 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: parvathi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>, 
	afd <afd@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>
Message-ID: <773982362.433508.1758892145106.JavaMail.zimbra@couthit.local>
In-Reply-To: <0080e79a-cf10-43a1-9fc5-864e2b5f5d7a@lunn.ch>
References: <20250925141246.3433603-1-parvathi@couthit.com> <0080e79a-cf10-43a1-9fc5-864e2b5f5d7a@lunn.ch>
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
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: RSTP SWITCH support for PRU-ICSSM Ethernet driver
Thread-Index: baBJgWRemsOFlllaDdRIwjoAJGMMPQ==
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

> On Thu, Sep 25, 2025 at 07:32:09PM +0530, Parvathi Pudi wrote:
>> Hi,
>> 
>> The DUAL-EMAC patch series for Megabit Industrial Communication Sub-system
>> (ICSSM), which provides the foundational support for Ethernet functionality
>> over PRU-ICSS on the TI SOCs (AM335x, AM437x, and AM57x), was merged into
>> net-next recently [1].
>> 
>> This patch series enhances the PRU-ICSSM Ethernet driver to support
>> RSTP SWITCH mode, which has been implemented based on "switchdev" and
>> interacts with "mstp daemon" to support Rapid Spanning Tree Protocol
>> (RSTP) as well.
> 
> Is there anything in this patchset which is specific to RSTP? In
> general, there is no difference between STP and RSTP. STP is generally
> done in the kernel as part of the kernel bridge code. RSTP does it in
> user space. But the hardware driver does not care if it is STP or
> RSTP, it is the same API to the layer above.
> 
> 	Andrew

No, this patch-set applies to both STP and RSTP. The driver and firmware
responds to the port-state transitions and FDB operations through the
standard Linux switchdev/bridge interfaces, with no STP/RSTP related
logic executed in driver/firmware.

We referred to RSTP in the commit message as it is our primary use case
and it implies support for STP as well.


Thanks and Regards,
Parvathi.


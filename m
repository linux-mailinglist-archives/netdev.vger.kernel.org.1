Return-Path: <netdev+bounces-206156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFBBB01C07
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2B9189B529
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541B529B8E2;
	Fri, 11 Jul 2025 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="29TjSso5"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5803299A82;
	Fri, 11 Jul 2025 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237007; cv=none; b=R6yKJqVTYs2nL2GImC4ycSdjbeSra+8M4/UVu+l1+YwiQ3l/il5rWJG6EPbzcIUx13gIypPhlI3xa1iMKQ9wr7Tsj1BMBd/r0rzB4l8uP1rO5sbJI5HVd/7ro9u5JBoSCTYPG9ESi1qX+IaDC0Iv1NjAErXzsVkgbu9JQ2XkPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237007; c=relaxed/simple;
	bh=0dxJOqsvNf9YI6ttikFKyQFzL+BZ/9qDNKVRZ9z1T0U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZBgWbtqEYSDqYnbwRqr9WhZ/du+zSD5D7Ai5VGScKyOEOHzfi5WyQSH+ZjDOKNHYPxUNqElwNA60R7ISjWPB6va7aK7UMJ4+oJnpIsAg7xHQJUq64AvT1dmgRTLc/EePnsY2bMUkYQUMusEpUKDDo3F5i+EVtBG8Cs9dMPJ0TYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=29TjSso5; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+mZwtOnORz1zUe5SEHz2Hy5URcUgxMWga++pbIoA72M=; b=29TjSso5NUVzpIbIMeTLBFozU8
	a/49n3lqFqyPoZFcLVNitCd+/vq9uiOFbubAN8iDwg5m4e+cxvhtom09NZ1q9eHbjMFqOHLaTDCPz
	KSAbXgDlI7CkLrVI13E0HXOn77ZOEZok5wQW7DnsipF9UrzVtxEwHMvmhv7ll6ztrtXPatwUxUeoo
	EvjgQ9ztRyOUQIywqKTkqO+8gMOyfsPN4VGqlJMyhpz7Q2XT6exugj/pOT91A89sKCrPCFXQDln4G
	PbDkmZ4kbPo1TMW0kQMakfLJSBi50+6tUSm2BmZrQirU1XLAdCidVB/rOXnckLCrgmii3Jy5QhBfp
	DZScMP5g==;
Received: from [122.175.9.182] (port=57395 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uaCjj-0000000CkrI-2Xqr;
	Fri, 11 Jul 2025 08:20:19 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 998741781A71;
	Fri, 11 Jul 2025 17:50:11 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 7262017820AC;
	Fri, 11 Jul 2025 17:50:11 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4htU6JcfYILf; Fri, 11 Jul 2025 17:50:11 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 3020C1781A71;
	Fri, 11 Jul 2025 17:50:11 +0530 (IST)
Date: Fri, 11 Jul 2025 17:50:10 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: kuba <kuba@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	s hauer <s.hauer@pengutronix.de>, m-karicheri2 <m-karicheri2@ti.com>, 
	glaroque <glaroque@baylibre.com>, afd <afd@ti.com>, 
	saikrishnag <saikrishnag@marvell.com>, m-malladi <m-malladi@ti.com>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	horms <horms@kernel.org>, s-anna <s-anna@ti.com>, 
	basharath <basharath@couthit.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <1001900168.1712445.1752236410964.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250708173310.5415b635@kernel.org>
References: <20250702140633.1612269-1-parvathi@couthit.com> <20250708173310.5415b635@kernel.org>
Subject: Re: [PATCH net-next v10 00/11] PRU-ICSSM Ethernet Driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: PRU-ICSSM Ethernet Driver
Thread-Index: TXP7pHbOvWv5H2YAdaWH+8TjmJE3lA==
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

> On Wed,  2 Jul 2025 19:36:22 +0530 Parvathi Pudi wrote:
>>  17 files changed, 4957 insertions(+), 4 deletions(-)
> 
> Please try to remove some features from the series.
> The chances that a maintainer will have time to look thru 5kLoC
> in one sitting are quite low.

We are refactoring and limiting features without affecting
fundamental functionality for AM33x, AM43x and AM57x platforms.

We will post the updated patch series shortly.


Thanks and Regards,
Parvathi.


Return-Path: <netdev+bounces-220849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D4B49214
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B31C1BC1717
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9190F30ACF6;
	Mon,  8 Sep 2025 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="FWdgS11t"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D22F7453;
	Mon,  8 Sep 2025 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343045; cv=none; b=HO30hozlmeEakMlKy/C242ksKRbg0E+2YCTKO4jO2cRe1/cgFdKyoFhWOB1eWDPesazIL1E6ValtH0ra1cnM6c865opmpkyIs9AFZch3cQCy8ZxcZEitoyf8bplvedx7L5nR7HktMAUw9UPry9rCQ4M/1xZ6MTu9uBL4hkSvDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343045; c=relaxed/simple;
	bh=5hG0q3nSRd7Hm9Dup++wc1r+pDFpdLZ2tgV/HNS7bO8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=H9DlvQR7PJXHA80iC91LLfi9SsFF0rlGk8p+ixfc7l4HcloVy0JiaU/IW/k1trQTOJU6RRtANRxg769LQeGcAkd9CFiFNarO19Znbe6TP+8a+1j0BuIgZepPMK2baM6/LcbnKCoFAA7aVtAYphKFemEI2N9wnRsNagL+SrBG3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=FWdgS11t; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RwHTVi+PZizs+OV4gI3ySDrmg4AiYXrmj6y0oc0TQk0=; b=FWdgS11tTW2FrsBTA33kGxMseO
	2hxuaDQJNQX0m+psQxLqNUbQ80jTTeH5FtQGcZKYp3oubAx8OI2NGrRvoIsFkk/ST+WciC1t5Nwip
	DU2rbZbrkpTUvzV8VzecBb6z2DbY1c8VWLCqb5uS3d/hx4aLSgVXZSMDXuw3JrqvhksdRZKd6OgEa
	UpYPkd0z9iBZ7PsqtdzYHPNv1fPipuVELxLOWnbz2wAFna2ULbdohzG6tndYfND8tlSKFMpBDdY+B
	eflnKZ8oaUlPtWpO9G5xFyU6gsMxAcB6T7QImo/1TEk1d6m6dW1I+9XW9BKmjzeAuJKhBLIib9BSS
	ov0asiIA==;
Received: from [122.175.9.182] (port=63034 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uvdCP-0000000G7f7-2Izr;
	Mon, 08 Sep 2025 10:50:30 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id C652D1781F3C;
	Mon,  8 Sep 2025 20:20:20 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 968B41783FF8;
	Mon,  8 Sep 2025 20:20:20 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oaVUIR3lcc0B; Mon,  8 Sep 2025 20:20:20 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 44B6B1781F3C;
	Mon,  8 Sep 2025 20:20:20 +0530 (IST)
Date: Mon, 8 Sep 2025 20:20:20 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: kuba <kuba@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	m-malladi <m-malladi@ti.com>, s hauer <s.hauer@pengutronix.de>, 
	afd <afd@ti.com>, 
	michal swiatkowski <michal.swiatkowski@linux.intel.com>, 
	jacob e keller <jacob.e.keller@intel.com>, horms <horms@kernel.org>, 
	johan <johan@kernel.org>, ALOK TIWARI <alok.a.tiwari@oracle.com>, 
	m-karicheri2 <m-karicheri2@ti.com>, s-anna <s-anna@ti.com>, 
	glaroque <glaroque@baylibre.com>, 
	saikrishnag <saikrishnag@marvell.com>, 
	kory maincent <kory.maincent@bootlin.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	basharath <basharath@couthit.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <974157264.314549.1757343020136.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250905183151.6a0d832a@kernel.org>
References: <20250904101729.693330-1-parvathi@couthit.com> <20250905183151.6a0d832a@kernel.org>
Subject: Re: [PATCH net-next v15 0/5] PRU-ICSSM Ethernet Driver
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
Thread-Index: lBuvfkt+lp1JesCVjb5URBl/aXb/jg==
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

> On Thu,  4 Sep 2025 15:45:37 +0530 Parvathi Pudi wrote:
>> The Programmable Real-Time Unit Industrial Communication Sub-system (PRU-ICSS)
>> is available on the TI SOCs in two flavors: Gigabit ICSS (ICSSG) and the older
>> Megabit ICSS (ICSSM).
> 
> Looks like the new code is not covered by the existing MAINTAINERS
> entries. Who is expected to be maintaining the new driver?
> Please consult:
> https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html


We will update the MAINTAINERS information in a separate patch to this series and share
the next version soon.


Thanks and Regards,
Parvathi.


Return-Path: <netdev+bounces-170671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA04A497F9
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB723B5B32
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E125F974;
	Fri, 28 Feb 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="EUKyxWgt"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7591B4250;
	Fri, 28 Feb 2025 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740300; cv=none; b=nBnZXSMpzlLgHxGVFz0DQG8m/ywmJtLizIqY3Neqb9JAACh3SaHhsQC+nCXF4MhVRAldjl3n1nHzbvOZ8Q9I813fY/UbskwpaG59jE/79tnnxs8bU6MOAD1q4sNnB1q2dzekuGrTNHqBc/Y9SSXCctmsskOb5xxcmQSol9NS6GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740300; c=relaxed/simple;
	bh=y4qLzVKeSumaJbQ2OcL2SjtVFyTfjHTiQ6ulK7YfVZ4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Mt3FcU1RxQqe2rABKfkfmynjXVcB0kkpwmCUEHFeMfbQGIFFnNown3q8rR2F2FM+7BpTQG9jaFabUK8ZFqI8yN/ntU1CcSPkhBqRhtmS2VjjOX6zSItptIzWf/GYKKVVK2dP4QB2Mpsl6nNgLyI9q8KZMFtk7eyPF8rSVg1thzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=EUKyxWgt; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sE6TUNROnNN1BDGkZDG+hbLODugZVEpsfc3S6d8BpfU=; b=EUKyxWgtREsHH005xVidHeShMx
	o2x3gSov/MlMrfIA27GHA5iGyEQwi3KIMdUbPYzkOMfk2/bQH3VV2QHcxl2MfFHGDmMiiCcRyDV2G
	P3sSQc+ZRzWAlw/lANFEUHIRpFjAa28kdzEb0iGlatdiDSr/QpkG1TPl+Y5G1+V262nOY0WsaQoNH
	/O6aOmQshXEiddFa+rgrgmNFg8eTciU64Oieyx5iyu08RoDurdKPku1Xa6KpsPhWs4LFt+LuHlm0L
	6aM/f8/qdaDTTj/dt3NtV5vIrrK6td+9pqrYzM8OAqpIZ2rsO5c0G6YyTNTrB2nNvqs9s4yLKZxNL
	OtKk1cBQ==;
Received: from [122.175.9.182] (port=44904 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1tny4L-000000003tI-3dut;
	Fri, 28 Feb 2025 16:28:14 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 21DA91782035;
	Fri, 28 Feb 2025 16:28:08 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id F05031784068;
	Fri, 28 Feb 2025 16:28:07 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MkyykbHGCm10; Fri, 28 Feb 2025 16:28:07 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id B25DB1782035;
	Fri, 28 Feb 2025 16:28:07 +0530 (IST)
Date: Fri, 28 Feb 2025 16:28:07 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: nm <nm@ti.com>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	basharath <basharath@couthit.com>, schnelle <schnelle@linux.ibm.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	m-karicheri2 <m-karicheri2@ti.com>, horms <horms@kernel.org>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	m-malladi <m-malladi@ti.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	afd <afd@ti.com>, s-anna <s-anna@ti.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <506678778.717678.1740740287558.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250226184408.d4gpr3uu2dm7oxa2@handwork>
References: <20250214054702.1073139-1-parvathi@couthit.com> <20250226184408.d4gpr3uu2dm7oxa2@handwork>
Subject: Re: [PATCH net-next v3 00/10] PRU-ICSSM Ethernet Driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: PRU-ICSSM Ethernet Driver
Thread-Index: IPUW/PB0LmhbxyH+Oxy+FoQN15s69g==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> On 11:16-20250214, parvathi wrote:
> [...]
>> The patches presented in this series have gone through the patch verification
>> tools and no warnings or errors are reported. Sample test logs verifying the
>> functionality on Linux next kernel are available here:
>> 
>> [Interface up
>> Testing](https://gist.github.com/ParvathiPudi/f481837cc6994e400284cb4b58972804)
>> 
>> [Ping
>> Testing](https://gist.github.com/ParvathiPudi/a121aad402defcef389e93f303d79317)
>> 
>> [Iperf
>> Testing](https://gist.github.com/ParvathiPudi/581db46b0e9814ddb5903bdfee73fc6f)
>> 
> 
> 
> I am looking at
> https://lore.kernel.org/all/20250214085315.1077108-11-parvathi@couthit.com/
> and wondering if i can see the test log for am335x and am47xx to make
> sure that PRUs are functional on those two?
> 

In this patch series we have added support for PRU-ICSS on the AM57x SOC.
Hence the test log was only included for the AM57x SOC. We are working in parallel
to add support for PRU-ICSS on the AM33x and AM43x SOC's as well. We will send it as
a separate patch series at a later time.


Thanks and Regards,
Parvathi.


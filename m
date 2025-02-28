Return-Path: <netdev+bounces-170670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC4DA497F0
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F8F3BBBF1
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB4E25F974;
	Fri, 28 Feb 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="ll921IZ6"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4825D1F8;
	Fri, 28 Feb 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740159; cv=none; b=JQccluUUXtZIuzGfqU05L025lbX4hDc8cTGqEPCCtcMfC4nlD/sz1vCfQPc81MjzPp8f3OdgMRv/guJvN+rIuiuy86wRJN80DRhB7vzD3FEWC/ywCfvXsvGe2W9uO0WmU6gMNel2ZA3VPXxedr5Lmckh4iYZTMbFsNzMDpfVkkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740159; c=relaxed/simple;
	bh=ybYNoa5DyDWxXzDm1f7ZLGFGQUGnbYx1zOwQ2g4yikw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Zt+RbrlfBCa2bhCm97m9rzwsbObx6bNmJ8+P/Ccu/jRgCzPFNgHQC09jfW65pas3oM+YVrchSHnRG0Q0v6ODD4MrBLT5+hQ8Sh4KMClo0AmiouhjU7kZggUbTQFPDUJqH6kU2/JOB2mIUOhMqN9aSgKu4NYo/D5Xb7Nnm6bFaQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=ll921IZ6; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UUxYy44GRIO4cQdUKxtZBENf+y127GHIZ7y6niKwD+c=; b=ll921IZ6bNuWX05m2a5g//QzBa
	2JCmTkTA3/84gqEYAA4nwTHgiqA/9K5CQBOS6D9FZZ60vQsZ81Ez+TDzPDQGwuDW8rK+VZNhImWhB
	lhqApCidqEle+BYlnJG4f9MWK2E3891Cl6d4WRyF/hKDwrrtevIBR/R/exbUjlPquJccsdrAWc/Od
	ebaySp0lHJ/LM7hHJsncEU34i2VJQC6YTlBrT1gjLnS/W5GXrekrWy75Efy8OTUJFenW/DNlvgbHS
	KWgGwLXTpMjyGG4BphJWlFUNZrThRzqhTLB7hQvadtlHMjyXAQlT6amUmuDcXkXpAtpAwY24h9Fmi
	dckhrPHQ==;
Received: from [122.175.9.182] (port=22918 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1tny1x-000000003oR-49Ac;
	Fri, 28 Feb 2025 16:25:46 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 6A87B17840AC;
	Fri, 28 Feb 2025 16:25:38 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 4F77F1784068;
	Fri, 28 Feb 2025 16:25:38 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iYYW2RZnI8rr; Fri, 28 Feb 2025 16:25:38 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 069531782035;
	Fri, 28 Feb 2025 16:25:38 +0530 (IST)
Date: Fri, 28 Feb 2025 16:25:37 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: danishanwar <danishanwar@ti.com>
Cc: parvathi <parvathi@couthit.com>, kuba <kuba@kernel.org>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	nm <nm@ti.com>, ssantosh <ssantosh@kernel.org>, 
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
Message-ID: <1432177615.717619.1740740137819.JavaMail.zimbra@couthit.local>
In-Reply-To: <af1d819a-4782-4b56-9e60-20263930bf19@ti.com>
References: <20250214054702.1073139-1-parvathi@couthit.com> <20250214170219.22730c3b@kernel.org> <1348929889.600853.1739873180072.JavaMail.zimbra@couthit.local> <af1d819a-4782-4b56-9e60-20263930bf19@ti.com>
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
Thread-Index: AjaAuJTDl7foxdNqzd93kIb2DnSneg==
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
 
> On 18/02/25 3:36 pm, Parvathi Pudi wrote:
>> 
>> Hi,
>> 
>>> On Fri, 14 Feb 2025 11:16:52 +0530 parvathi wrote:
>>>> The Programmable Real-Time Unit Industrial Communication Sub-system (PRU-ICSS)
>>>> is available on the TI SOCs in two flavors: Gigabit ICSS (ICSSG) and the older
>>>> Megabit ICSS (ICSSM).
>>>
>>> Every individual patch must build cleanly with W=1.
>>> Otherwise doing git bisections is a miserable experience.
>>> --
>> 
>> As we mentioned in cover letter we have dependency with SOC patch.
>> 
>> "These patches have a dependency on an SOC patch, which we are including at the
>> end of this series for reference. The SOC patch has been submitted in a separate
>> thread [2] and we are awaiting for it to be merged."
>> 
>> SOC patch need to be applied prior applying the "net" patches. We have changed
>> the
>> order and appended the SOC patch at the end, because SOC changes need to go into
>> linux-next but not into net-next.
>> 
>> We have make sure every individual patch has compiled successfully with W=1 if
>> we
>> apply SOC patch prior to the "net" patches.
>> 
> 
> If there is any dependency in the series, the pre-requisite patch should
> come before the dependent patch. In this series, SoC Patch should have
> been the patch 1/10 and the warnings could have been avoided.
> 

Sure, we will change the order and resubmit the patches in the next version.

Thanks and Regards,
Parvathi.



Return-Path: <netdev+bounces-167268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762EAA39844
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B03F3A032A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C94F233D9E;
	Tue, 18 Feb 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="YsjgW8iQ"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084223024C;
	Tue, 18 Feb 2025 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873194; cv=none; b=utcBU9ZabyHhv0DG6O2g/JRapS175GEuJbGiSNVT95B/RSojM3pH5cp78K9hJ9h/i/jFphsyjn3ZZM1PR3ojnHqJb/N1u83sWIxJC1vstqyIUudbVSbZF32cMQZA489bRGgM5zMBPN7Cml3Bzv2Zo5IzT+5qk8wAEoQSQJpmLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873194; c=relaxed/simple;
	bh=E3xOi/9hGj00jnNV5AhoZbkDyjCclw+unRetxDkBpRg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eTjmwhc3oGqetrzq4iOKvWc/4Z6X3TqNu5HK8How43apSieAw8xkGlJyUMBWwoSTaBtZW6+Gru2/cHOunMfxQo/qg9p4zWrx7iay9hqBzFeRzsjnjLBsPCzoMLOO680EL9lE+BVMMhscitarjww5Afreoaevu7q6pjfPkjwXjjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=YsjgW8iQ; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OVLzpGyAnuZGHlfCQnUEFiF2NICo49l1c70JyAHdJCE=; b=YsjgW8iQkmOefbMr+6DULtsIga
	yFggL4XyBiiokWFf3Yl10YLELIEdidsYjMd1P23he71C2U0yLjxOQ1A2Z1/Lxh452bIq7+gmWbfhH
	ykWZ3d/b0XeYJlwVZY8I8ahMi8s3TkX4kifAxMp/kp2wa3mH+63hOkhk402KWiBaAoPNPKTJOQs2f
	qoxFzskQ+WpcfR2y/pE4OMAAGAJDbJgiuxgQ6iop5tWejuRB+1aLSnzTWbk77Gdn66JlCUuM6pcSR
	p4mcDjSZ/iglZq+kxgGilPEXmFV1sfz1koVdXfY2+evT2Ue16Ysfe6Ey5OKxEJvxt0YlReMGrD7be
	0JNj/tYQ==;
Received: from [122.175.9.182] (port=15274 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parvathi@couthit.com>)
	id 1tkKUm-00086M-2f;
	Tue, 18 Feb 2025 15:36:29 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 8A9E317821C8;
	Tue, 18 Feb 2025 15:36:20 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 665BF17823D4;
	Tue, 18 Feb 2025 15:36:20 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AF5WfMi2JOCR; Tue, 18 Feb 2025 15:36:20 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 3381D17821C8;
	Tue, 18 Feb 2025 15:36:20 +0530 (IST)
Date: Tue, 18 Feb 2025 15:36:20 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com, 
	ssantosh@kernel.org, richardcochran@gmail.com, 
	basharath <basharath@couthit.com>, schnelle@linux.ibm.com, 
	diogo ivo <diogo.ivo@siemens.com>, m-karicheri2@ti.com, 
	horms@kernel.org, jacob e keller <jacob.e.keller@intel.com>, 
	m-malladi@ti.com, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, afd@ti.com, 
	s-anna@ti.com, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pratheesh <pratheesh@ti.com>, 
	Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth@ti.com, srk@ti.com, 
	rogerq@ti.com, krishna <krishna@couthit.com>, 
	pmohan <pmohan@couthit.com>, mohan <mohan@couthit.com>
Message-ID: <1348929889.600853.1739873180072.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250214170219.22730c3b@kernel.org>
References: <20250214054702.1073139-1-parvathi@couthit.com> <20250214170219.22730c3b@kernel.org>
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
Thread-Index: G9POODYMWs8t48CuCyp4N0Tp+gKU+w==
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

> On Fri, 14 Feb 2025 11:16:52 +0530 parvathi wrote:
>> The Programmable Real-Time Unit Industrial Communication Sub-system (PRU-ICSS)
>> is available on the TI SOCs in two flavors: Gigabit ICSS (ICSSG) and the older
>> Megabit ICSS (ICSSM).
> 
> Every individual patch must build cleanly with W=1.
> Otherwise doing git bisections is a miserable experience.
> --

As we mentioned in cover letter we have dependency with SOC patch.

"These patches have a dependency on an SOC patch, which we are including at the
end of this series for reference. The SOC patch has been submitted in a separate
thread [2] and we are awaiting for it to be merged."

SOC patch need to be applied prior applying the "net" patches. We have changed the 
order and appended the SOC patch at the end, because SOC changes need to go into 
linux-next but not into net-next. 

We have make sure every individual patch has compiled successfully with W=1 if we 
apply SOC patch prior to the "net" patches.


Thanks and Regards,
Parvathi.


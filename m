Return-Path: <netdev+bounces-172464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EDAA54C6F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA031707E8
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363CE20E6F2;
	Thu,  6 Mar 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="GLNF7/vV"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16920E6E6;
	Thu,  6 Mar 2025 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268609; cv=none; b=M91tY5Vg0+Zdysrq4i5N8hqV4u2wS35V+RBpGNOkdrK7Scd/ccQuCv9XAd6w6fV0HL4kvatnmhD7eyaaiRDm0aufpmNgjbH2XWZEVfWdrm8ZHz8GmDiow1j4jdj4vToWqKWl+q/Vs6o2Oi8JXRsEEXg9mtLIy3tLUTaoAbPsdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268609; c=relaxed/simple;
	bh=XhsdipqSjgN8I5C9hMAA5/EaEx3JzwQ1VDXAA/0IYW4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LsxAZ567ZEJVk5hPBOmbXEO2bI3j0gyCQ82Jm5peZqt5hT1mb1I8tHXUhOKnC/5sLryHFQ6rT6XaMkos3FBNCqJesK/Fnbat/GSmlxtBnhTfU3XXi/KXoB4Te1DUHOTq6ZwpAN+fV66ZbTRscIG5wRNQ8csEHPk25MHaAOERn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=GLNF7/vV; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=F58zD1KPXjvS97YM9EyLtNejKNfhEHL4YP2fhCSVYAI=; b=GLNF7/vViLVas2l4dYtlA7nzRv
	VN37Fu9gMHnjYGhgF8QsrXLgZ/Nn+taCvR1fBkOZ1I4NijVwkTB88HB85SYt3EbOg/P/qtBv73B2B
	u8xH8lsIA6U9QMt1QWKe28dusvfqVf+fwj14n57KayEt81Tj+TiBqQUVip/cZS50PhKs1HP0YMA0+
	nm/Dj95s1UkxuaxSP3LuLPMddc3v6VYQvcdpvM2AyPC8yGWl/Q63y9TCHEM3PdlR/nhBbD9YJX/tZ
	4vBfHQ65x4JFJ3V4G305lalGh5kIQhROwSZBSKWItn8nYbRMw6y+kWnwp0i6XuTtcUFJlHSLBnBt4
	OCCAuqFw==;
Received: from [122.175.9.182] (port=34841 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1tqBVL-0000000020s-0x6M;
	Thu, 06 Mar 2025 19:13:15 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id B5E4E178247D;
	Thu,  6 Mar 2025 19:13:06 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 955EC1781E38;
	Thu,  6 Mar 2025 19:13:06 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Fa2jILuXZBoo; Thu,  6 Mar 2025 19:13:06 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 547BC1781C4E;
	Thu,  6 Mar 2025 19:13:06 +0530 (IST)
Date: Thu, 6 Mar 2025 19:13:06 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: nm <nm@ti.com>
Cc: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, kuba <kuba@kernel.org>, 
	pabeni <pabeni@redhat.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	ssantosh <ssantosh@kernel.org>, 
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
Message-ID: <1229872038.768025.1741268586173.JavaMail.zimbra@couthit.local>
In-Reply-To: <506678778.717678.1740740287558.JavaMail.zimbra@couthit.local>
References: <20250214054702.1073139-1-parvathi@couthit.com> <20250226184408.d4gpr3uu2dm7oxa2@handwork> <506678778.717678.1740740287558.JavaMail.zimbra@couthit.local>
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
Thread-Index: IPUW/PB0LmhbxyH+Oxy+FoQN15s69iwVZZVb
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

>> On 11:16-20250214, parvathi wrote:
>> [...]
>>> The patches presented in this series have gone through the patch verification
>>> tools and no warnings or errors are reported. Sample test logs verifying the
>>> functionality on Linux next kernel are available here:
>>> 
>>> [Interface up
>>> Testing](https://gist.github.com/ParvathiPudi/f481837cc6994e400284cb4b58972804)
>>> 
>>> [Ping
>>> Testing](https://gist.github.com/ParvathiPudi/a121aad402defcef389e93f303d79317)
>>> 
>>> [Iperf
>>> Testing](https://gist.github.com/ParvathiPudi/581db46b0e9814ddb5903bdfee73fc6f)
>>> 
>> 
>> 
>> I am looking at
>> https://lore.kernel.org/all/20250214085315.1077108-11-parvathi@couthit.com/
>> and wondering if i can see the test log for am335x and am47xx to make
>> sure that PRUs are functional on those two?
>> 
> 
> In this patch series we have added support for PRU-ICSS on the AM57x SOC.
> Hence the test log was only included for the AM57x SOC. We are working in
> parallel
> to add support for PRU-ICSS on the AM33x and AM43x SOC's as well. We will send
> it as
> a separate patch series at a later time.
> 

Further update:

We have successfully cross compiled the kernel (linux-next) with this patch series
for AM335x and AM437x SOC respectively.

Kernel is booting well on both the SOCs and we have verified PRU functionality by
loading simple example application (pru_addition.elf) on the PRU cores, by using
"remoteproc" driver from mainline kernel.

Below are the logs for the SOCs with boot log and running PRU with elf file specified
above:

AM335x test log: <https://gist.github.com/ParvathiPudi/87d7ddf949913b80f022ed99706337ac>
AM437x test log: <https://gist.github.com/ParvathiPudi/b2d556829cb4a9e3b6b4c5656dbdd594>


Thanks and Regards,
Parvathi.


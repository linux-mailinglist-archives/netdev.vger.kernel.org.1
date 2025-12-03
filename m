Return-Path: <netdev+bounces-243373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFE9C9E3F5
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 09:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 683BE34A70D
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330752C11D6;
	Wed,  3 Dec 2025 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="Rd9YY+WJ"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6A82D5922;
	Wed,  3 Dec 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764751100; cv=none; b=rVh0yfGqLwmgU/1MjEZTSoNbl3bxURs+gs8a3TtijprgMpuSi5sSr+qa4In8oWfLcF5Zu1otBBuqMa6/S7yrkZXQqV/z6eNwvLGGOkTGuKvEzbYP9ciqC319yxUV4FPJJyWmVA/VWdb208lIUP61ueNk51oDRwHaZCcuv1TX2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764751100; c=relaxed/simple;
	bh=RvPZOSG1YATdgFBNUMKkBbJa1vOOuqcMt3E/BxZg7J0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=pK+seoulcfzSPM508p2imTC62xgbMUtNG00PDJV8HKbFxvueBhEuvGbclhNgCrMSCarSazioTpIQqEaIBjKl4FTsNRPNQPKO8bBuvKmSej2MdmxN+HGYeM/6IOKQg731OCslklg9CkS1T5I6hOUgGOv8sc+YVW5t/hSXsWSe6aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=Rd9YY+WJ; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3UJOY4vyMUgMeRHjwRhsFcjDSVBFr2F3TlIQIYfkWik=; b=Rd9YY+WJnkxZJ4szjNo9H3w9Hg
	lZZg8qD/BQJE4U0gCU0JMwOdkyrzMe7G1jpjuMrDobq6u/8eoX+NACWFBa/X0LGCVpNACm6ctC+yZ
	l++U/Gaohk2rjIJdA6i5ei4wpzlIeL9f/J894uapoRRpgULf8DlOqJp58dZ/mOKNRJbP1NQsSunp3
	OINyr1rG3b49G+FexMn4E+2HzXnyAW9g/xOcv9ArLfjA/ucxoMtaXCCIwfqZRh1Sya+19dy8PUcBk
	JOpA1OWEwk9dFTYJbJal+ARUWd+RrgRbbcOXcaGvEhU28//Tgmiz3vruaET1Kz4zLCIGr4z6tQht9
	Gdtw9rxg==;
Received: from [122.175.9.182] (port=19588 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vQiNE-00000001cuJ-1GlG;
	Wed, 03 Dec 2025 03:38:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id E10851A655AA;
	Wed,  3 Dec 2025 14:08:01 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 6Qm2ZRSK-WP5; Wed,  3 Dec 2025 14:08:00 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 21AB71A6575D;
	Wed,  3 Dec 2025 14:08:00 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id vRFxtNWMYZmL; Wed,  3 Dec 2025 14:08:00 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 0580E1A655AA;
	Wed,  3 Dec 2025 14:08:00 +0530 (IST)
Date: Wed, 3 Dec 2025 14:07:59 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, rogerq <rogerq@kernel.org>, 
	pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>, 
	afd <afd@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	ALOK TIWARI <alok.a.tiwari@oracle.com>, horms <horms@kernel.org>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>, 
	danishanwar <danishanwar@ti.com>
Message-ID: <483862293.84606.1764751079970.JavaMail.zimbra@couthit.local>
In-Reply-To: <20251201141638.00a986dd@kernel.org>
References: <20251126163056.2697668-1-parvathi@couthit.com> <20251126163056.2697668-3-parvathi@couthit.com> <20251201141638.00a986dd@kernel.org>
Subject: Re: [PATCH net-next v8 2/3] net: ti: icssm-prueth: Add switchdev
 support for icssm_prueth driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: Add switchdev support for icssm_prueth driver
Thread-Index: kayInG6VeUWfAgSoHuPqaRDLltmknw==
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

> On Wed, 26 Nov 2025 21:57:13 +0530 Parvathi Pudi wrote:
>> + */
>> +static void icssm_prueth_sw_switchdev_event_work(struct work_struct *work)
>> +{
>> +	struct icssm_prueth_sw_switchdev_event_work *switchdev_work =
>> +		container_of(work,
>> +			     struct icssm_prueth_sw_switchdev_event_work, work);
> 
> Consider using shorter type names.
> 

We will address this in the next version.

>> +	struct prueth_emac *emac = switchdev_work->emac;
>> +	struct switchdev_notifier_fdb_info *fdb;
>> +	struct prueth *prueth = emac->prueth;
>> +	int port = emac->port_id;
>> +
>> +	rtnl_lock();
>> +
>> +	/* Interface is not up */
>> +	if (!emac->prueth->fdb_tbl) {
>> +		rtnl_unlock();
> 
> Are you not leaking the device reference here?
> 

We will address this in the next version.

Thanks and Regards,
Parvathi.


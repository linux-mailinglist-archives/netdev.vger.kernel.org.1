Return-Path: <netdev+bounces-242547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0BC91FF9
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E6DB342FE4
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 12:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E138324B09;
	Fri, 28 Nov 2025 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="t/AhlW2p"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F112D594A;
	Fri, 28 Nov 2025 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764333282; cv=none; b=APkWyJI/7eGvO9UBRUbDNA2fKwHt1rMZyUSVIdCQFGoEQXykPXVtfWWWVMY/c2/jEMZTJdpIjmJfv3u6gc8IHnN7QwgGjJqKVSh2oY8CAUYrTDgh9jkfSDXCct7aTRYg1FXlBQGWJQ939qOc64X5CV7fzpjtYUFIKtVceHTJ7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764333282; c=relaxed/simple;
	bh=kQjno09qe2EWlDAZQbtWpWCI2Wtz6b/araBroVkNsec=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QYz9ETdgDzwwvV19cYuQUJXXnnmNVB4XHcPjs4AFga6z1wE6JE5xCg0yqw9QW+gcdrDrs5r7eYSOTnRV10sgjKZHSach7bEdzB9+N7K2jXSL61CKcpkYD7g4OpWhx3lIE5XvhAmQeS4mvyqeWU+Rm7tvRN98CdMBFCmGAZAMz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=t/AhlW2p; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9dH+D5mTSh5ELrYXQNv+Ooza55h/kNIOuzgn9g1M4Gk=; b=t/AhlW2pNgdxkkP4BnAGTAbg4q
	yzFNL59iUiW+bqdg2QvEAkHBmgy+/JvZbCCgUSh7l/wIXMrsXAF1aLrW62eT3YArgJrg/ypt+QWP4
	dK68VDDq/3bNQeceNdpimxAiDoRnMnC9vgk1wHXa2NTdrg4IBx6J7MGgjKg6t4MmaIuf4eBZXXHGt
	WbesSMu0yItkBDhQ6v5WHgtBDX3nPXlIu2hXMZA4chLA+ICKD045pNogaLqUItbyrTEBn5yALHr0s
	VWWcfYZdny4SI7ddDmDQLyZW/bShWdHpnssnD+CmSi22KBA7ePd5CpBIGv6d3Z0w35uBZnyv1g94T
	qlYRdzfw==;
Received: from [122.175.9.182] (port=40292 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vOxgF-0000000EcTe-04l2;
	Fri, 28 Nov 2025 07:34:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 395B21A83410;
	Fri, 28 Nov 2025 18:04:26 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id mUNqj3eLG-2O; Fri, 28 Nov 2025 18:04:25 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 4C9A01A833F8;
	Fri, 28 Nov 2025 18:04:25 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id LJ-YG9CDH0uv; Fri, 28 Nov 2025 18:04:25 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 2ED9A1A83410;
	Fri, 28 Nov 2025 18:04:25 +0530 (IST)
Date: Fri, 28 Nov 2025 18:04:25 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, pmohan <pmohan@couthit.com>, 
	basharath <basharath@couthit.com>, afd <afd@ti.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	ALOK TIWARI <alok.a.tiwari@oracle.com>, horms <horms@kernel.org>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>
Message-ID: <802911697.52286.1764333265118.JavaMail.zimbra@couthit.local>
In-Reply-To: <20251127184342.5d15c0e6@kernel.org>
References: <20251126163056.2697668-1-parvathi@couthit.com> <20251127184342.5d15c0e6@kernel.org>
Subject: Re: [PATCH net-next v8 0/3] STP/RSTP SWITCH support for PRU-ICSSM
 Ethernet driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: STP/RSTP SWITCH support for PRU-ICSSM Ethernet driver
Thread-Index: OaBX5KHFpkZx/CLKU63NiWcFnFJGkw==
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

> On Wed, 26 Nov 2025 21:57:11 +0530 Parvathi Pudi wrote:
>> Changes from v7 to v8:
>> 
>> *) Modified dev_hold/dev_put reference to netdev_hold/netdev_put in patch 2 of
>> the series.
>> *) Rebased the series on latest net-next.
> 
> The only acceptable reason for reposting within 24h is when a reviewer
> / maintainer explicitly and clearly asks for it. Please (re-)read:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> --
> pv-bot: 24h


Understood, we will follow the guidelines and avoid re-posting
within 24h.


Thanks and Regards,
Parvathi.


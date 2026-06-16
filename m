Return-Path: <netdev+bounces-299838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8cFAM5FFMWpNfwUAu9opvQ
	(envelope-from <netdev+bounces-299838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:46:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE6A68F869
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:46:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=couthit.com header.s=default header.b="J/0ZxW7L";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299838-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299838-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=couthit.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F0203207BFA
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72E2368D43;
	Tue, 16 Jun 2026 12:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AEA367B77;
	Tue, 16 Jun 2026 12:40:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613625; cv=none; b=iprS59ywrqF6w7sEGbvNriLL3JzLXaeMj2TdHWLVpoUmrVpG7MyqtOGBr7hcyxo1jL3Z8ljAbrqfN7gelSev9sIiFH8Pg5TBo+jR4fItajmuWqZMduJPynoxmKkkdRM4VSj2bYY07BKgpkSKGqTKZq6dO7AUUqf4MahQCVspex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613625; c=relaxed/simple;
	bh=4XeKWq60UBV2qmrPOY9bwFztkwl7zBGTvEprmRc+0Wo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eK8FzyXxkN3zbVmvjUq/UZsfiJTDNfjT5KavVwxTSP82qIq2Xjq2fU7blBiaUO0e9AvOFC723cwuxDfURrUYf+0Ui+IKLfuVVgcmPU7eoTBhlorpi7xrmby+7HUVk5leXMbNk1NFB0dipHz8Ndd/vvgyrLglmlLuzm5DkIXLoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=J/0ZxW7L; arc=none smtp.client-ip=162.240.164.96
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bvkZ8DMLt8TicAIiC7x/wSALOp0M65czhxs+ZBfdPY4=; b=J/0ZxW7Ly02wggASZ1/Xbr5nox
	8y5LtBgN4Sq6q0qPBvmgIBDTn1QLslLD60FUFhspSQuXFoVS9UDhHoeFUUE8Ezwj/hf3Cay5Oeznu
	f+xEwKl+CZenKqe/M9SxGJTqdk4ipMVnKYOYHdkZu2K2TDvMKyZb5kB64bX+KvGEbp/qMSWWAaTWf
	Rzj7pVl4gj6C/HOWGKqY15GPqkJfI3a2SVOqK+vsN3tIo67nuBK4LpRWYTiCc1pskWAPMDyFrafPd
	mGmSXOh2yypq7B5g23STrRwrdwbL6beVsaGzSMaZW0d1Htji2IFHrE9tAI6erpxfhd1pFa85nMMDk
	fT1Ypu9Q==;
Received: from [115.246.246.98] (port=40588 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <parvathi@couthit.com>)
	id 1wZT5Y-0000000At4u-11Yd;
	Tue, 16 Jun 2026 08:40:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 6435E19A7FA4;
	Tue, 16 Jun 2026 18:10:13 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id feLN8dZta5RF; Tue, 16 Jun 2026 18:10:10 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id C412419A7F9B;
	Tue, 16 Jun 2026 18:10:10 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 47KudGkixjvB; Tue, 16 Jun 2026 18:10:10 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 9FF6319A7FA4;
	Tue, 16 Jun 2026 18:10:10 +0530 (IST)
Date: Tue, 16 Jun 2026 18:10:10 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Simon Horman <horms@kernel.org>
Cc: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	pmohan <pmohan@couthit.com>, afd <afd@ti.com>, 
	basharath <basharath@couthit.com>, arnd <arnd@arndb.de>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	m-malladi <m-malladi@ti.com>, krishna <krishna@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <1748606529.1400457.1781613610625.JavaMail.zimbra@couthit.local>
In-Reply-To: <20260612200102.GN671640@horms.kernel.org>
References: <20260611123636.376577-1-parvathi@couthit.com> <20260612200102.GN671640@horms.kernel.org>
Subject: Re: [PATCH net-next 0/3] Introduce HSR/PRP HW offload support for
 PRU-ICSSM Ethernet driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC148 (Mac)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: Introduce HSR/PRP HW offload support for PRU-ICSSM Ethernet driver
Thread-Index: iqq9OEROOlbAtE0K3nChzbBATFVm3g==
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[couthit.com:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[couthit.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:parvathi@couthit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:rogerq@kernel.org,m:pmohan@couthit.com,m:afd@ti.com,m:basharath@couthit.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:pratheesh@ti.com,m:j-rameshbabu@ti.com,m:vigneshr@ti.com,m:praneeth@ti.com,m:srk@ti.com,m:rogerq@ti.com,m:m-malladi@ti.com,m:krishna@couthit.com,m:mohan@couthit.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,couthit.com:from_mime,couthit.local:mid,vger.kernel.org:from_smtp];
	HAS_X_AS(0.00)[smtp@couthit.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_X_GMSV(0.00)[smtp@couthit.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299838-lists,netdev=lfdr.de];
	HAS_X_SOURCE(0.00)[];
	DKIM_TRACE(0.00)[couthit.com:-];
	FROM_NEQ_ENVFROM(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_X_ANTIABUSE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EE6A68F869

Hi,

> On Thu, Jun 11, 2026 at 06:03:25PM +0530, Parvathi Pudi wrote:
>> Hi,
>> 
>> This series introduces HSR and PRP protocol HW offload support for
>> ICSSM-Prueth driver.  HW offload support for HSR/PRP is implemented using
>> dedicated HSR/PRP firmware running on 2 PRU cores(PRU-ICSS) as a "DAN"
>> available in AM57xx, AM437x and AM335x.
> 
> Hi Parvathi,
> 
> There is AI-generated review of this patch-set available on
> https://sashiko.dev
> 
> I would appreciate it if you could look over that with a view
> to addressing any issues that directly affect this patch-set.

Sure. We will review the sashiko feedback for this patch series and
address any findings that are directly relevant in the next version.

Thanks and Regards,
Parvathi.


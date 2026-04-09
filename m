Return-Path: <netdev+bounces-276834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPBtJY8Z12ldKwgAu9opvQ
	(envelope-from <netdev+bounces-276834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:14:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEB33C5FE8
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C83173010BAD
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 03:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC11E36CDEB;
	Thu,  9 Apr 2026 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="t08EX32L"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7008835F191
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 03:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704459; cv=none; b=HTyAdE7W8jlQScGVSqm0aiT5Ub3uelx07as0qHTKr0zX6su/0XnAwMdsefnw5DFBatQ9vQZByJvCW+X25+sikN4CWvklncHnKg+xNRSCnH3pEpPf8c+EnmWg5s9+6PqAz12D3zMJmc0Cmsl1kN41qxQ8lpEa7xoyjVREzFHHvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704459; c=relaxed/simple;
	bh=nDfsUA45wFoPkPBfScB8oTXEdZ9+qmyp6FIjTUlaVSg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e6qZhHrQSGDsnswwRzg22ROUG3PoKoyuJsfjpZx/Qe6hxTlrr+fEAb6ctE48HwXzzsoGV/sl0c2OpDnJQL6G5oBPXwgvr+v9IkNxkWwVANiomqKMLGdQEZEWNTZuJAL0ukcTBcPyAZN3hwAn4leFLgpzn1VY05muSSKYc0MgMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=t08EX32L; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IR3T7npias+PsiUSGbKlWZG++VR5swnJgvsp72zprLk=;
	b=t08EX32Lbf4CRiVWMLmWpccVenjrLNY7KRrVlH596/MFEr+yulLqZXh/MRdu2eJA5Jv09B2C1
	yyYJuxtCIt8vxkGyDEq6WqWU4Xaj2n9+5Gue7MCE/lzGEDo7M5T/cxd4ytwez0iq8ik/ji2nYUF
	0ZYQa1sp/i4i27aXQIGC+SY=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4frlH93SLGzmVCK;
	Thu,  9 Apr 2026 11:07:49 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 769FB40573;
	Thu,  9 Apr 2026 11:14:05 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Apr 2026 11:14:04 +0800
Message-ID: <de742f5c-b3df-498b-9611-88c0ed06799a@huawei.com>
Date: Thu, 9 Apr 2026 11:14:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <salil.mehta@opnsrc.net>, <shenjian15@huawei.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Salil Mehta as HiSilicon HNS3/HNS
 Ethernet maintainer
To: Salil Mehta <salil.mehta@huawei.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <kuba@kernel.org>
References: <20260409000430.7217-1-salil.mehta@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260409000430.7217-1-salil.mehta@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276834-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:email,huawei.com:mid,gatech.edu:email,nai.com:email]
X-Rspamd-Queue-Id: 2AEB33C5FE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


on 2026/4/9 8:04, Salil Mehta wrote:
> From: Salil Mehta <salil.mehta@opnsrc.net>
>
> Closing this chapter and a long wonderful journey with my team, I sign off one
> last time with my Huawei email address. Remove my maintainer entry for the
> HiSilicon HNS and HNS3 10G/100G Ethernet drivers, and add a CREDITS entry for
> my co-authorship and maintenance contributions to these drivers.

Salil, Thank you for your hard work over the years.
Acked-by: Jijie Shao <shaojijie@huawei.com>

note: Sorry, the previous email reply was rejected because it contained HTML part.

>
> Link: https://lore.kernel.org/netdev/259cd032-2ccb-452b-8524-75bc7162e138@huawei.com/
> Cc: Jian Shen <shenjian15@huawei.com>
> Cc: Jijie Shao <shaojijie@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   CREDITS     | 10 ++++++++++
>   MAINTAINERS |  2 --
>   2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/CREDITS b/CREDITS
> index 9091bac3d2da..a03b00452a1e 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -3592,6 +3592,16 @@ E: wsalamon@tislabs.com
>   E: wsalamon@nai.com
>   D: portions of the Linux Security Module (LSM) framework and security modules
>   
> +N: Salil Mehta
> +E: salil.mehta@opnsrc.net
> +D: Co-authored Huawei/HiSilicon Kunpeng 920 SoC HNS3 PF and VF 100G
> +D: Ethernet driver
> +D: Co-authored Huawei/HiSilicon Kunpeng 916 SoC HNS 10G Ethernet
> +D: driver enhancements
> +D: Maintained Huawei/HiSilicon HNS and HNS3 10G/100G Ethernet drivers
> +D: for Kunpeng 916 family, 920 family of SoCs
> +S: Cambridge, Cambridgeshire, United Kingdom
> +
>   N: Robert Sanders
>   E: gt8134b@prism.gatech.edu
>   D: Dosemu
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d1e6d3acbac..97d0bc3108de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11530,7 +11530,6 @@ F:	drivers/bus/hisi_lpc.c
>   
>   HISILICON NETWORK SUBSYSTEM 3 DRIVER (HNS3)
>   M:	Jian Shen <shenjian15@huawei.com>
> -M:	Salil Mehta <salil.mehta@huawei.com>
>   M:	Jijie Shao <shaojijie@huawei.com>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
> @@ -11545,7 +11544,6 @@ F:	drivers/net/ethernet/hisilicon/hibmcge/
>   
>   HISILICON NETWORK SUBSYSTEM DRIVER
>   M:	Jian Shen <shenjian15@huawei.com>
> -M:	Salil Mehta <salil.mehta@huawei.com>
>   L:	netdev@vger.kernel.org
>   S:	Maintained
>   W:	http://www.hisilicon.com


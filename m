Return-Path: <netdev+bounces-253651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKSjLOgZeGmwoAEAu9opvQ
	(envelope-from <netdev+bounces-253651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:50:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3DA8ECE9
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23A86302A7E3
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD0D284669;
	Tue, 27 Jan 2026 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DswVc6OF"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751320311;
	Tue, 27 Jan 2026 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769478629; cv=none; b=V61UPrcUanNzvqd+nmC3q0g33Dt6DPZ8Ky/ilYOriCHtifeS6RDN8vc/t7hLOg/aZCSW3+PI6ehN5WTP2Y11g226D04+vRo2IKZX8YA3lynAYRY4VBD9+5JmnDq+BPCPrbZ9DExVpyiWB5NwEpaqfC8Io3QkBDNl+vb2wywgt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769478629; c=relaxed/simple;
	bh=PoPkVPJ+AoSJsQsIpYU0/3qsSaVTpwRSPJYcLPqWts8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F3J7Um91Rmbat0e03SpsRdwgn/jIbHpCeXRCRfq1WEmJKstuJWraupnn/+MzQGqw5d7cID/sm8lc0V2dU7IC5RpKUUVZBUPGYj4oGVq0Y9P0AlO48m3NN/dhDXlXaPe3T1ieq0UPEJE2xjNfZxolnu+EenbasqqcBGpMiXwVamo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DswVc6OF; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PoPkVPJ+AoSJsQsIpYU0/3qsSaVTpwRSPJYcLPqWts8=;
	b=DswVc6OFEA3Iv0l50KMEtE9/qi1c6e3a2t+mHU0jjQStlmjbBGUuDNnsbMYhEw/VkrWMu4WjA
	zLtb5qt/0gor2GmA+WJDyQW+cLUol2CSQKfQxKUNbxFqJpVscJL/kmQ9jXxdRp/zZqx9eIRAE6b
	su/5lJa92fur/6lU0ttJETU=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4f0StW5sk7z12LGK;
	Tue, 27 Jan 2026 09:46:27 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CD38C404AD;
	Tue, 27 Jan 2026 09:50:22 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 27 Jan 2026 09:50:21 +0800
Message-ID: <acbfdba6-1590-417f-8bf5-f5ad44e1c294@huawei.com>
Date: Tue, 27 Jan 2026 09:50:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<lantao5@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/2] extend bit width in the flow director of
 HNS3 driver
To: Simon Horman <horms@kernel.org>
References: <20260123094756.3718516-1-shaojijie@huawei.com>
 <aXd0QSip2AcefqT2@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <aXd0QSip2AcefqT2@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253651-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C3DA8ECE9
X-Rspamd-Action: no action


on 2026/1/26 22:03, Simon Horman wrote:
> On Fri, Jan 23, 2026 at 05:47:54PM +0800, Jijie Shao wrote:
>> The bit widths of HCLGE_FD_AD_QID and HCLGE_FD_AD_COUNTER_NUM are
>> increased to support higher specifications.
>>
>> Note: The hardware already supports the specifications.
> Hi Jijie,
>
> Are there any compatibility issues here?
> E.g. new driver with old hardware or firmware?

Thank you, There are no compatibility issues.

The chip and firmware are supported in V2.
However, the software does not support the extension due to
consistency with older versions(and the customer has not used the extended bits either).

The queue_cnt and counter_cnt specifications of the software are directly or indirectly
queried from the firmware, and the extended bits are not used in the V1 version.

Thanks,
Jijie Shao





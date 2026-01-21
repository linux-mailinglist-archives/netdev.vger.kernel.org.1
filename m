Return-Path: <netdev+bounces-251773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHSlLQ1VcGlvXQAAu9opvQ
	(envelope-from <netdev+bounces-251773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:24:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC4A50FDC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 05:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3D7F4F0396
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118635BDC9;
	Wed, 21 Jan 2026 04:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rvq/3rZK";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rvq/3rZK"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AAC35FF7A;
	Wed, 21 Jan 2026 04:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768969476; cv=none; b=OkiIoO3ypnaHdfT1Bo4+EkbZbBxNfqY+fm8Y4raVP/OpKuvwtBfPfCpzcCxCkiTGcRwhauD2xyBz+6mTR+aPt8Vt7WFZfG63i9JjKgNWVfeIGUwnWkKYABYwjW94GfRVNketcHLDoTblb6yIXdZlNSfwwK1rCG10dHd+kjRVYrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768969476; c=relaxed/simple;
	bh=RnkLMcRQKffZL+/hd4xzZ0wM8EJgCJE3g7C0hhf8e4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guGshyaQOmcVjgXCBTzOwXNR3P2janeYseoWiDf/6RKaDEojeDepMX22Iqhv5tEVSuUAWntHIll/PQDzDumPnVtM9SqXt/o/rBaaWejLEhDsOIkIF9XVsdTX6dz/gpuOwb/i+RFsc7Or6ZNbMcJDHkOkkKy+/wmpbMYb8pvMAf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rvq/3rZK; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rvq/3rZK; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RnkLMcRQKffZL+/hd4xzZ0wM8EJgCJE3g7C0hhf8e4Q=;
	b=rvq/3rZK5l+jjY0KzUWklnhmYZR6jR1cwKeVzEF5KzB7Zdbr4TXiGK5XmI2LKq2MpBQ5ll1DF
	TLcNXo9BiJLOfZJAqSsVa6TokeaTurXwKQ1gGXpV0wCTw0NMISWt5nOHOo6N5FfEM1sJCwiERXS
	Y+SSTMBySYsyr81XB6EcSxM=
Received: from canpmsgout12.his.huawei.com (unknown [172.19.92.144])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dwrg45RSsz1BG2J;
	Wed, 21 Jan 2026 12:24:00 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RnkLMcRQKffZL+/hd4xzZ0wM8EJgCJE3g7C0hhf8e4Q=;
	b=rvq/3rZK5l+jjY0KzUWklnhmYZR6jR1cwKeVzEF5KzB7Zdbr4TXiGK5XmI2LKq2MpBQ5ll1DF
	TLcNXo9BiJLOfZJAqSsVa6TokeaTurXwKQ1gGXpV0wCTw0NMISWt5nOHOo6N5FfEM1sJCwiERXS
	Y+SSTMBySYsyr81XB6EcSxM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dwrZk38mKznTWL;
	Wed, 21 Jan 2026 12:20:14 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A19740562;
	Wed, 21 Jan 2026 12:24:12 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 21 Jan 2026 12:24:11 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <horms@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <luoyang82@h-partners.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <shijing34@huawei.com>, <wulike1@huawei.com>,
	<zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net v01 0/5] net: hinic3: Fix netif_queue_set_napi input parameters and code styles
Date: Wed, 21 Jan 2026 12:24:08 +0800
Message-ID: <20260121042408.1120-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260120154759.5a2c04c5@kernel.org>
References: <20260120154759.5a2c04c5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251773-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3BC4A50FDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/21/2026 7:47 AM, Jakub Kicinski wrote:
> On Tue, 20 Jan 2026 20:38:38 +0800 Fan Gong wrote:
>> This patchset provides netif_queue_set_napi bug fix and serveral code styles
>> fixes to :
>>
>> Fix netif_queue_set_napi queue_index parameter passing error.
>> Remove empty lines between error handling.
>> Remove redundant defensive code.
>> Use array_size instead of multiplying.
>> Sq use SQ_CTXT_PREF_CI_HI to improve readability.
>
> no reposts within 24h please
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Sorry for reposting and incorrectly confusing net and net-next.
We will send a new patchset tomorrow and add Fixed tag in patchs for fixes.


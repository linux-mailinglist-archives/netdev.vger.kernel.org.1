Return-Path: <netdev+bounces-252899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FvnNoqqc2nOxwAAu9opvQ
	(envelope-from <netdev+bounces-252899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:06:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D771D78C7B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 417F13004DAC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0C3033DF;
	Fri, 23 Jan 2026 17:06:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C542A80
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187973; cv=none; b=iZbefQ8hED764unfAiSFxoTIK0TIfcyZyVQ5b+hvjpH46vwahag4H5lMvbF9EpqybKMlj5peyGAYJ0kqrVbuCP7rHncYOcpUZ8vN3g2/kmejlR9xKdnWNCa8zR1A9CvIIzNfJaU1L+r1i6B7lhKAfugOKJ3PQvgEBcKpa00inxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187973; c=relaxed/simple;
	bh=Ti01rv7z7pULd/i0QBsRSkFbTSLn1Vyi+0EagtrVlxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LGPJxw73jjwpA7G99X2MsPx0jA2mRWUMHxVf89SzcP6iJ2RTPb0jgxklhYQHRyVGSr5G2uuSC2HmQH7s1uWIoraJa2AdYPE42C3xEhFpNFq1yZCBQPuYehX76Ut7qv+970OUyS2wQwK95YcwJojumeSN8zon1XMCOcP8RFKDGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dyPSy1FrtzJ46Yc;
	Sat, 24 Jan 2026 01:05:38 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id CCA2440086;
	Sat, 24 Jan 2026 01:06:07 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Jan 2026 20:06:07 +0300
Message-ID: <fd1c5142-b1cd-44a0-8b7b-3a21ab43a593@huawei.com>
Date: Fri, 23 Jan 2026 20:06:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] ipvlan: Deduplicate ipv4/ipv6
 addr_validator_event code
To: Jakub Kicinski <kuba@kernel.org>, Dmitry Skorodumov <dskr99@gmail.com>
CC: <netdev@vger.kernel.org>
References: <20260120161852.639238-1-skorodumov.dmitry@huawei.com>
 <20260120105909.4e52de08@kernel.org>
Content-Language: en-US
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
In-Reply-To: <20260120105909.4e52de08@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-252899-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skorodumov.dmitry@huawei.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:mid]
X-Rspamd-Queue-Id: D771D78C7B
X-Rspamd-Action: no action

yes, sorry. It was a mechanical mistake from my side

Dmitry

On 20.01.2026 21:59, Jakub Kicinski wrote:
> On Tue, 20 Jan 2026 19:18:33 +0300 Dmitry Skorodumov wrote:
>> This is a bit stylish patches: The code to handle ipv4 and ipv6
>> address change are exactly the same. We don't need separate
>> functions for them. Just look whether we are called
>> with ipvlan_addr4_notifier_block or with ipvlan_addr6_notifier_block
> [PATCH net] is for fixes, please use [PATCH net-next] for cleanups.
> If these patches depend on your locking fix you'll need to wait
> with reposting until the fix appears in net-next (Thu afternoon).


Return-Path: <netdev+bounces-267996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO4FIvNit2m4QgEAu9opvQ
	(envelope-from <netdev+bounces-267996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:54:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2023A293AE6
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BA113005582
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 01:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704342DC76F;
	Mon, 16 Mar 2026 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="R9ODD8kT"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687412D97B8;
	Mon, 16 Mar 2026 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773626095; cv=none; b=smCSqM4ccVCi0LWm8AuEA1UPgDjyZCKWqwVGzfcSIrPct6llQOUVMiLZIlz6oxvgeTOP7LFCZnNYUIyQ8ebFdN9U0rl837rG+ydklGtMgPhKeYtk6P6RL/KAlvwNJUaxGwXwws3Kls4tDRztZEB32mNQOy5EAnycSZLVx8Ct4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773626095; c=relaxed/simple;
	bh=J7/gESNJy6S3kRFzqwf0E0VTFd9Pp/MrdGZJfBuBI0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofR7LkM0U+YQZg0MctE+/H3SOsJP62LKMh+VW8Dw0IFqvA6txtVJMT84TIggWfHkjmBFMicJHtObwQzay6M6VGAMERFUJC1KovwnExcStJO4SQ/Ns7JiIHgNwAwOxANMIioCKPrv3VYQLgGWoo0LLUOkHsZsKbhFtuqhn1r3w90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=R9ODD8kT; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FfYK48iz0QHiVZquZkBh70pLzRTF+BbJow8zuSGikbs=;
	b=R9ODD8kTiPWBYT4eZeNFBpQgbjqMzCqKFGB69BtR0wOfpl5ZSpytbRr89XKvO/P1Yy++NTJJt
	uE1YTYvtpDYvb92SXqUvjjdPeqXJ46QzIsr5H/8tf0nUvKYNQXu15/Mzw094C8b/cp3NfLnAv1z
	JBe7kE2kTOMiecPyrjWNj5E=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fYyhC6Bkmz1K96N;
	Mon, 16 Mar 2026 09:49:47 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id B1C014056C;
	Mon, 16 Mar 2026 09:54:43 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 16 Mar 2026 09:54:42 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <maxime.chevallier@bootlin.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <horms@kernel.org>,
	<ioana.ciornei@nxp.com>, <kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shijing34@huawei.com>,
	<wulike1@huawei.com>, <zhengjiezhen@h-partners.com>,
	<zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v01 5/7] hinic3: Add MTU size validation
Date: Mon, 16 Mar 2026 09:54:38 +0800
Message-ID: <20260316015438.905-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <439753dc-496d-4e03-8480-ea409fb3d4bd@bootlin.com>
References: <439753dc-496d-4e03-8480-ea409fb3d4bd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267996-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2023A293AE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/2026 4:50 PM, Maxime Chevallier wrote:
> Hi,
>
> On 13/03/2026 08:54, Fan Gong wrote:
>>   Check whether the MTU size is within a reasonable range.
>
> I don't get why this is needed when we have netdev->min_mtu and
> netdev->max_mtu already to sanitize these parameters.
>
> Is this patch needed, and if so can you explain why the
> netdev->min/max_mtu parameters aren't enough ?
>
> Maxime
>

Thanks for your two reviews. We overlooked redundant defensive code and
pointer release operation in patch 2/7.
We will fix them in next version.

Fan gong


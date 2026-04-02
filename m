Return-Path: <netdev+bounces-274403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLCCOCUazmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:26:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D4385213
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E08DC311E289
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 07:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4D33876BB;
	Thu,  2 Apr 2026 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZQ2nwntW";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZQ2nwntW"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1F31E828;
	Thu,  2 Apr 2026 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114254; cv=none; b=oDskB5t3O//NCyMmX9izyDmLv9wYTYFXxXwqc4NSr0SGIKqsZBYk3nCsegIDd+tF3mt6nIYRUK6dIsf8VnvfN4dj7zdcEOH0EStnB/taV7BjI9CuGODi7ZQZpUj2JMTiRL7CfQEftfqFO5i09+BZaQJeshWpXlXwr5N0YsEneyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114254; c=relaxed/simple;
	bh=MdVvdK7OeWAS1DKm0l/0TvjYex3NYeEQXi3a21Re5XU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJqlwfEvQeWdcbeQWV8DpL41q7YJTEdz1euwI9/6bvsDku+ZlkBY3A0sKg+3d/F1Z0qJ3j99xKwnSPye5sJRbPjtK9aXEzPX2JQpjp4QXHm/C+b3RYU3NADqhTPfxRY7YqsfIIgM6hIKdZ+03U2FbXwU1mJxKHil4Ac0DUoHkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZQ2nwntW; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZQ2nwntW; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FjjN1O42JWfrYsE6u8cn0l/7c5bmdJr0V+5xnXYU6JY=;
	b=ZQ2nwntW+O0v0pYpqNbuJtKxMYr5srxNfSvtLjBVXdR9j26Tw0IsyhUt8MotF2KgJMLdTSz6W
	vEOI1UUomcRxFKk9wxk+wzdr096O4/U0It574FJCd2G8MFEePyqhn4IUtXVaKau/IWPgcJdZDwz
	oHFNoOr9RqCOLJrVOcnnJdE=
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fmY865xB4z1BFp0;
	Thu,  2 Apr 2026 15:17:10 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FjjN1O42JWfrYsE6u8cn0l/7c5bmdJr0V+5xnXYU6JY=;
	b=ZQ2nwntW+O0v0pYpqNbuJtKxMYr5srxNfSvtLjBVXdR9j26Tw0IsyhUt8MotF2KgJMLdTSz6W
	vEOI1UUomcRxFKk9wxk+wzdr096O4/U0It574FJCd2G8MFEePyqhn4IUtXVaKau/IWPgcJdZDwz
	oHFNoOr9RqCOLJrVOcnnJdE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fmY1g6x5WzpTKg;
	Thu,  2 Apr 2026 15:11:35 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 88F6F203B3;
	Thu,  2 Apr 2026 15:17:25 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 15:17:24 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <mohsin.bashr@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <horms@kernel.org>,
	<ioana.ciornei@nxp.com>, <kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
	<maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <shijing34@huawei.com>, <wulike1@huawei.com>,
	<zhengjiezhen@h-partners.com>, <zhoushuai28@huawei.com>,
	<zhuyikai1@h-partners.com>
Subject: Re: Re: [PATCH net-next v03 4/6] hinic3: Add ethtool rss ops
Date: Thu, 2 Apr 2026 15:17:19 +0800
Message-ID: <20260402071719.1715-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <3b252b2b-6be7-4a8d-9782-39695e948635@gmail.com>
References: <3b252b2b-6be7-4a8d-9782-39695e948635@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274403-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6B1D4385213
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/2026 3:53 PM, Mohsin Bashir wrote:

> > +    err = hinic3_update_rss_hash_opts(netdev, cmd, rss_type);
> > +    if (err)
> > +        return err;
> > +
> > +    err = hinic3_set_rss_type(nic_dev->hwdev, *rss_type);
> 
> So if we fail here, we have already modified the rss_type in-place. From this on-wards, the HW state would diverge from in-memory state. How about use a local copy and only update if no error?
> 
> > +    if (err) {
> > +        netdev_err(netdev, "Failed to set rss type\n");
> > +        return err;
> > +    }
> > +
> > +    return 0;
> > +}
> > + 

Thanks for your four patch reviews.

For patch 01, we'll add nic_info to inform the user that depth is timmed and restore q_params.

For patch 02, we'll remove const.

For patch 03, we'll change errcode and modify rx_max_coalesced_frames_high  judgement condition.
As tx and rx share interrupt, we only use ETHTOOL_COALESCE_RX_USECS to avoid user misunderstanding.
So we do not add ETHTOOL_COALESCE_TX_USECS.

For patch 04, we overlooked the recovery of rss_type in error handling and we'll fix it.

We will fix them in next version.

Fan gong


Return-Path: <netdev+bounces-288837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CANuHQOCCmqv2AQAu9opvQ
	(envelope-from <netdev+bounces-288837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:05:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 165D856548D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A759300B1DA
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482137CD4F;
	Mon, 18 May 2026 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CjxmO4/x"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EAF366557
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779073460; cv=none; b=Dp3Hq6YppFBQ7Vrw283v2p8Zk7lBRm7g9AOWmwJMP4DokkL/lH+CJe2WmXscoF/46LsqGfYDK2n31He14I6Mqsx2hrzjz6iqMZ6jRPKY3DlJ++8Sbae+6RxAirQMLPgLj0HPu4ylVx1ZDSRc63uo98Uwtq0fBHLaiwFHWBtM3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779073460; c=relaxed/simple;
	bh=ZP70uEwWZB1e00uw4fecKU/PrJuv//1vq3Buxaac2cE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=qiKEOYeHJNWESwOJ4IWkqSvoVjL86oTMSAZiFTo7qocY9mCMBX8YF7OgdnV1Htt9vfChyaYB43H0B1qXWaWkLqRasq9cA8hG++lrGeUh5jPCtMCE+3aqYebfvhNRbNSKX4J5npNym20uZbYIkMvqlnMbYjya7DVlPf7vMrdePlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CjxmO4/x; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779073454; h=Message-ID:Subject:Date:From:To;
	bh=ZP70uEwWZB1e00uw4fecKU/PrJuv//1vq3Buxaac2cE=;
	b=CjxmO4/xYmSERcs3HxnuEhbezefgP/oUTacD6UgCsGyu0UHyTTPAH8+1/N5h18ADNVmn66Nh0Bn46UaepnEQT0qgejLxwCRtN7qxIp4iSr4TJgWcqjWc3jvM4Q/oEECBndxMHOtktV1k09mecsV81AC0axi80nKKqDyg9lDTH7s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X32ye8S_1779073452;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X32ye8S_1779073452 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 11:04:12 +0800
Message-ID: <1779073307.6412275-11-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v43 8/8] eea: introduce callback for ndo_get_stats64 and register netdev
Date: Mon, 18 May 2026 11:01:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
 <20260514095138.80680-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260514095138.80680-9-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 165D856548D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288837-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba-inc.com:url]
X-Rspamd-Action: no action

https://idealab.alibaba-inc.com/ideaTalk#/ideaTALK/chat?sessionId=252ca245-ee4a-45d8-a859-d20100fe3f91

Sashiko comments linear growth in the stats counters.

However, I plan to introduce qstats (queue-specific statistics) in a future
update, which will be a more appropriate place for such tracking. I intend
to defer this feature until that implementation; it will not be included in
the current version.


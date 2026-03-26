Return-Path: <netdev+bounces-272016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iZMQOOgjxWkU7QQAu9opvQ
	(envelope-from <netdev+bounces-272016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:17:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDE9335155
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BFA83030757
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BBF372671;
	Thu, 26 Mar 2026 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QTMay2dz"
X-Original-To: netdev@vger.kernel.org
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B33317173
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527374; cv=none; b=bTMKN0qw/WfNGemMQcQldOaCG1t4EWBlAPcOu+fQ4AWjJRxxBHwgUuB2z2lgw0af2+lS9I9xcvuxF0cqOVp13Xqf5lhAl3J4c20MxoSNuk87G0rJPM6iF3M8U0oC2TP1rvw6wlEwut/NE70UXn6zEA39hFMQzJFnfUR/NNAOLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527374; c=relaxed/simple;
	bh=3UWp1m3bckio7CqG1gPbUNey4urC7CK3nvLizOgBktQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=DEBo2wK1fx+idE9KwdXAqqzi+hXwbuC7QJHlzLL0mAg6kIVZWox9Exk/LONuKxiTbMk2oTn2q0Ye0ZaVacjy4JmY4GJInpS/CeG0fHM4lmw/nvPnBV4ivzt1BxK7UnTEFFN4qQQDin/Gcm2kDWTbH0y5u5xxrQaDskzeIHTwu6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QTMay2dz; arc=none smtp.client-ip=47.90.199.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774527359; h=Message-ID:Subject:Date:From:To;
	bh=Fr8L/qRD9ZecHm7QP/PNsxlVFPYB2g4rIf3tTqcg1fA=;
	b=QTMay2dzuWwEErKr3hWs6tuKgs1HqwnCIrS862ho2um5+5Y/M9t1V4Ey2PS6Ry71WEERFQKqFQeAveCdtAndpbFMgWq1DIPpfxBIdMIsVO/sBewk5di5b2wfu/KK+1jROzy7LpoSj2uEILB01kwiLTI5gFb386ABjl544AJ0GEA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X.lMQ9P_1774527357;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.lMQ9P_1774527357 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Mar 2026 20:15:58 +0800
Message-ID: <1774527071.3010762-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v35 0/8] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Thu, 26 Mar 2026 20:11:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260323074441.91691-1-xuanzhuo@linux.alibaba.com>
 <cb8280ad-fd08-4201-9faa-d8b1bc4f0bd7@redhat.com>
 <1774525085.4029815-1-xuanzhuo@linux.alibaba.com>
 <cddbd5e9-6df0-40df-9ae1-6a6f296b4061@redhat.com>
In-Reply-To: <cddbd5e9-6df0-40df-9ae1-6a6f296b4061@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,gmail.com,iscas.ac.cn,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272016-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 5FDE9335155
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 13:06:14 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> On 3/26/26 12:38 PM, Xuan Zhuo wrote:
> > On Thu, 26 Mar 2026 12:26:33 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> >> On 3/23/26 8:44 AM, Xuan Zhuo wrote:
> >>> Add a driver framework for EEA that will be available in the future.
> >>>
> >>> This driver is currently quite minimal, implementing only fundamental
> >>> core functionalities. Key features include: I/O queue management via
> >>> adminq, basic PCI-layer operations, and essential RX/TX data
> >>> communication capabilities. It also supports the creation,
> >>> initialization, and management of network devices (netdev). Furthermore,
> >>> the ring structures for both I/O queues and adminq have been abstracted
> >>> into a simple, unified, and reusable library implementation,
> >>> facilitating future extension and maintenance.
> >>
> >> Unfortunately sashiko fund more stuff:
> >>
> >> https://sashiko.dev/#/patchset/20260323074441.91691-1-xuanzhuo%40linux.alibaba.com
> >>
> >> AFAIK checks vs malicious values from the H/W are not due, but stats
> >> endianness, 32-bits, truesize related concerns looks real.
> >
> > I've looked at this, and I think most of it is meaningless. For example, since
> > we have the following options,
> >
> > +	depends on 64BIT
> >
> > there's no need to consider some 32-bit related issues. Many other points are
> > also unnecessary.
> >
> > I will go through these comments again. I'll try to fix them.
> > I might introduce some defensive programming. ^_^ Just to make the
> > AI happy. However, I can't make all these comments disappear.
> Please, don't add defensive programming for AI's sake. AI reviews are
> threaded alike other reviews: if there are valid argument to counter
> them, should be ignored. Please instead mention on the ML why specific
> comments are not relevant.
>
> Note that defensive checks vs rouge H/W are AFAIK not needed, no need to
> argument that.

Sashiko doesn't seem to check the discussions on lore, but
https://netdev-ai.bots.linux.dev/ should perform such checks.
So I'm not sure how to make Sashiko aware of the detailed context.

I will try to address the issues it currently reports. For the next version, I
hope to incorporate more manual review of Sashiko's reports.

Thanks.

>
> /P
>


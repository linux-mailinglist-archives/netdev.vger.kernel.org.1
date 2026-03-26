Return-Path: <netdev+bounces-272004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DKDJOIhxWmC7AQAu9opvQ
	(envelope-from <netdev+bounces-272004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:09:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED742334F55
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA563020013
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48539317173;
	Thu, 26 Mar 2026 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rAqps1BT"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE61DE8AF
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526460; cv=none; b=Iux8FerC20WNhBoTTgNi3SiNzgRER+zQLtjXVnstnyWd4KTKL0YyqJgbdWdfklUpeVGYM/7TugnOcv0s9f20SHQidUISb1ZQhVz9G+H+MB7BbT7OfWpTi6IXgEPLBHH7H/VZSt+4vF30sroutl+6WwnGGEaAzTK2XePJKjerSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526460; c=relaxed/simple;
	bh=b9w5x4PR4Au3exK1pTgox5ELUIf4oFeVm8VO5zfgNWg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=d/+zmc1uI06ViutF9S5yVVmbQeOg6vjfkv+wFFFSOYfTpRw7Cjb4wTXQkR55eIBoqjz4NfiFrx5lvM8wKYWrZt1c9Zti+yDAFe/hotZunk2oe4K8L7ddxk+h3gq2EtP6Z8Y6demT9QxJ1Wr1Pyr4nRXftWhTA4fTl1sRoPlB/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rAqps1BT; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774526454; h=Message-ID:Subject:Date:From:To;
	bh=ETdmqNMFWOWHk8c5RCU0dqa9+iYWJARC9GJuc+8aOJA=;
	b=rAqps1BT3DLzR2EElxSRQO2heCgmLfk3IdMRnReKGRrqM5ClGeKUrpeDP2IU3HkIiJJAgyqV9a5PhMaQdTrGlyXqKvOkPpttWlGtquutfLUW4jgTn8N6fX29xkbw1BLf9zMR9TG+2tyYmwGJIk1405qEKSeJIY3LtBAAsFGJDk4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X.lEwhM_1774526133;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.lEwhM_1774526133 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 26 Mar 2026 19:55:34 +0800
Message-ID: <1774525085.4029815-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v35 0/8] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Thu, 26 Mar 2026 19:38:05 +0800
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
In-Reply-To: <cb8280ad-fd08-4201-9faa-d8b1bc4f0bd7@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,gmail.com,iscas.ac.cn,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272004-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: ED742334F55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 12:26:33 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> On 3/23/26 8:44 AM, Xuan Zhuo wrote:
> > Add a driver framework for EEA that will be available in the future.
> >
> > This driver is currently quite minimal, implementing only fundamental
> > core functionalities. Key features include: I/O queue management via
> > adminq, basic PCI-layer operations, and essential RX/TX data
> > communication capabilities. It also supports the creation,
> > initialization, and management of network devices (netdev). Furthermore,
> > the ring structures for both I/O queues and adminq have been abstracted
> > into a simple, unified, and reusable library implementation,
> > facilitating future extension and maintenance.
>
> Unfortunately sashiko fund more stuff:
>
> https://sashiko.dev/#/patchset/20260323074441.91691-1-xuanzhuo%40linux.alibaba.com
>
> AFAIK checks vs malicious values from the H/W are not due, but stats
> endianness, 32-bits, truesize related concerns looks real.

I've looked at this, and I think most of it is meaningless. For example, since
we have the following options,

+	depends on 64BIT

there's no need to consider some 32-bit related issues. Many other points are
also unnecessary.

I will go through these comments again. I'll try to fix them.
I might introduce some defensive programming. ^_^ Just to make the
AI happy. However, I can't make all these comments disappear.

Currently, Opus's comments are OK. I think Opus's suggestions are more
meaningful.

Thanks.



>
> As for the acceptance criteria, we should not merge code with known
> issues. A problem with this driver submission is the size and complexity
> which allow LLMs to dig different things at different moments.
>
> /P
>


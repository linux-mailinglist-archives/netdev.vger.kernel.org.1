Return-Path: <netdev+bounces-268407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKF0B63FuGnTjAEAu9opvQ
	(envelope-from <netdev+bounces-268407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:08:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D42A3076
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87848300D76F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A073257845;
	Tue, 17 Mar 2026 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EH2SRL+R"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F628314E
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716903; cv=none; b=fLEj04bAUnZi0+6atZni1eBerHv3KEpT3Eeq4sVIooyR1SXqGlLkpJ3QVI8IKkdxIlywaLMXzQQzSklVpzSSUxABE1QMCzSdRETBoIe3CmPJhorxKWOfotw+qizXg9rc+AeNY09ShfdOFJyUQrCE1s5hFZwsbXDrGPWGz57WfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716903; c=relaxed/simple;
	bh=6VXcukEtq/Iisyi37qrAU7OE6MMDc4qqZXQM9ieuxCw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=U9C9tIJYAmpShh3aw0wYivawXikZ3xGn2Rufm8VEpTQGO189QleiI2KAURAdGrRwQw+Z7TzPI/4sxMnNO2KkyOaxzhA0/VzEpgPBtGtTm0G6EDlgXhlAS2RV83O5nsrZl1nvl2+gkQLlTc0tJe390dm6iVm6fXUg09E23OznFOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EH2SRL+R; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773716897; h=Message-ID:Subject:Date:From:To;
	bh=6VXcukEtq/Iisyi37qrAU7OE6MMDc4qqZXQM9ieuxCw=;
	b=EH2SRL+RbIAg89kW6leDtIZxMw0TEkgmS63Wn2yS4TTyyIhuydb1M4cU/rjVdljssmTADpXmJW3uT3eMu8ateAcwleDn4/cFjKoK2O/LpnXLjaJ48qehvV6zo4QZsH5dFOsQguFvgsgy2e5LcNv7hyob6cbA6SCbbwgancnFewo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X.9SLQN_1773716896;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.9SLQN_1773716896 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 11:08:17 +0800
Message-ID: <1773716496.6578078-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v33 0/8] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Tue, 17 Mar 2026 11:01:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S.  Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo  Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dust  Li <dust.li@linux.alibaba.com>
References: <20260317015257.79494-1-xuanzhuo@linux.alibaba.com>
 <20260316195252.7fa24729@kernel.org>
In-Reply-To: <20260316195252.7fa24729@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268407-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 156D42A3076
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 19:52:52 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 17 Mar 2026 09:52:49 +0800 Xuan Zhuo wrote:
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
> 4 minutes too early, v32 was 56 past the hour.
>
> Jokes aside, can't you got your own LLM subscription? The mailing list
> is not a public CI. Please do not post this driver more than twice
> a week.

Actually, I've been using LLMs for local review since v27 (or possibly v28).
However, different models tend to produce inconsistent feedback. Since Claude is
not accessible in my region, I'm using Qwen. This results in a clean local check,
but minor issues still arise after submission. Since v28, the issues have
been trivial-for instance, this time it was some incorrect references in
the comments.

I'm not entirely sure what specific criteria need to be met for acceptance, but
we are hoping to finalize this work as soon as possible. We have significant
follow-up work planned, including qstats, RSS, and XDP...

Thanks


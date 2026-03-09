Return-Path: <netdev+bounces-265384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJWbJDNvrmn8EAIAu9opvQ
	(envelope-from <netdev+bounces-265384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 07:56:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F92348B9
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 07:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC2E3302517E
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 06:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA373624AA;
	Mon,  9 Mar 2026 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QQpEFvsf"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7D3624AB;
	Mon,  9 Mar 2026 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773039286; cv=none; b=hsKJaFi5LILL5BxoTfdKQReG/vzykBuvQL01rJa3T1pWlu+wclfezaaU8mpDSUCFbsS8F0/NYZ8Aa28fNmt/swL7w7OnYkG5Yy4UDZjb2vXkxe/vBRPrKKWEaGjZnKMrx+wE4HV09vImz9hzGSmtBPotZdDqKdZYvMj84QGjZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773039286; c=relaxed/simple;
	bh=p8zxAr+FgbUH/MbRYTkpHhFfVFF+0TdTNqkmL1S0cVI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L/rIYNM63KgsSU2Xj/bvy1+zZvFvzLdHrQJ4dXcJ7ui36d/263JT9HLB+iBUnx4Uc/DKd/kSzQFJGT7g3LhbB32Gkkeathf+3JojUqmEcis2+K/mGALf+vsG7SsWm/Qw8kTgO0BJEdgP5fI8B1GiGU+5wRtBStFrNGktXIZuyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QQpEFvsf; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773039276; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=eITBe4d+0D1vSKUbF1Kprrd/8R2b6vC70E/PbgygPZo=;
	b=QQpEFvsfxbxm1scto/soCr2RYoA1q9dopKOOvhSWIxszl1XcHL9lN+jw1AAjUy3TF424AUOi48uMZ13uGYJKeiJhoP0JyYiZkTeamTFF3buiZihWYYxtIhAgjyHxPsmyNpZqPL+oC3NL4P48i24qDMoyN2YFcRcOzUoFfWv4y58=
Received: from 30.221.130.175(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X-VGeMS_1773039273 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Mar 2026 14:54:34 +0800
Message-ID: <c0c9e8a9-1f55-4627-a903-629c9a98cbea@linux.alibaba.com>
Date: Mon, 9 Mar 2026 14:54:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [RFC v2 0/2] ptp: Move non-NIC PHC drivers from netdev to
 clock/timekeeping maintainership
To: tglx@kernel.org, tglx@linutronix.de, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, mani@kernel.org, imran.shaik@oss.qualcomm.com,
 John Stultz <jstultz@google.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, yangbo.lu@nxp.com,
 svens@linux.ibm.com, dwmw2@infradead.org, nick.shi@broadcom.com,
 ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
 imx@lists.linux.dev, linux-s390@vger.kernel.org, dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, taniya.das@oss.qualcomm.com
References: <20260227081934.96865-1-guwen@linux.alibaba.com>
In-Reply-To: <20260227081934.96865-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 561F92348B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265384-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guwen@linux.alibaba.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,linux.dev,linux.ibm.com,infradead.org,broadcom.com,vger.kernel.org,lists.linux.dev,linux.alibaba.com,oss.qualcomm.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Action: no action



On 2026/2/27 16:19, Wen Gu wrote:

To get more clock/timekeeping-side input on this RFC (in particular, the two open
questions below), I’m CC’ing a few additional maintainers from the clock/time area.

> # Request for comments
> 
> 1. Following the clocksource/timekeeping and POSIX timer areas, this RFC routes
> changes for drivers/ptp/emulated/ to linux-kernel@vger.kernel.org (rather than
> netdev). However, the preferred integration path is still unclear (e.g. which
> tree should take such changes, and who should collect/pull them for merging). We
> would really appreciate guidance from the time/clock maintainers, especially any
> input from Thomas Gleixner, on the preferred tree/workflow for these changes.

As a concrete option for (1): would it be acceptable to merge changes for
drivers/ptp/emulated/ via tip.git (timers/core branch)?

> 2. This RFC currently lists us as the maintainers for drivers/ptp/emulated/ as a
> fallback contact point. Ideally, we would prefer this area to be maintained by
> clock/time experts in the long run. Suggestions on more suitable maintainers are
> very welcome.

We’d appreciate guidance from the clock/timekeeping maintainers on the preferred
workflow and long-term maintainership for this class of clock drivers.

Thanks!


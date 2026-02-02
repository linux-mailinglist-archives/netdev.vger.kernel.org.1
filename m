Return-Path: <netdev+bounces-255694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBwUOOkHgGkq1wIAu9opvQ
	(envelope-from <netdev+bounces-255694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 03:11:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88191C7D97
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 03:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F08333000880
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 02:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98371ADC83;
	Mon,  2 Feb 2026 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OV3rHIoe"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954421531C8
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 02:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769998310; cv=none; b=iqSMUtfX40gem8i5NgXNG2rk1yFJJiuIGllbFrUT3g6t6JgPY4cdhwttYj9K5mX4XHJ/nxKeLULNA921NUlpUaBMBUo4uh7/ZQZSEXfut3l+32if3HBmQKMCeHTGsXxY7hr5pnkGIZFs/WraEM9j0Se64eMHSpLByY8th8imJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769998310; c=relaxed/simple;
	bh=YUJDwKGdxTvppASRafZF2OTsXz5pF2johsyqZtYNH+s=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=DzmAe5rOshUJyxMq394DKuil8LmOdGfayDC5l4k3qEWcJUxp7U4zinPHYcHUgTiEtL3c/gMu4VvrnVNOabeQ3cRnJyQ64s2nfu7ew+EUO/e9UxgRCrJ3JNK5ruGPS+bGBYHRNelynNZCfVYKXZLyXkXDRyirgzMDco9dEri3zPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OV3rHIoe; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769998298; h=Message-ID:Subject:Date:From:To;
	bh=YUJDwKGdxTvppASRafZF2OTsXz5pF2johsyqZtYNH+s=;
	b=OV3rHIoegMyZ+hSaCpWXrt1MyE3AZimdqeU1RkIPfrJww4iiDeJ2lvsiZP9oTte33YEVhKDy+gmdk01bd9uCrs8Jy5kbhEV7kfOFWzviiASRcFtI92OvJK4RLCN1tKYiBZ2bwcd6yizqDLMxztdGgwgfgYKGOeBRTh2KjRV8I6k=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WyI0WA8_1769998297 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Feb 2026 10:11:37 +0800
Message-ID: <1769998184.776148-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [net-next,v24,6/6] eea: introduce callback for ndo_get_stats64
Date: Mon, 2 Feb 2026 10:09:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 lorenzo@kernel.org,
 andrew+netdev@lunn.ch,
 hkallweit1@gmail.com,
 dust.li@linux.alibaba.com,
 edumazet@google.com,
 davem@davemloft.net,
 pabeni@redhat.com,
 lulie@linux.alibaba.com,
 andrew@lunn.ch,
 netdev@vger.kernel.org,
 guwen@linux.alibaba.com,
 dong100@mucse.com,
 lukas.bulwahn@redhat.com,
 vadim.fedorenko@linux.dev,
 enelsonmoore@gmail.com
References: <20260130093412.98407-1-xuanzhuo@linux.alibaba.com>
 <20260130093412.98407-7-xuanzhuo@linux.alibaba.com>
 <20260130233245.923444-1-kuba@kernel.org>
In-Reply-To: <20260130233245.923444-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,linux.alibaba.com,google.com,davemloft.net,redhat.com,vger.kernel.org,mucse.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255694-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 88191C7D97
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 15:32:45 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> eea: introduce callback for ndo_get_stats64
>
> This commit adds ndo_get_stats64 support to the Alibaba Elastic Ethernet
> Adapter driver and introduces a spinlock to protect concurrent access to
> rx and tx pointers when gathering statistics.
>
> The commit message says "Add basic driver framework for the Alibaba
> Elastic Ethernet Adapter(EEA)." But shouldn't this say it's adding stats
> support to an existing framework rather than adding the basic framework
> itself? The other commits in the series appear to have already introduced
> the framework.

Will update the commit log.


>
> This commit introduces a spinlock to protect against races between
> eea_stats() and the queue setup/teardown functions. The race being fixed
> was introduced in commit cf49df362e30 ("eea: create/destroy rx,tx queues
> for netdevice open and stop"). Should this commit include a Fixes: tag?

Not fix, before this commit, there is no race problem.
There are protected by rtnl.

Thanks.



>
> Fixes: cf49df362e30 ("eea: create/destroy rx,tx queues for netdevice open and stop")


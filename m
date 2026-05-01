Return-Path: <netdev+bounces-283075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOdRK2oM9Gk6+AEAu9opvQ
	(envelope-from <netdev+bounces-283075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 04:14:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA614A9C4A
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 04:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 474BB300669F
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 02:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA323E330;
	Fri,  1 May 2026 02:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG8MUpON"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58019D065
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 02:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777601638; cv=none; b=kv06rYF035LTDFRAO66qW2htjt3P0blkHTbX7x3EyeSoaPCI9OTlYe8Qf2I4FuEMoWn6Ipgo38k7EF8rBD8rgtfi1FPpjq+kEqC2YCH9kRRxIiaeneziBw0y5/I1IaV7jCFUcMzP3kdWT2TKgwJJeERtD65wRrplvXacp1Q9xhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777601638; c=relaxed/simple;
	bh=sG2z8WPk+ToDxdUaNhVx5kJ7TmxhjOozSAIKckbt03Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEXpBsSgBXEeIQqfHxOgKUL17BpB5J5p7CPftwo7nadF66aGg09NMH5LIjK01wDtkDEmW/uUwM+G5t12fgAqPE1lgIrBm78rxn9HiXGUuVjHni9pX4qFJ7JQomjR26Rx4IoceeINSaDOxpsoQJmbiiqak//s3xpIA3XGEQ+PQXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG8MUpON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3B9C2BCB3;
	Fri,  1 May 2026 02:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777601638;
	bh=sG2z8WPk+ToDxdUaNhVx5kJ7TmxhjOozSAIKckbt03Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DG8MUpONVSuugeSRFLlji84oRjWCTeN6UheCyo7KNuHZc5j2hHKezFGLBv2O/qavQ
	 IfzGeR13Pxz8hQZxrEwpyOFg97Zg86MzGjHVM8XOFrWhvrOD6xXQF1Z0Z525eNK7/I
	 KxKbSawj2wz1+Se68KR/bsv95HSs29yZKOWd0bGL36VMBKAbwt+6A6NCbYPKjDbYFP
	 habQfm0t+y5ih5ZKhn9Eo6AP/SSIfFNmWWFMVuiPMtFlk8fAt2IfaTf0+IHsMk9tu+
	 vWMAIwVKCPlP375Ef6Uzq09OoI4SLeXG3ygVj6UKjWRlXJpcXukqFTUTUOCtMJgDHp
	 u/gNGGWrPSYeA==
Date: Thu, 30 Apr 2026 19:13:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>, Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Heiner Kallweit <hkallweit1@gmail.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v41 0/7] eea: Add basic driver framework for
 Alibaba Elastic Ethernet Adaptor
Message-ID: <20260430191356.7a7183ac@kernel.org>
In-Reply-To: <20260429023726.100908-1-xuanzhuo@linux.alibaba.com>
References: <20260429023726.100908-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4BA614A9C4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283075-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url,sashiko.dev:url]

On Wed, 29 Apr 2026 10:37:19 +0800 Xuan Zhuo wrote:
> Add a driver framework for EEA that will be available in the future.
> 
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.
> 
> v41:
>     1. make https://sashiko.dev/ happy

Does not look happy, some of the reports / asks look valid. 
FWIW we have another sashiko instance now:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260429023726.100908-5-xuanzhuo@linux.alibaba.com
You should definitely follow the advice to rename the config,
and also failing probe because the FW doesn't like the kernel
version is not acceptable upstream. You can print a warning
but failure is not acceptable.
-- 
pw-bot: cr


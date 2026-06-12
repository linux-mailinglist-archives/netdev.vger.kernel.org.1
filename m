Return-Path: <netdev+bounces-298719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k9yIOO8yLGoYNgQAu9opvQ
	(envelope-from <netdev+bounces-298719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:25:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A8067AE35
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:25:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JXrPxjpi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298719-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298719-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A6D03035798
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B596F33CE9A;
	Fri, 12 Jun 2026 16:24:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A249A2FDC27;
	Fri, 12 Jun 2026 16:24:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281445; cv=none; b=bspOq88zmfk7BnNursTYrpCf/yV4/8/9cFBGTwPwRWJZrwXgAXdaJpavicf99alPnesmhOLoD5pu0wRzW47YKCmr0ry9P5JBqmnAw6k/qZbJ2xs7Ig4SBb4RTUZpgH7zDX9Oy8Vt2zLA6x0UkLxTjl1KB+iqmShXp094QT1WKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281445; c=relaxed/simple;
	bh=NH2gOuXKzK0UutsVWQ9s1cJTd+k1tq/lHNk2Kk5BaJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBCy6jc1RMFcMiUK4MP+SR2uwjxZB28N244gq2Alndt7RZ8yxaD71VZkclrF7jnegcHi6R1EuI7gdbcaprsDQxPRdRUi5iy4RQ3EDGHxLLF3X4NU4nAWMh+JIt6LR231s7h9H2oVEVioq/RDfUdTRjfQT8lR85fO7CPkzDnAbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXrPxjpi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A761F000E9;
	Fri, 12 Jun 2026 16:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781281444;
	bh=nHGikU6wcxSd2ae1bf/X0PRO1DJHTOD6l6hkx+0rWwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JXrPxjpiWFYNR1Ceqx02yDoFCtfdHzRGp1GuxlDvRgvxFLYKVg3aVFrnnotmqU72h
	 dD3kqHHWLdEJBS4kPaDNnHc/2e8D6/yswtwnSvHpj9t21BuiTOszEuHN/kQoz0cSMA
	 SHALt3IA5i6stbRutbXy4deffTl1Vy9SROuKKoccLQnqMxO4A4v7fM1Wl4F7/SJUas
	 DFljNkik0SYifOoGc1+UKI5Bnk/axf0/YvLDnQSLInlyAtKQ7vLf9Ufri7Nz8h0oZv
	 Q4IKyHaBNnuXfvreykDNVN0NjGqC2llGwlP1alrxdW++BfQbxv+K6bqJ2faiGh3AF6
	 xfs7ElKRnUEuw==
Date: Fri, 12 Jun 2026 17:23:59 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 net-next 0/6] net: hns3: enhance tc flow offload
 support
Message-ID: <20260612162359.GE671640@horms.kernel.org>
References: <20260610060618.834987-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610060618.834987-1-shaojijie@huawei.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-298719-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:shaojijie@huawei.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75A8067AE35

On Wed, Jun 10, 2026 at 02:06:12PM +0800, Jijie Shao wrote:
> This patchset enhances the tc flow offload support for hns3 driver:
> 
> - Patch 1: Refactor hclge_add_cls_flower() to support more actions
> - Patch 2: Improve unused_tuple parameter setting for separate src/dst configuration
> - Patch 3: Add support for HCLGE_FD_ACTION_SELECT_QUEUE and HCLGE_FD_ACTION_DROP_PACKET actions
> - Patch 4: Add support for FLOW_DISSECTOR_KEY_IP and FLOW_DISSECTOR_KEY_ENC_KEYID dissectors
> - Patch 5: Add debugfs support for dumping FD rules
> - Patch 6: Move FD code to a separate file (hclge_fd.c) for better code organization

Hi Jijie,

There is AI-generated review of this patch-set available on both
https://sashiko.dev and https://netdev-ai.bots.linux.dev/sashiko/
I would appreciate it if you could look over that with a view
to addressing any issues that directly affect this patch.

...


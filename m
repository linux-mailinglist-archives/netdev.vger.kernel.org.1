Return-Path: <netdev+bounces-298261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GOHDGVT0Kmr3zwMAu9opvQ
	(envelope-from <netdev+bounces-298261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:45:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78A67420A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:45:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LAJLjmsX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298261-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298261-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B8283007292
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25B6314B73;
	Thu, 11 Jun 2026 17:45:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7B2773F9;
	Thu, 11 Jun 2026 17:45:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199949; cv=none; b=GjaeADPhhoR8e4ZPismzXpiKfYWUpS7CBytsQLUjHBKSNx5Fr8PWvL6L1IgZExqMSpubaG38ZCDG7LCZ9BYk9Iuieyg3kOC815ivYlmJQX3b2g7XTByYXMWJTqWtDQkfuEmCPUFwG0mhWblXX4wu1OpXRdszJ6dQ1Z0svc0eWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199949; c=relaxed/simple;
	bh=GWRZV8FiHN1FyintRLe/c7RT0Sfdiq5xKR8iBOYTjzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwIi8e9LfES+AfpBUsWEIidObIfm28YPVZ83ysbvJYH156uKxBs5yUhLSDBgiJAKLPzE9r+6pzbrtLmv6y2XDufbahq6xG3WH91VovKa+GDz3VHkcxh9gp8aGr2lNJyJId+oIAVzJxxg82iWAbtoZCES5CTpvj5coJ131wvbIXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAJLjmsX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD431F00893;
	Thu, 11 Jun 2026 17:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199948;
	bh=vmoCLnFZIAzFjzCXsGaDa6Mke9+5NJMIv4PcHKUZGDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LAJLjmsXUkJpsCddUncIheRsZ4FZ5wWI3UBXsCZ+ttRcKolIMhXVfVJGoL+GCOaTW
	 NFv4fJualfIwS5SkAvC05+yg7IrBeYXlnQPWv/tivLjAMFCjhASrG/IxhoFaQ7M3zC
	 yDeQX78br69Oz85Drwylr2qF8aCsBSAwLh8468clxkWTlu1s+I/9HBy2iSz2PdsC3M
	 B4WN2c7JUz6ciaNccujAldt5AaeZJDjuvTZC1O8w5OSIr4fEUdaEpYKVsy0mWkLcLR
	 3TpGjzEW4U5jAduPu6AEmvWwvVLLz27fM6RA/heoDFmxXYiHMhnvI4WmTBMqdPiy3q
	 RHZo9qSrR8awg==
Date: Thu, 11 Jun 2026 10:45:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Yuho Choi <dbgh9129@gmail.com>, Sunil Goutham <sgoutham@marvell.com>,
 "Linu Cherian" <lcherian@marvell.com>, Geetha sowjanya
 <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nshettyj@marvell.com>
Subject: Re: [PATCH net-next v2] octeontx2-af: Fix PCI device reference
 leaks in debugfs
Message-ID: <20260611104547.22cedb69@kernel.org>
In-Reply-To: <aioblJqQctA_9U8y@rkannoth-OptiPlex-7090>
References: <20260608165546.61347-1-dbgh9129@gmail.com>
	<20260610083544.0da95356@kernel.org>
	<aioblJqQctA_9U8y@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298261-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:dbgh9129@gmail.com,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,marvell.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E78A67420A

On Thu, 11 Jun 2026 07:51:08 +0530 Ratheesh Kannoth wrote:
> > Review question sort of based on a Sashiko comment - this is part of
> > the rvu device driver, AFAIU, does anything prevent the AF from getting
> > removed (via sysfs for instance) while this code is using its priv?  
> 
> RVU AF driver's teardown sequence prevents the race here. In
> rvu_remove(), the very first call is rvu_dbg_exit(rvu),
> which calls debugfs_remove_recursive() on the debugfs root.
> ASFAIK, debugfs_remove_recursive() will block until all active
> readers (i.e., any in-progress seq_file read callbacks like
> cgx_print_stats(), cgx_print_dmac_flt(), and
> cgx_print_fwdata()) have completed before the removal
> proceeds. Only after rvu_dbg_exit() returns does
> rvu_remove() proceed to free the rvu structure.
> 
> A better approach would be to pass the rvu object(rvu structure has pdev field) while
> creating the debugfs file itself, e.g.:
> 
>   RVU_DEBUG_SEQ_FOPS(cgx_dmac_flt, cgx_dmac_flt_display, s/NULL/rvu);
> 
> This would eliminate the pci_get_device() lookup entirely. We
> will post this as a code clean-up patch to net-next.

Oh, that's much better, somehow I assumed that this dance is necessary
because we are accessing a different PCI device. 

Also, since you're actively working upstream and nobody else on the CC
list responded - should you perhaps be added to maintainers for this
driver so that you're CCed on patches?  (instead of one of the useless
ones)


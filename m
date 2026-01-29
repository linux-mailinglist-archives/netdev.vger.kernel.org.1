Return-Path: <netdev+bounces-254517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePPXAtDBemk3+QEAu9opvQ
	(envelope-from <netdev+bounces-254517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:11:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B5CAB0BA
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60143300599B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321183502B3;
	Thu, 29 Jan 2026 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEp3HoiY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060E2EBBB8;
	Thu, 29 Jan 2026 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652685; cv=none; b=k/RBfeLUmuq2UkZjqoXmrLOxp+zaEmNbQURKJiFxXIYznEQpastJ0JmkOfPEGmCa6hWdnAypTTgujFKYFN2oYCQH5IgCFjAS5vgPB788eRcuoHUiSzO5bz4hDvlBgZthJJcm3DlHuvYCeTLWfZZux3VCFJKXr8JLRI0rJyHD2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652685; c=relaxed/simple;
	bh=LBb9/yTDweuTXribS/IeboPTSPQ5/aexXUBFajT8K7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwEJqN7/xUzBDUChk3gr3XP4vnDahVCRa1FPiTQdwEsW4yQ7ioJ83aqDY9VkV8hqTP2drPoAXpvff0UopNxuctWMTw6UXL9O/TW9bTC4n7zcHnQT4PD9mtrFz2u5ljSFAcYH0Pw9z3EmX/vfVnSaeH5OIo5r16Hzq2xjtiftwiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEp3HoiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCB4C4CEF1;
	Thu, 29 Jan 2026 02:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769652684;
	bh=LBb9/yTDweuTXribS/IeboPTSPQ5/aexXUBFajT8K7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qEp3HoiYBJBIjFiNe/Q39dcb2I/kskBK8dWAg14inIHapGkHwIb/hPOPDs0cgcjIG
	 kJXy+AbJ+YTmV95U5fVlcX20NWS9et1Tyuw5H02QqMrW4LsoDSpAXk7Bf1AM2uEhVM
	 D1SMgfWAiN1SXyP8at4pFCopMhMei1nxoNZwdl8vrAY9IEPgG2atGaRzvu4WTjTHBR
	 OtTs2X4e3LTN0XbnjcwPUUj2Pn5yiJazhZb3XYwMPY50SZ8O9kgZ3YwBy8k/uWwCtP
	 dvRkdRWE105rUJfUkbZkWW+l3lptir1TV8PBhbNK4ACUaMZU2yMRdS39UxWpqfD8Rg
	 dAny3v1tydDHw==
Date: Wed, 28 Jan 2026 18:11:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <sbhatta@marvell.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
 <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <sumang@marvell.com>,
 <pabeni@redhat.com>, <davem@davemloft.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v5,05/13] octeontx2-af: npc: cn20k: Allocate default
 MCAM indexes
Message-ID: <20260128181122.0baf8ca9@kernel.org>
In-Reply-To: <aXmCpZWl9JHk2bpC@rkannoth-OptiPlex-7090>
References: <20260126123254.1000480-6-rkannoth@marvell.com>
	<20260128022921.4152787-1-kuba@kernel.org>
	<aXmCpZWl9JHk2bpC@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-254517-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5B5CAB0BA
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 08:59:41 +0530 Ratheesh Kannoth wrote:
> On 2026-01-28 at 07:59:21, Jakub Kicinski (kuba@kernel.org) wrote:
> > > +chk_sanity:
> > > +	dev_dbg(rvu->dev,
> > > +		"%s: Default index for pcifunc=%#x, bcast=%u mcast=%u promise=%u ucast=%u cnt=%u\n",  
> >                                                                        ^^^^^^^
> >
> > Should "promise" be "promisc" here? This appears to be a typo in the debug
> > message.  
> ACK.

Hi! FWIW no need to ack all comments per kernel process. Well, at least
on netdev it's not needed. We assume that all review comments will be
addressed by default. Only reply if you have context to add or to argue:)


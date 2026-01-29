Return-Path: <netdev+bounces-254834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Bv0Kl59e2kQFAIAu9opvQ
	(envelope-from <netdev+bounces-254834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:31:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2552AB1796
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5632300C021
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6A132ED24;
	Thu, 29 Jan 2026 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tuEDeIQr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHNAYGdA"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339032ED43
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700566; cv=none; b=CxMcJEBvkDteMamMCGYmBUknGCCHioOp5FVFV4KQvw8FtL9M7R5P9F9N2EP6PPzu+45ji/ZvJX1ja6ivvVApgujziwB/XGQtA1VCcDOF+9ZLqDPskouJgpd42Pes9MEpb2SUNIuDiDNNmbOq8ko9uOTGClpwPG3O/jAfJbMNvVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700566; c=relaxed/simple;
	bh=1xbevfEFLMw6cxLSTvnpNWu1vvnf1bRZMX1cid9N778=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXMTIPufN2GI5XioVPcz7HUYjVyAeeMhJPfXRm3u1M3cJx9nAkQoPNFoWuH3Z5GtbmljYLvfTAyW1Ep5PzEMLRUgHyFjNppewsSJ4ap1nh2ZNpE0Fi7EDF097nV2PT1EyhVBhA+ePR9XhFtLASH60vm+9ux0vYOAnh64MaRa9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tuEDeIQr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHNAYGdA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 16:29:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769700563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dHdep/or8hrGdYdzJ64DA7zDDlSnl955IPWsfg+rGAM=;
	b=tuEDeIQrrvqVjhN6qMt7aGkFn6LuJSBrq17HUdalxvXOvPPpv8enzwTGzKnrTQR/Oc9ZP3
	bKJB8vT2/S7x3KiJpnL7gyCWJ61fMvZsPICevtLu6jfZRCkGEcap+OqbFlqhfdYMww5q+e
	HjE8ysZpy8UPr0U/frkIxt0Yu+9TJB1tn+Z6G+JSagH5dla5nDxJrV0sV2Xckze9MTZQP9
	TkV79IK08z/lF+IVXVDvkKu7B/bWnqQgcbEC6Q3Fse3SJRAnyrFIPmi63MWmtlElPqK1Ac
	kcSs0MlzbXjHChvngr+aAP7aH3DiBkAOt66C/681F8sTS9UAGdPqBjtGA8zToA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769700563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dHdep/or8hrGdYdzJ64DA7zDDlSnl955IPWsfg+rGAM=;
	b=GHNAYGdAZGwaxnbSkXWLisj4o9fmTx+j1h1zKL6S5014t0LlaOs7/Ok4/mHskzdvqYDFSV
	pRxXo+wW6hEY+3AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, jkarrenpalo@gmail.com, tglx@linutronix.de,
	mingo@kernel.org, allison.henderson@oracle.com, petrm@nvidia.com,
	antonio@openvpn.net
Subject: Re: [PATCH net-next v2 0/9] hsr: Implement more robust duplicate
 discard algorithm
Message-ID: <20260129152922.P0efzzu6@linutronix.de>
References: <20260122173556.44d8b77f@kernel.org>
 <aXczshu7nvWWFMy4@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXczshu7nvWWFMy4@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254834-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2552AB1796
X-Rspamd-Action: no action

On 2026-01-26 10:28:18 [+0100], Felix Maurer wrote:
> 
> I'll wait for feedback from Sebastian, but I'm also fine with merging
> the fixes for the KUnit test into the other patches and reposting.

Overall the new algorithm is very nice. Feel free to add
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I made a few comments where I think it should be possible to avoid
tracking the sequence number for interface A and B but since you
preserve what is done now, I don't mind to keep it as-it and try to
remove it later on (unless I'm wrong and it is not doable).

> Thanks,
>    Felix

Sebastian


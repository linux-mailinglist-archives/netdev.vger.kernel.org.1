Return-Path: <netdev+bounces-269213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PK+NIMzu2kVgwIAu9opvQ
	(envelope-from <netdev+bounces-269213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:21:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FDC2C3CB2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD91A3028E92
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1242DB7BB;
	Wed, 18 Mar 2026 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMnT1082"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0921018A;
	Wed, 18 Mar 2026 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876096; cv=none; b=SK620VBkGrO2AHZcKfnjN2ZWEAgNUIwnVgSTU8WUHfdIo3Z3vSfOy3Xwrgbre8PitlUGIeKNlG1HsTYfSfx9QcNfwmAHPsw45ypkZYeg/5uFiWws5JNt5/2ETcRkyYQg1kdGP87M+LUIwywUBjBEUFxBwEoMXJ8aZq+ezWLY5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876096; c=relaxed/simple;
	bh=uVBO9VhaLn9ofBvayUz+cvz6W0q4UhHRkPwarjKskrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BtOlEtFEVzlnWhOh0yFjqKMrpKvHEUuH2qrONpKkH/vuH5XR/lvDzZ+kxZNAB00sj0ZvUcjpJS6Ej8ooqEH3K60OzUAuIsLbfpRwGzyJQm2P/eRf/AFAmIrnntR1JWG6uRBXtm/sDNqjGr5eF1bPLLe+Yc1jjIAGjK8m3I+Cf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMnT1082; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC000C19424;
	Wed, 18 Mar 2026 23:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773876096;
	bh=uVBO9VhaLn9ofBvayUz+cvz6W0q4UhHRkPwarjKskrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eMnT1082vEwFnlN/XZf7DZL/jHxhrPN3BmrBxiAtjWwcCQHqoKqGyOWTYbsrCuFlW
	 /0ce+Ipbn2a3jJnlY8IHNGC/UnV8HBjuNOijAE/E6LuuVZfIzD9eNexEMVZaa7HbOU
	 qoCCV5pfJeEScuZuGL9MT4o1cmRWVbMspIsLWX3B1oz5r/f9RhQkI2vpiwor9LfSgP
	 4R3wtYRnT2oNhWCZGDz3GUzzSZrQHxf1jAKMJd25OIMRK2NW3p8srHeo4cJfHhzrVF
	 6omLvqeYZ0TtU/umNMNy2CKgmA+hLWWdBTxcABbsgS4PA/aWRXiG1w1Upt3ulldFlN
	 EyCd9dnSb+sYQ==
Date: Wed, 18 Mar 2026 16:21:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org, rbm@suse.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10 net-next v3] Convert CONFIG_IPV6 to built-in and
 remove stubs
Message-ID: <20260318162134.5906d048@kernel.org>
In-Reply-To: <ea482a29-b9bd-4365-b771-2bc03bebad3c@suse.de>
References: <20260317140141.5723-1-fmancera@suse.de>
	<20260317124904.552d57e4@kernel.org>
	<ea482a29-b9bd-4365-b771-2bc03bebad3c@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-269213-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46FDC2C3CB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 11:19:06 +0100 Fernando Fernandez Mancera wrote:
> > NIPA flags a few failures, still:
> > 
> > https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-03-17--18-00&pw-n=0&pass=0
> >   
> 
> Hi Jakub,
> 
> This is test is applying the series in top of bpf tree which has this 
> commit 
> https://github.com/kernel-patches/bpf/commit/972787479ee73006fddb5e59ab5c8e733810ff42
> 
> AFAICS, net-next tree do not have it yet. I do not think I can do much 
> about it for now. Will wait until they are merged and rebase in top of it.

I see, hopefully trees converge tomorrow, else we can fix it when
merging. But the RCU warnings in forwarding can't be a BPF problem,
right?


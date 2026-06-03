Return-Path: <netdev+bounces-294881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EodBAGFzIGqT3gAAu9opvQ
	(envelope-from <netdev+bounces-294881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:33:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AA163A959
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:33:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A1vuDAVN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294881-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294881-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B27630345F5
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7D837F8DD;
	Wed,  3 Jun 2026 18:32:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844A937646E;
	Wed,  3 Jun 2026 18:32:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511575; cv=none; b=nvzmgETMA45275FrvBOKQDc2BuZJHdo79PYvRuLtoxlIeQru9EHUArE04YVaTP7RIPTKOiZpIpbcjve5YrGVAMAAAjmJprHu5IcHG7WWupuJ8SLU51EZmZBx+eOBcVCzmb+yu123JQXkI5/f+Mey/rebg3aDzd2nhioK/xg/hU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511575; c=relaxed/simple;
	bh=Or+hvxce+sEPgFelumGFymCFHJBZcWUny5H9fKrKFhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcMesVJnTUTrnIPZ8Bti2j3Q4E7sjDKyEWjVwhaazVdey8OfxWjg/8EbxhTnwLz2wxQG1Np5DoE7+fxXr3JCiqhB4Cw28+o+V22w9uViCcC/pxIccoeEahpQaS4I2gpO5i96mb/tKeSFmfzrSkGI9B6b4HgTkYS5rWpdiSqXLh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1vuDAVN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FAF1F00893;
	Wed,  3 Jun 2026 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780511574;
	bh=gPY2pu+kFmzQjUUfL3ysiLAzza3ggJnJ0ow22y5D58c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A1vuDAVN62beynYQhRY3qVxNV5+2urPD8D2cnKuAeB9QBauidlI69hn3sX/oipe1P
	 cTCtwYny9u64a7X3cB4Xzvcucl8LmreMHe9LfCcibJdOzjgd0D8Yp0x+1NPgWxyIJd
	 NoScEILhh7q3H4KLpDyc2ReU8IPHh8pEqe6e/07X0bGqmvXERIthHn5F2BhJDrnKd4
	 dYSrnipck9wdQ+c/mY5EWwd8wkUD8b8jUHRlkmkDzbo/JlLGSXGXM88A3nOtpgQNHi
	 2Kqfe8KgnKkk63ehdLF9e/J4RhSKiSxz6RCQu0sJeIukcD7zruKkR6ed779HdQGEB8
	 EzQ8+JxkptMrA==
Date: Wed, 3 Jun 2026 19:32:49 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, bbhushan2@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Suman Ghosh <sumang@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: Fix initialization of mcam's
 entry2target_pffunc field
Message-ID: <20260603183249.GH3766816@horms.kernel.org>
References: <1780054625-17090-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1780054625-17090-1-git-send-email-sbhatta@marvell.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294881-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sumang@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,horms.kernel.org:mid,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83AA163A959

On Fri, May 29, 2026 at 05:07:05PM +0530, Subbaraya Sundeep wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> NPC mcam entry stores a mapping between mcam entry and target pcifunc.
> During initialization of this field, API kmalloc_array has been used which
> caused some junk values to array. Whereas, the array is expected to be
> initialized by 0. This patch fixes the same by using kcalloc instead of
> kmalloc_array.
> 
> Fixes: 55307fcb9258 ("octeontx2-af: Add mbox messages to install and delete MCAM rules")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is an AI-generated review of this patch available on sashiko.dev.
However, I believe that the issue raised there can be treated in the
context of possible follow-up and should not delay the progress of this
patch.



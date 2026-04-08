Return-Path: <netdev+bounces-276658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD9sEhWN1mnzGAgAu9opvQ
	(envelope-from <netdev+bounces-276658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:15:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C255C3BF5D3
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D803041A50
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919F6346795;
	Wed,  8 Apr 2026 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfGZEPeR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED532C15B5
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668245; cv=none; b=MTJ9I4MqoJfBnjd68t3ygUQTQbOmPINlZd9sMjo11hZNpiflQ7iiNAtA2jUJMJEKus2YKdFhK6nIrSm4VUcP98W7P+XWdSp+gnq1ZWd9LTOwGGbTLCA3JZnP0OxiTz781uuZxfmD0fa50iFb2H8decYDMNqng+y/xjN5LhMlohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668245; c=relaxed/simple;
	bh=5PQPG+eDh+vV9LM79JGYoEkT5h6DO9tWzKNLppGBhL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2L03YeSZK7VejWloJakDId3ZxCOZFXatAlkFT1mhr5XH/OemZ2FMYQp2wWBckBkMwqLi0IGSuCGnK2IcN3sv4M4v0P+RNgH/fm7fcB3GvZFkO+VsIBTpiQH8QWbSrIGJe1igB/ZAklwt8f7KOWTGKgrJdFX0L55wcX9+Gm4YgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfGZEPeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798D2C19421;
	Wed,  8 Apr 2026 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775668245;
	bh=5PQPG+eDh+vV9LM79JGYoEkT5h6DO9tWzKNLppGBhL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfGZEPeR2vM7bun/2EH5Az+YXOUa3gJkfKYLTisapvXKleGW+5dh10+FVcRm9Tz5A
	 N24heCtDlpGY4crA9gleTFgQfX1ixBKTXBQGFgYKWO2POnn+qNj4tGTHkEjFw6MikF
	 PBY2zCYOS05QzbWWUkvTQyu50qRfPSxlmQ7LW404D28NC3f4nOg8nRQ93bOaMwilt8
	 r51UETHm03b0/h6V2kq9+8cqUfUepQIiBulknq1wiT3Uapr0/RT9VWwbjaiS9v/fTi
	 m1+nU9wccHhX7wj4cTN68TLwruoHuo0i+OaiHzGHi0RjddFS/ff4ZcxwCERRUAknvx
	 hqzHVytkvFijQ==
Date: Wed, 8 Apr 2026 18:10:42 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] net/sched: netem: cleanups and improvements
Message-ID: <20260408171042.GJ469338@kernel.org>
References: <20260403225324.476787-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403225324.476787-1-stephen@networkplumber.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276658-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C255C3BF5D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:52:05PM -0700, Stephen Hemminger wrote:
> This series modernizes the netem qdisc with several cleanups and
> two functional improvements. It is independent of the bug fixes
> that are in process on the net branch.
> 
> The first three patches are housekeeping: replacing pr_info() calls
> with proper netlink extack error reporting, removing unused struct
> members that only existed to declare enum constants, and dropping
> a version string that was never updated.
> 
> The fourth patch adds per-impairment extended statistics
> (delayed, dropped, corrupted, duplicated, reordered, ecn_marked)
> reported via TCA_STATS_APP, following the pattern established by
> RED and FQ_CODEL. A companion iproute2 patch for display will
> follow separately.
> 
> The fifth patch improves the corruption path to handle
> multi-segment skbs using skb_header_pointer()/skb_store_bits(),
> replacing the previous code that only flipped bits in the linear
> header region.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>



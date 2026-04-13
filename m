Return-Path: <netdev+bounces-277937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOhuOjgz3GlMOAkAu9opvQ
	(envelope-from <netdev+bounces-277937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 02:05:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 851483E6723
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 02:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98D843003353
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10002CA6F;
	Mon, 13 Apr 2026 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irn0UrM4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0679125D0;
	Mon, 13 Apr 2026 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776038710; cv=none; b=pNqHnEY+et2oYOslbW3jAKgg6pNIYyGcl6DzSGTMPQEX2jT09VKzTvzy9/HavIDH39/Rg6KQQPS4b556iupxg1qnEyCV9X4oYlUICyyZhwrRIxOFlLxglvlin+ICtxjbrWPb9pcHqQ3y6j2MKFU7+y0JYYZa1WoxEG8Qj/6GNYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776038710; c=relaxed/simple;
	bh=PftszzCsXv8DghYZfeatKx0V/bcSr8+BGM5mGPNx++Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgQLi7MI+mT6FMcs3vbLMWrk+T0PEdvWadC98RdQIfTxes4U84xkHEjKIkhYFG/pvJbLhZ7EPzNu0C2oozNize0r8H8gPT4+PnlZV9Nj1UD2pI0mNsgIBf4WoPyWRgDBCljEL1xXzgWXnlUmCEGl+ed/U0bnOfajkIEkyn/C5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irn0UrM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BC2C19424;
	Mon, 13 Apr 2026 00:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776038709;
	bh=PftszzCsXv8DghYZfeatKx0V/bcSr8+BGM5mGPNx++Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=irn0UrM4WMGu0Kj6v2QeZkS5kBYwP/4eb6PUhv6c67If4QY8yeGfZvwad9TUIa/xc
	 ybEPjmYqX936pQFu2WsYawZICUgC5J4sQd2Dd0PDtCFt/iap0bcuEQ2zhCMkv8Q7Os
	 rpWIrCtr5jD93NYseISt0cq7IWZS9+NaQWGJGqmn4QyCPxsL6nmoPd49CTk0QUcNJa
	 pKTiupdygcVEnXLtW6Zi/VwnZsn7oej4Gyg3CiUvlT7jf/1of1NRGtErPoeVFjqnHC
	 suJNC4qs3kAWo34nIaPWyvIaLgLhWHt6aKwAh6s9bEBB9xZ0c6ZUvJiZO3aXV7jd/D
	 KV91jscEpvyuQ==
Date: Sun, 12 Apr 2026 17:05:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Tim Bird <tim.bird@sony.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] keys, dns: drop unused upayload->data
 NUL terminator
Message-ID: <20260412170508.1f33a371@kernel.org>
In-Reply-To: <adwlFgKPdW4zDVb_@linux.dev>
References: <20260409225703.158552-4-thorsten.blum@linux.dev>
	<20260412141004.22c6686c@kernel.org>
	<adwlFgKPdW4zDVb_@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-277937-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 851483E6723
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 01:04:54 +0200 Thorsten Blum wrote:
> On Sun, Apr 12, 2026 at 02:10:04PM -0700, Jakub Kicinski wrote:
> > On Fri, 10 Apr 2026 00:57:02 +0200 Thorsten Blum wrote:  
> > > In dns_resolver_preparse(), do not NUL-terminate ->data and allocate one
> > > byte less. The NUL terminator is never used and only ->datalen bytes are
> > > accessed.  
> > 
> > I can't see where this is used at all.
> > Please write better commit messages, there's no way this 1 byte
> > is worth the amount of time I wasted trying to review this :/  
> 
> The point of patch 1/2 is not the removed NUL terminator itself, but to
> prepare for patch 2/2, which adds __counted_by() and requires ->datalen
> to match the number of elements in ->data.
> 
> Currently, that is not the case because ->data includes an extra NUL
> despite never being used as a C string. Removing the unused terminator
> makes the length match the allocation size and allows adding the
> __counted_by() annotation.
> 
> I can fold this into the __counted_by() patch if you prefer.

I understand that part, but I don't get where the data from which 
the terminating character is removed, is used. Only other access
I saw was freeing it, the rest of the callback seem to looking
at the error, not the data..


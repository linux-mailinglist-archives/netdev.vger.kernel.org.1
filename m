Return-Path: <netdev+bounces-252242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E/wEvHdcWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:21:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBA62F6A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59FD1506D99
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889E447DFB4;
	Thu, 22 Jan 2026 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/vnElbE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347AD407590;
	Thu, 22 Jan 2026 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069675; cv=none; b=uPyVCzURRL1bkdgz7WEWvC/BuAowoFF1+S7cArGc3oAJMf7Na3LBK3BBUeJuFtTCeL9veRqzE1LQIhTU/h9gq4PNI9rV8LFpSwwnSNVG1RHsch6XFCf0vqa/A1wxInY56Ko43PDd8xfMxtzQIdGLCggz/LCxkNDNkowfNi9PdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069675; c=relaxed/simple;
	bh=+5qCEXADRX+3Rn7uzuXBcjl85v9QdvSiUb4V5YDgzjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZRKMkSUq2cSKRXKfis0rf4GHRGlf78tFhIIxrHo0P3YOfkWPeyPi2GV4xzbCtUer4GUiIil9So+eKx80xIpbi5rh1kLPVN2SXNurk/WihDElgPTk5NV/ExhSOBV+IsuIKAx4gY0PeHBrXWfvqo1DEGdsnDPZcBKH7t9/kuhQOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/vnElbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1399BC116C6;
	Thu, 22 Jan 2026 08:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769069674;
	bh=+5qCEXADRX+3Rn7uzuXBcjl85v9QdvSiUb4V5YDgzjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/vnElbEX7MM6IS2jPrcOMtvZrWZkYldPYc6X8wBQRkJmAkkRbXnxgCcKQU0C+L3u
	 qbeYyRDIxM05D2RUSFGVF50vTnZK8TFn4r7CwvBSQwSFX5R4bBvVYMo8UNrv2iEsPi
	 8p3zCzKxDXtDyK1OBbDWbQMZ3/51Bd2h67a0H2U31tkrBU/RuVPfEYzGkZ4jFzqWZv
	 TeFwh6z+F4fNqVzhkLeWDi4LQZH/hSDmvbVehaxil7WDCtkPooTIjfVX3ud2DUjc1d
	 RELqtjeNEiarMv0Gq+GLW2hK/+oJTj39FBcgWNX2yNU3Ub2wff/Yqn4Mfii9VrToD0
	 LkdHNwL70Q7gA==
Date: Thu, 22 Jan 2026 08:14:30 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/tcp_sigpool: Enable compile-testing
Message-ID: <aXHcZu0EK4THCix-@horms.kernel.org>
References: <e4822cf4aa03fed067f5df7cd4f3496828abc638.1768487199.git.geert+renesas@glider.be>
 <20260117163304.20caae7c@kernel.org>
 <CAMuHMdX9J9QPp16aDD-_2Q-chWANWeTyS6Dw=xJdkm8r-sPyFw@mail.gmail.com>
 <aXEvOqjkMPXk28x2@horms.kernel.org>
 <20260121172828.7207108c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121172828.7207108c@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252242-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: C7EBA62F6A
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 05:28:28PM -0800, Jakub Kicinski wrote:
> On Wed, 21 Jan 2026 19:55:38 +0000 Simon Horman wrote:
> > On Mon, Jan 19, 2026 at 05:26:37PM +0100, Geert Uytterhoeven wrote:
> > > > this code cannot be used today. If this code regresses and someone
> > > > wants to start using it on 32b they'll have to fix it.
> > > >
> > > > Please LMK if I'm misunderstanding or there's another argument (not
> > > > mentioned in the commit message).  
> > > 
> > > In general, we want to be able to test-compile as much code as possible
> > > on all platforms, but not bother everyone who configures and builds a
> > > kernel for his system.  Until commit 37a183d3b7cdb873, that included
> > > the tcp_sigpool code, and any build regressions would be caught soon,
> > > and fixed (presumably).  Of course that still doesn't guarantee the
> > > code would actually work on 32-bit, but successful compilation is a
> > > first step...
> > > 
> > > As the maintainer, the decision is yours, though.  
> > 
> > Thanks Geert,
> > 
> > In my understanding COMPILE_TEST is about expanding compile-test coverage,
> > and that is what this patch does.
> 
> Mine is that the goal of COMPILE_TEST is to make hard to reach but
> *reachable* configurations. Canonical example a driver which can
> only be useful on a single SOC may be hiding under that SOCs configs
> but we don't want allconfig to miss it. Or randconfig to struggle
> to each it.
> 
> If we change a core API we want to be able to build all the drivers
> that it may break.
> 
> Here the situation is different, this code is already reachable by
> allmodconfig. The patch makes it also build for what I referred to
> as very unusual and Geert as "on't be dead for at least a decade"
> platforms.. But crucially the code currently _never_ builds for 
> those platforms.
> 
> Please don't repost this.

Let us agree to disagree on the intention of COMPILE_TEST.
And let this thread rest.


Return-Path: <netdev+bounces-280270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AXsAKz652lBDwIAu9opvQ
	(envelope-from <netdev+bounces-280270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:31:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 742FF4402FB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 635A83052A35
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110573A63EB;
	Tue, 21 Apr 2026 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uKuL8uGw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8457D3A63F9;
	Tue, 21 Apr 2026 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810649; cv=none; b=POr+PO0p18bzPI5+Kpa/ZW40v1MTRk3PssQYfNEgqfCu1SO7Ixs0YvokDh4X9j6rX9YCxTB2uxa7cHTiqKRzjjtJjGB5bi12A0ra/kpLLK8+iGuXRcVc54HYmr8N/HnHNsZ3xrUQCzNv9h6d2EuX4OOeACs5pmb5VCva+/rHMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810649; c=relaxed/simple;
	bh=JsBROnWsbsDyWIr9oR1HKPcD4AXQqSpDxm4A53tUoO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0h3c4rT6h43+uNrcdv2XdvJt/GZatHn3m3HyriQC07xxl+X2dGwmMwiWFaHM+MM7PbUkiw8JZ/kYFAOLGsOnE7HqTMXYBwGMbHwVtCsZWd+WDnW9FC84TuOvyOsFsH3XgKIJF0AgoAoUyI63iFWBBzrgFJIVd6yww1gyQr24fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uKuL8uGw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0owjc2dIxrEANaZrUtLU2bidjjfsvfi6s/RKJ+8v4EY=; b=uKuL8uGwUDlq8ZeHU40EiewuKo
	39gp1IbmdG3nVvoZdJQZpondzwS/Oet0WfNYqdxiYOfo+QJNlaGq89rKIeqs/fzrAAaDtvhPjSJsE
	KiAME7OKq7YV4PCCo/WFwdSE9WsQsgfP32YmSWVamqaPi2dhwVz4qFBky1M3KCMgPjM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFJc4-00GxO6-QR; Wed, 22 Apr 2026 00:30:36 +0200
Date: Wed, 22 Apr 2026 00:30:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Byron Stanoszek <gandalf@winds.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
Message-ID: <e056d348-4560-4df3-85c4-e29393b004e9@lunn.ch>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
 <71d319ef-cd49-e8a8-70dd-cf0763ac6305@winds.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71d319ef-cd49-e8a8-70dd-cf0763ac6305@winds.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280270-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 742FF4402FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 04:44:11PM -0400, Byron Stanoszek wrote:
> On Tue, 21 Apr 2026, Andrew Lunn wrote:
> 
> > These old drivers have not been much of a Maintenance burden until
> > recently. Now there are more newbies using AI and fuzzers finding
> > issues, resulting in more work for Maintainers. Fixing these old
> > drivers make little sense, if it is not clear they have users.
> > 
> >      drivers: net: 3com: 3c59x: Remove this driver
> 
> Hi Andrew,
> 
> I happen to still use this driver on several hundred industrial PC
> installations that were outfitted with 3com 3C905-B & CX cards 15+ years ago.
> The old hardware still runs, therefore those cards haven't needed to be
> replaced. I keep these systems up to date with the latest Linux kernel roughly
> once per year.

So 6.18? 6.12?

> I understand the maintenance burden, but I would be delighted to continue
> receiving bug fixes for this driver via the mainline Linux kernel if you are
> still willing to continue to support it.

Looking at the history of 3c59x.c i see:

Date:   Tue Jan 6 10:47:21 2026 +0100

    net: 3com: 3c59x: fix possible null dereference in vortex_probe1()

Date:   Wed Jan 3 13:09:23 2018 -0500

    3c59x: fix missing dma_mapping_error check and bad ring refill logic

Date:   Thu Feb 25 13:02:50 2016 -0500

    3c59x: mask LAST_FRAG bit from length field in ring

Date:   Sun Feb 28 16:49:29 2016 +0900

    3c59x: Ensure to apply the expires time

Date:   Wed Jan 13 12:43:54 2016 -0500

    3c59x: fix another page map/single unmap imbalance

Date:   Wed Jan 13 12:43:53 2016 -0500

    3c59x: balance page maps and unmaps

Date:   Tue Jul 7 20:48:55 2015 +0200

    3c59x: Fix shared IRQ handling

So it looks like it was been pretty stable since 2016.

Could you live with v6.18, which has an expected EOL of December 2028?
If you are only updating once per year, security is not an issue, you
just want stability.

In fact, you might actually find stability starts going down in the
next couple of years, maybe sooner. What we expect to happen soon is a
lot more AI generated 'bug fixes', probably from newbies who are
unable to evaluate if the AI is generated good fixes or bad fixes, or
fixes which are theoretical rather than actual bugs etc. We netdev
Maintainers are already seeing the number of patches going up, and are
expecting to get overloaded. Which means quality will go down. We have
also seen the AI generated fixes are indiscriminate, neither the AI,
nor the human, care, or even look, to see if the driver is from the
last century. We Maintainers however would prefer spending our time on
drivers from the last ten years, maybe newer. So patches for these
older drivers is going to get less review, and bad patches will slip
through.

By dropping them for the current HEAD, we are reducing our surface
area. It will be interesting to see if the AI patches are only for
HEAD, or they start going back to older kernels to find 'bugs'.

However, just because a driver has gone from HEAD, it does not really
prevent us from taking patches for stable. But we Maintainers want to
avoid doing the triage work, figuring out good from bad.

We have not discussed it as a Maintainer team, but one thing which
might work is we add a entry for 3c59x.c in MAINTAINERS, in stable,
pointing to you. You can then validate patches, and tell us if they
are O.K. to queue for stable.

    Andrew


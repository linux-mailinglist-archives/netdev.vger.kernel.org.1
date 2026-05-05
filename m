Return-Path: <netdev+bounces-284359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHWBNyvi+WlPEwMAu9opvQ
	(envelope-from <netdev+bounces-284359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:27:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF6F4CD6FC
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4098E303FACA
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF00E3A254C;
	Tue,  5 May 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h3clNq96"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28FD38946A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983787; cv=none; b=OUM2q+L5NnA1GVrd53ssw6m2dGNpArvEsxrNNtoimCc2m18WweLI46PG/RFZy3fxb7H5pXjQJ5Xxpq46N9UGPszRjkNtqdf2ESFyqcx5eWlgeOBOwgKaYQmxxDEhnQDp0poBJzN7Gcq2bJJiczYVXjKwPkyzv4KioZ5t5PlTO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983787; c=relaxed/simple;
	bh=2TxmB+jvENzHHtnNMRVGaR8ReVVzSDnS18IgzTbrbzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKPdNnEEIcqo+rScKRe8IipCsJFgBjbnG8wqS5ByNs+2rJmob+1cP9knJzqCUtXJhf1nArYAFZ7gi3Pz2G6B2Z35MGg4Bn4WouRh5PcQIlT+GWmfVb3NEv/I8zQAqSNMaMsNWc7Vn4Ms7zSGXSQ7F80Dd6D+25H3j/h5XCoRBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h3clNq96; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OF3TNpsc/6TKGwK2ZNnFceMzSVtE+xrTnW4YUzdPkKQ=; b=h3clNq96oQPyTptWQpwfp0bkvg
	OWqMpJDCrlSywiH17d5QMsWIJOmvMQ7IFaIoNwpe83TDvRSqZtMwfqctYHjOPIDGwMNlSuBuclPWP
	hjGX0MzILtwMHHwtwnyUi+0KdYbt4bcL8GVdb+yThBQnYODE90NGi7lG6UmfgGL+NN5I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKEng-001SH8-2Z; Tue, 05 May 2026 14:22:56 +0200
Date: Tue, 5 May 2026 14:22:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	richardcochran@gmail.com, milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com, vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync test
 using netdevsim
Message-ID: <9c7eecee-f0c2-4ee3-95cf-ae9965191902@lunn.ch>
References: <20260503074747.1321-1-maciek@machnikowski.net>
 <20260503074747.1321-4-maciek@machnikowski.net>
 <20260504100753.7cc193cc@kernel.org>
 <b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
X-Rspamd-Queue-Id: 4EF6F4CD6FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,intel.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-284359-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid,nscl.name:url]

On Tue, May 05, 2026 at 09:36:30AM +0200, Maciek Machnikowski wrote:
> 
> 
> On 04/05/2026 19:07, Jakub Kicinski wrote:
> > On Sun,  3 May 2026 09:47:47 +0200 Maciek Machnikowski wrote:
> >> Add PTP synchronization test using ptp4l and netdevsim.
> >>
> >> The test creates two netdevsim adapters, links them together
> >> and runs the ptp4l leader and ptp4l follower on two ends
> >> of the netdevsim link and waits for the follower to report the
> >> synchronized state (s2) in its output log.
> >>
> >> This implementation runs the test runs over IPv4 link.
> > 
> > Doesn't seem to pass on netdevsim for us:
> > 
> > # 41.13 [+40.95] # ptp4l follower did not reach locked state (s2) within 40s
> > # 41.13 [+0.00] # Follower log (last 10 lines): ptp4l[2179.605]: ioctl SIOCETHTOOL failed: Operation not supported | ptp4l[2179.607]: interface 'eth0' does not support requested timestamping mode | failed to create a clock
> > # 41.15 [+0.02] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 173, in ptp_sync_test:
> > # 41.15 [+0.01] # Check|     _run_ptp4l_wait_sync(nsimsv.ifname, nsimcl.ifname, nssv.name, nscl.name)
> > # 41.16 [+0.01] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 99, in _run_ptp4l_wait_sync:
> > # 41.17 [+0.01] # Check|     ksft_true(False, "PTP sync timeout")
> > # 41.17 [+0.00] # Check failed False does not eval to True PTP sync timeout
> > # 41.32 [+0.16] not ok 1 ptp.ptp_sync_test
> > # 41.33 [+0.00] # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> > 
> > Anything we need to do?
> 
> Can you share the config file you used? Seems the PTP clock was not
> found which may lead to PTP_1588_CLOCK_MOCK not being enabled?

Shouldn't the configuration file be part of the test?

	Andrew


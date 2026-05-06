Return-Path: <netdev+bounces-284627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCKgOvmJ+mm6PgMAu9opvQ
	(envelope-from <netdev+bounces-284627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:23:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4444D4F62
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFA51301F9A2
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801D51DE8BE;
	Wed,  6 May 2026 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaRhT2W2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22C7262E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778026999; cv=none; b=isBC4iLlIcDrIujmJecAk7iH5VV/DL5ZhoQlkKonXPb/dgfxF1t8WbpSOwzTRgQqrF9uww05dAFNcS9V7Nb4yoj9Z/XXnS2KkAN1j5YHWkrnRn4jZtO69KKdnBbYBIhSrrZ3Yx24JiuFqzS1pfkIhkN+CD9+TS8TPc7iVwLhCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778026999; c=relaxed/simple;
	bh=N/VXzOeIbzgolhAt64rY+P5dUaWDXOrcxi8ak5wXcEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKx0/fqO+f3WyaN3Fux1GIykwZK0oZRGQZJvRqCt4lx8WbYJTW8Kij7JiJAswjNnpMW7GcdWvuJdOxf63ESOMSMv6jqioQadQ3eg3YEHut7GK7vpzqKMxm1OEYbzMXjqi5gpMpoOw4D8H2uV1aM2aUZW3dWQHkD3rmtJuVA5lJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaRhT2W2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686FCC2BCB4;
	Wed,  6 May 2026 00:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778026998;
	bh=N/VXzOeIbzgolhAt64rY+P5dUaWDXOrcxi8ak5wXcEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QaRhT2W2iE9iT3SkSFuPzAnaj80BFgSDkrbvvDb5SpgIOwoYenaRJ7NGX01o3j81E
	 g0kpBk+FGcnCWT1a9u1TM664UKC/Ut03m4tK6UZBUFHfd7SRKk9z7P60P9DrvbwHpy
	 Q11HNsYmSNrF50Tu3iLY030E8yHoEBel+KBQw/uUF57ro8enN78E+303hW+0Sv0rv7
	 JcgpaY17zF7nlR0BCR2xJvm4TA5qWgzCR4kWvft5wgVgbIvKmC4ZAP5WZXXRvmgabH
	 ErZe+fw4zU0+Da57wJdtSZc5QhKtHJ9gwZWrra7qEpymEvK21J5Zlp+Bcs1echmdnS
	 dP1NooYoSVccA==
Date: Tue, 5 May 2026 17:23:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v5 net-next 3/3] selftests:net: Implement ptp4l sync
 test using netdevsim
Message-ID: <20260505172317.089fb380@kernel.org>
In-Reply-To: <20260505172234.3348a81b@kernel.org>
References: <20260503074747.1321-1-maciek@machnikowski.net>
	<20260503074747.1321-4-maciek@machnikowski.net>
	<20260504100753.7cc193cc@kernel.org>
	<b2ceffa3-a1d3-4124-b640-68fc11996f51@machnikowski.net>
	<20260505172234.3348a81b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4A4444D4F62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev,kernel.org];
	TAGGED_FROM(0.00)[bounces-284627-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 5 May 2026 17:22:34 -0700 Jakub Kicinski wrote:
> On Tue, 5 May 2026 09:36:30 +0200 Maciek Machnikowski wrote:
> > On 04/05/2026 19:07, Jakub Kicinski wrote:  
> > > On Sun,  3 May 2026 09:47:47 +0200 Maciek Machnikowski wrote:    
> > > Doesn't seem to pass on netdevsim for us:
> > > 
> > > # 41.13 [+40.95] # ptp4l follower did not reach locked state (s2) within 40s
> > > # 41.13 [+0.00] # Follower log (last 10 lines): ptp4l[2179.605]: ioctl SIOCETHTOOL failed: Operation not supported | ptp4l[2179.607]: interface 'eth0' does not support requested timestamping mode | failed to create a clock
> > > # 41.15 [+0.02] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 173, in ptp_sync_test:
> > > # 41.15 [+0.01] # Check|     _run_ptp4l_wait_sync(nsimsv.ifname, nsimcl.ifname, nssv.name, nscl.name)
> > > # 41.16 [+0.01] # Check| At /srv/vmksft/testing/wt-2/tools/testing/selftests/net/./ptp.py, line 99, in _run_ptp4l_wait_sync:
> > > # 41.17 [+0.01] # Check|     ksft_true(False, "PTP sync timeout")
> > > # 41.17 [+0.00] # Check failed False does not eval to True PTP sync timeout
> > > # 41.32 [+0.16] not ok 1 ptp.ptp_sync_test
> > > # 41.33 [+0.00] # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> > > 
> > > Anything we need to do?    
> > 
> > Can you share the config file you used? Seems the PTP clock was not
> > found which may lead to PTP_1588_CLOCK_MOCK not being enabled?  
> 
> You have to add it to the relevant config.
> 
> Please read: github.com/linux-netdev/nipa/wiki/Netdev-CI-system

Sorry, wrong link, this:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style


Return-Path: <netdev+bounces-262956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG0NLlQmpmnwLAAAu9opvQ
	(envelope-from <netdev+bounces-262956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 01:07:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 612FD1E6F94
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 01:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74DF63019C83
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 00:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9025474F;
	Tue,  3 Mar 2026 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK7CARNE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACC02628D;
	Tue,  3 Mar 2026 00:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496465; cv=none; b=mqYRSVTkh90tbsY6LMgGQ3aCnR7vws81vf9Rd05FKQHuGg/2/cN3uMpUi05Y5Pluot+KYkZF2dOW4ffrHTLBBVWBu5hI9R++7jPny/djAAmOJVpoyuEpspa3KpR/dp/oGITGQ70ls3jOV++04drL3i2cp4MNvg7MX76z1LtRE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496465; c=relaxed/simple;
	bh=EThN0d1uq2Lnup4NHkAJwhWfP9oJjh6mVRffnmzFeZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPlLOGXcSLp7hcc8WDr1H5RW37pK9sT2GW8m2vf5yYkEqjNuuOVWQVN4EtwBsAvuonP1OwjXP6vL82Es04wbxizJA66/kkfh5UMcs/wPbz2Px/fI/I4GY9jHEvPdSAw8wpE8OVm0AeHXOrxIx3Qi3e09xprubXiloqp+XN+jCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK7CARNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D45C19423;
	Tue,  3 Mar 2026 00:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772496464;
	bh=EThN0d1uq2Lnup4NHkAJwhWfP9oJjh6mVRffnmzFeZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bK7CARNE6FxRDwasyLC8hfczkmXG6BxyoZseuFifxv8j/9ClAKS9eG51voK2HGx9P
	 oseYtanuSWKrbFTDA52ZzfvcvIKNHqjgK2m5iBlCIRAldDniJ6jEVkZXvmaFqecmtZ
	 ENxZaC1cSs0bUNNGXIbQe9HTzviTAt1zmBUIPvvItHvSe8uhdOBLq1eNRFYPuaHDsV
	 eFtEpdPfUAzSE4UOuOpZK9RX14oTiVqVpCmoQYAaM6z8Rohq5drekptgDFg75NgMm0
	 6dPu6/Ks5KVZ50YDGjPLm7/t6AAPGics97qg96nrT0Z0g4yqzPyPHg47hHa8IF8oSG
	 GYs6oLHE8amgQ==
Date: Mon, 2 Mar 2026 16:07:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Petr Machata <me@pmachata.org>, Petr Machata <petrm@nvidia.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <20260302160743.124531f8@kernel.org>
In-Reply-To: <7hct7o4rzgygef536al6if2jl45p32ad3tdswyqf25uu5wy5re@2ltu2ems47q7>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
	<20260225150648.1542206-6-ioana.ciornei@nxp.com>
	<20260226182223.5eb1b10f@kernel.org>
	<87ms0ufc0p.fsf@nvidia.com>
	<20260227164348.63afcc43@kernel.org>
	<877brxf272.fsf@nvidia.com>
	<7hct7o4rzgygef536al6if2jl45p32ad3tdswyqf25uu5wy5re@2ltu2ems47q7>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 612FD1E6F94
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-262956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 14:11:21 +0200 Ioana Ciornei wrote:
> > I agree that adherence to the drivers/net/README protocol is valuable to
> > some users and would be good to uphold if reasonable in a given tests.
> > If that's what you have in mind.
> > 
> > There are going to be tests where it's not a great fit, but I think that
> > of those NUM_NETIFS=2 tests that we currently have, maybe
> > ethtool_extended_state has a good reason to be obstinate, because it
> > sets up negotiations and needs an extra unplugged netdevice.  
> 
> I would add here even ethtool_rmon.sh and this new test that I

I think I already told you that ethool_rmon predates the NIC tests
and bringing it up in this discussion is irrelevant.

> submitted. If you are running with a traffic generator on another board
> then you can no longer check that the counter's value is as expected
> (with a 1% tolerance), you can only check the lower bound.

1% tolerance is impractical for any CI with high test count.
The test will be flaky. And I really doubt that the 1% tolerance
is really necessary to catch most bugs. We're not trying to validate
silicon here.

> Additionally, if you are using the same single port also for control
> traffic towards the remote traffic generator, then you surely cannot
> reliably check that counters that should not be incremented are indeed
> not incremented.

I both told you in this conversation how to check the counters,
and written some existing tests for counters.


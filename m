Return-Path: <netdev+bounces-262020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMSBOnA6omk71AQAu9opvQ
	(envelope-from <netdev+bounces-262020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:44:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 989CF1BF792
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D5DB3028029
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399A526A088;
	Sat, 28 Feb 2026 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEykySR1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D40262D0B;
	Sat, 28 Feb 2026 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772239430; cv=none; b=ZaTJ/hjE2CsV1rajxOS6hc/qqay/xX/7vnce1Nmr83y/bo2f5Mk5Y5sTfgH7f1yb4tBIETnPfibUp/IQfH9VBMXCsKZ/7lJ8PzRh4QOknUcYaU87ZUCcwrz7vs84tTVvuMaaCIpwj4zOveOKObHz1JHuaX7vMPQ16x87MdXXXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772239430; c=relaxed/simple;
	bh=BpYrG8pxRKmKebGZQHmsmbPXtrrDZFkM5FRO8KV2e28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1JfhQvvqy7FX4hp644ySRotRqSy4OZWEAn6Uoe1NobmEZ7WVD2MbETIfrer7PT6fwQy17YHDQgUnc2LOsggEgpEID2G/SCf7oDC+hAXMY11tkYor8p86fIouA7gPhDebE/VGX5viBlgW6ERxjjKSgi6t3mMd2UjUrJZIq9fL4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEykySR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F321C116C6;
	Sat, 28 Feb 2026 00:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772239429;
	bh=BpYrG8pxRKmKebGZQHmsmbPXtrrDZFkM5FRO8KV2e28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mEykySR1UIGEflLjYgCjTIVtiMReRZnjHuN87wogViPVKn6R3z28M0eyjzfw0tz/6
	 q0K/tBuWugTznZNvXph1R9caI5lN/yXs+zJxeK49hxC1iz4ULEiW5e9j8rMCYXkbR1
	 MersJUb2qO+pv7bfWQkNs/rYlaD+dqrk8/+veYO+FVwYSARYfy7dJP0AHKuC/tCpZR
	 Xx5aZ1GMPcGQwevXbpypxL4122A27p2GoUb4lv6CKtWYIZjHGnZGtD3Byx0Bb0lkbN
	 CJWxBKYvrmQvz/OSMU8C8Zr9zF3ADcxaEX3KTCgFTeoSVW7glgMkp1puJorZQKQVOL
	 QLWZEOB/wj32A==
Date: Fri, 27 Feb 2026 16:43:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, <netdev@vger.kernel.org>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S.  Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Message-ID: <20260227164348.63afcc43@kernel.org>
In-Reply-To: <87ms0ufc0p.fsf@nvidia.com>
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
	<20260225150648.1542206-6-ioana.ciornei@nxp.com>
	<20260226182223.5eb1b10f@kernel.org>
	<87ms0ufc0p.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262020-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 989CF1BF792
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 14:53:06 +0100 Petr Machata wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > On Wed, 25 Feb 2026 17:06:48 +0200 Ioana Ciornei wrote:  
> >> +ALL_TESTS="
> >> +	test_eth_ctrl_stats
> >> +	test_eth_mac_stats
> >> +	test_pause_stats
> >> +"
> >> +STABLE_MAC_ADDRS=yes
> >> +NUM_NETIFS=2
> >> +lib_dir=$(dirname "$0")
> >> +# shellcheck source=./../../../net/forwarding/lib.sh
> >> +source "$lib_dir"/../../../net/forwarding/lib.sh  
> >
> > Argh, at some point we should probably decide whether we have 
> > a preference on which "library" / set of env vars we use under 
> > drivers/net/hw. Adding Petr to CC.  
> 
> I think the expectation is that by default, tests written in Bash are
> run on one machine without remotes.

I think we need to define the guidance by properties of the test, not
the machine? Of course _tests_ which don't need a traffic source can
simply consume the NETIF evn variable, so its trivial to write them in
any language without much library support. But for tests which need
traffic input we need a different distinction than "does the author
care about single-interface machines", so to speak?

> I think this fundamentally stems from the fact that running processes in
> Python is a bit unwieldy, so it makes sense to have helpers, so
> everybody uses them, so you can have helpers grow brains to do things
> like over-the-ssh configuration. In Bash, running a traffic generator is
> easier than working with arrays. So the helpers tend not to be as useful
> and we don't generally have them. At least not in any consistent way.
> 
> Eyeing the file, the requirement for the remote interface to be up and
> configured with an IP address is a bit surprising to me. I would think a
> down state is the most natural, and have the test bring it up and
> configure it in a way that it needs. I'm thinking maybe this is to allow
> testing a sole interface on like an embedded device?
> 
> Anyway, that's a fairly strong differency between how Bash tests are
> typically written and the NIC setup. I think basically all existing
> tests assume the devices are theirs to tamper with.
> 
> > The existing tests under drivers/net/hw which source forwarding/lib.sh
> > pre-date the "NIC setup" described in 
> > tools/testing/selftests/drivers/net/README.rst
> >
> > Should we ask "NIC setup" to be used for all tests which only need
> > NUM_NETIFS=2 ? These are basically simple tests where one netif is 
> > a traffic generator and the other is the DUT. And IIUC the "forwarding
> > setup" can't be used when the traffic generator is controlled over SSH?  
> 
> In principle nothing prevents lib.sh from growing brains to support
> these remote shenanigans. I think it's just that so far nobody cared
> enough to actually do it.
> 
> I think that a helper that in effect does "run this on a machine where
> $swp1 is" is mostly what is needed. That and "make sure $swp1 and $swp2
> are on the same machine". It's going to be annoying to work with though,
> because you need to annotate every single command. I bet there's a nice
> syntax to make it not activelly annoying.
> 
> If we have this, it might make sense to require tests to make use of it.
> (With an explicit opt-out for special cases.) But I do not want every
> test to have to reinvent this wheel and cargo-cult snippets from other
> tests.
> 
> BTW, my guess is that even many multi-port tests that I wrote boil down
> to just a bunch of fairly independent loopbacks whose far ends could be
> on remote machines. It's not a priori nonsense to me that one would run
> a test like this, or whatever magic we'd use:
> 
>     ./test.sh ssh://petr@10.1.2.3:eth1 swp1 veth1 ns://foo:veth2
> 
> And it just works, because only swp1 and swp2 need to be bridged, the
> rest can be remote, and the traffic generation helper knows that to pump
> traffic to ssh://10.1.2.3:eth1, obviously you need to ssh there first.
> But the library would need to have helpers for this, and the tests would
> need to use them.

Right, to be clear I primarily care about being able to run these tests
with traffic generator on a remote system. Otherwise someone who cares
about single-port systems will have to add a separate test I guess?
And we will have to maintain two tests? :S

A nice to have is for all drivers/net/hw tests to use the "NIC" env
variables (move tests which really only make sense on multi-port
devices to drivers/net/forwarding?) But I think "translating"
forwarding variables to NIC if NUMIF=2 could easily be done
automatically by the test / lib so that's lower priority.

> At least ethtool counters would cause problems obviously.



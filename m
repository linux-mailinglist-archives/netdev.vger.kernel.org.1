Return-Path: <netdev+bounces-262122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJquDzjoomlG8AQAu9opvQ
	(envelope-from <netdev+bounces-262122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:06:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4BD1C318C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA5E130479DD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 13:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8795743DA40;
	Sat, 28 Feb 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="GgxHoMsO"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77875283FDB;
	Sat, 28 Feb 2026 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283956; cv=none; b=V+Co14MCP8VI/hCdo3gHznAuZaMkN73zBEtnJakSz30ZbZqxKXRFoc+2H7kYwMbr6l++CAZtJQG+vCnLagDShWjDK1rtqWiJnJeBbVTqVZNI1aU0/kTWs+Aoec0CZye6Q+855ufXJIJAUvtV+myYKRQeIJbaJHzr3v4sT43Ac/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283956; c=relaxed/simple;
	bh=Kp99RHVH20I6HuYgBP+WhRnM/GM6AC7c9yUMHnJPmow=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=PRhiwkwAOCa1mEn3tVx2IDf26fzPKk+Gygu8aQkaaxjJb3sFO24j7wNnjQZ1oBL4QocR5pTNa8OZOhukOUtF/PHz84sXPCXLLOC4yG/GF8/sXju4w3Frbz2PilbdpHOM5AicT3xOeHJciQt0UltNEOPHLhVhV6WHrN4sLOzLWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org; spf=pass smtp.mailfrom=pmachata.org; dkim=pass (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b=GgxHoMsO; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fNQRV1sf3z9tZ4;
	Sat, 28 Feb 2026 14:05:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1772283942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBCTqfoUFB8sEME4u3rPQMqwI7w/71GcIE63YBTocA0=;
	b=GgxHoMsOrYIq8LukeJOWt7iwf/VmndWsp6AXkgOwTcV/hRWSCiBqm/lHkQG8OwOk1DRo6n
	1815aFOYmjXVXThcSDmiJEIrCzqktqRYUsASSGEjibbtTQfif8c9fNnqoP0+J00mOhgump
	K4XzH4WZu01Teb7XZw0rtMKd5PIFHICw7c/0srN+kTlW1XmedvCd+D0pFckS5volwwLu32
	hG9/nxHijyZsVG+n/XxDCvqJlDVjVpf4kwzyeEGUJKEFPMG2j0ZJEWrf3Em0N8x4tVuNke
	B9cnhwQACNIZeNohn1dWhGR6hkSHnpJyFy8ayXFezgWIWba38gF3jAIxqEX9Mw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of me@pmachata.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=me@pmachata.org
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-6-ioana.ciornei@nxp.com>
 <20260226182223.5eb1b10f@kernel.org> <87ms0ufc0p.fsf@nvidia.com>
 <20260227164348.63afcc43@kernel.org>
From: Petr Machata <me@pmachata.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 netdev@vger.kernel.org, Andrew  Lunn <andrew+netdev@lunn.ch>, "David S.
  Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests: drivers: hw: add tests for the
 ethtool standard counters
Date: Sat, 28 Feb 2026 10:11:26 +0100
In-reply-to: <20260227164348.63afcc43@kernel.org>
Message-ID: <877brxf272.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[pmachata.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[pmachata.org:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262122-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@pmachata.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[pmachata.org:+];
	NEURAL_HAM(-0.00)[-0.968];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: DC4BD1C318C
X-Rspamd-Action: no action


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 27 Feb 2026 14:53:06 +0100 Petr Machata wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>> > On Wed, 25 Feb 2026 17:06:48 +0200 Ioana Ciornei wrote:  
>> >> +ALL_TESTS="
>> >> +	test_eth_ctrl_stats
>> >> +	test_eth_mac_stats
>> >> +	test_pause_stats
>> >> +"
>> >> +STABLE_MAC_ADDRS=yes
>> >> +NUM_NETIFS=2
>> >> +lib_dir=$(dirname "$0")
>> >> +# shellcheck source=./../../../net/forwarding/lib.sh
>> >> +source "$lib_dir"/../../../net/forwarding/lib.sh  
>> >
>> > Argh, at some point we should probably decide whether we have 
>> > a preference on which "library" / set of env vars we use under 
>> > drivers/net/hw. Adding Petr to CC.  
>> 
>> I think the expectation is that by default, tests written in Bash are
>> run on one machine without remotes.
>
> I think we need to define the guidance by properties of the test, not
> the machine? Of course _tests_ which don't need a traffic source can

Oh yeah, I'm just stating that's how it currently is and how we got here.

> simply consume the NETIF evn variable, so its trivial to write them in
> any language without much library support. But for tests which need
> traffic input we need a different distinction than "does the author
> care about single-interface machines", so to speak?

I agree that adherence to the drivers/net/README protocol is valuable to
some users and would be good to uphold if reasonable in a given tests.
If that's what you have in mind.

There are going to be tests where it's not a great fit, but I think that
of those NUM_NETIFS=2 tests that we currently have, maybe
ethtool_extended_state has a good reason to be obstinate, because it
sets up negotiations and needs an extra unplugged netdevice.

>> 
>> > The existing tests under drivers/net/hw which source forwarding/lib.sh
>> > pre-date the "NIC setup" described in 
>> > tools/testing/selftests/drivers/net/README.rst
>> >
>> > Should we ask "NIC setup" to be used for all tests which only need
>> > NUM_NETIFS=2 ? These are basically simple tests where one netif is 
>> > a traffic generator and the other is the DUT. And IIUC the "forwarding
>> > setup" can't be used when the traffic generator is controlled over SSH?  
>> 
>> In principle nothing prevents lib.sh from growing brains to support
>> these remote shenanigans. I think it's just that so far nobody cared
>> enough to actually do it.
>> 
>> I think that a helper that in effect does "run this on a machine where
>> $swp1 is" is mostly what is needed. That and "make sure $swp1 and $swp2
>> are on the same machine". It's going to be annoying to work with though,
>> because you need to annotate every single command. I bet there's a nice
>> syntax to make it not activelly annoying.
>> 
>> If we have this, it might make sense to require tests to make use of it.
>> (With an explicit opt-out for special cases.) But I do not want every
>> test to have to reinvent this wheel and cargo-cult snippets from other
>> tests.
>> 
>> BTW, my guess is that even many multi-port tests that I wrote boil down
>> to just a bunch of fairly independent loopbacks whose far ends could be
>> on remote machines. It's not a priori nonsense to me that one would run
>> a test like this, or whatever magic we'd use:
>> 
>>     ./test.sh ssh://petr@10.1.2.3:eth1 swp1 veth1 ns://foo:veth2
>> 
>> And it just works, because only swp1 and swp2 need to be bridged, the
>> rest can be remote, and the traffic generation helper knows that to pump
>> traffic to ssh://10.1.2.3:eth1, obviously you need to ssh there first.
>> But the library would need to have helpers for this, and the tests would
>> need to use them.
>
> Right, to be clear I primarily care about being able to run these tests
> with traffic generator on a remote system. Otherwise someone who cares
> about single-port systems will have to add a separate test I guess?
> And we will have to maintain two tests? :S
>
> A nice to have is for all drivers/net/hw tests to use the "NIC" env
> variables (move tests which really only make sense on multi-port
> devices to drivers/net/forwarding?) But I think "translating"
> forwarding variables to NIC if NUMIF=2 could easily be done
> automatically by the test / lib so that's lower priority.

The reason for my diatribe above was like, if forwarding/lib.sh is
clever enough to handle these things transparently, then the NIC case
might be supported through a wrapper that just does the right thing, and
the test can be overtly just a run of the mill forwarding test.

The requirement for the remote netdevice to be up and preconfigured
throws a wrench in this idea though, so dunno.

One way or another, _some_ brains need to reside somewhere in a library.
I'm not sure forwarding.sh is the place. But I don't want to end up in
the same situation as like lib/half_the_tests.sh that reinvent logging
from first principles again and again.


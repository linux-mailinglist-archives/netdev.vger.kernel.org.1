Return-Path: <netdev+bounces-303397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L97oADNIRGp3rwoAu9opvQ
	(envelope-from <netdev+bounces-303397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:50:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 769626E87F0
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 00:50:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nbS240E4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303397-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303397-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D6913016EC3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796793264F5;
	Tue, 30 Jun 2026 22:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E72737E3
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 22:50:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859824; cv=none; b=QyTUeUJjq44da0UUJcv3okyKEFwARD0zJAej9s3PUp+rqBr1quHEfL8Sax9XHp7WSMy2UzEmF8OWVSCVvgzLEn462Z+TTm/10nROdtgVpG4BuxdDC2Q91y03dK/9ouyQKCH3SLehoEjg+GJz5mF5ps7okkN4DvRa276SdQZe0rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859824; c=relaxed/simple;
	bh=SKjpIwrI/Ty/83Rr6VQ6g93VCgkx+AoZGCCGGr61jao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXKrtEi7s8ogzJI8I/sIhGS3HbCRQnwNSkhVuCL92WHnMZavzA0J07BKM1zXgurmhetMpA5NXco0bT3WaYcJp/Pnh/QgRENY9n/7xLxNNOj3FqSVSDQORTB6o1K1YcjTvtt+aL7t88FpqzZFJY6s7S9NOe2c+A0uutcY7sclVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbS240E4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA26F1F000E9;
	Tue, 30 Jun 2026 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782859823;
	bh=4/7TjGJiqZagTrJvi7kpMXuVrILhpW7k/6RtBUpwu6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nbS240E4fkTexZ4KVCGleDZ6Ui7AHYGBZBuASvkTzuaeSIbLK1nSTFFQ/yDpAjjZg
	 hj8N4tVcDPKDNeqKTPUPVyLv62PEEdI5l1fPkXhcumUuUlEzii30PgKS4JDe4/3hZB
	 Go6hwcMA2VWjQsfmQiPY6Jr+WT/Ud6sL15ntoANXHAdqm/MOoQvyV6520L/4xFqcgq
	 so4pbCqCnWcwgrBeUG777l9Wl2vwe2CD0nEEUNVoUxYXwHRtJTYuxCJ1LOPT8KH4HL
	 bnW3wkCkQfukIBzjLmqWjr9We7pKuBqWCBE7pCKz4QE6uBjqs+pBQdWAIWX3Q6Db5f
	 Vmkx8igg4Or6Q==
Date: Tue, 30 Jun 2026 15:50:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Pielech, Adrian" <adrian.pielech@intel.com>
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <leszek.pepiak@intel.com>
Subject: Re: [TEST] intel: low timeout
Message-ID: <20260630155022.27c9a271@kernel.org>
In-Reply-To: <35ccefb4-a588-4556-87c0-ade880eaa8d6@intel.com>
References: <20260627095400.3c3d9f80@kernel.org>
	<35ccefb4-a588-4556-87c0-ade880eaa8d6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:adrian.pielech@intel.com,m:przemyslaw.kitszel@intel.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:leszek.pepiak@intel.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303397-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 769626E87F0

On Tue, 30 Jun 2026 14:56:02 +0200 Pielech, Adrian wrote:
> On 6/27/2026 6:54 PM, Jakub Kicinski wrote:
> > Hi!
> > 
> > Some of the tests need more than 5min, could you increase the timeout
> > in the runner to 10 or 15min? Looks like it's hard-killing tests right
> > now after 2min:
> > 
> > https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/xdp.py/stdout
> > 
> > which leaks config across tests:
> > 
> > https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/irq.py/stdout
> > 
> > BTW the JSON reports the timed out tests as pass.  
> 
> Hi Jakub,
> 
> I've increased timeout to 10 minutes per test run. It seems to help with 
> XDP tests score.

Great, thank you!

> I'll later take a look on default behavior of runner in case of timeouts.

default behavior == pass/fail status for the test?


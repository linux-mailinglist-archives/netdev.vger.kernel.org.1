Return-Path: <netdev+bounces-301696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SHMIHJ/4O2r8gwgAu9opvQ
	(envelope-from <netdev+bounces-301696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:32:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D05796BFADC
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:32:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NLbwuSVN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301696-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301696-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D3B83014500
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768CA3CDBB7;
	Wed, 24 Jun 2026 15:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6CC305692
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:30:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315023; cv=none; b=k1/PY3Y1zZtEmIGh84TjZxRXtulgJLnXu3xYpma2h0SCYuTXM2MFQ59rNL+OCo+I1n5OB4+Wll46fB6Q6x/KPxxuVGLkw9utZm3CN+jp0j5GQelSmcobaTwB5P/Z/udcbewO2bldzWN+CRj1upv8wpli+kQj6fRQYrpxVtYGJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315023; c=relaxed/simple;
	bh=FkhzrnJ7xRFTflz9rMUJLq/spmv9XjoC+PUcQQZn+gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KjnI5jkVGDIadjHVkUgojPuhC8rDAW4dFfACioDNLamcoeLHg0DZkELiCzOVRowQ/Z7Cv1pD7XI+4o9MRqIFO7mMRclL3v0zFQBJLuTeSIIKj3MN5IyR90P9cBElgJ6voK/P7MtQABqcgiUU8ebc+4RWwE5g7fMfuF15MaeUMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLbwuSVN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245E41F000E9;
	Wed, 24 Jun 2026 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782315021;
	bh=RUcbvgmQZC5oKq764H4ENHHBEsmXURttubgifoaZF5I=;
	h=Date:From:To:Cc:Subject;
	b=NLbwuSVN9DmYytjs9Dlkf4Qe+kkPcBLajxXTBsLbn5Qx31QtNxtCPYLDyPWJBeHFJ
	 JFb2RfEOQyUQ12log4GHmmRVXEG+qQo+ZkK9K9hvtUcRqrHoGG85jd/Tmr743v8gOn
	 2tIH6+riCZzChAXEHmmn2TPbF7u21DTzjD7w7W06dDdaWrsyuiK+/DJYxvNXlPOfxJ
	 WWZHREoD9CuZ4TFc/1a/4oFRDBRixgNvObU8g9nQO0CYZCkj1njSwuw3gpdcDXUnnk
	 +pX1BtDCtEaZDc8SgUW98qG0olHWj5JyOD3ULg+E6MKt38gMPwBll7zGDhlAJH8y2W
	 I9hvA69j1nQlg==
Date: Wed, 24 Jun 2026 08:30:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adrian Pielech <adrian.pielech@intel.com>, Przemyslaw Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 intel-wired-lan@lists.osuosl.org
Subject: [TEST] Weird RSS state on ice
Message-ID: <20260624083020.131a75fe@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301696-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:adrian.pielech@intel.com,m:przemyslaw.kitszel@intel.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D05796BFADC

Hi!

I noticed in the netdev CI that the ice runner fails to run the
toeplitz tests because of the RSS config.

https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-23--00-00/ice-E810-CQ2/toeplitz.py/stdout

I added some extra debug on the branch:

net.lib.ynl.pyynl.lib.ynl.NlError: Netlink error: hash field config is not symmetric 16 304: Invalid argument {'bad-attr': '.input-xfrm'}

16, 304 means GTP flow, GTP_TEID field. So we are trying to disable
symmetric RSS, but the field configuration contains TEID. The problem
is this is an illegal configuration in the first place. We are
_disabling_ symmetric RSS, but the kernel tries to make sure that both
before and after states are correct (because the configuration involves
multiple calls to the drivers and may fail half-way-thru). If the
current config is illegal net/ethtool/ won't even let us restore it to
sane state.

So the question is how we got into this state. It does not happen
on netdev machines. And on Intel machines it happens randomly around
30% of the time.

I tried to look thru the driver code and I don't see how we could end
up with such a config.

Could y'all have a look and figure out / fix this? This has been
happening for a while back but I was waiting until the merge window 
to poke at it first.


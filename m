Return-Path: <netdev+bounces-302086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id efKRGkvfPWqN7QgAu9opvQ
	(envelope-from <netdev+bounces-302086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 04:09:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B389F6C9A83
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 04:09:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YU2HsUhM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302086-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302086-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9072E301589D
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 02:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6798B2E5B21;
	Fri, 26 Jun 2026 02:06:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603C029D294
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 02:06:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782439589; cv=none; b=kOYLmQRHvzGf94Cw59XgvzWrFBgGXGK1tiLzJwBUbBYUE6wqc3OQSElKFwWQGZcN6av6coYdPykz0b64BdABqfl9DOZ4sPPC4kXkzJG/Frm89MhrDK/CVgbWut2+2SJfSjqotMapFLVE0opFfR44VarQhenDTR3w5TtmujX61JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782439589; c=relaxed/simple;
	bh=VmcQEwX9BglXs9rMNPHXsY3xt7iaAMcsZxTl/WOUxvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMaV/k6rumvojvBywMWADsfkxdZxLTZZCzMLvOsKER9p4C5y4jDJ0QSw7q+oPwUdqn9+7gX4tsVv3Ca8dzikHhpuVhX3UbF4qHsZKiUfnU/hrrA+Xj2Dp2V4SpImddfivaFPyCWhTJ0I6/j6lIH9wwMfV3Z4500YvtLY0hdsntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU2HsUhM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0CE1F000E9;
	Fri, 26 Jun 2026 02:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782439586;
	bh=d4tY6cLSmj5pQ3iTcSmFAglPnRm3lU+hsBD/90+HQrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YU2HsUhMffQf9G0WEH9VIETrTq9/dPVToRpIlremKJP9cpDHs0EzEpZGsB2cvrej7
	 l9tghFvvbYh4uZ6+4Jzq9rurp2piQw+LXRPbrMertjH7Qypv87QTeelkF8ZWSaQl8m
	 9gNKXEJ9hnJ5gr9EPvQPNwZBdb+x8uOAEG03WC4R0cDcIjE5g6cZe34t4buGLPy27s
	 Yvn3h2uV1dxFGfUnTWPb4nu3QrOCFHOUmysLiPXU80uaR+tGXEZM7/uC1Foy5gBJk9
	 zG/DFdlAIWf3B/i1FhRCL6F+tz9NsyJGRTCH9e/OqM4BcFRn3R/JnYAdD42INh0j59
	 xzpbLJwaCnhvg==
Date: Thu, 25 Jun 2026 19:06:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Pielech, Adrian" <adrian.pielech@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>
Subject: Re: [Intel-wired-lan] [TEST] Weird RSS state on ice
Message-ID: <20260625190625.0f5ffe01@kernel.org>
In-Reply-To: <DS4PPF7551E65529A34C04A73F4287C2B4EE5EC2@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20260624083020.131a75fe@kernel.org>
	<DS4PPF7551E65529A34C04A73F4287C2B4EE5EC2@DS4PPF7551E6552.namprd11.prod.outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:aleksandr.loktionov@intel.com,m:adrian.pielech@intel.com,m:przemyslaw.kitszel@intel.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302086-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B389F6C9A83

On Thu, 25 Jun 2026 07:11:14 +0000 Loktionov, Aleksandr wrote:
> The patchset didn't help? 
> 
> [PATCH iwl-next v5 2/2] ice: implement symmetric RSS hash configuration

Not sure, it's not in tree, and lore doesn't want to point me at it
either. What I don't get is how we get into the bad state in the first
place.

Looking at other tests today I spotted that rss flow label test is also
behaving oddly. Most of the time the first case fails and the second
passes:

test	"rss-flow-label-py"
group	"selftests-drivers-net-hw"
result	"fail"
link	"https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-26--00-00/ice-E810-XXV4/rss_flow_label.py/stdout"
results	
0	
test	"rss-flow-label-test-rss-flow-label"
result	"fail"
1	
test	"rss-flow-label-test-rss-flow-label-6only"
result	"pass"


But every now and then they skip:

ok 1 rss_flow_label.test_rss_flow_label # SKIP Device doesn't support Flow Label for UDP6
ok 2 rss_flow_label.test_rss_flow_label_6only # SKIP Device doesn't support Flow Label for UDP6

test	"rss-flow-label-py"
group	"selftests-drivers-net-hw"
result	"skip"
link	"https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-25--16-00/ice-E810-XXV4/rss_flow_label.py/stdout"
results	
0	
test	"rss-flow-label-test-rss-flow-label"
result	"skip"
1	
test	"rss-flow-label-test-rss-flow-label-6only"
result	"skip"


The devlink info is identical so it must be that the device 
is in unclean state sometimes?? Do y'all power cycle these
machines between runs?


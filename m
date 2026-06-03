Return-Path: <netdev+bounces-294711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hNTpHLgFIGrXuAAAu9opvQ
	(envelope-from <netdev+bounces-294711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:45:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDFD636B17
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:45:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b=J8idjtnq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294711-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294711-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C65083077CA5
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472B238D019;
	Wed,  3 Jun 2026 10:44:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C513905F9
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 10:44:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483458; cv=none; b=owi6eFJx1xnfiCKFO+xjiDhacXXo2pmPS8Wdy6qJ9oWwO5y0DLuUiOqXoMM8zA3w3uXrjK0mghOKfN173/naHqfzJoVZyf7PoPnykbVSsGRh54ZN39rbk5J4J2Q0psDDgSHjHMwQN03ND425xyOq2h5uXYBW1f2MimqAaPkueOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483458; c=relaxed/simple;
	bh=ojQcS59DEjUCC4st6avEqD7kAl3cyOj9e0X+h35+Zxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4E9QNh4nYjH3Qg/V3Auu0ZiRT21gKObj6YhkDEyknOMS0jp5SnLGHJRp5Nkb9RDyDZiBkaPBpRggHmwIteNeTEw5+J3Fp5KapF/Z721TU+b+HZJ2tY6XHubCZh7e5PA2d7Xo8jwHTiwrgS69HyJ30+U+hVoWmNyAmVLkdB93c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=J8idjtnq; arc=none smtp.client-ip=188.68.63.166
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4gVkpQ40Vxz3yNF;
	Wed,  3 Jun 2026 12:44:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1780483454;
	bh=ojQcS59DEjUCC4st6avEqD7kAl3cyOj9e0X+h35+Zxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J8idjtnqjkpGwnUlR8YeERvrYaUw3ZzjERRjQz1mgOCw8/Ow3fuK4+QWjwau16/B9
	 JBYIzR06Re5/PT9tt/rbnDHv7XPBSK20c7QcYK9WvVqP8yjS2QICEbfeRKYYnivSZV
	 JfX/IQoJRh2Ff8zVmBequRb0LNX3CQC5osnVPidq5t8DUWH3fOmPntl3gIlyR+88Qe
	 jUhIGuQWBL7l6/KJADomyJLS7duaDOGl0t7hmeKu7ZK1Kaqh8QxvHSew8//Xne1Cs6
	 kAkk1xREHAFilJXEcFr/WcctDc+m0hTzmwmgSu3rM51i8P2k8Y2MHGDnt1c90lCHgQ
	 jc7tmk+Ls/Ttg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4gVkmX24Ksz44gB;
	Wed,  3 Jun 2026 12:42:36 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gVkmV2HS7z8sgw;
	Wed,  3 Jun 2026 12:42:34 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 16FB95F96B;
	Wed,  3 Jun 2026 12:42:33 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <2619ad91-e3c9-439c-86ed-4604c3f5d912@leemhuis.info>
Date: Wed, 3 Jun 2026 12:42:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] e1000e: Reconfigure PLL
 clock gate timeout and re-enable K1 on Meteor Lake
To: Jacob Keller <jacob.e.keller@intel.com>,
 Dima Ruinskiy <dima.ruinskiy@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev <netdev@vger.kernel.org>
References: <20260417104330.3031987-1-dima.ruinskiy@intel.com>
 <b60a7ab8-dbab-4684-abf4-4dd2a9024f8d@leemhuis.info>
 <56f5f3da-31b8-4847-b274-ce140bf39617@intel.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <56f5f3da-31b8-4847-b274-ce140bf39617@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178048335379.3186764.11506183559720136272@mxe9fb.netcup.net>
X-NC-CID: JGTqWg96wboaZ89YyEfngH5t5ncByslqUufYnU0fpaMFYQz5l6Q=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294711-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:dima.ruinskiy@intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:regressions@lists.linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leemhuis.info:mid,leemhuis.info:from_mime,leemhuis.info:dkim,osuosl.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	DMARC_NA(0.00)[leemhuis.info];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDDFD636B17

On 5/6/26 22:13, Jacob Keller wrote:
> On 5/6/2026 2:59 AM, Thorsten Leemhuis wrote:
>> On 4/17/26 12:43, Dima Ruinskiy wrote:
>>> Commit 3c7bf5af21960 ("e1000e: Introduce private flag to disable K1")
>>> disabled K1 by default on Meteor Lake and newer systems due to packet
>>> loss observed on various platforms. However, disabling K1 caused an
>>> increase in power consumption.
>>>
>>> To mitigate this, reconfigure the PLL clock gate value so that K1 can
>>> remain enabled without incurring the additional power consumption.
>>> Re-enable K1 by default, but keep the private flag to support disabling
>>> it via ethtool. Additionally, introduce a DMI quirk table, so that K1 may
>>> be disabled by default on known problematic systems. Currently, this
>>> includes the Dell Pro 16 Plus, where the issue has been reported to persist
>>> despite the changes to the PLL lock timeout.
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220954
>>> Link: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20250623/048860.html
>>> Link: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260330/054059.html
>>
>> What happened to this fix for a regression first reported in January? It
>> looks like it fell through the cracks. Or was some other solution found?
>>
> There has been a bunch of back and forth discussion and varying versions
> of a fix for this. Its still in the Intel Wired LAN queue, and is
> currently waiting for one the E1000E team to report testing completed.

What's the status? Just wondering, as it looks like this didn't make any
progress, but it's easy to miss things from where I stand.

Ciao, Thorsten


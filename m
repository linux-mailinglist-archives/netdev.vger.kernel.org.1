Return-Path: <netdev+bounces-279198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3z7eODqH4WnbuQAAu9opvQ
	(envelope-from <netdev+bounces-279198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 03:04:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAAD415E87
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 03:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E9F1306DE9C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 01:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C7718DF80;
	Fri, 17 Apr 2026 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFsF5Vjn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE6CBA21;
	Fri, 17 Apr 2026 01:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776387894; cv=none; b=qjcU7m5VtddKgNxj+BBayCbjo5nYGVocjGXQNacYae31v+wPortJH+jKYkjQ5suLdhdh1beZudm3QXXOXxrIRUk6dM3NReusnCdAOU9n0ms7eXnPcVlFryDKelNijXqrx+dbVXKCQ9iXA8BsZn9tCvHur1snHJr0dpfzPVbtNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776387894; c=relaxed/simple;
	bh=uef/MQUFdwKWAzdRkfr82aSqXlQWMKmwRMGsFqVycJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjemQJUxtZDsYHZnw0DGcpbX2ncyio0N0vOtCxDQIlygf/pdgulzSKn1qYtdaNZrK/ovqRg2q15Yj6fqGfrRbQ8/TtZHtXMkoDImgBwQND+yO7oQ4QH5KmFQqvf3rIdEXc2PdbVgke7fe7nlWtahjI7P0MSuOLMijvsQSQJz1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFsF5Vjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBE1C2BCB5;
	Fri, 17 Apr 2026 01:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776387894;
	bh=uef/MQUFdwKWAzdRkfr82aSqXlQWMKmwRMGsFqVycJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AFsF5VjnZpZMwUuZwG42cFUA/ApcxrnvS78EoSawtPVB7vXB5OsYtsPsoUBfsD+LZ
	 4uvvqsFfa2V3CzfrIbE2d8UJs6sfgrhZuRBAMy7COZrKaDpmonM/krI3wBjkPB2zvj
	 zmn/HQwr3IAc7vF+cehDG6tAHms7HikId8JNssgu8i+8Wv6UIxugG8+u3aof/hPWxL
	 I4aOpVHJj1TAS354NCkazF+crkhVATK4607FwT2H/K4cZ69qq5DQsDWS/tWBybL2x1
	 MtSqd3nUy1kvPw8p4/PWTngj2r7iAmATpWRDhYTItdG3iQDqSoca7Mmk4KhMLMGISk
	 r7pinxcjTwhKw==
Date: Thu, 16 Apr 2026 18:04:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "Vecera, Ivan" <ivecera@redhat.com>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "horms@kernel.org" <horms@kernel.org>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>
Subject: Re: [Intel-wired-lan] [PATCH v5 net-next 0/8] dpll/ice: Add TXC
 DPLL type and full TX reference clock control for E825
Message-ID: <20260416180447.1a3c5c87@kernel.org>
In-Reply-To: <IA0PR11MB7378FF7BF4EA32C1F89372C19B232@IA0PR11MB7378.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
	<20260406192312.0f7a2760@kernel.org>
	<IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260409181041.395a0c37@kernel.org>
	<IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260410133812.4cf9b090@kernel.org>
	<IA0PR11MB737882B384AE7279EBCD05C79B242@IA0PR11MB7378.namprd11.prod.outlook.com>
	<20260414145835.07fbe355@kernel.org>
	<IA0PR11MB737842E2098D0952A8BA1FE29B222@IA0PR11MB7378.namprd11.prod.outlook.com>
	<20260416082751.04782987@kernel.org>
	<IA0PR11MB7378FF7BF4EA32C1F89372C19B232@IA0PR11MB7378.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.dev,google.com,vger.kernel.org,gmail.com,davemloft.net,microchip.com,lunn.ch,lists.osuosl.org,kernel.org,intel.com,resnulli.us];
	TAGGED_FROM(0.00)[bounces-279198-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EAAD415E87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 16 Apr 2026 18:26:11 +0000 Kubalewski, Arkadiusz wrote:
> >> This HW doesn't use EEC DPLL signal to feed MAC clock, as DPLL is
> >> external from NIC point of view. Only 2 signals from such external DPLL
> >> device are used by NIC:
> >> - synce (a single source for all those TXC per-port DPLL device)
> >> - time_ref (a source for the TS_PLL - which drives PTP timer)  
> >
> >No bypass? The PLL is actually in the loop? oof, this is beyond
> >my understanding of clocks and signals :S
>
> TBH, I am not entirely sure what do you mean with MAC PLL into bypass
> mode, but the HW description I have provided is still true, the MAC is
> not fed with any DPLL provided signal here. Only port tx clocks PLLs and
> a timer PLL can use those.

The ASIC PLL IPs I managed to find had a bypass mode where the reference
/ input frequency still goes thru the dividers but the PLL circuit is
bypassed. I assumed that if we want to distribute a syntonized clock
across the network we would want as few PLL circuits in the paths as
possible and we'd use bypass (which would be relevant here since for
the target use case we wouldn't engage the PLL of the TXC). But this 
is 100% guesswork so I'm probably speaking gibberish.

> >> Well, 'floating' MUX type pin not connected to any dpll would require a
> >> lot of additional implementations, just to allow source selection, as we
> >> have tried it already.
> >>
> >> Wouldn't more generic name cause a DPLL purpose problem?  
> >
> >The old proposal in netdev family was to to have source selection
> >without creating a real mux. Not saying I'm dead set on that direction.
> 
> Yes, correct, it kept the list of dpll pins valid for source selection of
> tx clock within the netdev and control over it through RT netlink.
> That solution was rather simple but you requested to hack into dpll so we
> did here.
> 
> IMHO this is cleanest and simplest solution we could find to keep it
> within DPLL subsystem.
> 
> >> We still want to make sure that given DPLL device would serve the role
> >> of source selection for particular port where a source pin should be an
> >> output either on EEC dpll or some external signal generator but somehow
> >> related to SyncE or similar solutions.  
> >
> >Right, but adding a new "type" per location of the PLL (especially if
> >we lean into covering any ASIC PLL) may not scale, and opens us up to
> >"vendor X calls it Y" and "in design A clock is fed by pll type X and
> >in design B by type Y".
> 
> I was thinking that this is more like a purpose specific DPLL device, if
> someone would want something similar we would have to review it, right?

We would if it was a Ethernet MAC PLL, but if someone wanted to expose
whether some random PLL in their ASIC locks - are we adding a new type
for each one of those?

> >IIUC you do provide "linking" of the pins? netdev will have the MAC pin
> >assigned. Is the pin that connects the PLLs also annotated so that user
> >knows what's on the "other side"? Maybe the topology would be clear
> >enough from just that, and we don't have to add a TXC type.
> >Call the PLL "integrated" or something generic. User should be able to
> >trace the path of the signals?  
> 
> It depends, TX clock has one of external pins connected to external DPLL,
> but second is a board-level pin with ability to provide some external
> clock signal, the user would have to determine that purpose just based
> on the topology of one of the pins, which seems a bit problematic?
> I.e. if at some point there would be HW with only external non-DPLL
> connected pins?

Not sure I follow, TBH. To me the function of the "MAC PLL" is fairly
obvious from the fact that it has a pin exposed via rtnetlink. So it's
obviously a DPLL which can drive the Tx clock?

It's the function / relation / linking to the EEC DPLL that may not 
be obvious. But user can see how the pins connect they can get some
LLM to draw a diagram of a live system.. et voila :)

> I mean 'generic' type is something we could do, but as already mentioned,
> thought that we want a DPLL types specified/designed for some particular
> functions/tasks. 

I feel like we often get labels wrong the first time around, so if we
can defer adding them until later that'd make me happy..


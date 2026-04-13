Return-Path: <netdev+bounces-278156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPXvIVQt3Wn1aQkAu9opvQ
	(envelope-from <netdev+bounces-278156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:52:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD71A3F1B05
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 400803007F4F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EEC370D4A;
	Mon, 13 Apr 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5kp8GuU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5B36F40D;
	Mon, 13 Apr 2026 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102055; cv=none; b=SPtIiM3/A5jYWKeXCGJ2rdAdlxVPFBf022rPRPiGXmR5r0cfkabPUYTm+ws6CSfHJrh6fEDw7D4iplsf4G4PCyuFt08sC7XW5UNWY5rNYtdM3NDF3pw/iJV+k8gTurq6zaRjc8q2YUVlHZc5mRPzO2ox+xDbmOzemTsLQ6g3s2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102055; c=relaxed/simple;
	bh=0N4BCYvO1+Hekbec44W1YKBqMvRW8D/6DQUbra7OWXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbYfBCa6NSJ5onDcUhRv4YexaPu0btSR7nF+eCgrRY2i3uVsrpMjg0nZ5S43md5/KPbkkGxBrX//Y8wCS7I4V83a45aYI89CIJo2xbN5T5CJhHS3rcUWxfH4EwKHXAAUWSs/IAWTIpMGBk2tADwlyBPTplRIv8dX0LXb+XgT31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5kp8GuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7FDC2BCAF;
	Mon, 13 Apr 2026 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776102055;
	bh=0N4BCYvO1+Hekbec44W1YKBqMvRW8D/6DQUbra7OWXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X5kp8GuU2+Zb0pS0yNLjVoEp8rBKG3Q21yTnrDjIY7ZM2U+9a+hi4HgHm/lMr8UNI
	 vpjDIGFcNffSiLj01LAL6dAQrdQuu9D/ho7gPuGDN9CypsV7Mnp38ZILUsegyf3hzZ
	 D0ItKRXD8uJieku1w25W3QWiuPcur5ly+IqpAgOszAt2q8rubZHwDu+YgOXE63XbRQ
	 Nbx0wDj6GIzmz+69rPLCt3/uXfDKW8v0wtyl8fW81+KEKRGvOQQvwJU0RfJK7qnac9
	 Qfio15bMQbzyGgSERwSEB1LloUuayrwOIagCS3S7sQBrc373RREfluQCgEFDlpimNh
	 0rMQ3+hCW8EMQ==
Date: Mon, 13 Apr 2026 10:40:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "Oros, Petr" <poros@redhat.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
 <Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
 <donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [PATCH v5 net-next 0/8] dpll/ice: Add TXC DPLL type and full TX
 reference clock control for E825
Message-ID: <20260413104048.4ebd7170@kernel.org>
In-Reply-To: <IA0PR11MB737882B384AE7279EBCD05C79B242@IA0PR11MB7378.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
	<20260406192312.0f7a2760@kernel.org>
	<IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260409181041.395a0c37@kernel.org>
	<IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260410133812.4cf9b090@kernel.org>
	<IA0PR11MB737882B384AE7279EBCD05C79B242@IA0PR11MB7378.namprd11.prod.outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-278156-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD71A3F1B05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 08:19:30 +0000 Kubalewski, Arkadiusz wrote:
> >My concern is that I think this is a pretty run of the mill SyncE
> >design. If we need to pretend we have two DPLLs here if we really
> >only have one and a mux - then our APIs are mis-designed :(  
> 
> Well, the true is that we did not anticipated per-port control of the
> TX clock source, as a single DPLL device could drive multiple of such.
> 
> This is not true, that we pretend there is a second PLL - there is a
> PLL on each TX clock, maybe not a full DPLL, but still the loop with
> a control over it's sources is there and it has the same 2 external
> sources + default XO.

Let me dig around and see if I can find any docs for PLL IPs
that get integrated into ASICs. The DPLL subsystem has implicitly
focused on standalone, timing related PLLs. Every ASIC out there 
has a bunch of PLLs to generate the clock signals. It's not clear
to me that DPLL subsystem is the right fit for this. Ping me if
I don't get back to this by the end of the week please. I'll need
to wrap up net-next and send the PR first..

> A mentioned try of adding per port MUX-type pin, just to give some control
> to the user, is where we wanted to simplify things, but in the end the API
> would have to be modified in significant way, various paths related to pin
> registration and keeping correct references, just to make working case
> for the pin_on_pin_register and it's internals. We decided that the burden
> and impact for existing design was to high.
> 
> And that is why the TXC approach emerged, the change of DPLL is minimal,
> The model is still correct from user perspective, SyncE SW controller shall
> anticipate possibility that per-port TXC dpll is there 
> 
> This particular device and driver doesn't implement any EEC-type DPLL
> device, the one could think that we can just change the type here and use
> EEC type instead of new one TXC - since we share pins from external dpll
> driver, which is EEC type, and our DPLL device would have different clock_id
> and module. But, further designs, where a single NIC is having control over
> both a EEC DPLL and ability to control each source per-port this would be
> problematic. At least one NIC Port driver would have to have 2 EEC-type DPLLs
> leaving user with extra confusion.


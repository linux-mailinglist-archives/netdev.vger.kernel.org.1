Return-Path: <netdev+bounces-279081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAJFLAIA4WlIoQAAu9opvQ
	(envelope-from <netdev+bounces-279081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:28:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 863EF410BFE
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A825304D3A8
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBE73C0600;
	Thu, 16 Apr 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="airFqvSl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4AB379EF6;
	Thu, 16 Apr 2026 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353274; cv=none; b=Zzvt2rOgiiSLPRUnsT80IJ2j+pmPFhme1QZ7MDEd6AKgCoRi0or67pJJiWmGgBBgdZRukAXJT6eDZcJ2cS0bxdfolXjD3Ry1MPHNDcXcaKpV/8BZwagrzN6wdP0lV32j8w+zaCkBgJ9pwwF95g8tvw63d3y676fQF40wmX73T6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353274; c=relaxed/simple;
	bh=4fXMUoJoIQeZzLLE5RSP1lM+SSHeh6NAx/GPxmyTz5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMgjBtE45tS+4f7OEM1Wv84h8uP+p1nz6zwa1cQ5WyxlIvzFMI1+ucTuEw9VWxZfSwrF5vne5zkBnBDrRI8iTLEbs1o5Ewgsazx5lBNif2TkKjzBkzy26kbvR0ehfbvXM9mz08Duuz99yhnTFU1tkjTttBRsRA7PufkYVuCFoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=airFqvSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9452C2BCAF;
	Thu, 16 Apr 2026 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776353274;
	bh=4fXMUoJoIQeZzLLE5RSP1lM+SSHeh6NAx/GPxmyTz5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=airFqvSl/cX+SuylumDvltNarwmMKcCR7gnzpXdqvAz7HruwfyZAabP9tJ/2UhdB4
	 8ZxmOwU10ljtDr5RmZFMpQfE2SLanKlNrSbEXmTORcHxgUqSrEqSt8FW80jMUyAcjq
	 v2kDuoX2JL6tKOEBwJBw+Ve45kwSQpz38MCzw7cf0mEqRtacaAD1q+UQ5soky6a7DP
	 WSbkSbFbU25DkaHatTXRMc7TIUweFJFlC53EvBqRMNwOnnGqUe9wzDyi+H+uCB8Aaa
	 +pkUA+mGxXZQ/9ZP1/Fj4PR23T1kwf9F8YzM8fIpBC/yL5iNyHrBygA92dghllAhBW
	 qFQqP8C5Ste6w==
Date: Thu, 16 Apr 2026 08:27:51 -0700
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
Message-ID: <20260416082751.04782987@kernel.org>
In-Reply-To: <IA0PR11MB737842E2098D0952A8BA1FE29B222@IA0PR11MB7378.namprd11.prod.outlook.com>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
	<20260406192312.0f7a2760@kernel.org>
	<IA1PR11MB621925C1718B838147404DC492582@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260409181041.395a0c37@kernel.org>
	<IA1PR11MB62194BF52262FCEB7FD5E76D92592@IA1PR11MB6219.namprd11.prod.outlook.com>
	<20260410133812.4cf9b090@kernel.org>
	<IA0PR11MB737882B384AE7279EBCD05C79B242@IA0PR11MB7378.namprd11.prod.outlook.com>
	<20260414145835.07fbe355@kernel.org>
	<IA0PR11MB737842E2098D0952A8BA1FE29B222@IA0PR11MB7378.namprd11.prod.outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-279081-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 863EF410BFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 13:23:22 +0000 Kubalewski, Arkadiusz wrote:
> >> Well, the true is that we did not anticipated per-port control of the
> >> TX clock source, as a single DPLL device could drive multiple of such.
> >>
> >> This is not true, that we pretend there is a second PLL - there is a
> >> PLL on each TX clock, maybe not a full DPLL, but still the loop with
> >> a control over it's sources is there and it has the same 2 external
> >> sources + default XO.  
> >
> >Don't we put that MAC PLL into bypass mode if we feed a clock from
> >the EEC DPLL?  
> 
> This HW doesn't use EEC DPLL signal to feed MAC clock, as DPLL is
> external from NIC point of view. Only 2 signals from such external DPLL
> device are used by NIC:
> - synce (a single source for all those TXC per-port DPLL device)
> - time_ref (a source for the TS_PLL - which drives PTP timer)

No bypass? The PLL is actually in the loop? oof, this is beyond 
my understanding of clocks and signals :S

> >> A mentioned try of adding per port MUX-type pin, just to give some
> >>control
> >> to the user, is where we wanted to simplify things, but in the end the
> >>API
> >> would have to be modified in significant way, various paths related to
> >>pin
> >> registration and keeping correct references, just to make working case
> >> for the pin_on_pin_register and it's internals. We decided that the
> >>burden
> >> and impact for existing design was to high.
> >>
> >> And that is why the TXC approach emerged, the change of DPLL is minimal,
> >> The model is still correct from user perspective, SyncE SW controller
> >>shall
> >> anticipate possibility that per-port TXC dpll is there  
> >
> >We are starting to push into what was previously the domain of
> >drivers/clk, tho. IIUC the "ASIC PLL"s are usually integrated with
> >clock dividers. And cannot be "configured" after chip init / async
> >reset (which is why I presume you whack a reset in patch 7?).  
> 
> Well, we need CGU-dividers change for a frequency-compliance with lower
> link speeds, the link reset which is required as part of tx-clk switch
> and link establishment on a new clock.
> 
> >  
> >> This particular device and driver doesn't implement any EEC-type DPLL
> >> device, the one could think that we can just change the type here and
> >>use
> >> EEC type instead of new one TXC - since we share pins from external dpll
> >> driver, which is EEC type, and our DPLL device would have different
> >>clock_id
> >> and module. But, further designs, where a single NIC is having control
> >>over
> >> both a EEC DPLL and ability to control each source per-port this would
> >>be
> >> problematic. At least one NIC Port driver would have to have 2 EEC-type
> >>DPLLs
> >> leaving user with extra confusion.  
> >
> >The distinction between TXC and EEC dpll is confusing.
> >I thought EEC one _was_supposed_to_ drive the Tx clock?
> >What PPS means is obvious, what EEC means if not driving Tx clock is
> >unclear to me..
> >  
> 
> Yes, correct, EEC DPLL main task would be to drive TX clocks of NIC
> ports, but if there is a per-port control something extra is required.
> 
> >Let me summarize my concerns - we need to navigate the split between
> >drivers/clk and dpll. We need a distinction on what goes where, because
> >every ASIC has a bunch of PLLs which until now have been controlled by
> >device tree (if at all). If the main question we want to answer is
> >"which clock ref is used to drive internal clock" all we need is a MUX.
> >If we want to make dpll cover also ASIC PLLs for platforms without
> >device tree we need a more generic name than TXC, IMHO.  
> 
> Well, 'floating' MUX type pin not connected to any dpll would require a
> lot of additional implementations, just to allow source selection, as we
> have tried it already.
> 
> Wouldn't more generic name cause a DPLL purpose problem?

The old proposal in netdev family was to to have source selection
without creating a real mux. Not saying I'm dead set on that direction.

> We still want to make sure that given DPLL device would serve the role
> of source selection for particular port where a source pin should be an
> output either on EEC dpll or some external signal generator but somehow
> related to SyncE or similar solutions.

Right, but adding a new "type" per location of the PLL (especially if
we lean into covering any ASIC PLL) may not scale, and opens us up to
"vendor X calls it Y" and "in design A clock is fed by pll type X and
in design B by type Y".

IIUC you do provide "linking" of the pins? netdev will have the MAC pin
assigned. Is the pin that connects the PLLs also annotated so that user
knows what's on the "other side"? Maybe the topology would be clear
enough from just that, and we don't have to add a TXC type.
Call the PLL "integrated" or something generic. User should be able to
trace the path of the signals?


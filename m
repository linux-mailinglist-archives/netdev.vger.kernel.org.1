Return-Path: <netdev+bounces-278584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHAOMqu43mkqHwAAu9opvQ
	(envelope-from <netdev+bounces-278584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 23:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2888E3FEBE4
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 23:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0297A30137A6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C4A388E48;
	Tue, 14 Apr 2026 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaGycWMq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35883388E41;
	Tue, 14 Apr 2026 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203917; cv=none; b=GyvyGRW+0cF/gutbbmp2I9l0mnmzkr5PRG1wDoVyF6GQ6t9/4SVs+G08xeebeOUtqhYKU01QLOBSy2XeUhov7qk2mard1H3FiVIbvDRgW9olL9SFvb1GNZfFLtr7x2/zS/0Eo6iluoD8GyTJ8u7O6lHZUXWhrLRqHqTTG9fF4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203917; c=relaxed/simple;
	bh=eE/A1HY1Is/66jFX3FEuLDx0jM8WPULiynZwxPFdYuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArVJjjUFuDRt+eAId19CYkyBhrpNaSyorJPuvOubZF5To08L43ewIhhAh6e1kZ8e+HrynMKsmoSgBGHoM4DruTUimPLHdoGfRQUbwJqScMCuB7RCHNGQmsbLSivOE77Y26h529jGIVo41fPdFpXbITTgIQF9rwoETk4l4uztjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaGycWMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5FAC19425;
	Tue, 14 Apr 2026 21:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776203917;
	bh=eE/A1HY1Is/66jFX3FEuLDx0jM8WPULiynZwxPFdYuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AaGycWMqF2itECQyxqYFjUFW3dHR6GRwAx0BBqkWWwCe02RFgFaBe1KclsQWMKa6y
	 22FZim7vYwpx8mtvgYbtKC02RUcVaV7DdLzB/h6PDUFa+9SuZoiudP/1INUeO4AhNP
	 XxUDuQI0hdpglQy+RgfZc+BuL+d04pLkwwo6BY38yNdN18r3Di2qAQQAqFZAh6dbpH
	 iMDXLzQdVo0hERNhykRSphEZmx0p7gAo5a3A4iKFyydOnpTxTEEhMrRjmHDYhjQWmu
	 fYrGupJZMCUlUmIT/ai6S4x4IlylDTGaXJNEdRoZ8JfCvqcOSXmG9FkX03uY+3yIYF
	 moV/T4obwB7Mg==
Date: Tue, 14 Apr 2026 14:58:35 -0700
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
Message-ID: <20260414145835.07fbe355@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-278584-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 2888E3FEBE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 08:19:30 +0000 Kubalewski, Arkadiusz wrote:
>> My concern is that I think this is a pretty run of the mill SyncE
>> design. If we need to pretend we have two DPLLs here if we really
>> only have one and a mux - then our APIs are mis-designed :(  
> 
> Well, the true is that we did not anticipated per-port control of the
> TX clock source, as a single DPLL device could drive multiple of such.
> 
> This is not true, that we pretend there is a second PLL - there is a
> PLL on each TX clock, maybe not a full DPLL, but still the loop with
> a control over it's sources is there and it has the same 2 external
> sources + default XO.

Don't we put that MAC PLL into bypass mode if we feed a clock from
the EEC DPLL?

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

We are starting to push into what was previously the domain of
drivers/clk, tho. IIUC the "ASIC PLL"s are usually integrated with
clock dividers. And cannot be "configured" after chip init / async
reset (which is why I presume you whack a reset in patch 7?).

> This particular device and driver doesn't implement any EEC-type DPLL
> device, the one could think that we can just change the type here and use
> EEC type instead of new one TXC - since we share pins from external dpll
> driver, which is EEC type, and our DPLL device would have different clock_id
> and module. But, further designs, where a single NIC is having control over
> both a EEC DPLL and ability to control each source per-port this would be
> problematic. At least one NIC Port driver would have to have 2 EEC-type DPLLs
> leaving user with extra confusion.

The distinction between TXC and EEC dpll is confusing. 
I thought EEC one _was_supposed_to_ drive the Tx clock?
What PPS means is obvious, what EEC means if not driving Tx clock is
unclear to me..

Let me summarize my concerns - we need to navigate the split between
drivers/clk and dpll. We need a distinction on what goes where, because
every ASIC has a bunch of PLLs which until now have been controlled by
device tree (if at all). If the main question we want to answer is
"which clock ref is used to drive internal clock" all we need is a MUX.
If we want to make dpll cover also ASIC PLLs for platforms without
device tree we need a more generic name than TXC, IMHO.


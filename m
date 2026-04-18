Return-Path: <netdev+bounces-279550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I72I9Da42l2LgEAu9opvQ
	(envelope-from <netdev+bounces-279550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 21:26:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E456A42213F
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 21:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46798301C148
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFE8315D58;
	Sat, 18 Apr 2026 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWkCmBh/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53F2571BE;
	Sat, 18 Apr 2026 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776540365; cv=none; b=jhWd7EgpKAF4IFr4wELrrASapR+wYLq2Yu3BKr2ApWAlzWHpIzsRedrLjZDhZvpoxdSvzhE9ZgCwKi0bXgqRdmRitpM4gVskUZ/MrtkI/3pBIC0mJ2fN3O4cr6Aww5DHEZypbQhUEhigJjlf0ev08LxPZNNnD+gQZPZeazOiHTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776540365; c=relaxed/simple;
	bh=N6BBecO9cG16wcouNfFoexu4GIU7PV9h4BUU/bLKA5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWfYcjzmDcwGvocLTc7b8uDEirmMXqwx6qxewCUpvgIOwG+vymvJjsh5nunx4LRjS2SXRWWUFjeTsyErBBmN+4tHiKBxnPz8tIDbj3yNts8QxQtWWfODfXSphEBB5h5FEVLbiwCYLNggI1CEx1qHllbmSNATTj93o6Xfo/smIyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWkCmBh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2B9C2BCB3;
	Sat, 18 Apr 2026 19:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776540365;
	bh=N6BBecO9cG16wcouNfFoexu4GIU7PV9h4BUU/bLKA5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KWkCmBh/IXy2bwCc9rqIyI6Ug+caXS8YQZDDCNwKMhhhrBW2E1knxKyzwKofn5O1Z
	 bn+a6EHUxVpN0fMce1Jzc+gO8dTodl382YbcJHLSk+jgj1w0mW+6CMtzEIvcmBROEH
	 Ok4Xjf5ZWhjEBkIOdRQ/dol+mLmOb3pyX2FAV8pStk0HfgMijO67aMsl8AlVWgUVFJ
	 P4EDoZOfv2Dt9iEG1IX7k1KBN4fKc5HIZc19xVL1qyNiF83OpKkeiLao0YmQmIwYzA
	 JSPzMey2IPJlaGPREjeUBPF0rbnoozB2tcngF95fG+NBKRAh5mogHAHmVZENUfHkye
	 m2+jf2nPmTWhg==
Date: Sat, 18 Apr 2026 12:26:03 -0700
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
Message-ID: <20260418122603.06d12715@kernel.org>
In-Reply-To: <IA0PR11MB7378CF62D86454916AE8F9D79B202@IA0PR11MB7378.namprd11.prod.outlook.com>
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
	<20260416180447.1a3c5c87@kernel.org>
	<IA0PR11MB7378CF62D86454916AE8F9D79B202@IA0PR11MB7378.namprd11.prod.outlook.com>
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
	TAGGED_FROM(0.00)[bounces-279550-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E456A42213F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 17 Apr 2026 12:22:05 +0000 Kubalewski, Arkadiusz wrote:
> >> I was thinking that this is more like a purpose specific DPLL device, if
> >> someone would want something similar we would have to review it, right?  
> >
> >We would if it was a Ethernet MAC PLL, but if someone wanted to expose
> >whether some random PLL in their ASIC locks - are we adding a new type
> >for each one of those?  
> 
> Yes, that was the implicit intention within those patches, if other purpose
> specific PLL would have to be present for whatever HW design and user
> control over it would be required, then that would be the easiest to
> maintain in the long term? Multiple types and each have own function/purpose.
> 
> It would be good as long as there is one PLL for a function per board, once
> there could be multiple ones for single function, we would have to add some
> enumeration (labels, etc.)

Defer on adding identifiers. User knows which driver and bus device
spawned the pll and more importantly what the pin topology is.
Naming in the kernel is rarely a good idea.

> >> It depends, TX clock has one of external pins connected to external
> >> DPLL,
> >> but second is a board-level pin with ability to provide some external
> >> clock signal, the user would have to determine that purpose just based
> >> on the topology of one of the pins, which seems a bit problematic?
> >> I.e. if at some point there would be HW with only external non-DPLL
> >> connected pins?  
> >
> >Not sure I follow, TBH. To me the function of the "MAC PLL" is fairly
> >obvious from the fact that it has a pin exposed via rtnetlink. So it's
> >obviously a DPLL which can drive the Tx clock?
> 
> I am lost a bit now too. You mean clock recovery pin? And EEC type dpll?
> In this solution the 'MAC'/EEC is external and it doesn't drive TX clocks
> directly.

MAC == "tspll" == TXC in this series. On Grzegorz's diagram the new PLL
was in the MAC, which makes sense since it's a pll in the same ASIC as
the MAC.

I'm saying that the function of that pll is obvious since its pin will
plug into the netdev / rtnetlink.

> >It's the function / relation / linking to the EEC DPLL that may not
> >be obvious. But user can see how the pins connect they can get some
> >LLM to draw a diagram of a live system.. et voila :)
> 
> Yes, correct it would work for this particular HW, but adding a variant
> without a external EEC-connected pin in the picture would be problematic
> to understand 'generic' dpll purpose, pointing to the labels later.

The function of the "MAC/tspll" is still obvious. The clarity of the
external PLL is not helped by naming the "MAC/tspll".

> Just to make it clear. I believe that generic type dpll could be used in
> any HW and for any purpose, so after all each such usage could possibly
> introduce entropy and confusion on the user side.
> 
> But if you are fine with that, then sure, we can live with generic
> purpose dpll.

Considering all the imperfect options - generic / unnamed type would be
my preference.


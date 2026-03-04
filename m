Return-Path: <netdev+bounces-263628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECriOMjip2mrlAAAu9opvQ
	(envelope-from <netdev+bounces-263628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:44:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F5A1FBC6C
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA6303084CB7
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFD8371869;
	Wed,  4 Mar 2026 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx6eA5xb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E9035CB7A;
	Wed,  4 Mar 2026 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609985; cv=none; b=Y8vgRQ05j1bwR2VIrS/gQqgq7sBYLUHgigImu2+emv/6LPiuzrFa+0uxbJhE4MINmSmLh+Qe5nnJ+FIau6Z/KL4eOclTueUQRU7c0ML62vEyC5jgkuq95q5MDcRX5RJAi4suPveN0WT2xzIRhRp/FmURep4r2LjJNgJnD7ojDwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609985; c=relaxed/simple;
	bh=qdRtPAje6I7hfutoJeNmqVJEJbOGSUjuE1RqijSch3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tklNOci2Y8x3G0BFODq1xJERUPfNVheygoTQTs1zjg/yfq51L6lQRT/zlD2pPHwEf17V7xxwa4n7QN3toHPyL0onDpE5IAJvoR41dVSQ6LUdDR2Un+4TGgIU51LdZ7/yLBPuStpsDBhnfo/owqnIDgl2owr/QLe+FtUaW+iUipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx6eA5xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE5AC19423;
	Wed,  4 Mar 2026 07:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772609984;
	bh=qdRtPAje6I7hfutoJeNmqVJEJbOGSUjuE1RqijSch3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fx6eA5xbdBXKpUHh3/IErKPDYWgCQMOpGOgNwTTtlboSsMT2zDcFz4NP5doi6f89r
	 wDKDYQeygqdWZ3mckkpNuFdbCfd9ISn/LHbPM9+po9wMN0ke2Sq7okB4Em152CfeS7
	 cHnKusNJdzuRkyL49/kkyPGm0S05gkX52f+CEf8AkGOXVj/UAh7L7oxwfIh2Wjrk0z
	 Uxwt75SSIBzP873g1BaZ1O28zSg88gOejUG65uXc3y0NEGpIfjbh1ee3vw3ipsZ+K4
	 RNckEFqYZcobNZEEh/wYAn7allEHlvCfsipl4IjAMA9/4k7dAre3Z5h+ezsAFDvhaq
	 dolGMc42cY2Dg==
Date: Wed, 4 Mar 2026 08:39:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bo Gan <ganboing@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	lizhi2@eswincomputing.com, devicetree@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, 
	wens@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, linux-riscv@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <20260304-stalwart-raptor-of-cleaning-446b61@quoll>
References: <20260303061525.846-1-lizhi2@eswincomputing.com>
 <20260303061637.872-1-lizhi2@eswincomputing.com>
 <20260303163846.156d18f7@kernel.org>
 <20260304-regulate-verdict-c3a361d2dc83@spud>
 <05a15890-392c-41c3-9566-8eb506ddfe5f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05a15890-392c-41c3-9566-8eb506ddfe5f@gmail.com>
X-Rspamd-Queue-Id: 49F5A1FBC6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263628-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,eswincomputing.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,einfochips.com];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,eswincomputing.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 05:23:18PM -0800, Bo Gan wrote:
> Hi All,
> 
> On 3/3/26 16:47, Conor Dooley wrote:
> > On Tue, Mar 03, 2026 at 04:38:46PM -0800, Jakub Kicinski wrote:
> > > On Tue,  3 Mar 2026 14:16:37 +0800 lizhi2@eswincomputing.com wrote:
> > > > There are currently no in-tree users of the EIC7700 Ethernet driver, so
> > > > these changes are safe.
> > > 
> > > What do you mean by this sentence? The commit under Fixes was part of
> > > Linux v6.19 already.
> > 
> > The "funny" thing is that caring about users doesn't even really matter
> > on the devicetree patch, except for this hunk:
> > |@@ -81,7 +99,9 @@ properties:
> > |                          or external clock selection
> > |           - description: Offset of AXI clock controller Low-Power request
> > |                          register
> > |+          - description: Offset of register controlling TXD delay
> > |           - description: Offset of register controlling TX/RX clock delay
> > |+          - description: Offset of register controlling RXD delay
> > |
> > | required:
> > |   - compatible
> > And it only matters here because an item is injected mid-list. If this
> > was moved to the end with the RXD delay, the **dt-binding** changes
> > don't have issues with safety. I've not looked at whether there are
> > knock-on concerns about users in the driver or whatever yet, but from a
> > binding POV only that hunk can break something that currently works.
> 
> This was already discussed here in v1:
> https://lore.kernel.org/lkml/e7183ae1-8b8b-4e77-9f4e-3bc1b4b63556@lunn.ch/
> 
> The device-tree is not checked in yet by ESWIN folks, so there's currently
> no user of the dt-binding. No need to worry about backward compat.

Of course there is user of this binding, for example ESWIN. Or many
other vendors using it out of tree. You documented ABI.

Best regards,
Krzysztof



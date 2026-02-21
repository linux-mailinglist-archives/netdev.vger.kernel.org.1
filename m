Return-Path: <netdev+bounces-259812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0p7HNQMTmWnhQAMAu9opvQ
	(envelope-from <netdev+bounces-259812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 03:05:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBF216BCA4
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 03:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A11E8300D9CB
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 02:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6330631AA9C;
	Sat, 21 Feb 2026 02:05:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6B8F7D;
	Sat, 21 Feb 2026 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771639550; cv=none; b=pl12vMjzf3IgWDRgSuifkrSjB16QT4cStJBO2FHA/0f1JyGlAUEzsLZhyMdUh2PW13LFDIRCLHNfEF6x5DtkUmvKdbWecZhXJziAQwdAS+zJ/8xiDZNdOPbyqqMLy7eZEt5FPRQStTDHWUlqWKGIdwRY4F2/L3TVBCRFCkdyaWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771639550; c=relaxed/simple;
	bh=/1L0eOLHIcuq+KMQYlBxMwouNHovymbAHhI7qfeT0uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Behb595uC5nAhJPPSCTbJSlZnG9sgbPUdTkzN9WdiKx7DuSe+102LPU1u4tVMKq3HbRXXsmWULEh0HcYFNvcFd/KWS1KuQb+EUrhqqlroa29umunKCUmu4sO4WVAiDdGK7l1CSWJSST7R1OwP+3b4lLiw/WfH1ArvCZqKm/nlWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vtcN8-000000002I0-3Udj;
	Sat, 21 Feb 2026 02:05:30 +0000
Date: Sat, 21 Feb 2026 02:05:27 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] net: dsa: MxL862xx: don't force-enable MAXLINEAR_GPHY
Message-ID: <aZkS585QOq6g7Ax-@makrotopia.org>
References: <20260216105522.2382373-1-arnd@kernel.org>
 <aZMKXavVQPelSXcG@makrotopia.org>
 <306e79fb-f3ee-434e-a90e-547e97d2a5aa@roeck-us.net>
 <c881a13a-0687-4e4d-b70b-900f91acd212@app.fastmail.com>
 <70a195ab-3b61-47fb-a361-17b53cf7bdda@roeck-us.net>
 <aZNEKS-fefEgqhTs@makrotopia.org>
 <316a6ee6-9e5e-4518-8dc4-2f39805934a9@app.fastmail.com>
 <9d7aee5a-ac46-47d9-ac26-0f3a63b6a8ab@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d7aee5a-ac46-47d9-ac26-0f3a63b6a8ab@roeck-us.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259812-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CBF216BCA4
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 05:25:06PM -0800, Guenter Roeck wrote:
> On 2/16/26 08:27, Arnd Bergmann wrote:
> > On Mon, Feb 16, 2026, at 17:22, Daniel Golle wrote:
> > > On Mon, Feb 16, 2026 at 08:20:41AM -0800, Guenter Roeck wrote:
> > > > On 2/16/26 07:34, Arnd Bergmann wrote:
> > > > > On Mon, Feb 16, 2026, at 16:17, Guenter Roeck wrote:
> > > > > > On 2/16/26 04:15, Daniel Golle wrote:
> > > > > > 
> > > > > > Technically, with "select MAXLINEAR_GPHY", NET_DSA_MXL862 should depend
> > > > > > on "depends on HWMON || HWMON=n". That would prevent NET_DSA_MXL862=y
> > > > > > and with it MAXLINEAR_GPHY=y.
> > > > > > 
> > > > > > Maybe it is time to implement dummy functions for hwmon API calls
> > > > > > to avoid all this.
> > 
> > I think I misread this bit earlier, sorry
> > 
> > > > > I had considered this when I found the build failure, but
> > > > > I think removing the 'select' here is much better: this
> > > > > simplifies the dependencies, and allows a valid configuration
> > > > > with hwmon and gphy support in a loadable module that would
> > > > > otherwise be impossible.
> > > > > 
> > > > 
> > > > Makes sense. I think I'll move forward with the dummy functions anyway
> > > > because with that the #ifdefs in drivers are no longer necessary
> > > > and the "depends on HWMON || HWMON=n" becomes optional.
> > > 
> > > Yes, that would be great and eliminate that whole class of obstacles
> > > with some inline no-op stubs in the header.
> > 
> > What I meant above is that I had considered and rejected the extra
> > dependencies in the ethernet driver. I don't think there is a good
> > way to add inline helpers. Technically, one could use IS_REACHABLE()
> > here, to stub out the functions when the caller is built-in, but
> > I find that even worse because it replaces a trivial build-time
> > failure with very subtle runtime bug.
> > 
> 
> Lots of kernel APIs have dummy implementations. hwmon isn't really that
> different to those. Also, arguably, that would not be a subtle runtime
> bug but a feature.
> 
> In this context:
> 
> If NET_DSA_MXL862 is enabled but MAXLINEAR_GPHY isn't, does the system
> still work ?

The switches supported by NET_DSA_MXL862 come with 5 or 8 twistedpair
ports provided by built-in PHYs. For the ports to (fully) work the
MAXLINEAR_GPHY driver is required, as without it they would be detected
as "Generic PHY".

This is similar to the situation on other DSA switches, and there is
apparently no clear rule whether this (runtime) dependency should be
treated as depedency in Kconfig which is typically used only to express
linking dependencies.


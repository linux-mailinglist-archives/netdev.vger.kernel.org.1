Return-Path: <netdev+bounces-258924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNI7J1pFk2lx3AEAu9opvQ
	(envelope-from <netdev+bounces-258924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:27:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0250E146268
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89823300BD8C
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD90330B36;
	Mon, 16 Feb 2026 16:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F96312821;
	Mon, 16 Feb 2026 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258934; cv=none; b=HweE77RCptiVVbGd3d495L9NC9+5OzQdHupQg/IhNelETh6F71ououVIBKNdzTK5wvSPWyTePGi4ZBZOC84FfEyctLw3jcjAVFCnojPOaHBdGZvqsg2rFpqb1QpV04b2gIIltfgRgcnGcOLfz4m2VPhk/aJ5OXoNa16wJu5O8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258934; c=relaxed/simple;
	bh=wvqDLZFvY1On6e8TFnSfctct62+0IJvImXxLPolTnCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsyODaKAgIumvzaCLaolArFKlqEY89gwWDTVrgDpQl/KzN5Z2E+P9Jk4mK9EBvLXPAmes5zNq7l45oE9NlFjhRJ5KUt66XieSKH0xOqcWOuZwFWl6tcP0vFXcDkCPPLBVEq05jXt55g/HGhudpKWOzf9zt+S05YU30AMu9yqsBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vs1ML-000000001G9-12jr;
	Mon, 16 Feb 2026 16:22:05 +0000
Date: Mon, 16 Feb 2026 16:22:01 +0000
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
Message-ID: <aZNEKS-fefEgqhTs@makrotopia.org>
References: <20260216105522.2382373-1-arnd@kernel.org>
 <aZMKXavVQPelSXcG@makrotopia.org>
 <306e79fb-f3ee-434e-a90e-547e97d2a5aa@roeck-us.net>
 <c881a13a-0687-4e4d-b70b-900f91acd212@app.fastmail.com>
 <70a195ab-3b61-47fb-a361-17b53cf7bdda@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70a195ab-3b61-47fb-a361-17b53cf7bdda@roeck-us.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-258924-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0250E146268
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 08:20:41AM -0800, Guenter Roeck wrote:
> On 2/16/26 07:34, Arnd Bergmann wrote:
> > On Mon, Feb 16, 2026, at 16:17, Guenter Roeck wrote:
> > > On 2/16/26 04:15, Daniel Golle wrote:
> > > 
> > > Technically, with "select MAXLINEAR_GPHY", NET_DSA_MXL862 should depend
> > > on "depends on HWMON || HWMON=n". That would prevent NET_DSA_MXL862=y
> > > and with it MAXLINEAR_GPHY=y.
> > > 
> > > Maybe it is time to implement dummy functions for hwmon API calls
> > > to avoid all this.
> > 
> > I had considered this when I found the build failure, but
> > I think removing the 'select' here is much better: this
> > simplifies the dependencies, and allows a valid configuration
> > with hwmon and gphy support in a loadable module that would
> > otherwise be impossible.
> > 
> 
> Makes sense. I think I'll move forward with the dummy functions anyway
> because with that the #ifdefs in drivers are no longer necessary
> and the "depends on HWMON || HWMON=n" becomes optional.

Yes, that would be great and eliminate that whole class of obstacles
with some inline no-op stubs in the header.


Return-Path: <netdev+bounces-269349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA6rI1ivu2ljmgIAu9opvQ
	(envelope-from <netdev+bounces-269349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:10:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 956D72C7AE1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C13B3301072F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A743A783C;
	Thu, 19 Mar 2026 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="zrlJ1VvD"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2028623EAB3;
	Thu, 19 Mar 2026 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773907794; cv=none; b=jCQFD1V5cZ//ovgk+be3gNy6Z/GKTg0AulPQIjXw8zH9ZeMKXKfzMIyLwZmv9BuwtzvePDxJbUH/vcOsr3LU5yAjxMrXV2rEKnTzsxyeNavB/1vy+PRWSEk0zG8NpPDjuBjuLNEociG5Z5J5Y5NadUy2FRuceX+PUX2gtzLgu/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773907794; c=relaxed/simple;
	bh=/eoynW+sJF2PZIxRo6AnYTGNfHvzdyYKKp2Ao3jzLcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FepU4Dd3k19n+6uh3UoKljhnXZh4UiFocLzbLt3BvqkFzWhLRzmgT9dMDgZYBoTEx55BizHf28v0VyyXYibgWt1W2I00vZSdFIZtChbaO5cOBC08uybu0ukkTFFY6RFMmBI2NSe7BEWHzFwkECfBCz56IGS5LPH0uNQOJ3BE3gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=zrlJ1VvD; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6D2581F940;
	Thu, 19 Mar 2026 09:09:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1773907790;
	bh=dJ9657zYwrukRzdvCzFf1VnhYPLd6Qfy7rR+2FHT8ck=; h=From:To:Subject;
	b=zrlJ1VvDSl/dduMYyCDLgrB7+m47+yT9EQy2Z/dfvbJiPRQ+4UowtlKFZ/2yZiJa5
	 mCg78FxTuaxcyPnIothacTLB5C04LPofi+mdhywb/uuAWlbl+V+wbV0MIwKZP/6nE6
	 2PA1I2fCfn8nvARH3MO9jO5UCQSnxTmGHPkj6seqRMqJxGXxni78Pt1a3fobRbKnQg
	 KOVB16Fauyszexxxrp675EKp/DfyhS1kioD/7RgeRVzUSeoZS6HKyEe8OYTuVfBitj
	 D0Sbdj9ykSFlz3M6oRepiEXNSUb4aQZVZB3xPQviKtg+mUoul+oYRm5RxJumDaaTvk
	 rWYi1dnJSxvJQ==
Date: Thu, 19 Mar 2026 09:09:46 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	=?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	Frank Li <Frank.Li@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Message-ID: <20260319080946.GA6892@francesco-nb>
References: <e2518c8f932fd9da6754b5ab5cc892ed58a0c1db.1773849293.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2518c8f932fd9da6754b5ab5cc892ed58a0c1db.1773849293.git.buday.csaba@prolan.hu>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269349-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,prolan.hu,toradex.com,lists.linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dolcini.it:dkim]
X-Rspamd-Queue-Id: 956D72C7AE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 04:56:15PM +0100, Buday Csaba wrote:
> The PPS channel selection was incorrectly implemented in the orginal
> commit (see fixes). The sysfs interface uses a logical channel index,
> and rejects channel numbers greater than zero (n_per_out is 1).
> See: period_store() in drivers/ptp/ptp_sysfs.c
> 
> On the other hand, the FEC PTP driver was expecting the hardware
> channel number, making the periodic output unusable from the sysfs
> interface, with the exception of channel 0.
> 
> Fix the FEC PTP driver to match the logical channel number of the
> sysfs interface.
> 
> Fixes: bf8ca67e2167 ("net: fec: refactor PPS channel configuration")

The commit you mention as fixes, it was just a refactor. The behavior
before/after that commit was supposed to be the same.

That commit never implemented "PPS channel selection", as you wrongly
state here.

Francesco



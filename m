Return-Path: <netdev+bounces-291964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBmMJzkgFmp/hwcAu9opvQ
	(envelope-from <netdev+bounces-291964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:35:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2225DD384
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5AAA302E0CB
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83B83C583B;
	Tue, 26 May 2026 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv3hJ1HF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74A3A8730;
	Tue, 26 May 2026 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779834934; cv=none; b=UvF1AJcdD3wVu296UwDz1fFf5uzvm9g+NO7PlWpgU00vfHSLcoultGvxCcKhfqWCd+odg9rsgUqAYi1F4L9l4tVvcGosnGKAbLW4T5nXX/stepOTCoZ6cikj3jY7zN0ORz0gmF9KxNOIFWHKlWzBrbd04QeC7DsWHplGyw+5ikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779834934; c=relaxed/simple;
	bh=aFkL6P7F55JAmBj2/k/48cfMzu+PjW0K9b9VVAYu3KE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idcB+b/Wlw7TvpZlD6UtEf5AqfSpjXAsszvAa+olA836h9uaBIMr1+4KOgkLZOT6F94m/bRDXCZqGyo/fpIdGPMkpy0WjMVy1QTe3lSMAZc4FnRaFfps48su0KYBOSifh777VuqKd+aeNjyAFt4Vqzcfa1K5rtuHyPN8f16UUiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv3hJ1HF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFCF1F000E9;
	Tue, 26 May 2026 22:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779834933;
	bh=NbleJdTCwKs5WoryYxaNmlGpyfGAhKVE5VL3jARcpFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rv3hJ1HFd+aYHvPfkEGfJrsaeXoukMH/cV65Hr4wleI21YGRR3t/4j+Efenv8m5TM
	 z+oOQsUDimGWsY2tTrWuMDno0gVVhfisfDT77Zqtp+sO21Yv9raxWZW1J9q96/0L6+
	 bJpi2Binpy4NVokXl6FYyrN+j15k8vphTYS99Y2s9AwbBAY22XjWhUu8ieJbt+Xs8L
	 7N+setAOQoWZNEovazZKDnQ697gkPP4v1g7sRdC16btdM0GnnTRhjRcSjPpkuBhRaf
	 r0XlqJP39kDZRwWwMmZ5ny+wLnPV810VqY8mEQE8UKxykWBhaF7FrI3JAkQdzp1PrH
	 qSlVi/IO5HQHw==
Date: Tue, 26 May 2026 15:35:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 vladimir.oltean@nxp.com, willemb@google.com, sdf.kernel@gmail.com,
 ecree.xilinx@gmail.com, jesse.brandeburg@intel.com,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 06/10] docs: net: refresh netdev feature
 guidance
Message-ID: <20260526153532.7979b43c@kernel.org>
In-Reply-To: <422219d6-8377-423c-8ccd-641b2fccaa1a@bootlin.com>
References: <20260526160151.2793354-1-kuba@kernel.org>
	<20260526160151.2793354-7-kuba@kernel.org>
	<422219d6-8377-423c-8ccd-641b2fccaa1a@bootlin.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291964-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0E2225DD384
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 20:41:10 +0200 Maxime Chevallier wrote:
> >   
> >    1. netdev->hw_features set contains features whose state may possibly
> >       be changed (enabled or disabled) for a particular device by user's
> > -    request.  This set should be initialized in ndo_init callback and not
> > -    changed later.
> > +    request.  Drivers normally initialize this set before registration or
> > +    in the ndo_init callback. Changes after registration should be made
> > +    very carefully as other parts of the code may assume hw_features are
> > +    static. At the very least changes must be made under rtnl_lock and
> > +    the netdev instance lock, and followed by netdev_update_features().  
> Feel free to keep this description as-is, but can we get somewhere the
> actual meaning of "hw" in "hw_features" ? I've seen this cause confusion
> before as this is sometimes wrongly interpreted as "Hardware features",
> which isn't correct as the hardware may do stuff without allowing users
> to change that behaviour.
> 
> I vaguely recall something along the lines of "Host-Writeable features",
> but I am not sure at all about that...

Hm. I assumed the hw in hw_features stands for hardware.
The magic behavior of host controllable vs hardwired was
probably added later without renaming the field.

As you indicate the usual confusion is that it's legal to have 
a feature in ->features which is not set in ->hw_features which 
means that features is hardwired "on", it can't be disabled by
the user.

The current text does say this: "features whose state may [..]
be changed [..] by user's request". But perhaps it's not emphatic
enough.

Main question is whether this series should be clarifying
this or our criteria is that the series doesn't _add_ confusion,
even if it doesn't clarify all the potential confusion points? :)


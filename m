Return-Path: <netdev+bounces-300151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qSSwMSGMMmpy1wUAu9opvQ
	(envelope-from <netdev+bounces-300151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:59:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AFA69964F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:59:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SRueWrjP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300151-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300151-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 602EB30E48D8
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BDA3E92AF;
	Wed, 17 Jun 2026 11:40:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D8367284;
	Wed, 17 Jun 2026 11:40:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696431; cv=none; b=FFBzXZ5phF6OwDOHfixB9nqAfyFssdZoch5Fjm16mnzVgVyhZRAIVOEasd2fhWHhsMxV5aoHMBh7sBpc/GAeZ0dYkh+lrb8iwT1h5EA6MA4yuI3DohJnSy7zVyOMb/yhKGl+MNefwl7cgWciz0r9tOo1NK8xpwufREcDI2zJgiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696431; c=relaxed/simple;
	bh=1IzuiLCpgVRzDiaaTNKjsTHwmM0Wz/vmapGdB9UF+cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQFKcKFG0DIteGedfUsrqV5amJfIUPvu1HERvLmbcvE6PpGhlea77qNc0DIN5Tx7W4mx8pln3qdYybDIRivfnbm6djUlu994XNMclSfyKjrvG8Skf+wAAtJvqZgDnCJio8Mxm2Rv9dECGvcxpyH3A0+mFFH11X25Oyl5IkpWtA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRueWrjP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B363E1F000E9;
	Wed, 17 Jun 2026 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781696430;
	bh=NDUXhknvkX+D31MgIY8BSQWwYVKJ7dn/MYNRb8Qxhp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SRueWrjPO+bv6Me59Q/y6ggB25gVmPSMXA5+YsVrhDa67961Rs+x7ABSfblBbaEDm
	 AotjIBISkaCAwChMKHpqUNkyVfsNyko7MeMECbLycRPFri/cVlSf1fCDRpUTfACiJY
	 aUyC9w6hHG9jPM18YbnfxxLLq1hl7My+FPWnGoexL6faH3K7HHh5+CGsF8EZmKptXD
	 pePJBmwEOqw9hmuvogxWPe/WvRgdObP7Zxyhf/N7cMpP0zwMryObOGQf6H4g3QaVp5
	 oyzgrm7r3e6acOLlQUPMryyWbQmwc0fqH6K9olt/KhZSMLeGg+lDE2NPfwh7ID0PBW
	 V2L+QaDh1Vdow==
Date: Wed, 17 Jun 2026 14:40:24 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	johannes@sipsolutions.net, corbet@lwn.net,
	skhan@linuxfoundation.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: exclude driver and netdevsim bugs
Message-ID: <20260617114024.GW327369@unreal>
References: <20260603162943.2406080-1-kuba@kernel.org>
 <20260615091436.GP327369@unreal>
 <20260615091909.78ad2b03@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615091909.78ad2b03@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:johannes@sipsolutions.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:workflows@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300151-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35AFA69964F

On Mon, Jun 15, 2026 at 09:19:09AM -0700, Jakub Kicinski wrote:
> On Mon, 15 Jun 2026 12:14:36 +0300 Leon Romanovsky wrote:
> > > +Unless explicitly excluded all bug fixes should be targeting the ``net``
> > > +tree and contain an appropriate Fixes tag.
> > > +
> > > +Obvious exclusions:
> > > +
> > > + - fixes for bugs which only exist in ``net-next`` should target ``net-next``
> > > +   (please still include the Fixes tag in the commit message)
> > > + - bugs which cannot be reached, e.g. in code paths not executed given
> > > +   current in-tree callers
> > > + - fixes for compiler warnings and typos  
> > 
> > If you decide to resubmit this patch, could you please remove "fixes for
> > compiler warnings" from the exclusion list?
> > 
> > It is quite frustrating to receive a compiler warning originating from a
> > different subsystem after the merge window, knowing it will not be
> > addressed until the next merge window (around eight weeks later).
> 
> Agreed, FWIW, but not planning to resubmit.
> I think people misunderstood that I'm __documenting what I already do__
> rather than trying to have a discussion :/

I'm pretty sure that people aren't aware of it.

Thanks


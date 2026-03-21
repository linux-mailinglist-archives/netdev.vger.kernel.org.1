Return-Path: <netdev+bounces-270188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LqeqGYdhvml4OAMAu9opvQ
	(envelope-from <netdev+bounces-270188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:14:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97302E4525
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EF29301DEC7
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 09:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C447320A37;
	Sat, 21 Mar 2026 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoE6RpPA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AEC26B2D3
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774084484; cv=none; b=j3BvzELgg1O2wH2JNX1ANxyXhZg+HbQ+gpgBsKP3pP9esoeaXiUZ7JqqSDQ3QtcAyCPPdTGaRvDg1KFz16vaW+zM8Y9eGj1nDPyjiEvfaBjtohR9eqvZw3YQNbWwCdqxNgVU77zvqsajGRwTITJ32/y1hCNfbJ9wnhM7Vx4luJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774084484; c=relaxed/simple;
	bh=UqZ8VzmgWhDv/uupfpMd/3DUo+HUmBI1g+qwzL27+nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGsqklFImr1o/88dJKI8l6ZaUlnOUoX2j8Ut66i+nV94aQDINPyfitbCy97Bw9tPvd7/Cq0zJlmL9A/nIrus0X1OvV/Fo/XCqTnhVf7ER4+rJ2ZzTf+36DFZwhx5SahbiqsIhni8GHrVeen6oWdT1zwQHys/YAgTSRjblphD+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoE6RpPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9C8C19421;
	Sat, 21 Mar 2026 09:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774084483;
	bh=UqZ8VzmgWhDv/uupfpMd/3DUo+HUmBI1g+qwzL27+nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoE6RpPAmMfSwff//GVuT4xxO4zDe+we7wWo0alVhkWaUW76yYIIvsjXu+JGKIjhv
	 hTKuRZVoAPKKby9WuZ1TD2k3BDmFUksn03bzNSsdAyGSA4gWRmwyN14zfDB+dR+HkB
	 HJr4sUHj2LBj5U8t6IB2Nz3H6JfRzjj8hFLxw5WW9xi/+0nrJDbVTUeBJxxjM58jes
	 EZeDbWMayf/Iw7NW83lWqCYvIKKgXEv+RHffQ0GrVhYWLKpbXfGCda1Fm/XEzrQFhX
	 WcIhIGevNDIp2t9R9mBFecyIoHLkk+iESn1BBTlMypHLcPMq8DGnmrw7eJ764w/pH/
	 RntjBm9rJqnqw==
Date: Sat, 21 Mar 2026 09:14:40 +0000
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Wieczerzycka, Katarzyna" <katarzyna.wieczerzycka@intel.com>
Subject: Re: [PATCH] ice: add missing reset of the mac header
Message-ID: <20260321091440.GR74886@horms.kernel.org>
References: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
 <20260320180410.GA151863@horms.kernel.org>
 <IA3PR11MB8986779AEBF981B6AF66F3D8E54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986779AEBF981B6AF66F3D8E54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270188-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,horms.kernel.org:mid,osuosl.org:email]
X-Rspamd-Queue-Id: C97302E4525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 07:53:28PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Friday, March 20, 2026 7:05 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Wieczerzycka,
> > Katarzyna <katarzyna.wieczerzycka@intel.com>
> > Subject: Re: [PATCH] ice: add missing reset of the mac header
> > 
> > On Fri, Mar 20, 2026 at 06:05:18AM +0100, Aleksandr Loktionov wrote:
> > > From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> > >
> > > By default skb->mac_header is not set, so reset prevents access to
> > an
> > > invalid pointer.
> > >
> > > Call skb_reset_mac_header() before accessing the mac header from
> > skb.
> > >
> > > Signed-off-by: Katarzyna Wieczerzycka
> > > <katarzyna.wieczerzycka@intel.com>
> > > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > 
> > Hi Katarzyna and Aleksandr,
> > 
> > I am curious:
> > 
> > Is this a bug? If so then it should probably have a fixes tag and a
> > bit more of a description around how this can happen.
> > 
> > If it is not a bug, then is this defensive? And if so, is it really
> > necessary?
> > 
> > ...
> 
> 
> Good day, Simon
> 
> I'm upstreaming Katarzyna's fix.
> 
> From my point of view, it's not just defensive code, but real bug even on latest kernel because the gap is partially closed by packet_parse_headers(), but not completely.
> Sorry the patch header is malformed, I definitely need to add 
> Fixes: f9f83202b726 ("ice: Allow all LLDP packets from PF to Tx")

Hi Aleksandr,

I can see you have been busy.

I agree adding a Fixes tag makes sense.  If you could also expand the patch
description that would be well appreciated (at least by me).

> But not sure whether to send to net, because on modern kernels I have no real call traces only theoretical conclusion.

That is a line call in my opinion.

If you include a Fixes tag, which seems sensible, then the chances are the
patch will end up being backported to stable. And if the patch is in
net-next it might not have hit Linus's tree before that happens. Which
doesn't seem ideal. So I think it would be more sensible to target the
patch at net to avoid that problem. But that's just my feeling.

Either way, please consider adding a note regarding this.
So it will be more obvious.


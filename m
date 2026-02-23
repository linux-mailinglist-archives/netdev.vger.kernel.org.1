Return-Path: <netdev+bounces-260062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJjoNuFqnGmcGAQAu9opvQ
	(envelope-from <netdev+bounces-260062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:57:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F162178518
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A44E30B0195
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68812609FD;
	Mon, 23 Feb 2026 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZtEg2LQn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23D92566E9;
	Mon, 23 Feb 2026 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858521; cv=none; b=PaYW3SAuoyxN9YO8OoI5yIP3pXGY4WsMyc2CROAIq7v2yx5I/aUmuyrtzvk6prvWL3RAFk3BJI3wWjmpNQ6pAy97BVcQaY19z3XLDI+GIsD1c4QvLD1PNu/iNzYNYLfoOJPD+CvP1uwyonP5keerrsAPuoKU4zfsPmlGQn1F97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858521; c=relaxed/simple;
	bh=5jq3lFicRtvgdrdrx4nTVDUTSi21O3Z2bTVIiBTF/CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWC0vsRFi2FqHV1ie4zRa3cLAlSr26Y0O+Cj0f7b6ZjUGxAmKoijuA4pe0+0j4SZW0xyaUF3OF6b/uvPvY+mA9ts0f8TSM4zw132JGbifZcaiHrpOeV/evwcKCIsar2mN1OcifU5iBdiagy5ICO1/W3gtW3Ol+MYSL8Zoa3pyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZtEg2LQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C71CC19423;
	Mon, 23 Feb 2026 14:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771858521;
	bh=5jq3lFicRtvgdrdrx4nTVDUTSi21O3Z2bTVIiBTF/CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZtEg2LQn3jV5g6whRG6RhF48foeAFWPPnaMNef55e9us6a10Bi4IReEV+1jL8hWWC
	 1w85kbUizcNRln1Q5JJRYm4bmKyL2wbsJKxi6VReNAjwAoIlAaClGgWH6iP8xaZdgs
	 tuHJZidS45heLQMhKbbfPfUY5SA+nulCCNoZDXds=
Date: Mon, 23 Feb 2026 15:54:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Petko Manolov <petkan@nucleusys.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] net: usb: pegasus: validate USB endpoints
Message-ID: <2026022352-dried-sputter-eba9@gregkh>
References: <2026022347-legibly-attest-cc5c@gregkh>
 <acc166b4-9ce7-4e95-8f2f-4300ee6dd27e@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acc166b4-9ce7-4e95-8f2f-4300ee6dd27e@rowland.harvard.edu>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260062-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nucleusys.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F162178518
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 09:39:52AM -0500, Alan Stern wrote:
> On Mon, Feb 23, 2026 at 01:58:48PM +0100, Greg Kroah-Hartman wrote:
> > The pegasus driver should validate that the device it is probing has the
> > proper number and types of USB endpoints it is expecting before it binds
> > to it.  If a malicious device were to not have the same urbs the driver
> > will crash later on when it blindly accesses these endpoints.
> > 
> > Cc: Petko Manolov <petkan@nucleusys.com>
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> 
> This does much the same thing as
> 
> https://lore.kernel.org/linux-usb/20260222050633.410165-1-n7l8m4@u.northwestern.edu/T/#u
> 
> and that patch also removes some magic numbers.

Yes it does, that's a much nicer patch than mine.

> BTW, what is gkh_clanker_2000?

A hacked up system of tools/scripts I'm running here to find stuff like
"take this previously applied commit that fixed a problem, does the same
pattern need to be also done anywhere else in the tree"?  It finds a lot
of stuff and then I sift through it and see if anything is actually real
or not and if so, make up a patch for it.  It was my "merge window is
giving me a respite from reviewing patches" hobby project this past
week.

Now if I was really good, I could turn the output into a coccinelle
script, as this is just simple patterns.

Also it seems that we aren't running the coccinelle scripts anymore, as
many things it has found are already covered by that, I wonder why that
is...

thanks,

greg k-h


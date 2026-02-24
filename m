Return-Path: <netdev+bounces-260476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AkGHaiMnWn5QQQAu9opvQ
	(envelope-from <netdev+bounces-260476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:34:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7206186582
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E6FAD304E723
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C42337C10F;
	Tue, 24 Feb 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDh5Dx0E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1937C108
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932593; cv=none; b=TKsLjDjn7i44simZRA2K5IPE5wvBJI0e6RfqyCJHZ52e3cbvw2DAzkId9XjaziXbK13CFrJQEro+nidv6S84RHU0ndhgSSFjyVAUeeRLrs/qau1r+7aFDqxF2kB1Rx2kyuYqdWNbgAJ0fOZi8n838WToFUVJV9HfKcWYT9X4pWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932593; c=relaxed/simple;
	bh=qae+KiV0H06twWryyZRy7nDOgPhLMz/Ho0BGykyklJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq2y6ppHYp5zcTirD9BrEDQTmb18mNAHwViOfEg+hq5fvRUL0yMzprIsQPDIKKY2sLsNmCj1cQOsa9nxjS6h23aRRdt59yzsxekUTWdN8oQTzsocuC/ENSaV/BAlCEvhCLSjDPC8RUnCn/5/ljTIkT7fku2Cri9OwLffRGKywoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDh5Dx0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736CBC116D0;
	Tue, 24 Feb 2026 11:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771932592;
	bh=qae+KiV0H06twWryyZRy7nDOgPhLMz/Ho0BGykyklJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDh5Dx0EpWIZ64bcRaZ27qvAnJXequ/LMJZm4dN0Hcri0QTx6R3nsCe/hglXvzRlr
	 WsV9QiFJFmNxwfDwP+P9MdJWbU/RbK+hH2+Ajz+kDBw5bG1foZM5utHkfNHuIdEzYZ
	 j1hxzKVTMDL19wu+McDjN2CYQ7kIPaf9m2E+UDGxMj6e1fcWAMkfNFBu6kqG0QKInx
	 u2mOO18OtXEeSGxB2iFubpjCXq4Sf1Epo+TT75cKEoVtuInl1p6SJqZJv5aeFuTlCz
	 QI5xiYYfC3bo/CXqbw/m+pJrOJohUKOS8BVi6dS3dGbypYKAfAjFi9hrKN/ZUDuX5r
	 EiSqkp9FOe2aw==
Date: Tue, 24 Feb 2026 11:29:48 +0000
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: ptp: limit n_per_out
Message-ID: <aZ2LrDLPTR61TfQP@horms.kernel.org>
References: <E1vuUvf-0000000AfhS-0lJR@rmk-PC.armlinux.org.uk>
 <aZ1uxX_fddwO7UYD@horms.kernel.org>
 <aZ13Gjav_5PYNGEN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ13Gjav_5PYNGEN@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260476-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7206186582
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:02:02AM +0000, Russell King (Oracle) wrote:
> On Tue, Feb 24, 2026 at 09:26:29AM +0000, Simon Horman wrote:
> > On Mon, Feb 23, 2026 at 12:20:47PM +0000, Russell King (Oracle) wrote:

...

> > > This could be a user exploitable bug (although one has to be root
> > > so the gun is already pointing at one's foot.) This is the commit
> > > which introduced the problem:
> > 
> > Hi Russell,
> > 
> > From the description I assumed that for this problem to manifest
> > out-of-range values would need to be turned by hardware.
> > But maybe I misunderstand things.
> > 
> > Could you elaborate on the vector you have in mind?

...

> Either code should care about values > 4, or it shouldn't. The current
> code cares about it in one place but then ignores it in all other
> places where the index is under userspace control, allowing the
> potential for array overrun.

Hi Russell,

Thanks for the clarification.

Personally I think it would be best if the Kernel took a robust approach
and assumed that hw may provide out of range values. But in my experience
this is generally not the approach taken by drivers. And it's not a hill I
which to spend too much time occupying.

IOW, I don't think the current practice is to treat such cases as bugs.

On the other hand, I agree that the code should be consistent.
And I would lean towards verifying rather than not, although again,
I don't think that one can find plenty of cases where the Kernel
doesn't do that.

Which is to say that I agree with the approach taken by your patch.
But I lean towards it not being a fix.

Reviewed-by: Simon Horman <horms@kernel.org>



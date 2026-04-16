Return-Path: <netdev+bounces-279160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHIIMJdD4WlErAAAu9opvQ
	(envelope-from <netdev+bounces-279160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:16:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB130414847
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B84C3016D0E
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD7723E325;
	Thu, 16 Apr 2026 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pK43roZi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6538C429
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370577; cv=none; b=s70JhSRRGA53NtC99071QM1CbM7tRQscdFWGCBK2T5zAyZ2s0FDxhdEC9kN0RK9XMH+6Q8AHPKMHRB6K1F4whzTmiqNbs5RpQ6iY8okokUk+ZqHt77d8lRjjXI5Rct8fm4UNQOvr5V7EEkjvjpKjbCb6482mEvbSjT2sC3t7vE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370577; c=relaxed/simple;
	bh=R/+DzOdGIK0mO9G5ivghTZXgfvc47/DKlFbEl1raOVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XS9OEonOLD9Is3L5a+XztDLBmiLiFpQ0zMhXd8uydyJ59AvL17fWLFOAtwxDIjtYWsnj1sAFOpOH3MsZ2Fky/68WmZpkU5/R1dP+yPZX7YIqXwWm4W7PlsgeHBflPgSAa6aHCgChHOoMgJVPubxzoDQTtcn8YnOX5hgKpbfskTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pK43roZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FA1C2BCAF;
	Thu, 16 Apr 2026 20:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776370576;
	bh=R/+DzOdGIK0mO9G5ivghTZXgfvc47/DKlFbEl1raOVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pK43roZiQcqiQnjSJT7dagBUZfApCSNmUvHNa9llT8HcqXlgYEzYyd27qrRJrPD7X
	 GXXLXxW+1p7EiiEFBTUCM1p/1lcQrFPDjrJJ35VNM7jh6Y/fk1dgcmGPYMMMAu/FLA
	 szCyku3OH1MpQZrV7jsY1vacIUOavd1rD71L8pqSOCnztWZI5BSfn+4xdkXBsEonrk
	 1p038auIwS7gTKSHpjKTfERlvzpuB5+vyATcjVIJXo81z8ygfL5+eRsi7L38eYixwz
	 Ue03sIH+igCURCBehG83I9Qrp3CHojxZexJ2XgXeVZH838Vm7r4BVgtM00nEVXJBG9
	 4CDX3fZdXcGtQ==
Date: Thu, 16 Apr 2026 13:16:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/6] net: stmmac: move PHY handling out of
 __stmmac_open()/release()
Message-ID: <20260416131610.1bf3bce2@kernel.org>
In-Reply-To: <aeE8mpXy9FRHvN9q@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
	<5987484.DvuYhMxLoT@steina-w>
	<aeC-tc2CooYDoBok@shell.armlinux.org.uk>
	<2410317.ElGaqSPkdT@steina-w>
	<aeDSTIS9-TDSihbX@shell.armlinux.org.uk>
	<aeDojTdDTELfpT0X@shell.armlinux.org.uk>
	<20260416090826.1c5ca018@kernel.org>
	<aeE8mpXy9FRHvN9q@shell.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279160-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[ew.tq-group.com,lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BB130414847
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 16 Apr 2026 20:46:34 +0100 Russell King (Oracle) wrote:
> On Thu, Apr 16, 2026 at 09:08:26AM -0700, Jakub Kicinski wrote:
> > On Thu, 16 Apr 2026 14:47:57 +0100 Russell King (Oracle) wrote:  
> > > The next problem will be netdev's policy over reviews vs patches
> > > balance which I'm already in deficit, and I have *NO* *TIME*
> > > what so ever to review patches - let alone propose patches to
> > > fix people's problems.
> > > 
> > > So I'm going to say this plainly: if netdev wants to enforce that
> > > rule, then I won't be fixing people's problems.
> > 
> > Do you have a better proposal?
> > I'm under the same pressure of million stupid projects from my employer
> > as you are. Do y'all think that upstream maintainers have time given by
> > their employers to do the reviews? SMH.  
> 
> Are you really under the same pressure? I have one of my parents in
> hospital right now, and was in A&E yesterday afternoon through into
> the evening. I've been down at the hospital since 2pm today, only
> just come back to feed the other parent and head back down for what
> could be a long night. Then there's supposed to be an appointment
> that will take up to 3 hours tomorrow morning...
> 
> Yea, I'm sure you have the same pressures and worry from your
> employer - except my pressures are medical, looking after my parents.
> 
> Thank you for your lack of understanding.

Not my point. Sorry to hear about the issues you're facing.

I don't think making vague complaints about the development process
is going to make anything better.


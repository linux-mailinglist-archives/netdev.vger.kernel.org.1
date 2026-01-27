Return-Path: <netdev+bounces-253652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IGCKiQbeGnooAEAu9opvQ
	(envelope-from <netdev+bounces-253652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:55:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 727658ED30
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2D35300669D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03769296BC9;
	Tue, 27 Jan 2026 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="K73u5pQr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12C4298CAB
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769478944; cv=none; b=DN2gMreZfOBw8eumZB+H0HTtL/i+EODIyIpIsf5WCnyKNeLo0gV8zNQ3Z+BczcThl/vrKSUPppEvnqvY8LmNHzepzl9lGX3jumwXz8Nd1WwmbDBnfIxzUqYIf0gZXjLqQhiJv7YigF6qxRwXlDu394utWTXrvjZHqfgv3QIyUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769478944; c=relaxed/simple;
	bh=9oRyMB4v9knl25OEKbfUpH7lggk4I2Mck4BStnbftSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH/bsQwi8WLCuYn4PWbTqIKV8wqRQny6UvgW6/8bqpYlrdGkkhZ9e6EDg3cpj0McMsG76pZq/cOnws9EmtRo6Kw9qz/PnrYxPDr5JDZPZbwpK9OMVGwDBb1Sg79L90cvGAbVbEkDJH5iGXcabQ8BnoAdVu7abRriyc7eK60QHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=K73u5pQr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LvO5XQ+hJ+bO6yYuL4I5nYEstcN+CoP2zxmc7kZjaHA=; b=K73u5pQrlQ8ZLV9RxyHv2J/jwb
	9aR25JTtJYKT8McR4etdr9G5J1IwvVSnsqBfzSAWRF2Xs04MHMmaaIk2HKIuZzucV8DfZgDCogub5
	sHQO6jFzMTR4S8yPAo1aWvXX6FbTXBTINf3sp2BO6tar7XkhFZZAIi/4SLGV0tjm4dauvCLoN9c1w
	nR5f7Uh3cpcqPMnH07wE6MBFCchZp2babQSwibPJZIyJcrF7GdNy0WcLqJs1uorvMUraFtiNQa0AX
	TPqZ8MGFz/TW7126NU2Tamj3H6qp7zK4GYfC4gx7Myi/MzdpajEEK4CKcbbwdzjffkq3W1dTlg2sa
	Gq//ZoRg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44380)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vkYIo-000000005WJ-0PkD;
	Tue, 27 Jan 2026 01:55:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vkYIj-000000005Ta-3Dv2;
	Tue, 27 Jan 2026 01:55:29 +0000
Date: Tue, 27 Jan 2026 01:55:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 06/22] net: stmmac: rk: add SoC specific
 ->init() method
Message-ID: <aXgbEYvjcXqQKRIx@shell.armlinux.org.uk>
References: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
 <E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
 <aXd7aSk7KIxlQd5z@shell.armlinux.org.uk>
 <20260126165144.25055591@kernel.org>
 <aXgN2UjiI_OxWHH-@shell.armlinux.org.uk>
 <20260126171606.6153aa1a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126171606.6153aa1a@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253652-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 727658ED30
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:16:06PM -0800, Jakub Kicinski wrote:
> On Tue, 27 Jan 2026 00:59:05 +0000 Russell King (Oracle) wrote:
> > > > and there's no way to find out for about 9 hours (more like 19 hours
> > > > for me because of the timezone) as the AI reviews are not accessible
> > > > until then.  
> > > 
> > > The patchwork checks are for maintainers. If someone wants to build
> > > a public CI for contributors that'd be great. We can even provide
> > > funds from the netdev foundation. But let us be clear that the current
> > > setup is until now maintained primarily by me for me on the weekends.
> > > Unless you make an effort to actually help I don't think it is in good
> > > taste to complain.  
> > 
> > This sounds like my contributions to netdev aren't valued, and if that's
> > the case, I will stop.
> 
> Quite the opposite, what I'm saying is that your complaints make me
> feel like the weekends spent on trying to make this project come out 
> of stone age testing-wise are not appreciated. Of course your
> contributions are appreciated.
> 
> The AI code reviews on existing buggy code are indeed very painful.
> Not sure what we can do here to make the contributing easier.
> It costs us around $2 now to review a single patch so we can't afford
> public access. I think Google is working on making Gemini code reviews
> public and free, hopefully that materializes.

For a series of this size and complexity, the AI reviews are valued
because it's finding real issues that I can't test for.

The big problem is that the AI only finds one issue with a patch, not
all the issues. So, it's going to take multiple submissions to get to
a point where the AI review of this series is clean.

I suspect the problem with "AI only finds one issue" is that the AI
systems aren't advanced enough to do anything else yet.

So, do I continue fixing the AI issues each day and resubmitting a new
version of this series each day this week, costing $44 each time? Do
we reach a point where it gets merged even though the AI review still
has issues?

These are honest questions... and if they haven't been considered, I
think they need to be, because I can see this series becoming very
expensive.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


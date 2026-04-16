Return-Path: <netdev+bounces-279141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MVYL7w84WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:47:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA424144CF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE87A30131D3
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5A93E4C8E;
	Thu, 16 Apr 2026 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lpA7J4Pw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D633E5EDB
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368815; cv=none; b=ozLqJgzMoBwHOdjs008yxz0QDqi1WP9BMboAQ8BGrw6OzcNyYwZFeJPKsc9XJ24EsFpxWoXaJLDNrU9A3QJOMsvllwlBnMe/Eudo6fWc4F8GL75ySN8Ko+68U4WCkeptg9u+ZxQJnwVaBLmfCdQn9Fq6RNzX2XYp4x/ab4yr1gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368815; c=relaxed/simple;
	bh=YgmYMi4Zi5lNK8RcnYK9fVrRwTTGzVRGxvQSSDNfDe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2CCcZn+i6rYAOsDrT/dW3K1ykEUUgLp9AxF9K3zpVpRD29sTOFA46Bp92/bqen/d+nRN2TmAsIsOcfD1KxRoaQRor4R/TmgSC81tzwo/CqhVEF22PN/72hfKXWISY7esDEoIr3oWB2rsPds0sMAdZKj0CMHPvIK4nHvxihtWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lpA7J4Pw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HASfmhv4rUG5GHgvnGz8cmO8OTo9CENeqWoVTI5Y+4Q=; b=lpA7J4PwOr6GgUySmqbcuobRqj
	wFji3X5wBStapZ+y3eyYuQcQDu5bAH97dw377gaIYNYl6D00xkjzXiW+6n5G4ujfVqmlTfXJF8yWc
	azw+sUd9yNQZBV/RJzp5IOHRg0n1iEzaBPqaj3QIsQYKXzluvkqkZXBt+rNZO/oV65DysECG8HKvs
	Z4csOLuA7UQw6GB0wDUA8woWlMJQJ/t4FoUa+V1xAZJB3mZbLfCplRK9loVN2vlqEQl/ivd7KvnH4
	2g7u+dVoEBx+RIZt/7gpcR31XcxpcjLYq4EOEBn1CICDaDY5c9tfo+nWCLx8Tm3UMo3mSudzKppN5
	dk7cQeVA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37416)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wDSfd-000000003Vs-0REi;
	Thu, 16 Apr 2026 20:46:37 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wDSfa-000000003UF-1AiS;
	Thu, 16 Apr 2026 20:46:34 +0100
Date: Thu, 16 Apr 2026 20:46:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/6] net: stmmac: move PHY handling out of
 __stmmac_open()/release()
Message-ID: <aeE8mpXy9FRHvN9q@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
 <5987484.DvuYhMxLoT@steina-w>
 <aeC-tc2CooYDoBok@shell.armlinux.org.uk>
 <2410317.ElGaqSPkdT@steina-w>
 <aeDSTIS9-TDSihbX@shell.armlinux.org.uk>
 <aeDojTdDTELfpT0X@shell.armlinux.org.uk>
 <20260416090826.1c5ca018@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416090826.1c5ca018@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ew.tq-group.com,lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	TAGGED_FROM(0.00)[bounces-279141-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.401];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DFA424144CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 09:08:26AM -0700, Jakub Kicinski wrote:
> On Thu, 16 Apr 2026 14:47:57 +0100 Russell King (Oracle) wrote:
> > The next problem will be netdev's policy over reviews vs patches
> > balance which I'm already in deficit, and I have *NO* *TIME*
> > what so ever to review patches - let alone propose patches to
> > fix people's problems.
> > 
> > So I'm going to say this plainly: if netdev wants to enforce that
> > rule, then I won't be fixing people's problems.
> 
> Do you have a better proposal?
> I'm under the same pressure of million stupid projects from my employer
> as you are. Do y'all think that upstream maintainers have time given by
> their employers to do the reviews? SMH.

Are you really under the same pressure? I have one of my parents in
hospital right now, and was in A&E yesterday afternoon through into
the evening. I've been down at the hospital since 2pm today, only
just come back to feed the other parent and head back down for what
could be a long night. Then there's supposed to be an appointment
that will take up to 3 hours tomorrow morning...

Yea, I'm sure you have the same pressures and worry from your
employer - except my pressures are medical, looking after my parents.

Thank you for your lack of understanding.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


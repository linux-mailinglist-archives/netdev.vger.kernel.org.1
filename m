Return-Path: <netdev+bounces-266664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLSPNBx+sWmjCwAAu9opvQ
	(envelope-from <netdev+bounces-266664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:37:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8183265851
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9950C300516C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16A13BADBD;
	Wed, 11 Mar 2026 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="If8uo/u9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4283A392C27
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239180; cv=none; b=YOE7DgatI9Z2tybrLqO8PbHP3bUyRnACqmYaA2PMN04GCh0oQ3SSDW1pwN3yWYZwaCjbnFFTKwap1h3xM1A6L1JhHTwfARy5IXFO30CbfgWJlpP72JXlHpN7d99sZHnDlTHpyK/7k7NqSuksMb9GC5ny4iwBa0S1GYbgQyMeX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239180; c=relaxed/simple;
	bh=4ceUNuXX6pWUvU8VvO1XDBzl8/ZMKu+p+vbNJlMs9wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9ceReDOkl9582jutfOC8+H0Ok0t6JVji08tMwIIdHYjV/fpG4iscqO7hAhq+CrBmbNCZnZ/sOYxo72QgIZQyDHlW6dONDsBA7Wru6tn6iQSsU6Pyimc416nwzXaijs+7Qc4fGAc/fvtNCtuE8EVCVWr7OZT1FYMfZsa1qkdLmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=If8uo/u9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=11YlZnsUQzWnNst822K7eoXd8kxt6rzmcbVMr2uy4Lc=; b=If8uo/u9Auvd7+rrMk9k7Qek3q
	9ptxQOfM2dhiWqWfXsvF2GLny+7Mk7grOH4y9ADF5f5FwbPfXKkGgDowPgIa+YrfIx4paWTrrl4aI
	SZfUKZyrgXsNTeXFOK/cNEgyQ3f6PPIpdbs7CtieOOP/pahOrhhhe0yH4SCnqUJIn2YlsJCN9BOve
	r8E8ORDNAP5nAL03BRQcoluFBZNb9+xDeCl5OfYx8DZfGRzeaz0dNSd6gcsaDQ1//HvoJfnQ4iend
	o4ZyPsgVU2kTROZJi/h0QsjoKI2XwcvUlHj920lvnhuMafoEKCz6iIscxM4nEf64+nvKA1E8O/0ik
	wg9rGovA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44788)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w0KVp-000000006Tx-2h7t;
	Wed, 11 Mar 2026 14:26:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w0KVn-000000006Iv-3UY6;
	Wed, 11 Mar 2026 14:26:11 +0000
Date: Wed, 11 Mar 2026 14:26:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: andrew@lunn.ch, conor@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: phy: vitesse: add inband caps and
 configuration
Message-ID: <abF7g9kZk5-9YN5_@shell.armlinux.org.uk>
References: <E1w082O-0000000ChNc-1wDz@rmk-PC.armlinux.org.uk>
 <20260311140135.937544-1-geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311140135.937544-1-geert+renesas@glider.be>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266664-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.958];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: D8183265851
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 03:01:35PM +0100, Geert Uytterhoeven wrote:
> 	Hi Russell,
> 
> On Wed, 11 Mar 2026 at 01:07, Russell King <rmk@armlinux.org.uk> wrote:
> > Add support for VSC8662 reporting its inband capabilities, and also
> > hook to configure the PHY's inband mode.
> >
> > This fixes a regression in the macb driver caused by commit
> > 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
> 
> Fixes: 1338cfef1ff1b958 ("net: macb: fix SGMII with inband aneg disabled")
> 
> > Reported-by: Conor Dooley <conor@kernel.org>
> > Link: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba1@spud
> 
> s/Link/Closes/

I avoided it because any other PHY used with macb that is also connected
via SGMII will run into this same issue. It just happens that adding
this support fixes the above commit.

Conversely, we have stmmac, which unconditionally enables SGMII inband
at the MAC end no matter what phylink says to do, and should this
PHY be used with this patch in a stmmac system, it will cause that to
break, because we end up with either end misconfigured.

Also, if this commit is applied without the macb change, you'll
probably also find that macb breaks (please test that.) 

So, while this is a solution and a step forward, I'd rather not suggest
that it is an official fix to the macb issue - it's merely filling in
a missing piece of the jigsaw.

Sadly, this is a fundamental issue with SGMII implementations today:
whether SGMII inband is used/required is completely random both at the
MAC/PCS end but also at the PHY end. If one ends up with a mismatch,
then things stop working.

As I say, the problem with fixing the PHY end of the link is that
it could cause a different network driver to regress.

So yes, this is a solution to the macb problem, but I regard it as
high risk.

That said, given the SGMII mess, there is no easy way forward.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


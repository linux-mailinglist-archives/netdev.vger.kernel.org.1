Return-Path: <netdev+bounces-271156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAwBAYq2wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:06:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6342F318AFD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D054230FEDD9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170DA391510;
	Tue, 24 Mar 2026 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lgFhXA8R"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF038F65F;
	Tue, 24 Mar 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368006; cv=none; b=ltu9Fxoblp6BtLET16Fr8pQoDbzUQo9F8+p1XGCBjkPvHQVxy78hHEwAqcR1aWaQhmp0oqBbGM/MImiui8Btc8fekUEXO+M4kMrAx1XGf+8Gvb8yRGKcJKXLktKidekMlBaQAfG6pxe493+1/EnsiGuOS4U3lNCLNfk9SAkxLMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368006; c=relaxed/simple;
	bh=w93yOgRwZrXUr8HP+PVDBIDCftif6wc3/aWhomcJ/6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBCMN50oQG1J2YnEG86FR3XLdF3zNw98LTRdhyrys8DiSEk5FTYTCE5R/+VH2Yukpr6tmWuD4MqhbrcH2izOsE7KAYI8FzagDVZKNVfMBL6N2WElBNbr3VeeVwrhEAn+Ah3Ovc8YJaIRT5jHTfI5DsfbYWmODvtRTeFaLy039ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lgFhXA8R; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zf0/9XCuKjKNRx7wtM4tESz8aRDpD2HLpkH9lTB+IIA=; b=lgFhXA8REvNp111NhY4I0709M1
	NK3B3KQHkcib7fhl1e7BukTgkeUJM5aQJKcxW5RnafIlp5nQgaxa2NfEQGzcu+zoyc0vI+vJx/4IW
	lA6ZIBfVFrYaE0pOulcKZJaKgJw1O82umOBC9QLWI7o4voEMSUA/8Ea0sj6WJ4OaLR7sGofJF+I/N
	9Ockuh5cyEAHxptwBdx5Bb0GDXY778sXNtfyqlxKCp5izHivWUgTm62a+DoF7PrbOshI1SnkhkGc8
	treb6nUxPH2r/oCuV1HGFr5vO36v8s1u9PMcGwIA77cbE2IhyrAI5abfOMnAAmoQS55Vmcohd7WFK
	SLMWJ+Ww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59014)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w54Ab-000000002Hk-2C8t;
	Tue, 24 Mar 2026 15:59:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w54AY-000000005BX-2SMV;
	Tue, 24 Mar 2026 15:59:50 +0000
Date: Tue, 24 Mar 2026 15:59:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Michal Piekos <michal.piekos@mmpsystems.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Message-ID: <acK09pJynbhPnKDN@shell.armlinux.org.uk>
References: <20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl>
 <5e5706bb-0f04-4bb1-94f4-45083a3c76fd@redhat.com>
 <acKL4RoM-zdwj1Ib@shell.armlinux.org.uk>
 <TY7P301MB1984855F48CACF4FE1B502A4D348A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY7P301MB1984855F48CACF4FE1B502A4D348A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,mmpsystems.pl,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-271156-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url]
X-Rspamd-Queue-Id: 6342F318AFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 03:37:24PM +0000, Ovidiu Panait wrote:
> Hi,
> 
> My understanding is that the code in stmmac_vlan_update() that checks for
> !priv->dma_cap.vlhash is dead code, this condition cannot be true inside
> the ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid callbacks because the
> callbacks are only called when priv->dma_cap.vlhash is true.
> 
> This seems to be a long-standing issue in the VLAN code.

If you're certain that there's dead code here, please consider
submitting patches to clean it up thereby making the code easier
to understand.

> I only have access to a board that uses the DWMAC4 IP, but I'll have
> a look in the documentation I have to check how to improve VLAN
> features handling. 

Definitely please do! Having more effort to clean up parts of stmmac
would be very welcome (but please bear in mind that I have had quite
a large patch set, but that's reducing now.)

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


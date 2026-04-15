Return-Path: <netdev+bounces-278768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMbQDQON32l5VAAAu9opvQ
	(envelope-from <netdev+bounces-278768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:05:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80828404A4C
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA56E30082A9
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3337CD46;
	Wed, 15 Apr 2026 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aFyriBXu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66935C197
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257985; cv=none; b=uaJv41mtpMfbn4u0edfgu1EUUcklo5CEnA8D+LS1YJ031tvTj+iHlGiu3EVjBpMx66gtP2dmuEMXnvO9MCDFZ+Ph/fR+eL4cgjPxHOB6M3HA3vHvoXnWRuk3GinVUOR2fFCdTUTNC+sDoVBdq64i1ind/xmoOHZ0jpufu7NWN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257985; c=relaxed/simple;
	bh=QI8hvSFR4MG7toHeGfU6mUaxTYPzK5OvM+q+8pgdxDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYQu9/KvUlPB39nR3y31G6tO9D//8tcX7HIW7Z1EjbcFZVxxKThX8MSQr76bXSOT3jjVwX6Hn84jMjI/J7LFExdhiweWrK8Mp3Y1FgJnCqZCt3BgCTcdJ1UcjWZtezofkQNgM9XQnR1ESdUOWEBL1hi+lrIiGOJ9j8udCVXvSuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aFyriBXu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k1puqjkx70xR77cxDwbqQolTS/KLwYlYFTOWLOqnzlM=; b=aFyriBXuIy8LHVTejW1TUXwLSI
	SOGtjKg/MRydcxHRxyQwoWq1ZMD5bmH+zHEXuwt9s/TgJKEIQvXYmU/CVhy/JjHCom2U4e8bU6qLo
	87W1gK0L3wGZJMrRowFSZIdUb+E5XAcib8X4LG7+rupk+ph3+nYjveF29ZNvTl7ss6iIIRG/g6FZK
	mcPmRJ4JcBkbfPOt09h5TjV0eVBiQPuuQ3xMWChxR/IXz3YuKsLinJOie1NfDpQDAxDgIo7K1PSuK
	TL5zcIE/On68zsFvm6Mc7BgNzAyjhZay+pKmXU5Qcc3uqdKZTDhOF93nE+/MPpFU6TeMtUwXoDDkv
	m8g+Ib8A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59050)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wCzqA-0000000026f-2wkF;
	Wed, 15 Apr 2026 13:59:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wCzq8-000000002EM-3sFk;
	Wed, 15 Apr 2026 13:59:32 +0100
Date: Wed, 15 Apr 2026 13:59:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/6] net: stmmac: move PHY handling out of
 __stmmac_open()/release()
Message-ID: <ad-LtOBrKREM1tCk@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
 <E1v11A3-0000000774G-3PKY@rmk-PC.armlinux.org.uk>
 <8409022.LvFx2qVVIh@steina-w>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8409022.LvFx2qVVIh@steina-w>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278768-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.149];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 80828404A4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 08:08:40AM +0200, Alexander Stein wrote:
> Hi,
> 
> Am Dienstag, 23. September 2025, 13:26:19 CEST schrieb Russell King (Oracle):
> > Move the PHY attachment/detachment from the network driver out of
> > __stmmac_open() and __stmmac_release() into stmmac_open() and
> > stmmac_release() where these actions will only happen when the
> > interface is administratively brought up or down. It does not make
> > sense to detach and re-attach the PHY during a change of MTU.
> 
> Sorry for coming up now. But I recently noticed this commit breaks changing
> the MTU on i.MX8MP. Once I simply change the MTU I run into some DMA error:
> $ ip link set dev end1 mtu 1400
> imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-0
> imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-1
> imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-2
> imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-3
> imx-dwmac 30bf0000.ethernet end1: Register MEM_TYPE_PAGE_POOL RxQ-4
> imx-dwmac 30bf0000.ethernet end1: Link is Down
> imx-dwmac 30bf0000.ethernet end1: Failed to reset the dma
> imx-dwmac 30bf0000.ethernet end1: stmmac_hw_setup: DMA engine initialization failed

This basically means that a clock is missing. Please provide more
information:

- what kernel version are you using?
- has EEE been negotiated?
- does the problem persist when EEE is disabled?
- which PHY is attached to stmmac?
- which PHY interface mode is being used to connect the PHY to stmmac?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


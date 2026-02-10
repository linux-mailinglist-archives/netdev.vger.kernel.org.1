Return-Path: <netdev+bounces-258127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIkpBAJni2kMUQAAu9opvQ
	(envelope-from <netdev+bounces-258127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:12:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE211DAE3
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DB2F30058CF
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DA33815E1;
	Tue, 10 Feb 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eR2SFbnI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F62327BFB;
	Tue, 10 Feb 2026 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743549; cv=none; b=MnFrCC1NzRhcAZeMwoDnPK1q6evKE+RSg/I1i+4ovcjsoSVCMrDepgbPCHMp/li0zN5no+ZYjYT25ZxRxH92iLpDeRxEaPbnyFDuLQNFTsflSiXxiBpDCLIhZbfsWXOGq5aqGyPk24L3lM8P+uw/T3UaL88dvvCe7G1rXPagqP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743549; c=relaxed/simple;
	bh=0rIQx/lAJQUSuEq0DoZp0MlQH53Sy7mL660Jef77SlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfNB7q4/DF8kIpJogRFal4YGut5d1hKQVFyqfyLsrjGuCaJKcPHMQrfSgIQzw74MqZYE9s+lTBx6qFEKcxnUPpWuoAIIP1/A8xwXZCCfKps9YMeytAcPkD6ThDwBkDiZ9b+ITrfWcnwj6TbfjJMFgqt/XREMRZfDfMnFO7lGZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eR2SFbnI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mzYF97sVWz63m1CUxZf+jl+Hhjnz8guVOlV5+MbrsME=; b=eR2SFbnI4lfCWYT1cmVHQL6SgG
	rkwXF+klYabsm6Z8drPNbxY5lCHy5UDtoDUyIbk8k4bkjUYCPQd6mhuVxaXlvC2WB454hmU/RXBnE
	paJhrdsndFkbykNv8/uEnSfLJnpMBDfDwP4/kfpQoVxwaPrnJj2qGDKQUgeXleafN9uRJ6KB1izT6
	B9Fyw7AL9cgLv/2DzrsdO5ebbUbRC+1m6eRDWKFX4IFp7saMMQijwOi8QniOzBpVTezDN8kP/gYIX
	nt7vaZMESAfi7iEyd7/yO16UiTBbbDZrCpBegIn53yo5+TBUJrhsPGPWdDJa/7ThDQfBPfrisXpqp
	uhM/QYaQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57276)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vprHc-000000002nw-193h;
	Tue, 10 Feb 2026 17:12:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vprHW-000000002wr-3vpe;
	Tue, 10 Feb 2026 17:12:11 +0000
Date: Tue, 10 Feb 2026 17:12:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: stmmac: intel: Fix IRQ vector leak
Message-ID: <aYtm6pCnw0hdWdNx@shell.armlinux.org.uk>
References: <20260210-flo-net-stmmac-default-affinity-core-v1-0-4e76612444e1@siemens.com>
 <20260210-flo-net-stmmac-default-affinity-core-v1-1-4e76612444e1@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210-flo-net-stmmac-default-affinity-core-v1-1-4e76612444e1@siemens.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258127-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,intel.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1AE211DAE3
X-Rspamd-Action: no action

Note that net-next is currently closed. Patches for net-next should
be sent RFC. Please see the netdev *whatever it is* documentation (I
can never remember the name of the renamed document nor it's URL).
It's somewhere on docs.kernel.org and is in Documentation/ somewhere.
I'm getting tired of having to do a google search every single time
I respond to someone about this.

On Tue, Feb 10, 2026 at 05:28:14PM +0100, Florian Bezdeka wrote:
> The IRQ vectors allocated in stmmac_config_multi_msi() or
> stmmac_config_single_msi() where never cleaned up.

Please refer to:

https://lore.kernel.org/netdev/27fec7d0ed633218a7787be3edce63c3038c63e2.camel@mailbox.org/
https://lore.kernel.org/netdev/7e024db2557a4d5822a0dd409ae678d10d815d9c.camel@mailbox.org/

and the associated discussion in that thread.

PCI is weird. If pcim_enable_device() is used, it switches all sorts of
other functions to managed mode. The missing cleanup here isn't
actually missing, it's buried in the depths of PCI code. So, this is
not a bug, and thus:

> 
> Fixes: b42446b9b37b ("stmmac: intel: add support for multi-vector msi and msi-x")

this is not a fix.

However, if you look at Philipp's replies, there is a desire to get
rid of this PCI behaviour, so your patch is useful - it just needs not
to be dressed up as a fix.

I am keen that we cut down on the duplication between drivers. Having
_four_ stmmac PCI drivers all using MSI but no sharing any code is
silly.

Please consider what you can do to improve the current situation with
these stmmac PCI drivers.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


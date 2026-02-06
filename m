Return-Path: <netdev+bounces-257652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HKlIW5PhmlpLwQAu9opvQ
	(envelope-from <netdev+bounces-257652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 21:30:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2F61031F9
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 21:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB5893013706
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 20:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0097730EF67;
	Fri,  6 Feb 2026 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cUM2ujHW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEE32E3360;
	Fri,  6 Feb 2026 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770409824; cv=none; b=kxDwKJvhUbVndJipTKSlspHZig/h9MIPZ8X4VFHc0+LlhV3ULLY/PF8JY0NfPQWl00+4GIep6NgmIoGwptkzWxvsbviloLGrVYYvaQemqYyb+13ydYMxCIcrWychJDN+3plLy3wDRWXz9X6zuq3dlUOgeV6zug+kXzlldJx16d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770409824; c=relaxed/simple;
	bh=F6qiAd1W7b6pCHC2KsNYFfi1Jkwo0gHfRQ7KZJeYncM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fos9hL8TKxhe5s21wjhuOwNzxhtTFqJ0hsKj7yzYE8WIW4NAuCqnXZCgGcIte7VYxOfRMD4v0brApZMhJHDDaLkg3mWceDfI+yvIcU5KGprcEIExDQdxIrFdeJNSuP8oXg6AbnDJ6u6P5+yr/qBwnmLIN33cRnZCRWopvMs0Fqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cUM2ujHW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4YHH0YAMAHnJ5UGh8pphcs9yAuxrmD7yQeFh/XrEM1k=; b=cUM2ujHWceUzMbW20cIxqA4llS
	NkE8BDAwqzDmYlfweI9LHAUpWYlxzdrvLA5m1wdr0Z8+TZA5w10hCD+WxkQyEgPtUUEnq6GnJiU4O
	wvjdWjQJfmNXBJtzVpEL8q07G8B+obm9lIEThmhNkdCtmQZUAGs0j8PRgQtQcGwV6VHukgdN4P25b
	euMdVvZOmk2Z3Ol28RZgeWSFM2HOIFBjngDcaebtXbfDdzeloV790c2+Bj9G7f+PMqOWXBQQtPlVu
	z9kyVPyVhCuw6ZoRtG+Uj33nOwDBjz95xY11XTce8Ny/irboMl+80x5OPmDmfd34eHK2NLxH/3c40
	Rz9IKV0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42876)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1voST3-000000008Oi-39Cq;
	Fri, 06 Feb 2026 20:30:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1voSSy-000000007cx-01gv;
	Fri, 06 Feb 2026 20:30:12 +0000
Date: Fri, 6 Feb 2026 20:30:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jie Zhang <jzhang918@gmail.com>
Cc: netdev@vger.kernel.org, jie.zhang@analog.com, horms@kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: fix oops when split header is enabled
Message-ID: <aYZPUx2WrIkPmvIU@shell.armlinux.org.uk>
References: <20260206195643.11333-1-jie.zhang@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206195643.11333-1-jie.zhang@analog.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257652-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,analog.com,kernel.org,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,bootlin.com,nxp.com,synopsys.com,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B2F61031F9
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 02:56:38PM -0500, Jie Zhang wrote:
> For GMAC4, when split header is enabled, in some rare cases, the
> hardware does not fill buf2 of the first descriptor with payload.
> Thus we cannot assume buf2 is always fully filled if it is not
> the last descriptor. Otherwise, the length of buf2 of the second
> descriptor will be calculated wrong and cause an oops:
> 
> Unable to handle kernel paging request at virtual address ffff00019246bfc0
> ...
> x2 : 0000000000000040 x1 : ffff00019246bfc0 x0 : ffff00009246c000
> Call trace:
>  dcache_inval_poc+0x28/0x58 (P)
>  dma_direct_sync_single_for_cpu+0x38/0x6c
>  __dma_sync_single_for_cpu+0x34/0x6c
>  stmmac_napi_poll_rx+0x8f0/0xb60
>  __napi_poll.constprop.0+0x30/0x144
>  net_rx_action+0x160/0x274
>  handle_softirqs+0x1b8/0x1fc
> ...
> 
> To fix this, the PL bit-field in RDES3 register is used for all
> descriptors, whether it is the last descriptor or not.
> 
> Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jie Zhang <jie.zhang@analog.com>
> ---
> v2:
> 1. Update for the latest net HEAD
> 2. Reduce crash dump message in commit message
> 3. Add Fixes tag
> v1 link: https://lore.kernel.org/all/20251202025421.4560-1-jie.zhang@analog.com/

I was trying to work out whether this was a re-post of a patch that had
already been merged and it was the result of someone inappropriately
re-posting old patches, or whether it was something to take seriously.

That is because of this in the patch:

> +	/* Not GMAC4 and not last descriptor */
> +	if (!priv->plat->has_gmac4 && (status & rx_not_ls))

Commit 26ab9830beab ("net: stmmac: replace has_xxxx with core_type"):

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 99022620457a..151c81c560c8 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
...
+       enum dwmac_core_type core_type;
...
-       int has_gmac4;

So, has_gmac4 no longer exists, and hasn't done since October last
year.

Thus, it seems your patch has been generated against an old kernel.
As you are submitting for netdev, it is a good idea to ensure that
patches apply to the net-next tree and/or net tree depending on
which one you are targetting, and have been tested against that
tree.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-264711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLbqCQ2YqmmIUAEAu9opvQ
	(envelope-from <netdev+bounces-264711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 10:02:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6EF21D90B
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 10:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35E07300E4B6
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A21D32AAC5;
	Fri,  6 Mar 2026 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ahlOo+mh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26BF273D8F
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787715; cv=none; b=YTum6TYHqXViC4LsNXJLZrqOoanZNTDQX4lKXLF4KjIjEbkXBm6LsAJAuhK1Op7QbEdzgHV1JBVki9tja6jDzUaqf7sRBCGnAcNCvlb8oTVj9ayY7DyePQ+q21cm48wBYz4NECEsH4NelSsjIsp9u8cC+TEyGfxEllpqecedyP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787715; c=relaxed/simple;
	bh=jKvSCK2VZow3Ee2fl3Vir23oJKTdWa67+5Es5wmbAYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzmcxJnmKdNgQHbeE9bpFjMo22gH7AxYOmB8CQkXb603Khdhepwd4AXTalDfduMIxlnCWBvxOZLyHiL2ywytfwEmV2eYkRAzMTrIz4LI4V7B2gTwx3hn5nbPJxxpsQMYTlTZWTQp9S7ZINLDEqdPASHbxo6V9OMDdBH98PhImOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ahlOo+mh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZgDBXmEnVujJM8vulMEVYeA6ICqdKuQICuLq3YHevSE=; b=ahlOo+mh3t8qpxKXMd1PjHafv8
	37m8cqehiUO9Z7eeLymK0NQLXS2kg/oIzYDJb/+pa/1UWGRgWbVrqrzTls5cEEWCNlrHOHM8cTYwQ
	a5II4e0BX4jwm8RucqWkof7Cty24hFJL9ulS8FjKmCsGQN7FbTvSSZfsOuq6UAfECxPkKZRk/aJ/8
	XbyLQLvyn0r0SFGP1co3x79I6CK5a2c/lL3xzvApaImX44AhUkUNRDimQ0ixXKyiyVJXayzafi+LL
	2RQjiZdzN9d1XCKWHlaN+a9mSDe44Xinj4sdhoXz2tXjO0f+CtHT4Jrefqs2ytwtMX/ozvm4Z6pWd
	3Y7Uo/bQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47666)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vyR40-000000000jm-29aw;
	Fri, 06 Mar 2026 09:01:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vyR3w-000000001IO-41FR;
	Fri, 06 Mar 2026 09:01:36 +0000
Date: Fri, 6 Mar 2026 09:01:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH net-next v2 3/8] net: stmmac: mdio: simplify MDC clock
 divisor lookup
Message-ID: <aaqX8IxLzZ7jGM4r@shell.armlinux.org.uk>
References: <aald--qJquWGIvmO@shell.armlinux.org.uk>
 <E1vy6A9-0000000Btwp-0lxY@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vy6A9-0000000Btwp-0lxY@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: 6E6EF21D90B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264711-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.364];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,shell.armlinux.org.uk:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:42:37AM +0000, Russell King (Oracle) wrote:
> As each lookup now iterates over each table in the same way, simplfy
> the code to select the table, and then walk that table.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 29 +++++++------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index 6292911fb54b..c9f0b8b601d2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -535,6 +535,7 @@ static const struct stmmac_clk_rate stmmac_xgmac_csr_to_mdc[] = {
>   */
>  static u32 stmmac_clk_csr_set(struct stmmac_priv *priv)
>  {
> +	const struct stmmac_clk_rate *rates;
>  	unsigned long clk_rate;
>  	u32 value = ~0;
>  	int i;
> @@ -548,25 +549,17 @@ static u32 stmmac_clk_csr_set(struct stmmac_priv *priv)
>  	 * the frequency of clk_csr_i. So we do not change the default
>  	 * divider.
>  	 */
> -	for (i = 0; stmmac_std_csr_to_mdc[i].rate; i++)
> -		if (clk_rate > stmmac_std_csr_to_mdc[i].rate)
> -			break;
> -	if (stmmac_std_csr_to_mdc[i].cr != (u8)~0)
> -		value = stmmac_std_csr_to_mdc[i].cr;
> -
> -	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
> -		for (i = 0; stmmac_sun8i_csr_to_mdc[i].rate; i++)
> -			if (clk_rate > stmmac_sun8i_csr_to_mdc[i].rate)
> -				break;
> -		value = stmmac_sun8i_csr_to_mdc[i].cr;
> -	}
> +	rates = stmmac_std_csr_to_mdc;
> +	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I)
> +		rates = stmmac_sun8i_csr_to_mdc;
> +	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
> +		rates = stmmac_xgmac_csr_to_mdc;
>  
> -	if (priv->plat->core_type == DWMAC_CORE_XGMAC) {
> -		for (i = 0; stmmac_xgmac_csr_to_mdc[i].rate; i++)
> -			if (clk_rate > stmmac_xgmac_csr_to_mdc[i].rate)
> -				break;
> -		value = stmmac_xgmac_csr_to_mdc[i].cr;
> -	}
> +	for (i = 0; rates[i].rate; i++)
> +		if (clk_rate > rates[i].rate)
> +			break;
> +	if (rates[i].cr != (u8)~0)
> +		value = rates[i].cr;

Looking at the AI review, it seems to me that the AI review is
incorrect.

With reference to the full original code which can be seen in:
https://patchwork.kernel.org/project/netdevbpf/patch/E1vy69y-0000000Btwd-3oq7@rmk-PC.armlinux.org.uk/

If we look at the original code, then we can see that the intention
is that if clk_rate is smaller than the last real entry for the
sun8i and xgmac cases, the value should end up as zero - and this is
exactly what the new code does. So, the behaviour is preserved, even
though AI thinks it isn't.

AI seems to think that reaching the last entry for sun8i and xgmac
means we have an invalid rate. That is where AI is going wrong -
that is an incorrect "assumption".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


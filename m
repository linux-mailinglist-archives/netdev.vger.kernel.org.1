Return-Path: <netdev+bounces-264971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5LrKHc1rq2kHdAEAu9opvQ
	(envelope-from <netdev+bounces-264971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:05:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4062228E57
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B070C302BDE7
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 00:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B522E413;
	Sat,  7 Mar 2026 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NztodOTZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23201C13B;
	Sat,  7 Mar 2026 00:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841931; cv=none; b=M6rGDqflgAQz+/WAuyTmkWNwbmrMy3d1z80/Yig13rCZmR6vyicW/iOLg9BVZ+Wo0WStNMXM77ONYuvVglZz8iApNx3QPxuHVb2+5Omk8ui4CJthw9uRgHRkyN+jjfwF1s0xqOtFxPH7yQQtZBt8FIHF4VwhWVq4ubm0MW0YK2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841931; c=relaxed/simple;
	bh=h1a75gdjqpmW7z6/ZJFcSnXVV4clbTBNT+a53CyNqlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrqneUwxF/xKqc9r8l2X8GE4YB66GvpWE/afRce0XdRpqWXBt1nZUIUGhswU+IOISgq5QNZZ+L14xkyKJ/UkrawuUI2nFCTHHG18W+TPeYHeExtA6q7ZDfHB4lh+p8MJBWJ+utdIv2eUOev2zfqMWAJ9gb8oQEOJSJgfrEJeQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NztodOTZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FsRPNID5PAvwSRgv4YV66cyR8EgMHDZN2LmKg1jcxCM=; b=NztodOTZPF9ce0GYVQJAZ+0fjy
	KV4HTH+asXGOH0lQE3k6M2wop9lFdAzefd7jR5MM3xj6q8N9PcSjGV0+uf+jrpaeoFvji0BdL9dnf
	SANdQViLj+hPkphrXXTiUBm3G8E8vFbOOT/tw9VmMZNTdPJfmulOohOFPbs1aoVq0Vv34oDYuT5tu
	+p0BYZlh2rO8i4xrXVofszwbHZYp/eak0RGso5AItkqLKHWlhNHGaookuQCJEXpp06fCnenMRzzop
	Zb7/tyfFyNR6UPxCNJ4KbGbLWyGo+0L9VgPy+xt/01N1ztatymJKwIGpIEOAG6JGhh7bXGKEfUovm
	2YYtpyPg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59864)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vyfAY-000000001gD-1Kzj;
	Sat, 07 Mar 2026 00:05:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vyfAU-000000001pI-2HLV;
	Sat, 07 Mar 2026 00:05:18 +0000
Date: Sat, 7 Mar 2026 00:05:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: mark unimplemented AXI snps,kbbe snps,mb
 and snps,rb
Message-ID: <aatrvmyW-SaHuVN7@shell.armlinux.org.uk>
References: <E1vxq3L-0000000BsQm-4C8v@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vxq3L-0000000BsQm-4C8v@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: C4062228E57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264971-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.107];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Any chance of a review from the DT maintainers please?

Thanks.

On Wed, Mar 04, 2026 at 05:30:32PM +0000, Russell King (Oracle) wrote:
> Mark the AXI snps,kbbe snps,mb and snps,rb properties as not
> implemented. These were introduced by commit afea03656add ("stmmac:
> rework DMA bus setting and introduce new platform AXI structure").
> While stmmac has code to parse these properties and save their values,
> these are written to write-only struct members - no code in stmmac
> has ever read their value. Hence, these properties have been non-
> functional from day one.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 38bc34dc4f09..45dba6533458 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -202,11 +202,11 @@ title: Synopsys DesignWare MAC
>          * snps,xit_frm, unlock on WoL
>          * snps,wr_osr_lmt, max write outstanding req. limit
>          * snps,rd_osr_lmt, max read outstanding req. limit
> -        * snps,kbbe, do not cross 1KiB boundary.
> +        * snps,kbbe, do not cross 1KiB boundary (not implemented)
>          * snps,blen, this is a vector of supported burst length.
>          * snps,fb, fixed-burst
> -        * snps,mb, mixed-burst
> -        * snps,rb, rebuild INCRx Burst
> +        * snps,mb, mixed-burst (not implemented)
> +        * snps,rb, rebuild INCRx Burst (not implemented)
>  
>    snps,mtl-rx-config:
>      $ref: /schemas/types.yaml#/definitions/phandle
> -- 
> 2.47.3
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


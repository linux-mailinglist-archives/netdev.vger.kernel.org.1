Return-Path: <netdev+bounces-272191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHTuAwJ4xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:16:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD57E339E5C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5780300B5B3
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967CC39EF17;
	Thu, 26 Mar 2026 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A91llKaR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0839EF30;
	Thu, 26 Mar 2026 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548937; cv=none; b=iP8t/QLCWIylJeM54/MBS7CCfDsI+Yyu0ZsGcuLooiw3bT5i0LWNkxfBuC3ksZWmIdPr7vvbAwRjjFEE3vj9ZYZYIiHR+G37vM6d2oy3NBCpIY4cLqyaLkzVtn0gN1xhAUgrQsBgcuUD6xc10yeevLT9avNcno+X7Bpvd02VKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548937; c=relaxed/simple;
	bh=InLnSJBLzWxlxo3dw4P0X/q8o5CvV5UAEslhTc14/us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZcpCHxg0TN/+broZvAUEaMi9iYwKymmtL1v0ou23kPBT+lhh8OXAfqf1kIzjd6jtqZmcZ9dALP5ww7rrBjH2Ea+cPqwepAEpAf0dgGcqTbR1SE75FyPDcAQrpUSo+OlLLqsTDh2IxaVpEb6sM4Ue1pL9eZM+L9/2Ni/0t+x3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A91llKaR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q04VIAHNkeO/Oab8CZfYBVf+J5N6KJreQMXprmET4N4=; b=A91llKaRZg1Kmp6LhWd1OiFvcj
	3itUEP0PSvXO6oGyTtfgHDbDG28LoaPafvUnAUVxPxPAGgzivyFflJrT+8x7+D5B6aEBiE5KUJvpx
	hsLC3Q9MtLtj5zS6XTV+mTFQHCTk/a4GPoJsYEIH5dzvP8DG3wwdU6/BAhPw3H9Z4kE7jlOleNzY4
	938Lcw/7mq1ZxXXkBvdTj0rrQ/E8FqgyUjbin2ESTPaMpntIg5biA5leRtVjbSi3EMVY1NPQ2UQUW
	vZvi82S6JJQyDlX/01L00gn7bQ3JaN9y4RDLm9UG60iu0fAZ20CIs2Nv6xeag98tIykPe2I/N4nY9
	WeQ2ggwA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54672)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5pEw-0000000059k-0PVC;
	Thu, 26 Mar 2026 18:15:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5pEt-000000007G1-3NVj;
	Thu, 26 Mar 2026 18:15:27 +0000
Date: Thu, 26 Mar 2026 18:15:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH net-next 1/2] net: stmmac: remove axi_kbbe, axi_mb and
 axi_rb members
Message-ID: <acV3v-iyoCUTh2a8@shell.armlinux.org.uk>
References: <acJh4z3pRKkeaFbR@shell.armlinux.org.uk>
 <E1w4ydo-0000000Dlpb-34jd@rmk-PC.armlinux.org.uk>
 <20260326172943.GR111839@horms.kernel.org>
 <acVxNBLE8Ck2qfjc@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acVxNBLE8Ck2qfjc@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272191-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: AD57E339E5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 05:47:32PM +0000, Russell King (Oracle) wrote:
> On Thu, Mar 26, 2026 at 05:29:43PM +0000, Simon Horman wrote:
> > On Tue, Mar 24, 2026 at 10:05:40AM +0000, Russell King (Oracle) wrote:
> > > axi_kbbe, axi_mb and axi_rb are all written, but nothing ever reads
> > > their values. Remove the code that sets these and the struct members.
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > 
> > Hi Russell,
> > 
> > FYI, AI review suggests that these fields should also be removed from
> > Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst
> 
> I noticed. I've prepared an update if netdev folk want that to happen
> as I've noticed that that documentation is fairly out of date now.

There's another reason I haven't submitted an update, and that's
because netdev is fairly backlogged at the moment - currently there's
381 patches in patchwork - four pages of patchwork, with the oldest
"new" patch dated 21st March. I don't think netdev patchwork needs
more patches at the moment!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


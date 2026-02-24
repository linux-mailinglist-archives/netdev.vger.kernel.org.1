Return-Path: <netdev+bounces-260441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA6YKTh3nWmAQAQAu9opvQ
	(envelope-from <netdev+bounces-260441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:02:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0797A185130
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 406D8302D082
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B010C36B07C;
	Tue, 24 Feb 2026 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fBhIoRXh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAE1428F4
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927347; cv=none; b=bJ4aUNf48eYGoBeHrcg5btv76f3A3h5QEvFcHIzezNPWN3I0PoD3O+slcr/Bzb3Vusgu8YJcjO/W/9DhZQsawE9rhjTHQe5MVC2xVq8SxXkrsMCxt4yzfxlM+dUwGMjqQlCp1EMH3dLR8aiZxOh/eXwHRZi2Mi7ErombTPO4leE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927347; c=relaxed/simple;
	bh=Y3cMqOEa8ZSogS4rvUnWvBmarJIjegLy4qPw4G+C9IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edQ4wPGFo8Q9xJp4XctpFSvc5mHiMrdFYPRsSgqWLwG7D75hUJ425TK7pwn/Bdyq3ejBHgpFEajhNIKdrs2GbTsXyPymMALCaC6pWkha5ppCEYwBJ7DWtRMptyhmf2bj0op+L1e4guPg4Es1gnsdxZOoxL52Uy73FNly6uHmsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fBhIoRXh; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WdEZMFpQwHHmjmHMSwjs7JUUFErg72GIrhiSikPqoEI=; b=fBhIoRXhvjPAk7lxdXgmVZ4eF0
	CYw+FGwMDwqu2PAtevCfLNsu9NyKOKz0/xKV95U85oWU2Hy7s1Z2x1Hd1QNY9P+VwUrIYUTZdG0qh
	cQBKxf+uZGDhSPthm26p01JeytMS4I8YLZPsbacg8uu6MyvCAroM/DFupj3tpMwR+ENOH0YYqKV1+
	mFqJa8z5kdEMmUmdqb9WfBSDRCFp5eMhi6UAnq7olMESK+Nijbo16rClkZ+LxfvDvimBAY70bJ6T2
	5egdIJrpto1hSoHd0P6Fg0yoQ+1m6PPyoLHeDbyMBxKHVm5c8x9KgMbQBj6ta8YkUtI8x8GCODxqw
	+N2jBGmA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48140)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vupF0-0000000053j-2ZSh;
	Tue, 24 Feb 2026 10:02:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vupEw-000000008Gi-48I1;
	Tue, 24 Feb 2026 10:02:03 +0000
Date: Tue, 24 Feb 2026 10:02:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: ptp: limit n_per_out
Message-ID: <aZ13Gjav_5PYNGEN@shell.armlinux.org.uk>
References: <E1vuUvf-0000000AfhS-0lJR@rmk-PC.armlinux.org.uk>
 <aZ1uxX_fddwO7UYD@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ1uxX_fddwO7UYD@horms.kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260441-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.920];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:url,armlinux.org.uk:email,shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0797A185130
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 09:26:29AM +0000, Simon Horman wrote:
> On Mon, Feb 23, 2026 at 12:20:47PM +0000, Russell King (Oracle) wrote:
> > ptp_clock_ops.n_per_out sets the number of PPS outputs, which the PTP
> > subsystem uses to validate userspace input, such as the index number
> > used in a PTP_CLK_REQ_PEROUT request.
> > 
> > stmmac_enable() uses this to index the priv->pps array, which is an
> > array of size STMMAC_PPS_MAX. ptp_clock_ops.n_per_out is initialised
> > using priv->dma_cap.pps_out_num, which is a three bit field read from
> > hardware.
> > 
> > Documentation that I've checked suggests that values >= 5 are reserved,
> > but that doesn't mean such values won't appear, and if they do, we
> > can overrun the priv->pps array in stmmac_enable().
> > 
> > stmmac_ptp_register() has protection against this in its loop, but it
> > doesn't act to limit ptp_clock_ops.n_per_out.
> > 
> > Fix this by introducing a local variable, pps_out_num which is limited
> > to STMMAC_PPS_MAX, and use that when initialising the array and setting
> > priv->ptp_clock_ops.n_per_out.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > 
> > This could be a user exploitable bug (although one has to be root
> > so the gun is already pointing at one's foot.) This is the commit
> > which introduced the problem:
> 
> Hi Russell,
> 
> From the description I assumed that for this problem to manifest
> out-of-range values would need to be turned by hardware.
> But maybe I misunderstand things.
> 
> Could you elaborate on the vector you have in mind?

priv->dma_cap.pps_out_num is initialised from hardware:

dwmac4.h:#define GMAC_HW_FEAT_PPSOUTNUM         GENMASK(26, 24)
dwmac4_dma.c:   dma_cap->pps_out_num = (hw_cap & GMAC_HW_FEAT_PPSOUTNUM) >> 24;
dwxgmac2.h:#define XGMAC_HWFEAT_PPSOUTNUM               GENMASK(26, 24)
dwxgmac2_dma.c: dma_cap->pps_out_num = (hw_cap & XGMAC_HWFEAT_PPSOUTNUM) >> 24;

As can be seen, these are three bit fields, and as noted in my commit
description, values in this field above 4 appear to be reserved, but
"reserved" doesn't mean they will never be seen.

Meanwhile, priv->pps[] is defined as:

#define STMMAC_PPS_MAX          4
        struct stmmac_pps_cfg pps[STMMAC_PPS_MAX];

The code in stmmac_ptp_register() takes account of that, and is careful
not to overrun the priv->pps[] array:

	for (i = 0; i < priv->dma_cap.pps_out_num; i++) {
		if (i >= STMMAC_PPS_MAX)
			break;
		priv->pps[i].available = true;
	}

but the code there goes on to assign it to the number of per_out:

	if (priv->dma_cap.pps_out_num)
		priv->ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;

Core PTP code uses this to validate user input. This limits the value
that can appear in rq->perout.index for a PTP clock ->enable() call
for PTP_CLK_REQ_PEROUT.

stmmac_enable() implements this method, and with no bounds checks,
does this:

                cfg = &priv->pps[rq->perout.index];

                cfg->start.tv_sec = rq->perout.start.sec;
                cfg->start.tv_nsec = rq->perout.start.nsec;

Thus, if priv->dma_cap.pps_out_num were to indicate e.g. 7, then
there is nothing to prevent rq->perout.index being e.g. 6, and thus
overflowing the priv->pps[] array. This will likely write to other
struct stmmac_priv members if it were to occur.

So... there's two views one can take here:

- hardware will never indicate values > 4. If that's the case, then
  what's the point of the limiting check in stmmac_ptp_register() ?

- hardware might one day support more than 4 outputs, resulting in
  priv->dma_cap.pps_out_num being greater than 4. This will be a
  silent overrun until someone attempts to configure an output > 4,
  at which point non-PPS data of struct stmmac_priv will be
  overwritten.

Either code should care about values > 4, or it shouldn't. The current
code cares about it in one place but then ignores it in all other
places where the index is under userspace control, allowing the
potential for array overrun.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


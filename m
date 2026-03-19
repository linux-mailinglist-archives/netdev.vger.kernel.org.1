Return-Path: <netdev+bounces-269351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JwbIvewu2k8mgIAu9opvQ
	(envelope-from <netdev+bounces-269351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:16:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C4A2C7BCD
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 09:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D925E300DF7F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2EE3A8729;
	Thu, 19 Mar 2026 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="N8U5LMwO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538E3A3835;
	Thu, 19 Mar 2026 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908110; cv=none; b=RqsDuQ7Cr3/X64WxX4qcjCjNZTOqe+6TT8t5tkVpcKZ170D8A9NmP7SdRkpegL8C99TLTeXmrgvbyO7nsRL15CfFJqK5MT5YkHsbOF8mSwnRFfyFnLt1mzYtxruA6HU3yVCSxQj+QyUYdurxBe4Plx692k1+91pL5YqU09lo1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908110; c=relaxed/simple;
	bh=/46lHL5quM09lZSvVpaCiNabWUsqlrPWGranUcc3cpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF03p5xWe4t25h7p3exLTSL3e9NEK75neZA/A6eO8kicrsbFIuFoOaQZS0H7greyHO1C5kcUFsqrV9XJrnIefuZeD4LdKECGA5a4l9/RtaIJT18uLTU59Px3Q57KSyAJ2tUu+EFJo3pGcU/BaQzO4hvhBLi+vrUgwHj7VRrH2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=N8U5LMwO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ay74TMh014iR7nkSfjsS4NxcUBQqZWrWwmUFvdZ+uTc=; b=N8U5LMwOvrosPl6nOVMMteuKVW
	sTe7HQrBy06spxIvUzVkz3BHiznipoV4TylXKQYaLjUGrXcqsJV6zFjMqADDLaBTU/l1Jx2fnM92R
	JqNXoaJTFHHkd9ibx2CqvxaH+R6STvuSBF8c81fGugte8jjRpjqYFxptpFfKdUJXC/42DnXYObj6H
	UkOO6fUS5YTkP+SbcbBfqrqGQdQ4e+pgTe107Mr3yS/Pi0wMVk3wzI7fBu/JZK48rYbo35sh29dZE
	FQlyzRoj/XXnTzBCuqgYkunW0rilS/w0qDqpk7ErNsUr4KtuGJ3GYtEG+85jmcVLDJX8PAkK93F4n
	04y9qy3w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45380)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w38Wt-000000004SZ-48nU;
	Thu, 19 Mar 2026 08:14:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w38Wf-000000007z5-1pDU;
	Thu, 19 Mar 2026 08:14:41 +0000
Date: Thu, 19 Mar 2026 08:14:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, rohan.g.thomas@altera.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	siyanteng@cqsoftware.com.cn,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	weishangjuan@eswincomputing.com, wens@kernel.org,
	vladimir.oltean@nxp.com, lizhi2@eswincomputing.com,
	boon.khai.ng@altera.com, maxime.chevallier@bootlin.com,
	chenchuangyu@xiaomi.com, yangtiezhu@loongson.cn,
	ovidiu.panait.rb@renesas.com, chenhuacai@kernel.org,
	florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v7 4/5] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <abuwcYH791D_oJp_@shell.armlinux.org.uk>
References: <20260313222206.778760-1-jitendra.vegiraju@broadcom.com>
 <20260313222206.778760-5-jitendra.vegiraju@broadcom.com>
 <abSXP3gMFQEiC5Lm@shell.armlinux.org.uk>
 <CAMdnO-LYAPfyvM4vgmGcZgy-aagHSkP+VDmpRskNU-414j3gnQ@mail.gmail.com>
 <CAMdnO-+YWowCDh4iB9EZ=eqUidE6Mu4TOqjwyoMgyEaG=pBLBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdnO-+YWowCDh4iB9EZ=eqUidE6Mu4TOqjwyoMgyEaG=pBLBg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269351-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,foss.st.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,broadcom.com,iogearbox.net,altera.com,st-md-mailman.stormreply.com,lists.infradead.org,lunn.ch,fomichev.me,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,nxp.com,bootlin.com,xiaomi.com,loongson.cn,renesas.com,quicinc.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.826];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,armlinux.org.uk:url,shell.armlinux.org.uk:mid,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6C4A2C7BCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 11:12:23PM -0700, Jitendra Vegiraju wrote:
> Hi Russell,
> On Mon, Mar 16, 2026 at 1:34 PM Jitendra Vegiraju
> <jitendra.vegiraju@broadcom.com> wrote:
> >
> > On Fri, Mar 13, 2026 at 4:01 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > > +
> > > > +     plat->suspend           = stmmac_pci_plat_suspend;
> > > > +     plat->resume            = brcm_pci_resume;
> > > > +     plat->bsp_priv = brcm_priv;
> > >
> > > Populating suspend/resume means that plat->init and plat->exit
> > > will only be called on driver probe (former), probe failure (latter)
> > > or remove (latter). Please consider using these to ensure that
> > > all appropriate resources are properly cleaned up in all cases.
> > >
> >
> > Thanks for pointing this out. I will check resource cleanup more closely.
> After reviewing the need for  plat->init and plat-exit, I don't think we need
> these handlers as this driver with fixed-link doesn't need to restore any device
> specific state such as clocks.

Huh?

plat->init and plat->exit have nothing to do with "restoring" anything.

plat->init is for platform specific initialisation.

plat->exit is for reversing the effects of plat->init once plat->init
has suceeded, and will be called should the probe fail or on device
removal.

So, where you have:

static int foo_probe()
{
	do init stuff();

	ret = stmmac_dvr_probe();
	if (ret)
		goto cleanup;

	return 0;

cleanup:
	do cleanup stuff();

	return ret;
}

static void foo_remove()
{
	stmmac_dvr_remove();
	do cleanup stuff();
}

Using ->init for "do init stuff()" and ->exit for "do cleanup stuff()"
will simplify the code, and actually make things more correct.

Currently, you have this in your remove path:

+       pci_free_irq_vectors(pdev);
+       device_set_node(&pdev->dev, NULL);
+       software_node_unregister_node_group(brcm_swnodes);

but in your probe error path, you have failure paths that leave
the swnode connected to the device, and you don't call
software_node_unregister_node_group(). Thus, it seems to me that
your cleanup path is buggy.

My suggestion of using ->init and ->exit means you have slightly
less to think about when stmmac_dvr_probe() fails - although if
you still have to do appropriate cleanup within ->init if it
partially fails.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


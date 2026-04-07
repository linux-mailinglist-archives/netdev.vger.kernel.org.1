Return-Path: <netdev+bounces-275994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH4vBxAF1WmczgcAu9opvQ
	(envelope-from <netdev+bounces-275994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:22:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7417B3AEF46
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D560A3009F9B
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B93B6BF3;
	Tue,  7 Apr 2026 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gjBF7WWT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94643382E8;
	Tue,  7 Apr 2026 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568053; cv=none; b=ZhqONrXYgGBoCeD2sS12MBWhuAT4/tjEa6RlrQOaiYEXlwjwdto7VCptpr4D8/CUyJn1HVrBQUuatj8H5z5G33aBtFXZl7GBs23egW27xsp8h1U6fIWipeidwH1EvHGTy8XBxc9ZHqyFa8nkaGmQWN2fh/g4YAnh/9r/USCc8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568053; c=relaxed/simple;
	bh=pzM7QcrWkAZhZA1R6Gzk5BL0recEtgJSouEzuAt98Bs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwVM72ButODLBeK93u5IF/Ow3qIuxnxgZZTrEA2kBS9avD5vpDRSph3bH4r3uWWHldjYWjwy/tVgzxfrs0YoLpdroYLwqRALCoIP7XZ0WeTRkGK0RRJ0OCWa8/bKMARwl8Q+Y9g3+obGJ3JmZMbrp1/2uPuzgj/z5RDiDCCTa3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gjBF7WWT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775568051; x=1807104051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pzM7QcrWkAZhZA1R6Gzk5BL0recEtgJSouEzuAt98Bs=;
  b=gjBF7WWT+IAXa130oO8KRTbmLT2Ed8tnHg84VTY0cuXjZuWCyC9YTm1l
   MBHF8sO4p1PUx7Zdt3p1Rs7U9V0qDoxsbYMfWPSDG42qP9pIX8whwoTZ2
   3+/HnHgBA19gY9kOT7PelFYqTVpByO8f5GUSSn7uRmNoJvU6VUGh3ugLO
   xsrI+l/DQt5i2W6KlYrgOqTbdYX1LosAp2FbKVt9A2oAsbxoIUDs9GeCb
   t3HcU8uGO0juyNX8Mxpaq+X66mTWZs62CBt+l9jwAag1E+5xEbIWnAE1h
   mXUvJx2trAvhQeBlcWOvT04qf2oWQE4KgdUnmgsp82rAuHBrkWDyLbIr6
   w==;
X-CSE-ConnectionGUID: aXGGLOy1RX28Pwd01XKozQ==
X-CSE-MsgGUID: glKQK2BKREieQL8Sh1ogcw==
X-IronPort-AV: E=Sophos;i="6.23,165,1770620400"; 
   d="scan'208";a="55012776"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 06:20:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 7 Apr 2026 06:20:20 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 7 Apr 2026 06:20:17 -0700
Date: Tue, 7 Apr 2026 15:20:16 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Herve Codina <herve.codina@bootlin.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Arnd
 Bergmann <arnd@arndb.de>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 00/10] net: lan966x: add support for PCIe FDMA
Message-ID: <20260407132016.4cfivs24ljqneyu7@DEN-DL-M70577>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
 <20260323155204.0321db13@bootlin.com>
 <20260323172640.2669232d@bootlin.com>
 <20260323194059.jjphkep4teq5rzbc@DEN-DL-M70577.microsemi.net>
 <20260324090752.0799acb1@bootlin.com>
 <20260326154833.jp6rx5x2rlpmwrg3@DEN-DL-M70577>
 <20260327113337.0368eea3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327113337.0368eea3@bootlin.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275994-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,arndb.de,linuxfoundation.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim]
X-Rspamd-Queue-Id: 7417B3AEF46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Hervé,

> >
> > As I remembered, doing rmmod on the lan966x_switch followed by modprobe
> > lan966x_switch works fine. This is because neither the switch core, nor the FDMA
> > engine is reset, so they remain in sync.
> >
> > When the lan966x_pci module is removed and reloaded (what you did), the DT
> > overlay is re-applied, which causes the reset controller
> > (reset-microchip-sparx5) to re-probe. During probe, it performs a GCB soft reset
> > that resets the switch core, but protects the CPU domain from the reset. The
> > FDMA engine is part of the CPU domain, so it is not reset.
> >
> > This leaves the switch core in a reset state while the FDMA
> > retains state from the previous driver instance. When the switch driver
> > subsequently probes and activates the FDMA channels, the two are out of
> > sync, and the FDMA immediately reports extraction errors.
> >
> > Theres actually an FDMA register called NRESET that resets the FDMA controller
> > state. Calling this in the FDMA init path causes traffic to work correctly on
> > lan966x_pci reload, but it does not get rid of the FDMA splats you posted above.
> > They get queued up between the switch core reset, in the reset controller, and
> > the FDMA enabling. I tried different approaches to drain or flush queues, but
> > they wont go away entirely.
> >
> > The only thing that seems to work consistently is to *not* do the soft reset in
> > the reset controller for the PCI path. The soft reset is actually the problem:
> > it only resets the switch core while protecting the CPU domain (including FDMA),
> > causing a desync.
> >
> > A simple fix could be (in reset-microchip-sparx5.c):
> >
> > +static bool mchp_reset_is_pci(struct device *dev)
> > +{
> > +     for (dev = dev->parent; dev; dev = dev->parent) {
> > +             if (dev_is_pci(dev))
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> >
> > -     /* Issue the reset very early, our actual reset callback is a noop. */
> > -     err = sparx5_switch_reset(ctx);
> > -     if (err)
> > -             return err;
> > +     /* Issue the reset very early, our actual reset callback is a noop.
> > +      *
> > +      * On the PCI path, skip the reset. The endpoint is already in
> > +      * power-on reset state on the first probe. On subsequent probes
> > +      * (after driver reload), resetting the switch core while the FDMA
> > +      * retains state (CPU domain is protected from the soft reset)
> > +      * causes the two to go out of sync, leading to FDMA extraction
> > +      * errors.
> > +      */
> > +     if (!mchp_reset_is_pci(&pdev->dev)) {
> > +             err = sparx5_switch_reset(ctx);
> > +             if (err)
> > +                     return err;
> > +     }
> >
> > Could you test it and see if it helps the problem on your side.
> >
> 
> I have tested it on my ARM and x86 system. It fixes the lan966x_pci module
> unloading / reloading issue.
> 
> However an other regression is present. After a reboot, without power
> off/on, the board is not working (tested on both my ARM and x86 systems).
> 
> According to your explanation, this makes sense.
> 
> IMHO, the problem is that we cannot make the assumption that "The endpoint
> is already in power-on reset state on the first probe". That's not true
> when you just call the reboot command.
> 
> Best regards,
> Hervé

The following diff should fix the FDMA traffic issue, and the FDMA error splat,
when reloading the lan966x-pci driver, by:

1. Resetting the FDMA engine on PCI init()

2. Clearing any rogue FDMA errors that may latch due to the soft reset by the
reset driver.

  diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c                                                   
  b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c                                                              
  --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c                                                          
  +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c                                                          
  @@ -372,6 +372,9 @@ static int lan966x_fdma_pci_init(struct lan966x *lan966x)                                            
        if (!lan966x->fdma)                                                                                                
                return 0;                                                                                                  
                                                                                                                         
  +     lan_wr(FDMA_CTRL_NRESET_SET(0), lan966x, FDMA_CTRL);                                                               
  +     lan_wr(FDMA_CTRL_NRESET_SET(1), lan966x, FDMA_CTRL);                                                               
  +                                                                                                                        
        fdma_pci_atu_init(&lan966x->atu, lan966x->regs[TARGET_PCIE_DBI]);                                                  
                                                            
        lan966x->rx.lan966x = lan966x;                                                                                     
  diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
  b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c                                                                  
  --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c                                                              
  +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c                                                              
  @@ -1071,6 +1071,15 @@ static int lan966x_reset_switch(struct lan966x *lan966x)                                          
                                                            
        reset_control_reset(switch_reset);                                                                                 
                                                                                                                           
  +     /* When in PCI mode, the GCB soft reset issued by the reset
  +      * controller can latch spurious bits in the FDMA error stickies.                                                  
  +      * Clear them before request_irq hooks up the FDMA IRQ line,
  +      * otherwise the handler fires immediately on probe.                                                               
  +      */                                                 
  +     lan_wr(lan_rd(lan966x, FDMA_ERRORS),   lan966x, FDMA_ERRORS);                                                      
  +     lan_wr(lan_rd(lan966x, FDMA_INTR_ERR), lan966x, FDMA_INTR_ERR);                                                    
  +     lan_wr(lan_rd(lan966x, FDMA_INTR_DB),  lan966x, FDMA_INTR_DB);                                                     
  +                                                                                                                        
        /* Don't reinitialize the switch core, if it is already initialized. In                                            
         * case it is initialized twice, some pointers inside the queue system                                             
         * in HW will get corrupted and then after a while the queue system gets                                           
  diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h                                                       
  b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h                                                                  
  --- a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h                                                              
  +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h                                                              
  @@ -1010,6 +1010,15 @@ enum lan966x_target {                                                                             
   #define FDMA_CH_CFG_CH_MEM_GET(x)\                                                                                      
        FIELD_GET(FDMA_CH_CFG_CH_MEM, x)                                                                                   
                                                            
  +/*      FDMA:FDMA:FDMA_CTRL */                                                                                          
  +#define FDMA_CTRL                 __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 424, 0, 1, 4)                                  
  +                                                                                                                        
  +#define FDMA_CTRL_NRESET                         BIT(0)                                                                 
  +#define FDMA_CTRL_NRESET_SET(x)\                                                                                        
  +     FIELD_PREP(FDMA_CTRL_NRESET, x)                                                                                    
  +#define FDMA_CTRL_NRESET_GET(x)\                         
  +     FIELD_GET(FDMA_CTRL_NRESET, x)                                                                                     
  +                                                         
   /*      FDMA:FDMA:FDMA_PORT_CTRL */                                                                                     
   #define FDMA_PORT_CTRL(r)         __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 376, r, 2, 4)

Let me know if it works on your end.

(Btw. I have noticed another issue where TX stops working on lan966x-pci reload.
It happens more rarely, but is unrelated to this patch series, as it also
happens in register-based INJ/XTR mode. Whenever that happens, you will see
"Flush timeout chip port" in the logs. This should also be fixed, but sent as a
separate fix commit, I believe.)

/Daniel


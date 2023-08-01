Return-Path: <netdev+bounces-23199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EC476B4C6
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1421281295
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478281FB47;
	Tue,  1 Aug 2023 12:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B922EE2
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 12:31:19 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF091FC8;
	Tue,  1 Aug 2023 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bzAyDaYKheMlsEXYtFHUp4oTpXTxaVR8hJ5XqEVy6bs=; b=T8N80gOQyDEqe6GTu5TM/vjPkK
	fPVcsGnPoGUrVfE+mqYNwpkz4dBH2kdKiq+43vgbRIstMoKw949841Gx/8AresWQldkOytqbsiA0G
	Q4N7SjEQeFDZSsGeUKLDj0dIC0EVyYouLMVEbwBIqWPep157qJpiTjbVk1SD8rPvBLmAi2EGLeza4
	w1+orDVNenjbr7/6T+i7BGfgdV0V0tt+ZIBFLCJsr3ZO4zhOtKnRIdWDLkBOqOfL3+5T9c2S1ciYT
	CSr0Y6+CtbcXMAgHMRoq/Hx/Z1LseEAmPAF/6KUZhoCshi4tx1VHgusSc/Enaj0+TnC5kKjdBwBde
	P9XNzCFg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52012)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qQoWq-000449-1e;
	Tue, 01 Aug 2023 13:31:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qQoWo-0000gh-I9; Tue, 01 Aug 2023 13:31:06 +0100
Date: Tue, 1 Aug 2023 13:31:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Marcin Wojtas <mw@semihalf.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 7/8] net-next: mvpp2: relax return value check for IRQ
 get
Message-ID: <ZMj7Cp3fhN7GmCZp@shell.armlinux.org.uk>
References: <cover.1690890774.git.mazziesaccount@gmail.com>
 <9738e169d83a96f18de417e62b3cf4c20f51f885.1690890774.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9738e169d83a96f18de417e62b3cf4c20f51f885.1690890774.git.mazziesaccount@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 03:04:24PM +0300, Matti Vaittinen wrote:
> fwnode_irq_get[_byname]() were changed to not return 0 anymore.
> 
> Drop check for return value 0.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Sorry, but I don't think you've properly considered the effects of your
patch.

> @@ -5833,7 +5833,7 @@ static int mvpp2_multi_queue_vectors_init(struct mvpp2_port *port,
>  			v->irq = of_irq_get_byname(port_node, irqname);
>  		else
>  			v->irq = fwnode_irq_get(port->fwnode, i);
> -		if (v->irq <= 0) {
> +		if (v->irq < 0) {

You're making this change based on the assumption that fwnode_irq_get()
has changed its return values, but I really don't think you've looked
at the code and considered the return value behaviour of the DT function
above. Reading it's documentation, it states that of_irq_get_byname()
may return 0 on IRQ mapping failure.

So, by making this change, you are allowing IRQ mapping failure in the
DT path to succeed rather than fail.

>  			ret = -EINVAL;
>  			goto err;
>  		}
> @@ -6764,7 +6764,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
>  		err = -EPROBE_DEFER;
>  		goto err_deinit_qvecs;
>  	}
> -	if (port->port_irq <= 0)
> +	if (port->port_irq < 0)

Exactly the same problem here, but...

>  		/* the link irq is optional */
>  		port->port_irq = 0;

this is less critical... but still wrong.

So, given that this patch is basically incorrect...

NAK.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


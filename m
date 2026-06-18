Return-Path: <netdev+bounces-300332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BlAAL7GaM2qIEAYAu9opvQ
	(envelope-from <netdev+bounces-300332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:13:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B8C69E02A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:13:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=o26mZh7A;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300332-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300332-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DCFD300D457
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C333750C9;
	Thu, 18 Jun 2026 07:13:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340C73101BC
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:13:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781766790; cv=none; b=LbsnUYe7zxpPbimJyT5N58KKw/d1OacxNACxBKQyhferjSR6iC5FE2iwvb0M25mZsVCxDj2MkK/3bgqE1QVnmkBkp0MsyAXHhVKuZRzAB/GPvWk+gWXTcuiuUwfJBNHOq2LqvmCjxoSd+OSsFF6GAfgvQg8AtKbSTA5LXAbgFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781766790; c=relaxed/simple;
	bh=Ez3ikU/x7+r9Ed6EbFv+aLj6wwrKN7k8sCEofzr3O8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g48BaRr2X9HdVw6Y7T7+ki7wwsO1HxCyeXdZcHSj67m2yb2uvOK9h8ujJhoixoduqH1gHN32u96UoEeT8wyu8DeU6Jam7gwI3fI3q8oNOYLtQgbRPEOwQBySP66cd6pD4PB1REBwjcrpvMOG9OKA8BbIW2Mwhb070wCyEJVWAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o26mZh7A; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so525893a91.3
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781766789; x=1782371589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KU/eD8zFijZYAE4C8J5GszRlhYqC9pFtYnLR1rm99qs=;
        b=o26mZh7AY6OBd5Ti7IBzgOKYXFFJjHn31sGZzFSR+v+y9BSMhbPhCB+VpDVL2G5uob
         MRYXl5ygs5kP6KrW4qerW+9TLvtOuSVu+HIh+dJYaySiSgmH1+FugNokzx4BR6q7q6lQ
         Lqg6FK+CaWuD/hbx9dfxJtIw/g82oiTdgSofavpvgE5CAtN4GV0spKU+KjaRxbBS8FCZ
         cpzUeR6k4o/buMelFbKYuprNvDx4N7y7yf02S0oy9WJi4jFmGZJPtIXQqGAKMXzjfW7p
         rWKaaqVOfYxPujAmZMfeNiT26PXszlKieqRlqlH23swMsiOBppfDomU3aU4HeCAS+w/j
         sZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781766789; x=1782371589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KU/eD8zFijZYAE4C8J5GszRlhYqC9pFtYnLR1rm99qs=;
        b=kZVzXcK/S/VFdkRb6N+ITzBcXp5kT8aIA0epAb2OYKy8meZVWMCY6UjW/tfuB/u+xB
         gi1Laq7M/26KLsdh6YT2qLA4gtbz+0CCL2J/VHxnWpiV4dJOR8n4cIkFzpQOm0nN0M3w
         XuGTNkymCyjitlSCyknCm+Y3aYcZk7GPYyIqP0ryYHHOv+QERW3L5jeXu+cJ7K4hBby1
         YwvP0bRlImgKL7YQ5qgEVC2dclCc1qZDhSTEazCewPurkxYrIX4cDc2uPJe1LrViiySx
         CpXtKOrjBOnsVgReyuXAlTfCmnM6dFvoolK/eTuG0YbRRnybV3/CtNC0axbEvawTndHL
         4h8g==
X-Gm-Message-State: AOJu0YzXhrPueaDh/Lw/gmUiW85wH3XsKHLINXKvU8Csr82aLEZ07k0K
	gSU8Se/nzBB/ItkmMELT/UX5b0e9+7/HeqAMZNHa5lJnHtZW4iEJKnFh
X-Gm-Gg: Acq92OF5/2sXJbl16SpewG7lRz9jofbYxrJ+EEWQdyHesJAEtjZagcNz09rTfmgqiMI
	J5oRGS37sN2AVlvJHYJ/+J6ooHwl6aF2B0KD6mlu/JFDGrfmBntYCElpyI6e/MIX3jL9kOGzsCb
	H4DjxRLa+HY9vkSF4JxLio2Y5C41UCdSSneSf8Cc3UeTABXl/YLsC8zXJ+uErKnwpbv0n7eB2vw
	FUa+YruK6UhGGUsN2Mmq4OD7WkMwz/7sxb9T6+AnH50LLESxFQGFFm75CTyiav/V4cznoEaTxdr
	okbjKAXUD+LDRRl/S9CORme5bsP0vcxecGN6UQ4z6I+xhVClvEfUu2BJEb2x0FI9cG7JXo42XDY
	I/u8T61izeq1kPBAIdH581NC4kjNdRyvwic+v9+ogJumTFXVHI+B927tkZrje93sR
X-Received: by 2002:a05:6a20:c991:b0:3b4:65ac:e2e3 with SMTP id adf61e73a8af0-3b9e5b2381dmr3247768637.5.1781766788479;
        Thu, 18 Jun 2026 00:13:08 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c889356266dsm3221211a12.6.2026.06.18.00.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:13:08 -0700 (PDT)
Date: Thu, 18 Jun 2026 15:12:58 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Yixun Lan <dlan@kernel.org>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net] net: stmmac: dwmac-spacemit: Fix wrong ctrl register
 definition
Message-ID: <ajOZnO_dFg20VnEc@inochi.infowork>
References: <20260618064143.1102179-1-inochiama@gmail.com>
 <9b39829d-92b4-4ffa-be0b-b2b0f857f58e@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b39829d-92b4-4ffa-be0b-b2b0f857f58e@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300332-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:inochiama@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:dlan@kernel.org,m:rmk+kernel@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:dlan@gentoo.org,m:looong.bin@gmail.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,m:looongbin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foss.st.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,gentoo.org,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,inochi.infowork:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18B8C69E02A

On Thu, Jun 18, 2026 at 09:03:21AM +0200, Maxime Chevallier wrote:
> Hi Inochi,
> 
> On 6/18/26 08:41, Inochi Amaoto wrote:
> > There register layout of the phy ctrl register has something wrong,
> > fix it to match the right layout
> > 
> > Fixes: 30f0ba420ed3 ("net: stmmac: Add glue layer for Spacemit K3 SoC")
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwmac-spacemit.c    | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> > index 223754cc5c79..6feffaa3ef3a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-spacemit.c
> > @@ -18,10 +18,12 @@
> >  #include "stmmac_platform.h"
> >  
> >  /* ctrl register bits */
> > -#define CTRL_PHY_INTF_RGMII		BIT(3)
> > -#define CTRL_PHY_INTF_MII		BIT(4)
> > -#define CTRL_WAKE_IRQ_EN		BIT(9)
> > -#define CTRL_PHY_IRQ_EN			BIT(12)
> > +#define CTRL_PHY_INTF_MODE		GENMASK(4, 3)
> > +#define CTRL_PHY_INTF_RMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 0)
> > +#define CTRL_PHY_INTF_RGMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 1)
> > +#define CTRL_PHY_INTF_MII		FIELD_PREP(CTRL_PHY_INTF_MODE, 3)
> > +#define CTRL_PHY_IRQ_EN			BIT(9)
> > +#define CTRL_WAKE_IRQ_EN		BIT(12)
> 
> Looks like you're fixing 2 things there :
> 
>  -> Wake on Lan probably didn't work before, as the wake irq was apparently wrong.

I guess the vendor firmware and uboot may do something for it, 
but the irq is wrong actually.

>  -> The MII mode selection apparently also changes, but maybe you don't have a
>     MII board around to test this ?
> 

Actually, the only board of the K3 is the pico-itx board, and it only has
a RGMII phy. I even doube the spacemit vendor has not tested the MII phy
well....

> Is it possible you address these issues independently (i.e. split this in 2 patches) ?
> That way, if we ever revert one, we won't re-break the other thing that was broken.
> 
> 

Yes, it is fine for me to split it. I will send it in a few days.

Regards,
Inochi


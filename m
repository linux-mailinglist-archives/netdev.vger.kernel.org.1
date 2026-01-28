Return-Path: <netdev+bounces-254211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uI8GJSPxeWnT1AEAu9opvQ
	(envelope-from <netdev+bounces-254211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:21:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE090A0382
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DE363017035
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC4933D4E4;
	Wed, 28 Jan 2026 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjjuT0O1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B275221DB5
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599211; cv=none; b=fyX4MpElKcJNXy6NY8QtKywWb8eNXYQAH02lUwZ0efmN44i7dC89ENE38gkYLtdNoIzVj47FTp/iMkoVdjtAUnsk0PLL8QwkBujmyfFMtvwY90xygceVAYrJKHHEpKsEaMRp7SO+LOW8Vn1zZGlSuIQyqeej6ZT2bQOFK+n4KkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599211; c=relaxed/simple;
	bh=HnHPH+j/OKPmgWAnhXrXBM80tftLuBhnT/v5StYFZsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHi3YK2VR1j0RC//+xwT0/+UiU+ORQP+al8PlqoygaeCTI4KIAJfMT5XrSHx3zsjWtWsMDH+hYl73/Y50/wnI/Ux+1rpnzLV6tPyd1DWuIZTzH4oog+eHIXAitYsS8AEKrDBSOMcnYGcYPL/VN8vu+giiuhicQ3fxyIM067y3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjjuT0O1; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1248d27f2b9so5334638c88.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 03:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769599210; x=1770204010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2qYF+OMHzpUpn67zzVLUIwDwbqG7uxpk42nhaKidxBE=;
        b=VjjuT0O1uqBX3s+if4gS1ZgWfRe5UV3SMIdZKd2bFv4TQ0myKZMPSw6Akli/CNnFK1
         xd+pggvp6/dnZbFKNZZ4ILIk5on+CUftAuSj4HO/tpw9XHKBIK0498QMGxlpw974xVdH
         iXoPwwZLYbk5k69tLvaZhogwSvADK9uKzkPlHVfBvBqb0m8uOJv98hlGuAAdbWhrnuH2
         5Y0WgpeUN3pfwmIkdwjMb/hWi6mqwGeCKYwA61yT9ULjghR9DQqGWX+SvAHotcJnMt6X
         UGnyXi7gUziLf/lcNRMKg3C4u6YOh0mMLAQ1op7YuyFXWvQID/e3vaCIugrhuHtYOFVL
         HzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599210; x=1770204010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qYF+OMHzpUpn67zzVLUIwDwbqG7uxpk42nhaKidxBE=;
        b=UFZ6766Bbu/PkiOd4EVGw2rDsOO1jX/yTY+lh28Hn4a1KWZGWCp8R0mUJn+g9yHBa+
         ptFFzsqd4Hl1Q3NzcHuzBDJ0x720hPZ+Gi/7Qkw1WeMf8ewrJv8kWUQ1CgCKI2/MiGUc
         h/H2yIAgKdgBkxBqEneOTYcyBjlAB9OXF4HYg4aOTNKxKJ3h25phtjoCaV9FjKfew1HE
         +RkZuxFGvGsNB6MzzM2no+aNn3SFmIEGyk/igNsY4wibS+68opbwG5lv/vvR7OCsGJq2
         B6SyRL33Cv5lK1zjm42krzFj4zpu49rvoorMjtefx8dosSat7Gvx6dPOGVQw2FX/0jWY
         TASA==
X-Forwarded-Encrypted: i=1; AJvYcCXFHwRcGra66Y0bD3pbz6nxoTe8BXTB37jgvuVhACZku/0e00QRusNJtJCu+Ke+vuZ8dvKWc8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+/dHMWyfwIKuoTUD84gNOKqJHhxI3RE3ed77lByZdn+Si45N
	wRXU/LlejBCdT1LLMRdl+1FW/bqzuWknxrCDRkXhLQp11xZ/J9eEOyry
X-Gm-Gg: AZuq6aJ0rWVxFVKrQo5mUD/zsxG5J8MICdrSvIHP32hKNrPvylZO+X92wyNHxlLXOqY
	ZOHON6vM+z6x4rBFAq42pYgkLv/mZKXVtI7VWZRuRpmzy6gz8UAwogzj0X+verwhlbdez+IN6/Z
	MTSrNDZtMf+2XRm6osJmYgFvXbsnhBZZVvEKszhPuobe8Ha3lxAKSliJ3ivK1E9gT8W1Gv6cadA
	Of7C9SMu490RcU/CBG1w664i7UYhNjSWYgRUvz9/JCYclrtX2l8gn1SdWTiTV5qlDnTclHMQkm8
	m2cBmaLv72c7VthfD6csKsVJ0rICXNxpNtfyuBMlMI/u2iGVTzIG88hnjfZ2qbzFf8OnQYBjlK5
	+t6bpp71quYCvyoDouOLX2WFN9h4P/caeIHv1W7ZdLEPoQ9965JPQxJCppyauRTULE5eyXaze1r
	mOSV9fhxzpIw==
X-Received: by 2002:a05:7022:926:b0:119:e56c:18a8 with SMTP id a92af1059eb24-124a00745c6mr2790960c88.16.1769599209402;
        Wed, 28 Jan 2026 03:20:09 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f597sm1867369c88.5.2026.01.28.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:20:09 -0800 (PST)
Date: Wed, 28 Jan 2026 19:19:50 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <ziyao@disroot.org>, 
	Yanteng Si <siyanteng@cqsoftware.com.cn>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Choong Yong Liang <yong.liang.choong@linux.intel.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Shangjuan Wei <weishangjuan@eswincomputing.com>, 
	Boon Khai Ng <boon.khai.ng@altera.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add glue layer for Spacemit
 K3 SoC
Message-ID: <aXnwlDOF40gs5L_7@inochi.infowork>
References: <20260128072931.875041-1-inochiama@gmail.com>
 <20260128072931.875041-4-inochiama@gmail.com>
 <aXnoV3Ay0uCc3HGQ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXnoV3Ay0uCc3HGQ@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254211-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,disroot.org,cqsoftware.com.cn,bp.renesas.com,bootlin.com,linux.intel.com,eswincomputing.com,altera.com,cherry.de,st.com,synopsys.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,inochi.infowork:mid]
X-Rspamd-Queue-Id: EE090A0382
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:43:35AM +0000, Russell King (Oracle) wrote:
> On Wed, Jan 28, 2026 at 03:29:29PM +0800, Inochi Amaoto wrote:
> > +#include <linux/clk.h>
> > +#include <linux/math.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "stmmac_platform.h"
> > +
> > +/* ctrl register bits */
> > +#define PHY_INTF_RGMII			BIT(3)
> > +#define PHY_INTF_MII			BIT(4)
> 
> Please add a suitable prefix for these.
> 
> > +
> > +#define WAKE_IRQ_EN			BIT(9)
> > +#define PHY_IRQ_EN			BIT(12)
> 
> While you're renaming the PHY_INTF_*, you might wish to also add the
> same prefix here to identify that they're all part of the same register.
> 

I think this is good for me. I will add the "CTRL" prefix
to identify these are all from ctrl register.

Regards,
Inochi


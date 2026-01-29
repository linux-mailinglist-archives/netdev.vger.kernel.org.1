Return-Path: <netdev+bounces-254788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELNhGStae2nXEAIAu9opvQ
	(envelope-from <netdev+bounces-254788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:01:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2057B0386
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88EA8300EC9F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B404138757E;
	Thu, 29 Jan 2026 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r42S10kY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E73446D0
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769691688; cv=pass; b=IqG+vSK+rFvayr9eWUWOyf6cRO9XP5cHBZhYvTTnzW9NTlOziSfOBDben8Q9HlAdfV1JAadod3HL4IvVBUw+2Q9kbpML6J7V7jmNfWbhISrzY587Qeca3hDIuYh4sE3FokJcMkpBiJOeGiLO9edsEP0Eb7p7JLqIym4vJ/BYZFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769691688; c=relaxed/simple;
	bh=O2bGTXjwn0dbEXJ9LllFe/AoB9VfaliGSCVigq8yX2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2g/+53QrCX0K5axa61ZmhTrJBit8Gx+S/By4vZbUEdQUCNVNbD4en3hGm1G1G46ujLxCDUABK8U02M7fDEAst1ta/5HsOfEtJml5RjhVIzP4hLt6dFsIoCHDe1ERXnFi2V7QOOTbClDXE+y9ikj/0acn7ku7pAp/dE2uGeyA94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r42S10kY; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-658b511573cso1708793a12.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:01:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769691685; cv=none;
        d=google.com; s=arc-20240605;
        b=h9oQ8hSMMMLvsJbK9FMg7w4uYKntu+Hgi2mtIEMFIccjwFx19HnHl9jxJdOcYFGlIe
         D3FmlOdxCjUyuB7Ky0ktuiyhMSf+HWPpQQPqPvOwRq7n5ZTmb32I+VIqV1HuTR5It8Bu
         u/S3hGs1GLVcCWmKa1UcB5+rp+w9a4eiPIXflQP3+b9vD9joO04LtlTeCNwTCcqPi85e
         dq0QD/KNYiHXGuG8lRcR1ZiqHMnq8xEeasBKI31dnzjvi7h07R7ywJrlUHMLluuDvrYn
         SnMkHu9zEIrgTDomv97Ok2YAqGO8qMHnkSJSuMZj8IgSemfCV+/zOpu7+XKESYAC5RUU
         s6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iesfD+1e0XJcSwTx9KNwWz9DxCNf+/Vb7CeNYX6bJos=;
        fh=872q4clmUIhZxewMs1LG71JAlzgAdfPu8SJd8ayD7uM=;
        b=hxVStqukYBxI9uhY9DkTdZti9b/GdwiYa9poqajHU3CE01vAt4QOskSksc0rdNDLqv
         An/UF0jDOj5B5kvxPBumuCMzOfP/3GiF3/k1ApuJxZHXYcZ+7lL7oCsfF6/socClJhAK
         bFrO9OB19U4wfjk64bpeqooz2NN8oul52AWx8XXTlmJkPxW2UB9muFMKjQPJBMe6k50B
         L4nxmgeQt953xhkdh+rykzu0cwRMD0vjuBk79tp8gG5iaT6vfOLe+wonARh1oE/jvvye
         hIE8Y9+vvRN3RKxLUKpQlqkoMfAwoVoYuGSD2k+1qnHXiYqczv4SYTHeyLCoz9/GeaCB
         E4pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769691685; x=1770296485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iesfD+1e0XJcSwTx9KNwWz9DxCNf+/Vb7CeNYX6bJos=;
        b=r42S10kYNTzAh+UYuMToWSR+wk/K529aGthpFdjs18St2NPYM4Nrh+6jZ5sXMQ1i5G
         BiqvtCYGxYLWSmrc8ErdOpIte3MPzMXiD/zh5botdSjhNOlMRJdAGRvt+LfzvW1qnNuv
         2xL2ERUZZsUOltXyveFG2/7zzlD8agDjNCEP+UHjqsQBPj2DbPwYAZGc3yhnugh+JeOn
         xl2/eDfxQ9esIwO1S3pZ3bISAOucrX4LdyXzdY7wDYPeGF0BLSfPxpb3uDzNPi41p14s
         72hwBug3ZRcbG3C7NNwerGkKZP35J1I+MQ5eEzS5oRWPo2SQWDo6hDgW7PXpD2AW6iGS
         +Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769691685; x=1770296485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iesfD+1e0XJcSwTx9KNwWz9DxCNf+/Vb7CeNYX6bJos=;
        b=n9AW3LCogcauLSTYMQyO+W+5vP1TQsV/gWSVwNgojuA7aCd39sRP+WwenDG4dauUG/
         +vUjmj9Te+LK6jh3C/jeoDtq0ZjhpaLRMlWSyXi25KRe6MPq1owGWk5aSh6rZYZntif5
         Oc6KKuzIm47Nm1mt+DYxonrcIUshrTBMzrUF/OMytckKZAXBCyPyzD+DdmBhI8y4JeQE
         C6baeaRgzfGaMT+hclnXVrjHoGLFw3Ac6pFm0aAfFGZzXrqImQ8l/F40pCklYVS9Da1G
         RJhsHJBUbT4FiKNbnKgczRemaLWhjDdaVDKP2fxA6ytG8OP1EAMkd35VWi6bOBuaF1IZ
         fhig==
X-Forwarded-Encrypted: i=1; AJvYcCWXr6sX7H1su9lRWDGDJcRi2T5eSBqe+6vTH0oa3sghhArMzCPaPDGgLeQgrFAQD3DwTh4u4kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHW6Hreu1zjuiTQrbw2d0OduyiKZ8kCUZ6XwJN8Ex2FOyyYSRJ
	nbgMAin5MyQTIbIttsikxDQyJg0qWjxYEhPkZIbSam3RVlK59LHjuAO1rshXU9eEwyRzQdlgBwE
	fE7AjTQfkg9y/oLvwX3CTVMMswnxG+2DllNY7BvHZvA==
X-Gm-Gg: AZuq6aL54RVPfIOG9L22efMyCg7Ld0abStyhkvaaUD0vSkUM8pX4U9yMiRZrUPrxrbU
	eUfQo5A7mSp9ZCT4vb35lPStzrHjrTgsncWlI8u47Bxkc7YAeC8W+njCV9f9U1wGfK1kIuID0iS
	XYAdVCCpDvmW7wRUBjDV7NkQn4J1BeLZfXaPau65XxzOkA//j4FSbl/l5In1ignnaFFY3W8aWrb
	Rv7+hJ/3t2Gk8dZ0qKKyD7qx72++g3CmSctrgojiuT/l+1fLCqYHlfYV+ThMTHuBeGyzBsQRjHT
	UkCtYWQPjZHRV56XoRAxuqXQ
X-Received: by 2002:a05:6402:2711:b0:658:1eee:8a40 with SMTP id
 4fb4d7f45d1cf-658a600eeb3mr6025005a12.2.1769691684890; Thu, 29 Jan 2026
 05:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092159.815968-1-vincent.guittot@linaro.org>
 <20260126092159.815968-3-vincent.guittot@linaro.org> <aXsuRTZUUnw0kdzV@horms.kernel.org>
In-Reply-To: <aXsuRTZUUnw0kdzV@horms.kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 29 Jan 2026 14:01:13 +0100
X-Gm-Features: AZwV_QjS9ru6SWfw3DDchF_hxWLgsNEurVnBwt9Mvn_TEdB82tA-dgIWwcajOmY
Message-ID: <CAKfTPtDfnpzq2CB-isVzvh1ZCWo7kit9KRJvVGoU1C3zZTgdXw@mail.gmail.com>
Subject: Re: [PATCH 2/4] phy: s32g: Add serdes subsystem phy
To: Simon Horman <horms@kernel.org>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com, 
	p.zabel@pengutronix.de, linux@armlinux.org.uk, ghennadi.procopciuc@nxp.com, 
	bogdan-gabriel.roman@nxp.com, Ionut.Vicovan@nxp.com, 
	alexandru-catalin.ionita@nxp.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	Frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254788-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:dkim]
X-Rspamd-Queue-Id: B2057B0386
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 at 10:54, Simon Horman <horms@kernel.org> wrote:
>
> On Mon, Jan 26, 2026 at 10:21:57AM +0100, Vincent Guittot wrote:
>
> ...
>
> > diff --git a/drivers/phy/freescale/phy-nxp-s32g-serdes.c b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
> > new file mode 100644
> > index 000000000000..8336c868c8dc
> > --- /dev/null
> > +++ b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
> > @@ -0,0 +1,569 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/**
> > + * SerDes driver for S32G SoCs
> > + *
> > + * Copyright 2021-2026 NXP
> > + */
> > +
> > +#include <dt-bindings/phy/phy.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
>
> Hi Vincent, all,
>
> I think that you also need:
>
> #include <linux/iopoll.h>
>
> So that read_poll_timeout() is declared.
> Else this patch causes a transient build failure
> (for x86_64 allmodconfig)

ok, i will add it

>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_address.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/processor.h>
> > +#include <linux/reset.h>
> > +#include <linux/units.h>
>
> ...
>
> > +static int s32g_serdes_phy_set_mode_ext(struct phy *p,
> > +                                     enum phy_mode mode, int submode)
> > +{
> > +     struct s32g_serdes *serdes = phy_get_drvdata(p);
> > +
> > +     if (mode == PHY_MODE_PCIE)
> > +             return -EINVAL;
>
> This is part of an AI Generated review.
> I have looked over it and I think it warrants investigation.
> For information on how to reproduce locally, as I did, please see [1].
>
> [1] https://netdev-ai.bots.linux.dev/ai-local.html
>
>   This returns error if mode IS PHY_MODE_PCIE, but this is a PCIe PHY!
>   This looks like a typo. Should be !=.

yes don't know what happened here but it should be !=

>
> > +
> > +     if (!is_pcie_phy_mode_valid(submode))
> > +             return -EINVAL;
> > +
> > +     /*
> > +      * Do not configure SRIS or CRSS PHY MODE in conjunction
> > +      * with any SGMII mode on the same SerDes subsystem
> > +      */
> > +     if ((submode == CRSS || submode == SRIS) &&
> > +         serdes->ctrl.ss_mode != 0)
> > +             return -EINVAL;
> > +
> > +     /*
> > +      * Internal reference clock cannot be used with either Common clock
> > +      * or Spread spectrum, leaving only SRNSS
> > +      */
> > +     if (submode != SRNS &&  !serdes->ctrl.ext_clk)
> > +             return -EINVAL;
> > +
> > +     serdes->pcie.phy_mode = submode;
>
> The AI review also suggested that it may be unsafe
> to set the submode after s32g_serdes_phy_power_on()
> has been called. And that there is nothing preventing that.
>
> TBH, I am unsure if either of those statements are true.
> But it seems worth validating with you.

yes, the usual pattern is :
- phy_set_mode_ext()
- then phy_power_on()
but I can add an additional check

>
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +static int s32g_serdes_get_ctrl_resources(struct platform_device *pdev, struct s32g_serdes *serdes)
> > +{
> > +     struct s32g_serdes_ctrl *ctrl = &serdes->ctrl;
> > +     struct device *dev = &pdev->dev;
> > +     int ret, idx;
> > +
> > +     ret = of_property_read_u32(dev->of_node, "nxp,sys-mode",
> > +                                &ctrl->ss_mode);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to get SerDes subsystem mode\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (ctrl->ss_mode > S32G_SERDES_MODE_MAX) {
> > +             dev_err(dev, "Invalid SerDes subsystem mode %u\n",
> > +                     ctrl->ss_mode);
> > +             return -EINVAL;
> > +     }
> > +
> > +     ctrl->ss_base = devm_platform_ioremap_resource_byname(pdev, "ss_pcie");
> > +     if (IS_ERR(ctrl->ss_base)) {
> > +             dev_err(dev, "Failed to map 'ss_pcie'\n");
> > +             return PTR_ERR(ctrl->ss_base);
> > +     }
> > +
> > +     ctrl->rst = devm_reset_control_get(dev, "serdes");
> > +     if (IS_ERR(ctrl->rst))
> > +             return dev_err_probe(dev, PTR_ERR(ctrl->rst),
> > +                                  "Failed to get 'serdes' reset control\n");
> > +
> > +     ctrl->nclks = devm_clk_bulk_get_all(dev, &ctrl->clks);
> > +     if (ctrl->nclks < 1)
> > +             return dev_err_probe(dev, ctrl->nclks,
> > +                                  "Failed to get SerDes clocks\n");
>
> If devm_clk_bulk_get_all returns 0 then this value will
> be passed to dev_err_probe(). And 0 will, in turn be returned by
> dev_err_probe() and this function. However, that will be treated
> as success by the caller, even though this is an error condition.
>
> Perhaps something like this is more appropriate if ctrl->nclks
> must be greater than 0. (Completely untested!)
>
>         if (ctrl->nclks < 1) {
>                 ret = ctrl->nclks ? : -EINVAL;
>                 return dev_err_probe(dev, ret,
>                                      "Failed to get SerDes clocks\n");
>         }
>
> Flagged by Smatch.

okay

>
> ...
>
> > +static int s32g_serdes_parse_lanes(struct device *dev, struct s32g_serdes *serdes)
> > +{
> > +     int ret;
> > +
> > +     for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> > +             ret = s32g2_serdes_create_phy(serdes, of_port);
> > +             if (ret)
> > +                     break;
> > +     }
> > +
> > +     return ret;
>
> Perhaps it cannot occur.
> But if the loop above iterates zero times,
> then ret will be used uninitialised here.

should not but will fix it

>
> Also flagged by Smatch.
>
> > +}
> > +
> > +static int s32g_serdes_probe(struct platform_device *pdev)
> > +{
> > +     struct s32g_serdes *serdes;
> > +     struct device *dev = &pdev->dev;
> > +     int ret;
> > +
> > +     serdes = devm_kzalloc(dev, sizeof(*serdes), GFP_KERNEL);
> > +     if (!serdes)
> > +             return -ENOMEM;
> > +
> > +     platform_set_drvdata(pdev, serdes);
> > +     serdes->dev = dev;
> > +
> > +     ret = s32g_serdes_get_ctrl_resources(pdev, serdes);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = s32g_serdes_get_pcie_resources(pdev, serdes);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = s32g_serdes_parse_lanes(dev, serdes);
> > +     if (ret)
> > +             return ret;
>
> The I review also says:
>
>   The probe function calls s32g_serdes_init() which enables clocks,
>   configures hardware, and deasserts reset. However,
>   s32g_serdes_parse_lanes() creates PHY providers via
>   devm_of_phy_provider_register().
>
>   Problem: PHY consumers can start calling PHY ops (like power_on) as soon
>   as the provider is registered, but the hardware isn't initialized until
>   s32g_serdes_init() runs afterward. This creates a race window.
>
>   Recommendation: Move s32g_serdes_init() before s32g_serdes_parse_lanes().

I will look at this more deeply but part of s32g_serdes_init() needs
lanes to be parsed for configuring clock

>
> > +
> > +     ret = s32g_serdes_init(serdes);
> > +
> > +     return ret;
>
> nit: This could be more succinctly written as:

fair enough

>
>         return s32g_serdes_init(serdes);
>
> > +}
>
> ...


Return-Path: <netdev+bounces-16462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6137174D59A
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 14:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780E528121B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E19BE6A;
	Mon, 10 Jul 2023 12:36:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DAE80C
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 12:36:02 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87450DB
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 05:36:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso45092945e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 05:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688992559; x=1691584559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KIIshc/sZIq3ymGFwwOVPJVYiDgQB5jTnHaHwv/X16c=;
        b=RL8oFpStLwUC4NEk0QZcXYmjcpOaQXVdWdlQTn4CUQqo/HT3JUoUcEFOrcJLLmvQkP
         dJbzK/CY7q+0SlXdl9iM07VeE6jtUcwnrru6yYg4llcbL1kSI42ME4oHb2xy96mmmHkV
         2c0/96l1ffugVNOALm6sZyd89/p4hy0vRhiY/3nM1kzBat2g9C7v/d24Qp55TUT8mkUm
         OhemllLZVRaEOH98j46bHn+WnTla0gIyapKyjYxDgDvp8O4Pcds2+ThcbnAiw5YXXx9g
         GvUEDkEPCXqXvb/CEVb/HFzHZU/pAyE8EObZFDYXcb9PnhIQ+YOnqEACbB2zzcNRT/o/
         66vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688992559; x=1691584559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIIshc/sZIq3ymGFwwOVPJVYiDgQB5jTnHaHwv/X16c=;
        b=BqktkErY7SR0uxrn5nxgTrZhotEylfykkwq5yDKkXz7sml9YEIlKMwGsy21Zlfn1z/
         P9aXMlLfTftyPVCmF1RAH8d1TZTtZoxdjcKr7ljGtACmPKFQQAGu3YMtafOcnQO1kRCI
         gMyLdw/+uf8LEhkYOhpoKPn3ZgdbNSNgAEposX7vxyE/u9NhzMwc7spVgbtWfyX1Epte
         +YNrTxa3StfiGv7Cf/mKaq+Z20mbzWPNQs1RCh11vy3H+19Dl2sygKD/yEbMvLV6I4sF
         SY2KtR7Mp3P6AB/wNdCqc3/Zr4BzClBoUQzLFmAzpRUb12ORr8zPfx+DA3AsYgcGhMun
         6PRA==
X-Gm-Message-State: ABy/qLaBCCNBiNmN2hJgt2eclY9Q+l4bgW5HK08HJSK0PeqQ0DJinvbQ
	FRn1cfl0TRYyBU+6qE82o7ThRQPCRmg=
X-Google-Smtp-Source: APBJJlFwfZda6/NPUjVjqhq627954vL86cds+y4bjXRW/BTshdRNrV1McSVcY76HyQsk9xlH44rEtA==
X-Received: by 2002:a7b:cd96:0:b0:3fc:443:3773 with SMTP id y22-20020a7bcd96000000b003fc04433773mr6456609wmj.30.1688992558548;
        Mon, 10 Jul 2023 05:35:58 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id c5-20020a7bc005000000b003fbdbd0a7desm10173509wmb.27.2023.07.10.05.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 05:35:58 -0700 (PDT)
Date: Mon, 10 Jul 2023 15:35:56 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Sergei Antonov <saproj@gmail.com>
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk
Subject: Re: Regression: supported_interfaces filling enforcement
Message-ID: <20230710123556.gufuowtkre652fdp@skbuf>
References: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 05:28:47PM +0300, Sergei Antonov wrote:
> Hello!
> This commit seems to break the mv88e6060 dsa driver:
> de5c9bf40c4582729f64f66d9cf4920d50beb897    "net: phylink: require
> supported_interfaces to be filled"
> 
> The driver does not fill 'supported_interfaces'. What is the proper
> way to fix it? I managed to fix it by the following quick code.
> Comments? Recommendations?

Ok, it seems that commit de5c9bf40c45 ("net: phylink: require
supported_interfaces to be filled") was based on a miscalculation.

> 
> +static void mv88e6060_get_caps(struct dsa_switch *ds, int port,
> +                              struct phylink_config *config)
> +{
> +       __set_bit(PHY_INTERFACE_MODE_INTERNAL, config->supported_interfaces);
> +       __set_bit(PHY_INTERFACE_MODE_GMII, config->supported_interfaces);

This is enough to fix phylink generic validation on the front-facing
ports with internal PHYs. But it is possible (and encouraged) to use
phylink on the CPU port too (rev-mii, rev-rmii); currently that's not
enforced for mv88e6060 because it's in the dsa_switches_apply_workarounds[]
array.

Could you please modify your device tree to add a fixed-link and
phy-mode property on your CPU port so that phylink does get used, and
populate supported_interfaces and mac_capabilities properly on the MII
ports (4 and 5) as well (so that it doesn't fail validation)?

> +}
> +
>  static const struct dsa_switch_ops mv88e6060_switch_ops = {
>         .get_tag_protocol = mv88e6060_get_tag_protocol,
>         .setup          = mv88e6060_setup,
>         .phy_read       = mv88e6060_phy_read,
>         .phy_write      = mv88e6060_phy_write,
> +       .phylink_get_caps = mv88e6060_get_caps

Comma at the end, please.

>  };


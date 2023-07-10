Return-Path: <netdev+bounces-16484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF1774D91C
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 16:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668232812F7
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ABC3222;
	Mon, 10 Jul 2023 14:35:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770932F2F
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 14:35:50 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0FBF2
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 07:35:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3141fa31c2bso4612021f8f.2
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688999746; x=1691591746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Py5SuVRs36Pf+OhiUvDcO9EUkwbucp12BG8ea/pOTpk=;
        b=Wef7JmvM6KJjmBYXSCrPd+k64nsBRu2IbxD9nTMqSCLbbhSEF/yvdpTDnzAFQinHEE
         iNMGIiDqYunJYSi58uyEMWrknEWLENJiMsugvxpiDQjfoc1WcCsUBK5zD3YciMF9ye2n
         QkNkZM87TGLdsW1n5RDL9XaPYxCOGNA/BmW/4X5k4HALF6uvm6IEiwWPsHoB2W3Sf2y0
         evTpTpxLiLGrzeM0mf1RcTB9XkgGiGJYC6cmjwNnPYdDUV/2JLlBhJbDgnMgeazZl5d0
         cIDrpJYqlAv2K8m5bTxZM0+ClO4kh27Zby0UnXqI8BSjPhqRiED4ISEMThnCh8tqcfPC
         MCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688999746; x=1691591746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Py5SuVRs36Pf+OhiUvDcO9EUkwbucp12BG8ea/pOTpk=;
        b=PQvTgNjiupJOHAB5VVtaPyAuof5pDbD4089j+ZbPNNRW2RxEllb7QxTyYbTjll9ypv
         j7ylWCMIjKlRBrf7STEdgde4nBrWEAfB/NVwOv8KVqZB4nS9Qe0DzDbEvYGvf8ll6HBQ
         0LYwic3PgSYmzxXZWLqCUWkvuJBXFfuJjbwwHf5lhr9HUqZzzjpQxzv7VdVzk8HwDZS5
         kG43ZFZemDQZyxGBx3kDlSpLLUO8s5f+MvM+WWE1SavvnpWvVb9l1JrJeY8URDBRMj15
         G2pIbJcpf+DBvzCBDXKSFOoZ25unikpW6AF+07VzYS1MlYiWMQ+Pffw64kIZfLgFW0Zb
         T8Jg==
X-Gm-Message-State: ABy/qLZptpJ/sZhprZSBg+MmJEyJdtSTXe0XLFr8+mjlaIo0ehwCpr2D
	0eJpwyywsE71qwEGOo8TeFtoIAdMMXCq2wRDWX4=
X-Google-Smtp-Source: APBJJlHGdmgd4TsmidhmtmI15qvc1V469fSGoMrENQlgcfjJ/GS+HVAdPB7X9eTdJ5b1vyvSo3oh5RyFLr2N8zKkg40=
X-Received: by 2002:a05:6000:1cc9:b0:314:2735:dc13 with SMTP id
 bf9-20020a0560001cc900b003142735dc13mr12844706wrb.47.1688999746270; Mon, 10
 Jul 2023 07:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
 <20230710123556.gufuowtkre652fdp@skbuf>
In-Reply-To: <20230710123556.gufuowtkre652fdp@skbuf>
From: Sergei Antonov <saproj@gmail.com>
Date: Mon, 10 Jul 2023 17:35:35 +0300
Message-ID: <CABikg9zfGVEJsWf7eq=K5oKQozt86LLn-rzMaVmycekXkQEa8Q@mail.gmail.com>
Subject: Re: Regression: supported_interfaces filling enforcement
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 10 Jul 2023 at 15:35, Vladimir Oltean <olteanv@gmail.com> wrote:
> > +static void mv88e6060_get_caps(struct dsa_switch *ds, int port,
> > +                              struct phylink_config *config)
> > +{
> > +       __set_bit(PHY_INTERFACE_MODE_INTERNAL, config->supported_interfaces);
> > +       __set_bit(PHY_INTERFACE_MODE_GMII, config->supported_interfaces);
>
> This is enough to fix phylink generic validation on the front-facing
> ports with internal PHYs. But it is possible (and encouraged) to use
> phylink on the CPU port too (rev-mii, rev-rmii); currently that's not
> enforced for mv88e6060 because it's in the dsa_switches_apply_workarounds[]
> array.
>
> Could you please modify your device tree to add a fixed-link and
> phy-mode property on your CPU port so that phylink does get used

I already have fixed-link and phy-mode on CPU port. See below.

> , and
> populate supported_interfaces and mac_capabilities properly on the MII
> ports (4 and 5) as well (so that it doesn't fail validation)?

By setting bits in .phylink_get_caps function?

Should I remove mv88e6060 from dsa_switches_apply_workarounds too?

&mdio1 {
        status = "okay";

        #address-cells = <1>;
        #size-cells = <0>;

        switch@10 {
                compatible = "marvell,mv88e6060";
                reg = <0x10>;

                ports {
                        #address-cells = <1>;
                        #size-cells = <0>;

                        port@0 {
                                reg = <0>;
                                label = "lan2";
                        };

                        port@1 {
                                reg = <1>;
                                label = "lan3";
                        };

                        port@2 {
                                reg = <2>;
                                label = "lan1";
                        };

                        port@5 {
                                reg = <5>;
                                label = "cpu";
                                ethernet = <&mac1>;
                                phy-mode = "mii";

                                fixed-link {
                                        speed = <100>;
                                        full-duplex;
                                };
                        };
                };
        };
};


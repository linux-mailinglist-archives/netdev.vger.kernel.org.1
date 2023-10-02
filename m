Return-Path: <netdev+bounces-37447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D867B5628
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0BA11281880
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C51B264;
	Mon,  2 Oct 2023 15:18:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0801A721
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:18:07 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6D1107
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:18:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so2223651866b.3
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696259884; x=1696864684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf4ZNhuPTEn2Z+23t2mZfOO20aAgYvdXy8GsiBgu4PA=;
        b=GoLeUgen9II5kXBwTvgAxPaXY8oq9oDHi8IvzttNBNQgFHUEY7T7FmQri8Ah4WM0xY
         vu+lc1cchqAc6qn8BOm+fABLECfLhIXmbBsrIJ48BwQHj9s419RVcKFazoh85YeMRkxd
         X0Yy4TVqhZFA4STkOv+tKmzI39Minvqx74HCRf/PpxnTWCrmiIetuqKmN8xaeEgd2xN3
         n5HZTAWJ/oWiHxgLiwWFsnAK4Di8bRutFZILkoiMARiceHJE46sSdbJj6sdiyaJvxcpp
         r5EGZqf4Ba13XyKs6lSmyCx1anwN/0rNFtrZZBPRMaSCoT8VcAVSaKu7KbJAuFFp26/x
         94Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259884; x=1696864684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bf4ZNhuPTEn2Z+23t2mZfOO20aAgYvdXy8GsiBgu4PA=;
        b=t60bxDnDgZSC3WpZG6Wg7lznn5qlN/dcaSNhacHEH42Sjc3jzd7wpIeMW4+h2LxaG7
         En9ZYIeicD7aNxVdiOdCo23lds2+QJ07ub3KFkfJxIT9amHj2xxvRT6kdpXlSyBvwe0l
         v3y5NXTquPjjGk7G4pFVAOVqsGC050FHLqImcE1h7ra/i/l5zsCOfLO+HpDWOG7IRJDm
         py796k1W70AarIF+0GMNwwj0OhZKkoW9U9qdnZsAtOpjHvovcuH2p19T+ov+fYvuVgbD
         /Cd7dikWZnTns/btD5ENqxFiibY4KVZaX47OQNupX95jCSKUAXvc3RV4ytMaKEcAtWoF
         270Q==
X-Gm-Message-State: AOJu0YwLoBGj+3XsQ2GQd6t2NhTIok4hm71q9fS5QnF6E6tSWUL465cC
	nxpilj5xWtfVoZMAM5BApa4=
X-Google-Smtp-Source: AGHT+IE/ItgUGymnepNrrbl5yIUtcIkxs6IYv1D2G8pKdeZY3XS+nDz9H28wjwX8hTrvPzRxk75ZDA==
X-Received: by 2002:a17:906:10cc:b0:9ae:56ad:65a7 with SMTP id v12-20020a17090610cc00b009ae56ad65a7mr12407824ejv.45.1696259883385;
        Mon, 02 Oct 2023 08:18:03 -0700 (PDT)
Received: from skbuf ([188.25.255.218])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709062a4500b009934b1eb577sm17399795eje.77.2023.10.02.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:18:03 -0700 (PDT)
Date: Mon, 2 Oct 2023 18:18:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Ar__n__ __NAL <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt753x: remove
 mt753x_phylink_pcs_link_up()
Message-ID: <20231002151800.z7zcad2lw4jxjebk@skbuf>
References: <E1qlTQS-008BWe-Va@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qlTQS-008BWe-Va@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 01:13:56PM +0100, Russell King (Oracle) wrote:
> Remove the mt753x_phylink_pcs_link_up() function for two reasons:
> 
> 1) priv->pcs[i].pcs.neg_mode is set true, meaning it doesn't take a
>    MLO_AN_FIXED anymore, but one of PHYLINK_PCS_NEG_*. However, this
>    is inconsequential due to...
> 2) priv->pcs[port].pcs.ops is always initialised to point at
>    mt7530_pcs_ops, which does not have a pcs_link_up() member.
> 
> So, let's remove mt753x_phylink_pcs_link_up() entirely.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>


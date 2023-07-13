Return-Path: <netdev+bounces-17599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF6D7524AB
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C073281DEB
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157E517ABB;
	Thu, 13 Jul 2023 14:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5F6FB1
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 14:10:30 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D18426AE
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:10:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-993d1f899d7so112805266b.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 07:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689257428; x=1691849428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEkEcpSgWRNVvWIlxhnvpRXuThAMDSeCvhuSKlc3m2o=;
        b=JY+jgDedMnvLJc8fWlra11n1a3TfHdpw4R7X1BCx/y00+CxWQEcwXPKzMYez03vE5a
         9/aPq3Q0BvW8ffn7DnvcdFC+Z6TCU8YQ9z5PIezd7VYeJLCerCALgcE+M6riu/+VSrPR
         9wdnI8bfUgmVPdhVpJdWA6w7GQCozsIotymNIOpsjkyv5yAzIvCH+jbZx8gk7XNf9wjs
         CyC6qovyX6Zw05rXKzC29Xu+8T+8E8tjUhYE263GhdxoS7H8dkUOmb7ZoaTCentgWbUk
         pQlweOxRZeo7s92WbqNAwsm4YVvLWjyAOr/sEd+lRHJNWTsxagJWFX+CKVeCIeIrrsKU
         Q9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257428; x=1691849428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEkEcpSgWRNVvWIlxhnvpRXuThAMDSeCvhuSKlc3m2o=;
        b=BK23fLSbV0VgzSUYv6ILQCMiD1VZS8pG/oNktwzI2xzEY6HsBusoOQudMUF5pVLndY
         dEc+Jenpe2V9/yeq8pvaZagTxiscdYCmjyskZTd/wjofPLBUhmB/ggicRX4gWS95gX7G
         iSoibCONkE+usRezMBL9Yu7i4e49+UaIu6NXlVlrXk/gqTS9c3Q47e6rzgfEvtGQYEPx
         DeraP3OS/zpPfmGKhrvNn1OJX1zQxQsxOjdRhyWGei/fszyPCWZFotLeqLVbitESb9b1
         3tUkmlAxi04JRL9TWIwV181x5JBvci0OQnAjxgoR5dUF3ZtbbSwHwT4JnXigrRYIh+k0
         hbfA==
X-Gm-Message-State: ABy/qLbY8dE/9lL+Mi+UgMUy9OmvqEFKs5ya17ewr3xrop/bbb+P0Beo
	jKYVwlHVjsRJ9dDSGrQBNbA=
X-Google-Smtp-Source: APBJJlGkmFZ80EVKp1KguNT3C/d2x+U/9puUfrNGR3M2/1GYwkbbQ0ZDrFZdJ03cjIuIVSuXW6oHhA==
X-Received: by 2002:a17:906:3f1c:b0:98d:f953:f473 with SMTP id c28-20020a1709063f1c00b0098df953f473mr1604969ejj.50.1689257427756;
        Thu, 13 Jul 2023 07:10:27 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:9d33:114d:9337:5e4d])
        by smtp.gmail.com with ESMTPSA id pw20-20020a17090720b400b009786ae9ed50sm4043430ejb.194.2023.07.13.07.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:10:27 -0700 (PDT)
Date: Thu, 13 Jul 2023 16:10:21 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/4] net: phy: add the link modes for
 1000BASE-T1 Ethernet PHY
Message-ID: <ZLAFzaN7IRzerGpX@eichest-laptop>
References: <20230710205900.52894-1-eichest@gmail.com>
 <20230710205900.52894-2-eichest@gmail.com>
 <cad4c420-470d-497a-9a1d-a43654af9a7e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cad4c420-470d-497a-9a1d-a43654af9a7e@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrew,

On Mon, Jul 10, 2023 at 11:10:17PM +0200, Andrew Lunn wrote:
> On Mon, Jul 10, 2023 at 10:58:57PM +0200, Stefan Eichenberger wrote:
> > This patch adds the link modes for the 1000BASE-T1 Ethernet PHYs. It
> > supports 100BASE-T1/1000BASE-T1 in full duplex mode. So far I could not
> > find a 1000BASE-T1 PHY that also supports 10BASE-T1, so this mode is not
> > added.
> 
> Is this actually needed? Ideally you want to extend
> genphy_c45_pma_read_abilities() to look in the PHY registers and
> determine what the PHY can do. You should only use .features if it is
> impossible to determine the PHY abilities by reading registers.

Unfortunately the MDIO_PMA_EXTABLE register does not work on this PHY.
It will not signalize that it is BT1 capable (MDIO_PMA_EXTABLE_BT1). I
tested it again (should be 0x0800):
root@verdin-imx8mp-14777637:~# ./phytool read eth0/7:1/11
0x0020
The PHY documentation does not list this register at all.

Even though the MDIO_PMA_PMD_BT1 exists and works correctly:
root@verdin-imx8mp-14777637:~# ./phytool read eth0/7:1/18
0x0003
This register is documented in the datasheet again.

So unfortunately I think I have to force the features, or do you see
another possibility?

Regards,
Stefan


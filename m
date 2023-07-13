Return-Path: <netdev+bounces-17561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B05752041
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16531C21272
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ECD11C9E;
	Thu, 13 Jul 2023 11:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A68100CE
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:41:39 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D262123
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:41:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e590a8ab5so756313a12.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689248466; x=1691840466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYn1xiwWvev+wcwyHFa2B8ci9P2T3l/8wXVLYJm21Ug=;
        b=RvrEHRK3IY6VQR/Nd4BHA1fUaehtXCq/JcCtnKw13dcrOQ4f2kIPKaHPE4VnxpAHdt
         LRysP9avDd2Nx3CjM0jIklrqrmxXdHvRakAw6ZLv0fd66tE6HSU6cjFGtih4oj6jPths
         r7BetnbFlXrbWH0SjCH9P1mkf2axjcekf4UN8BZZCCYQMxVqACtrDdWuOMzNByg1iWPV
         97bw5b1jElF2YnfU6a2TAJ4t5n1GUKyu2iA1HBU6T0BPnC4oY4wojdIoqryyskzC7yB5
         emSyrmkii57Hu3fu2eUCrhdG3KpUzqFSgvKQcmrNksaN+UmLycQoh7GBAWoRLa11TAIj
         hQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689248466; x=1691840466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYn1xiwWvev+wcwyHFa2B8ci9P2T3l/8wXVLYJm21Ug=;
        b=Wk7NJo+MBjfF6WEjQxmtUQ2WIXoAj9ZK5+TDRbw0OpN8rAMOumjkn3XK23RWWvXVUn
         Q0P38ajY/sJyQuOJbxUbLej3p5Pzj85G/iYmx13PNnrQL5Oyb0KYSaGzaIOcE7bSPudB
         dL0YowRzBUh96FEflGwQbvaC+gHij/pTTXsP+QepnxCKd+AEtb+2W5aVuzVaSq7jJ+AX
         L980mhUnjKK8NhQF+V/LcvL9uhuRXKwc1YZAW2AauamU4joCr9fNnIjJKycDSw1iAXcf
         JtZ62C2QivMy08hfydwDaCMP7p6DsTlPEd9wvDsd2BmgHPGY0ODHW6bQO/PIRBqetWH5
         t2fw==
X-Gm-Message-State: ABy/qLaMQMM02VjZvOpkY9+WktXNrumiPWI5OvLhgqfLPLAMhMcRQyW3
	MwAWmgal7vkSW9JZ4BAxCBE=
X-Google-Smtp-Source: APBJJlEc6HcBpMQZig1dSSP9AeYWGb5pcpDbMlsjmlIhG8h3z7AkCr089VTjuLRnAnv70YosuBf8mw==
X-Received: by 2002:a17:906:24f:b0:993:ffcb:ad56 with SMTP id 15-20020a170906024f00b00993ffcbad56mr1507339ejl.10.1689248466368;
        Thu, 13 Jul 2023 04:41:06 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:9d33:114d:9337:5e4d])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090616ce00b0094e7d196aa4sm3841154ejd.160.2023.07.13.04.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 04:41:05 -0700 (PDT)
Date: Thu, 13 Jul 2023 13:41:04 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, francesco.dolcini@toradex.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 4/4] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2110 PHY
Message-ID: <ZK/i0AEC6nfSDZCG@eichest-laptop>
References: <20230710205900.52894-1-eichest@gmail.com>
 <20230710205900.52894-5-eichest@gmail.com>
 <2de0a6e1-0946-4d4f-8e57-1406a437b94e@lunn.ch>
 <ZK/G9FMPSabQCGNk@eichest-laptop>
 <ZK/Of27YzREq+Z9V@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/Of27YzREq+Z9V@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russell,

Thanks for your reply.

On Thu, Jul 13, 2023 at 11:14:23AM +0100, Russell King (Oracle) wrote:
> On Thu, Jul 13, 2023 at 11:42:12AM +0200, Stefan Eichenberger wrote:
> > With this we will detect link loss in polling mode and read the realtime
> > status in non-polling mode. Compared to genphy_c45_read_link we will not
> > immediately return "link up" in non polling mode but always do the
> > second read to get the realtime link status.
> 
> Why do you think that's better? "Link" only latches low, and the
> entire point of that behaviour is so that management software can
> detect when the link has failed at some point since it last read
> the link status.
> 
> There is only any point in re-reading the status register if on the
> first read it reports that the link has failed, and only then if we
> already knew that the link has failed.
> 
> If we're using interrupt mode, then we need the current link status
> but that's only because of the way phylib has been written.
> 

I agree with you. I missunderstood how the link status worked. I thought
it will always show the status since the last read, independent of
whether it went up or down. But it only latches link down.

> > If we are only interested in the link status we could also skip the
> > remote and local receiver check. However, as I understand the software
> > initialization guide it could be that the receivers are not ready in
> > that moment.
> 
> With copper PHYs, link up status means that the link is ready to pass
> data. Is this not the case with T1 PHYs?

If I interpret their documentation correctly, they differentiate between
PMA and PCS. The PMA link status could be up while the PCS link status
is not. Maybe when the cable test is running this happens. Therefore, I
keep the read for MDIO_MMD_AN_MV_STAT for now.

Regards,
Stefan


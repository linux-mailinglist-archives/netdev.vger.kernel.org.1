Return-Path: <netdev+bounces-18474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90344757523
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2AD1C20BC3
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 07:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6935393;
	Tue, 18 Jul 2023 07:16:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8B253D4
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:16:37 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049F410E4
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 00:16:36 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52173d4e9f9so4425399a12.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689664594; x=1692256594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8KO3FM/0N+UezERFdqzBtwss6ITuBphrsZoEGOGcKg=;
        b=b2SVZ++eyuQArlaI9MQOQ99AKfUnU0heKb+24BAlEJ2odOuVNPR0LO4jU9PR3waI38
         9p/dbojGfE3zkKYRqR67KNLOYjT2R+EMDtZvAw4FN0VevJTzCrFcvxgsENLPjSHBPDoS
         2k++JdxEAtSoWpR4l+uh9fklkJaX3wC+dBYiDvfm1bJgP3vc298k+ua+U/ulR8Ne3O2y
         tR5baMg4XlqVPbrf3c7lnU9ou3p7yrVX5FtH7KvkeVJ8Is7YAthaPLecV1YNrYTY+8dj
         kEW2owE7GIRjDjjfDKN8TCW73GlCl0tuo2Vmo1PbkrsFd86H1CkTlp5Z9OT/lxlFVk+V
         2Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689664594; x=1692256594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8KO3FM/0N+UezERFdqzBtwss6ITuBphrsZoEGOGcKg=;
        b=jYr9iZfZLAW0RSYS866ahW56WOz1RjT9MoK8Cyh39yVRgzbmUFnAR6r6orkWIxym/p
         Iiz3lkExK95eQEmGQQQA6WefOdhEXgkw9//OWsZXX47guu+oyI8EXICcUDESSFPImF4P
         VEf69n7A+SBnzbpO4lGWIB+XjHoKtAIQjNFAied6pytoVpaqYhBdz/Hu41IjuXbZXjzF
         KREkEcVdcbG3lAiSudRfugixvPe8UZpKnKlijBUgvYPq0ocrVDHQhQYZqxQp83+RbHMK
         /FccqtzMsKEQUoCqcd9wOpkLogOS7zTa4fr3Cuqmo3YoTW0TFL+tNYTDnQ1e2Rv0Kfnz
         ZMQg==
X-Gm-Message-State: ABy/qLb377jo2/UkXziWBwHtdyPJl7uqYi9tcOfuJX5hlSWK1stPSHRW
	wPevUdLdn8TRQ3GAcxEC1jo=
X-Google-Smtp-Source: APBJJlEwatHiKn2molEKbDQNFpvlDjwFur5x8P36ryonC3dDV+e8m5nC9FTh3IFkTFbTcDGUbCjLZg==
X-Received: by 2002:a05:6402:2037:b0:51a:2c81:72ee with SMTP id ay23-20020a056402203700b0051a2c8172eemr12920439edb.20.1689664594271;
        Tue, 18 Jul 2023 00:16:34 -0700 (PDT)
Received: from eichest-laptop ([178.197.207.3])
        by smtp.gmail.com with ESMTPSA id k26-20020a056402049a00b0051e186a6fb0sm770013edv.33.2023.07.18.00.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:16:34 -0700 (PDT)
Date: Tue, 18 Jul 2023 09:16:32 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	francesco.dolcini@toradex.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 5/5] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2110 PHY
Message-ID: <ZLY7+aM4IUw+T3cH@eichest-laptop>
References: <20230717193350.285003-1-eichest@gmail.com>
 <20230717193350.285003-6-eichest@gmail.com>
 <dbd85f63-6abc-4824-a5ec-3ed5f270ffeb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd85f63-6abc-4824-a5ec-3ed5f270ffeb@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrew,

On Mon, Jul 17, 2023 at 11:54:39PM +0200, Andrew Lunn wrote:
> > +#define MARVELL_PHY_ID_88Q2110	0x002b0981
> 
> > +
> > +static struct phy_driver mv88q2xxx_driver[] = {
> > +	{
> > +		.phy_id			= MARVELL_PHY_ID_88Q2110,
> > +		.phy_id_mask		= MARVELL_PHY_ID_MASK,
> 
> Probably not an issue...
> 
> The ID you have above is for revision 1 of the PHY. But the mask will
> cause the revision to be ignored. Do you want to ignore the revision?
> Are there different errata for revision 0 and 1?

A0 to A2 (Rev 1-3) are the same software wise for the current scenarios.
Z0 (Rev 0) might behave slightly different in the reset scenario but
most likely it works as well. Unfortunately, I could not test it because
I don't have such a device.

Regards,
Stefan


Return-Path: <netdev+bounces-46843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112C47E6A5E
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 13:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305E61C208A8
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8DC1B268;
	Thu,  9 Nov 2023 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEYezGod"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0441D55F
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 12:14:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1DF2D7C
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 04:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699532042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAh9L8BgLNMrWbHh/2X3B2F2bnI/8yZ4Lx19OACfIMU=;
	b=XEYezGodwyRfTeMyP5KcbCsNoiL6vJ40n/uMGH4VFvMBvn1fTVb0WQLSj2w97/EB6ClFzy
	P/DhGwhiOtf64EnwW9SnO1eQzGvxPAO7GijFEnuAjZTuxIDuG9olfRDOep/V1k/p/h4+NB
	3BkXKImC4LiuQBDrPOoHFZT7oDQd17o=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-MKMgAX6SOQKuo8HRqD6IMg-1; Thu, 09 Nov 2023 07:14:00 -0500
X-MC-Unique: MKMgAX6SOQKuo8HRqD6IMg-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7ba0f486647so88548241.0
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 04:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699532040; x=1700136840;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gAh9L8BgLNMrWbHh/2X3B2F2bnI/8yZ4Lx19OACfIMU=;
        b=h4rOxUFh7vl396lxXXRyMHK8Mr0sYlc5cdRrJCo92sgQdOCN+2ke5nnFLzP4XUTioA
         KhwLK2nMxp56l3BDsMKIeSTW8Gt37wh7a5/OkF5zfBRG6+BCEZuCj8LUBPaKJkaN7iGI
         CnkatwAR2LSJ2odU7+isE/QNW5aqj2WAbQsmAynf750g13d5xyyJ/K/MxfC9obj9AfuS
         tqSeGnxG10IkxvMAWhn1DBLQ0g4ZL1pTAbvrkR52tVUj2c+ug++mCRlYWdA1Qbg2o57p
         +Pbfeeg996Ca5I5J3KWYt/FEUoQBGezg5HMJ7eUPRiz9N4YT+TRb0LgmoX7CVd3mq7py
         fsug==
X-Gm-Message-State: AOJu0Yzu9SBmZmNiOY8DOENl5++FUFyaLJFQib2V40IuSDEFaCCnL4rH
	5L/LRkHlR1YQ5WCfkLfUfw73rvG8RyTpYInxigMEDbGUiYWrLjS8riuuKdJttIww6LClqvs3ANC
	6gi7sfeBSnFmxAwcN
X-Received: by 2002:a05:6122:1524:b0:4ab:ebf6:d33a with SMTP id g4-20020a056122152400b004abebf6d33amr4434044vkq.1.1699532040205;
        Thu, 09 Nov 2023 04:14:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEAxY0nj/0v5nor7NxsmD9RUNljGGVM05DfuLXm6QO9KoxG2lCVGMBL0SkNm/L5qih3hGBuQ==
X-Received: by 2002:a05:6122:1524:b0:4ab:ebf6:d33a with SMTP id g4-20020a056122152400b004abebf6d33amr4434027vkq.1.1699532039848;
        Thu, 09 Nov 2023 04:13:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id m13-20020ad4504d000000b0064f3b0d0143sm1993411qvq.142.2023.11.09.04.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 04:13:59 -0800 (PST)
Message-ID: <01aa11e0c8b0aebb1340b5702a42b20c7a7aabd9.camel@redhat.com>
Subject: Re: [PATCH net 1/1] net: stmmac: fix MAC and phylink mismatch issue
 after resume with STMMAC_FLAG_USE_PHY_WOL enabled
From: Paolo Abeni <pabeni@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Gan Yi Fang
	 <yi.fang.gan@intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Joakim Zhang
 <qiangqing.zhang@nxp.com>,  netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Looi
 Hong Aun <hong.aun.looi@intel.com>, Voon Weifeng <weifeng.voon@intel.com>,
 Song Yoong Siang <yoong.siang.song@intel.com>
Date: Thu, 09 Nov 2023 13:13:55 +0100
In-Reply-To: <ZUyjOEQHHnnbzwrV@shell.armlinux.org.uk>
References: <20231109050027.2545000-1-yi.fang.gan@intel.com>
	 <ZUyjOEQHHnnbzwrV@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-09 at 09:15 +0000, Russell King (Oracle) wrote:
> On Thu, Nov 09, 2023 at 01:00:27PM +0800, Gan Yi Fang wrote:
> > From: "Gan, Yi Fang" <yi.fang.gan@intel.com>
> >=20
> > The issue happened when flag STMMAC_FLAG_USE_PHY_WOL is enabled.
> > It can be reproduced with steps below:
> > 1. Advertise only one speed on the host
> > 2. Enable the WoL on the host
> > 3. Suspend the host
> > 4. Wake up the host
> >=20
> > When the WoL is disabled, both the PHY and MAC will suspend and wake up
> > with everything configured well. When WoL is enabled, the PHY needs to =
be
> > stay awake to receive the signal from remote client but MAC will enter
> > suspend mode.
> >=20
> > When the MAC resumes from suspend, phylink_resume() will call
> > phylink_start() to start the phylink instance which will trigger the
> > phylink machine to invoke the mac_link_up callback function. The
> > stmmac_mac_link_up() will configure the MAC_CTRL_REG based on the curre=
nt
> > link state. Then the stmmac_hw_setup() will be called to configure the =
MAC.
> >=20
> > This sequence might cause mismatch of the link state between MAC and
> > phylink. This patch moves the phylink_resume() after stmamc_hw_setup() =
to
> > ensure the MAC is initialized before phylink is being configured.
>=20
> Isn't this going to cause problems?
>=20
> stmamc_hw_setup() calls stmmac_init_dma_engine(), which then calls
> stmmac_reset() - and stmmac_reset() can fail if the PHY clock isn't
> running, which is why phylink_resume() gets called before this.

@Gan Yi Fang: at very least we need a solid explanation in the commit
message why this change don't cause the above problems.

Thanks,

Paolo



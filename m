Return-Path: <netdev+bounces-40273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5217C6780
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 10:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1EA1C20ABA
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1C11C2B4;
	Thu, 12 Oct 2023 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ki8ssBT+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E8718B1C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 08:20:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07F8CC
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 01:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697098822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUQGFZibjWLbHGD7MkFyWjWgEq0nesz4IaEchkjp01E=;
	b=Ki8ssBT+GSBw61OcAct8DQQKRSg2Z07GRZyI8jcbGUlJ+nmkqxSPU4n19d0G86y2ffuazU
	rgBH8T7TFdLn0UHZFVMKKKxcBQsvfpxkPCen7Z6ngm42ScP0hrMbxLoxruRKDQb+PJUn8h
	apGRt1QExIw7S4HryYjpTkvYnYa8XBY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-ImzrdZXfMBOJbgO8dJVnMg-1; Thu, 12 Oct 2023 04:20:15 -0400
X-MC-Unique: ImzrdZXfMBOJbgO8dJVnMg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b9a1dd5843so14610766b.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 01:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697098814; x=1697703614;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUQGFZibjWLbHGD7MkFyWjWgEq0nesz4IaEchkjp01E=;
        b=cLGu2aUwZCbhWnShn7b8h8EEMWotydz3GPZdoWkzRPH1yEMUmpJiCDZhCULR3ghoKP
         IH3JRakzcSKsqZtJchDU3XN0iqV2+G3ayjPR6hHDMf6rIq7kha3OymM008WI5GnuSP2d
         9dCmJ0uobrJnRS3vO47k+ia/txeQkgKtnTzMx7QgLC/2uw47mLyKkhV/oxLyowvv/cdc
         yF1wW2OR8hrDsJRX4clGDlUDLHcUUSMKp8STusb+//P465ShVEifsmk+cZBoKV2f8lk2
         7eGIELX/I1T8C/e2AKV+ZVlSz7CMaRBQluDIyzWHe0vrGxwY0DDSF+6tXxyjEhG3ppjS
         P5og==
X-Gm-Message-State: AOJu0YwLGcyAi+U1PZWdkDGe9XRKCCznuIINGqtUsQ7TnbA0FdRX9vRr
	7akAeVm8zwTlKgQZyqfcco1wby9IcV+nxhJXJnVRIStma+HvLf0g4Z0uOB6RIbrYnPjfSI0HsJk
	Ag3LAU9X2W1cwvvrHFpaEWFvI
X-Received: by 2002:a17:906:5308:b0:9b2:b532:d8d7 with SMTP id h8-20020a170906530800b009b2b532d8d7mr19609959ejo.5.1697098814248;
        Thu, 12 Oct 2023 01:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmtmCJxaUaeLtHi5RVZPHhGXh9jaLCD3x/MRiZ5QnXRXTXc+xC7HkDo64T2no3UQEvF/oS4A==
X-Received: by 2002:a17:906:5308:b0:9b2:b532:d8d7 with SMTP id h8-20020a170906530800b009b2b532d8d7mr19609936ejo.5.1697098813773;
        Thu, 12 Oct 2023 01:20:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-181.dyn.eolo.it. [146.241.228.181])
        by smtp.gmail.com with ESMTPSA id dx12-20020a170906a84c00b009b977bea1dcsm10765401ejb.23.2023.10.12.01.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 01:20:13 -0700 (PDT)
Message-ID: <438bdacdfe2b50534d30d5d51660c4a7c3ba4f66.camel@redhat.com>
Subject: Re: [PATCH net] net: davicom: dm9000: dm9000_phy_write(): fix
 deadlock during netdev watchdog handling
From: Paolo Abeni <pabeni@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Francois Romieu
	 <romieu@fr.zoreil.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Kalle Valo
 <kvalo@kernel.org>,  Wei Fang <wei.fang@nxp.com>, kernel@pengutronix.de,
 stable@vger.kernel.org
Date: Thu, 12 Oct 2023 10:20:11 +0200
In-Reply-To: <20231011-said-hemlock-834e5698a7a3-mkl@pengutronix.de>
References: <20231010-dm9000-fix-deadlock-v1-1-b1f4396f83dd@pengutronix.de>
	 <20231010222131.GA3324403@electric-eye.fr.zoreil.com>
	 <20231011-said-hemlock-834e5698a7a3-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-11 at 08:43 +0200, Marc Kleine-Budde wrote:
> On 11.10.2023 00:21:31, Francois Romieu wrote:
> > Marc Kleine-Budde <mkl@pengutronix.de> :
> > > The dm9000 takes the db->lock spin lock in dm9000_timeout() and calls
> > > into dm9000_init_dm9000(). For the DM9000B the PHY is reset with
> > > dm9000_phy_write(). That function again takes the db->lock spin lock,
> > > which results in a deadlock. For reference the backtrace:
> > [...]
> > > To workaround similar problem (take mutex inside spin lock ) , a
> > > "in_timeout" variable was added in 582379839bbd ("dm9000: avoid
> > > sleeping in dm9000_timeout callback"). Use this variable and not take
> > > the spin lock inside dm9000_phy_write() if in_timeout is true.
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > ---
> > > During the netdev watchdog handling the dm9000 driver takes the same
> > > spin lock twice. Avoid this by extending an existing workaround.
> > > ---
> >=20
> > I can review it but I can't really endorse it. :o)
> >=20
> > Extending ugly workaround in pre-2000 style device drivers...
> > I'd rather see the thing fixed if there is some real use for it.
>=20
> There definitely are still users of this drivers on modern kernels out
> there.
>=20
> I too don't like the feeling of wrapping more and more duct tape
> around existing drivers. How about moving the functionality to
> dm9000_phy_write_locked() and leave the locking in dm9000_phy_write().
> I will prepare a patch.

If you have the H/W handy to try some more invasive change, I'm
wondering if you could schedule a work from dm9000_timeout() and there
acquire all the needed locks.=20

Cheers,

Paolo



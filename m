Return-Path: <netdev+bounces-29588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 973F1783E97
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 13:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B2A1C2037D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806561172D;
	Tue, 22 Aug 2023 11:12:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696659447
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 11:12:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0451ACC8
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 04:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692702751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muADhbgSLn0DEyqi6FAB1jDCqlzA9c1XZkMSrZIK8vE=;
	b=J0Y6SwPh6HWyH6vSVdWYp+Fz8XN5Q/Xk4TJmF5+CgEYgKxHtn+7qAzKHkucfmahPP4jsSS
	eoL+jntlHIGlEfBJ7gKO7iQDVSCwM7em3V6VLDbXCqt+slrqHKybFDaoh2Tl7OjEfsYJDb
	Y5NS83UWlIRW1cm9HZtlDKgZ0QCqJKc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-BbaSANUiNP25WeNlLlKGcw-1; Tue, 22 Aug 2023 07:12:30 -0400
X-MC-Unique: BbaSANUiNP25WeNlLlKGcw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5009005a5fdso125159e87.0
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 04:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692702748; x=1693307548;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=muADhbgSLn0DEyqi6FAB1jDCqlzA9c1XZkMSrZIK8vE=;
        b=VBE8r28ulaWobwj8ZxnRTvapn/SJEWrkUKHw78oiFL0mHiOaAOWr35mUrhgttpI9L5
         ATrxvP79bfqtFcTfcSlL63cOywQBqPp8bXATx83vtnXIN89Ffy+TNhdwNLtTEolxvxUs
         y7smJY9bhWKkGap6F4Ib4cK9qQab1i40XgUuHoJlyx6viBaClLIJ3SbBaQVJr6oIM28v
         GH9KWqmvvNR1zmYCk9xQ4gbrJc0WwgrsSrG+Z6cDzci+4OeKLBHYAPagKx0NnZQY5o5R
         nUhhgLHJ4L3tHqVdUhZjgKXWbx759nzxjygboDuKWTwMdwqfM2KEctht+ph08wnLE2Sq
         pb6Q==
X-Gm-Message-State: AOJu0YyeZ+41K2nTE6dfaLFESZfN6+LSIG6cIESoyJkiaVB6tfIKaqJR
	BpaYDfx/YDrmU/7AZQuD/a9qLPgMmzEHz33EKcu82olivxmMjSxgb5Q8wS4Ik94PlqgwjK3VRJ0
	9zL02G4jTb2avgkES
X-Received: by 2002:ac2:4a74:0:b0:500:8681:4066 with SMTP id q20-20020ac24a74000000b0050086814066mr2153282lfp.6.1692702748489;
        Tue, 22 Aug 2023 04:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFADyHw9+4kF3gxwWBb/UBmgg1iQ7GiprxPqucEMRAbRZEcIdUMdFglOJ80BgG9FH6T4203Q==
X-Received: by 2002:ac2:4a74:0:b0:500:8681:4066 with SMTP id q20-20020ac24a74000000b0050086814066mr2153261lfp.6.1692702748130;
        Tue, 22 Aug 2023 04:12:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id w9-20020a056402070900b00525683f9b2fsm7387270edx.5.2023.08.22.04.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 04:12:27 -0700 (PDT)
Message-ID: <f922ac8896974b3823d238894498c8e135f862b6.camel@redhat.com>
Subject: Re: [net PATCH V3 2/3] octeontx2-af: CN10KB: fix PFC configuration
From: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>, Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
 hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 22 Aug 2023 13:12:26 +0200
In-Reply-To: <20230822071607.GJ2711035@kernel.org>
References: <20230821052516.398572-1-sumang@marvell.com>
	 <20230821052516.398572-3-sumang@marvell.com>
	 <20230822071607.GJ2711035@kernel.org>
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

On Tue, 2023-08-22 at 09:16 +0200, Simon Horman wrote:
> On Mon, Aug 21, 2023 at 10:55:15AM +0530, Suman Ghosh wrote:
> > From: Hariprasad Kelam <hkelam@marvell.com>
> >=20
> > The previous patch which added new CN10KB RPM block support,
> > has a bug due to which PFC is not getting configured properly.
> > This patch fixes the same.
>=20
> Hi Suman,
>=20
> I think it would be useful to describe what the bug is - it seems like an
> incorrect mask in some cases - and how that might affect users. Better
> still would be commands for an example usage where the problem previously
> manifested.

Suman, please address Simon's feedback above in the new iteration.

> >=20
> > Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
> > Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> > ---
> >  drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/=
net/ethernet/marvell/octeontx2/af/rpm.c
> > index b4fcb20c3f4f..af21e2030cff 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
> > @@ -355,8 +355,8 @@ int rpm_lmac_enadis_pause_frm(void *rpmd, int lmac_=
id, u8 tx_pause,
> > =20
> >  void rpm_lmac_pause_frm_config(void *rpmd, int lmac_id, bool enable)
> >  {
> > +	u64 cfg, pfc_class_mask_cfg;
> >  	rpm_t *rpm =3D rpmd;
> > -	u64 cfg;
> > =20
> >  	/* ALL pause frames received are completely ignored */
> >  	cfg =3D rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
> > @@ -380,9 +380,11 @@ void rpm_lmac_pause_frm_config(void *rpmd, int lma=
c_id, bool enable)
> >  		rpm_write(rpm, 0, RPMX_CMR_CHAN_MSK_OR, ~0ULL);
> > =20
> >  	/* Disable all PFC classes */
> > -	cfg =3D rpm_read(rpm, lmac_id, RPMX_CMRX_PRT_CBFC_CTL);
> > +	pfc_class_mask_cfg =3D is_dev_rpm2(rpm) ? RPM2_CMRX_PRT_CBFC_CTL :
> > +						RPMX_CMRX_PRT_CBFC_CTL;
>=20
> Maybe it is overkill, but as this appears at least twice,
> perhaps a helper would be appropriate.

I think this is a matter of personal preferences (there is another
similar chunk with will not fit an helper, short of implementing it
with a somewhat ugly macro. So the overall code would be asymmetric),=C2=A0

I'm fine either way.

Cheers,

Paolo



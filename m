Return-Path: <netdev+bounces-41155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3847D7C9FB6
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 08:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E041C208DF
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 06:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EDE134A9;
	Mon, 16 Oct 2023 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bfvg4A1j"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE38836
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:38:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9CB8E
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 23:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697438291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cifvyOUkqDm99gRqA7r8HDAmuZ+jj3vv6LzHyAB/feI=;
	b=Bfvg4A1jEYLReoydDFhGJjkLR04R3tpqofgUgoT8R5blFhphjYqxN+t+1sxfWkgDVEb9zF
	iOmewbd7R7zl5hpCHl7jpkeShGYmmcyGy3y0G4Zuz8ppg7NGB/PuX/BIHW9M6qJCFN37L+
	30fYgzhAU/+c0aaxMljSYH6CDwePHEY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-3X8JuoGFO_q_VeEGPD961A-1; Mon, 16 Oct 2023 02:38:09 -0400
X-MC-Unique: 3X8JuoGFO_q_VeEGPD961A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b2d2d8f9e0so51067966b.1
        for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 23:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697438288; x=1698043088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cifvyOUkqDm99gRqA7r8HDAmuZ+jj3vv6LzHyAB/feI=;
        b=aB0FRT8XWP+eVzOHKtQKHwHEBPHMOyJ1hnbwCrbopVbZIlJdYumJjau6GXD5rPaMl7
         aqKMtRz1OuQ9yxDt8J2PQ8Y4SekcZPwsuOIg46/Q5hnYzV/xxE2i70QpwDkR2BQdFreV
         pHbrUxQN7l3vhxKeKqvDMFLdUZSFU3WFiGXbO5DjEtPAwd9yM4jrcVrcfAM2wJ664cro
         XfSWvuC0Co3XSzw2VNnXIrBRbbhD+2POMFx+7exLR/+xWl8QP0xxi6WL0otyHhTLO6Sk
         QBzIbCDN92Gb293jEmzQccYylOSBWYps55FUm90n/tdG+KPpo6t9z+h6hv9/nC9BQ2Kk
         23ig==
X-Gm-Message-State: AOJu0YzSCyidhL5XDHYICeNEtcJdfTS87fPSZ+4rQrpcorQME6CvKweH
	RUYvWdWzBnigP/FhiRLvp2/nsdbTDb0L190Ev+GvFm5+diocke9SliVhesvIeaAIyBtFdafDSLz
	ROXqjXZU9haAVkfEOxg1dn0Nq
X-Received: by 2002:a17:907:7d86:b0:9be:4cf4:d62e with SMTP id oz6-20020a1709077d8600b009be4cf4d62emr5865227ejc.5.1697438288019;
        Sun, 15 Oct 2023 23:38:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkR1i0Sh+EH7Z7RwQC8HFYLm0NaqBGAtpxuoR8egMYiDQuV9OHzfRfOzWFHGoA+PwFm0GqbA==
X-Received: by 2002:a17:907:7d86:b0:9be:4cf4:d62e with SMTP id oz6-20020a1709077d8600b009be4cf4d62emr5865211ejc.5.1697438287595;
        Sun, 15 Oct 2023 23:38:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-136.dyn.eolo.it. [146.241.231.136])
        by smtp.gmail.com with ESMTPSA id j27-20020a170906535b00b0099ddc81903asm3417011ejo.221.2023.10.15.23.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 23:38:07 -0700 (PDT)
Message-ID: <57af5c65ee5510ce03c451456679be7654a4047b.camel@redhat.com>
Subject: Re: pull-request: bluetooth 2023-10-11
From: Paolo Abeni <pabeni@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Date: Mon, 16 Oct 2023 08:38:05 +0200
In-Reply-To: <CABBYNZ+A9Zk8HbQBPNXFLbaR_maCY7o5qHtx_MTJqhQ=LNBMPQ@mail.gmail.com>
References: <20231011191524.1042566-1-luiz.dentz@gmail.com>
	 <20231013175443.5cb5c2ce@kernel.org>
	 <CABBYNZ+A9Zk8HbQBPNXFLbaR_maCY7o5qHtx_MTJqhQ=LNBMPQ@mail.gmail.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-10-13 at 20:12 -0700, Luiz Augusto von Dentz wrote:
> Hi Jakub,
>=20
> On Fri, Oct 13, 2023 at 5:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >=20
> > On Wed, 11 Oct 2023 12:15:24 -0700 Luiz Augusto von Dentz wrote:
> > >  - Fix race when opening vhci device
> > >  - Avoid memcmp() out of bounds warning
> > >  - Correctly bounds check and pad HCI_MON_NEW_INDEX name
> > >  - Fix using memcmp when comparing keys
> > >  - Ignore error return for hci_devcd_register() in btrtl
> > >  - Always check if connection is alive before deleting
> > >  - Fix a refcnt underflow problem for hci_conn
> >=20
> > Commit: fc11ae648f03 ("Bluetooth: hci_sock: Correctly bounds check and =
pad HCI_MON_NEW_INDEX name")
> >         Fixes tag: Fixes: 78480de55a96 ("Bluetooth: hci_sock: fix slab =
oob read in create_monitor_event")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist
> >=20
> > Commit: 6f0ff718ed67 ("Bluetooth: avoid memcmp() out of bounds warning"=
)
> >         Fixes tag: Fixes: d70e44fef8621 ("Bluetooth: Reject connection =
with the device which has same BD_ADDR")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist
> >=20
> > Commit: b03f32b195df ("Bluetooth: hci_event: Fix coding style")
> >         Fixes tag: Fixes: d70e44fef862 ("Bluetooth: Reject connection w=
ith the device which has same BD_ADDR")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist
> >=20
> > Commit: a9500f272b3b ("Bluetooth: hci_event: Fix using memcmp when comp=
aring keys")
> >         Fixes tag: Fixes: fe7a9da4fa54 ("Bluetooth: hci_event: Ignore N=
ULL link key")
> >         Has these problem(s):
> >                 - Target SHA1 does not exist
> >=20
> > :(
>=20
> Not sure what I'm doing wrong, because verify_fixes.sh doesn't
> actually warn these for me, or perhaps it needs to be used in a clean
> tree/new clone since it may match commit ids of different
> branchs/remotes?=C2=A0

Indeed verify_fixes will match any commit in your tree. I personally
stumbled upon similar issues while doing backports - when references to
different trees converged in my repo.

One things that did help me is using a specific, clean, clone with a
single remote for all the netdev patches.

Cheers,

Paolo

> Anyway, I'm preparing a new pull-request.



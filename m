Return-Path: <netdev+bounces-29587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E972783E71
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 12:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCFD1C20AA2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3278D9474;
	Tue, 22 Aug 2023 10:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F69472
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 10:58:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D565E5F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692701891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2QwF53F9zwST/a/bBNMeCL1+CzbCBl/0QSzpdsdnjcM=;
	b=RBlhH+oE2HajS+NPcpCP2NThb3kbVltgR2KhzvXvNyBZ7BMPOYZ4FfBeA5ojcidilpcpC1
	UYPFJALaTWGxglUVhVa4SzJUfWHxatj6ufDJQsC49J1QrYhdkxTlRIYSC29ty+vgjGl/RB
	O+DSftZgmAV/GdxOiNvECOAeZAT7tno=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-CrRtQVKzOFKKBdoETptmqA-1; Tue, 22 Aug 2023 06:58:08 -0400
X-MC-Unique: CrRtQVKzOFKKBdoETptmqA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe246ec511so8779475e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701887; x=1693306687;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2QwF53F9zwST/a/bBNMeCL1+CzbCBl/0QSzpdsdnjcM=;
        b=J7ho+VYzPFli41c6v0vbW8xw+QUxe0Vw2nglahCGpfgF1+qLr1sWAXj22KA+KWKGMT
         8hOBrnVOEaEqUaLKvCoouqEJe21hgbwaRhPK3g52Ppkbw1qmqiuAY9wpep1x0qaFpKCE
         rnrteZcA1FhDNZ3nF8KDGU3lhAQJ13ZEoeH4misSsjYghupek+/PonyqsIrMgIh10ksC
         OxxHiHPz32HPnGziLyJbQaOkZPdCoj6VyyVjzGvE+UiUDhOP+a5JepwlEAk0/ozXydTJ
         ggcLzp4JRjdajyFjwVH122T6pcUGpEYMmGXpkpASQBZwSvqE+VqBJuiO3cuiioX/XbiI
         exuA==
X-Gm-Message-State: AOJu0YyvdKafjOD1ku5+G35wXzfR+1EC4x9iygs867xS18FObtYg6djD
	DEh+2zkCvcWPusDcATE8AXjpKkLzX6GQgpYHGOANdvcT5YZI/f0Q9OE74/F5YLn3nuDnlYX6d1+
	m3vcpsmv0xaiPIJC9
X-Received: by 2002:a5d:5242:0:b0:31a:d2f9:736b with SMTP id k2-20020a5d5242000000b0031ad2f9736bmr6776134wrc.1.1692701887020;
        Tue, 22 Aug 2023 03:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/gfvQP+q86KUqFZ7cXqs4O29Y4pdllPQAUHuNmDQpG9Jrfa9VxnrVCNIRTHBEC4+4zm6fbw==
X-Received: by 2002:a5d:5242:0:b0:31a:d2f9:736b with SMTP id k2-20020a5d5242000000b0031ad2f9736bmr6776114wrc.1.1692701886650;
        Tue, 22 Aug 2023 03:58:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4d07000000b00317afc7949csm15422903wrt.50.2023.08.22.03.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 03:58:06 -0700 (PDT)
Message-ID: <d3073c7b5d54e1ad4790b16c419e862fee952350.camel@redhat.com>
Subject: Re: [net PATCH V3 1/3] octeontx2-pf: Fix PFC TX scheduler free
From: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>, Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
 hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 22 Aug 2023 12:58:04 +0200
In-Reply-To: <20230822071101.GI2711035@kernel.org>
References: <20230821052516.398572-1-sumang@marvell.com>
	 <20230821052516.398572-2-sumang@marvell.com>
	 <20230822071101.GI2711035@kernel.org>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-08-22 at 09:11 +0200, Simon Horman wrote:
> On Mon, Aug 21, 2023 at 10:55:14AM +0530, Suman Ghosh wrote:
> > During PFC TX schedulers free, flag TXSCHQ_FREE_ALL was being set
> > which caused free up all schedulers other than the PFC schedulers.
> > This patch fixes that to free only the PFC Tx schedulers.
> >=20
> > Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
> > Signed-off-by: Suman Ghosh <sumang@marvell.com>
> > ---
> >  .../ethernet/marvell/octeontx2/nic/otx2_common.c  |  1 +
> >  .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c   | 15 ++++-----------
> >  2 files changed, 5 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b=
/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > index 77c8f650f7ac..289371b8ce4f 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> > @@ -804,6 +804,7 @@ void otx2_txschq_free_one(struct otx2_nic *pfvf, u1=
6 lvl, u16 schq)
> > =20
> >  	mutex_unlock(&pfvf->mbox.lock);
> >  }
> > +EXPORT_SYMBOL(otx2_txschq_free_one);
>=20
> Hi Suman,
>=20
> Given that the licence of both this file and otx2_dcbnl.c is GPLv2,
> I wonder if EXPORT_SYMBOL_GPL would be more appropriate here.

AFAICS all the symbols exported by otx2_common use plain
EXPORT_SYMBOL(). I think we can keep that for consistency in a -net
patch. In the long run it would be nice to move all of them to
EXPORT_SYMBOL_GPL :)

Cheers,

Paolo



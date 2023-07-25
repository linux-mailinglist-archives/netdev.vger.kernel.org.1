Return-Path: <netdev+bounces-20811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049676112C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621BD1C20E20
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B74F14A82;
	Tue, 25 Jul 2023 10:47:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046B8F59
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:47:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF2810FA
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690282069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJQzTxThR2VztifReyTpqJYEB15Fq8bQiVZuW+ew/e4=;
	b=Ps6i0Hongw5zRQxlfpS/s36YRDiPn33dLzAQekFIq0tMUKlyakRs99grAsXgyP+LGshL0q
	e5cBdSWGQ8tKz3l/qbw8NIlXxCyTZ/t0RWR3hC+mYCtRT4Aecfb10CcICMVLOTyxd4EOvB
	tcaCJ5FKTSgZx3v8EjlX/uKyz5iwnSo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-3Vi7-DTaPDaUKriFxmMWyg-1; Tue, 25 Jul 2023 06:47:48 -0400
X-MC-Unique: 3Vi7-DTaPDaUKriFxmMWyg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-403fcf7a9d0so14708641cf.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690282068; x=1690886868;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJQzTxThR2VztifReyTpqJYEB15Fq8bQiVZuW+ew/e4=;
        b=Ib0yRwbxsSzGqVq1zIydGO1oypX4fPGaQjNVenjn+A39XZU8WW/i61JTPwsmtN+5F1
         s1jVoViz1Ni9fDd5p3IKLjbQ3lvdpABQcXjpCFT8zF373VsKpI8m+3NHoxpR71Se2Ruu
         vllZMy02DciS/JKG8d0lGUs5aRUGRqIRMfmv+xXjToZx1wFku5WV4OoFTWBu9hvMtakh
         2P1JAM775gU+6CBltyS3rQDnIOH+zpgpJw6MN/pWwOj+UUjtvI/lE6Piu4KDBJtcLNaM
         5ZiYq/n9NpjfE/7ezxHq+trBzXAeRDhQEeu9HXnU1AI6yy5Lp2oeseDYd6QnjRWafpjK
         cY6A==
X-Gm-Message-State: ABy/qLZS/LGFUNxwsbD65sf+Qp2RDCF1ric/bqt1obmpNQVgOfCOW2Lc
	xdg9BIu00IThwT4Pc4HleChpny+hgbwK1Vk61xQCdlOzE9EbbyueSJTUIHQJioiMFuT5B0/hzja
	wck7Tuf2MDNV8d9xb
X-Received: by 2002:a05:622a:1aaa:b0:403:b001:be3b with SMTP id s42-20020a05622a1aaa00b00403b001be3bmr16350741qtc.6.1690282067919;
        Tue, 25 Jul 2023 03:47:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFjHyvT827bv8a2AuTUh1x1s/iWAmW8Ra4YOQK6zvLyQFYP6favS5UMjBOH1c4Mx8EEHJuvTQ==
X-Received: by 2002:a05:622a:1aaa:b0:403:b001:be3b with SMTP id s42-20020a05622a1aaa00b00403b001be3bmr16350721qtc.6.1690282067601;
        Tue, 25 Jul 2023 03:47:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id a6-20020ac86106000000b0040697ea156asm1353597qtm.52.2023.07.25.03.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:47:47 -0700 (PDT)
Message-ID: <e1cdc94be0e515a5de9d4af8fccfd99e25435b73.camel@redhat.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
From: Paolo Abeni <pabeni@redhat.com>
To: Ante Knezic <ante.knezic@helmholz.de>, "Russell King (Oracle)"
	 <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	f.fainelli@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, olteanv@gmail.com
Date: Tue, 25 Jul 2023 12:47:43 +0200
In-Reply-To: <20230725095925.25121-1-ante.knezic@helmholz.de>
References: <30e262679bfdfd975c2880b990fe8375b9860aab.camel@redhat.com>
	 <20230725095925.25121-1-ante.knezic@helmholz.de>
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
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[adding Russell]
On Tue, 2023-07-25 at 11:59 +0200, Ante Knezic wrote:
> On Tue, 25 Jul 2023 10:56:25 +0200 Paolo Abeni wrote
> > It looks like you are ignoring the errors reported by
> > mv88e6390_erratum_3_14(). Should the above be:
> >=20
> > 		return mv88e6390_erratum_3_14(mpcs);
> >=20
> > instead?
> >=20
>=20
> I guess you are right. Would it make sense to do the evaluation for the=
=20
> 	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
> above as well?

Good question ;) it looks like pcs_post_config() errors are always
ignored by the core, but I guess it's better to report them as
accurately as possible.

@Russell, what it your preference here, should we just ignore the
generate errors earlier, or try to propagate them to the core/phylink,
should that later be changed to deal with them?

Thanks,

Paolo



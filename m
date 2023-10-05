Return-Path: <netdev+bounces-38290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496697BA027
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E03B0281AF1
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972E129438;
	Thu,  5 Oct 2023 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrckMHJU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC5629434
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:35:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7418B4CD3
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696516506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJEa+gWdlvljcsxPLx3PWHMvt63pRc6Ikwaz2vOfIPg=;
	b=IrckMHJUYzDlE8vJXwjY5OYAh/vE0BqfsFEyncI4npHdbfqiXlzM2TrQIiK5nQZBgZbiqQ
	NiV2Vb2owsD9xrtLzaLMcOYkuulMUm9M36HLGUmVe3I6wIb4ZecbYY9ZeaLtNoG54eBAd2
	E2zIxJqXfY1s6U574y3Z/Hut8yxFLvQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-1Tdt2WKiOsWsaZTO4hcGUw-1; Thu, 05 Oct 2023 06:34:04 -0400
X-MC-Unique: 1Tdt2WKiOsWsaZTO4hcGUw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51e3bb0aeedso93423a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 03:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696502043; x=1697106843;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJEa+gWdlvljcsxPLx3PWHMvt63pRc6Ikwaz2vOfIPg=;
        b=QXr06zPJ45ILL32dE4XytwvEx9e9312l/x2KDydgq1h4k5Ag3a0GzLY02rhe2Me9m0
         bmKWviTgGeHjsfbUjpdOiOEBeZCU0baY7PdmfZZZaop6/gSphwa50ya6mFKlnrT6FqF4
         0wm9G2rSdZLblAsFvLmJO9z5ms5CX7unIl8+j3uvRFSdFg7zENVC6Ck9F5R3yKirzHaM
         cIcg1nRTtX0ff5NPfcQjoC09Yngkk9ctpOA5rRnENNPgjgHbEfKTCdkECBNiGHRa2C7x
         a0VADwUVScXbgynn+keVybhF2Rn1aRN2GWHgV8Km4pSoVhKlrbvrGhc2RHWQLQZDDggW
         z1ig==
X-Gm-Message-State: AOJu0YzpQl9h0mO5ruKVy5bDPzPuOmGdbKKCFikxfub+fFky9/315cFD
	RKhetmpWi7bJcwBa5vXd5pAwip0T4dmajOOfiSY9zA40hHErT6ix8bFoCho+IS1v3N3ZuKuceMN
	euFcBWDJUb3dQP5TG
X-Received: by 2002:a05:6402:278c:b0:523:2e64:122b with SMTP id b12-20020a056402278c00b005232e64122bmr4222448ede.3.1696502043141;
        Thu, 05 Oct 2023 03:34:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBjwOxGN0mroujhop9lSt9BQu5QPOyNH8DNEdnCagtFe3aIYksxxEYiMpkoc5gI5XLXtgVuw==
X-Received: by 2002:a05:6402:278c:b0:523:2e64:122b with SMTP id b12-20020a056402278c00b005232e64122bmr4222432ede.3.1696502042791;
        Thu, 05 Oct 2023 03:34:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-9.dyn.eolo.it. [146.241.225.9])
        by smtp.gmail.com with ESMTPSA id i13-20020a056402054d00b005231e3d89efsm867932edx.31.2023.10.05.03.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:34:02 -0700 (PDT)
Message-ID: <6845daf40e0bd79c9768e83928b308e84459c010.camel@redhat.com>
Subject: Re: [PATCH v3] net: phy: broadcom: add support for BCM5221 phy
From: Paolo Abeni <pabeni@redhat.com>
To: Giulio Benetti <giulio.benetti@benettiengineering.com>, 
	linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Giulio Benetti
 <giulio.benetti+tekvox@benettiengineering.com>, Jim Reinhart
 <jimr@tekvox.com>,  James Autry <jautry@tekvox.com>, Matthew Maron
 <matthewm@tekvox.com>
Date: Thu, 05 Oct 2023 12:34:00 +0200
In-Reply-To: <20230928185949.1731477-1-giulio.benetti@benettiengineering.com>
References: <20230928185949.1731477-1-giulio.benetti@benettiengineering.com>
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

On Thu, 2023-09-28 at 20:59 +0200, Giulio Benetti wrote:
> From: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>
>=20
> This patch adds the BCM5221 PHY support by reusing brcm_fet_*()
> callbacks and adding quirks for BCM5221 when needed.
>=20
> Cc: Jim Reinhart <jimr@tekvox.com>
> Cc: James Autry <jautry@tekvox.com>
> Cc: Matthew Maron <matthewm@tekvox.com>
> Signed-off-by: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.c=
om>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
> V1->V2:
> Suggested by Andrew Lunn:
> * handle mdix_ctrl adding bcm5221_config_aneg() and bcm5221_read_status()
> * reorder PHY_ID_BCM5241 in broadcom_tbl[]
> Suggested by Russell King:
> * add comment on phy_read(..., MII_BRCM_FET_INTREG)
> * lock mdio bus when in shadow mode
> Suggested by Florian Fainelli:
> * reuse brcm_fet_*() callbacks checking for phy_id =3D=3D PHY_ID_BCM5221
>=20
> V2->V3:
> * rebase on master branch

LGTM, but waiting an extra bit for explicit ack from Florian.

Cheers,

Paolo



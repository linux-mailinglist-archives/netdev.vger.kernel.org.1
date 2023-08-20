Return-Path: <netdev+bounces-29220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23627822BC
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 06:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5208280EDB
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 04:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A548A1390;
	Mon, 21 Aug 2023 04:22:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BF9136C
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 04:22:07 +0000 (UTC)
Received: from smart3-pmg.ufmg.br (smart3-01-pmg.ufmg.br [150.164.64.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8341C99
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 21:22:01 -0700 (PDT)
Received: from smart3-pmg.ufmg.br (localhost.localdomain [127.0.0.1])
	by smart3-pmg.ufmg.br (Proxmox) with ESMTP id 44BF160511E
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 14:28:20 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ufmg.br; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:message-id:mime-version:reply-to:reply-to:subject:subject
	:to:to; s=mail; bh=qMwz92O8K0cAoBo7WcL/Ogu7LjGDMA8XkVY9GHxXg1s=; b=
	ZrO//sX0ryQHw9p6y5TZedKojGGub14nGX8BFAkF22Q5tCA1x8ep1FM1aqxxSkhe
	Tjx/BphrvTQLJ4EthhSyEIUADGJwku4njXkbk3bHe2DDY2a9lXW77sQty0f5mnnv
	YdvEAfyq3EVnbGKgvmNsyhJzuPA4W8tsdJxFzjLm0lLuthy1Du/tsnrQbiQWE3rS
	8/qp0PrewKknzgH/u25ZdNI96+zNVvdIe7qjA0EUqdOVD2i0ADHhgbC3BRjX90yX
	vCV8bwjbEBNWGUsQjiztFZkKQgv1Ga7ob+woj7aRCWFv9fsFnfZQmQxuxE20UdVj
	f1V6R/r1VV5ABdhh0tPeDg==
Received: from bambu.grude.ufmg.br (bambu.grude.ufmg.br [150.164.64.35])
	by smart3-pmg.ufmg.br (Proxmox) with ESMTP id F35265E8D47
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 14:21:53 -0300 (-03)
Received: from ufmg.br ([98.159.234.166])
          by bambu.grude.ufmg.br (IBM Domino Release 10.0.1FP3)
          with ESMTP id 2023082014132196-1083281 ;
          Sun, 20 Aug 2023 14:13:21 -0300 
Reply-To: "Kristine Wellenstein" <inform@calfd.org>
From: "Kristine Wellenstein" <luanacsg@ufmg.br>
To: netdev@vger.kernel.org
Subject: [RE]: RE:
Date: 20 Aug 2023 13:13:21 -0400
Message-ID: <20230820131321.E35BCC22963F59B9@ufmg.br>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on bambu/UFMG(Release 10.0.1FP3|August 09, 2019) at
 20-08-2023 14:13:22,
	Serialize by Router on bambu/UFMG(Release 10.0.1FP3|August 09, 2019) at 20-08-2023
 14:21:53,
	Serialize complete at 20-08-2023 14:21:53
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset="utf-8"
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

K=C3=ADnh g=E1=BB=ADi ng=C6=B0=E1=BB=9Di th=E1=BB=A5 h=C6=B0=E1=BB=9Fng,

Qu=E1=BB=B9 EmilyWells khuy=E1=BA=BFn kh=C3=ADch m=E1=BB=8Di ng=C6=B0=E1=BB=
=9Di t=C3=ACnh nguy=E1=BB=87n v=C3=AC c=C3=A1c m=E1=BB=A5c =C4=91=C3=ADch x=
=C3=A3 h=E1=BB=99i ho=E1=BA=B7c t=E1=BB=AB thi=E1=BB=87n v=C3=A0 gi=C3=BAp =
=C4=91=E1=BB=A1 nh=E1=BB=AFng ng=C6=B0=E1=BB=9Di k=C3=A9m may m=E1=BA=AFn h=
=C6=A1n. T=E1=BA=A5t c=E1=BA=A3 ch=C3=BAng ta h=C3=A3y truy=E1=BB=81n b=C3=
=A1 th=C3=B4ng =C4=91i=E1=BB=87p quan tr=E1=BB=8Dng c=E1=BB=A7a ng=C3=A0y t=
r=E1=BB=8Dng =C4=91=E1=BA=A1i n=C3=A0y v=C3=A0 c=E1=BA=A3m =C6=A1n v=C3=AC =
nh=E1=BB=AFng g=C3=AC ch=C3=BAng ta c=C3=B3.

T=C3=B4i l=C3=A0 Kristine Wellenstein, ng=C6=B0=E1=BB=9Di tr=C3=BAng gi=E1=
=BA=A3i =C4=91=E1=BB=99c =C4=91=E1=BA=AFc Mega Millions tr=E1=BB=8B gi=C3=
=A1 426 tri=E1=BB=87u =C4=91=C3=B4 la v=C3=A0o ng=C3=A0y 28 th=C3=A1ng 1. T=
=C3=B4i ch=C3=ADnh th=E1=BB=A9c th=C3=B4ng b=C3=A1o r=E1=BA=B1ng b=E1=BA=A1=
n =C4=91=C3=A3 =C4=91=C6=B0=E1=BB=A3c ch=E1=BB=8Dn l=C3=A0 m=E1=BB=99t tron=
g n=C4=83m ng=C6=B0=E1=BB=9Di nh=E1=BA=ADn =C4=91=E1=BB=83 nh=E1=BA=ADn kho=
=E1=BA=A3n =C4=91=C3=B3ng g=C3=B3p 2.300.000. =C4=91=C3=B4 la t=E1=BB=AB Qu=
=E1=BB=B9 Emily Wells.

Kho=E1=BA=A3n quy=C3=AAn g=C3=B3p n=C3=A0y l=C3=A0 =C4=91=E1=BB=83 t=C6=B0=
=E1=BB=9Fng nh=E1=BB=9B =C4=91=E1=BA=BFn =C4=91=E1=BB=A9a ch=C3=A1u trai qu=
=C3=A1 c=E1=BB=91 c=E1=BB=A7a t=C3=B4i v=E1=BB=ABa m=E1=BB=9Bi s=E1=BB=91ng=
 =C4=91=C6=B0=E1=BB=A3c m=E1=BB=99t ng=C3=A0y.
=C4=90=E1=BB=83 bi=E1=BA=BFt th=C3=AAm th=C3=B4ng tin, vui l=C3=B2ng tr=E1=
=BA=A3 l=E1=BB=9Di email n=C3=A0y.

Tr=C3=A2n tr=E1=BB=8Dng:

Kristine Wellenstein
Ng=C6=B0=E1=BB=9Di s=C3=A1ng l=E1=BA=ADp/Ch=E1=BB=A7 t=E1=BB=8Bch: EmilyWel=
ls. Qu=E1=BB=B9, t=C3=A0i tr=E1=BB=A3




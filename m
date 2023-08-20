Return-Path: <netdev+bounces-29186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B004F781F97
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 21:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DA11C20834
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 19:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4186FAE;
	Sun, 20 Aug 2023 19:39:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907C7E6
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 19:39:04 +0000 (UTC)
X-Greylist: delayed 6168 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Aug 2023 12:33:50 PDT
Received: from smart3-pmg.ufmg.br (smart3-01-pmg.ufmg.br [150.164.64.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B79E4481
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 12:33:50 -0700 (PDT)
Received: from smart3-pmg.ufmg.br (localhost.localdomain [127.0.0.1])
	by smart3-pmg.ufmg.br (Proxmox) with ESMTP id CE1BF5E8BE6
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 14:22:10 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ufmg.br; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:message-id:mime-version:reply-to:reply-to:subject:subject
	:to:to; s=mail; bh=aB6phz2CCV0fOdUx+FEpXbqcMS5qcYYIVmsV4Zzs0ug=; b=
	WSqcydMhRhbnlQllmbPzO//pxYvef9DRkRFhfHmVNdTN+R1y6civxiavn5OkwgGS
	+3ABmn/x4k2jm05XcNt6HA6AGel6HtbJ8LI90PbhUprpe4fM6HfdPOA+yuBsZpv4
	VeIc0FT0kyMy0UgyIV6X/ECnXsrfGGnRbEi4rBmrn/R8kgU0qcSR08340Lri6Gz/
	HNWKK3p/HX74JmP476dVHL5UJAMI/p+zUrd9ZiXbPqhxT0fBTUcoSXVHH1lJ9oK5
	4u+OAoxLWY1zpqC4F34DTIwNRtT7sBgnO1MgQxdztzpsqJv3H7HqYBf7UnbbIwN1
	sJpZqG5B252QycOzH2KoQw==
Received: from bambu.grude.ufmg.br (bambu.grude.ufmg.br [150.164.64.35])
	by smart3-pmg.ufmg.br (Proxmox) with ESMTP id 0EC8C6022BE
	for <netdev@vger.kernel.org>; Sun, 20 Aug 2023 14:10:11 -0300 (-03)
Received: from ufmg.br ([98.159.234.166])
          by bambu.grude.ufmg.br (IBM Domino Release 10.0.1FP3)
          with ESMTP id 2023082014014210-1067981 ;
          Sun, 20 Aug 2023 14:01:42 -0300 
Reply-To: "Kristine Wellenstein" <inform@calfd.org>
From: "Kristine Wellenstein" <luanacsg@ufmg.br>
To: netdev@vger.kernel.org
Subject: [RE]: RE:
Date: 20 Aug 2023 13:01:38 -0400
Message-ID: <20230820130138.9D54751E181FC2EB@ufmg.br>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on bambu/UFMG(Release 10.0.1FP3|August 09, 2019) at
 20-08-2023 14:01:42,
	Serialize by Router on bambu/UFMG(Release 10.0.1FP3|August 09, 2019) at 20-08-2023
 14:10:11,
	Serialize complete at 20-08-2023 14:10:11
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset="utf-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sehr geehrter Beg=C3=BCnstigter,

Die EmilyWells Foundation ermutigt Menschen, sich ehrenamtlich f=C3=BCr soz=
iale oder wohlt=C3=A4tige Zwecke zu engagieren und den weniger Gl=C3=BCckli=
chen zu helfen. Lasst uns alle die wichtige Botschaft dieses gro=C3=9Fartig=
en Tages verbreiten und uns f=C3=BCr das bedanken, was wir haben.

Ich bin Kristine Wellenstein, die Gewinnerin des Mega Millions-Jackpots in =
H=C3=B6he von 426 Millionen US-Dollar am 28. Januar. Ich gebe offiziell bek=
annt, dass Sie als einer von f=C3=BCnf Empf=C3=A4ngern einer Spende in H=C3=
=B6he von 2.300.000 ausgew=C3=A4hlt wurden. Dollar von der Emily Wells Foun=
dation.

Diese Spende ist im Gedenken an meinen verstorbenen Enkel, der gerade einen=
 Tag gelebt hat.
F=C3=BCr weitere Informationen antworten Sie bitte auf diese E-Mail.

Beste gr=C3=BC=C3=9Fe:

Kristine Wellenstein
Gr=C3=BCnderin/Vorsitzende: EmilyWells. Stiftung, Schenkung




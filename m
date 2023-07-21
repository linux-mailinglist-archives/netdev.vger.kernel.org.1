Return-Path: <netdev+bounces-21504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989E2763BBA
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D4C281CBA
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C0A27708;
	Wed, 26 Jul 2023 15:56:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18F111A3
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:56:29 +0000 (UTC)
Received: from mailsenadoer.gob.ar (mailsenadoer.gob.ar [190.183.215.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08C9213F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:56:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mailsenadoer.gob.ar (Postfix) with ESMTP id 98BBF17A84B8
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:42:02 -0300 (-03)
Received: from mailsenadoer.gob.ar ([127.0.0.1])
	by localhost (mailsenadoer.gob.ar [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Yigr7q3izX-L for <netdev@vger.kernel.org>;
	Tue, 25 Jul 2023 07:42:02 -0300 (-03)
Received: from localhost (localhost [127.0.0.1])
	by mailsenadoer.gob.ar (Postfix) with ESMTP id 58F4B18218CE
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:11:41 -0300 (-03)
DKIM-Filter: OpenDKIM Filter v2.10.3 mailsenadoer.gob.ar 58F4B18218CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailsenadoer.gob.ar;
	s=dkimmailsenadoer; t=1689963101;
	bh=Aor/WLwl4h5zbhGzya8ajVmHiT+79UPpoXAPFDddDh4=;
	h=MIME-Version:To:From:Date:Message-Id;
	b=yw4+0FinRoHeGxK1D9lbKIzZhhWsFp9DJzzean19jfpgiurUDPJ7vx707NCwA31ew
	 2EW8KI0Kb5GofJ+DIm03ugZWPjWMcZ11tsZfBXeVZGRmtL2FnbGbKapd8LZoHqRLSF
	 HtLnZ3SwcKFhlIuxDpSjZNY19zymfPPLsFplN02Keuqi08IrD+LqXgy2GfkQVhjsJv
	 rYIWdpWibsVe49rTBlgtqTqoLr4FhsphX8/zauH51+EBRFN0snc+6kdz6qezD09Y9x
	 34dnWqCQ5Xzax9cLW64jVjHnF5cV4d7j10v3SBBZu06piFD35+uB1blD0YskbHyuL8
	 hqlGix1x8mYkw==
X-Virus-Scanned: amavisd-new at mailsenadoer.gob.ar
Received: from mailsenadoer.gob.ar ([127.0.0.1])
	by localhost (mailsenadoer.gob.ar [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hAFPnptqCeVR for <netdev@vger.kernel.org>;
	Fri, 21 Jul 2023 15:11:41 -0300 (-03)
Received: from [192.168.0.166] (unknown [105.8.7.246])
	by mailsenadoer.gob.ar (Postfix) with ESMTPSA id 62FA21705344
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:57:07 -0300 (-03)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?RHVsZcW+aXTDoSB6cHLDoXZhOyDigqwgMiwwMDAsMDAwJzAwIEVVUg==?=
To: netdev@vger.kernel.org
From: "Pan Richard Wahl" <santacruz@mailsenadoer.gob.ar>
Date: Fri, 21 Jul 2023 09:57:03 -0700
Reply-To: info@wahlfoundation.org
Message-Id: <20230721165709.62FA21705344@mailsenadoer.gob.ar>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Drah=C3=BD pr=C3=ADteli,

Jsem pan Richard Wahl, mega v=C3=ADtez 533 milionu $ v jackpotu Mega Millio=
ns. Daruji 5 n=C3=A1hodne vybran=C3=BDm lidem. Pokud obdr=C5=BE=C3=ADte ten=
to e-mail, byl v=C3=A1=C5=A1 e-mail vybr=C3=A1n po roztocen=C3=AD koule. Ve=
t=C5=A1inu sv=C3=A9ho majetku jsem rozdal rade charitativn=C3=ADch organiza=
c=C3=AD a organizac=C3=AD. Dobrovolne jsem se rozhodl venovat v=C3=A1m c=C3=
=A1stku =E2=82=AC 2,000,000'00 EUR jako jednomu z 5 vybran=C3=BDch, abych s=
i overil sv=C3=A9 v=C3=BDhry prostrednictv=C3=ADm n=C3=AD=C5=BEe uveden=C3=
=A9 str=C3=A1nky YouTube.

VID=C3=8DTE ME ZDE https://www.youtube.com/watch?v=3Dtne02ExNDrw

TOTO JE V=C3=81=C5=A0 DAROVAC=C3=8D K=C3=93D: [DFDW43034RW2023]

Odpovezte na tento e-mail a uvedte k=C3=B3d daru: info@wahlfoundation.org

Douf=C3=A1m, =C5=BEe v=C3=A1m a va=C5=A1=C3=AD rodine udel=C3=A1m radost.

Pozdravy,
Pan Richard Wahl


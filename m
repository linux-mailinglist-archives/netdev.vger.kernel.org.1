Return-Path: <netdev+bounces-36529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294687B04AE
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AEB72282AE2
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32332286AA;
	Wed, 27 Sep 2023 12:52:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108545257
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 12:51:57 +0000 (UTC)
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Sep 2023 05:51:54 PDT
Received: from m2-bln.bund.de (m2-bln.bund.de [77.87.224.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B7CC0
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:51:54 -0700 (PDT)
Received: from m2-bln.bund.de (localhost [127.0.0.1])
	by m2-bln.bund.de (Postfix) with ESMTP id 57DB0AB5FD
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 14:45:10 +0200 (CEST)
Received: (from localhost) by m2-bln.bund.de (MSCAN) id 6/m2-bln.bund.de/smtp-gw/mscan;
     Wed Sep 27 14:45:10 2023
X-NdB-Source: NdB
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=itzbund.de;
	s=230316-2017-ed25519; t=1695818696;
	bh=JzV03SOJfmOsV1V8NePw9A1n04lNTFYSP415BNgFqJ4=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Autocrypt:Cc:Content-Transfer-Encoding:
	 Content-Type:Date:From:In-Reply-To:Mime-Version:Openpgp:References:
	 Reply-To:Resent-To:Sender:Subject:To;
	b=+/C8YQ19AWridqQbyXzcvrwc0GUANgPTl+cq1AqsxBMXp/R7judoPQNyeF+NAQqdf
	 WSQancYwjpq2MglWW/BBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=itzbund.de;
	s=230316-2017-rsa; t=1695818695;
	bh=JzV03SOJfmOsV1V8NePw9A1n04lNTFYSP415BNgFqJ4=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Autocrypt:Cc:Content-Transfer-Encoding:
	 Content-Type:Date:From:In-Reply-To:Mime-Version:Openpgp:References:
	 Reply-To:Resent-To:Sender:Subject:To;
	b=j6Sw2fR4S3OuxwKqSwOahPnkFKRCL25o7qW8vFDFdm6GHwOkRQsktidyf9drE9rwd
	 e28uu2dAXkzVUgGFzHA5+mRvq3e8uiQltF+kA1G/dhm8rC67YLLnWRAw6agOzGxpvt
	 6H8ougoUVyEljkPgVYSr4GmGCuAy1Ybp9JAAa/YgxJgI4yorDgZhreHuoFOyLtGKQ2
	 D7cMygDSK/AzJJoE8XE/NAIBXekZYhiH44lSChoIWKCj9Kkd4NN/zC68wsrG6Gv72T
	 E2DuQiEekeUVgOlDbn1lvaQ0kxcIDvyapl/uPjL/9Vt1ojQdOgK4Wp6OPywrOqIW07
	 EKRcN7x36/GJQ==
X-P350-Id: 28a11e390767c8bc
Date: Wed, 27 Sep 2023 14:44:55 +0200
From: E-Mail-Administration ITZBund <noreply@itzbund.de>
To: netdev@vger.kernel.org
Subject: Ihre E-Mail konnte nicht zugestellt werden
Message-ID: <20230927124455.GA120132@vlp22140.prod.groupware.itz.itzbund.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rusd: domwl, Pass through domain itzbund.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sehr geehrte Damen und Herren,

bitte antworten Sie nicht auf diese Benachrichtigung. Kontaktm=F6glichkei=
ten entnehmen Sie bitte der E-Mail-Signatur.

Aufgrund eines Zertifikatsproblems auf einem Antivirus-Gateway des ITZBun=
d konnten E-Mails nicht zugestellt werden. Diese Nachrichten sollten dahe=
r noch einmal versendet werden.

Sie erhalten diese Benachrichtigung, da Ihre E-Mail-Adresse in einer der =
fraglichen Nachrichten enthalten war. Nachfolgend finden Sie die Einzelhe=
iten zu dieser E-Mail:

Datumsstempel: 25.09.2023 10:30

Absender: alibuda@linux.alibaba.com
Empf=E4nger: jaka@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.=
kernel.org, davem@davemloft.net, extern.martin.grimm@itzbund.de, wenjia@l=
inux.ibm.com, kgraul@linux.ibm.com

Betreff: 'Re: [PATCH net] net/smc: fix panic smc_tcp_syn_recv_sock() whil=
e closing listen socket'

Sollten Sie der Absender sein, so erw=E4gen Sie bitte den erneuten Versan=
d. In dem Fall, da=DF Sie diese E-Mail h=E4tten erhalten sollen, informie=
ren Sie bitte den Absender =FCber Ihren Wunsch, die E-Mail erneut zu vers=
enden.

Wir m=F6chten uns f=FCr die Unannehmlichkeiten entschuldigen.

F=FCr R=FCckfragen steht Ihnen die E-Mail-Administration des ITZBund gern=
e zur Verf=FCgung.


Freundliche Gr=FC=DFe

Ihre E-Mail-Administration
_______________________________________
V A 51 40 - Gateway-Systeme und Schnittstellen
Informationstechnikzentrum Bund (ITZBund)

Postanschrift: Postfach 301645, 53196 Bonn
E-Mail: VA5140@itzbund.de



Return-Path: <netdev+bounces-45581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A837DE6BF
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 21:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C3DB20F76
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 20:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806A41B28C;
	Wed,  1 Nov 2023 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbCfsTV/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B761B281
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 20:27:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895FB11C
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 13:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698870451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sUlB9Zey7+viE7qsX1uDxY/6yuVcf/6ZYKLf2CdDwkY=;
	b=AbCfsTV/RSWgm4eRTOiJNi+CTlT4hCom+pPymIOmoq+m+ujdgdb6ANNrtd+OVWpg1FjcFD
	nbo6yFs+6D5qaixQjYkKu6/5fnu3dO2aJbFHTTrFMZmFgvoJoGEIcNgjloEl28VicOCV6S
	9et5uucps/Gq/nH0/iPXjQc1ovoDM90=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-Kxn8zXZFNUS2IdSCga1DSw-1; Wed, 01 Nov 2023 16:27:30 -0400
X-MC-Unique: Kxn8zXZFNUS2IdSCga1DSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBFBD101A53B;
	Wed,  1 Nov 2023 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.22.48.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 99F821121308;
	Wed,  1 Nov 2023 20:27:28 +0000 (UTC)
Message-ID: <79b7f88e3dd6536fe69c63ed3b4cc1f2c551ce8d.camel@redhat.com>
Subject: Re: Does anyone use Appletalk?
From: Dan Williams <dcbw@redhat.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Geert
	Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Arnd Bergmann
 <arnd@arndb.de>,  Jakub Kicinski <kuba@kernel.org>, netdev
 <netdev@vger.kernel.org>
Date: Wed, 01 Nov 2023 15:27:27 -0500
In-Reply-To: <5e3e52a48ba9cc0109a98cf4c5371c3f80c4b4cc.camel@physik.fu-berlin.de>
References: 
	<CAMuHMdWL2TnYmkt2W6=ohBuKmyof8kR3p7ZPzmXmWSGnKj9c3g@mail.gmail.com>
	 <594446aaf91b282ff3cbd95953576ffd29f38dab.camel@physik.fu-berlin.de>
	 <CAMuHMdWv=A6MiVwUuOp8zOCcf21HxKb8cdrndzdbAZik3VRXiw@mail.gmail.com>
	 <5e3e52a48ba9cc0109a98cf4c5371c3f80c4b4cc.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Wed, 2023-11-01 at 13:26 +0100, John Paul Adrian Glaubitz wrote:
> Hi Geert,
>=20
> On Wed, 2023-11-01 at 13:19 +0100, Geert Uytterhoeven wrote:
> > > Isn't that a bit late?
> >=20
> > It can always be reverted...
>=20
> Sure, but I'd rather see such discussions before merging the removal
> patch. Best would have been to reach out to the netatalk project, for
> example and ask [1]. They just released version 3.1.18 of the
> netatalk
> server in October 2023.
>=20
> It's an incredibly cool project because it allows you to replace the
> expensive Apple TimeMachine hardware with a cheap Raspberry Pi ;-).

But... Time Machine debuted with 10.5 and AppleTalk got removed in
10.6; did the actual TimeCapsules ever support AppleTalk, or were they
always TCP/IP-based?

(also TimeMachine-capable Airport Extremes [A1354] are like $15 on
eBay; that's cheaper than a Raspberry Pi)

This patch only removes the Linux-side ipddp driver (eg MacIP) so if
Time Capsules never supported AppleTalk, this patch is unrelated to
TimeMachine.

What this patch *may* break is Linux as a MacIP gateway, allowing
AppleTalk-only machines to talk TCP/IP to systems. But that's like
what, the 128/512/Plus and PowerBook Duo/1xx? Everything else had a
PDS/NuBus slot or onboard Ethernet and could do native
MacTCP/OpenTransport...

Dan



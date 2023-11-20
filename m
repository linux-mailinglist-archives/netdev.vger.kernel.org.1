Return-Path: <netdev+bounces-49381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD427F1DAE
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA231F25F85
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C003715A;
	Mon, 20 Nov 2023 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="ntaRrF8Q"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C532FAA
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 12:02:41 -0800 (PST)
X-KPN-MessageId: bd60d1a9-87df-11ee-a95f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id bd60d1a9-87df-11ee-a95f-005056abbe64;
	Mon, 20 Nov 2023 21:02:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=UniRdzI67XOS7ikIXX4j3nYPWBNr5bK3aKMYfqvfxzU=;
	b=ntaRrF8Qrg+d9b7WoVtb7jUe0tYkQe8MRoX3QgfXZ9kzvk+/vPyvozdTcINC25f7i4uST0y3mcgx9
	 7+tcWD4TslmN4b4FQkbVkqIDKqBLzZL0ZLrMMiaNf22G5TVrayLDAZ4KwKBSEhmKga5pmB25yQSGHQ
	 vUdIgNkTaTfzE88Q=
X-KPN-MID: 33|YIz5VoKN0Z6f0kmaezgR46p9LrxW9Rvh1Ox8HeclPpiLUumX/b/y9oVXVFU180O
 JIknXlAO7CVHmjhG6tR15YKXAmQV8OYlXS56CzvsMQH8=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|Ldp0Nw6C0CchPKg0D6Kredq817lLoIQT1Gg3LvIvsvdVpD7xhRC7x7QPEboaURQ
 tnPkzHZnQRJJt+x/tg1WvWg==
X-Originating-IP: 213.10.186.43
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c1572c72-87df-11ee-9f03-005056ab7584;
	Mon, 20 Nov 2023 21:02:39 +0100 (CET)
Date: Mon, 20 Nov 2023 21:02:38 +0100
From: Antony Antony <antony@phenome.org>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@labn.net>,
	Andrew Cagney <andrew.cagney@gmail.com>, devel@linux-ipsec.org,
	netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [DKIM] Re: [devel-ipsec] [RFC ipsec-next v2 0/8] Add IP-TFS mode
 to xfrm
Message-ID: <ZVu7Xu2-6KVePPUN@Antony2201.local>
References: <20231113035219.920136-1-chopps@chopps.org>
 <ZVHNI7NaK/KtABIL@gauss3.secunet.de>
 <CAJeAr6t_k32cqnzxqeuF8Kca6Q4w1FrDbKYABptKGz+HYAkyCw@mail.gmail.com>
 <m21qck1cxz.fsf@ja.int.chopps.org>
 <ZVu668MJ2iEr4fRG@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVu668MJ2iEr4fRG@Antony2201.local>

On Mon, Nov 20, 2023 at 09:00:45PM +0100, Antony Antony wrote:
> On Mon, Nov 20, 2023 at 01:39:50PM -0500, Christian Hopps via Devel wrote:
> > 
> > Andrew Cagney <andrew.cagney@gmail.com> writes:
> > 
> > > > I did a multiple days peer review with Chris on this pachset. So my
> > > > concerns are already addressed.
> > > > 
> > > > Further reviews are welcome! This is a bigger change and it would
> > > > be nice if more people could look at it.
> > > 
> > > I have a usability question.  What name should appear when a user
> > > interacts with and sees log messages from this feature?
> > >     ip-tfs, IP-TFS, IP_TFS
> > > or:
> > >    iptfs, IPTFS, ...
> > 
> > I think no `-` or `_` in the code/api. For documentation it is probably better to hew closer to the RFC and use `IP-TFS`.
> 
> That sounds good. However,
> iproute2 output, ip xfrm state, or "ip xfrm policy" is that documentation or code?
> 
> current unsubmitted patch shows: "iptfs"
> 
> src 192.1.2.23 dst 192.1.2.45
> 	proto esp spi 0x76ee6b87(1995336583) reqid 16389(0x00004005) mode iptfs

there also the following line further down in ip x s

iptfs-opts pkt-size 0 max-queue-size 1048576 drop-time 1000000 reorder-window 3 init-delay 0

> 
> root@west:/testing/pluto/ikev2-74-iptfs-01 (iptfs-aa-20231120)# ip  x p
> src 192.0.1.0/24 dst 192.0.2.0/24
> 	dir out priority 1757393 ptype main
> 	tmpl src 192.1.2.45 dst 192.1.2.23
> 		proto esp reqid 16389 mode iptfs
> 
> -antony


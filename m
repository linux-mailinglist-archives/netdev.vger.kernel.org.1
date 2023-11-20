Return-Path: <netdev+bounces-49378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA67F1DA5
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7164D1F23819
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C5337145;
	Mon, 20 Nov 2023 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="hFNekEaR"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBB7AA
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 12:00:46 -0800 (PST)
X-KPN-MessageId: 753e81d8-87df-11ee-b097-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 753e81d8-87df-11ee-b097-005056aba152;
	Mon, 20 Nov 2023 21:00:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=koJ4NwFrkgltfcs3Z+z3lRHPXaiC2cO6U3kNrXAsod8=;
	b=hFNekEaRZino3MGBkmRoKiJE1xK2mlzQWLgK9s4VM2LZPX8MyI3GyR4UaR7bcrctb8KILIrp2Z1of
	 j3Ya62agWvaMHxHF3qPy1lWDPkjWvgnhDrBQnDqQmpYHow9uGnShVlpkr0yeNgEO43YM8QyJtAbPlG
	 01XPq9gXunHV/30Y=
X-KPN-MID: 33|gvCesEb7+NjDLNv/axqviVy69+WCxGxYN/zaRIHL9o2CRKz/uHstBHSPsXtV30H
 DggdJXduRaNNn4dCmdkANpZOGlZ2M5aRD1avnkWntbLk=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|VcBONr9d9f/oP+v4DJ0XWQKmtC9N9CiyxEZZneKfTnjVQQ7pJnBwHHOPrlorn6P
 LNJVwF9sFQ1Jo6g+mXCyqrg==
X-Originating-IP: 213.10.186.43
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 7cba2e88-87df-11ee-a7b1-005056ab7447;
	Mon, 20 Nov 2023 21:00:44 +0100 (CET)
Date: Mon, 20 Nov 2023 21:00:43 +0100
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@labn.net>
Cc: Andrew Cagney <andrew.cagney@gmail.com>, devel@linux-ipsec.org,
	netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [DKIM] Re: [devel-ipsec] [RFC ipsec-next v2 0/8] Add IP-TFS mode
 to xfrm
Message-ID: <ZVu668MJ2iEr4fRG@Antony2201.local>
References: <20231113035219.920136-1-chopps@chopps.org>
 <ZVHNI7NaK/KtABIL@gauss3.secunet.de>
 <CAJeAr6t_k32cqnzxqeuF8Kca6Q4w1FrDbKYABptKGz+HYAkyCw@mail.gmail.com>
 <m21qck1cxz.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m21qck1cxz.fsf@ja.int.chopps.org>

On Mon, Nov 20, 2023 at 01:39:50PM -0500, Christian Hopps via Devel wrote:
> 
> Andrew Cagney <andrew.cagney@gmail.com> writes:
> 
> > > I did a multiple days peer review with Chris on this pachset. So my
> > > concerns are already addressed.
> > > 
> > > Further reviews are welcome! This is a bigger change and it would
> > > be nice if more people could look at it.
> > 
> > I have a usability question.  What name should appear when a user
> > interacts with and sees log messages from this feature?
> >     ip-tfs, IP-TFS, IP_TFS
> > or:
> >    iptfs, IPTFS, ...
> 
> I think no `-` or `_` in the code/api. For documentation it is probably better to hew closer to the RFC and use `IP-TFS`.

That sounds good. However,
iproute2 output, ip xfrm state, or "ip xfrm policy" is that documentation or code?

current unsubmitted patch shows: "iptfs"

src 192.1.2.23 dst 192.1.2.45
	proto esp spi 0x76ee6b87(1995336583) reqid 16389(0x00004005) mode iptfs

root@west:/testing/pluto/ikev2-74-iptfs-01 (iptfs-aa-20231120)# ip  x p
src 192.0.1.0/24 dst 192.0.2.0/24
	dir out priority 1757393 ptype main
	tmpl src 192.1.2.45 dst 192.1.2.23
		proto esp reqid 16389 mode iptfs

-antony


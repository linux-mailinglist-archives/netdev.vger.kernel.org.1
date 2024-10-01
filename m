Return-Path: <netdev+bounces-130970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D098C460
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 860FCB22BA6
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5271CB53A;
	Tue,  1 Oct 2024 17:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275701CB529
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803287; cv=none; b=owrWuFgLiED9zMsUef2Ya2bl2BvgNaB7y4X3RshNXj98bktUDEvjK8M7okACtkkMjq0wfCgPJswLTke4whJZ44vY/LRXgFpUk60ZUCgCKt3PTr8Vx+C2n6uaFqsEGG5Mxut/Kn7cuep4/1vt3ZFg4VhhA1M5Hq/BoQdY4+xhIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803287; c=relaxed/simple;
	bh=+pR2R4WwK/bFEt5VMFiz+fB9vduoe/ilQDA7qyfq51A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5yEolEVN54vtQCLF87/TyQojzhFgUAIst6JymbwoS/xqMeHXh4GVWNxI1JQ/WmQodQDeDKGRQ4HvZ1hlrrP2rDrjLw+FX0sS5BvJrmg43tTytb+kvaKywD9GljfdjEiwcAwWDxonOX692PCDvDAU6SC/WqzI+GI7Eywc8bG9UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-TWM-U1SoM5Gluj2BPgzhBw-1; Tue,
 01 Oct 2024 13:20:07 -0400
X-MC-Unique: TWM-U1SoM5Gluj2BPgzhBw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29DB61943CEF;
	Tue,  1 Oct 2024 17:20:04 +0000 (UTC)
Received: from hog (unknown [10.39.192.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CD3D195DFAA;
	Tue,  1 Oct 2024 17:10:21 +0000 (UTC)
Date: Tue, 1 Oct 2024 19:10:19 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: pabeni@redhat.com,
	syzbot <syzbot+cc39f136925517aed571@syzkaller.appspotmail.com>,
	davem@davemloft.net, edumazet@google.com,
	herbert@gondor.apana.org.au, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] UBSAN: shift-out-of-bounds in
 xfrm_selector_match (2)
Message-ID: <Zvws-45NVXIMUYl4@hog>
References: <00000000000088906d0622445beb@google.com>
 <66f33458.050a0220.457fc.001e.GAE@google.com>
 <ZvPvQMDvWRygp4IC@hog>
 <ZvZfAQ4IGX/3N/Ne@gauss3.secunet.de>
 <ZvZu9TmFs5VFhjLw@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvZu9TmFs5VFhjLw@hog>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Steffen,

2024-09-27, 10:38:13 +0200, Sabrina Dubroca wrote:
> 2024-09-27, 09:30:09 +0200, Steffen Klassert wrote:
> > On Wed, Sep 25, 2024 at 01:08:48PM +0200, Sabrina Dubroca wrote:
> > > Maybe a check for prefixlen < 128 would also be useful in the
> > > XFRM_STATE_AF_UNSPEC case, to avoid the same problems with syzbot
> > > passing prefixlen=200 for an ipv6 SA. I don't know how
> > > XFRM_STATE_AF_UNSPEC is used, so I'm not sure what restrictions we can
> > > put. If we end up with prefixlen = 100 used from ipv4 we'll still have
> > > the same issues.
> > 
> > I've introduced XFRM_STATE_AF_UNSPEC back in 2008 to make
> > inter addressfamily tunnels working while maintaining
> > backwards compatibility to openswan that did not set
> > the selector family. At least that's what I found in
> > an E-Mail conversation from back then.
> > 
> > A check for prefixlen <= 128 would make sense in any case.
> > But not sure if we can restrict that somehow further.
> 
> I'll add this check too, and then I'll run some more experiments with
> that flag.

I ended up not adding the check, since for x->sel.family == AF_UNSPEC,
xfrm_state_look_at doesn't use the selector at all, so I don't think
restricting prefixlen in that case would do anything.

-- 
Sabrina



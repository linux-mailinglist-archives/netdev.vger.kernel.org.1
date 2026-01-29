Return-Path: <netdev+bounces-254503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOlgBHmxemk79QEAu9opvQ
	(envelope-from <netdev+bounces-254503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:01:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69196AA762
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4B7D3002B4B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 01:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3523C3112B4;
	Thu, 29 Jan 2026 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="kuOOkmhA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13130F95F
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769648479; cv=none; b=Ewe4au1BLAr3qZEtlPu7Sr0rX3aozHwM1q5pqUPSMvHhzbcHNePB/b8kh1d6ZGp/LN4ZnWyWpd4nvg6y7phnujRg8XIbb1BrD7k+7BgoqY4jkahHAnoAhpwKCatE+gcMA6UCynXnYgnDpb9/uOQ73RVICjWOwi/Hfsp+dMioDYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769648479; c=relaxed/simple;
	bh=TWjP6ZADgKUe4VsEEJWe37T1+623sBH9m5v28UVcsp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBbTHS4ueYtBzKEZZ3ZsIIJSWQ0XZp/xC785L4KdsG/+jmkOHzxqarSlFTc++fSFYLZYJ1MXKKP9ojKbBY7W/kOdD5fUyuzJ8VNPmFpQeZbI9RDchPdNLnSv5Wcl7fhyc7rseHH6WuYOLpR4VW9OKPJ45TEHFQcl4Kv1pbygRsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=kuOOkmhA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81e93c5961cso363839b3a.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 17:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1769648477; x=1770253277; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n/q7c9XKTy03X7ABvxQisB8sZ2KrW1t2ngCelRKREuA=;
        b=kuOOkmhAmhXqHnrg/2SnuKR4P3THrl92WEs+oOGXwrUnYXNVK3CMqvlPprC0aTUdX3
         EQlOw2zkHfNXjlVEYUKtz9tBPwVuAcXO64NKxDQho/rdZiMJcdqkeTms78TFgdsjPxWv
         6HVgC97Y89XaipO57XH0g3w3xwnio0jF2ybZAoU2DcjXa2E6gNGNf/kTV7TdLuoyQ3ZN
         0k4xF/wRMA5MIf3ViUwEHPsQmWVuR+J3OZ/A8E49RNeJqDYZKivMOlxlV3BaPKB9zGgh
         reIGnhaMgQRoXgFret7ErM8iBxtv9DtijSkUpI7GrbyG8LkRBWevdaDfoom8QMVxwWfs
         akGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769648477; x=1770253277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/q7c9XKTy03X7ABvxQisB8sZ2KrW1t2ngCelRKREuA=;
        b=mtVaUM4TRzs0/yd/AvSh+q+XpFkjQRi1QzJXJluE1m/e0O5FEg8uKD/RZ4062wcb5Q
         ygxHdpeKIj4U0QUDiTbfmmpMbyP5fHZDfXDbgCf6VGtmi+qDDP9uND8/stdjJnANZQyJ
         rjFQ+E0nsIFxKnkyAkequckguLNiPWMVSjew0t36WolPIHd4LB+LKgK5as45i4xfWNRv
         jf9G8J8ctsxWZE0h+ZFCOU4UN6n1/t+qNrGMHqElUnViQPx6nFVTwiLyEvurqxJ46Y0N
         +xCp5XsbrbHVBwsHT4fOderfD87EkS2f6jh/WK7HgOtGSs+/sIxgT02DXnVuzMp/I6ui
         QbFg==
X-Gm-Message-State: AOJu0YxBaqOXMnhC29fnr97OtEjfLkzo1UAJG9SMNaWZp5WM5mUoOLqk
	waiYtduiosJF/UirEgUkfobBUtI+zlDzgmL8sMVdsfgGLtMZ9UUD0foycLmxVNkwutU=
X-Gm-Gg: AZuq6aIoHiQYU96hNRSlZetL+byZNH8M1yC47RI2xi9grs/TbcS2sGtC7Jz309vdob1
	iAYm8rnWRzUIBe8rKazvMSlupEaRb3yYJOHyp7FdZAc6tZJIhlZknRmfBi+uwkf/SB++mSft5PI
	+dQgZ64kHgFvgw7FP9yRUriPYgRXSMGKfrnW/3UVZRg+PrTv6VKOCOU2nzvfEXbHnWz/SDbx1nu
	fERyGZDX5Y/eqCDHNpONlF+p4IG+3DSkOMAwNrsDsiwhzWoLxquRxAMS1M64NG071c6bKSbIPVM
	Xe4nyRtEOPLQD46gqIoZAYbzRjbMj4YN6fMK6mNRXVXUYjmhL+KbAJ5D5IwsHEolSSfK9k0QfCu
	Tt0sF1zlFFC6N69f3JRoPOmCKBC0Un0Q9XE+UFcQDwQ/B6gvhtRjqNasRfs8ApWKHRzU=
X-Received: by 2002:a05:6a00:761b:b0:81f:9bf3:6deb with SMTP id d2e1a72fcca58-823691975edmr5073986b3a.15.1769648476970;
        Wed, 28 Jan 2026 17:01:16 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b59e10sm3681291b3a.25.2026.01.28.17.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 17:01:16 -0800 (PST)
Date: Wed, 28 Jan 2026 17:01:15 -0800
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	shruti.parab@broadcom.com
Subject: Re: [PATCH net-next] bnxt_en: Allow ntuple filters for drops
Message-ID: <aXqrIXo7GFQR7UyP@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	shruti.parab@broadcom.com
References: <20260128222718.1679581-1-joe@dama.to>
 <CACKFLimN+AOBeesHaiHPZM-OFUtLNeL-3GFtLUDCdv6_RGkEJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLimN+AOBeesHaiHPZM-OFUtLNeL-3GFtLUDCdv6_RGkEJg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254503-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 69196AA762
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 03:09:21PM -0800, Michael Chan wrote:
> On Wed, Jan 28, 2026 at 2:27 PM Joe Damato <joe@dama.to> wrote:
> >
> > It appears that in commit 7efd79c0e689 ("bnxt_en: Add drop action
> > support for ntuple"), bnxt gained support for ntuple filters for packet
> > drops.
> >
> > However, support for this does not seem to work in recent kernels or
> > against net-next:
> >
> >   % sudo ethtool -U eth0 flow-type udp4 src-ip 1.1.1.1 action -1
> >     rmgr: Cannot insert RX class rule: Operation not supported
> >     Cannot insert classification rule
> >
> > The issue is that the existing code uses ethtool_get_flow_spec_ring_vf,
> > which will return a non-zero value if the ring_cookie is set to
> > RX_CLS_FLOW_DISC, which then causes bnxt_add_ntuple_cls_rule to return
> > -EOPNOTSUPP because it thinks the user is trying to set an ntuple filter
> > for a vf.
> >
> > Fix this by first checking that the ring_cookie is not RX_CLS_FLOW_DISC.
> 
> Please add the Fixes tag.  It looks like the drop action never worked
> properly because of the vf check.

I haven't been able to verify, but based on reading the code it looks like
this path may not have worked since the code was introduced.

In that case, a fixes tag isn't needed because this is essentially new
functionality.

> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > index 6b15fedbb16f..fd32231bf8e0 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > @@ -1353,10 +1353,12 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
> >         if (!bp->vnic_info)
> >                 return -EAGAIN;
> >
> > -       vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
> > -       ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
> > -       if ((fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
> > -               return -EOPNOTSUPP;
> > +       if (fs->ring_cookie != RX_CLS_FLOW_DISC) {
> > +               vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
> > +               ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
> > +               if ((fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
> 
> I think the FLOW_MAC_EXT and FLOW_EXT checks should be done unconditionally.

OK, I'll change the patch so that -EOPNOTSUPP is returned unconditionally if
(FLOW_MAC_EXT | FLOW_EXT) are set and then do the RX_CLS_FLOW_DISC flow check
before calling ethtool_get_flow_spec_ring_vf.

> Alternatively, we can also change ethtool_get_flow_spec_ring_vf() to
> check that the cookie is not RX_CLS_FLOW_DISC or RX_CLS_FLOW_WAKE.

That's up to the maintainers.

The existing drivers I checked which use ethtool_get_flow_spec_ring_vf all
explicitly check RX_CLS_FLOW_DISC, so it seems to be an established pattern.

I think we should fix this in the broadcom driver first and if there is a
desire from the maintainers to handle this in ethtool_get_flow_spec_ring_vf,
that can be done as a separate series which updates all of the drivers to
remove the redundant check.


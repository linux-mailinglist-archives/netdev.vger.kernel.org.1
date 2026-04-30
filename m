Return-Path: <netdev+bounces-282672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCxmAEv88mmIwQEAu9opvQ
	(envelope-from <netdev+bounces-282672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:52:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F226F49E43C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABC8330091FF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01BC378806;
	Thu, 30 Apr 2026 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="ixdwmzeH"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C0377ECD
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777531972; cv=none; b=DGTn5gDE375X3RsIa0eBvF0agqTed54eRVgw/GNPDmZBGxnOusk450EieZg/EVq/eytPHCH1iMRyA8agdHR4dBHKBn2M3FC1dLmszuefd1uHeAr+VyA4NpAlL0NAHeP5dIdqKd3//tW0Sv6Trb/QZ4gqOgHkXkbfUY3OUyhOdME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777531972; c=relaxed/simple;
	bh=HdZTeVEOnlll/V0J+Es7BGEsIH0paVJMwW0tqmHdEVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANny07CrKoSR5hL4JfluftuUnRnb+w9TtjhAvB3rlnzR9cswqgetaenZK+jzZlAdutl7oEN/w9LSng21QslD3h9G/Ri7NeQZZOaZdqw9jSq40rglMPzxWg1KBQ3J2g+7mJU2iqa4Bh9NxT0Q9NHmGs9VnfmmasalfXts+h/UySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=ixdwmzeH; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (197.87.13.160.dy.iij4u.or.jp [160.13.87.197])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63U6qlWY016759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 30 Apr 2026 15:52:49 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=ga//PkVdVcOc+iQouQF6R8qn8+tGcT2W6yixW1flLbM=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1777531969; v=1;
        b=ixdwmzeHhgz0TVFzCdl3Cj+DzOCMvxOFSKSTNlJgj/az33/93ZRhWCKbPHshF4cv
         oE5TU3LV0L1jSquHHLK528bfFsbopl61sMvHT7omwLe5XeN6fqBHpHOQH2OOcm8l
         CbdqrUsh2Gl3X7DbUMq3T2NdMiBt9l5MCqriVSkYauZTSND0N6D8264xWoTAnWUX
         UHd8NmDHBpkAUFXZkFkdR+58pSC5tKLXRSIABCNtMSUzHYDxs0KNVnvvjXyNe+Pd
         y6ULkijAUITu9KD7EIUxUKzEaC4JHpc7AlLlEgrmelAwOcBEArsm787NNFsGNS38
         4dI2ZnDkQvOq1C3eo7d6tw==
Date: Thu, 30 Apr 2026 15:52:47 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
        Willem de Bruijn <willemb@google.com>,
        David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net v1 3/3] tcp: use skb_get_hwtstamp() for hardware
 timestamps
Message-ID: <afL4RF8bqtCKCt95@x1>
References: <20260429091632.26509-1-kohei@enjuk.jp>
 <20260429091632.26509-4-kohei@enjuk.jp>
 <willemdebruijn.kernel.2345608a210cc@gmail.com>
 <afLftTCDDzw4bE0P@x1>
 <CANn89i+0iK-Ci+Gokq5VW+SCvQLyA4vjairsf422P6hjZErquw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+0iK-Ci+Gokq5VW+SCvQLyA4vjairsf422P6hjZErquw@mail.gmail.com>
X-Rspamd-Queue-Id: F226F49E43C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282672-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,engleder-embedded.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,enjuk.jp:dkim,enjuk.jp:email]

On 04/29 23:09, Eric Dumazet wrote:
> On Wed, Apr 29, 2026 at 10:07 PM Kohei Enju <kohei@enjuk.jp> wrote:
> >
> > On 04/29 17:09, Willem de Bruijn wrote:
> > > Kohei Enju wrote:
> > > > Since commit 97dc7cd92ac6 ("ptp: Support late timestamp determination"),
> > > > skb_shared_hwtstamps may contain netdev_data instead of hwtstamp. TCP
> > > > receive timestamping can then interpret the stored value as a ktime_t
> > > > and report bogus hardware timestamps to userspace.
> > > >
> > > > Use skb_get_hwtstamp() instead of reading hwtstamp directly, so TCP
> > > > sockets follow the same hardware timestamp resolution path as the socket
> > > > layer. When coalescing SKBs, resolve late timestamps before copying them
> > > > to the merged skb.
> > >
> > > Why? Does this preclude supporting SOF_TIMESTAMPING_BIND_PHC for such
> > > sockets at a later time?
> >
> > You're right. If we want to keep the door open for
> > SOF_TIMESTAMPING_BIND_PHC on coalesced skbs, resolving the timestamp at
> > coalescing time is the wrong approach.
> >
> > >
> > > It is just as easy to coalesce the cookie as the htwtstamp.
> > >
> > > That also avoids the need to mask out SKBTX_HW_TSTAMP_NETDEV.
> >
> > Indeed. We should also carry the matching @napi_id, since
> > skb_get_hwtstamp() uses it for late resolution.
> >
> > I'll update this in v2.
> 
> Do you plan adding a selftest ?
> 
> I am confused by your series, a test would really help clarify the
> issue at hand.

Yes, I agree a selftest would help.

Since this issue is only triggered with drivers that use late RX
timestamp determination (SKBTX_HW_TSTAMP_NETDEV / ndo_get_tstamp), it
would likely need to live under tools/testing/selftests/drivers/net/hw/
rather than as a generic net selftest. I'm looking into whether I can
add such a test.

Either way, I'll expand the cover letter to explain the issue in more
detail. Sorry for the confusion.


Return-Path: <netdev+bounces-252234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJxYO2nYcWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:57:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C44062BA3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43C9F48A24F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AE3339B45;
	Thu, 22 Jan 2026 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="B9b09Juk"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345F2FD1D6
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068172; cv=none; b=VJJxXjd+rmu24dXyUXYVS4z95C7+RoKPpySIhkh/BBTy/lwp4mgbjraOvLZOWBZ4UHwZ3T9zuk7hqnYdIW5Vpn2e60bFg155Rk5V52yy0S6T7XH9w+Wf8qUKs2G4rqFZLF70smaYudlkvPPFpaUZjUsyumvnCbvYw9KvZWGrQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068172; c=relaxed/simple;
	bh=DFgOw/CUovX/CpYE+aDDAMoJS9IM+AsEMNRxdF8H4Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCo3/FF333EMhbTnU6QqHN0s5Y0JTi0gPSdcB6K8xaa14pI3wkLdJFW5o8UmcG/ma9/J26bIPmsU6VKRUWF7R3sPSmoIWuvSyFj7/uizKbQpZb5SvdHEoRGMfdvF0QpV9qqgRh9Q8xBiX3deV8Q5HkC0p6KJ/7eh4g3bCxYwqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=B9b09Juk; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (79.192.13.160.dy.iij4u.or.jp [160.13.192.79])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60M7nHV3064753
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 22 Jan 2026 16:49:17 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=YfFJ1yYZBltGbYzcJ2fakwNTo9XP10WDXsi1mmhmUGI=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769068157; v=1;
        b=B9b09JukH2mSlRO6cJXSTzMCI1uk1eOuCgBwR72oaLu1k+Hijsgk/Wx5xCDKKhHK
         w35mDCJa57RqYgEpbep1p4jcQ19hSV6QtfZlT9ABmgysapBgt5LJUc5aUilY4gfo
         lTPVnqH76QScExojR4RZsPgaq68Ugxa9A2o2hn4fimEzpvvFO3XQYBGNUOw7wrdk
         5aKClQ+muU+VZp6dF0KTMLJ5oa2d5uDzCBVXWl120QwUoGvnRv65Xkxp32JZGaeV
         hJy+fDd0vXYJTvENUtINySqC44YO/VB2uU+mkccuSaW2bWF3PtM9nwEM6XP353fs
         c3Y0kOaOmKo2xfE1Wy8M2A==
From: Kohei Enju <kohei@enjuk.jp>
To: aleksandr.loktionov@intel.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, intel-wired-lan@lists.osuosl.org,
        kohei.enju@gmail.com, kohei@enjuk.jp, kuba@kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        przemyslaw.kitszel@intel.com, takkozu@amazon.com
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-next] igb: set skb hash type
Date: Thu, 22 Jan 2026 07:49:16 +0000
Message-ID: <20260122074916.119851-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <IA3PR11MB898633484D0CB77105D1B9A1E597A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB898633484D0CB77105D1B9A1E597A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252234-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,google.com,lists.osuosl.org,gmail.com,enjuk.jp,kernel.org,vger.kernel.org,redhat.com,amazon.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[enjuk.jp,none];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,toeplitz.py:url,checkpatch.pl:url,lunn.ch:email,davemloft.net:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,enjuk.jp:email,enjuk.jp:dkim,enjuk.jp:mid,osuosl.org:email]
X-Rspamd-Queue-Id: 9C44062BA3
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 07:33:23 +0000, "Loktionov, Aleksandr" wrote:

> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Kohei Enju
> > Sent: Monday, January 19, 2026 6:58 PM
> > To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; kohei.enju@gmail.com; Takashi Kozu
> > <takkozu@amazon.com>; Kohei Enju <kohei@enjuk.jp>
> > Subject: [Intel-wired-lan] [PATCH v1 iwl-next] igb: set skb hash type
> > from RSS_TYPE
> >=20
> > igb always marks the RX hash as L3 regardless of RSS_TYPE in the
> > advanced descriptor, which may indicate L4 (TCP/UDP) hash. This can
> > trigger unnecessary SW hash recalculation and breaks toeplitz
> > selftests.
> >=20
> > Use RSS_TYPE from pkt_info to set the correct PKT_HASH_TYPE_*
> >=20
> > Tested by toeplitz.py with the igb RSS key get/set patches applied as
> > they are required for toeplitz.py (see Link below).
> >  # ethtool -N $DEV rx-flow-hash udp4 sdfn  # ethtool -N $DEV rx-flow-
> > hash udp6 sdfn  # python toeplitz.py | grep -E "^# Totals"
> >=20
> > Without patch:
> >  # Totals: pass:0 fail:12 xfail:0 xpass:0 skip:0 error:0
> >=20
> > With patch:
> >  # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
> >=20
> > Link: https://lore.kernel.org/intel-wired-lan/20260119084511.95287-5-
> > takkozu@amazon.com/
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> > If a Fixes tag is needed, it would be Fixes: 42bdf083fe70 ("net: igb
> > calls skb_set_hash").
> >=20
> > I'm not sure this qualifies as a fix, since the RX hash marking has
> > been wrong for a long time without reported issues. So I'm leaning
> > toward omitting Fixes.
> > ---
> >  drivers/net/ethernet/intel/igb/e1000_82575.h | 21
> > ++++++++++++++++++++
> >  drivers/net/ethernet/intel/igb/igb_main.c    | 18 +++++++++++++----
> >  2 files changed, 35 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.h
> > b/drivers/net/ethernet/intel/igb/e1000_82575.h
> > index 63ec253ac788..a855bc10f5d4 100644
> > --- a/drivers/net/ethernet/intel/igb/e1000_82575.h
> > +++ b/drivers/net/ethernet/intel/igb/e1000_82575.h
> > @@ -87,6 +87,27 @@ union e1000_adv_rx_desc {
> >  	} wb;  /* writeback */
> >  };
> >=20
> > +#define E1000_RSS_TYPE_NO_HASH		 0
> > +#define E1000_RSS_TYPE_HASH_TCP_IPV4	 1
> > +#define E1000_RSS_TYPE_HASH_IPV4	 2
> > +#define E1000_RSS_TYPE_HASH_TCP_IPV6	 3
> > +#define E1000_RSS_TYPE_HASH_IPV6_EX	 4
> > +#define E1000_RSS_TYPE_HASH_IPV6	 5
> > +#define E1000_RSS_TYPE_HASH_TCP_IPV6_EX	 6
> > +#define E1000_RSS_TYPE_HASH_UDP_IPV4	 7
> > +#define E1000_RSS_TYPE_HASH_UDP_IPV6	 8
> > +#define E1000_RSS_TYPE_HASH_UDP_IPV6_EX	 9
> > +
> > +#define E1000_RSS_TYPE_MASK		GENMASK(3, 0) /* 4-bits (3:0)
> > =3D mask 0x0F */
> 80columns violation, it's not critical, but I'd suggest just remove redunda=
> nt comment
> Otherwise, it smells like AI generated...
> #define E1000_RSS_TYPE_MASK		GENMASK(3, 0)

Ugh, somehow I missed the warning in checkpatch.pl. Thank you for
poiting out. TBH I copied that line from igc/igc.h with the comment, but
the comment is not necessary :)

I'll fix it in v2.

> 
> Everything else looks fine.
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 


Return-Path: <netdev+bounces-285583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FBcABdN/WkraQAAu9opvQ
	(envelope-from <netdev+bounces-285583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:40:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5F94F0E47
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B4D9304BE72
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 02:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF3826A1AF;
	Fri,  8 May 2026 02:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Jqq19Gok"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526681F63D9
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207887; cv=none; b=LdnQrzD2g1555HE/YAvz9uW9pw7Z1cjkZLke76F90r1KPAdX5d3HZL/HvadJjSsP/awWyXzeoVN8sbdXZLz7kroW/dy2Y6jsgnwiuVy7TvXVRm95NjmQyfT/YYduFy6txNctAcr32me05pAxpFi3GymiobiwI9k1zfVhjjzpJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207887; c=relaxed/simple;
	bh=2ULnQu4EydgN19WmdHGJkZB1ofR7oyXmS23aa5beXmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHAFOoOa3Z6xHVspJqt6NyidlgWhVPK0HYOWmOsu/WZ4+tKDtN1nPCqioC4ezaWobcDoODFou5qVmEJVdxxQyLhK79wHmHBSq1G/yLyUP5OIWJl0JG1+a9YxZycBLpYwCElrrMxDnwok3sE9IJMb21WwFeEqgDa/Bb260g8Sq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Jqq19Gok; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y2xgnUVTSEmtFl7AVjBTgOn4OO+GYRXOx9xXLnwDwhI=; t=1778207886; x=1779071886; 
	b=Jqq19GokzWQ7k53fE4YmsKamMuenQVDO4ia0ic8+yZN+X556ewcbDjMMPD2hUfA7PZ5Fw7vXrCp
	4INBXho1mk7KHb2GZQjx0XDBLbBsqH8Jdq4V5Q+pMC8jD9kzmnJyyH3xTGPQVdgr4YikyfDgQ6uR1
	hnz+LJal3xvAICXRdPeGHBnxKxngsaGmAqMDk9VDDmhh0BsBa5hN4peo1K5W8BEzl4sSLnkqWqjKz
	5q6BF3xo7FvU08zJnWu0TZX1OTPqrXo10ltyOyfcCKFfMlVhq78xPiQmsF/1wdxo4+k1iM3ltTSFS
	TkZeDDEp/tgsPvLwpzKzlLUUHbXrJ6hi+wwQ==;
Received: from mail-yw1-f169.google.com ([209.85.128.169]:52552)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wLB6J-00068A-Mf
	for netdev@vger.kernel.org; Thu, 07 May 2026 19:38:05 -0700
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bd810cdc5dso16502577b3.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 19:38:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ//T6hT+1xnDM8Ta4QqbTdFkS7BMdHjb40NmBvwuUAUqHsiVdzuWjL6OGklaanheeAya25T4/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuu2SDdsEZlBmKm9/x6deD0rLYwY7e9/lzGIaIzSbwNUkon0o1
	kgEMIhfwezMRXG+AlTGoTl2GHxhDiuSqFvFBlefJLf8IyVqo0XFR1KqghgLR0VfYiWrrgHjaOIB
	3qdKy4lDt3su4+IDKmYE7PttcBzNVvBo=
X-Received: by 2002:a05:690c:e094:b0:7bb:c0f:19d4 with SMTP id
 00721157ae682-7bdf5d7fff7mr116382837b3.4.1778207882943; Thu, 07 May 2026
 19:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507183843.1457-1-ouster@cs.stanford.edu> <379cd3dc-aff5-4fcd-bf9f-4878ae21ee74@intel.com>
In-Reply-To: <379cd3dc-aff5-4fcd-bf9f-4878ae21ee74@intel.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 7 May 2026 19:37:26 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzqBQha+XRu12ZpLTDBSMgAEANffD2uGKZ+VVdkMk6OVA@mail.gmail.com>
X-Gm-Features: AVHnY4LeXWVde9sR1jld00r7tS8euPOtaMdbiRvSbEKzDRI4GYQW7FInkNAHXv4
Message-ID: <CAGXJAmzqBQha+XRu12ZpLTDBSMgAEANffD2uGKZ+VVdkMk6OVA@mail.gmail.com>
Subject: Re: [PATCH net v2] ice: fix packet corruption due to extraneous page flip
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: anthony.l.nguyen@intel.com, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	przemyslaw.kitszel@intel.com, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: e7339ca2e2d71873cd3c16053348112b
X-Rspamd-Queue-Id: 9F5F94F0E47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285583-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanford.edu:email]
X-Rspamd-Action: no action

Correct: this patch only applies to the ice driver before its conversion.

The patch applies to versions 6.18.27 and 6.12.86. I believe the bug
may also be present in 6.6.137, but the code has a slightly different
structure there (the function ice_put_rx_mbuf doesn't yet exist in
that version) so the patch would need to be reworked a bit.

This situation isn't all that rare. It isn't a zero-length packet that
triggers it; it seems to happen if a packet uses every available byte
in a buffer, ending precisely at the end of the buffer. When this
happens, the NIC seems to generate an extra zero-length "buffer". This
happens quite frequently (thousands of times per second in some of my
workloads).

What keeps corruption from happening constantly is that there is only
a problem if the "other half" of the buffer page is still active when
the 0-length buffer is received from the NIC. I suspect that with TCP
this is pretty unlikely: packet buffers get recycled quickly. If the
other half is not in use, then it doesn't matter whether the page gets
"flipped" while processing the 0-length buffer. I ran into this
problem because I was testing Homa under conditions that caused some
packet buffers to stay alive for longer periods of time.

-John-


On Thu, May 7, 2026 at 3:11=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.c=
om> wrote:
>
> On 5/7/2026 11:38 AM, John Ousterhout wrote:
> > Note: major revisions to the ice driver make this patch irrelevant
> > for recent versions. It applies to longterm stable versions
> > 6.18.27 and 6.12.86; it also seems relevant for 6.6.137, but would
> > need modifications for that version. I have not examined earlier
> > versions
> >
>
> From this description I take it this only applies to the ice driver
> prior to its conversion to page pool?
>
> In that case, I think you need to Cc: stable@vger.kernel.org and include
> the relevant versions you intend to target.
>
> I think this case is "unique" since there would not be an upstream
> equivalent patch. But that is merely because we removed the faulty code
> before it could be fixed.
>
> I'm not 100% sure whta method to follow since typical stable rules don't
> really like taking patches that don't apply to mainline...
>
> Even with it being somewhat rare to get 0 size packet, it is not
> impossible and packet corruption is a Big(TM) deal.
>
> Thanks,
> Jake
>
> > Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/et=
hernet/intel/ice/ice_txrx.c
> > index 51c459a3e722..081c7a7392b7 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -1215,6 +1215,13 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *=
rx_ring, struct xdp_buff *xdp,
> >               xdp_frags =3D xdp_get_shared_info_from_buff(xdp)->nr_frag=
s;
> >
> >       while (idx !=3D ntc) {
> > +             union ice_32b_rx_flex_desc *rx_desc;
> > +             unsigned int size;
> > +
> > +             rx_desc =3D ICE_RX_DESC(rx_ring, idx);
> > +             size =3D le16_to_cpu(rx_desc->wb.pkt_len) &
> > +                    ICE_RX_FLX_DESC_PKT_LEN_M;
> > +
> >               buf =3D &rx_ring->rx_buf[idx];
> >               if (++idx =3D=3D cnt)
> >                       idx =3D 0;
> > @@ -1224,10 +1231,20 @@ static void ice_put_rx_mbuf(struct ice_rx_ring =
*rx_ring, struct xdp_buff *xdp,
> >                * To do this, only adjust pagecnt_bias for fragments up =
to
> >                * the total remaining after the XDP program has run.
> >                */
> > -             if (verdict !=3D ICE_XDP_CONSUMED)
> > -                     ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> > -             else if (i++ <=3D xdp_frags)
> > +             if (verdict !=3D ICE_XDP_CONSUMED) {
> > +                     /* Don't "flip" the page if size is 0: in this ca=
se
> > +                      * the data in the current half will not be used =
so
> > +                      * it's OK to reuse that half. And, since the bia=
s
> > +                      * didn't get decremented for this half, the page=
 can
> > +                      * be returned to the NIC even if the other half =
is
> > +                      * still in use, so flipping the page could cause
> > +                      * live packet data to be overwritten.
> > +                      */
> > +                     if (size !=3D 0)
> > +                             ice_rx_buf_adjust_pg_offset(buf, xdp->fra=
me_sz);
> > +             } else if (i++ <=3D xdp_frags) {
> >                       buf->pagecnt_bias++;
> > +             }
> >
> >               ice_put_rx_buf(rx_ring, buf);
> >       }
>


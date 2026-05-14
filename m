Return-Path: <netdev+bounces-287754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKkrNlYTBWpoSAIAu9opvQ
	(envelope-from <netdev+bounces-287754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:12:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6C753C451
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E73230156E3
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 00:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB61C17B506;
	Thu, 14 May 2026 00:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL7KeUGI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F578F4A
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778717517; cv=pass; b=Gy/L85245g1L1q1hKeBB5StJLH8ePL9ZcOM7B6dmHy7gzAtHGiybeuUvpaKf1qjOUJEkfcPLMy6bRke/iU47DdwKW4+SXW0MSSF9YDiXCKZwa9nhG0zNApdx8dp+k25NmTJ7QO7bFEF1IqnUHmabGGWexi+w4R/l2pW+xdoRRDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778717517; c=relaxed/simple;
	bh=9Fx6TEcuhP0uKfukSu8YwwdQeCUGDwPtmvcrrmZ+k34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALgpUGhdrYPT8hJ/Paq0ZBe3B1QRwYvNLswM5Ia8XLnLK4QB0SRw/c97vhBt1lruQ9EzSl/L0mTMuXavTp5ezI4CzR70tUmZr0TTBZE98heIYqFW0gEOcrbHeesCS1F0ZA9oCUbnxWxa2hDdSwR+hgfY5EY+ty74lKanjbksin8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL7KeUGI; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a40502e63bso6668765e87.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 17:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778717513; cv=none;
        d=google.com; s=arc-20240605;
        b=fhVUb/5zCjmWhgSnQAGfxbhI76Nw6mLYzKoHSyT0hAm+Y0orn6ILvvDx2bdCWQVfTi
         74Al2TydWWWOpC331L/FejTKVp8GfGc5CrCkeXsmygmI2fnGHiB33GDorYbItj8Un/kl
         2jurXpnC+R+VSEIDtwL4ozWen9CSmcBrKicpziYwjkryGohzWJRCTDhldKHa/1vwC8tY
         knhr24+K+QZU4gSw34gY3fAicz8772jNeMwPbIZN3oIsSC6AC02vFDCr6O2JHeCqmcQ9
         b84Yyk7FsZAHkBCwwvbw1ofyQG28zlvlM+LjTLa1PcbYdykZ6p1SFfvEcDOJZjm0dTzy
         /3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ecfv/2egnJYM7Ef3EdLiXvdvlvXcGmopKQvWn0K3Cmc=;
        fh=BNQs6+CPyjwFSpZgrPtNZTYM+NEuhD1PDSPxI/iFrjo=;
        b=Y0CMt1PC0iTpKZEvmnLc/yF2Op7jpPM0+yi/AeI2Mwvl7vPVCXM94+GgVp1rOweZB9
         s38oGFsDpOyCz30hZjeDoyyph7OUl7X7+EztnGkoyeGE/skuF3p7szm8oQ0HQuAEhlN8
         qCYZG+YIkqSaj0vTCd67yqzINhUdk9FrUy2zlxtcKF/RyJCthFm3vUflp1PiREyMllhD
         IhT6G/7SRrkRnFyhtCMtvKgFAdOk+Wml2PQxWwFfUeqqnUiQMX3YAobvfQVs5CA1HuVh
         kkShHzwA02UsPoHK665Edr9szk5CIWwqM4eKhjQhvHCUTfkX8UZwVuTRMfk0nyv396/S
         kZig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778717513; x=1779322313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ecfv/2egnJYM7Ef3EdLiXvdvlvXcGmopKQvWn0K3Cmc=;
        b=bL7KeUGI6u2D/8mMFyw5w1ReewAJSd6Kv30eLbNPcShyQNqVxX0SP6E2Q5FgXrZSMv
         bSOiSr7m/JEg5jTjyJFcTHrjRJDG5cxkzD7WBQm3M0R50HKKAemWBXSf9sf/f1vkUHCy
         QYxbP4FPrMzWmH20w1qY9YUokrQNwYENlHgX6Ud8w+bUTFwwAkOlb7rCxHlCA/yFLI+R
         w8kVDUt74eQ5nJU7dwt1yp2OO2Kq7mKFsFZ6bexgdg7ZvYdQZWn7GEEBPcWDijI6CqKE
         x/i4EtRESD7nFVeA09g6oE22ge1P0T6CC9dwfy/O9WB7ioXYWnQOY2BD5CQfmcvZKWzi
         OxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778717513; x=1779322313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ecfv/2egnJYM7Ef3EdLiXvdvlvXcGmopKQvWn0K3Cmc=;
        b=ECPzEkkgInjHDKJv9GvoSs/VoHVvLzK5W+N/E/OZBiLvLr2wCvSRp6UxA8g27w2tm1
         Fzyi/O1IZr7Ow5vbjGZda/sWBJg/VKwhC1BKY/A/Rwm3wus7ozwOVZhb3vgMURvEgLQh
         fzWQI4RFdvH5vnn4EwTLIQlaTa1W5kx5GJ6grofB3kN2HE3sZ2LfdQHwPaHlTbaekz37
         z2OIPasRWie22bbKgl4n1nOHdCkQY1hCEIn1kL7B+O4awCUq/ZPiOGp9gxyTAYv2PrWF
         578ogu8Kq4nED7Ge9vkWpqjQBM+oPxNeJoxi7vnUlffE9sAo+kgQTxPGaB9TK3WNb7nz
         6Z4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8mF7RkonP483/0AjDDZM4V0lTDDfwmxA30nGA/2ds7E35CFjUXm7kj0pnP1X0Gcm4+MnHyjls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQ9rSEYQyASNHVZziCFixbfIUAl42QQmiWCdBBi9EDI/5eGAD
	K+yo/oxdlWBAlR5VqQ7WZYQmfsBZysVBvS9UgbSrVNwzMuHmfcASuIzAyX8BOAi7rmZRtMJKTLH
	dOvw9Ci2Ufs091eSyK3msV5crWt9bCG4=
X-Gm-Gg: Acq92OFUZ/oIqKX+dcW3FYuKJ/mkAICZP14z2yU2MHKLBqq5x5eHZL5Q+TcznwykCOe
	gh1PTQ6rc35bdzutW8xd8nQklVWImG69OtVvcizPuuAdLnjQ3sA4Nx3B28Fh9NiM1DnksQeUpGc
	OOVMrH5jdXp25fgtRmEXY3PznG5tUqGT/9vjGf1yabxk3vNr78RR88LSw1F0gnjN4dQEzGjY5GF
	pI+fswnX+rlRUAZNaTv9UkGCLSF9TJU8/WXYt42EoT1hDYrGp4N4CvWoYEZb7+77YLX6+2b/8Va
	UT2BaAJbqldTI8YsqEJGqn8ZYSXRUGAVvGoCMMTrh01lPvBwtQ==
X-Received: by 2002:ac2:44c5:0:b0:5a8:f6fd:f201 with SMTP id
 2adb3069b0e04-5a8f6fdf342mr1021166e87.15.1778717512962; Wed, 13 May 2026
 17:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-2-kerneljasonxing@gmail.com> <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
 <CAL+tcoDrjJ8iHzSGz_Orf7iH-1WJ2H_LZd6BMKTnDS3MVN8daA@mail.gmail.com>
 <agOozH29XU6KQUTy@devvm7509.cco0.facebook.com> <CAL+tcoDqtEAqX65-8crUkUko5T_0nq=LSxAbMg+5jCAHa_uC=A@mail.gmail.com>
 <agSaZtBh-v6isF_8@devvm7509.cco0.facebook.com>
In-Reply-To: <agSaZtBh-v6isF_8@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 14 May 2026 08:11:15 +0800
X-Gm-Features: AVHnY4K-2doFlvgfTjD9RnebzpNCpRm6uN5I6-q9Co6W9ht1PFJwC1E0IPKHRyA
Message-ID: <CAL+tcoCEoptgzBgbDUH9tdoqJYa8QVgqe=7R4XThKocRM9SOPg@mail.gmail.com>
Subject: Re: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3D6C753C451
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287754-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 11:37=E2=80=AFPM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 05/13, Jason Xing wrote:
> > On Wed, May 13, 2026 at 6:34=E2=80=AFAM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> > >
> > > On 05/12, Jason Xing wrote:
> > > > On Mon, May 11, 2026 at 11:03=E2=80=AFPM Stanislav Fomichev
> > > > <sdf.kernel@gmail.com> wrote:
> > > > >
> > > > > On 05/10, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > The TX metadata area resides in the UMEM buffer which is memory=
-mapped
> > > > > > and concurrently writable by userspace. In xsk_skb_metadata(),
> > > > > > csum_start and csum_offset are read from shared memory for boun=
ds
> > > > > > validation, then read again for skb assignment. A malicious use=
rspace
> > > > > > application can race to overwrite these values between the two =
reads,
> > > > > > bypassing the bounds check and causing out-of-bounds memory acc=
ess
> > > > > > during checksum computation in the transmit path.
> > > > > >
> > > > > > Fix this by reading csum_start and csum_offset into local varia=
bles
> > > > > > once, then using the local copies for both validation and assig=
nment.
> > > > > >
> > > > > > Note that other metadata fields (flags, launch_time) and the ca=
ched
> > > > > > csum fields may be mutually inconsistent due to concurrent user=
space
> > > > > > writes, but this is benign: the only security-critical invarian=
t is
> > > > > > that each field's validated value is the same one used, which l=
ocal
> > > > > > caching guarantees.
> > > > > >
> > > > > > Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@=
smtp.kernel.org/
> > > > > > Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum off=
load support")
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  net/xdp/xsk.c | 11 +++++++----
> > > > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > > index 6bcd77068e52..cd039e397018 100644
> > > > > > --- a/net/xdp/xsk.c
> > > > > > +++ b/net/xdp/xsk.c
> > > > > > @@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff =
*skb, void *buffer,
> > > > > >                           u32 hr)
> > > > > >  {
> > > > > >       struct xsk_tx_metadata *meta =3D NULL;
> > > > > > +     u16 csum_start, csum_offset;
> > > > > >
> > > > > >       if (unlikely(pool->tx_metadata_len =3D=3D 0))
> > > > > >               return -EINVAL;
> > > > > > @@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buf=
f *skb, void *buffer,
> > > > > >               return -EINVAL;
> > > > > >
> > > > > >       if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > > > > > -             if (unlikely(meta->request.csum_start +
> > > > > > -                          meta->request.csum_offset +
> > > > > > +             csum_start =3D meta->request.csum_start;
> > > > > > +             csum_offset =3D meta->request.csum_offset;
> > > > >
> > > > > Wondering if it's better to READ_ONCE(x) these?
> > > >
> > > > I still chose not to use it after reading the suggestion from local
> > > > AI. The reason is there is no WRITE_ONCE pair to make sure everythi=
ng
> > > > is no data-race. I also checked some existing implementations aroun=
d
> > > > the shared buffer (between userspace and kernel) and didn't manage =
to
> > > > see the usage of XXXX_ONCE(). Does it make any sense to you :) ?
> > >
> > > Without READ_ONCE your patch relies on the compiler honoring exactly =
the
> > > loads and stores as written. Which I don't think it does (hence that
> > > whole WRITE_ONCE/READ_ONCE mess). IOW, it can pretty much generate
> > > the same code (and read csum_start twice) even with your patch applie=
d. Happy
> > > to argue with your local AI if you give me the output :-D
> > >
> > > I grepped io_uring/ and I see similar pattern for reading user suppli=
ed
> > > entries (via READ_ONCE).
> >
> > I roughly understand what your meaning is here. My thought is the
> > data-race condition in this case still happens even with the
> > READ_ONCE() protection (because no such corresponding operation is
> > performed on the writer side).
> >
> > Actually the local AI said use READ_ONCE instead.
> >
> > I can change this as you suggested for sure. Maybe related fields can
> > be protected in the same way in another patch.
>
> In general, feels like we should be doing READ_ONCE on all user-supplied
> descriptors (to make it more apparent that those can be concurrently chan=
ged
> by the userspace). In practice, probably too late and too much churn to u=
pdate
> everything at this point, so let's only fix the ones that can lead to
> TOCTOU.

Agreed. Will update it then :)

Thanks,
Jason


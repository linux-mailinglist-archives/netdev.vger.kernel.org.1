Return-Path: <netdev+bounces-252404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fvEoLbRAcmlpfwAAu9opvQ
	(envelope-from <netdev+bounces-252404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:22:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A0568A6F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84D8F30004D4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD57336C59D;
	Thu, 22 Jan 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjyXwU6G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27A387378
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094864; cv=pass; b=jlabA+6rhOSh31MJFhELgLAFsZKSNVYFBRMBzOfKlmFuFuTselCclvw32RodUmWg/YH5jt0uxd6/GFFdFz4ogqbVwy9xpn5yWiPrk2htq1JAZys3e88Fpc4Gx4bLL0lpUqD912upy0ApFiiguZVhP9L9LpJoy+z2ISY6yHKAckc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094864; c=relaxed/simple;
	bh=BzjoKlvqt1EzagDyE1uDPXUBk0JHsuSDNte2h/zwXm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzsXsGyNWAdIEoBncPxPMz2u3/dpJQt1DzT3zjLoa/7Z9QQ43uTm8WpjGCSIkKa9x2yUbz3OXX+19PxPy2Fpr6FREDjr7sySMgwy2DCOFh6dBqk/dTycJLh2K/ycabGigZ1bvd9RVQjpQio+ewc67xT8yIfiibyPzU/DcMCJwSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjyXwU6G; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-65f6f9d84d6so653271eaf.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 07:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769094860; cv=none;
        d=google.com; s=arc-20240605;
        b=MOi6YoI6I++CALrXOLi/i9Ht0ZojqNKENTe5jUanQaqYF4WeNrfeIDpbx6JPOKbVr4
         xicYyAC/PNnP6K1ZKXlktWQEC7NNEoRQmYdDbDqhYy/OH5THrPnmTzMR1+TzrPmDHjLa
         SCnDEJ/fmQkXkZgSXxkFNOj3cuzcryicJyKysycAeWfLc5T+IxYcM6ymHWTOGLPCROB2
         xDV/8IHLfxyN2iOClHGRAqYwHC8oqaQRlVX1cuu7Zme7RqImrjxpmh+kMYtq77ktnIYO
         FRI8xtfsw/JTz4LfRUcprkPtnI9SVval0NkyneYiSjRGXOazcAK3JpocKD657CG7DNzL
         wfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JBOZm8NEn1I7Enhvm7jPT5V5sGA/hVgZBX7ufyhJPsQ=;
        fh=P/HVX2Scij3vZdTIcYjaqMyR9xJ+3MajswY47mPMVIA=;
        b=F0qvRYKWh15vjKlHGGid+Tg6OYBS9Hg+8ZeXR9qxzPFZ28iNER6abQVTKrrUTpcpeX
         xqKR2YPv17zMwLT+r1amcswk9Wo0QAMsuVfT+sKh6gcd9wDVNBbicUR5LvsFBRfxHUiv
         MHRru/WgMy3/dwiq18/yemYNR73f8CzKtL0lfnAvAqkp2uPLkVnr+WBxQwCJUKviMrh3
         ExQGHA9dbeiSFp9dRHmpByyIJ4+x/IFScmvGZIHRw5mlVNGALaorywAmiusGJkDv5bfV
         nf7TRQfN5SnnrTUbgDyCk/XJpKmQk/yIZLEX8DwpKdJRSPVeUN/V81hJ03RBQl4oQA5k
         40Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769094860; x=1769699660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBOZm8NEn1I7Enhvm7jPT5V5sGA/hVgZBX7ufyhJPsQ=;
        b=RjyXwU6G4xPpty3DHY4MMLuK7bET/s4dZR1Tz5l2TGX4a7AKyQrk6AVN7WqcUDD3R+
         2AYPfTI+UXwyDxsYEMr0/IbXa5dbcKcc7sSMMMvXcabZqKqbDJ6lXvTi8T31cW3fJQZT
         JJKp5/2aWGK2/ESrbftV3bXjuwAZ9Ww3JarcavN7ppkkMtwt/bCV/PBp1lVxab8bhwnv
         FLj64vIvrkvhVWX8ljnPvW5FGZtJMQ7r9lpL6uMCHg6sBw/SRqj1PAGpcw8gW9T3nYPd
         pmBsF+Fy4mq9DfEbGnf+fOHFxDBqIZT7BrHIHIX+XZzj/b0pTAVVTb1H2fXgUDs7HKXN
         mg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094860; x=1769699660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JBOZm8NEn1I7Enhvm7jPT5V5sGA/hVgZBX7ufyhJPsQ=;
        b=Jo6JMqaaXrixPiEdx1VQKk7ZEIlQLW7Ue3euHiod6Wr2Z+szn10klelnOuiebbDo9h
         xxij7+6IcYVDo14Fq3BLRtJ0zPlwgOXAnihm0wyOX2bM+xAT0j7w+ANvuSm1NALaVLvQ
         3V5UcKFYRW0S1wc87aUsLO+g3l8+9270DBSFjZuVPUzbZpuSpY0FCusdUwjrZTDi3JqI
         LQksqdX1J0DzyZkOStjXlo3NTwlx/O0azhIGKZQ5nEwuL+55jA8J+QwLec2+ahaypV94
         qsGZdC5MkW+wSP3BM296tP/TORP5ew1glY2vFEZQskLq6/S4md6LEXY9FI7p0mlWDg3y
         rjPw==
X-Gm-Message-State: AOJu0YzqQnelj5BqQiRGFqvTgySO1tqdfqx41+LdYUveB8G6owbX+Bwi
	Oeoag/w+6vsNIBitmcWwg0nBIwRz3nEZD+QQ/kCdIfcNxP7HDUVhNzlF/x/Tbfj7dt/eEXMd0e4
	0mkUhoZkYV0xkZdHH6BmOjRXCSdLj/L4=
X-Gm-Gg: AZuq6aIRXaYBMqpnEupEPbQ6ET0NCojQJ1H6NUvQLhSoZBQH2+KW3KyftpI6UCi8euk
	9q4pgk0i/egdIGa0pLk7LaUv8UX/cRtNn3FnO9XvqcxzGKdvaALTSICQJU4ChvXAkYRbspe5xiS
	3VRAwSliq865Qn8nH3NNvEEON6W1gwh7g+zKJBWdp0qMhHOCO1m3dxZQgq53Znhy89usgTbm6LQ
	Oe1nrTmjTwgTjbCyJdyxfn+5gucIYVk24xD4bakWN5PUjN+tg+XOT09XDn9addqi39cm+f7Fwxj
	eGg/fQzPqWKIavG4yQIhu5AN0rGQsDr6fGm7458EB3crODQ0OP6+SaEJjFLY
X-Received: by 2002:a4a:ddd1:0:b0:662:bffd:9e35 with SMTP id
 006d021491bc7-662bffda1e2mr1583385eaf.77.1769094859811; Thu, 22 Jan 2026
 07:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120092137.2161162-1-mmyangfl@gmail.com> <20260120092137.2161162-2-mmyangfl@gmail.com>
 <aXELnMSc4UU6DkbZ@krikkit> <CAAXyoMMAMAbEu=-wTf3MGMiZr2Uq7pqJXC+_zrtxKrsjyYi+AQ@mail.gmail.com>
 <aXIIBbCpuY_ISi-t@krikkit>
In-Reply-To: <aXIIBbCpuY_ISi-t@krikkit>
From: Yangfl <mmyangfl@gmail.com>
Date: Thu, 22 Jan 2026 23:13:43 +0800
X-Gm-Features: AZwV_Qht3cszjBZS3tSwI0aj4ueyYvMDm0wFiSnF3H1eB_3KslEbR7FUK3MfJh4
Message-ID: <CAAXyoMMJsWK8F5neewwZHtEHe0-iT1rbfPekSDXm7HJvG2bOpQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] u64_stats: Introduce u64_stats_copy()
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Carolina Jubran <cjubran@nvidia.com>, Breno Leitao <leitao@debian.org>, 
	Shigeru Yoshida <syoshida@redhat.com>, linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252404-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Queue-Id: 35A0568A6F
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 7:20=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-01-22, 02:22:49 +0800, Yangfl wrote:
> > On Thu, Jan 22, 2026 at 1:23=E2=80=AFAM Sabrina Dubroca <sd@queasysnail=
.net> wrote:
> > >
> > > 2026-01-20, 17:21:29 +0800, David Yang wrote:
> > > > The following (anti-)pattern was observed in the code tree:
> > > >
> > > >         do {
> > > >                 start =3D u64_stats_fetch_begin(&pstats->syncp);
> > > >                 memcpy(&temp, &pstats->stats, sizeof(temp));
> > > >         } while (u64_stats_fetch_retry(&pstats->syncp, start));
> > > >
> > > > On 64bit arches, struct u64_stats_sync is empty and provides no hel=
p
> > > > against load/store tearing, especially for memcpy(), for which arch=
es may
> > > > provide their highly-optimized implements.
> > > >
> > > > In theory the affected code should convert to u64_stats_t, or use
> > > > READ_ONCE()/WRITE_ONCE() properly.
> > > >
> > > > However since there are needs to copy chunks of statistics, instead=
 of
> > > > writing loops at random places, we provide a safe memcpy() variant =
for
> > > > u64_stats.
> > > >
> > > > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > > > ---
> > > >  include/linux/u64_stats_sync.h | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >
> > > > diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_sta=
ts_sync.h
> > > > index 457879938fc1..849ff6e159c6 100644
> > > > --- a/include/linux/u64_stats_sync.h
> > > > +++ b/include/linux/u64_stats_sync.h
> > > > @@ -79,6 +79,14 @@ static inline u64 u64_stats_read(const u64_stats=
_t *p)
> > > >       return local64_read(&p->v);
> > > >  }
> > > >
> > > > +static inline void *u64_stats_copy(void *dst, const void *src, siz=
e_t len)
> > > > +{
> > > > +     BUILD_BUG_ON(len % sizeof(u64_stats_t));
> > > > +     for (size_t i =3D 0; i < len / sizeof(u64_stats_t); i++)
> > > > +             ((u64 *)dst)[i] =3D local64_read(&((local64_t *)src)[=
i]);
> > >
> > > Maybe u64_stats_read/u64_stats_t instead of local64_read/local64_t?
> > >
> >
> > I think casting to u64_stats_t is a bit overkill here since we accept
> > const void * and we are the actual implementation.
>
> It would be a bit more consistent. Just within this function you have
> 2 lines using u64_stats_t and the 3rd uses local64_t. And reusing
> types/helpers within a similar context doesn't seem overkill.
>
>
> [...]
> > > Since this new helper is always used within a
> > > u64_stats_fetch_begin/u64_stats_fetch_retry loop, maybe it would be
> > > nicer to push the retry loop into the helper as well?  Not a strong
> > > opinion. It would be a bit "simpler" for the callers, but your curren=
t
> > > proposal has the advantage of looking like memcpy(), and of also
> > > looking (for the caller) like other retry loops fetching each counter
> > > explicitly.
> > >
> >
> > The callers may want to copy other discontinuous data as well, albeit
> > no one did it then.
>
> I'm not sure why they would. I think the main point of using memcpy is
> "I don't want to copy each counter by name one by one", and possibly
> "I don't want to have to patch this code as well if we add a new
> counter". If you already have a batch copy for a bunch of counters,
> it's usually easier to add others in a contiguous block.
>

While I agree with your statement, I don't think it's a good idea to
push the retry loop into the helper. u64_stats_copy(syncp, dst, src,
len) would be a strange API, while no others accept syncp argument.
Also, it would give a false appearance to those who read the driver
code, since it does not involve fetch_begin()/fetch_retry()
explicitly.

In my opinion, it would be better to introduce a for-like macro
#define with_u64_stats_fetch(syncp), eliminating two function calls as
well as one variable declaration altogether.


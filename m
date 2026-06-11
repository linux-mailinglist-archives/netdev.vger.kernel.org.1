Return-Path: <netdev+bounces-298309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ClKVMR0MK2pf1wMAu9opvQ
	(envelope-from <netdev+bounces-298309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:27:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64821674BBC
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:27:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=f+2xK7Az;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298309-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298309-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43B6B322F3A5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F3E285061;
	Thu, 11 Jun 2026 19:27:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FD369D77
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:27:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206032; cv=pass; b=Dnq4e5bXg3NouQrCCv/VQvgSBbZfjbj9yDZtAVFzSj7U2ig4VVK7sFFdTLaRS5hcVifEdCI5ZUd29hymuMMGIDLFYwZpwdFoW9yYXyGOkl3Nz1q63qHrC+SugrS5+xAVT/iQwHlkqu7dS50FWTO0kSnRO4jQrSxrrhHLso6N8R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206032; c=relaxed/simple;
	bh=GiJIqbi/zt960Tj+KwRSqVMjpp+NhQcRoTz0Bx8JZJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hxm51yaEsg2KXfyyit55cSeiarnO8R0LQ6uOmc8pIeW1XG+243PNvwlEGoJ3vzguFQ4w/oXuHUQfqGePfr7hmRbFtRIA+jb1wujVOAze2lrFYDOWXM+nnG5ddID838AC6UaffIT+7v3nAzA0YgJYbGZTUnHQvsKm6r3EtbBB79k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+2xK7Az; arc=pass smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5175d339e8bso115551cf.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781206027; cv=none;
        d=google.com; s=arc-20240605;
        b=YxNyDarxmrY+Q8iNK2prwhLb+DuX/Xd5agDVnP3yAHLFIe427qXY6TvRAkElNe3Z1i
         3eF1OYtDFL/Ccnxmq9Wl9d1QTahJn9RfVmLKHQ/2hzlr5IjRiawVgMg44gAsVFlTZRV1
         7I4LdVOVJ8E4xwfGQaPRsS9TMkxcV+oVII7dVdLbzBJ5EWm92HDU/fRmFtp21TZGToN2
         ZXTK8iAa+viinVgA+urBwxhEJdd1jAVa1OXian4hl6K90j+ULxxX6++9EbJSmUHK/Co4
         tf5G8iBziY3kchEVdFs/NrthKt1xiJ7YJ6VwfU+MfB6ysTxi/fVn/0cmr3PjBlApa5YZ
         HehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B9qk5GpsUA8CAgTHbPborw1Bfo5DBMe+LeFNmN/rkbU=;
        fh=J+6UsfIiTpWV0enGVylGeNFih9idI2/JPj9ahtv7Pls=;
        b=PAkqbsIk8ib2a+xLPGfD8U6MrGXvKzKghX35+P1tjodbD48YuKeiXq6viLBuI9Sldp
         yR9vquPO3tdOz8MAhgBkv+/Xf84gZzvfvn/LL9WwDVxCH/NkWzVwzwz22riWEzqFvSyr
         yLGHwYXZMpNU4huw4eHD21U39+77yGSHjpXCuZTzABcyuZ/AoF6UhC2BcoeZvLTwP+fl
         Xfdi/Xd1wZLKmGTai1MbF2rRBB01YEDkq9gb00Bj+lu62uCQD+8JmIVI+lDebyVyg3+o
         oFTRXLk04O49K6tGw9ekDo54xN5YYyGZvFhRErVs5XEvAnC01fYIOy8wfkiL97CwkC5t
         hFkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781206027; x=1781810827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9qk5GpsUA8CAgTHbPborw1Bfo5DBMe+LeFNmN/rkbU=;
        b=f+2xK7AzyQrcrmbZJQ+234fii6z3bLYSHlgeOy/1SRCeyDm2nHdZ4cnPX577bxWV6Q
         CvtLY4hAORZl+R5XWmejUBcNSt/+BWHF4pznauYQ8IBqJJU6TZqRl3Q/QKOa4wrUcqqa
         CSpIrbx1j3vHQHCZrNrU39KYupoVaWlJSGzxtb9t208xejLiYbRfi+CBrmqAVEc2sJVa
         OJ2z8jl5GZ+H6gcj1NFrVKB7x6Bky+N2HCGriZHNZKqfqfHK58tSpE2sj8ysudVbf9Wa
         YUdZds+EkG3uhah+Tl98uajzwyWFmoZ7Yzeb3aAth/Daa+zbfjhnLcsRjVacAWd6rX6X
         y0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781206027; x=1781810827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9qk5GpsUA8CAgTHbPborw1Bfo5DBMe+LeFNmN/rkbU=;
        b=g/dvGFgj3Li2jdcZQkW9Q7O7BqEjDq+HW/WWQaPBFPutJ3vJd8TVIt5itsgvDPsmhg
         VRc90UHo69+J7JNOmGgVt/9CQAeXoczee30VVGk9nC9iqeEVvNqYTOlea6xBHu41evTg
         0oe3n1brjv3pYph5ipGq8IV0qu2SeynmDq+CpsnoP9xYX7CjnD0Q9nXWRQGJaHgQa9f7
         GkJulLp5PR6q6c0ri2e6B6S88REKOHL4+8srNgFKzH/K4Hx1jqDk4zwJOVvD6/lYqfsw
         bdr3AkJrHBb5vuKC4IO0ADc6w9b/uns7u1CIywVyjJsBBXe2aGQUtIDQ6trvBWwXmLtA
         Z2Bg==
X-Forwarded-Encrypted: i=1; AFNElJ/AI5XUB4mpm0Qfxz6OjC8V1vX/cxH2dLjzmVe0CcmYiLsCtTGmlDVhaUctguIsS41BDCbHEYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+cnGB6VJSQARaIrzOLPhY5flRob5VsejfB1WdYDMGxMwChyJ
	0C6K69z6WmIXhefY7t2dphRiFoDK/ImWzLU1sb4sOckudiWOE7Y/a9WMjLcC55Mu183krZSQg2j
	ruZ2KvFzVDuvQBnYqwgTHfCH2naeB/kzJrfm0dhvT
X-Gm-Gg: Acq92OFmuVydvwcyHGUfuwFOjNEumqY6zGuhQidYx3VjLVdRM5BmtlKlUzxvml1dX5K
	1MFq1hFv/yDhuIUsJ/I2k4nGSWHW0SIbv0OyfZUJs4ZMsqR2U1rcD/+PzOX95nhTpW2+SZgGocT
	0x2EpfxcXr+/jlyqWFfCRPtLyJ6e460dbYmmpUPOr/pT8FYkOySjmmDQ1vfKy7t93I0nPbiAXr6
	Bi2t708or9ZiPwXvHtUemQhW67rq/hGXsaRDEB97tvSttZZvXgtyrkRSlTQcr9Gu7Um6GmGxwAK
	/t4//j17OwHSgsJBSMdwqAajGwitEMCGFSIIdA1HAbfP7Els+7y7uNjaOFwVR9czNxahjR07MVa
	K2UBX1h4=
X-Received: by 2002:ac8:5751:0:b0:516:3b3c:1df2 with SMTP id
 d75a77b69052e-517fb081b98mr1442321cf.14.1781206026577; Thu, 11 Jun 2026
 12:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
 <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com> <CANn89iKkPJqOM=0KV8O8=2zWrZObj+E+VJoLztp4sUi7Vj0aQg@mail.gmail.com>
In-Reply-To: <CANn89iKkPJqOM=0KV8O8=2zWrZObj+E+VJoLztp4sUi7Vj0aQg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 11 Jun 2026 15:26:49 -0400
X-Gm-Features: AVVi8CcE5E6vt2s5oq4L--FKZfAYR8Si6-gSnr-nTlOrZF55zyd_6sc57DK_ztc
Message-ID: <CADVnQyk+sOAKU_WtPja7_hgiXw8he9U1g6AY7iEm5q3F3R-Hag@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback for TCP Prague
To: Eric Dumazet <edumazet@google.com>
Cc: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	kuniyu@google.com, ij@kernel.org, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:chia-yu.chang@nokia-bell-labs.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298309-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[nokia-bell-labs.com,kernel.org,vger.kernel.org,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,lunn.ch,gmail.com,google.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64821674BBC

On Thu, Jun 11, 2026 at 1:01=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jun 11, 2026 at 9:15=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.co=
m> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > This patch adds tso_segs() CC callbak for CC algorithm to provides
> > explicit tso segment number of each data burst and overrides
> > tcp_tso_autosize().
> >
> > No functional change.
> >
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > ---
> >  include/net/tcp.h     | 3 +++
> >  net/ipv4/tcp_output.c | 4 +++-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index e8090f542f7c..3b415c9dcc54 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -1366,6 +1366,9 @@ struct tcp_congestion_ops {
> >         /* override sysctl_tcp_min_tso_segs (optional) */
> >         u32 (*min_tso_segs)(struct sock *sk);
> >
> > +       /* override tcp_tso_autosize */
> > +       u32 (*tso_segs)(struct sock *sk, u32 mss_now);
> > +
> >         /* new value of cwnd after loss (required) */
> >         u32  (*undo_cwnd)(struct sock *sk);
> >         /* returns the multiplier used in tcp_sndbuf_expand (optional) =
*/
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index fe725d94a225..a7206fa61957 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -2274,7 +2274,9 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned=
 int mss_now)
> >                         ca_ops->min_tso_segs(sk) :
> >                         READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso=
_segs);
> >
> > -       tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
> > +       tso_segs =3D ca_ops->tso_segs ?
> > +                       ca_ops->tso_segs(sk, mss_now) :
> > +                       tcp_tso_autosize(sk, mss_now, min_tso);
> >         return min_t(u32, tso_segs, sk->sk_gso_max_segs);
> >  }
>
> Can you explain why min_tso_segs() is not enough?
>
> We do not need two different mechanisms.

I'm pretty sure this was proposed to meet Prague's goal of having TSO
bursts be sized to be at most 250 usec worth packets, rather than the
default Linux TCP TSO autosizing approach of 1ms worth of packets:

https://datatracker.ietf.org/doc/html/draft-briscoe-iccrg-prague-congestion=
-control-04#name-segmentation-offload

Where "MAX_BURST_DELAY" is defined as "Maximum allowed bottleneck
queuing delay due to segmentation offload bursts [s] (default 0.25 ms
for the public Internet)".

AFAICT this proposed patch is no longer needed now that
tcp_tso_autosize() uses a parameterized approach for :

   bytes =3D READ_ONCE(sk->sk_pacing_rate) >> READ_ONCE(sk->sk_pacing_shift=
);

AFAICT tcp_prague can simply set sk->sk_pacing_shift to be 12 for its
purposes, looking at:

   https://github.com/L4STeam/linux/blob/8ac01b97ffd993b1fed93a015ec30dd085=
857e8b/net/ipv4/tcp_prague.c#L144

   static u32 prague_burst_shift __read_mostly =3D 12; /* 1/2^12 sec ~=3D.2=
5ms */

Then probably this patch is not needed.

neal


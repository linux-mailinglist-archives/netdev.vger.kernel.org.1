Return-Path: <netdev+bounces-297345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id khAIKlyaKGrSGgMAu9opvQ
	(envelope-from <netdev+bounces-297345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:57:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D9D664AE8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:57:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=i0LGsEPZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297345-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297345-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF56F302351C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4673EDABA;
	Tue,  9 Jun 2026 22:57:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5683ED3AA
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:57:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781045828; cv=pass; b=hMLvpmI6A9HwqGmQp6AbVT4V5ouBfHpdEdu5rDBRgBMpMupjQpameYmFRe5P6WD0OH2bZ2adisOZi4Rvrg92pGCciw0Ak5IZrSudoN44pcDr6j5PnKHLyI9mlz0ZYu225rK6WnOC4hSMtImzNAf06WnJ1rgJAw0DYAUZD/fGOW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781045828; c=relaxed/simple;
	bh=FJVNHzxPnmF861w/IYvmWTP6kYwvaOT2RUNaoEZTad8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocJR7ER5od/2DCyobSbJ/cvN9/dbetupGpjnYUPwr03dsZP8A2td8Wmx78BjF6dxFgd6ZNngHSK0aNIADqlsmVbshnxp1MtDz2OdQtNMCVvY7bT6uGJ7Sz5dV/6ihL9KZ1usRnP6yg48U9B9chbbh1eSfQ9ylgv74VzsQlvKL/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=i0LGsEPZ; arc=pass smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0aa420401so47277205ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 15:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781045826; cv=none;
        d=google.com; s=arc-20240605;
        b=GBa6562Q6xsRAVwQJD3x04RuR3BfBO5iIFLxts9pwuDCsmCkyN/5NznoTLj5l4rfKe
         p1cjB/RoibiacjuZ43LW3t9bzY4OoRoRc8103CrJEv8ct5IiJ7BYh5SB4bb5mBUC+FKd
         ZoJa83xFT0ymefrxTJH/Ia3fgHI6XFMXjt3scpozFzUyo4K3spsqmi/JnWvHlqSrFKVY
         pydUhQVCDXqbx3GoK3zHUWfDh9+arZFyVezsoqgwRzRylaQ4hKR+NeiF3C77fIIJhZt3
         5PcQZ/YGBgIfyn3/zUsSmo5RiWy4KzueuLFZDEnIFHRJ9hVrKQngwUN4ycDvkUh+Fm13
         mFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qEqKUzJO2jlie+1r8aMh98L/XxOod7KRRcuXrHmlPxg=;
        fh=S/p8mD4kqhRqVVtl/ltbi4Ogr2L2SbrWRn9TlwzEZx8=;
        b=SA0nkexe/NndW/m8gT687HvVtd5tBt8P0Nlo8cHGvfQZF/6RdJ7vDgm3KR5t7Pwx3j
         OqobqyAwM5J/aHf2e4Oba1oqT9LnaPt/20e4As9KqyEou1kekKFpvnEjeb2EKY6rb5Ap
         A9pVHdCOvzmknF8N8nlo68mEcMOgPSY7ptnMOCG53IAnbf1YjwjtXwuAGjqcjYi9NneO
         ahI9YhNXYwati3I1W7dtOImi79ygSqbl8cqHTtO/ayLfIMshQ/hISSfAEKFm99qoHkHy
         LpHEHhJp998XrcdDidw8OSIM2Nj1aQrYNhyi/WsNJ1VdO9QHIunJEJ2YnGztlodYqCBN
         9dzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781045826; x=1781650626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEqKUzJO2jlie+1r8aMh98L/XxOod7KRRcuXrHmlPxg=;
        b=i0LGsEPZJIHkIKI62mWwLHAgxTcz352vwK41lcG8WuG5CwLDt0kTmvGvu9QYC4Uec1
         nHWW/g8U91FrXEYg+wRizHoQi2n3VZ0TuJv0QPBgIpTt9IQNX9CKJq+Sxmxxb38F+oCm
         Hai0JNr5eZGGy83ZHLxxgFyr7NfnxyeIsugr1HaZ7vAtvjCY+S0K9uSaBplcd7+C7UnB
         pVznf/IQ7gPD+5bUlakb+wfHXxhduny1Rl8pPqRR4RRdWnKnY/9Q93ifP0SqusRrw1yi
         UBKN9RQRV79XcJFzTcGsv2fp+bhZij7+IhcBAPB15xu2yIE1BNX/8ScbP2zMt/tBLzdq
         yvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781045826; x=1781650626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEqKUzJO2jlie+1r8aMh98L/XxOod7KRRcuXrHmlPxg=;
        b=r/LdVRkdoEQwsLVTCCzjDhwcSWpiUUcHyNPmMqzjyGbZViBQQU82gvfgqXgA0H5WuD
         JampdbQXEq2mEVgYRiI6VS2Kh+Nqrx1TGAhCcj6SZshFAwhc30cogbHgPT4N4XSSTPwO
         EFJ5hLkUc3YR9sUkbfynn7p0qCGAQYqFCX1ryJ35Idvgp1uUfnDVBC3CUHu78g4T6HHb
         8bDh4mBcRzPxS+IbZBXtZx9oRUnQWjRCKZmIeGmO1XyiEFyacMlRLP6fbndcO2I81oaI
         ZDi/qtYmpIEJy2G+qh4Gteu2xzp0IsrnmTmeycvO9h3Yb2hRcGpwEIm1efYqiMNRuxg2
         a01w==
X-Forwarded-Encrypted: i=1; AFNElJ+27Zelny7CTbERa8F9guzwJ2YEOjLXxQvcQXbfNbhuhVGZJ8emb3Uz/1qpTnvpgOVTA2+MCzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zy1I8WAV/IYKYYCH6zaHL7DbzBzw/njU5forEX7dBahYxDSg
	YehFe234p5HzUk40vXrLTGzt0ibiQdhdcnm83mcnJrHxo726EPnqOvfNx0eR6Hy4auHZEJpq7rC
	8BzgzXzMnzqdDYW+t/Lb4LiPXHxmiogOWbZBiHwDKAG7xoz4lpdElmzv+
X-Gm-Gg: Acq92OFh+hNLAHS25aThUovgNUlKId6bvLGo7gGwHO6KixcJdTS20PiPkBUKQJZBc4c
	htQujEMjA1djduSFotMDp63j8sRW3DtObWdcPJ0GBU1/poorD2yOgYQckeEWoKv5w+j7pD+2Fax
	lIj3gAd0TTHTQ5UoggKL2f2tJuzDsJcKKF7LdQHjJlBGM5Z4uHRUuHNLNk30RFxcXqTz9TpRGTA
	jkJIMPr3QSJ9+NXv1RdcLDFZemqsCjv5nElTASExjWSdOB00wUdm9mxLv3JRoLVpfnWLxM26x6z
	o4vxpmFsePJTyRlxdMqjBl+A5e/Pk8hGxyNy4XY6fuvY5hwdq9SW
X-Received: by 2002:a17:903:faf:b0:2c0:ca99:3d73 with SMTP id
 d9443c01a7336-2c1e7b2f203mr251660005ad.8.1781045825877; Tue, 09 Jun 2026
 15:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608001124.309352-1-xmei5@asu.edu> <aih9kXLYQKsWbUmP@chamomile>
 <uirq3v4lihhyfwg5x46xfupncevwzo4lgncit2ftsbq3jse67k@yavzv6oocv4d> <aiiVY8ieb4o6wOgP@chamomile>
In-Reply-To: <aiiVY8ieb4o6wOgP@chamomile>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 9 Jun 2026 15:56:54 -0700
X-Gm-Features: AVVi8Cf2Kzxou-mxBuvg5OhyiHxUFJ3PvFaNT_fh9YTC6YOAazq1HCmb3GSEpRo
Message-ID: <CAPpSM+TKh2n2YMa7Opm-_EYjCd0-6J9Cg=zB_DtiNGs4tRRd=Q@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: nf_log: validate MAC header was set before
 dumping it
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, davem@davemloft.net, edumazet@google.com, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, coreteam@netfilter.org, 
	netdev@vger.kernel.org, Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297345-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,netfilter.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,asu.edu:dkim,asu.edu:email,asu.edu:from_mime,netfilter.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38D9D664AE8

On Tue, Jun 9, 2026 at 3:36=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.o=
rg> wrote:
>
> On Tue, Jun 09, 2026 at 03:01:14PM -0700, Xiang Mei wrote:
> > On Tue, Jun 09, 2026 at 10:54:41PM +0200, Pablo Neira Ayuso wrote:
> > > On Sun, Jun 07, 2026 at 05:11:24PM -0700, Xiang Mei wrote:
> > > > The fallback path of dump_mac_header() guards the MAC header access
> > > > only with "skb->mac_header !=3D skb->network_header", without check=
ing
> > > > skb_mac_header_was_set().  When the MAC header is unset, mac_header=
 is
> > > > 0xffff, so the test passes and skb_mac_header(skb) returns
> > > > skb->head + 0xffff, ~64 KiB past the buffer; the loop then reads
> > > > dev->hard_header_len bytes out of bounds into the kernel log.
> > > >
> > > > This is reachable via the netdev logger: nf_log_unknown_packet() ca=
lls
> > > > dump_mac_header() unconditionally, and an skb sent through AF_PACKE=
T
> > > > with PACKET_QDISC_BYPASS reaches the egress hook with mac_header st=
ill
> > > > unset (__dev_queue_xmit(), which would reset it, is bypassed).
> > > >
> > > > Add the skb_mac_header_was_set() check the ARPHRD_ETHER path alread=
y
> > > > uses.  Only skbs with an unset MAC header are affected; valid ones =
are
> > > > dumped as before.
> > > >
> > > >  BUG: KASAN: slab-out-of-bounds in dump_mac_header (net/netfilter/n=
f_log_syslog.c:831)
> > > >  Read of size 1 at addr ffff88800ea49d3f by task exploit/148
> > > >  Call Trace:
> > > >   kasan_report (mm/kasan/report.c:595)
> > > >   dump_mac_header (net/netfilter/nf_log_syslog.c:831)
> > > >   nf_log_netdev_packet (net/netfilter/nf_log_syslog.c:938 net/netfi=
lter/nf_log_syslog.c:963)
> > > >   nf_log_packet (net/netfilter/nf_log.c:260)
> > > >   nft_log_eval (net/netfilter/nft_log.c:60)
> > > >   nft_do_chain (net/netfilter/nf_tables_core.c:285)
> > > >   nft_do_chain_netdev (net/netfilter/nft_chain_filter.c:307)
> > > >   nf_hook_slow (net/netfilter/core.c:619)
> > > >   nf_hook_direct_egress (net/packet/af_packet.c:257)
> > > >   packet_xmit (net/packet/af_packet.c:280)
> > > >   packet_sendmsg (net/packet/af_packet.c:3114)
> > > >   __sys_sendto (net/socket.c:2265)
> > > >
> > > > Fixes: 7eb9282cd0ef ("netfilter: ipt_LOG/ip6t_LOG: add option to pr=
int decoded MAC header")
> > > > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > > > Assisted-by: Claude:claude-opus-4-8
> > > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > > > ---
> > > >  net/netfilter/nf_log_syslog.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_s=
yslog.c
> > > > index 7a8952b049d1..ed5283fb6b67 100644
> > > > --- a/net/netfilter/nf_log_syslog.c
> > > > +++ b/net/netfilter/nf_log_syslog.c
> > > > @@ -815,7 +815,7 @@ static void dump_mac_header(struct nf_log_buf *=
m,
> > > >
> > > >  fallback:
> > > >   nf_log_buf_add(m, "MAC=3D");
> > > > - if (dev->hard_header_len &&
> > > > + if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
> > > >       skb->mac_header !=3D skb->network_header) {
> > >
> > > Maybe this instead?
> > >
> > > +           skb_mac_header_was_set(skb) &&
> > > +           skb_mac_header_len(skb) !=3D 0) {
> >
> > Thanks for the quick reply to this patch.
> >
> > The skb_mac_header_len is a combination of
> > 1) `skb_mac_header_was_set(skb)` and
> > 2) `skb->network_header - skb->mac_header`
>
> No, 1) is only true if DEBUG_NET_WARN_ON_ONCE() is enabled.
>
> > However, we have skb_mac_header_was_set added in the
> > original patch, and we have `skb->network_header - skb->mac_header`
>
> I think this is the last spot which opencodes skb_mac_header_len() in
> the netfilter tree.

I see it! I misunderstood the previous message. Thanks for the explanations=
.
>
> > at the start of the fallback code block:
> >
> > ```
> > fallback:
> >       nf_log_buf_add(m, "MAC=3D");
> >       if (dev->hard_header_len &&
> >           skb->mac_header !=3D skb->network_header) {
> >           ...
> > ```
> >
> > So I think the original patch should be enough.
>
> I think this patch could be streamlined like this:
>
> ebb966d3bdfe ("netfilter: fix regression in looped (broad|multi)cast's MA=
C handling")
Thanks for the example. We have sent v2.

Xiang


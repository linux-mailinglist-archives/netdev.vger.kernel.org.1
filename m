Return-Path: <netdev+bounces-299699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gfu7AZyqMGo1WAUAu9opvQ
	(envelope-from <netdev+bounces-299699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:45:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED268B51B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:44:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OwnPR6I5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299699-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299699-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 755E7300E635
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8079D37C0E5;
	Tue, 16 Jun 2026 01:44:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A60A37C0E7
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:44:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574297; cv=pass; b=KUqXNFgi98hP6cbQVDhZA6mUAs+8Ut9E3kqIIVkb9lrEE5FtKkrSITETQqxIUDMRuL/EU9wvqlj+g2+OT7lGD5frTLFpZhW7pAfOB28KNNDs30JiQtXXGFUdF0R27+fZI32DeBYs2vVJP2E1hxTwmmOUv4Sg2itU+VEg3/rfOY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574297; c=relaxed/simple;
	bh=8tb1U1aZ9n4reEv10sQy7avbCZsN68fkX6jT/KPserc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ho9gx6LbAa/QSKIVSXtFaEFmsYRCVo3OAfXV7+4nuBvljqIG+arFB2R8kg8Uuy9xkS/j8ueCYVlwHoFCSH76RvhwU71coLbUSVhPAtiksos/ab8mBHyqox9TuStUbTZ2gQpPbaVabH6yINiFEFv5E0F++jnj8z+vXQLajNDY0P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwnPR6I5; arc=pass smtp.client-ip=209.85.128.181
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7e0b3db3499so29332727b3.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 18:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781574295; cv=none;
        d=google.com; s=arc-20240605;
        b=H871czGkyYBEJA/xAredm324Lad/SyR0DsBrAhN7CgPm6HOVPa4ySlTkVU7193zToJ
         RY9RyfKKGURYwsGVRohbaVbzy3QixylL+Med4KPmsypAMEqGYgjEJ/yFYr8g9LBNARTy
         rfUL37UIdwWIY0DJQSTYAmIRZK3hK+XXQV1XvKxWpFBQ4J6Yo63LY19bo/J13wEc+r+d
         HGvaqsZ0hLbdD7uCZem+B2SmaO4NW3EF02cyYyDm8YyDKzt4afl/qxpIw1Gh1e9XAVzf
         z2CZuuZ2dJ4BVkQO3vtswZCtejNVPj10JjMYNq4KWUDl8a89lsDsIGd1L/i07F4hTT0q
         //VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=73H1rmBZsR9HB0wLO22wKQ4YOh6GObKN7jR8HYwzlak=;
        fh=5x4M7j69rZg5+jMGVbNRVLzLDkCdTHP0GCiz544c0Cc=;
        b=QH+IR/QyOAXgVddDEAdT9ZWFn3pNbzMM4Xp3IwpMZjcXXBosUc++NIWjOwJ9mnOVWM
         3W/qPv3NfgXn9zEW1eIu5neTJzAbbfQz1CiMK9U9EGdnS+chpbQT0I91eK2Exe8yzPQu
         3k5QTgAz9u+R1sJTCvQKTyx2KtY1Jqgn6LRaH9ST5Spd9hffjhJ0fPllbWpv7SmTRvGX
         Ee4Kl7Zc0a0pZQ8KfyzDr+QIdbqHebKIpc0c+/PsQNRkZxbBS++mPQebYeQ6WR69hQdy
         lcpBrkmvZlCDKQkNEo1z8HZnwlTvBtczDZk5JbNxEvY/7Ek138fHJ7bpTiYhRT5SDJcP
         8sFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781574295; x=1782179095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73H1rmBZsR9HB0wLO22wKQ4YOh6GObKN7jR8HYwzlak=;
        b=OwnPR6I5iIs3RNyIl7li/ifWPBaRoWSLpVjjuEyDVWS62jUrE/MoAVNMhCMGpbIqrE
         /2i6BuHuX5b8az7Yo1OrPtmAge1WunOi45at90gpQXXA/h+ywccJRNjhtDGcvoWRkalM
         0t8GYkldhbtUdD8qInwfGg2TvXqpUAa202NBRcM/1pWS3TcgtOwUXQ/YXcL73q8uHwyZ
         WQ88gK2/RAaSyRGDAb/uKncOtos2rQsrinmHOu8QAoAUV1OX5Ot4heHifAaX1zRLChWf
         p+itmcyBFTIaP3TS2nXxeGozYEFk8Ycz22PxffOZOP78k/qVNtZ68Yss6STa5J3UfeAr
         eUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781574295; x=1782179095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73H1rmBZsR9HB0wLO22wKQ4YOh6GObKN7jR8HYwzlak=;
        b=NFlJnAUc0Lp5Zti/PNuSuGWfiQNfmmqCqpFlJRvkY2zXBW2pWy3c+xNNUxJxA5BkIn
         YvYw+jvHYwYiQDZPVAiqYMP9mWRbMZl7rCL4vRS7oxlkTMqIksOypA9KHI6kajHZQDjW
         zq5cl6vy9r6c4zfr9z/FK9CL/l6w2XvQXa0hLSRMPoiXN5b/RBBmv8uvnH8cG+PW/u+k
         txOXwJehrzvVp4aXfFokubgUAAHy1TnRrsWd8SUKyY7qJ4NAfqAHIykCxSdixMKi7Cg3
         MkSVp8rmd65kcS+KzWGDwx/RsF23FM+hgC1vl5j8w/7yEPnq1GiVzXYpgrBQobF11KBo
         yTlw==
X-Forwarded-Encrypted: i=1; AFNElJ8J1Ap5Z3Hi7soJltHu9bma2CPTD0ui4Z9w2iX8Xc3HQyFRIiLW65On1iu7PGAm1eyAzR8dv4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJhqM3o+iqMDnhDQ2ZP/Flgew/bqu49VD7l5RNR6rwTrvCCoY2
	GI9z0FwKeloiwmkryEyVVqCEw0FEG16jfn0fsmpVJLsRPaiBzuQ5DfWq/96TIsriUkfkThBWoZK
	cB2D7zYbiOE1HsHBWMfTpfK/EULvK/sE=
X-Gm-Gg: Acq92OGMf8NC9XHGOwcdC49FbetxFyGiue5820zHfK5I85f9jZx2v76S0GpbKHPwOJC
	gj09jAwLZu138PhyphIOavSMHxgFJF0kglB+guzb00w+oFjPnPMVDEd+qL7+1E2Z8mPWV5MLjfP
	p9RkDgdBSmcelA6qwsYI7OBgMvP2Md4GYTipyH/HBHkwTxN4+mS/Wja6yLcexuLdt0KQf5CZOma
	57Nx6OPg3p5PwWKqMQNoc28FcSi1VM1Jfs4ZuwNRAxCRWc0LkjV69w7QsPzrzhIlkJFB21IkjxR
	kAZTT6OvPPv8pbQjtQnGd153jeOBtQUB9xVSkhRJTzeNj/4+fac=
X-Received: by 2002:a05:690c:4902:b0:7a3:7ad3:3e9e with SMTP id
 00721157ae682-7f8c37d34b1mr121816437b3.32.1781574295274; Mon, 15 Jun 2026
 18:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
 <20260615073856.152479-3-sun.jian.kdev@gmail.com> <ajAIdJHvvIH9ZSrM@mail.gmail.com>
In-Reply-To: <ajAIdJHvvIH9ZSrM@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 16 Jun 2026 09:44:45 +0800
X-Gm-Features: AVVi8CfJxceWjHoo-gL6bJqNaLI_gcPFSgsxs1Oced6jE74a7o2xoyErdyfibJ4
Message-ID: <CABFUUZEkndSQyxckpNZ8tbP6_o7zL7fBNdrsWNia4JDiHD-NHw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover partial copy of non-linear
 skb test_run output
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:paul.chaignon@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299699-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CED268B51B

On Mon, Jun 15, 2026 at 10:13=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail=
.com> wrote:
>
> On Mon, Jun 15, 2026 at 03:38:56PM +0800, Sun Jian wrote:
> > Add a test case for BPF_PROG_TEST_RUN with a non-linear skb and a short
> > data_out buffer.
> >
> > The test verifies that test_run returns -ENOSPC, reports the full packe=
t
> > length through data_size_out, and copies the packet prefix into data_ou=
t.
> > The test uses a 100-byte data_out buffer with a 64-byte linear head, so=
 the
> > expected output spans both the skb head and the first fragment.
> >
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/skb_load_bytes.c | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c b/=
tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
> > index d7f83c0a40a5..134be0ea8ed7 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
> > @@ -3,6 +3,39 @@
> >  #include <network_helpers.h>
> >  #include "skb_load_bytes.skel.h"
> >
> > +#define NONLINEAR_PKT_LEN 9000
> > +#define NONLINEAR_HEAD_LEN 64
> > +#define SHORT_OUT_LEN 100
> > +
> > +static void test_nonlinear_data_out_partial(int prog_fd)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, tattr);
> > +     __u8 pkt[NONLINEAR_PKT_LEN];
> > +     __u8 out[SHORT_OUT_LEN];
> > +     struct __sk_buff skb =3D {};
> > +     int err, i;
> > +
> > +     for (i =3D 0; i < sizeof(pkt); i++)
> > +             pkt[i] =3D i & 0xff;
> > +
> > +     memset(out, 0xa5, sizeof(out));
> > +
> > +     skb.data_end =3D NONLINEAR_HEAD_LEN;
> > +
> > +     tattr.data_in =3D pkt;
> > +     tattr.data_size_in =3D sizeof(pkt);
> > +     tattr.data_out =3D out;
> > +     tattr.data_size_out =3D sizeof(out);
> > +     tattr.ctx_in =3D &skb;
> > +     tattr.ctx_size_in =3D sizeof(skb);
> > +
> > +     err =3D bpf_prog_test_run_opts(prog_fd, &tattr);
> > +
> > +     ASSERT_EQ(err, -ENOSPC, "nonlinear_partial_err");
> > +     ASSERT_EQ(tattr.data_size_out, sizeof(pkt), "nonlinear_partial_da=
ta_size_out");
> > +     ASSERT_OK(memcmp(out, pkt, sizeof(out)), "nonlinear_partial_data_=
out");
> > +}
> > +
> >  void test_skb_load_bytes(void)
> >  {
> >       struct skb_load_bytes *skel;
> > @@ -40,6 +73,8 @@ void test_skb_load_bytes(void)
> >       if (!ASSERT_EQ(test_result, 0, "offset 10"))
> >               goto out;
> >
> > +     test_nonlinear_data_out_partial(prog_fd);
> > +
>
> Maybe prog_tests/prog_run_opts.c would be a better place to cover this?
> test_skb_load_bytes() is meant to cover the bpf_skb_load_bytes helper.
>
> >  out:
> >       skb_load_bytes__destroy(skel);
> >  }
> > --
> > 2.43.0
> >

Hi Paul,

Thanks, agreed. The test is really about BPF_PROG_TEST_RUN copy-out
semantics, not the bpf_skb_load_bytes() helper.

I'll move it to prog_run_opts.c in v2.

Thanks,
Sun Jian


Return-Path: <netdev+bounces-297070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uEMdHEshKGrA+QIAu9opvQ
	(envelope-from <netdev+bounces-297070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:20:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D51BD660F06
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:20:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=e95Aen3O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297070-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297070-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6227D30548AF
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206FC3264DE;
	Tue,  9 Jun 2026 14:14:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39132A3DA
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:14:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014477; cv=pass; b=dvPdx5Vx+2hwWWF3rzLzJBBTc3mpB3i2bdu5OJc9DHwJtQy0x/AOx3dZ7g9B9AEiodD8LBOINVaQh0ceJt0MAHbGJJPiJ2Bq9Pes1NResJ5dW0jgbgBKo0H3s8BGOHM8WdXavFNG6neVAtK3Up+JY2Miqke1E94lpzgheQbU9nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014477; c=relaxed/simple;
	bh=WDuQ5aMcXXGMGWSgimjtG7u3272kvY4m8NMdW0ESSMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWmOjY/A6ynQyj2mSC6KdippKjFJ24dM7t07lJVdhp4PEQfb+Zr26iN7hwzEZqF5aWS+joLkrdXjFrSeC6GDtJTUnWOt+uI69FI+X3ulbdcXvKqG7pcXdhXx9TmG/VysMFz24S91mLWqrxhvuGC8yFq/k/xKkOD15/FgwGC9ndA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=e95Aen3O; arc=pass smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7e1916922b9so61750227b3.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781014474; cv=none;
        d=google.com; s=arc-20240605;
        b=kmucaXeZ4rD8sHUsuUJ3CuBG5C6hTrwFHI7KrvapCvRXgHhpIo3faXdiBcjv/B0q4D
         9BxxgJqcLSf+QgvMRjCi0o/T5ucrSW4y5Hgr7EIsccVnRoHoIkHE7DFNRu0Tc5dU+v5z
         npLT8G4QRzOGu2sixs0I7q0KvGL2EMY3/YtMF1nGjxnJxLzibToL5o3bVjIoILArff29
         PjvSegVBVAQFkjKD24A2oaSYT3fU9+HOzCs5ht+lDROjmqFV/gt6q8Z437Am31p4sEA3
         qL6N52r7hVmu5U8wfXbsXeNgVq+8UMbSQQNGkRdl23eraeAndcuqlfZqAeNtG1txvLbG
         OdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LOl8Qoe1dz/fZX2fWuUlrIc82O13Oquj25wgqoFE3Kk=;
        fh=bvaUPO7vaQn4wnxrs/Qsp2GXur6IiSbD+nQk7t0eZSY=;
        b=hXpLu18r3gV2x/fzs8EMoKSVjZ0FjUZNbelKV74FnhCHvCVLYR4NeLGh5NKcA4QEkn
         VspNFqsZ0PUXdeRt0pomNeAekDzI0RZ5lt4RzSplUH1lXflG6YblyJqrCuTDRScEnn4S
         trzQp6gQCGN25v+mHmOgQgmCg9lLMMYrN/aVFv8aLyXwIMtxXab4MifDBV8Y7sO72AUy
         3mpqmt53Cu+5qyhEtLc5wCjU9RytU+7+96HErAACPgvznpywbTpSI2osdYLSgF2M4iMC
         yUj7IZcCTxtvFacE0MLcy7kGNU19jwDY1dslq/YjteZ16qsEhe9gXQkAkFb8MuOiXkW3
         tc5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781014474; x=1781619274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOl8Qoe1dz/fZX2fWuUlrIc82O13Oquj25wgqoFE3Kk=;
        b=e95Aen3O5dHbSQTKL9NqiyKZgl2ItLu8ohfqTaitGE+AXJt06zbBYhfvneCmXbvenv
         I2/bSLwLuaOp4rZRY4RDyk1HKXStpr2eXmZF/UDr83kIDFaQTHUNNKWMZ+7AwNj9Qph0
         0igV/rNHo86KuMeiXzSHrzA91DNi8JMSfrjII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781014474; x=1781619274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LOl8Qoe1dz/fZX2fWuUlrIc82O13Oquj25wgqoFE3Kk=;
        b=owngEUsiq+U+UVqVLsGXVzpvsyJsFjsAaii9q703E0sD4o4GB0h0tMebdRM6K0zLUt
         0MSZEj1T6iO7w1cK3IG/YsdNt9lGW7NDEmF+/TcvTRFW0C61wuE2sioCnx1In4zQ+/Bw
         OIqV5Rnx2ayBqoPDxdTC9IiyHrmPeYEyoreP445h8MxriqoMtZcp5p2szCY7t5Jd4Mfv
         lEh9ZeVdosaxuqLysFX26MImfyWS681JCFeIfd+ftCsFZ0jPIa+dGebnYb/OpYj3ZmJ7
         Te7HZEHjg7ojgVa11/mLhew6NFK9Rvbqi8VX3G4bIazHmZnGKxfXdsO54Z8Bf6YtRuz7
         kG+A==
X-Forwarded-Encrypted: i=1; AFNElJ+yX5ubIpvpmfeF8USTOW1S8BqMznud5s2JUVUqtAyknEMCKMxio7N9Q51vGwc3O52/pZ90XTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5WaZGGhfYMGGlmJGvamGsftr49r/UQIKhxwb5I6jVSdywYGZ
	UuzuyXH9KpPQVTuRgkaKeVD0olGRZla5qhFEHjzXFFxpfg6U0sTXFKOmpZ0ZFB28S+vaw1RHXT4
	nAmYPcuiUZjPoTBebUGXovESTv65nE4HZBaELdJMJ
X-Gm-Gg: Acq92OE03dfcU7qEXte+7Bymajst8dKxSfpDmaoTaQ9YUhi2ZLlvvHdbZr7NvGvDCoI
	PHjlWditvw+6cFWkJzrUtZpVYJcRVg+cHAIpEX59B1qJNAgF1ArBIcEv85i08oLmv6guWryritd
	lASl2+MB+q2gkS1KJvN31itslf8vFYEayZdXoZcX2iDrrC+8e004MJADQZ1QD4EkS9ubgt7EBff
	MJglamwAYXKA5wuuNyrogCga7I2+CYajOSmKDY9zBw+BUq41XlxbguOINQ4ee6vgue2QrAq47lu
	i9YnYCdFAwymVwLzrDfTweSMZbXakp7BRyRm6O28nG78dwtiOfSPOZi3Efs=
X-Received: by 2002:a05:690c:350a:b0:7b2:bf20:cdc3 with SMTP id
 00721157ae682-7ed0935434emr198858037b3.0.1781014474327; Tue, 09 Jun 2026
 07:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605194640.2645386-1-sam.moelius@trailofbits.com>
 <CAM0EoMmeftLxWNdQqWsJonxEtMoCCuJdeTEjNzQfc2GYUX+mtw@mail.gmail.com>
 <CAE+C+DZTme=GQBy9BaXCiPe0pO7Pv7XNM69iru0VTGFX_ybBKg@mail.gmail.com>
 <CAM0EoMmPb0jZGWeadX4KqsyQTx4Oo2gLg-3h+u=Ec=9rqzzjdQ@mail.gmail.com>
 <CA+NMeC_3bzJzn_NjztcnM=C1M0Xrf7Xo26DiQNRy_o_iZPAnMg@mail.gmail.com> <CAE+C+Dact=a0_rAm61A=m9b=LJoV9Nkny5ozOxL_UAiK_pdy2Q@mail.gmail.com>
In-Reply-To: <CAE+C+Dact=a0_rAm61A=m9b=LJoV9Nkny5ozOxL_UAiK_pdy2Q@mail.gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Tue, 9 Jun 2026 11:14:23 -0300
X-Gm-Features: AVVi8CfRUgo2g50UBvWG401fxh8GRky118G54qn7McPaksyOTW60evJJ1RTollU
Message-ID: <CA+NMeC_ZXhUEwrKirP3TiamZB9CoTTPfomOPoxv3AaVNJR5BxQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_pedit: require matching IPv4 L4 protocol
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297070-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime,trailofbits.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D51BD660F06

On Tue, Jun 9, 2026 at 10:57=E2=80=AFAM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> On Mon, Jun 8, 2026 at 10:41=E2=80=AFAM Victor Nogueira <victor@mojatatu.=
com> wrote:
> >
> > On Mon, Jun 8, 2026 at 7:46=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> > >
> > > On Sun, Jun 7, 2026 at 10:33=E2=80=AFAM Samuel Moelius
> > > <sam.moelius@trailofbits.com> wrote:
> > > >
> > > > On Sat, Jun 6, 2026 at 5:29=E2=80=AFPM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > > > >
> > > > > On Fri, Jun 5, 2026 at 3:46=E2=80=AFPM Samuel Moelius
> > > > > <sam.moelius@trailofbits.com> wrote:
> > > > > >
> > > > > > The extended IPv4 L4 header mode in act_pedit can select TCP or=
 UDP
> > > > > > header fields without confirming that the IPv4 protocol field m=
atches
> > > > > > the selected transport header.
> > > > > >
> > > > > > That lets a rule written for TCP or UDP modify unrelated payloa=
d bytes
> > > > > > in a packet carrying a different protocol.
> > > > > >
> > > > > > Verify the IPv4 protocol before applying TCP or UDP extended he=
ader
> > > > > > edits.
> > > > > >
> > > > > > Assisted-by: Codex:gpt-5.5-cyber-preview
> > > > > > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > > > > > ---
> > > > > >  net/sched/act_pedit.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > > > > index bc20f08a2789..9a4590451f7e 100644
> > > > > > --- a/net/sched/act_pedit.c
> > > > > > +++ b/net/sched/act_pedit.c
> > > > > > @@ -341,6 +341,8 @@ static int pedit_l4_skb_offset(struct sk_bu=
ff *skb, int *hoffset, const int head
> > > > > >
> > > > > >                 if (!iph)
> > > > > >                         goto out;
> > > > > > +               if (iph->ihl < 5 || iph->protocol !=3D header_t=
ype)
> > > > > > +                       goto out;
> > > > >
> > > > > From inspection the fix looks reasonable.
> > > > > At first glance it seems that the only fix that resolves the issu=
e you
> > > > > are describing is to check the protocol header.
> > > > > header length seems to be an extra thing. But let's do what the v=
6
> > > > > side seems to and skip frags as well? Something maybe along the l=
ines
> > > > > of:
> > > > >
> > > > > if (iph->ihl < 5 || iph->protocol !=3D header_type || (iph->frag_=
off &
> > > > > htons(IP_OFFSET)))
> > > > >         goto out;
> > > >
> > > > I will submit an updated patch.
> > > >
> > > > > Are you able to describe how someone would configure a tc rule th=
at
> > > > > will allow this to happen?
> > > > > IOW, how did you verify the problem and then validate that your f=
ix works?
> > > >
> > > > The bug was validated using a custom init script in QEMU. The speci=
fic
> > > > line used was:
> > > >
> > > > /usr/sbin/tc filter add dev veth0 egress protocol ip pref 1 matchal=
l
> > > > action pedit ex munge udp dport set 18053
> > > >
> > > > An IPv4 TCP packet with destination port 2222 was sent through that
> > > > path. With the unpatched kernel, the packet was received with TCP
> > > > destination port 18053. With the patched kernel, the same packet wa=
s
> > > > received unchanged.
> > > >
> > > > I can provide more details or artifacts if you would like.
> > >
> > > A tdc test case is better. Victor or I can create one for you if you
> > > dont know how.
> >
> > It seems like v2 isn't applying so you'll have to send a new version.
> > When you do, after waiting for the 24h period, can you resend with
> > the attached patch (containing the tdc test)? Since this is a
> > fix, in the new version, remember to target net and add a proper fixes
> > tag.
>
> I'm sorry, I'm not quite following.
>
> I should send a multipart patch with the patch you shared as one of the p=
arts?

Yes, please send a patchset with patch 1 being your fix and patch 2 the tdc
test.

cheers,
Victor


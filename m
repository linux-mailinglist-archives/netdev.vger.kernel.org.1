Return-Path: <netdev+bounces-296483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0GjfCNmeJmrZZwIAu9opvQ
	(envelope-from <netdev+bounces-296483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:52:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C74655558
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:52:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=OIpo5gFL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296483-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296483-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5225630008AB
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490823BD17;
	Mon,  8 Jun 2026 10:47:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737504071CE
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 10:46:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915620; cv=pass; b=GGqEPKirXi3fGFusEHyKugqEjVAIWs/+IZ+PnsVOTP9oUYE551zkLDPSeSJoc8Rjdi2utmy4cBstzEI97JMoNgtETDro6FhPmBwTRf4bA5pLzGXZpylJp0lhJTq1mW6CcTuxvkSDoa9AfzVJe3U7Xitnd9OcoslSPR2B/+loj5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915620; c=relaxed/simple;
	bh=w3D+Pg3BAXCJwfO88zczxxmfP+wZznyTuK7USknRcDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAvdQjxsFmqiHjuUqYkCVETEhpiFvtn3OdxQya9u06Hqr6rgDKU+AAu/03fWGravu++4ok5E0b352cebHlhPhLYSC/GRyWaz2R1VS4aquL0414rHUyRsugRmkUKis8Pg/6rj0tQDsKMjWnrzo8x0u6Ss10UWy5LILuks55Kpd3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=OIpo5gFL; arc=pass smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84234c83142so1621744b3a.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 03:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780915619; cv=none;
        d=google.com; s=arc-20240605;
        b=Dd6pJFjdQE+3zdw3C7fZp/YspacBiSwC4KacVtVgDKZMfRvIFIRIliwrClJCFQ56bZ
         6pVmw0D/pzt0z8HUdMZzENukbfcva0q3hmEHHrfPDyLfTOZw1RvH0fYe0Up9RgTEfRiG
         cFwBQbxFpGVBK1YVJr6tVulKre9dO316AoEo0E+8ki0wDWg9hNWTtG5MnUYw8C0GJVZZ
         QFOBGDXEF5bVLqSIUdiN0hTjwQ/NfbR1TbhnVLiuR4ZjvCHoscT6c881yAhk0pa0k8+r
         WRUw3Uhn4/LYfurzcGsl15znKJcG+vnaKHzuLVVctlsWHKZlx1JR/SrA2L6nRy1okvry
         VLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hX75lj9UvWmArTL5O2CWCemxnLVEp3KiNKdt8nBqMA0=;
        fh=g/U7ANc66XGS+qLMLSgwAfIZePycogdd1n1uy53TMs4=;
        b=L0njIO58wnpMJiRrM4iuE2EWW/t9QNtBiys/C5QGZjWtCAykqb3XsFQzyMyc2217ZH
         P/4CTji37LvR2iI057/8iTV4uxPvZHHm0sRIWxH8Nw6n33bO1n/MZ0owV7hzp0zPVPq1
         vKYvohOX/fQf5TSUgWSlMKI9qfESG4lMMRmI716eV/PDqET+EVoKsmUaEKkwSLB/hVoY
         A7mBzODWP8+56NLYPzX4nIna02n72c4KUnKgUjaHKdXvaOSUCuY05ud4w4tGWem73iFd
         VtlS6LKmHV7rowjXQF4Og5ls8Mg5GDAxcyQciHGobX9eTBhzndkpJw0oTinQKD1SMTZr
         vF7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780915619; x=1781520419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hX75lj9UvWmArTL5O2CWCemxnLVEp3KiNKdt8nBqMA0=;
        b=OIpo5gFLyQwR7iaxhsEFQZWRR4yljQMR2aBnhCboK72VRWQInxPoze+85oopiR9LUN
         rwBmdfz39mTliHyjMvdM8D99IAl9NIe2se2GrVJTK1+r3dWBjN2Rd1ItqtE+c70wI5e1
         8W1wR30oQTnzQpTycekm9HshIxikykaekJdnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915619; x=1781520419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hX75lj9UvWmArTL5O2CWCemxnLVEp3KiNKdt8nBqMA0=;
        b=ZALw0v2VQqitXoTBzVHyRF9cVkZ4X2RhGiD9KHkqmeanbkKPtW1GTzSszgi8HfDMDy
         oqMLDHapNdTpHZ/wegYgdcGbWbkUlIBsb5GrPbIITPx7jnJzealkLwqERiJeo4sRwIze
         JU3c8s8Pi7TGLiZ88nMLJc3HpPT1NNy5h8Gg98nTWdSTODtNZhD4+/htBF2uwnSLZsdk
         DNRsro5m86kfQG7iOATvRAqIE25Xq9+UBtFTNczo7iM1JLSoa9tmEYydrRoJ4SPzKItm
         rcRpWSPne+OuNNOaoliFwgXwwLzMk6AJz46VCZnVkyDfHKR6Wa3rLAd8cCQG/U7X/AF+
         kwJA==
X-Forwarded-Encrypted: i=1; AFNElJ8pXm9XnYytxsr47rltYUangZ0wlTl0i85MkCSIpxeaBg/YCJ9RQg3vFY/C0MTatxD5t40eLFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVozdHDYjTZ7IqcK66sdw2PyS6G0YOS+j7pERgezX2C22U4QMN
	YetjG2QdkwxZLhxEbboeDOi8EFqBHVeQsloMxnF05j2DnL9OpxI+kZccjUQpeNJa6XuSVGSfokb
	Jws33b3knz/kmt59udqg7yjteaEzp2aLXj6LxTK9A
X-Gm-Gg: Acq92OGFTkOgp9MODZ+o86rSPGE/9fyxznEhecHS29tw5gbsANUJdUfBnNe6FNyMvdt
	9rn28J9I6mWg3bO5z5So+Z1D7nQOu9v9Esoq6glqZW3pZ80wr2zQBeZogGZryoZSdiTdzi8yMyB
	F0rMZodYeMPbZoHRZ2OT/HVHtHGW+/p+/2599V4Vtb7m2m5X00PumsxyIOqr54LrNWOduUhvjLS
	cAB03Cu4T5ALNMqPb5ikfnOX9JpHAqMWaLT/J765NAnC1AG2Sf/vkzYtptMPbamgyB1PoTknVtx
	FZKAfmygBHFw7d48+n4=
X-Received: by 2002:a05:6a00:23ca:b0:842:5b63:6119 with SMTP id
 d2e1a72fcca58-842b0e2f430mr14794701b3a.1.1780915618808; Mon, 08 Jun 2026
 03:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605194640.2645386-1-sam.moelius@trailofbits.com>
 <CAM0EoMmeftLxWNdQqWsJonxEtMoCCuJdeTEjNzQfc2GYUX+mtw@mail.gmail.com> <CAE+C+DZTme=GQBy9BaXCiPe0pO7Pv7XNM69iru0VTGFX_ybBKg@mail.gmail.com>
In-Reply-To: <CAE+C+DZTme=GQBy9BaXCiPe0pO7Pv7XNM69iru0VTGFX_ybBKg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 8 Jun 2026 06:46:46 -0400
X-Gm-Features: AVVi8CeQlcB6w6tpNcR8QKmfjpjjni7kCUy9HMzVK5ay3z0dtfgs45EdiEocANQ
Message-ID: <CAM0EoMmPb0jZGWeadX4KqsyQTx4Oo2gLg-3h+u=Ec=9rqzzjdQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_pedit: require matching IPv4 L4 protocol
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:victor@mojatatu.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296483-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87C74655558

On Sun, Jun 7, 2026 at 10:33=E2=80=AFAM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> On Sat, Jun 6, 2026 at 5:29=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> > On Fri, Jun 5, 2026 at 3:46=E2=80=AFPM Samuel Moelius
> > <sam.moelius@trailofbits.com> wrote:
> > >
> > > The extended IPv4 L4 header mode in act_pedit can select TCP or UDP
> > > header fields without confirming that the IPv4 protocol field matches
> > > the selected transport header.
> > >
> > > That lets a rule written for TCP or UDP modify unrelated payload byte=
s
> > > in a packet carrying a different protocol.
> > >
> > > Verify the IPv4 protocol before applying TCP or UDP extended header
> > > edits.
> > >
> > > Assisted-by: Codex:gpt-5.5-cyber-preview
> > > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > > ---
> > >  net/sched/act_pedit.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > index bc20f08a2789..9a4590451f7e 100644
> > > --- a/net/sched/act_pedit.c
> > > +++ b/net/sched/act_pedit.c
> > > @@ -341,6 +341,8 @@ static int pedit_l4_skb_offset(struct sk_buff *sk=
b, int *hoffset, const int head
> > >
> > >                 if (!iph)
> > >                         goto out;
> > > +               if (iph->ihl < 5 || iph->protocol !=3D header_type)
> > > +                       goto out;
> >
> > From inspection the fix looks reasonable.
> > At first glance it seems that the only fix that resolves the issue you
> > are describing is to check the protocol header.
> > header length seems to be an extra thing. But let's do what the v6
> > side seems to and skip frags as well? Something maybe along the lines
> > of:
> >
> > if (iph->ihl < 5 || iph->protocol !=3D header_type || (iph->frag_off &
> > htons(IP_OFFSET)))
> >         goto out;
>
> I will submit an updated patch.
>
> > Are you able to describe how someone would configure a tc rule that
> > will allow this to happen?
> > IOW, how did you verify the problem and then validate that your fix wor=
ks?
>
> The bug was validated using a custom init script in QEMU. The specific
> line used was:
>
> /usr/sbin/tc filter add dev veth0 egress protocol ip pref 1 matchall
> action pedit ex munge udp dport set 18053
>
> An IPv4 TCP packet with destination port 2222 was sent through that
> path. With the unpatched kernel, the packet was received with TCP
> destination port 18053. With the patched kernel, the same packet was
> received unchanged.
>
> I can provide more details or artifacts if you would like.

A tdc test case is better. Victor or I can create one for you if you
dont know how.

cheers,
jamal


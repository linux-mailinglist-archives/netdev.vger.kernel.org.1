Return-Path: <netdev+bounces-297059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FwthGWUdKGrs+AIAu9opvQ
	(envelope-from <netdev+bounces-297059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:04:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9EA660D4B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:04:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=bjQYIjAJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297059-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297059-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03CCF3059DF4
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2073742B756;
	Tue,  9 Jun 2026 13:57:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C2E42B749
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 13:57:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013469; cv=pass; b=EkPMClD9pi7rBTX5EwTNP4jbYlYhuukTeae8EE42sV0+3tuXJTEv38De70Yzn6NR7v2kAxhIG4l6tVzfZ383D4Qb+z0DqmnIhkk8JNba7GvsRVrpj0dFuRSmVzXORddE21eveoiJ0MgKz9DiBC61C0p163c3JncKbxI4Xw57Pco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013469; c=relaxed/simple;
	bh=9H3n6jJ/Cewkf38K0o8Ik7o52T0PvcAbhtGUzZr9BTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzxljU2es6tUrf18ISaGbXTJZQvd1XhTihiyfb6vaBKMTx2TCC+0YL4TuZ9HkipTwEwGnTON9zJw7SdJNyNrvgNFuBmtScGjG1E3b9xTJj7O6wndFzybRcH+xu1IDMtAtKOto3UKqw9kWopG0cGvA6FbT54GQfjXCrZEEQ1LLsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=bjQYIjAJ; arc=pass smtp.client-ip=209.85.167.46
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so4865508e87.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 06:57:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781013466; cv=none;
        d=google.com; s=arc-20240605;
        b=BZZsnvkPMEGGDIBKuKrJtHM/xIrMx61ns+HoMBbRCn7M0oTuV6aHuZEG2QvN3NvMkL
         mRh4o3gLW+qm7lvT37UVRaEJtLxQc7oF8bkfqht8zP6XwfFKpf5PBwaqYgn9g3siqhon
         anh3lnGJ38aeiFWixEP753ArPIZ3Ysd54YFfUvR5vyrvRruCbeyhdF8M33ghy1WDAzVV
         yCfJCOjt+eZd6qz8pr8HL2V0x3pBJP7npz506odnNUf0JUgZbsTyhtX7YgNuVg39qR5F
         Ar7sOI9Mrd594ONknQmswEcIdPc67bzaYdap2Ti9O1xGa0VRwekcu3Oyph6IAqtuZVLn
         5DVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tCb/PmfMqibccVPEB0SpuoNk3B936z3C+Or74Gj7qVo=;
        fh=hQE/+H+kfNrHOjikPEdrnBdwH0Glu3CcKnVM5lR/Uz8=;
        b=VaeHJP0F6pzWJNYGuIjS4YNcdYnXIM1cnRX5WRMBgxmftmKY9EdDmUkcEd8qSYhQh4
         cxxU4MeuDCgw/wbFPmfD55dcTWqkPyS6Oplr+oQx6QQEK+pR6qaXulUGhlVOsk8uwfZc
         acAB5IGmZ3uBv4vVgjBiF2RnG0+qVSFKiKe/CPAVMPZu9cuCNz88RKbpW2uagF7QufX2
         1rr7vsQ8troKS7rdxgqEdfrr/mElKgS2eNi42Sa4Rdrct5M1wZ01upJRymm4BcQkGQf5
         mWE/a7a7yXyLlpJs80RyJMYBPsD2PCzgvdZovHEu5tFu8gCr9YAbYcltHbS4ETCCW549
         YzGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781013466; x=1781618266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCb/PmfMqibccVPEB0SpuoNk3B936z3C+Or74Gj7qVo=;
        b=bjQYIjAJqahJexFWhGtyCOeBHjEghT3B6Ba8fNKx5nCHFu3T6MkxpzYGhRxThJqAVa
         oABo8tVHwM961v/gNiKzAHeQdvNk04fU7z+FZ82M3ksoP27AFJfg2h2p6bIf/jyRY50r
         RIQOuXP19qhNMNQUZNLLfhe6+WfSdNDsN4fWiI40zKzgAN0IUKdAifCXvFXvXlUqrA7A
         wxpRIxMMJsFP+UuuS2A8bcM9UsvUMFuU7USqFXgFnmBsP13LCxFiabTiHhh3UgxV5i3d
         O9hqwoSORy/ktONkcCmI6N5Leu0J27pAuvqnf+mry1bkxyY6t7oUQUEc1Sj4I8+rwpm7
         uFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013466; x=1781618266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tCb/PmfMqibccVPEB0SpuoNk3B936z3C+Or74Gj7qVo=;
        b=pB1W2aKwbFLkBslLWoiWUFhVYMjZLvJP6ADwLrc6B/7pgxfEYGCi/e8/Ivn4gWHoZd
         QEHXpa/PPztJPMVthm9jsOJ8NgoICM/KBkgicA3Khvd1GmMdebqPhAJYJUF4aZMJNK5C
         KGuFbQkD4gTm68upTJ+UBQfZMNQmcMcirKr5B8xutZDCps789jmYRPXOXEdrZSZsaUmy
         akwYubJwICmhbIdejVwv26kpBcBh7F1E3tiaRF6Io0i+puhVFcfT3/nfacfBRDjNmX+a
         G7Z1tLEcvhvlcYfUH/8LZCsI8DjcTkz/CxnQB5P7p1X8EDFd6XTpW8n6OWCEwnR2LzO5
         90bA==
X-Forwarded-Encrypted: i=1; AFNElJ9X4wz/OKh1NnXiD0P15u4h0B75rj2kJBvJgBg00FcL25NAVKEUde5kpSqcTZ35PQWWJul9z7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SJa9KN+k0IxNzEJqbLpkKuMY7a91pnXzKqWhekUpvSAq5AkM
	UlwmvDl1ogmrld7k68SKK9xWC3YnQL7p8EapSiCFtPrCk6QJd1WrPFnoiUSJht1y6gqycOEeQdU
	X0jLLv+r8BQTbrHTRIK44PuYSMXjd2ErephN8nNC2MQ==
X-Gm-Gg: Acq92OGS8TgcQicmLqR8w6TGvkH1XrkQ4+E73XkThWoxIzvv1AlqKLeZmVmtQRvgf1Y
	jHO84U6VAuLoLf3JYLNmbuf6f0/9AfQ2So8aOFGzQh64/owew7l9UeD5ZEMrKOkL2/I5dGaJrfu
	KKt2fTXzsxfPK0JUU3ZJb7pW32vaR1C1rdwz9anUE0cOQ7/nUl2/jgZrs6/NcTJIvBJbn2pTXzo
	+3ysAh5UlVTqu4zWPRHyHfd0T6PgOOFCroH4GTsvCXh/ZvJzluJxvq74j/sr6NPnHKvLt1knNIG
	H1bfJgVZmv5P5+dD
X-Received: by 2002:a05:6512:3402:b0:5aa:500f:7bae with SMTP id
 2adb3069b0e04-5aa87b8f846mr5956959e87.35.1781013466282; Tue, 09 Jun 2026
 06:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605194640.2645386-1-sam.moelius@trailofbits.com>
 <CAM0EoMmeftLxWNdQqWsJonxEtMoCCuJdeTEjNzQfc2GYUX+mtw@mail.gmail.com>
 <CAE+C+DZTme=GQBy9BaXCiPe0pO7Pv7XNM69iru0VTGFX_ybBKg@mail.gmail.com>
 <CAM0EoMmPb0jZGWeadX4KqsyQTx4Oo2gLg-3h+u=Ec=9rqzzjdQ@mail.gmail.com> <CA+NMeC_3bzJzn_NjztcnM=C1M0Xrf7Xo26DiQNRy_o_iZPAnMg@mail.gmail.com>
In-Reply-To: <CA+NMeC_3bzJzn_NjztcnM=C1M0Xrf7Xo26DiQNRy_o_iZPAnMg@mail.gmail.com>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Tue, 9 Jun 2026 09:57:33 -0400
X-Gm-Features: AVVi8CcL42h7bbbdJNPC5seDh0BhA8B5YpsxGVBAJuC6UUt7sxXmbW93zGi3TDs
Message-ID: <CAE+C+Dact=a0_rAm61A=m9b=LJoV9Nkny5ozOxL_UAiK_pdy2Q@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_pedit: require matching IPv4 L4 protocol
To: Victor Nogueira <victor@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-297059-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:victor@mojatatu.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mojatatu.com:email,mail.gmail.com:mid,trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F9EA660D4B

On Mon, Jun 8, 2026 at 10:41=E2=80=AFAM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> On Mon, Jun 8, 2026 at 7:46=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> > On Sun, Jun 7, 2026 at 10:33=E2=80=AFAM Samuel Moelius
> > <sam.moelius@trailofbits.com> wrote:
> > >
> > > On Sat, Jun 6, 2026 at 5:29=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > > >
> > > > On Fri, Jun 5, 2026 at 3:46=E2=80=AFPM Samuel Moelius
> > > > <sam.moelius@trailofbits.com> wrote:
> > > > >
> > > > > The extended IPv4 L4 header mode in act_pedit can select TCP or U=
DP
> > > > > header fields without confirming that the IPv4 protocol field mat=
ches
> > > > > the selected transport header.
> > > > >
> > > > > That lets a rule written for TCP or UDP modify unrelated payload =
bytes
> > > > > in a packet carrying a different protocol.
> > > > >
> > > > > Verify the IPv4 protocol before applying TCP or UDP extended head=
er
> > > > > edits.
> > > > >
> > > > > Assisted-by: Codex:gpt-5.5-cyber-preview
> > > > > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > > > > ---
> > > > >  net/sched/act_pedit.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > > > index bc20f08a2789..9a4590451f7e 100644
> > > > > --- a/net/sched/act_pedit.c
> > > > > +++ b/net/sched/act_pedit.c
> > > > > @@ -341,6 +341,8 @@ static int pedit_l4_skb_offset(struct sk_buff=
 *skb, int *hoffset, const int head
> > > > >
> > > > >                 if (!iph)
> > > > >                         goto out;
> > > > > +               if (iph->ihl < 5 || iph->protocol !=3D header_typ=
e)
> > > > > +                       goto out;
> > > >
> > > > From inspection the fix looks reasonable.
> > > > At first glance it seems that the only fix that resolves the issue =
you
> > > > are describing is to check the protocol header.
> > > > header length seems to be an extra thing. But let's do what the v6
> > > > side seems to and skip frags as well? Something maybe along the lin=
es
> > > > of:
> > > >
> > > > if (iph->ihl < 5 || iph->protocol !=3D header_type || (iph->frag_of=
f &
> > > > htons(IP_OFFSET)))
> > > >         goto out;
> > >
> > > I will submit an updated patch.
> > >
> > > > Are you able to describe how someone would configure a tc rule that
> > > > will allow this to happen?
> > > > IOW, how did you verify the problem and then validate that your fix=
 works?
> > >
> > > The bug was validated using a custom init script in QEMU. The specifi=
c
> > > line used was:
> > >
> > > /usr/sbin/tc filter add dev veth0 egress protocol ip pref 1 matchall
> > > action pedit ex munge udp dport set 18053
> > >
> > > An IPv4 TCP packet with destination port 2222 was sent through that
> > > path. With the unpatched kernel, the packet was received with TCP
> > > destination port 18053. With the patched kernel, the same packet was
> > > received unchanged.
> > >
> > > I can provide more details or artifacts if you would like.
> >
> > A tdc test case is better. Victor or I can create one for you if you
> > dont know how.
>
> It seems like v2 isn't applying so you'll have to send a new version.
> When you do, after waiting for the 24h period, can you resend with
> the attached patch (containing the tdc test)? Since this is a
> fix, in the new version, remember to target net and add a proper fixes
> tag.

I'm sorry, I'm not quite following.

I should send a multipart patch with the patch you shared as one of the par=
ts?


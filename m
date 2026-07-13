Return-Path: <netdev+bounces-306995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cMZeDyNEVGoSkAMAu9opvQ
	(envelope-from <netdev+bounces-306995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 03:49:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DC27467F5
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 03:49:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jdpEnRVI;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306995-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306995-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4BD93008D12
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 01:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627B7287510;
	Mon, 13 Jul 2026 01:49:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7406A7080D
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 01:49:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783907344; cv=pass; b=sRrSqgkcxyBxxIDj1DEVmd/0GQ9vMVba5I2mjQTnq9YqHXIqYTTEatotN/9IDosyqRRjo19dSjAm8LK89ipmkYEht9MmnWgm72SC5qH/D2q0SavGKqM+vOV8qwmx8VpGwEYBcxaQNjXB4aAuMpsEU1pmqwx5DNlHw4fCSlIxuRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783907344; c=relaxed/simple;
	bh=FApoLwEr6u0DIU2Sv0d6X13xdDZbQL/G/f8+KqxZwMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9ed5gJgPHr0EUBOVc15zXmKdhFyw4K1H6JTFQEI+B3Xqd7eyFZbOlYcBNqt+Sk3vIleaTKMAcHPu2ho7HQgjwAq/O3H2pyCka16k67lNoVHUpzkh+6Isd9UxDWml8KSPitMxAKoer+Nfy0dXKGafmRw3BhqtDuIe5F755MNTNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdpEnRVI; arc=pass smtp.client-ip=209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15b509c323so355903166b.0
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 18:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783907341; cv=none;
        d=google.com; s=arc-20260327;
        b=De8gAO4QmpRrgaXz6060l26b4IkdfAy2DWrcM63sBNQVH0ZwjQYabDKSVx3eRkLR0S
         GEy0C/17aqbJngmVrSRptbb6MChuF9WR52DlDnU6G5xNNYokK1Ii5nTASbuoSxUW5Qfi
         b3SDls58Oq+9TCxM2BthdHKSI8MUjs/rahauO59yXmDHweOQ2LV47wYLkcZCKlw5k8vg
         glGiCB9s0WGAJ7y9Cmc0URb4nxcL6rTDnzc6yG5x2kWDAIToX85xGHtV0EgwBLyvtexP
         D7XlWBQnNS7CI7V74exQBLZJbHSAMMq6iVBkuq7K+NaoMXik8Y4rIeShPxJgyymhnCw4
         2Zcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ei6Ovvv1T88AmXcWJaHTpwUZz1npTk79c3/Dn7yootY=;
        fh=JPdIJF/p0F8/GlCVs9TGvI48Tu7gAx+S9aZG+8UgduM=;
        b=S9X0mikpoEBn9JuRafZMbATYB8TXdIp9h9b0uPftMqbEKQwOa/TyJSBdARbdXnALl2
         Tqzq2VgTkQBQrcdpSwh9TXWijFt/JxAKe+0V7kBTx978RUe/eX8YeCpEIwOMyOa8S784
         WdfrdkwZmG440Fu57PXJjNbTXjR5cHaiLIimrsy3EXCD+7TuCY+2ICQmeBsb2R7ekOcL
         zD6fm9EyWxkRZkP8XobtzmuS6+WLlki9WpWnnPRgGyenW4obXWn8XbUKTsTi6ZvqYuC9
         O0JvDzvtMHZ2pBy7/nO9uqHxaip9UUmyHzGgO3hgBH8o+yJQ5b/wR0RdlFwKMllEX04X
         3HZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783907341; x=1784512141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ei6Ovvv1T88AmXcWJaHTpwUZz1npTk79c3/Dn7yootY=;
        b=jdpEnRVIdloxkhajQ6toXgV/iw2E4VCy2sxdCZxrjZiCCK4wIk/aJmEuAM4JvJLda5
         PK7UPMagdA5GE0ROr2J74tF7V+9hQLmaZ6FqabE+u+n96xzn8Nv+2ZVgOQPYwSbGUhGi
         th9cgn52/7qV4BdGlaFD3EC/LF5aaXqxhwvLAXECjqCkp1+eyZb3wIPLl5zCmUCvDsGS
         WKuZPOHFw0lw7p2oPRA+Seu8z2uZ4GdaZTm7Q8cgntDm6b2Od2R1w6yuZQACMZOZ0G+R
         BbGEplhq1262vKD0Rp7KTpfBfODKHXLYGiu85HG7mPgB/ywUBPsnx9t0kSo0WxqvEQY5
         VK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783907341; x=1784512141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ei6Ovvv1T88AmXcWJaHTpwUZz1npTk79c3/Dn7yootY=;
        b=H5ipNi6j4TkBBoj4lbfaUFXABrga1iWYLh6GrcioIKXhVU2iWnf3mdoWxu9OO33QQx
         k+cHhPmfDLxfVnWPD0Y0piy9lYQ0dfmWPlZ3TnalSdhYG30iy3Etik6UodglDQK+3Jol
         AtB696HD+QOcZ8M/+NTdE4oWSX+lbFdBQRq9kl1MKYo4maUadqj7/n2x+p5ruUOfFmh+
         AU35skUewevsosbefvQf5+frPfVFzgAyrvmRAUDxIFcVc7NPPCA6l1zpbuizeJQ1hDXs
         yrpAXPJtYtHLphggsUoNugClIXt/e5pFUpLc/VM2KUjS+zjPgYO7dQG29wROwo6Vc3gU
         mvBw==
X-Gm-Message-State: AOJu0Yyoy8T/0ey4P/kqwP57AF1NX3ZUcCC+/tNheaNvR+Mmu+YKXVV6
	e/djzgyjRiyKxs3gLT1pinkkVBHw5tETVpGEyd/QjbNsAYhIGBn/CeeqxmuS045Q5sizhwOB0jN
	XnaMugHlWvloBSiVHIRfGLQkvWiItUyI=
X-Gm-Gg: AfdE7cn3bmGYmH+7ZKSj29SxIEhLAAlVICgrWBRVnqZRhlIFgyCtLm2ZAbMcMld4vK2
	VKWoPAcfITni+BtkAJ1G0Ui3ARi5HyoRac8OuBbgan9qgnrEP0bt1dwyEA5VvYd8yshnMrxnJFT
	LmynZcl6FRDgAM1/emN0gUe9yHm+Q1YInjqhXsK0sgIIas1jjY4fMhLPskGZKXTeGaRvbwBsOlh
	xeHNc3oGCBiri+G7cwHChvt9OwRpB4g0/H4yOL9fcPvsmtRik94PeUNuvnWAaFgLA61kM3UbQ==
X-Received: by 2002:a17:906:2894:b0:c15:fc41:fda with SMTP id
 a640c23a62f3a-c161f42a82fmr216083566b.63.1783907340641; Sun, 12 Jul 2026
 18:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d56e7ac2502cd92d4837d9fb16b9228aa17d599.1783406660.git.jamie.bainbridge@gmail.com>
 <CADvbK_efrY+6jj=J7kQ7+k82wOJa+eABdZBK3Ou725M4hTZa5A@mail.gmail.com>
In-Reply-To: <CADvbK_efrY+6jj=J7kQ7+k82wOJa+eABdZBK3Ou725M4hTZa5A@mail.gmail.com>
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Date: Mon, 13 Jul 2026 11:48:48 +1000
X-Gm-Features: AVVi8CedDW67MjF9oMBHlVSJGll27QXRJx-4ORN_U7dE1t3vnQveiqcP3WaMQZA
Message-ID: <CAAvyFNjasjqXR8V3udWcCsNbQBP5AJLbmL+NL-1KW2c0treszQ@mail.gmail.com>
Subject: Re: [PATCH iproute] ss: Don't re-print an SCTP listen socket as an assoc
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
	Phil Sutter <phil@nwl.cc>, Rustam Kovhaev <rkovhaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:stephen@networkplumber.org,m:phil@nwl.cc,m:rkovhaev@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jamiebainbridge@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306995-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jamiebainbridge@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,networkplumber.org,nwl.cc,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71DC27467F5

On Thu, 9 Jul 2026 at 09:34, Xin Long <lucien.xin@gmail.com> wrote:
>
> On Tue, Jul 7, 2026 at 2:48=E2=80=AFAM Jamie Bainbridge
> <jamie.bainbridge@gmail.com> wrote:
> >
> > "ss -Sa" prints a LISTEN-state SCTP sock once as a non-assoc when
> > is_sctp_assoc() correctly returns false, then again when we have cached
> > the inode in sctp_ino, so is_sctp_assoc() returns true.
> >
> > On the second pass, we try to print the socket state with
> > sctp_sstate_name[s->state], but s->state =3D=3D 10 (SCTP_SS_LISTENING)
> > but sctp_sstate_name[] only has 8 entries, so we illegally access beyon=
d
> > the end of the name array.
> >
> > If you are lucky, the space beyond the array is NULL and the argument t=
o
> > the print format is printed as "(null)" by the C library:
> >
> >   $ ./misc/ss -San
> >   State     Recv-Q Send-Q    Local Address:Port Peer Address:Port
> >   LISTEN    0      5           192.0.2.10:9001       0.0.0.0:*
> >   `- (null) 0      5           192.0.2.10:9001       0.0.0.0:*
> >   `- ESTAB  0      0      192.0.2.10%net1:9001     192.0.2.9:11111
> >
> > If you are unlucky, the space beyond the array is non-NULL and you
> > pass an invalid address to the print format:
> >
> >   $ ./misc/ss -San
> >   Segmentation fault (core dumped)
> >
> > The inode is correctly cached at the bottom of inet_show_sock(), so
> > check if we've already processed this SCTP LISTEN inode and exit early.
> >
> >   $ ./misc/ss -San
> >   State    Recv-Q Send-Q    Local Address:Port Peer Address:Port
> >   LISTEN   0      5           192.0.2.10:9001       0.0.0.0:*
> >   `- ESTAB 0      0      192.0.2.10%net1:9001     192.0.2.9:11111
> >
> > We cannot exit later than this (eg: in sock_state_print()) because by
> > then we're already halfway through a new line in inet_stats_print().
> >
> > Keep the existing check in is_sctp_assoc() because that is needed to
> > differentiate related assocs from new endpoints.
> >
> > Note: there is still a chance of double-printing a listen socket (now
> > with the correct format if netlink delivers us listen sockets and their
> > assocs with something else in between:
> >
> >   $ ./misc/ss -Sane
> >   State    Recv-Q Send-Q    Local Address:Port Peer Address:Port
> > > LISTEN   0      5           192.0.2.10:9001       0.0.0.0:*     ino:3=
6518
> >   LISTEN   0      5           192.0.2.10:9002       0.0.0.0:*     ino:4=
4485
> >   `- ESTAB 0      0      192.0.2.10%net1:9002     192.0.2.9:22222 ino:4=
4485
> > > LISTEN   0      5           192.0.2.10:9001       0.0.0.0:*     ino:3=
6518
> >   `- ESTAB 0      0      192.0.2.10%net1:9001     122.0.2.9:11111 ino:3=
6518
> >
> > This behaviour existed before this commit. I don't see a way around thi=
s
> > except to pre-sort the results from netlink which seems unrealistic.
> >
> > Fixes: f89d46ad63f6f ("ss: Add support for SCTP protocol")
> > Reported-by: Rustam Kovhaev <rkovhaev@gmail.com>
> > Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> > ---
> >  misc/ss.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/misc/ss.c b/misc/ss.c
> > index 14e9f27a75321556240a5f290b8bcf51c605a4c2..7e94160f7590c35aa187fe0=
0902be8def7593608 100644
> > --- a/misc/ss.c
> > +++ b/misc/ss.c
> > @@ -3764,6 +3764,14 @@ static bool bpf_map_opts_is_enabled(void)
> >  static int inet_show_sock(struct nlmsghdr *nlh,
> >                           struct sockstat *s)
> >  {
> > +       /* SCTP assocs share the same inode number with their parent en=
dpoint.
> > +        * If we've seen a LISTEN socket inode before, we've already pr=
inted it
> > +        * and cached the inode at the bottom of this function. We don'=
t want
> > +        * to re-print the LISTEN socket again. so exit early.
> > +        */
> > +       if (s->type =3D=3D IPPROTO_SCTP && s->state =3D=3D SS_LISTEN &&=
 sctp_ino =3D=3D s->ino)
> > +               return 0;
> > +
> >         struct rtattr *tb[INET_DIAG_MAX+1];
> >         struct inet_diag_msg *r =3D NLMSG_DATA(nlh);
> >         unsigned char v6only =3D 0;
> > --
> > 2.47.3
> >
> Hi, Jamie, thanks for identifying the issue.
>
> The same listen was dumped twice continuously, which is abnormal.
>
> I think the issue was introduced in kernel by:
>
>   1ba8d77f410d ("sctp_diag: Respect ss adding TCPF_CLOSE to idiag_states"=
)
>
> where the check against TCPF_LISTEN in sctp_ep_dump() is incorrect.
>
> and got fixed (unintentionally) by:
>
>   7d8297e26b4e ("sctp: hold socket lock when dumping endpoints in sctp_di=
ag")

Fix confirmed by cherry-pick onto an affected recent kernel. Many thanks Xi=
n!

iproute patch can be disregarded.

Jamie


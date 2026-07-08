Return-Path: <netdev+bounces-306012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e25yBcHeTmpVVwIAu9opvQ
	(envelope-from <netdev+bounces-306012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 01:35:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 590DE72B32B
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 01:35:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cc0Crqku;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306012-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306012-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 493ED30C3E05
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 23:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DB839DBE5;
	Wed,  8 Jul 2026 23:34:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878C39B955
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 23:34:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553642; cv=pass; b=URxdXGUrhDts6t9biDHvGegeAAF28lMneK+kC6ZHRKkz6kCN+uAUrawstMlkUQzZtarSxr/l14snoCKFJrT6fCIZyq0iA3GbmRg6lzc5DPRO9YY36Ic1sI2af7Mpc1ggfnbDNwUUnlHThVTrJ8WY1gpH73PjbTULaXu4798xUJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553642; c=relaxed/simple;
	bh=VYi2u1mRLgvUmIU8MU5aTHmBuiTDCK8LORomizCP0Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4xDbpofQY4F09czNx3cA7zKhubYUlZr6watsGnvXvliGggHNwWLdWzzMAKOPDvKy3kiN+WERpn/wTrybjE9TYc2wITXemjdF3HE7lv/xAHSRYtFv+ZfuyDtfK8HeeEiPTu3XBvLLNySPEfVpc6yNCppEeK77AnLeK4NkOhjdjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc0Crqku; arc=pass smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845c92bc464so861422b3a.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 16:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783553641; cv=none;
        d=google.com; s=arc-20260327;
        b=HSL3O0rGqbw3vZrYSExAILddxM4Q8/VpilbyicmmmkJdM9pibsUqAImMkmVtEmHOFJ
         cfo5Yqq/8DRibux0V32PnXA69zAGMpPr0bTALJErcqdiHobsUsK7+awTBIa3PT0l0Os2
         sXvLQsw8Ok7Im3cBQspiBgeNGz7iwR7S8OZ8bKArxiK/BNtiNBZszbgRnMGAMO7FOyu5
         qpEhZbfI2Q7BdZzMyF7F6mN1Zz0fkfgdahXlwYCjaiSoZ24YH6h1PIA3j5oYoxnF8pKR
         iPx5DlPYURRfrMMcZrM9NUvcsHs1Kk7fHTft7RtHyxbVa7mKxRY6qnzqBZktl12QWfZ8
         XB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CX+gEapl9T2joPC10iHvd+2YSrps/B4k6fMebpx5nhM=;
        fh=vh4v5g3PGLuvSLwjKPWOb9AkQoKN3RuRuBu8/DyCy5c=;
        b=myFyKCmjKySP73tI5QnhXhRi60xBe4QENt0xxsWgpKbnfQz63QL1HtkHD8Km4oALfR
         AmhcNN+83HZz4+h2fiPppBPTaeSlUN/+GJzmpkNTbJsCd2z/4DKX0p23umhgncU0BxWs
         yCOGhqLQpcv8yRyuJD/RN+caNgGMqYl/9pRGhsXMEW3JYBNPBZgySYRmdsYRrm9BiGxf
         JeLNmaFYZyPZSvzZ9ANYyy3SEvEhpON9IOZ3/nebmbIlQDTuqu7Q/sdwEeRtDgJhy9LH
         K6nb3Yu8FpMbiEOCfqBf+pjDn7tyCcP4g1YdqyuLZGe4WR5PHLYm9HB3wzEl7B74JLg1
         w+Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783553641; x=1784158441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CX+gEapl9T2joPC10iHvd+2YSrps/B4k6fMebpx5nhM=;
        b=cc0CrqkuP7XgQ/wTpBwkEd/3ID7UJ8Vkq+O41tq3WLNYvi37xWyFYIqs++EA2OHs+E
         MgPf7bD3NH8MshW2L2tFAcvrrWLw/kA8FP8LzAagdzH4/Zgi0z0NFejoysdjGDrniS8s
         6CfRUw0r58jleB2F0/swpTtOsa1QfS4KDJRLf5fzO8mI3Uw2EJWXzDGTaXhq32PXDBK0
         5EbupS81Ic3h0JZ7l+WbH1yqcS4ZBzctYEmZWObXctfAFKj4ISSzUKtjWzdEQcaYxuzs
         FV2IG7mvRAmlmi2BCohWDD+3nmN/GQ98/TU+rGgh7bwcGu+l+A35QZPaJkAdW7Rbr+QL
         N5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783553641; x=1784158441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CX+gEapl9T2joPC10iHvd+2YSrps/B4k6fMebpx5nhM=;
        b=jUkkiVpPn4hQlsR03IzuuPSWGdRdGsZbafgHMQLKHLg2SQ7KV3Fnaxj71J8iru92Uc
         b2NrnjX+CoEt/XW2r5C4rMjGk4M0jZv7/WDb4a/iANb8YMrUGE8zMxXyOxV0If7Nunbj
         VvMNeRjZz86v3VHZTGVDiNVU213QwRiVVV/ZUjke8SKJCxF3Pv/boKUxGjINzNHi1/zR
         CFqK+B4bmWhNLQ5GRir+OaHM7QP6JYBzwUIKGUrm1BqD9fpd0oFKp3sWzZP+zjVC3n0/
         t59vO+UIBt2sbHzl9RYBGMkjWpxUdMe32v1PiXdp5m1FwH6/KiyOLudem/leh+uTzqIr
         3qXg==
X-Gm-Message-State: AOJu0YzZqWwRticDCmL1Qb6Xvq51eXBVmfScQTlt2CpOrObK/wth7/YB
	XiVGa/nRCxVvIAAXeK6BBAQfitTcejvYp/vj12ltX9Wc+XQSrR5il0JulDskxgrp4bQsyyawlQU
	kM3U0BP+o58xLMMd3+NkYpzgPwwohNtc=
X-Gm-Gg: AfdE7cnqr7K1azbbctox1/OKLMKUKZuTZyfj32Q7/t6939IpTLI1pv/Vf0uY5sRkW3e
	jHGUKv13tkwu1+cfVnP/gNz8Wc4EMsoA7mSkoMoYO7IUMBeAlu+v4q8hU8UqoxYSpgT+jlLAv8/
	tFv1e2O68M8q3lXHaXhDtuUzCbmNP86gHy00dwV1uv8+itMCN0N9T62PGvDJ/y+S6MrAGWvGquP
	5q6YkdXcXX/dk682A4UyHWndVZ162W3CFSueK6EoWXM5cVmP/xGGYOngLK0mTKP2pgMDxCX9ZXj
	p1t29yDvnp26XsU8x6yDZR303a1EMj1JyTbvVmlKWqMsgqgNNc9xPmpWjbaqvY1Smg04S18wdEV
	OnQBErL4=
X-Received: by 2002:a05:6a00:6f18:b0:848:4810:2b67 with SMTP id
 d2e1a72fcca58-84848102d18mr3298627b3a.21.1783553640851; Wed, 08 Jul 2026
 16:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d56e7ac2502cd92d4837d9fb16b9228aa17d599.1783406660.git.jamie.bainbridge@gmail.com>
In-Reply-To: <4d56e7ac2502cd92d4837d9fb16b9228aa17d599.1783406660.git.jamie.bainbridge@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 8 Jul 2026 19:33:49 -0400
X-Gm-Features: AVVi8Cdr6uyVfBEitP0e7Tb4E4sWOds5ebvaEZsQen_uVscn7m6UOVmiQ5ZL_gg
Message-ID: <CADvbK_efrY+6jj=J7kQ7+k82wOJa+eABdZBK3Ou725M4hTZa5A@mail.gmail.com>
Subject: Re: [PATCH iproute] ss: Don't re-print an SCTP listen socket as an assoc
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
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
	FORGED_RECIPIENTS(0.00)[m:jamie.bainbridge@gmail.com,m:netdev@vger.kernel.org,m:stephen@networkplumber.org,m:phil@nwl.cc,m:rkovhaev@gmail.com,m:jamiebainbridge@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306012-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,networkplumber.org,nwl.cc,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 590DE72B32B

On Tue, Jul 7, 2026 at 2:48=E2=80=AFAM Jamie Bainbridge
<jamie.bainbridge@gmail.com> wrote:
>
> "ss -Sa" prints a LISTEN-state SCTP sock once as a non-assoc when
> is_sctp_assoc() correctly returns false, then again when we have cached
> the inode in sctp_ino, so is_sctp_assoc() returns true.
>
> On the second pass, we try to print the socket state with
> sctp_sstate_name[s->state], but s->state =3D=3D 10 (SCTP_SS_LISTENING)
> but sctp_sstate_name[] only has 8 entries, so we illegally access beyond
> the end of the name array.
>
> If you are lucky, the space beyond the array is NULL and the argument to
> the print format is printed as "(null)" by the C library:
>
>   $ ./misc/ss -San
>   State     Recv-Q Send-Q    Local Address:Port Peer Address:Port
>   LISTEN    0      5           192.0.2.10:9001       0.0.0.0:*
>   `- (null) 0      5           192.0.2.10:9001       0.0.0.0:*
>   `- ESTAB  0      0      192.0.2.10%net1:9001     192.0.2.9:11111
>
> If you are unlucky, the space beyond the array is non-NULL and you
> pass an invalid address to the print format:
>
>   $ ./misc/ss -San
>   Segmentation fault (core dumped)
>
> The inode is correctly cached at the bottom of inet_show_sock(), so
> check if we've already processed this SCTP LISTEN inode and exit early.
>
>   $ ./misc/ss -San
>   State    Recv-Q Send-Q    Local Address:Port Peer Address:Port
>   LISTEN   0      5           192.0.2.10:9001       0.0.0.0:*
>   `- ESTAB 0      0      192.0.2.10%net1:9001     192.0.2.9:11111
>
> We cannot exit later than this (eg: in sock_state_print()) because by
> then we're already halfway through a new line in inet_stats_print().
>
> Keep the existing check in is_sctp_assoc() because that is needed to
> differentiate related assocs from new endpoints.
>
> Note: there is still a chance of double-printing a listen socket (now
> with the correct format if netlink delivers us listen sockets and their
> assocs with something else in between:
>
>   $ ./misc/ss -Sane
>   State    Recv-Q Send-Q    Local Address:Port Peer Address:Port
> > LISTEN   0      5           192.0.2.10:9001       0.0.0.0:*     ino:365=
18
>   LISTEN   0      5           192.0.2.10:9002       0.0.0.0:*     ino:444=
85
>   `- ESTAB 0      0      192.0.2.10%net1:9002     192.0.2.9:22222 ino:444=
85
> > LISTEN   0      5           192.0.2.10:9001       0.0.0.0:*     ino:365=
18
>   `- ESTAB 0      0      192.0.2.10%net1:9001     122.0.2.9:11111 ino:365=
18
>
> This behaviour existed before this commit. I don't see a way around this
> except to pre-sort the results from netlink which seems unrealistic.
>
> Fixes: f89d46ad63f6f ("ss: Add support for SCTP protocol")
> Reported-by: Rustam Kovhaev <rkovhaev@gmail.com>
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> ---
>  misc/ss.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/misc/ss.c b/misc/ss.c
> index 14e9f27a75321556240a5f290b8bcf51c605a4c2..7e94160f7590c35aa187fe009=
02be8def7593608 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -3764,6 +3764,14 @@ static bool bpf_map_opts_is_enabled(void)
>  static int inet_show_sock(struct nlmsghdr *nlh,
>                           struct sockstat *s)
>  {
> +       /* SCTP assocs share the same inode number with their parent endp=
oint.
> +        * If we've seen a LISTEN socket inode before, we've already prin=
ted it
> +        * and cached the inode at the bottom of this function. We don't =
want
> +        * to re-print the LISTEN socket again. so exit early.
> +        */
> +       if (s->type =3D=3D IPPROTO_SCTP && s->state =3D=3D SS_LISTEN && s=
ctp_ino =3D=3D s->ino)
> +               return 0;
> +
>         struct rtattr *tb[INET_DIAG_MAX+1];
>         struct inet_diag_msg *r =3D NLMSG_DATA(nlh);
>         unsigned char v6only =3D 0;
> --
> 2.47.3
>
Hi, Jamie, thanks for identifying the issue.

The same listen was dumped twice continuously, which is abnormal.

I think the issue was introduced in kernel by:

  1ba8d77f410d ("sctp_diag: Respect ss adding TCPF_CLOSE to idiag_states")

where the check against TCPF_LISTEN in sctp_ep_dump() is incorrect.

and got fixed (unintentionally) by:

  7d8297e26b4e ("sctp: hold socket lock when dumping endpoints in sctp_diag=
")

Thanks.


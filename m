Return-Path: <netdev+bounces-285246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /P5+Gmlx/GkEQQAAu9opvQ
	(envelope-from <netdev+bounces-285246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:03:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 981CC4E72D1
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 084E2302000D
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948BD3DDDD1;
	Thu,  7 May 2026 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="IdvJPeih"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA73EE1DC
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151490; cv=pass; b=XAYMYhVCFMrb2YCnT/NceNpF9rMymWsZwZadYECHk5AAlpswqQPq67Y7hxZx6BmmbPaQuOAc2lENxBw/8EEElRIHhG8CzrNvPRWboEkee/N3OH56qqirrfd18sRkCQokanH5Mlnq97G30CboyRquaDnQGmpdCK4uEEIK9XGKvz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151490; c=relaxed/simple;
	bh=EatwXWiIR9QmGXhIVhQe55PrFCR5KFGzuZXiljgfysU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmEeYvqQem3r53fPjqypAC/J3BfphpZzl+wttppXR6roWsqK3i2F4tLvPnBsZj9TNUafqoGb05ssV68QkOg4rRRhZDUyRZ8T6BG9CgtPHXA2AncRsqqPcBjmAM+dYH2Eroxvz7fnolPyyidRv45wHGk5v+qhUJpe6q/K/80iSEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=IdvJPeih; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-83945063f70so874942b3a.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 03:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778151475; cv=none;
        d=google.com; s=arc-20240605;
        b=ig0MgtdJoB7ohGgWkFrtS6Cc2Rx2vz/I/+2wib70W1LxUQWL/moAQzuearCgjjfHbT
         /Lr8PaNrqN84v0tUVOUANjrEwiz2d19Hl8E4aDhsl+W7bzGWn38DyQpylgmOTnS1hNDg
         m3yxJZ800KLXxaLCeHYI1MkTNqOVt+6uZWeC+e9XOfLCvTZLjtRzd7O/3blOl8EtnenU
         nK3LBSvHYuNZ34ZTEPCn5OiljEpU4albRKCDHeYgv1xbxyv/FUI8apdXVpoLZ6rOAjmU
         D8aWuPm4aapFRXUdf20Ma/FiuhkR91RTvBT6IEmKblZvwlG0EECNzKiW8/I8omOqA3tK
         IaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oPVL2GjvrzQhKd8ADnxeiwx1nKks5OaNxUM/54F87FQ=;
        fh=KBXsfxVG7ixLpXYN6qTwTDy5POs2++zGZSIBEFOgvs4=;
        b=JQoX99Yq7yKJYm49ItT4F2a27sg3b4cUlxK3ZXw15eKR/er7WpJpQrOPoWaK9+Hz3u
         jioXGxZBo9T3mAG0r+or1xIHduS43ykUSDVrNt8HW5Qsa5EhJD1Zzm3tgfkdViMsjWwm
         8fm2mhK0xUanQ2de1jCI7k6mjA73Nu9B4m9l7TCYX59aLO7lFQ7utvP6k7FskZehdRYq
         Q264boEu38DdfCSvyK8PHVm9qcohvbgj//zdjI9au91apoZkrnrWO8KAWKg+af/YWoz1
         LeVeKcjLW9kKlJ0Sy5FOndjClALATrsBCHI8Fn5hNK3yYPyTU1XWwEGppLoLV5G8cWLm
         crKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778151475; x=1778756275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPVL2GjvrzQhKd8ADnxeiwx1nKks5OaNxUM/54F87FQ=;
        b=IdvJPeihxAAldA6JHMME8b9vKcYTjMlb0shIJLf8iMbbQvSh8iL6/t6fbvX6HT2wBl
         C8XovR3QvMtrYlIMgJ4X5iAoi38Ey1enbCP9neifr76uQkPKIUIbd86VqOpK1O7bt6u2
         ZiZA6wUtCv5MjN1qECRuY/a5ZHDKNmYJJYrw4Am1zZp2uQwZd3GOIjb43o4m8+VJaqr6
         QtMXKMJFHMNbXl5tHQIJ1fDdrjdKj0HTgyIZb8T7VQPbV8UQZpATSnnfinaODPzDgYvu
         Rhp5cul8vbx/s95nQO9hZ/F4xXQdyyH7QZ9w4QmXwx+1wGLr4v4Eym3+qvrAPB6GLTgh
         SJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151475; x=1778756275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPVL2GjvrzQhKd8ADnxeiwx1nKks5OaNxUM/54F87FQ=;
        b=ppfRoVe1D+HJ6Rqtc1YKt7835/F6k9g7fC7O2INHgeEmZM2hDcz+jMOIce9CWRDo3K
         9AhP2WI4Q2S5CY2SuDGKz4o88rZxwGdR7gNDfa3Rib4PH8YMkGMbEFzTWn5Orrn1e07t
         kEo2R8o4FW7gFVyYUmwNBuGpPoQdJIyVsglj/WCmbaGJzEkil4zoZYcvrDJ+3ZCnteQ/
         lD6dZAKSgD3Fd1oPa+rJUZ5dmn1PZ+EZ8+2Jy8SJwJs8glckDIWPTgQkrA46IHtjCZwS
         KzdtnDqvHyf1GIg1JkW5D5AdnzAT4uUyPjQyokollMUUfXj9E52o9JzmLM+eI/XiKV2f
         A1Pw==
X-Forwarded-Encrypted: i=1; AFNElJ/SafvLrH54Zd8BJ3G13Ef+iFvUbZuZ+KL8Cda4CcafLOmECPrhQgfTlvJqFwRaexUIjgV+z94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQV266NGy2abiO7g+PJN60AufZWnFTiS5A70THn52RzcdtqeYS
	gez6IpJetcUE4/E3OYdty+jv368euhFvo3F4HuKk5dHAbYTS931xy65Sus79R/HYdCJO17TdyRi
	Q9bwmn4h0nBblnyMETPTLfNC8agQqHdYrMgKNLBFL
X-Gm-Gg: AeBDietOwYcK2M9z0Qn4RoufO5m8p0AIFwXmRPEcV2WdsnV2Wnj7laiwnBZ9HHm8zsX
	wjTuieefax9O1LT/nB8NmKQiwYgnWPLqhlEVbFp8OJJgtFkySMRMe2x3uggyuD2ee9TpYB75Ene
	hBsU1uneqkno99bhhikNlcMzQXZOOgyOY3ZXr1XaVti9V5VfZ806ET9jm9DvJYuXwSddxb3PLTn
	pypqqlWvMKIsxL/fFjmJGeIRhBHTmvHvxmpMoa7ULrudN85P4AvgYnRjSHlOSA5hLkh6PYYX7wO
	opCbj+4vEgfABU/dDjt+Bf4h0h1f3A==
X-Received: by 2002:a05:6a00:b8f:b0:837:6bb9:acc1 with SMTP id
 d2e1a72fcca58-83bb6cd842cmr1946259b3a.13.1778151475157; Thu, 07 May 2026
 03:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506160656.1226077-1-edumazet@google.com>
In-Reply-To: <20260506160656.1226077-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 7 May 2026 06:57:43 -0400
X-Gm-Features: AVHnY4IlGLW9bqJ19ndvVWahIfUW6qgXhfUgVRkRS2g1TFC1nWSHclHH1IQiMW8
Message-ID: <CAM0EoMkRwxvoxU5qPmiFr5KGu7adeWe1NmuSHNwZMYYadt+8=w@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] tc/class: use rtnl_dump_request_n() in tc_class_list()
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 981CC4E72D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285246-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Action: no action

On Wed, May 6, 2026 at 12:06=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> strace tc -s class sh dev eth1 parent 2:
>
> strace is fooled with rtnl_dump_request() way:
>
> sendmsg(3, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D0=
0000000},
>         msg_namelen=3D12,
>         msg_iov=3D[{iov_base=3D{nlmsg_len=3D36,
>                         nlmsg_type=3DRTM_GETTCLASS,
>                         nlmsg_flags=3DNLM_F_REQUEST|NLM_F_DUMP,
>                         nlmsg_seq=3D1778082626, nlmsg_pid=3D0},
>                         iov_len=3D16},
>                 {iov_base=3D{nlmsg_len=3D0, nlmsg_type=3DNLMSG_NOOP, nlms=
g_flags=3D0, nlmsg_seq=3D0, nlmsg_pid=3D131072},
>                         iov_len=3D20}],
>                 msg_iovlen=3D2, msg_controllen=3D0, msg_flags=3D0}, 0) =
=3D 36
>
> With rtnl_dump_request_n() we get instead:
>
> sendmsg(3, {msg_name=3D{sa_family=3DAF_NETLINK, nl_pid=3D0, nl_groups=3D0=
0000000},
>         msg_namelen=3D12,
>         msg_iov=3D[{iov_base=3D[{nlmsg_len=3D36,
>                         nlmsg_type=3DRTM_GETTCLASS,
>                         nlmsg_flags=3DNLM_F_REQUEST|NLM_F_DUMP,
>                         nlmsg_seq=3D1778082790, nlmsg_pid=3D0},
>                 {tcm_family=3DAF_UNSPEC,
>                  tcm_ifindex=3Dif_nametoindex("eth1"), tcm_handle=3D0, tc=
m_parent=3D131072, tcm_info=3D0}],
>                 iov_len=3D36}], msg_iovlen=3D1, msg_controllen=3D0, msg_f=
lags=3D0}, 0) =3D 36
>
> This will also permit future attribute additions, like skip stats.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Did not run tdc tests yet.
Waiting to see those extra attributes ;->

cheers,
jamal
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  tc/tc_class.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/tc/tc_class.c b/tc/tc_class.c
> index 310514ce560ab6c1b42665cb6c75314e45b84cd6..82f0f85ee39a335bc7e1c3bea=
2e3ea9571ea155f 100644
> --- a/tc/tc_class.c
> +++ b/tc/tc_class.c
> @@ -386,7 +386,14 @@ int print_class(struct nlmsghdr *n, void *arg)
>
>  static int tc_class_list(int argc, char **argv)
>  {
> -       struct tcmsg t =3D { .tcm_family =3D AF_UNSPEC };
> +       struct {
> +               struct nlmsghdr n;
> +               struct tcmsg t;
> +       } req =3D {
> +               .n.nlmsg_type =3D RTM_GETTCLASS,
> +               .n.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct tcmsg)),
> +               .t.tcm_family =3D AF_UNSPEC,
> +       };
>         char d[IFNAMSIZ] =3D {};
>         char buf[1024] =3D {0};
>
> @@ -412,20 +419,20 @@ static int tc_class_list(int argc, char **argv)
>                         if (get_tc_classid(&filter_classid, *argv))
>                                 invarg("invalid class ID", *argv);
>                 } else if (strcmp(*argv, "root") =3D=3D 0) {
> -                       if (t.tcm_parent) {
> +                       if (req.t.tcm_parent) {
>                                 fprintf(stderr, "Error: \"root\" is dupli=
cate parent ID\n");
>                                 return -1;
>                         }
> -                       t.tcm_parent =3D TC_H_ROOT;
> +                       req.t.tcm_parent =3D TC_H_ROOT;
>                 } else if (strcmp(*argv, "parent") =3D=3D 0) {
>                         __u32 handle;
>
> -                       if (t.tcm_parent)
> +                       if (req.t.tcm_parent)
>                                 duparg("parent", *argv);
>                         NEXT_ARG();
>                         if (get_tc_classid(&handle, *argv))
>                                 invarg("invalid parent ID", *argv);
> -                       t.tcm_parent =3D handle;
> +                       req.t.tcm_parent =3D handle;
>                 } else if (matches(*argv, "help") =3D=3D 0) {
>                         usage();
>                 } else {
> @@ -437,13 +444,13 @@ static int tc_class_list(int argc, char **argv)
>         }
>
>         if (d[0]) {
> -               t.tcm_ifindex =3D ll_name_to_index(d);
> -               if (!t.tcm_ifindex)
> +               req.t.tcm_ifindex =3D ll_name_to_index(d);
> +               if (!req.t.tcm_ifindex)
>                         return -nodev(d);
> -               filter_ifindex =3D t.tcm_ifindex;
> +               filter_ifindex =3D req.t.tcm_ifindex;
>         }
>
> -       if (rtnl_dump_request(&rth, RTM_GETTCLASS, &t, sizeof(t)) < 0) {
> +       if (rtnl_dump_request_n(&rth, &req.n) < 0) {
>                 perror("Cannot send dump request");
>                 return 1;
>         }
> --
> 2.54.0.545.g6539524ca2-goog
>


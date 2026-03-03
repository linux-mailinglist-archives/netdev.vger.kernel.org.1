Return-Path: <netdev+bounces-263380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PtsGmczp2k9fwAAu9opvQ
	(envelope-from <netdev+bounces-263380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:15:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FABD1F5C95
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39CD23049D6C
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8759D3537F4;
	Tue,  3 Mar 2026 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dnJ6mFuN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49C3537ED
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565331; cv=pass; b=g1whEF+vw5ippzwWRxBtHNiE2gHXvhYdZA/o9IqtnxkupegvraDU1EC9e+IvV/+5bHTGr5KEGbB7oRYOxMnRIpXvNg7rZx6Gb28OWo2o1x+EJNLK8MOTbtvielsTKnwjSW0m2QvzTk3B4rTlaLAurhGwdolRihKBWGuCgbrB30s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565331; c=relaxed/simple;
	bh=gWn35m7N71/aCcF9Kz5cWE38nycCL16noYuObIRWPsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGYKMzvqtWCU1dUM5xy6FHiIpVFFBFKmzigLSpjj2J71wGa6zy6V7K8LCZE1CtQ18wfBfAEn1Smuh49pJ1LRFA2q2C3VkRBjournORwtNEMn42PQugfYz/MyI2+onnRpF/tOXS81B2xfts3iPYZlF5dq52H0cxrK1iLuXAAIsfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dnJ6mFuN; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-127380532eeso356765c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:15:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772565329; cv=none;
        d=google.com; s=arc-20240605;
        b=XDPnL2o5RyCNWffGljNVZfcAr2jplidYOgWQweIrmCHuyK6854LfdOAUjWKTkNnh2T
         qtYDCYHAAU15DafrHAuZtG1fEQt06F5ALpksAYJZt7TzDGP4iJ++fb87ggpoGbjdGIsQ
         AMxf/B8+ZiZ+HhpRJ2ZI4qKZmPcY0bKyABk7L48EMO0ME2fi4Mcz64O6iKilZcnwKn6r
         6948ZvCCghOOc3QbhQT25B4VRjzO94D1iDkWTDdzQNHlh+e/d8YwpIZUVIJxjcTk8mUa
         cqzBk2eo1ARSXIVJA0dN0ZHAjycjwa/QhsqUzhhDmlyLDZ6fzScL3dyAcOV8WAYnZdMC
         NnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OqlGtdbRVHU7YXGYxhDJwMRbkB7YKbm6URUa4qxbU14=;
        fh=0dZcnRHZ2AdyunkiCUBzfVrKK04pU3uZihd1QCHKBCk=;
        b=bhoN9wvxNmmxK1lyQTn3qNNE5ng/4Zl1h2tYbe1X0JnDsU2pLvins1/uuYn1G6NruE
         YAW8rD3rTl4TPaifcBFFpHROGlYwweMHF0atPpNyTYm6dVF4CLwpx98IvJNisTTpUdzo
         XwjJCqV/Vvmksji7yc/BdZfsHtVtdVnMoyW46XUW1mJY6XR+mtOg5AeKmHe9vZcHP2bm
         XIb6POsqO7Udc8BRfUYYiNqioJmnTZfQWabJGFK+ud9bJsD6npg1o9If7V4N9crRa1EN
         ETDCn+ZZOqAxQy+akklFqHnX2yeUxSA0rZ/JFXCSEJW3MGW6i3N/NWNbOHIdZZud2zpV
         RlhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772565329; x=1773170129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqlGtdbRVHU7YXGYxhDJwMRbkB7YKbm6URUa4qxbU14=;
        b=dnJ6mFuNObVI8P/U8HkK1CaSMRWRV9bmFD+n38KxNZp9Lrhz6t/oTf3XrT/gTgXYTm
         hueCPYEgc7Mmc59O0UwK6ZMVxOhpeisp4Sn9qYKsisVbrxxqe0bssLQUSQH/lqXXqyN0
         cGOK1ph06xaaP80HvqmLm290HoNrfcJcab5qPWgcS4xF3Xr01/5bs77ks5Db5kgTtD5W
         mvv5/ZSX9CkvDYWGfFjpnFRpWHqo/Hhbaasxiygm6rQN3QZ7HdX3m+pv6yLlEhEBe4Io
         oSJTzPqPWxcAtm4uU4DS3qh7CvjZZ5fs2/mRyNmT4Ubsl68A9Sb04JGOpKvHE93S5Wy2
         kUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772565329; x=1773170129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqlGtdbRVHU7YXGYxhDJwMRbkB7YKbm6URUa4qxbU14=;
        b=SwwuFtRVN7NAcYu+bj/kmeBQ894XrxYzKQm0wht+v3HewLfMpOT+zTD+VMIDq59szQ
         3YA7NxpA3fwI36T8GHj5xqzkzAQFLpAxcgJKNktbOKRvC1jV/9TfyM8+IXs5/Bc3F/kk
         aKWbEm6J51yfP/oJ5ozg8Jk6s3EW8wTLxV/++hB+DiLwm8jqLizH921M/ZWHW5NyUjXJ
         RO6E6rF5lmPABlhmBqcfthn4iuoPXar1Jcz1wY/8L4ssjAfd1XprQ1cT1GJrGn9f3uKE
         9aAU8v4LMo+BUF0nw8o5m+7RiFJX0r8sBH67oEr3wnmIPI+9UUTf0p0FhNtwGgykPHMe
         Md8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+7YGG1+TA1AetIRp8CQkrJKvfRpGOoOhfMbRNobU1fIEA9TR7b7h8/VL2owuwZNLTMi5EECM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywql3HFSLk6lVoQgp74a3feWDdPKR9ZzQ2H2wf+IRm8NJk0PR7V
	9lDLDJXwybtqa4cBnI7qPqcOkI9EU5rIPTxZyrd62TmilY14FqDZ6+VGf4qVoShol2OJs9nnVDa
	gnIZS0ldTRYcC8TtTuyQjnvt6lsd0Lrdnx1RtnZ2Riz7MdNVP1ItSQUIC
X-Gm-Gg: ATEYQzxIY1xv1HfSa7v6U3bQtEXGo6mzlvBOlXHC/eR5FkHuoeVellwLW3+erEYaZjj
	5lp06RArGKN22Q6l94eljMs7pykhowDQrBJGT2zLhS9Qxp1ivavT1vpjDyR/sD5m3xHBp3OeY+m
	QDqPvPgt0fLA9227rliSl7301t+1jjx/F9s6jCzHa6W+MrSFHFAp1WE3PYaR1dnuCfPLd1pX1i4
	sybTg437Au5hRZt2eBqMgxjSaVRGk3We5uhhDzhThaslOR1XNY01UGTpFLFkqb4ZDSr/DpHSYD1
	xt147fTkB2BnOwRY/uoKjvz5/jVhCQh/SzsbAJ00DLqmErhW7OdYoFC8bMoa9SHKQ0Mvll5hDs1
	wjwOj
X-Received: by 2002:a05:7022:4381:b0:11b:a3a7:65cd with SMTP id
 a92af1059eb24-1278fc48265mr6361509c88.12.1772565328657; Tue, 03 Mar 2026
 11:15:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302154201.1621117-1-edumazet@google.com>
In-Reply-To: <20260302154201.1621117-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Mar 2026 11:15:17 -0800
X-Gm-Features: AaiRm525YjkVQwGNFvfojmlZiWhdqJhdNYhBX94ANQeEcxM4DM_eMOTovP_0uLM
Message-ID: <CAAVpQUD8zSg1dsf6oSsegY83VcajhtXyA2Wst6C6Q_XnYMpOVg@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: add IPV6_CALL() helper
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0FABD1F5C95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-263380-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 7:42=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> ipv6_stub use is racy, we should add READ_ONCE() and WRITE_ONCE(),
> even if this pointer can only change once.
>
> Add IPV6_CALL() macro to factorize the READ_ONCE(), and perform
> direct calls when CONFIG_IPV6=3Dy.
>
> ipv6_stub->nd_tbl will need a separate patch.
>
> $ size vmlinux.old vmlinux.new
>    text    data         bss             dec             hex     filename
> 37705007        23152761        4747540 65605308        3e90ebc vmlinux.0
> 37702861        23152665        4747540 65603066        3e905fa vmlinux
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/22 grow/shrink: 0/25 up/down: 0/-1025 (-1025)
> Function                                                                 =
        old     new   delta
> nexthop_select_path                                              832     =
828      -4
> ipv4_confirm_neigh                                                       =
426     422      -4
> fib_detect_death                                                         =
348     344      -4
> br_do_suppress_nd                                                        =
671     667      -4
> udp_lib_setsockopt                                                       =
893     888      -5
> set_xfrm_gro_udp_encap_rcv                                       117     =
112      -5
> __ipv6_neigh_lookup_noref_stub                           336     328     =
 -8
> udp_tunnel_encap_enable                                           57     =
 45     -12
> udp_tunnel6_dst_lookup                                           465     =
453     -12
> setup_udp_tunnel_sock                                            251     =
239     -12
> nexthop_free_rcu                                                         =
254     242     -12
> bpf_xmit                                                                 =
       1203    1191     -12
> bpf_input                                                                =
        500     488     -12
> __remove_nexthop                                                        1=
705    1693     -12
> xfrm6_tunnel_check_size                                          631     =
616     -15
> sch_frag_xmit_hook                                                      1=
233    1218     -15
> icmp_build_probe                                                         =
922     907     -15
> eafnosupport_fib6_select_path                             15       -     =
-15
> ip_neigh_gw6                                                             =
708     692     -16
> __pfx_eafnosupport_ipv6_route_input               16       -     -16
> __pfx_eafnosupport_ipv6_fragment                          16       -     =
-16
> __pfx_eafnosupport_ipv6_dst_lookup_flow           16       -     -16
> __pfx_eafnosupport_ipv6_dev_find                          16       -     =
-16
> __pfx_eafnosupport_ip6_mtu_from_fib6              16       -     -16
> __pfx_eafnosupport_ip6_del_rt                             16       -     =
-16
> __pfx_eafnosupport_fib6_table_lookup              16       -     -16
> __pfx_eafnosupport_fib6_select_path               16       -     -16
> __pfx_eafnosupport_fib6_nh_init                           16       -     =
-16
> __pfx_eafnosupport_fib6_lookup                            16       -     =
-16
> __pfx_eafnosupport_fib6_get_table                         16       -     =
-16
> eafnosupport_ip6_mtu_from_fib6                            17       -     =
-17
> eafnosupport_fib6_get_table                               17       -     =
-17
> skb_do_redirect                                                         2=
878    2858     -20
> eafnosupport_ipv6_route_input                             20       -     =
-20
> eafnosupport_ip6_del_rt                                           20     =
  -     -20
> eafnosupport_fib6_table_lookup                            20       -     =
-20
> eafnosupport_fib6_lookup                                          20     =
  -     -20
> eafnosupport_ipv6_dst_lookup_flow                         22       -     =
-22
> eafnosupport_ipv6_dev_find                                        22     =
  -     -22
> nh_rt_cache_flush                                                        =
191     167     -24
> fib_check_nh                                                            1=
580    1556     -24
> nat_keepalive_work_single                                       1319    1=
292     -27
> eafnosupport_ipv6_fragment                                        35     =
  -     -35
> eafnosupport_fib6_nh_init                                         49     =
  -     -49
> rtm_new_nexthop                                                         8=
495    8441     -54
> bpf_ipv6_fib_lookup                                             1107    1=
043     -64
> .compoundliteral                                                        5=
792    5592    -200
> Total: Before=3D25219423, After=3D25218398, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


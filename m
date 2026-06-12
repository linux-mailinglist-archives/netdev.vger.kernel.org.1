Return-Path: <netdev+bounces-298473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id upj8GFqqK2p7BgQAu9opvQ
	(envelope-from <netdev+bounces-298473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:42:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFADE676FD4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:42:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ViBKG8bN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298473-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298473-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1377330B0E8A
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A163D8103;
	Fri, 12 Jun 2026 06:41:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427B3D6683
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:41:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781246519; cv=pass; b=CmPdM2uA8srzqUPdZK5vBmhMnx8oBpDrAK3EMKu021MwxmXlJpR2bG6+Iy7KbQCN8u0VzlW0Wqs5PIEDfS6OPl8UxVlqfWAQXmYZ0DyM2fROqjWQLBcIHsnHwwehPJaQpDAQlRIGxwKCizVxS0pUZqUuQ5QuNl7aMSeWOsMgmm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781246519; c=relaxed/simple;
	bh=il9gLlDK2ryI0ZJU3Rk08iTfXQVb81d8dYDWL7SRAzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmPJbyrBvPt6Ic+ToNztQWD4e88Zf53cqV6lFgAKGzdSGECCaeYIq8EPfDIZdNpj6qajWHb9of3Btgy/jP1WQadnrnBk/Ck27ljwFSP3gTPKqMs7LmMpMlHAjQt0/kKUdxmWOUvMjlbB3FEnolPLRYti43Zj9lS4Nh/2CT1VWOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ViBKG8bN; arc=pass smtp.client-ip=74.125.82.47
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137dd523634so959919c88.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781246517; cv=none;
        d=google.com; s=arc-20240605;
        b=WmeAKNh4JvRGu6rWq0ISYmecKmmCMcexcyCaTvpwU13TWdNGdZFBHzEeW8dKI7dK+Z
         qLuWi3QpcawIRaQWdXV/ue2ItF9ekLPKk4/xooFrsW/bkL7EE1vPcqDrgZslfuCeEBs4
         vBC85HddGXVIwBdWaSRVU+np7rD0aymRMPmfDSUIfSq92F9VsIBhdSmp71Gs3zk7NfvG
         uWJwkADrQbpG5kiKqAKdjnmI9z0xo36Wt8T08SmdZI6Ivmq0ESplejmpCxSGpN1wBK3b
         Tz1pXAvgBa8NtN93pH+WYsYJmK+3lkPnIPLsDl4EEgin3D9xvGtu2LB+toVG0UdgFuBG
         X8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=il9gLlDK2ryI0ZJU3Rk08iTfXQVb81d8dYDWL7SRAzw=;
        fh=e1xFRHusdEEDctjeYmTehimuq4EjH8P1xrx37yTYHL4=;
        b=hu2u2Ru5Ideu60s4GFPVs5l6gq8pf04q/9Ndg5jeGrV9k9CZRhGt3G41HATAIgkcSY
         GQfmK2YEUhczWgtIY0jpuc5JeWazM5EDBEpw8mIAptgrDJ2IIlbshgot2v5iXbbd6V5o
         Pc1eHh13NN+7K/yEqK5fdcGHA1p9jxEuwj0vBF3d2aGG+ZiWEvmK7dgXhc7XT9fSxuVm
         AgpSRUCqZGv6bBpbKyq2Aw5p92yTFBl67JqPa3N5s8QgQfXK2YHliaSjHEGdObA5NsH/
         A26XZugroGU00tgC6Qh65jNNrfToVBe9BBol8DNDWlU5dGK8QkFauTSBL1Mwd5mwVFJ5
         mt4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781246517; x=1781851317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il9gLlDK2ryI0ZJU3Rk08iTfXQVb81d8dYDWL7SRAzw=;
        b=ViBKG8bN2Dc+86Ra8JFtji3ftEKhz/WdcpPwgiIRTpexMojvsr3LIfAENOZwbOLWJN
         8WTsWlTVDMCu295oCTzVI6eGiP1T1JCGxpiXRC4/2lQF4JFY9hilSlahiWZpphIbzarg
         GU8epCY1VdMbEfDpK3x4WEL2haHGFoJel16jcVD9m05Y9InEBcbIGT7Tdq+euBOauh9z
         PoTgCjSNqZwx67yfEEXU6L91kQqxIRQIHjkkeK0GP4PS7upsAiazDvHWqJFkjOJtUfod
         VWKIYLoz62rHkg8HiKHrr/vdVPBnRCF7FBCKDa1DkRcv+mnksW0URqFfzRdx0kcG0qd7
         A7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781246517; x=1781851317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=il9gLlDK2ryI0ZJU3Rk08iTfXQVb81d8dYDWL7SRAzw=;
        b=sNb+uGHeSpSndZHWklsBW5pPjEFSTtCVjEDfw8KivkCGodsVZTS962Sin3DnoLll2T
         bB9aREsBCjx9x4owiZNvCo6NcVmfHJmW+em3o4FMtP+5yoJMsVaydddMUmYtwvmI4Zn0
         OUsJenB+tPM0EY2MOVfw0RxE52RF4RRQyfzu2XVcEP3YN0EkUTowyg3v0zsRIaAjyeOx
         2lAXoNC7GmtaJIJbwUpF9LU7Ehd4WNHJFJhz3tmbgvxG0qGSTB77GayvTyKmmpIwlYDo
         V3BQoNnRxVDWkNrwz0qsR4ckAcR7bewlz0YAA51QJSjsxJVcR6AuP22N86Br8hR2K5OB
         RyqA==
X-Forwarded-Encrypted: i=1; AFNElJ+8wX7prRlYHU829h1hEu/s77RzyLijLMlfgJ/pscJclo7yO9dr9lrp5xBQbGFUgk6VOutWF7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTNDFXjvkjp76G0L8krf72PQNFvyPI9xKCtZW2/OzBrZO9ZY/z
	VT93aSIRuIVzrG2uCbfj4cX0TaHr4hsP/jRkoBkImnaxqLeI12unHwt1hQ54d8AW0nGYwo9MdOA
	iIOO3wa0LOkPBErasYmVEwvyi88JHqqNJsDP2odqp
X-Gm-Gg: Acq92OF3wR/T2JvQgSDJdlZk/huzBhS6InCLrMpIGNILHchWtjgipk0V0ba/tANOTYu
	aIzy9MLCSKgxjO/TIA33cnyBU4uCPI29amQ1MfUYG/oZ6xBM++WYgozAw4mBJ2VdJED0c8lbQUx
	XRlCtvTmoPiFixYaJdXdLohhRTqjv+bIGgscgExe2++d+xV/pYGionScNTma2oAYTYysq/3VlI4
	7/QxLggEo6QI74lI6ytsix78yj1x+fUIEL0WDiDjFzBFMxAOezM4WZ+ava89laN4jDmyEn4ptpb
	Vl/oRaOmysEcdrZlT+DIYpst4fUx4lrvY3vAN5N0JFIb0PffbgrDu30AvhpBPjwY0fWeymAM7cl
	6T5YnAJRIalSKStwQAR0MiNUHUDoBu+yJ88QHZj6StNe8l3kFTUs/
X-Received: by 2002:a05:7022:6a4:b0:138:407c:1d0f with SMTP id
 a92af1059eb24-1384baef0b4mr595568c88.1.1781246516575; Thu, 11 Jun 2026
 23:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-2-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-2-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 23:41:43 -0700
X-Gm-Features: AVVi8CeF5TL34MXY3AZ5iYUyue6WIxsN_f4iunM0aCi1eakSENdPJq2jGVYJej4
Message-ID: <CAAVpQUBnqtBAO=AzAKckuuLZdHQdt6Z0dxPDxTdT1rpcV3JL5A@mail.gmail.com>
Subject: Re: [PATCH net v5 1/7] net: ip_gre: require CAP_NET_ADMIN in the
 device netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-298473-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFADE676FD4

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> A tunnel changelink() operates on at most two netns, dev_net(dev) and
> the tunnel link netns t->net. They differ once the device is created in
> or moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
>
> Add rtnl_dev_link_net_capable() next to rtnl_get_net_ns_capable() in
> net/core/rtnetlink.c. It requires CAP_NET_ADMIN in the link netns and is
> skipped when the link netns is dev_net(dev), where the rtnl path already
> checked it. The other patches in this series use the same helper.
>
> Gate ipgre_changelink() and erspan_changelink() with it, at the top of
> the op before any attribute is parsed, because the parsers update live
> tunnel fields first. ipgre_netlink_parms() sets t->collect_md before
> ip_tunnel_changelink() runs.
>
> Commit 8b484efd5cb4 ("ip6: vti: Use ip6_tnl.net in
> vti6_siocdevprivate().") added the same check on the ioctl path. This
> adds it on RTM_NEWLINK.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")

This tag looks wrong, the correct one should be

Fixes: b57708add314 ("gre: add x-netns support")

This also applies to erspan since it shared the code until
e1f8f78ffe985.


> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

The change itself looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


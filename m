Return-Path: <netdev+bounces-283656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPEsMWGb92lkjgIAu9opvQ
	(envelope-from <netdev+bounces-283656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:00:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DBE4B70F5
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 415AF3006792
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 19:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CEB346E43;
	Sun,  3 May 2026 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N75JM049"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF6B14AD20
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777834835; cv=pass; b=BO/GoCr93JJdM3kwXw2vC1ntVTHUC9A3ARBxGu3wtvbxNY4s6zKevb5Ll0aC6QY6zL5gzj8i1sy25+1W4C2CDyezHZoOG+gh8grEXLxH4U+RDprqaaYgDlvPhHPIUbcnpNRj2L5ECmXgRBQqsNX8MK5IoRIA8KiXme0e2FEtZVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777834835; c=relaxed/simple;
	bh=n2E82+vYR04y/YAhY6g0SptfGlT2uVOglqs1Hp01Fto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cK9TE1O03bQBDInu9nzuAHZF3WxFiLmW16yWrJ9naoaqEGw4PSeD3D+dQPoNzkLb/COHGC12NwyH+7EKGvd08N/shgNpGA+EDBRVN/eeK3ivnpX+qKGTCWHkzvQtC5qivK5IJw08oUjd0YbnFfbupc91uJ1n81JCfmIW/VTEIyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N75JM049; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12dfbcc0703so2250295c88.1
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 12:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777834834; cv=none;
        d=google.com; s=arc-20240605;
        b=GXwbKZIBdhmrpJAfC2tfOtjdhZCi7UwJGTCyDHe5Xn/nGVoPuN9JvmXUZ+dTWHcalO
         BFFnIDjoUsXuGe6J7wWl+lsnY8Mi6Ofgct5D1b6M+vmDVifKtNzMbUpoG9ihJyZUOejZ
         m74BnAI5pQQVPtmKfgkvG3WVgZwL1PXk0AaC0+UjJ2TF8Y+oFLyE1PPSsbjbXnHYlO6T
         grED6CtWOI/erZHrxvEuJNoGB0oBKJIzUgBpCVZz4PSJCQKl3tOEK9ElKXlwzffek3oM
         xORPThXgm81PNzvTgSQ+XeeT3EasSpaMtbTguiYRD+E9qkJmuFGA9Q5meqRYAyNf7VPt
         fNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bOzpuHzAmSny6CPtqub6UgNCy2+WRTWlu+qW1EwWqEA=;
        fh=oKPhmwvqneTVACDkIuFhnOS1RNIXMgdZOhdviXqVcKQ=;
        b=UNjt8gTq6aFXoz8pFBiQ7dQWyjSCQmuSIe4MGoiiwP6TdKqlq76nCd3K8a1oqAWoVn
         GMDUBIv/sPRzyrpjlOS4083Us5AfAbvNPZU6dHQandLtZ2f+jre9Fqz7P3iPFPMoG5sN
         VFAxXGMyk0MUlYtfRRuyepIZQVoTAb9qRB5lpaCyH13dGNOdFSeVDo/Ojny5iIrEsuai
         d/DBR76kW0lg3QnCpqZ3soXPkVcuj04M9uh8G4No9HzyRDnDtNd0rzzmvbWzNHI0YzmE
         uXSjQ7Murg9DyQ1MNtJX0Tf5Og30lMvBUf3q9IL8iJr53eZwwMj0QFkCNCUSHV/e1g0l
         tjHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777834834; x=1778439634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOzpuHzAmSny6CPtqub6UgNCy2+WRTWlu+qW1EwWqEA=;
        b=N75JM049OYiNrvo6SZPFuano9DXED8m5W9m1B+uo2tWgxN6IUbQAr5AiV4f9ns6baP
         zUkce6a2vmgY3OL7aZh27Jebm0z+ukdhhJ+tAZtPWWmkOhZe+HPDEA79Wu0dSq1cgp1O
         0qXQsXBn4+OB8Um55ZQmZSqoDnxccTM1GIZ9pkmx88felOK9z+yraZRMr3HrfCDzki15
         oc+Fom85BvKgr4lh1bGaF2ZDHJ1uLkJ8F1oFPMHlRmAcOGoxbO7Mb9Lhd1ihWsCOlNQU
         lgQbPo4dUd3n+W+5XRn3lAp7+kO0MTKZYqoadGupok6BxgYCwDqiHTiXsWWPMH7Ck3x8
         2S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777834834; x=1778439634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bOzpuHzAmSny6CPtqub6UgNCy2+WRTWlu+qW1EwWqEA=;
        b=WXX9IFb8AviedwpRCFFFL5rZkYTg7g3SMHnvXn1+f1CSWIyesPsbQyBJTPI/YkBA95
         xICWi9bpZDrf+WivyHW79ePmJ+4/xLQRG2d9e9UGMq/r64nBobRHb7JKWp2GCt8FrQIn
         AvY6ONnhfLYuVa/xo6QUlmowuZZlCknkPqbphaApAizIdX36t3fzApQKcCV7lES00zM4
         dqFa/WSdAmqOAiwfk7u0PXtGrHoEvIbIk/tF5O+xlH3ZQ+iZy5OcwMi1eKCcyDo9TBX7
         25I8N6c+CiQvo+C5rcJU4UXGkrzdCs0wr79Q0Wgw+Y55QNatd1WsrOjJkBWl28Ce+EvW
         gFdw==
X-Forwarded-Encrypted: i=1; AFNElJ+YNeymCgqStaDljfRR4mqzJ54smU2FD6nSO5+Co3H4wfBK1mSui2L9AzIp0wrOcHS8FPZJN2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mu8QJXMuGw49EtTRh5vjRSV5ksgffP/gana/jsAVYqhDKKi2
	4+5ZKujdHUU8lWdS3aporSo+1rS/fwW5kXsUyPiZnpu4Ufdy8z4qnVuhjKe0qEcsd9Cjk8thknf
	4Bm8RvOn1OYmc9m5Xii4fgutWZjVsiFW7cgHwwFjD
X-Gm-Gg: AeBDiesztMipeI78nyLeFkhzrcDBMe1joJb8fESXScXcwuK3WVuGQ+bz7H3SbvrzT7T
	vIK2uj9nwAdfPvJ7lzRT/Lnxb3nfJlaeoSA7EGhrRQacwDhstVhYloHF4Gz6kGbmskYmhvir5cy
	AZf+anqU0H7DFuyEL2Vuit6KSzee+/f4BQ4rn3xcldgEHKfHlPlCk2v+0eXnLjkVyo8C/qPsvc2
	eROWVFQYBME8+00ApEtU3VO4iF1NYtKQEz7T54bvMTfOp4iGuq63WVZBKELiIcqwzwrDn/HMcc8
	NwRRou0mJloZAISfUaKBCJlQ6V7aPKGF42Ydrv15tgJ23tBZE7LHCj/UWHvoHemVozApMD4+aic
	ZPnY9lO3f61uIdBAr3jupFjUxI/KsYReYlAmBk2VX35siyGVct94wnjDeVw6goaNhu0EjMGIrWA
	==
X-Received: by 2002:a05:7022:660c:b0:12d:b993:c68f with SMTP id
 a92af1059eb24-12dfd7a0f5cmr3276827c88.4.1777834833155; Sun, 03 May 2026
 12:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com> <20260502031401.3557229-14-kuniyu@google.com>
In-Reply-To: <20260502031401.3557229-14-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 3 May 2026 12:00:22 -0700
X-Gm-Features: AVHnY4KVPKyXkjtq4C5TjErIEvXpxKiJIZLvauyOtyrVlcFvFrrA-jGRz0WLFPU
Message-ID: <CAAVpQUDG6UudwWGHSeJaOy+m9cm5hAQBCc0cJVWiA4jvbm2BVg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/15] pfcp: Store struct sock in struct pfcp_dev.
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 25DBE4B70F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283656-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

For Sashiko review:

On Fri, May 1, 2026 at 8:14=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
[...]
>  static int pfcp_newlink(struct net_device *dev,
> @@ -216,6 +216,7 @@ static int pfcp_newlink(struct net_device *dev,
>
>  exit_del_pfcp_sock:
>         pfcp_del_sock(pfcp);
> +       synchronize_rcu();
>  exit_err:
>         pfcp->net =3D NULL;
>         return err;

---8<---
If register_netdevice() fails after successfully invoking the driver's
ndo_init callback, the network core error rollback path executes the
ndo_uninit callback, which maps to pfcp_dev_uninit().
pfcp_dev_uninit() safely calls pfcp_del_sock(), which releases the
socket and sets pfcp->sk =3D NULL.
When register_netdevice() propagates the error back, this error handling
path unconditionally jumps to exit_del_pfcp_sock and calls pfcp_del_sock()
a second time.
Since pfcp_del_sock() lacks a NULL pointer check, it passes the now-NULL
pfcp->sk to udp_tunnel_sock_release(), which unconditionally dereferences
it:
net/ipv4/udp_tunnel_core.c:udp_tunnel_sock_release() {
struct socket *sock =3D sk->sk_socket;
...
}
Can this result in a NULL pointer dereference in this error path? Would it
make sense to add a check like 'if (!pfcp->sk) return;' inside
pfcp_del_sock() to handle this safely?
---8<---

This is pre-existing issue too.


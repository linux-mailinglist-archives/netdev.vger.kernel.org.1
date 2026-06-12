Return-Path: <netdev+bounces-298680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4V6bDjoRLGo4KwQAu9opvQ
	(envelope-from <netdev+bounces-298680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:01:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0457667A097
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:01:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Uvzkse3t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298680-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298680-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26B4930D6CEB
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3170B33D4EE;
	Fri, 12 Jun 2026 13:58:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E414357D08
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:58:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272699; cv=pass; b=Vhg25WWPInIMLT3lCG6VIx+PzhNnEvl/5pJqsocVWqY6NhqNRR6ua7OiYZim3lKW+y1IDvl+ECGmfrgAYwGKODwp07hVzmzaIYbeQ/jT2kaTLGqA47d3TuVFoKfthVPl6eIGDZU1A0s/1iVw/38+APpksvYRkIdDwnNZd3IVg5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272699; c=relaxed/simple;
	bh=7nkmyuk+mVPRHuMjba29kjsd8mvWEce3DORmTPAygTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhwTFYAOun5BgYu3DdB3MrX6Q1yPKUNDWHHm1IUFEifNjtgQHZ/33pyQ9iTBPMJ8gIgIwjECApfhpYG6fGOoxUQvVPPNo3waVY0gSxiPM7nG0J9GebjrEaxENjGzfP0mc6UhCZ0MJMds18lkhz7OEsj99v2LlBT6bCujer6/qkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uvzkse3t; arc=pass smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423610ec93so883178b3a.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:58:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781272695; cv=none;
        d=google.com; s=arc-20240605;
        b=aMvGJYj/4Ggg/rOSsADYyNiFF1lIu7FPV4WObIfzlfZJR8fS0hbF2V/KvfVYRn2rYx
         NymkDE9StOCW23/QA+1r9dFMEBEHDKq+dnOjcO0tKXLbQ/1rZ+BSZLcmoT8a7rnK2sxZ
         cqe1Xf5HfoNXo6hyEFNheotDrO/qE1aLITmhaF9eQJgd4ros6EOhBSQkwa6wsXH7tkJ4
         lVyGpwumRBmW2+tRhgMpXkOOa5f9LMpTeAA+gVpSLgiKdFxENtSobNWHIcMZ1Mz1EVLG
         /Jsk84GE6GNfQdtbqjRYnvK5jdHXyaZC5PlCFduZUiB2scZUCK7/8aCWPLLMI4P0Em4X
         uPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=39JwziAVEtMY+TsSm//5hIngMfgIk9ci79M8m9H/nTI=;
        fh=WojKv4wyNATTxSM4MNpvI2bIZ1cH9NeKYG+8134alPo=;
        b=ctC3QE/teE+ieXVOxGU1kf1ryHpSg3noBhhaNf38hPT2fzc49zUWja1MuSf9uu1ub6
         F8VnqWdN5PSHPHAZAlLt88RVwRNubuQRzVWiBGTe3psA3QK1789l+j6L/VzVjtdD8F5b
         GrUrRa5m5LLAQlW+jKpYGunyJ7uZxHi65hlcnijvwt/wonyJVHsSqaRWIXLDbrm+Fo4+
         Nr60MUS3FPZlAON1k5f0QtvTKFUrPNPiICEghEUIqTwT38VzEOme354wjIi9XyRqA2eg
         Zn46V7QbeRnBqPZ2Rlpp3EzI85HfHpUsyGo7uzcSDsSShaKW0FxuRqL93a+JBqCSoKgp
         bv2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781272695; x=1781877495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39JwziAVEtMY+TsSm//5hIngMfgIk9ci79M8m9H/nTI=;
        b=Uvzkse3t6M4ckXfvjk3Dlo+4IHwe/pS0AIOu8/D+u+EsH6RRqbZK4F3nKFv14I28wv
         fOzP/Dz6vHuorsA61dOZmcxHvuJvsRKcD+Xz9wtEk/eON7HDutc/89yuaz9NQGiVbh0O
         cUpTyYdxv5ysumMmoIOmtcERqvU24+GH4qL0X1cyKY8oBJTbcCu2VpZuhauxdKa9KPta
         NQNF8SWIB72XYi/iErktdgmEucuKSCHk8hWn4edjStKc1SKiB194WIbGTS6LRS5PMlR7
         GA5uy1f8H5FVasaUoC+HpGSbQuIacUqk95e8echa8+OREBWN6aa+N/HTMoKdXYoZ8vnT
         fDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272695; x=1781877495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=39JwziAVEtMY+TsSm//5hIngMfgIk9ci79M8m9H/nTI=;
        b=rWwNjXhEeQ4YbtZw6GHteWBGiXwTwW57iMRbJ182yxdwkY7h6fu087NiEzKN8Ilrrt
         E3FQZVqNoosQNUaRQprw0lTolFp0gfEKe5jIFhaaT1NUHuoPtEweeETOSDDWA2m0m1xT
         9MWAGr/PmXQT0azTg+l6d2CBCUbe9+hZanEqrvzBDYNDnXPL3WEtv+yr2aFochEJdBWN
         xnTEZ8n4jJ5K03s88zdFoNya3Ueq26a3SMfgtg6ne4DnHyxgdFAJOQmbazuMq8vmNmqK
         pRHbhbbj53M1SU/znF1J/5i5UrF1puhqGbrHY3B7zJeT+omm+/ghAuWkbRk1W2KtwlH7
         FFfg==
X-Forwarded-Encrypted: i=1; AFNElJ/TdcdnsjCWYqKbuWYdeB3x3sg57VdL9lU8kC7wWgL/Pu14j+G7UZsFFG4UXLyCkIKrDkr1eoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoR8vxiBAsgrzCds6FGNMkOAa7xqb593PsN3IQQJ/MP4BY8Q9z
	L9/lwhkLNt72ajPJifqpvQCuaQqF4yPemNxD5jxetufnKTmC4pI+QGl77jbDtnVMftQ9Zloj09I
	RnoLH2BCjTfk7F1pAf3Aey2Ge03dv4XI=
X-Gm-Gg: Acq92OHbk4eX0/evzXtvtuZ5EPTOPjY+pEQtSXJtpnfhVs2lwJ5Z9IovAbsl4BijOIx
	ByCZn8WXz5EcaK7K0Wiv4WdTxFp0K3YpwxO+4ok5jU2JL9Dt16v7x1sBufsWJFdWXwK/caNyw/1
	D3goKXBRdvyJmCj3SHlmwZudGGh/VZjRsNrausowa1JcYLVDMwsrl43PRvxuzDUpmOF2Fzul8A2
	cjQtp+TeKqovyb/LRtUBi/q8qOFtkObapgs5qfKdg34KF2YXr0viH060bUgG1ZEL/4+S/DY0I3u
	kM7Kcxc0nQfIWS2lqJFbzdV0YVBsCBW+dyIbdsb0jzrFekIb8qKIGhH3H+4M/1YfmzYgmv9EUgG
	i2HMOF+2jy4HpZNrb
X-Received: by 2002:a05:6a00:1884:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-8434cc0b172mr3363582b3a.13.1781272694689; Fri, 12 Jun 2026
 06:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612012530.7889-1-vulab@iscas.ac.cn>
In-Reply-To: <20260612012530.7889-1-vulab@iscas.ac.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 12 Jun 2026 09:58:03 -0400
X-Gm-Features: AVVi8CdGRRqHLxpu5pXSGqJ6sSUoP3MuudWkexvLo07GnoDx744Nx0AV02fwFSE
Message-ID: <CADvbK_fTdr7rtwK7jgO8wveVptnAK=JhBr_L+d7NaDv-6td6DQ@mail.gmail.com>
Subject: Re: [PATCH] sctp: auth: fix inconsistent key release in
 sctp_auth_set_key error path
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298680-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0457667A097

On Thu, Jun 11, 2026 at 9:25=E2=80=AFPM WenTao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> When sctp_auth_create_key() fails in sctp_auth_set_key(), the newly
> allocated shared key was freed via kfree() instead of the proper
> refcount-aware helper sctp_auth_shkey_release(). While both are
> functionally equivalent in this specific error path (cur_key->key is
> NULL, refcnt is 1, and the key is not yet shared), using kfree()
> bypasses the refcount abstraction and creates a latent bug if the
> code is later reordered (e.g. cur_key->key set before the allocation
> check). All other error and success paths in this function correctly
> use sctp_auth_shkey_release().
>
> Cc: stable@vger.kernel.org
> Fixes: 1b1e0bc99474 ("sctp: add refcnt support for sh_key")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  net/sctp/auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/auth.c b/net/sctp/auth.c
> index be9782760f50..84708f87392f 100644
> --- a/net/sctp/auth.c
> +++ b/net/sctp/auth.c
> @@ -753,7 +753,7 @@ int sctp_auth_set_key(struct sctp_endpoint *ep,
>         /* Create a new key data based on the info passed in */
>         key =3D sctp_auth_create_key(auth_key->sca_keylength, GFP_KERNEL)=
;
>         if (!key) {
> -               kfree(cur_key);
> +               sctp_auth_shkey_release(cur_key);
>                 return -ENOMEM;
>         }
>
> --
> 2.50.1 (Apple Git-155)
>
This is more of a defensive programming change, so please target it to
net-next and may drop the =E2=80=9CFixes=E2=80=9D tag.

Thanks.


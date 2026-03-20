Return-Path: <netdev+bounces-269794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WeKbLmXhvGlu4AIAu9opvQ
	(envelope-from <netdev+bounces-269794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:55:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEBF2D60F5
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F7403038512
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 05:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4E031AAB8;
	Fri, 20 Mar 2026 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XsriI4QE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787832F3600
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773986145; cv=pass; b=lxWQ9126S63V4U2YXn456bzh8L/e7JMEqDJIqgzfI42DJuskI3+da0zM5pWAs0l29tX8TmsWnX6yX9xmPZL1PF2mphj4iC3/9WNPpVsdKjMJhGM1JLRXwdeKfWobi4C6Ok9KIrPxNAecHZTVFOnK7LKV5OEvYwS7Bgiz7WBBU0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773986145; c=relaxed/simple;
	bh=oCgtRbRk9MYu+izrc0OkdjmcYDPKaoAFmclfY77q4Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYuAY2G1TnVYHFp0qV+cb5bVTS4BY2GaRGbwBL99d9VZcbv8wCKdNMrPgfpQBFC871M25njbnxU4JTMePsxP3GIZIkLem79kBT7+G15iNlYQU6MkbhRKMJnlMZy2NXYNApPe91Mgrp1yh3YwkIa4lSLszIPulOBfPiUL3jdUqMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XsriI4QE; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5091ed02c54so236231cf.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 22:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773986143; cv=none;
        d=google.com; s=arc-20240605;
        b=bgw+jfq1jGFm+XBgWiku1YtthPVYgCVZ/0Lc91K1PjQTUXHa14ZifRzF1LmG2lWBB1
         7SZI/THu2UjevyBSHDOrdo3HrEdPXcFEJkYC9tLOpiZAsEFeFvnNPhD0mQ7vc9ZRpmNI
         Eo1Jx0jHEhZppbagiCuUDalJFGERVlE8BjvdxmFYSUSOF6Buh7/UG4yyH70awdPwFW9s
         9h5JNewa1A4YNva3IUfd6iyhZNRx5iiWcpNhXMzYZ6wRizeOJI/MEj+VXG5vtfO8jFeD
         cZrkKYx7BW3CjAA1mYeEnROa0uw52Fjc/klPApewO+hWtPJJq+bfU3hMb817GIEWu6ht
         Qy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3xIgPbLcoKc5TWnRnYeKBSff9C2c6gGrDbCryr89sY0=;
        fh=tKvEXYLI2q7cUoa9NFBJbqHLT3DO1DPUh22psi/SgLE=;
        b=frBLbW+5CAaCpIWVhiqvG4tGJExW2aWLuErZdRp9Qog/b7zo9ufd1rgyjZ7FxQ1i4e
         Pdf75sun+F2sERuBNDjeJ1WI0N+8x9KDZegci2feJocgszIgyTha49Vl+q5DGd1QfaYt
         fhEBL8n9m1i5RmqfE6SLP7gmP/ZotCDfs7l6gv5WDGNWphOoFrvXfmtqiBByIR0ocz8v
         UqiXfnJsebK8sEMqt88dvxIeSxOqNXefp4cNmF1G5oGioAKMaxvLkUjilZ7U4Q7jGefp
         sKKXWzJYxYUV1s92hfCCxYwElKLoYBE537IjHZN/KwnslfjfhpC6ygo18l9znF9+WnSX
         cdxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773986143; x=1774590943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xIgPbLcoKc5TWnRnYeKBSff9C2c6gGrDbCryr89sY0=;
        b=XsriI4QE1Qm9//5gYTVEFG9osnqtnpW4fm0IOP51bq891wlqNaYdaMUQJnaiXrpxyT
         KKDj3Y7ZRYkem4NjYtHPbglrEenjbhfArNyVzbSR7fNZMd+nO0Y/N1flwDWcyEYZBZ8e
         NJ1on0mXQ7DgHM1nX6IWscut2peitUYonBUEuhY5Blxgo7v0WtV+ttIstAIZfq3cHSij
         vORy1mwMJaEmMNBOIQtveJcGyIwwWC8vJM0vKaYJNiR4Q/iEVUVXH1XFJ938gVJ7fx13
         NaGYArWdMqZ2MccQ6piU7YZYp6H0sFsMO7xBR6RrnirtO6h2wTphoJfRXrNTqxNQyXqm
         AiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773986143; x=1774590943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xIgPbLcoKc5TWnRnYeKBSff9C2c6gGrDbCryr89sY0=;
        b=SA+xwmdvRPfn09hlyvGLUgbSC3271rW57CGHGEMRhi/3FGhj0neiExkGMcDRCBxxFb
         BAVyzIMr+sS+AiWYoE51Vom6J6fSFGqApnHIsGJlsJaSQXFw82RFVSSTQJuqMciXVjye
         6euGLBAE1nme6RSg00lEfXEYb8V3WxM+XcbLe1VYke989ZYLkkofe9GlqvAwu+mh3G+7
         JkY7Bz51DtPdNu8DzuhHSJY5vjV0KWQ7ui2o1Mx9xrDTPuRmdDY8o+t0+dhEFbWvitbm
         5fFMJCm3r+2Q+ovcnkklvGBgp95FP7996sUIkewYWTnaFwxSM2iF14Bn/1Vg5ZOpzhNJ
         L8MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmMSB+WwAE+kfwNsAEdHQH5/dHI+TcSNyCisU9HsU0BLHebzYMywOBUYD33xZRPtUsnyTiz6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE33kjGpC4YiA3SbzeBfFmyf4BOOUL8lJLfbxMPnWGitMSAX6U
	YLksWFQmyChEYB/unuTQPT501TO/q0ieY4YJpgy3QwBsjO5LEEyVNO5ng7ODZYgn3+oUo6BWaqC
	wk7uIS2STK5SSAhhDmUxe7C9kKPTllCQYuaI7h3wH
X-Gm-Gg: ATEYQzxWBDosck++19EnE/L4Pkk82gls7f0mkyd9cn9EwQtHXiE8fF/o96+v5t6vo6p
	5nY8s5GdHy7GGp+Uf/3o2/4XlTzyTLyGKv37f+QTaLZLThDPBZtk1CPXuUB+V8HmJs75WcXK+wz
	ycsQ6IUzHS42M0BGrJLea1UDiAAoz8g8DpQHihoXLRkB+ZQUmJCmBbYw8qciSniHX/HKraP5Tm2
	HSw2yJ4zWdyqeOtTJX6FPk82gqbimTcyXC3VJMrZBfyk1TtaTjCDw/L3WXR6UrqYv6C7GkRFSzQ
	kCG8PWaZ9ZIB5SuIUH1CTCpJcCcSw6HaRDE8C9g=
X-Received: by 2002:ac8:7e8b:0:b0:509:21ff:cd49 with SMTP id
 d75a77b69052e-50b371ca480mr10124371cf.4.1773986143143; Thu, 19 Mar 2026
 22:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617093620.12a9b539@kernel.org> <20260319222250.2588501-1-cmllamas@google.com>
In-Reply-To: <20260319222250.2588501-1-cmllamas@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 19 Mar 2026 22:55:30 -0700
X-Gm-Features: AaiRm53p3pib_DhQUkLEwJBbWTq_jR7XozX1Ko_yN1-kj99X_qDGMJCQot-eGWk
Message-ID: <CANP3RGc9STBO+dhOV=ghufm1Awn7=M=gK5GbQt4r4kp2WXG-cA@mail.gmail.com>
Subject: Re: [PATCH net v3] neighbour: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to RTM_GETNEIGH
To: Carlos Llamas <cmllamas@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, kernel-team@android.com, 
	Terence Tritton <ttritton@google.com>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Breno Leitao <leitao@debian.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269794-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maze@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.979];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email]
X-Rspamd-Queue-Id: 0EEBF2D60F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This didn't really slip through; rather, the netlink parsing code in
Android's net test is buggy and needs a rework...

On Thu, Mar 19, 2026 at 3:23=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> From: Maciej =C5=BBenczykowski <maze@google.com>
>
> without this Android's net test, available at:
>   https://cs.android.com/android/platform/superproject/main/+/main:kernel=
/tests/net/test/
> run via:
>   /...aosp-tests.../net/test/run_net_test.sh --builder neighbour_test.py
> fails with:
>   TypeError: NLMsgHdr requires a bytes object of length 16, got 4
>
> Fixes: 7e4975f7e7fb ("neighbour: fix neigh_dump_info() return value")
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> Tested-by: Carlos Llamas <cmllamas@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
> It seems like this fix slipped through the cracks, so I'm resending it.
>
> v3: Rebased on top of mainline and fixed the conflicts as v2 from Maciej
>     no longer applied cleanly. Verified the fix works as explained un
>     the commit message. Added tested and sob tags.
>
>  net/core/neighbour.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index c56a4e7bf790..bdee4cf110bd 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -3953,7 +3953,8 @@ static const struct rtnl_msg_handler neigh_rtnl_msg=
_handlers[] __initconst =3D {
>         {.msgtype =3D RTM_NEWNEIGH, .doit =3D neigh_add},
>         {.msgtype =3D RTM_DELNEIGH, .doit =3D neigh_delete},
>         {.msgtype =3D RTM_GETNEIGH, .doit =3D neigh_get, .dumpit =3D neig=
h_dump_info,
> -        .flags =3D RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED},
> +        .flags =3D RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED |
> +                 RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
>         {.msgtype =3D RTM_GETNEIGHTBL, .dumpit =3D neightbl_dump_info,
>          .flags =3D RTNL_FLAG_DUMP_UNLOCKED},
>         {.msgtype =3D RTM_SETNEIGHTBL, .doit =3D neightbl_set,
> --
> 2.53.0.1018.g2bb0e51243-goog
>


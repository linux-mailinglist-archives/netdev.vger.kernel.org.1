Return-Path: <netdev+bounces-298463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gqo4JPyeK2quAQQAu9opvQ
	(envelope-from <netdev+bounces-298463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:54:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 823BA676D1B
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:54:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=KlKb9gAK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298463-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298463-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D2EE300CF16
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 05:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646EB37EFE7;
	Fri, 12 Jun 2026 05:53:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D82236F0
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 05:53:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781243639; cv=pass; b=TRZTqTGJG4SwB5b5kjs7pXrNLnesZss+Ej/2mh/KE6WAL41QwKCYtCU7+TDA/xnDlqoy72WaaxL5FWB3dmv1pi3iHJokQnagqW3O2nBX4yITWal/7tHP2QZv4+X5UJpeVTZthsFYCLfqTBtwB0IBN1mR9WVqcsz6r3uqhHvhpSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781243639; c=relaxed/simple;
	bh=1vWL0BXeG0FSXQnsxbKIMJmpZgquuCn4Tk59McPRHfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDWgMfSObcqauT4IBEm6AI4aMDFSAbVApGzHrtPzBTLvdBlV7bS9KUG4Jp9RE3vglSgNOsUvwQXHj/tM8KkPZN3YM9GN8t02tgMRCYIv6FAY/Y/CSmcgkAW/da3QZgrmwFqjq4BkS5kDH2aKkCbFeIh+P4sP5K7Qb9btLdTefC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KlKb9gAK; arc=pass smtp.client-ip=209.85.222.172
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9159951f05aso71392785a.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 22:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781243637; cv=none;
        d=google.com; s=arc-20240605;
        b=Pp6jbD3I0tU4VwzS09tjEysypVOm0/MFE4za0EFd+8NdV9E+g5jcE/hvShTZcBpg2o
         G/PKGpjgeX7gytFuSxhQSzzBNjYO2KqRoT0+s15S9lfOZsTQ8wPF902D664RQqls3m18
         SjJqbFZ+3+d6QOjlZyMcbR+pAevyktslHczWSt8nwb88+xhARPDJF5CBenK7J6w0+TWp
         xQvO7eZVTPGewFfC/0npJE8BogfMnU74kDwN/mgnOhSA94/Ka98Gt4l78YwHHDuaxU3X
         fqPb+c3fO9I6clUXgmvjgStgJ5Tf/hKR6a21/3+qcNIS/jC9QSRpzjwpOHs97dRDKp3T
         xQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jim7VVCGySRECFhqXko5r4bOP/J+hPyEF0t7DCcEkPA=;
        fh=zLnOFLDiyCKpSgv0hEXgJd5urdrIco0kE7vIpvK98AE=;
        b=akn621eHImwXNSDVIcVK+s7BZjqKBV6Qqy//7IYTaizACgM5O9JjrP6km4wlDD1Re+
         vqIIjl7UM5wiDFt/BSfvAq1YwpyxGwZKkwjgDHVUrdYBtRsZHY1ZigXOlxRlDYTJ53M2
         nKJM+aFfnakIzCm+fhLZTvgYympuPH8syBbojwf4w++eWuv+MMKwaK9QU6OUGmQ9lOpj
         loHBOqBbbF4B3oAgVW0GOIA+XMIxp3Blif1a4w9bExFwecQka4Y6YkGRHkze7II6faOL
         lPTTJgV3BoHccTMD0fa+nStatiP1YGxmpx5rMEhWgY8VH9WyhtV2+vfUnfPrtQESawlT
         Cf2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781243637; x=1781848437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jim7VVCGySRECFhqXko5r4bOP/J+hPyEF0t7DCcEkPA=;
        b=KlKb9gAKCIOuOtHkuIN6cuYZT8jyh6j2e83kf/zW+qUIoMsSy/QGuHJYe8UjbHbO2u
         q1Efv3wiyHPbSO/zh7zes8CPv2fEmTgvXzlP/sUqtvoSxLXbdXRsdT1fThe5mrUhakcQ
         dN7KusyMYPOwji4v4WGy0cIkZ8SVI4sczFdeU8FyKj5e71RXExRwX7TuQjKH/f/oGOAY
         5UKwo/UKaxGMTG+Bfx8wvrYoWWvW05lxwVEnKsvgyqB9jV2kDTJEcR2HyPRJkDBgdCUo
         FVI94Z6im5lAcUZbabnFQiF1sKBDNQ1NA7hu/K/+NkOXhdRBwcA1/UKuA0GBPLAE/DDI
         WeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781243637; x=1781848437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jim7VVCGySRECFhqXko5r4bOP/J+hPyEF0t7DCcEkPA=;
        b=NL9scdHaMaJZ9Kg+TWXTWS7L5mP8DYIZyCCuJa/FkfJm7JoZEN7/VCaheukxX/SlGm
         x+q180C4xOuU5r6RMfYFMRLhotbofsJ879c7mh5rwUlpvleMldjqpmPFkiWpXTrxmDNg
         pEEJjUZ6/ZY55F5s+W6u/qLSHweljovdLzIMdV0+j9/9b5T4Lx2FZLL4H13k8ttwNelb
         347ttURWroymmXYCHhFFl60ycUae/SFE+BycqHW6iIAWSTjtosRhOxG0hyuHHauvHL+X
         TLJuAgsWB6WsQCVkuAT2DbJsyZSe2YZE7VBL/YBFd2YwyySzZvujqeBLzPMK+QZhk/6R
         5Itw==
X-Forwarded-Encrypted: i=1; AFNElJ+nteWUvg8BNeIb43jVivGVF4SJK3Y0sxHHigMyt46/FVswuJzbUZEUlJP2FkHc5XSO+8WadvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDXx+OBePkP5dNUmlHfOsemmTyP3piIydi2V7Tbv+1puNogSno
	kWATk3epNOYvODbk2QAuRt4CvgyGBaXjX1g4iv3l+sFoic5CAut/myLuVhmtGALBNLZzr5ZIIAt
	owObJLtoeMce1Qh//h3q/MjumSP5H2/pbNAtminRQ
X-Gm-Gg: Acq92OE2aTDKGNfFSiW0QUN8ve4NN13aIZ2LsB9ryCtABQAxc8XsvGojEIt0i86J/Kf
	9bzk7hnVVHlJu30cAeFzwLr7jRJtttCOoktLlcLFoqXniUbvFli8+j/WF+TGAL04IARvkz/Witr
	DP/PdjFggNJzb+uvwpNXfXsJt3GD162C5xIRXVNFoRLYh6lTvpWET5eXuGd9JvIqrEJfMBKQm8k
	SsOos7jPayFUGN+7jVQDJk/Eo2/xXhPyJfxcff5FRe2cpRmGVPGgS78RDH1hTI16pboIervpPxU
	wFsZ56pZNICsf0sJO8CxgoJu1Jrhrvmhyf3bR5LE2TYuczk/hsqUYPNYSN1PhJkR+TYVjTF/JXc
	I7tfV/xYbg8PdfNCrOAY=
X-Received: by 2002:a05:620a:4406:b0:915:9943:d760 with SMTP id
 af79cd13be357-9161bf6d7b6mr154634585a.43.1781243636400; Thu, 11 Jun 2026
 22:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612020941.12694-1-vulab@iscas.ac.cn>
In-Reply-To: <20260612020941.12694-1-vulab@iscas.ac.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 22:53:45 -0700
X-Gm-Features: AVVi8CfxgffmPJH6SaGYfAW8T6cMU8tQodJPSSvqbmPQBshWMh2lxfmQtVthhMQ
Message-ID: <CANn89iJVksVj+tnSgGFeWo9C1m7V6gM7pA_badBs6G5Z=GMO9Q@mail.gmail.com>
Subject: Re: [PATCH] net/xfrm: fix refcount leak in clone_policy()
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298463-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 823BA676D1B

On Thu, Jun 11, 2026 at 7:09=E2=80=AFPM WenTao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> In clone_policy(), xfrm_policy_alloc() initializes the refcount to 1
> and sets up the timer. If security_xfrm_policy_clone() fails, the error
> path uses kfree(newp) directly, bypassing the proper release through
> xfrm_pol_put(). This leaves the refcount unbalanced, triggering
> warnings if refcount debugging is enabled, and also skips
> xfrm_policy_destroy() which would clean up the timer.

Can you show us the warning?



>
> Replace the open-coded kfree() with xfrm_pol_put() so that when the
> refcount drops to zero xfrm_policy_destroy() performs the correct
> cleanup and frees the object.
>
> Cc: stable@vger.kernel.org
> Fixes: df71837d5024 ("[LSM-IPSec]: Security association restriction.")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  net/xfrm/xfrm_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index dd09d2063da2..3074692b4556 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -2421,7 +2421,7 @@ static struct xfrm_policy *clone_policy(const struc=
t xfrm_policy *old, int dir)
>                 newp->selector =3D old->selector;
>                 if (security_xfrm_policy_clone(old->security,
>                                                &newp->security)) {
> -                       kfree(newp);
> +                       xfrm_pol_put(newp);
>                         return NULL;  /* ENOMEM */
>                 }
>                 newp->lft =3D old->lft;
> --
> 2.50.1 (Apple Git-155)
>


Return-Path: <netdev+bounces-292378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAtlM1weF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:39:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C515E7E56
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6287308A95E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725DB43901E;
	Wed, 27 May 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="Wl2ijVMk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586AA3C5535
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899494; cv=pass; b=DV2Uot6nSQj7n21NzGfRyxvnjPf0f8uTeIXzhlTeUqiWUFcPIUPExWtkQlcsVHDjyLF1P1FFpSS4tQT8Uz0X4umBZU4v3nSwt/bl62n1S/ckKgmQBqAG0MaH8dLQE/tmg5ko/p+AFtdUT2T1lrU2KO3OLDkRhK/8D7U/texaL3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899494; c=relaxed/simple;
	bh=ZY7rgWI9XA+vyU0QAFA9/Bmy0Vi9PGZqL1JwLat115w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzgqyNJO3cL0qVgFsyHPGz6JThYGCTiWn/9gpYPUMp+34Pi+TG0JH52pdfQdogKbdsWRcNvbmt0hLZyjiJE/sVlI8Vg+D4LxhUvZxk04OByjzT98E6dt0aZtQ+5+z/wjmVdtQy3VKeqcaP2HaIi/TLEnZX38VeVy6xLZ1ZrqiGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=Wl2ijVMk; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36931e4f5e8so11091597a91.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779899488; cv=none;
        d=google.com; s=arc-20240605;
        b=hmdEO26dQRR1k+ER+tIBx6z7AG+QHzuGhNew2QH1T124Q+W1XXjDJd1EM3t9cKhyu1
         1aJwPY6wabBjz5OdyVTJZ5nHpO94Kx4b6zoZOnJo2goGbYsw1Fd7bxAEUnyTHJVHiSz4
         XzUyYlYPTeq4otNfWPgLWhpDlQhuFIJ/YgxULydm1X1UsjbX1W2hYPwlhDDi3nKrEXWT
         8oOpEAf8yZbkJrKI5dEBsehboa0mmUp7PQc3abdVEbJVxljRwtsperp74+QkZxHqSgxw
         VzKUjjYIPvlfl6lVfmPWJGQ4bBh4BBNg8HNvB7sxnmw2fkfK9kzS/nCl3UTasmhcdGhg
         487g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RnK3rUPxq8JPD6745RbPCi5d1YGGTd1FVgP59617C+Q=;
        fh=9fu6koHtNrXasDqcC2Ff8C6hxOV19pBy/H11UAgK7dI=;
        b=O0v6Y8DYPDy49aHirPQCIx2MgEIkTIWsczNr3glk1p6h4Q+CIZeuI1SrlA+ZfGvm1Y
         uoFM5M6wBBHfrsUd8NOGT149aLiqOWx3TC4RfeX1RGqtELgmLlOP1a1uM0JuifyD70IY
         Uxu+7GSQojU5dH3ZynrroP3nw4+c3SwjOPpUkZXP3zWp/Yj7CvbQrjHNfqLzzapten+C
         ScxWt74lhKhhrTg/lfmNGEzc4M5QLe6TZEGW7gQ1hRpvsCadlUIjIIwxultvQ1k7ElHU
         AkCHgFUrJqxZZnSY2VkKWv02Qs8wKnumZ1H61K9knT+Wg/WPWDU+EKfRGt7+T13otehv
         vTwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779899488; x=1780504288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnK3rUPxq8JPD6745RbPCi5d1YGGTd1FVgP59617C+Q=;
        b=Wl2ijVMkqaJebxHtEmboit9GPbMDqk8qODpSssWo7a6YycSN9h6DlE6A9AfebNR7so
         EfRiJv9nXLsnHoL6zkESxd0vVrgo9SsySRv+PFa+H6X8tGje/K1D5M3Ce84O3HZx8Nzi
         zeSfbppN/bDJgT0eDT3NjN191ZvpIk6sUS6l1SNN0s+aKg+zSVf0Fm7gDv6m+DlvtRMj
         9OYWNb907EB46XM+eYwZbC672UXxA+osFbtrGZvolCdHhT9a29NsgpUB6gjwhei2bu63
         uf0fcH7InAUAVwVTD6bTL90Z50FXJ5zONxlaV+HyPHXlStqGG83wP8w9hU6LuTL2J+il
         Q7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779899488; x=1780504288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RnK3rUPxq8JPD6745RbPCi5d1YGGTd1FVgP59617C+Q=;
        b=p3W+yA2pxowpGmzMvNYbTYLxqE1GKwi47IzOhILrJqRFXOhiOkanx1K5i88zlAo1qG
         3UHr+78rcBmH1/X5DOb+OxKLmpNFebMOcpubCLExoajKY00BvLqHBLSJ/8eBvUGQj9N2
         y0EergR+5RXo5vBTjap3C7WoGljdUzeN5XtkSqyM49jGrZJgNoQD0oV8dETkNdFQ6FuS
         bQk7RQ7+MxyIV/TNyOBhSj6bEOiUYldQnnUZOAc7Iz/+7oO/WidjQQZTXp352EcMAN9/
         CdN90uag5I7IIfVXYnJ1pFh4Bcn4+J8Hq2CexAUL6DWP7bbjT3Qhg7YUKOm5L9uEW6Ah
         1Bjw==
X-Forwarded-Encrypted: i=1; AFNElJ89ROBZufNVMu1PdFj74vNq2u2uDmsrmI/j1Gb++Mbm7mH7FljrDW6ky0PV2ED4+vPMnrzNa6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpxfhVhc3eT7oAP2540XiBPjCosbBupCDuyi36SwYJbFepsxP+
	3+znSzQtuYVwF80/KV3ueC5SoVjsSBA9HpPkw/L0Wu2lH0WoG4WQPrAN7v9rGkXB6kkC448dzd4
	/toqK321SWxpRnyY7tFir+/sdTdcanybZtfwic/iL
X-Gm-Gg: Acq92OG8F0MJ6fFCdIdMUBC3zYGaY9BzCFOvBWloE9cXGzTYLvQQWzCn7UCDaTlwIY6
	sE/Yk9DpIBy5X1fGxosAJSPo1ARE/qiyazf4fGKDeFaPOASV/q63WfE+Tu2yGLCa2YY+20wcuP9
	W0LCTJrwzTdmgBdNTIFMiF0nvOuFCCTJ1cVbpnm5yrNzxGts/isZnTlH3nzxBsy+qpnA1hTQBxe
	RHy/oZI+vf/qR7V6bGAnhw3AzKL+znB7qmehrQNnOK8z+qUHLVad7bDjzxH0JAEdqbgbbUgP1lD
	Esrp48SPPeu5C8pDkWU=
X-Received: by 2002:a17:90b:2e88:b0:369:a359:b18e with SMTP id
 98e67ed59e1d1-36a67449708mr22392702a91.9.1779899488267; Wed, 27 May 2026
 09:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526220847.28365-1-kylebot@openai.com>
In-Reply-To: <20260526220847.28365-1-kylebot@openai.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 27 May 2026 12:31:16 -0400
X-Gm-Features: AVHnY4KqnFYf15k44tGJLi2M3503cgZBYMeLKUZpV0HVdHQraRqFixVVV3H-hMA
Message-ID: <CAM0EoMnzOMPXcGO14B7nL9veOKEYWn-dwnWrExA6rPuMNC-55w@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_api: use mutex in tcf_idr_check_alloc
To: Kyle Zeng <kylebot@openai.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-292378-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,openai.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 30C515E7E56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 6:09=E2=80=AFPM Kyle Zeng <kylebot@openai.com> wrot=
e:
>
> Currently, the NEWTFILTER path uses RCU to guard action idr accesses whil=
e
> the DELTFILTER path uses mutex to guard action accesses. This
> inconsistency leads to a race condition scenario, which can lead to
> erroneous operations on refcount, eventually leading to use-after-free
> situation.
> In this patch, we revert the introduction of RCU back to mutex in the
> NEWFILTER path, which is consistent with the DELFILTER path, avoiding
> the race condition.
>
> Fixes: 4b55e86736d5 ("net/sched: act_api: rely on rcu in tcf_idr_check_al=
loc")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
>  net/sched/act_api.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 332fd9695e54..63841c3e4310 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -874,36 +874,34 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u=
32 *index,
>         u32 max;
>
>         if (*index) {
> -               rcu_read_lock();
> +               mutex_lock(&idrinfo->lock);
>                 p =3D idr_find(&idrinfo->action_idr, *index);
>
>                 if (IS_ERR(p)) {
>                         /* This means that another process allocated
>                          * index but did not assign the pointer yet.
>                          */
> -                       rcu_read_unlock();
> +                       mutex_unlock(&idrinfo->lock);
>                         return -EAGAIN;
>                 }
>
>                 if (!p) {
>                         /* Empty slot, try to allocate it */
>                         max =3D *index;
> -                       rcu_read_unlock();
> +                       mutex_unlock(&idrinfo->lock);
>                         goto new;
>                 }
>
>                 if (!refcount_inc_not_zero(&p->tcfa_refcnt)) {
>                         /* Action was deleted in parallel */
> -                       rcu_read_unlock();
> +                       mutex_unlock(&idrinfo->lock);
>                         return -EAGAIN;
>                 }
>
>                 if (bind)
>                         atomic_inc(&p->tcfa_bindcnt);
>                 *a =3D p;
> -
> -               rcu_read_unlock();
> -
> +               mutex_unlock(&idrinfo->lock);
>                 return 1;
>         } else {
>                 /* Find a slot */
> --
> 2.54.0
>


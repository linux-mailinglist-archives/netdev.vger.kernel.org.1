Return-Path: <netdev+bounces-260893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEiGMUfanmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:17:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 686DA196575
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0888300B9E3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2EF39446D;
	Wed, 25 Feb 2026 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHb6Zyci";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s8sBnDFz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2689393DE2
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018244; cv=pass; b=qP/x4PCu12Ge1Bwj2o6lcqN2F6NOgwj+7Vrdn3wsXoaURM1UCXnY3Gzj3eol6uYnhiUVqAe4VRoEZkkWzz4wF6JcAXWQ06afyBApXhUYcnRi4xJ3AMsfhYyrqbgdMiMCAsaIg9e6SwJGqIgDt0I6FXwuaZE/c6qdvk95MYky4yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018244; c=relaxed/simple;
	bh=ScjPGYvbF+x5M24+r2PbaTr+5ESRsrvbiRntSZp43hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGhKsA79t7c6H1DCli8mwxz6Pnyl4aDY0pQBRW3YfsdsCJzXZUDH95q2ZN8igPPmAg7M/corqrtmcXfu7YaVuSmjrrUp0MWnmgyuuccBp4EeYbMxDKyGwQNx31l+mDsqTiPu7N1JbuXY6X8FrLkoGtvcOY2RVNa5PHDN4QWBJBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHb6Zyci; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s8sBnDFz; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772018239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJAgujioq3EwE7o85/KGFLew4sjYqJsiovhiUlVgoug=;
	b=gHb6ZycieLP+DLYomClFNWm3T5kdcqjby+2DZK1h1Qr6JIiB98HYRkfceRfMkf9qWBfRV7
	tOltL79blFGK7JMwX8R83NLkxub4D9lCnQ4kpXWWYX8tqZRQpBjlhoAjc0a1Jl9GiwcZU2
	vfjKumaWqsMkqgaU1CClnSBtG/wOPyw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-68cw35r1MOiAGcAQyg7nLg-1; Wed, 25 Feb 2026 06:17:18 -0500
X-MC-Unique: 68cw35r1MOiAGcAQyg7nLg-1
X-Mimecast-MFC-AGG-ID: 68cw35r1MOiAGcAQyg7nLg_1772018238
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4c4703b70so8911237a34.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 03:17:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772018237; cv=none;
        d=google.com; s=arc-20240605;
        b=eiQwBuyrqMw8SRHyvPSkV41yjbJCxLebFMHCnYdPf9bNqAh3ZpeWb9mUYjBbbY0Vsw
         gt1p/BEhM0qoDH5mM7eyGqUO64pwjOjrm4ONvb5G9aAiKTRdw/hSjqGeVJX4zqNdI/KC
         VaxikqUaO52av14GluzP/KJDe9oLlDRzI/fy8NA6o1q5lSV6ZPs4VlV1v8limgECyLkm
         aSAmPNcfOLJWrKo2Uf5XVEE5LOFRtrjsdDHVUt6hJag4rHZ53c5OTEm9eo3Qx2gsK1aG
         GmYfq8SggKW7hRrpCQMi+roZfWqI3gk71xEEGtVYyoFyM6qqFxXOcY0g5rBt6zhgMl7I
         Lz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJAgujioq3EwE7o85/KGFLew4sjYqJsiovhiUlVgoug=;
        fh=76QHNLH66v09C9VuSHP7cHrVjg8xjUM99GOAsdSAttA=;
        b=OISQD5sANy1XJ3YATY5QQREqO55ZIk/b92xi1fGn5p2OH2QKCI99BMbF1rw3omro+W
         6gVIj/BFtdUMsGByplkip4YAhpmQJ8WyKA6yxK1bZitvWmyf39hfX/Q4D16nHuAh4MvV
         f08CAC/lO8pTKZn4E1vlVq9A+2+KY/h8QJfOYisgl3bajE521EkDtxmXc2vdoCGmHwir
         cIiVy3a10porVYtAJqFUrqAlo8m1h/j9FvKz5OWV9dSB92/PUB9zrJmQPjg5Q6HE1A0m
         1asJszWvsUaboRs3J9cE45nMGEqqu/eB8g/IC+8mq0YV26PYcPmjdZU0E5MqI9utcA5T
         lMCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772018237; x=1772623037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJAgujioq3EwE7o85/KGFLew4sjYqJsiovhiUlVgoug=;
        b=s8sBnDFz6RbFMvgoybsH9obAsBErCSPby27r4mesZesfow3ikXlVmNfX8sfXFgTIgV
         YZ9eriXoJOKFqbtprPlzbTnTb+YnoZY2hEJnyBD2P77WDSvCE6+XIIOc+QtFHMSWwfB+
         OZbWD1hL3Vb17AfVLnY6g+IvDltrMgVhMgc+tUDJyh39Ktk2RRl6TIfvehSrZDOY0xGT
         84llGn0cTrawttfHmAwF5m4zIbhJUA2oQRWOpU7MYc9MbA3BG3eQMKYapWKjaCeMbP8c
         TT5z0O8D1cH4HJ7qxF8LabWOI73rem7XNpby92PP9bMzpEmsV+qXhfEj+nsHGROgL2Jf
         uGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772018237; x=1772623037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJAgujioq3EwE7o85/KGFLew4sjYqJsiovhiUlVgoug=;
        b=WV7xOoPVgKw+Slkv6/H53TqBhEkdul0bwRGiyFAgGe6yLIuRfdlyGE9VFpqGP1QV+F
         0J79dCRoxbrndiUnKhECoq6uiaeatnk8yR+jnC+pShS9MwR8XpTLIutDi+NBKfeqWR8k
         xpbakaweI++DQq1eWqTIDIdbbRS/TbVr8Mt+RmV0gmP8omr1ntqQxtB1xe5Z7qlfU6ag
         q/Vlr7HVqYVNR1VuyyE6pf1C/gH0CACUwArNCzsFFKXqBc9l/usD/CW6bYboHCk203Mz
         ywAzAj60uY/Zf3Sh578MmWNmSxI/RWo1CjnnHxi07rh0Z+HaDhiJACrd41XyDE2+eyjf
         Dqcg==
X-Gm-Message-State: AOJu0Yzv2SjPwE5d1p8RTLw44aguCnOghSiCnAB6shfFvDyo0EV3Jd7U
	k66UG2eHbp3+89lX9KF83isfS3AWaoToYhw0rb3UA+oixcY9dA/nm8xPWUcZSMwM1aB5Mq98ffI
	PCQ8IWu6UAtNnlCJw7BcjILIwoAUJ34UZDlJt82G1K+JqbpRR98BxU7M9B8TmH3/+LCeITVddE2
	IggmDF8h+brNZd01baZ1fgsUB8Z5dP1f0z
X-Gm-Gg: ATEYQzwuH0HpARhPObEpwugYcZd4KDjh0MhwmF+U9ps2rea7u8r5w9HUNERFQGeEqyD
	x4woagM6gcaFn7RM7c7iGiKd2ojpuONSK6/yEAxEGUFaCTPMgPX0tCTH6CF2vw0ODOHjqEIXF55
	Sq6mF2hMLnLNpfAXb6LRnbpPM3VgV8VFTyBgIyUrzxpgJBXB1ZkrQO3/j4KSuPRbTb+VtY7x3Rh
	uysuw==
X-Received: by 2002:a05:6830:268f:b0:7cf:d108:65f with SMTP id 46e09a7af769-7d52be03c9bmr8085253a34.2.1772018237683;
        Wed, 25 Feb 2026 03:17:17 -0800 (PST)
X-Received: by 2002:a05:6830:268f:b0:7cf:d108:65f with SMTP id
 46e09a7af769-7d52be03c9bmr8085246a34.2.1772018237391; Wed, 25 Feb 2026
 03:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225100137.383527-1-poros@redhat.com>
In-Reply-To: <20260225100137.383527-1-poros@redhat.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 25 Feb 2026 12:17:05 +0100
X-Gm-Features: AaiRm50bofXry4bxFntonEhNYGGknNqMfZsgOM_LWk9I1qmKjhrgXGt_4R_ORqo
Message-ID: <CADEbmW2WNCLuRYVs5FTKR6GR16yOMmQGyg0vYR98SQCCwb_5HA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] iavf: fix VLAN filter lost on
 add/delete race
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Eric Dumazet <edumazet@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260893-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mschmidt@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 686DA196575
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:02=E2=80=AFAM Petr Oros <poros@redhat.com> wrote=
:
>
> When iavf_add_vlan() finds an existing filter in IAVF_VLAN_REMOVE
> state, it transitions the filter to IAVF_VLAN_ACTIVE assuming the
> pending delete can simply be cancelled. However, there is no guarantee
> that iavf_del_vlans() has not already processed the delete AQ request
> and removed the filter from the PF. In that case the filter remains in
> the driver's list as IAVF_VLAN_ACTIVE but is no longer programmed on
> the NIC. Since iavf_add_vlans() only picks up filters in
> IAVF_VLAN_ADD state, the filter is never re-added, and spoof checking
> drops all traffic for that VLAN.
>
>   CPU0                       CPU1                     Workqueue
>   ----                       ----                     ---------
>   iavf_del_vlan(vlan 100)
>     f->state =3D REMOVE
>     schedule AQ_DEL_VLAN
>                              iavf_add_vlan(vlan 100)
>                                f->state =3D ACTIVE
>                                                       iavf_del_vlans()
>                                                         f is ACTIVE, skip
>                                                       iavf_add_vlans()
>                                                         f is ACTIVE, skip
>
>   Filter is ACTIVE in driver but absent from NIC.

I don't get it. If, as the diagram shows, iavf_del_vlans() skipped it,
then how does the filter become absent from NIC?

Michal

> Transition to IAVF_VLAN_ADD instead and schedule
> IAVF_FLAG_AQ_ADD_VLAN_FILTER so iavf_add_vlans() re-programs the
> filter.  A duplicate add is idempotent on the PF.
>
> Fixes: 0c0da0e95105 ("iavf: refactor VLAN filter states")
>
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/et=
hernet/intel/iavf/iavf_main.c
> index 4b0fc8f354bc90..6046b93c7f3472 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -782,10 +782,13 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter=
 *adapter,
>                 adapter->num_vlan_filters++;
>                 iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_VLAN_F=
ILTER);
>         } else if (f->state =3D=3D IAVF_VLAN_REMOVE) {
> -               /* IAVF_VLAN_REMOVE means that VLAN wasn't yet removed.
> -                * We can safely only change the state here.
> +               /* Re-add the filter since we cannot tell whether the
> +                * pending delete has already been processed by the PF.
> +                * A duplicate add is harmless.
>                  */
> -               f->state =3D IAVF_VLAN_ACTIVE;
> +               f->state =3D IAVF_VLAN_ADD;
> +               iavf_schedule_aq_request(adapter,
> +                                        IAVF_FLAG_AQ_ADD_VLAN_FILTER);
>         }
>
>  clearout:
> --
> 2.52.0
>



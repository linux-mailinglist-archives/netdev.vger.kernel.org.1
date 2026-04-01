Return-Path: <netdev+bounces-274265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDJXLGqRzWklfAYAu9opvQ
	(envelope-from <netdev+bounces-274265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:43:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D53380AE0
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB24E304E326
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 21:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C263C35E957;
	Wed,  1 Apr 2026 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVb0E7Nt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF437B3FE
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775079572; cv=pass; b=P0MNOfY2WHVaWwZMQdBIy9GM4tR7RmZWWoIYPQdaA8EHjnsZhb1yfrFBzvbcovS5uf4Yl/teFqe97koH1G8jHpfG4OljcTwzt/uJVoI5AjvLyqZmTugE18BZdXR4uF95VECGwLvazxLR46kKy/Hdg+eKCG5Ctz/Hta46NJZ3uTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775079572; c=relaxed/simple;
	bh=FiT91IWEcnRhOhL20y4Lm4/9AhqyJzDAZiNkB49pxjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHqWhVijBplxpUPOk8eScWBbK0jhdYqfR2rPH8ctpEWCaRM3Dcd8i04rP9w9NIW3kWEuCFELLq8lvyJHbJNQUeSwirFlntHWUux4BpSI6Zrmew1PruUiykMuGPTp94tuliBz78MHBbfQDl9IxdjmKZDGvuQ1GFE7GRw9eeZGCWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVb0E7Nt; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d7d68c202dso24980a34.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 14:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775079570; cv=none;
        d=google.com; s=arc-20240605;
        b=eeZlhOnsnSqb2zP8l0Ii2ULv1nmRlhn8DMzXr8Nflucms6Cr0bQTgQNFDLfi8uDjrn
         W2d38d61iNMAogZ8qGUEHzhFr1AXBBuyspPQEoh7yVBYGA02ZLwFf6fuuB+xt7/9XSqa
         h6oU9/LS8C3TUSQKw5FJYiZ/rdLph3EubSywqoe1UwjtQWzxdzRshHx3ML/YnCxWQjD3
         KOUVpxadJT9kA7bcnn3XnEJ9ho1I3wD+Ucp2hCw1UrDPsMzepOWy8B7+6yEkm+pcBFEP
         fS9ANcqD/5JovoFM9VufvYzYME5rDaESGLGXkAfXYQjhUO5psCMRUDzWL+JUywb0ZU0C
         I25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GU47svpajT6DPi//LYlQdguxn+UFERX4VXHYau9GbyY=;
        fh=H8c9WxbJiTCOeqRsgzc/2tlfc6S4phJdV26sywHRpr8=;
        b=ZLiQbK6HbsLZrSMugmSwKgKYeJwCL9+xNI0l+174W8XrRE6FpCraTh6WhhRztZ7OXG
         XCAfRnaBFtDQuEJgjvIUAovPqUB0+B3Cv8/ZQyhGv8oHRboNz5b/JsML7/z/BQ/GmD6V
         KTXCoU0lxG9BfsLehV+NSAX1jNLcQ8TDY2IGxl7YpSCLxljnAiDWPq87/ZK164TlUaHM
         0i5wRLSp2C+8YPDExTVRE+c5qfSnh9szLpsk2TltT85gmYnvmogrc7wrvZlyzD4kRAAg
         wc5DNCccX577kMPkn7Oqc7nkeBlEJaTlxOOb3ILcfsfjYSOBaAvxhdlXKZ4mSu141ueL
         X5qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775079570; x=1775684370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU47svpajT6DPi//LYlQdguxn+UFERX4VXHYau9GbyY=;
        b=GVb0E7Nt+iZRi1zN/q7L7C5hdVvNOHcLZ0+ZzLuWutEaPsxF6rWm2ECB159/rdHANX
         5b25HVsHCPPWejAG9v8v182t//BroOV5ZYx7knDJDkxBr3TsBK109jsvD1azohzYt8N4
         is5fzLO57bw7EYQ9vnfyWo2HodfuUHrH3rUkTbZ73gLnYogkmdgQ3kx1N7Sis/v2Jeyz
         DFslsxeLTRYMMKwh0/c+0YYuqWMkXnSl1rJKA9WP7MzbsJ/hMnbNZUtHkmFrFWEqyOTp
         5ZYLGkjIhWz0BGhcWOI92iJueDih0iEkHqQz7V/CCEwSjLkg6H8RNEC+OycQ7Mpu6k7O
         lRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775079570; x=1775684370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GU47svpajT6DPi//LYlQdguxn+UFERX4VXHYau9GbyY=;
        b=bnARN2ZoERrdV2o9q0dZUSryq5EDnRLU0AmtllMpORfF6cN2UOieqBYxIgfl3Cml55
         +0thlwKSObinoajwD5qP9lN7mJ9TUgzn581zo++FKaCVYWbHexRXP8d3IQ6soNEh2BFo
         DbzGCBL+QRYx4DbugrrQqNQrZwsTZHwPAkF8IKws1u4b/1xsB6KtaEqHYxNPkz7tCll6
         p+RVGZYB3Sd72TKGTbX0zhmvQIqDqTJ+GzkyP+U8YmQB6mbXh5GyZNrQS1lZ9o+UoZE4
         lr412mR4ANf5fvHv1CGc+y0IoB8+hsfvBJSOnF9ujn8oxNYQZF36My4bNL02crWbTgfa
         8J/w==
X-Gm-Message-State: AOJu0YxJ7YKHfF6WcJ5Cd5oTnkNm78nFVntWzKLijqF6HdNQvI0HTUW9
	+Xp/BTS7IwpRncaQoTP9Ch6jSrWFz8C2tRYcLAePXuatiq1viy8snIj/358oCTG1GI55Y/E87Qw
	+X7bhgAfTP5GPShC+w1qHn/QF7iVs1yE=
X-Gm-Gg: ATEYQzyVZqggivd0vEJpFa7U7IR6CKnE7wau+7IcxKrXuQlRyGAbku3g0b7kPPujOLY
	E9WN5mKfhhANuzvM9tb0cV1tkSRPOCdxkBd5uItnVG9h8CFhHazrkgdBh0cIVqCtXIzA1N0bfJt
	sqS82yLfebQsS22dFtznRyPWkk0//m11uQH7DHJmquKZLPa6dTDbxat0JUmSCmcEuemIEV/XNbl
	UzAJgkj9dApVfJxCnRCqpSmwOe44zJ7Y71xjFAENTMSO37UIS1EPGMxnc6emhAG1dynh3ohhzkX
	KF9lOw==
X-Received: by 2002:a05:6808:6f90:b0:46a:ada:cebf with SMTP id
 5614622812f47-46adffb088emr2036715b6e.1.1775079570222; Wed, 01 Apr 2026
 14:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
 <20260330223143.2394706-4-weibunny.kernel@gmail.com> <1d013236-e945-46fc-8acb-c7ab9ac32a1f@gmail.com>
 <CAGqc4nX096xJKyxdXrpXkHert6uCqHLKo3Z2idw4UXSdKw0O0g@mail.gmail.com> <1ec0c6e5-4c5a-436f-8d43-6f6e31e66b02@gmail.com>
In-Reply-To: <1ec0c6e5-4c5a-436f-8d43-6f6e31e66b02@gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Wed, 1 Apr 2026 14:39:19 -0700
X-Gm-Features: AQROBzCZJ1ORh7Xoc2Wmf17KPRzagnHo3TjLIanJwIFyIgXajkNd6gj5lbDoXBI
Message-ID: <CAGqc4nUoyA8+nqOJ3ft8Cd9kJc03jiEh4S9Th23N0JVsyE_zRw@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 3/5] psp: add a new netdev event for dev unregister
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274265-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 20D53380AE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 6:02=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.com=
> wrote:
>
>
> On 3/31/26 5:51 PM, Wei Wang wrote:
> > On Tue, Mar 31, 2026 at 6:30=E2=80=AFAM Daniel Zahka <daniel.zahka@gmai=
l.com> wrote:
> >>
> >> On 3/30/26 6:31 PM, Wei Wang wrote:
> >>> +static bool psp_notifier_registered;
> >>> +
> >>> +/**
> >>> + * psp_attach_netdev_notifier() - register netdev notifier on first =
use
> >>> + *
> >>> + * Register the netdevice notifier when the first device association
> >>> + * is created. In many installations no associations will be created=
 and
> >>> + * the notifier won't be needed.
> >>> + *
> >>> + * Must be called without psd->lock held, due to lock ordering:
> >>> + * rtnl_lock -> psd->lock (the notifier callback runs under rtnl_loc=
k
> >>> + * and takes psd->lock).
> >>> + */
> >>> +void psp_attach_netdev_notifier(void)
> >>> +{
> >>> +     if (READ_ONCE(psp_notifier_registered))
> >>> +             return;
> >>> +
> >>> +     mutex_lock(&psp_devs_lock);
> >>> +     if (!psp_notifier_registered) {
> >>> +             if (!register_netdevice_notifier(&psp_netdev_notifier))
> >>> +                     WRITE_ONCE(psp_notifier_registered, true);
> >>> +     }
> >>> +     mutex_unlock(&psp_devs_lock);
> >>> +}
> >> ...
> >>> +int psp_device_get_locked_dev_assoc(const struct genl_split_ops *ops=
,
> >>> +                                 struct sk_buff *skb, struct genl_in=
fo *info)
> >>> +{
> >>> +     psp_attach_netdev_notifier();
> >>> +
> >>> +     return __psp_device_get_locked(ops, skb, info, false);
> >>> +}
> >>
> >>   From an AI review, but seems plausible to me:
> >>
> >> psp_device_get_locked_dev_assoc() will proceed even in the path where
> >> register_netdevice_notifier() and psp_notifier_registered stays false.
> >>
> > This behavior is intended. In case register_netdevice_notifier() fails
> > for some reason, this current dev_assoc will proceed but the next
> > dev_assoc operation will try to register_netdevice_notifier() again.
>
>
> That doesn't sound correct to me. If the notifier is not registered, but
> the dev-assoc command succeeds, then an entry can leak in the
> psd->assoc_dev_list during a NETDEV_UNREGISTER.
>

Hmm, right. Will fail dev_assoc in such scenario in the next version.


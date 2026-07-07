Return-Path: <netdev+bounces-305564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PoNCEX9DTWoSxgEAu9opvQ
	(envelope-from <netdev+bounces-305564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:20:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A90771E97F
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:20:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=IigIMhOS;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305564-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305564-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02EA93048098
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 18:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A759343B6FD;
	Tue,  7 Jul 2026 18:18:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2C26AC5
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 18:18:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448293; cv=pass; b=NhIrBpgpGcJtNkG9P4s5KGCSItVXAmXSE0Gf0q4TgLL1AhFhCp7VBGYvGRwb3Baenm4DozJHPt1OvcF8miTDBkSO+WFTO6xLTKT8hC5t1D2+unttzxrus4SyHqYPyK7fo2AgG1GDNTEYm5k0gqx0gtWdFYBzikUlX/jB8qHKVv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448293; c=relaxed/simple;
	bh=uEg7i6xtZZzWPDfZHBts44nU0r7FcUzQViZ2Hklcgzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7iAtSWAed0NhZdbPnX9T3n+kRtV4lvvcz1VS3No+Ig6eN8qVW7KwmwSrlkLAQZkitQXfoXaSwFjDjqK3ulhw8CBU80wN8PWYN+6c1HmF8LyaKguNVMhw4LEmOsiPgMnvirnqP9NxomAu9pJ8UYD/51KfgV8aUQQ1IRB8vBnKqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=IigIMhOS; arc=pass smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84780c95e2eso3764668b3a.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 11:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783448292; cv=none;
        d=google.com; s=arc-20260327;
        b=OCZsSuoAPjwY5BY/0tdGcIG2RxUcSggEThOnUe0H5n8VqNgaBQFHKrar9y7p0UKKQK
         AcsIDowTnuX8jhPqM63YOKVbS4KGADNTlOWPNR3GhKSx0cIzHwM6RVLLsLPhbsMtY46X
         sEIdpHFUxdxk9fwIH6M1xESOlAdbSm199+dPwyGAEZt9o+iryx6+6Jvla7c6j/egEfJF
         xwWojArrZwXxjNMB8InJdjxf3slgPlZA7zjfvv77KOPnR3vjsIBNXwN2kIwog1+/Fe9c
         P/JD+UA7ZQ4nUp3lAFU1/yZ5eQDwXXAZ6UO8ZB+xdSX1F2BLMP8GbjKKNb9gXPsKsSjJ
         GOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CC/DjMknxpK8wOTo2t115qL7eB7dRauKbUe1yctE2aM=;
        fh=TOFMrbxiTkfpXSUva3PYxQ/49qHNRYoTMTIdOFbrbw8=;
        b=NQbqXgTpIxmuT4b7oiwuy7cloC0htGqfS9GA0/PBo0cpB7MCX4dpnruWy1ZDNUHGJA
         wC0oe9cxiEye2Iu2tWm/nl1QCdOmjeSumwhCl57hSsEhsfqQzI16KJXwG2InBf44oeI3
         tHt+76Fpep6SDy4POrQ57hBTKAHvZiHTCdR5F5//UTEQ4YzdWwbPSzM0yPgNWyAPRV1N
         kMK18l4EfOZfWBJXD3cu+zQ7+oCsy2P0dtDkVFN2agTuzf5wnapN6qHTi9elcPKzSIBt
         NtH1FlHD0Fwd4aXvI0jgiI6uCBQ6xJM5fs2ncgsGLqu3mdu4ndpOp3pYLcgTD6kQwLba
         oG1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783448292; x=1784053092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CC/DjMknxpK8wOTo2t115qL7eB7dRauKbUe1yctE2aM=;
        b=IigIMhOSyb7M6T/7YCjdg6uTZjUGQ1FJ2UA5NAPrpYpvgDdFmBK1jVMkGGPIN3O1wN
         8Y5lNqR95Y2Jav3YcyFa1+T02bqWjkCB3HTRPUS6SphKpwrHgSBf2g/XI/SfE906/Etx
         Baa/BF1kwOejRghujc/yNRH2wo7CV7qhXpJQB1GFU5LW6NomOgKc3E/Z4DBY7GYEVC7z
         WjkRlIq3VQnJ8FZI7yMRDqexH7Gzf/YwhrWP/OAccqs9gjxaVOy1+6BUTJl/G69amCMw
         TW0kwKQmNLso7wudd5DsC7FP6hcUcllJxDIvn78KokPesm3f/5FXbD/e0lRMiOjd4+7c
         rUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783448292; x=1784053092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CC/DjMknxpK8wOTo2t115qL7eB7dRauKbUe1yctE2aM=;
        b=pve97YFOIYu93SE7V+7TWicuG7clEeNSNf/rfJa97PC6vYYqNHscBap2yZD6A5Ou9N
         A8Ep6d8+hHd2CA9AiOZEDqDqx/w2rJyHxNgG3VeNKiOCNZA+tL3EOsHYuY5tlK7Uewec
         MfdJmHKBdAUXJ7aIxrzDm+pYZznPO7Eg4BIuaDGcivVMTaA77FhKadjR2HqHj2SwwUKV
         69x/NwZvbNqHjxkD0RoF66n/ff8lmYJA9Di5lF8hROI8dRFv03llu+Ep7gIYgvi+21lU
         2JM3ByBOcCdf5Nk5Y06CeQ9pAAOhmmw8PdeC8Jp7UM+0RqM+aRdqJljnPV1jSkq07Y9/
         E6KA==
X-Forwarded-Encrypted: i=1; AHgh+RqIJgRl1tjp4uNP23TR6CLYHrVQBTnp4RQ4ap8xRb+CXV+1O5C4vBGotK5kPTNPjRBiL0+ggW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JVaF3jFilR1PfcA4hf/D5itjPQs9tIjrrBRQ/KxJUrAqS4Vl
	XaTMI4iiCnWrsMDit6K9ZLqLENnXEqlZJEksyhpTbvlGV8/1cgCRWtonzwUScO/8QLpd9EG5eeR
	1aaFJblhqvmxvD5CuQrAelwAmgUQ+WZBDNc7w4mH8
X-Gm-Gg: AfdE7cmSSHQbL/2T3pqU7WVyE3JVvuC8gOHOqDLJdEdaxgDcycP5hLgsqwVeje1cFWS
	5h4qYqYg3eytOUiXE7HaubMtpPJNgo8MYqXKPEBVBbojD3J7UEhknUI98cSBVHHn4Sp6yiCNjAe
	do6RWnU3NZu7vqdEMl7OeQfq35+5rI7UnDW4BYz5z0xzDYA7lrdSyVwgLFbmkDCOxAas8oYIkvI
	Wa47YCsb75Z/UcSltChEuL4D/3/dh84CxnGhB48FD0HkZh7K13UiDxUCaXw2tb0Nyjc8YOnYyd+
	uAp34Bve0/roacnRY5YxdO9MCpiX
X-Received: by 2002:a05:6a20:6f01:b0:3c0:b3f7:e5dd with SMTP id
 adf61e73a8af0-3c0b3f821b4mr117966637.42.1783448291687; Tue, 07 Jul 2026
 11:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702010516.221830-1-xmei5@asu.edu> <akyd7YVSczkMzK-h@secunet.com>
In-Reply-To: <akyd7YVSczkMzK-h@secunet.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 7 Jul 2026 11:18:00 -0700
X-Gm-Features: AVVi8CeIw1w7k9t41LQyqOyB_-4DkH3Ov3YlihTG_NWq3k0ALOmn7u6xWCG6pk0
Message-ID: <CAPpSM+Qi0Abt6-bD_88SOgbDR-kLfOnwAPuZQ+vgu5jpQHQ+uQ@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm6: clear dst.dev on error to avoid double
 netdev_put in xfrm6_fill_dst()
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,asu.edu:from_mime,asu.edu:email,asu.edu:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A90771E97F

On Mon, Jul 6, 2026 at 11:34=E2=80=AFPM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Thu, Jul 02, 2026 at 01:05:16AM +0000, Xiang Mei (Microsoft) wrote:
> > On the error path where in6_dev_get(dev) returns NULL, xfrm6_fill_dst()
> > releases the device reference with netdev_put() but leaves
> > xdst->u.dst.dev set. dst_destroy() later calls netdev_put(dst->dev)
> > again, so the same net_device reference is released twice, underflowing
> > its refcount (ref_tracker WARNING + "unregister_netdevice: waiting for
> > <dev> to become free").
> >
> > Clear xdst->u.dst.dev after the netdev_put(), the same way the XFRM
> > device-offload paths xfrm_dev_state_add() and xfrm_dev_policy_add() in
> > net/xfrm/xfrm_device.c NULL ->dev when releasing the reference on error=
.
> >
> >   ref_tracker: reference already released.
> >   ref_tracker: allocated in:
> >    xfrm6_fill_dst (net/ipv6/xfrm6_policy.c:86)
> >    ...
> >    udpv6_sendmsg (net/ipv6/udp.c:1696)
> >    ...
> >   ref_tracker: freed in:
> >    xfrm6_fill_dst (net/ipv6/xfrm6_policy.c:90)
> >    ...
> >   WARNING: lib/ref_tracker.c:322 at ref_tracker_free+0x58b/0x780
> >    dst_destroy (net/core/dst.c:115)
> >    rcu_core
> >    handle_softirqs
> >    ...
> >
> > Fixes: 84c4a9dfbf43 ("xfrm6: release dev before returning error")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
>
> Applied, thanks a lot!
Thank you!


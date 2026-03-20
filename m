Return-Path: <netdev+bounces-270076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CESFBua8vWnyAwMAu9opvQ
	(envelope-from <netdev+bounces-270076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:32:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DB42E1695
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE4A43007500
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9213AA4FD;
	Fri, 20 Mar 2026 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VhioUHhl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0F395D86
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042338; cv=pass; b=XR0h/eGlDhyYvwNq/KrDtS4VnQeqthHEPAc4kvantCZ8aN1k9OOmaERfSOsYKOHeF76tW99h27cswC3nCBygW85fyT0lMzu6GiNXogbIrO3TigD9BYeqhjwsJRcG9CQuD2Q6fifQGZZhLNsATl5kkJz0RXLCSoGcp77VX0w/V9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042338; c=relaxed/simple;
	bh=4aNgRP0fxkJlU8uu5MAT3FbnTy/e1qwkXRMyVbQt7EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+0Q8JdUtPMBgdlpIJckVmcCvRJ7KZSCXhU3gWA1eQ5wyDjTa7YLUV3J69G3I2Jl5KP4BCPXRsj6+blUUoHEaIiMV4TA1top8Q5upOfB8eA7ZHdanfs9OyURLA2zzudO5/vDGVlK1JrUCH5h4zqz21PmeS2hyqWYm6T6qV7Gaw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VhioUHhl; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56a8fdaddebso408580e0c.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774042334; cv=none;
        d=google.com; s=arc-20240605;
        b=jhzL/OWa+gQYQxD2Qd3XYhxx4CxAv70v9FsqwZNKadm+VS4J9exQrk38a9/ak62sfz
         7TMDLyK+2J4q0lUMeEmwvBH2AQMq+2a5ATb+QE+gyVBtlN6LjocAGFbrl+THFbqmH3EN
         kIeyCHuVaJiSeiyRePb+aoXQH/tEwBDDR9wWxkqbayCCplzvfEe3YceHAN06ulAqsDkO
         2ANmUGqPMONqGkvT20PL9rVbThM/CiKDt1jByTJKZTuLJpPDtLOamrPS6KNT3zJawMzD
         vMEDge9YpyOf0iLylFzNm+9jMmtnK+pr9jKQG1XLvq1mxh2BnSSiWZh8UJ0bJiqtOMIn
         Ho6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zXn5ELf3xinxpvYDam5c3+C3+p3dpskPet6yexUsdbg=;
        fh=vkPAv2jdFy0XjBCSNikZxpcvgZdGimhCzxUtsus1elI=;
        b=j/N4YxgmWM/VuYXzongWnt2mKMTrVmJzfkrdbCqP6rgXVLanH86NawqIyiV5fVPA24
         3Pv/acWALZVHAFypUWe6WV9mB25b7CjJwaD9FDQXFNgAK+7RDmK2VyyF5l3vdRuMGld+
         2AYFqVlDhs4MN3hcfCM8PqC4zlnh/iYDR6XELw+aHzTAh+LGL+7d34uty+6MXKal6U7j
         W95w+vk12bacJo04s8k674BfotViVV+8cMxyW21eei5c2eqJ1+DHwszGHH+dkqVEjSTy
         +h8pCytlioB0K4Kbr6R/5nF77w+f0U1QeH5PjhztU2rbTbFOnt/sQc3gLWR19ivhpMsm
         /jYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774042334; x=1774647134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zXn5ELf3xinxpvYDam5c3+C3+p3dpskPet6yexUsdbg=;
        b=VhioUHhltuMMSl04jOj5Lf3XlKZIs8G8g7vybEgfnSjcKsVgFyvVqX6UxhTC9dJWxK
         NPsbx/qojd7pt2NsBfPf40Eotb9Pb4vUbY+n+9iQ1SLG7ZsBQeNmGLtSYdHKmTv8cmPV
         jdZb+Pz4Kk0aNwNOdVvtZIsyDh2CbbDgp0u8QZZnq0cpwy52T0Rc+OM5jXLbAx1Sg7pa
         vRV6nTizXoIYNRq4dABhT3PbFg7Xu/QAfL3K1eqvvxN9pXtKDzwe0cuqJuxyVDpooTeH
         t7f6R2/XpNZx21XUyiX1lrl1lIRWGikTfAeL8ho7qOepbzWUCMvBrsknz6ZSmGqlShxe
         laUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774042334; x=1774647134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXn5ELf3xinxpvYDam5c3+C3+p3dpskPet6yexUsdbg=;
        b=QbzoGy121piZJuYKPZzR2/FycTdXcRuDj0kcFsm96cCZSMJ6VLmARlMlR/s5B1CYSs
         HIkZ+6e3fJN++xt8mrcatSMXIDB0RHC0Ghv/PoYYYLRQMPTC0sU+v/0GYoof1wE8hwvu
         S/bLvgR6ebw+1umLm1eJQXCthQzBshf+X73LO1hzF/SaKkWxvNxovhhpnyC2yATUWa18
         isYtytCNKnUWIAI5KM9MeGYDQim+Uzk1pFeH/fgmWDBTHaYbgfRyDkDmC9tnXyIUBwYH
         swtpzmnF2VWAYpBLYSs9TkTdljIVzf3t7TTKFIXifZHwx2cqXsr1HyuFWg177zxL5Neg
         ienQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJiR0Fzz81xv/oUVyJlvorY6UoMi11/Uc9oX/FQp74cSsT+2t03eSwadrq+1+uzVGNoZBcl64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3MDSbMYx6ee1ovryzGAy5hKzE7wjq4VdPkHAMewadX4Dq6GN
	7XkAIo2mKn9l+nUTeKlaqFEob5EHXJbXUfaCfpx60BxF4elUmegstgZ6Bo4884ppMTtQCguSKwk
	UjHAOZz3qwcKlTdC3dL5F6GFr/qGY6sMcq/cKcAkneQ==
X-Gm-Gg: ATEYQzzFkkDDia5mBpcuLkGLonjNEqjmWgvsRiPBcYEkHZQM7jGLrDs5SRAHsTYj/lR
	USRCw4T4lhZaxSduIQjWZNThY8weSIGD9Vqer9p7aZdMvtVMlBD6ivVYM/15P77bdKM2tnM6pbm
	a0MVwxM58aviQR1OtP6anGnbXRQDX7NuN8djj6byNvuJ4LVsOWDFqQW8Fn+fQKHC7jq9GPlkva0
	BaPhwOSePdWuHsjWmKk0T1P9OQxQIQNj0nQbMuXuC50V3NIhtFpZRjs3IKckl7Gz/SB8nIQwWut
	FKDHTMCi
X-Received: by 2002:a05:6102:449b:b0:602:6c69:eec7 with SMTP id
 ada2fe7eead31-602aeca6225mr2070294137.23.1774042334247; Fri, 20 Mar 2026
 14:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319213323.235559-4-rjethwani@purestorage.com> <20260320194205.175498-1-horms@kernel.org>
In-Reply-To: <20260320194205.175498-1-horms@kernel.org>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Fri, 20 Mar 2026 14:32:03 -0700
X-Gm-Features: AaiRm52ASSRAm7p1M0QHFiJcf1imtatu3057DU-tRe5aYV8Q2muJa5P4sYPY0ZA
Message-ID: <CAKaoeS0cb443Uuuwpmf7uorKyZZzM_vqcURDZSE5=XxWgJ5a3g@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] tls: add TLS 1.3 hardware offload support
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, kuba@kernel.org, mbloch@nvidia.com, 
	john.fastabend@gmail.com, netdev@vger.kernel.org, davem@davemloft.net, 
	sd@queasysnail.net, pabeni@redhat.com, saeedm@nvidia.com, borisp@nvidia.com, 
	tariqt@nvidia.com, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270076-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[google.com,kernel.org,nvidia.com,gmail.com,vger.kernel.org,davemloft.net,queasysnail.net,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,purestorage.com:dkim]
X-Rspamd-Queue-Id: B6DB42E1695
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The caller closes the record when num_frags >= MAX_SKB_FRAGS - 1, reserving
> only one slot for the close operation.
>
> Under memory pressure, when both skb_page_frag_refill() calls fail (the new
> one for content type and the existing one for tag), both fragments use
> dummy_page but at different offsets:
>
>     dummy_content_type_frag.offset = record_type (e.g., 23 for app data)
>     dummy_tag_frag.offset = 0
>
> These two dummy frags cannot coalesce in tls_append_frag() because their
> offsets aren't contiguous (record_type+1 != 0 for any valid record_type).
>
> Can this overflow the frags[] array in struct tls_record_info? If num_frags
> starts at 16, the content type increment makes it 17, and the tag increment
> makes it 18, but frags[MAX_SKB_FRAGS] only has valid indices 0-16. The
> second tls_append_frag() call would write to frags[17], which is past the
> end of the array.

I will fix this issue in v9

>
> Sabrina Dubroca noted in v7 review that you should ensure all 5 in-tree
> drivers explicitly reject TLS 1.3 sessions. In v3, Jakub Kicinski asked
> 'Are all existing drivers rejecting TLS 1.3 sessions? These days we prefer
> for drivers to explicitly opt into new features to avoid surprises.'
>
> Your response mentioned only 3 drivers (chelsio/chtls, fungible/funeth,
> mellanox/mlx5), but we have 5 drivers in tree. Sabrina noted the 2 your
> reply didn't mention don't seem to have version checks. Without explicit
> TLS 1.3 rejection in all drivers, the new TLS 1.3 path may be attempted by
> drivers that don't support it.
>
> Which drivers are the missing 2, and do they need version checks added?
>
> [ ... ]

Patch 1 ("net: tls: reject TLS 1.3 offload in chcr_ktls and nfp
drivers") in v8 has the required changes.

>
> > @@ -1089,11 +1110,6 @@ int tls_set_device_offload(struct sock *sk)
> >       }
> >
> >       crypto_info = &ctx->crypto_send.info;
> > -     if (crypto_info->version != TLS_1_2_VERSION) {
> > -             rc = -EOPNOTSUPP;
> > -             goto release_netdev;
> > -     }
> > -
> >       cipher_desc = get_cipher_desc(crypto_info->cipher_type);
> >       if (!cipher_desc || !cipher_desc->offloadable) {
> >               rc = -EINVAL;
>
> In v7 review, Sabrina Dubroca suggested this version check can be removed
> entirely:
>
>     'You can get rid of this whole version check, it was only needed
>     because HW offload supported less than SW. tls_main already ensures
>     that the version is 1.2 or 1.3.'
>
> Was there a reason to keep this check in tls_set_device_offload() and
> tls_set_device_offload_rx()?
>
> [ ... ]

I removed these checks in v8


Return-Path: <netdev+bounces-278010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAljOkez3GkDVgkAu9opvQ
	(envelope-from <netdev+bounces-278010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:11:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544B3E9A36
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6490E30104A2
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3083B0AEF;
	Mon, 13 Apr 2026 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LdpAM9c8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614DC3A9DB9
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071418; cv=pass; b=krrzh/5sboMa/SFCWZl2Je5RijLdKuzsP3v+96/WUBxJ8QJZixtTlkev3+OfqcY0h1sVahxFVSmubC5FMp4gbO4AW1OgA6poCN5/Txaab4y04ooJLP0D4Kdoo05KbF+bNp87jNELvdTuKvasYVB64U2/Gfq/ZsXUIgvZWUk6I3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071418; c=relaxed/simple;
	bh=lwMsYud59ZH+wPN1u4VR2uGEKj06DabIZgiH+3bzOO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+Lu4H5aBeEGTI5nbjyePtAWUp/VUyhWuVfqBBPhnshw+yo7iO1nzvm+GFhdIIqvn5oFEcceRjJE3pEu8cXnFzjQen8J5Pqn14nDmmacXjBevUCBh/eLr9Apnw6nv1ewwDMozwViVwhfHQsCmTpGSALn26yH0nOuLGrAOyH0ZLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LdpAM9c8; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50b3488fb31so54350711cf.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 02:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776071416; cv=none;
        d=google.com; s=arc-20240605;
        b=HLjLXsf+D+Ju6wZFYvlyP1Ltt/Sjvx1jzEOpG8RBiGPGT1LnX4TiO4bhHva1Abex9y
         2Td4hmN6HUDCWqUwlLabDdmuaFMdazgbsKP4iC/rJSLoHH+/zub4+XLCFytSBQ8dsy/+
         UAVELlhKQCAlCARLJqwhyIFZhLBlNo4iw2cVDyjirXitwtUgNx4Iw9HKWscYGJxoJga0
         FusRTxdKIeJSxyV3IPlzzUs+hDzhxwPs/0V9S5w9+I3TTx59hEs1JO4kdCRISBrA3x0E
         5gSSb3WUkeRCPmxxxYYxSUyCYPeFtN+6eRfXan2jP0FNu+NZPUyHE3SEuQckbDcHSAoV
         EGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wFihvD5F5AL0vEScm9aPKM4KVPGTyMzzEuOFyc5tfzg=;
        fh=0emub2htopEZ1vciyT6vJ4ueHnKj59KYxq7BQUBKLWw=;
        b=IkvYiwqh0vEY2CqrfQ5Ta6TNevBNX/+f71UPYsuYgh1WAur7ILFtD3N5bGC/c6NDwl
         yo6Edau13vTrEJWPKoSxhsLxaJEN3t+YdIdy0bZ5z4aI24aK7y4sFp+jMYfXYx2Sko3H
         bONLORJBjTHu6DUa+rAAcO7soMZR6XLVYwru5BcZnwCTOs28NmwxBesAf8jRgo7rStJ4
         +G3ris7jFbGo0PZoRyKQ4GsFQl8dxqgu6xGmTtzRlVKFuyKGEEVbmUomDEnGnXW2zDyd
         bYHQCgz4nx5IEHXHBoZ7Ff+KUVgtHXSlLdNKZ7j3TVnQeAiEAN0kHD3v9H8aWgJ+9S0N
         Fxvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776071416; x=1776676216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFihvD5F5AL0vEScm9aPKM4KVPGTyMzzEuOFyc5tfzg=;
        b=LdpAM9c8ist2Z+LPQAOR04Hyn/AY0vRKWX95qdRJkdJVRQc8kukgExSXavEziuNQjJ
         F25cUYgrhfh0jak+Iag5zXwQsJMZhJFBtNDWecSenwesWnD1C6hQYAEQY2CPBple5RPm
         +s/7KWX6XH45twNli09FZlYo8Ufsob6hG8gKrQnEAAMjnnAefKG/6jKMUQvDTiqq7efH
         BJJTbjHAXuvRWK0wBT11aRn6VzJ7bYNBJlfgSwDt9SZKb+n93nKWXIcv4G1l8Hs/E1rH
         hudwNwQ7BLMs0we72xg2RoaQNkr8xdmlHKI5s7+eSwQoC/ChEOyyqk6itHSjiLjueiSD
         HGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776071416; x=1776676216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wFihvD5F5AL0vEScm9aPKM4KVPGTyMzzEuOFyc5tfzg=;
        b=ldpCfmqR12NXthy4Tm2ZC6mmPoXgb3QqnhoVKVzfvtxQ0vfxc0nH1BASSCVQCOGAIO
         7m8CqKXG3IWjkMn5e9fptNRZWuIuv+tdbuCPUW+VC7vRiQeCTe1SAHqkP+Lrlvjs9BD6
         koBi/4DgrxsWipivfYeE2+pWdPuz46AYJegdMQLUR0mDUYdz01FW6WphLpyJrX83cvHn
         saFgoGEpr5lMyg4UYQmsckqqCesDfr5hU+fxD/htnJdWWAoDB5AZTvhH6A/xtnqrwXud
         01yPaQSkoBdvLEyBe1itDQenBKexD1kuFciQM7SACxhIKvOm5MO1O5OzYTP+IOWAUXr8
         qiTQ==
X-Gm-Message-State: AOJu0YxzAcPTE+TkzFntEKLi0rNXAP18pawQwVSvZNYMmEWF2POD6pcI
	fZn5247YLFaM/5dqRy2VbxrjahUxn4gWWHmrsrQZ4RtAS3kCh2+0O2y99vAKBo0yrF9BJzSqjT8
	LCAZH38/sZgy7UwugqyvYzbHYACoruHTAvewZfKAy95Ftt5hqjjN9NONt
X-Gm-Gg: AeBDieslyu87AkpYFtfRgFAt7OdpI7w/1GQHNioqaQpAVwX+AHAnJ49OCoq8fGZKRDr
	yGtDWFNVqzeB5EE1COxq1MfsBVVpoISuzuVEtjh/2M+z/sIcWVB3SkAdp2sqEENxMJALRUeo2Cf
	0JUN6BugnYOfBKDkEoqZzFw9xEGRdi5kdGW2zfypEUVyS9S3klVyXcUlSddmbSnCmMFPeeUc2Rw
	Z30A+UMWnkpD8Rp57A88Ad2hsJI74dQsssrcFmC0z4BcY/COF9fKrM82OHeofYoVN3COUD0OtTx
	FC12Ks4FAynFcHqaIeDMVyjKzfZEkNZ5XhZ++qWCThSfcUnKRA8vn6GUeM8KODw5Imv4Wsycr2I
	=
X-Received: by 2002:a05:622a:1c0c:b0:50d:8ed0:7f10 with SMTP id
 d75a77b69052e-50dd6abfc41mr155085601cf.13.1776071415917; Mon, 13 Apr 2026
 02:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413090420.79932-1-phx0fer@gmail.com>
In-Reply-To: <20260413090420.79932-1-phx0fer@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Apr 2026 02:10:04 -0700
X-Gm-Features: AQROBzB48_FmzgV9CBEBfAdtFQTxw_m90qwCH6KEZJCpO4lSbCHBKVNu1jX-FJQ
Message-ID: <CANn89i+hQaJmitXByaft+xqmpyOPkRctV+uzy2-DD23JargndA@mail.gmail.com>
Subject: Re: [PATCH] rose: Fix rose_find_socket() returning without sock_hold()
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278010-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5544B3E9A36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 2:04=E2=80=AFAM Dudu Lu <phx0fer@gmail.com> wrote:
>
> rose_find_socket() returns a raw socket pointer after releasing
> rose_list_lock. The socket can be freed by a concurrent close()
> between the unlock and the caller's use of the pointer, leading
> to a use-after-free.
>
> Add sock_hold() before returning the found socket, and update
> callers to sock_put() when done.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
>  net/rose/af_rose.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
> index ba56213e0a2a..b32b136f80aa 100644
> --- a/net/rose/af_rose.c
> +++ b/net/rose/af_rose.c
> @@ -1,4 +1,5 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> +       if (s)
> +               sock_hold(s);// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   *
>   * Copyright (C) Jonathan Naylor G4KLX (g4klx@g4klx.demon.co.uk)
> --
> 2.39.3 (Apple Git-145)
>

I suggest that your patches are checked by one human, before sending
them to the lists.


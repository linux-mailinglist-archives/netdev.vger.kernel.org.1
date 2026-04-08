Return-Path: <netdev+bounces-276677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MjWBICd1mmyGggAu9opvQ
	(envelope-from <netdev+bounces-276677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:25:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE453C0A7C
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11B0A301E730
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9533B0AFC;
	Wed,  8 Apr 2026 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGVuJZpd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ED6B67E
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672701; cv=pass; b=WqiJi5jweXXNYQaD//iVb9GITU6Oeq+K4llliiHCW8Zz6RdPAwRX7sjUM9RYfNN2koBpGJ554ZoFNKMbnJwfQ2SvDHLdfPv82LpR8vWvqhq9SjT1ne6elsB6rJhLGXjOVKrmPQA4kTa4ama895WPwDwwbbztQzAzSFUCWf6KUis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672701; c=relaxed/simple;
	bh=SxQJc+CDSQYnOxMbs0HujGi9S7wv5ORbdGwiws9bGfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSjWUP2FNSjCb4UhGKi0hc5R+Jnb/3n7MPleuU9D9g39oJqWK/Ywhu8vwc3nFZK/wCVUr6fXbI/OA7mlp8YzjhGOiMvG0PVq5ydi2KpFjPNBchVrjezr0kGz68q7mwDftZFj5d7CyVyohHGNn5tKqXgmfkGNMDKMbnSVuzChX/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGVuJZpd; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbb38eaf49so8081a34.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 11:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775672699; cv=none;
        d=google.com; s=arc-20240605;
        b=ATaskUWMVv1EVHcXhFxujN8v6VHtti1RfUt4Ji0Hx2ZFHQv4RCNxDDrN0tXnEIVsjp
         e/pjAtGa/D0Kak8cRQ8x5BCgztS9JfL5uPgiWH0PVz59r2Hu8zhVLOa64zPfFgBtNHQP
         aLS1OXxFNNr4zW5PM3YibdESgTo4oi8JkDA0coDnpCWvRMmb4oCd/gK85v229SypFIPW
         +ZSN1RwsG0y6qTzFzp/Eav3rPMQqLxxyCxPQydFw4cyUfegD9CIpujJN/nDf3egONHPq
         y63yM1Ot5OIaMvhjeVxEjm3oRXpyLAcVoG2zvDSFdTP0srf4xrHYIBQpQG7jOiBvgc+I
         MkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eOy6IM78wPp44n4uHYS+7RKGYtgPRmKl1w3JD6OGCZ0=;
        fh=H8c9WxbJiTCOeqRsgzc/2tlfc6S4phJdV26sywHRpr8=;
        b=cdc3tc7gOlT7Xyqifvc+JADbsEZEzgRR42wmwd0ccyF5RtgvlxDEQ8YLknPQ2hxfFo
         ismdQBQehhtE4o2BkbSvCqJnNKWyCMiVTx9EfsmihRjovd9sOxT6bDALQGSbsNuHnXRO
         FOL0I5qdCy1MBo7NuRZvXkpdwQUVVafvlbulWgsGeo9N/fjemGJR7KI8uFpN4Z+eH/B/
         3cOu0qmYmXOVHCiZuBLSsBY70PGnclSk5v25aSCYi4jl2z7COUjkfNcJrBJLXO6cnXCA
         5QfC/8rO5kkhk4jgv+bvHWarzSDs4YNZtpLFc09hqIIP6wr1m/Uo4Zf6x7TvDrjbgQXI
         S5oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775672699; x=1776277499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOy6IM78wPp44n4uHYS+7RKGYtgPRmKl1w3JD6OGCZ0=;
        b=BGVuJZpd796dX2Lg4joGBSSpuGwnuXWfBRi6AV+zMasWnnnJujrdqcOynLC1jAB5Ad
         9D0/ANzoi8lwUQklOmuD877IfmzEgZ79PUc0bZNc9spqbgJq3as3F/odEiAkewM+1j95
         ieiYJRLouVGgbriPzAJQYO4mpsckjkf8bxwVh988OPQ9ZE3dVfVsM74m1h2i2qlm0h3i
         4sCX6rwnmmie2qhYEcbLnKtkHlU9vw2pD4AZRWEGrAcPbEViZHn2MFwlfuvTOj8xjBMD
         5yniNi2aDApCPeYqYc2LOUrGYvi1diL5YnOOqX1HEKQ+zJC8CDo0PbjzYNh3gLTYjENq
         G/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775672699; x=1776277499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eOy6IM78wPp44n4uHYS+7RKGYtgPRmKl1w3JD6OGCZ0=;
        b=JeYoq/2xZXM+MMp7q7GG65hsQs6MYsItRAYl+Tz2aJNaiDm4ApYkJPhdVsDOmgB8lz
         THyn/JxvAhFwP86fNGydKUn9CudoRXOVA6klOZA5yfX0fvWSeu6LJox7XksSSujIczl2
         /oR7IZDZgD8yirElRsFc0VxHrfLF15STFNrgBK/9I64PWWq+yqKJm/AeBUsb17nyJYlu
         bVbwy4bNBBpUhdQqIUHboMkW5MSL/6KgzjL73mtqeyzv3JyNM/LayVyMPS+X8HHqLnMd
         TPAdyO8F3Eh9PNSjKUe+FEtUPnKpxEIUIxq324uhkX+0MI6l9c4yLJID9lpw0SasE8aL
         vdhQ==
X-Gm-Message-State: AOJu0Yxx8gDZwnf4uilQ/7DY+fUxkW09GrotAWf41VahHFJODP5Fi6XN
	2HAzivs72ALDMyvd4DMVZhCoCMUJkcqvJFwXpA3MCvB07+gnIzNIZriQbBHzv1tCuTx3DiFAE/z
	rcfGsC4ahkU/QHR0YtkIVSY9JTKb4h6QpKsVZ
X-Gm-Gg: AeBDies4OAPm57xnD2+8N6LVfefYrf4+eV+DNEjpBwpwmW+2U4mrLjVoa0bQpKIqOVH
	7QLhBecsZWnCPON24oWZC+X8fKNmnOZVUYol7IvXhu/V2Nrp6+1OWOpbA2To9VW3sHPTCQq55IB
	5D9rF9Q2uLZ4YWJBDnU3MucG1Z4h7JniZ03yUgP5XjwmjycN7shP4fJi+t3IMAFwEFHG3TySMTo
	aOXGPrWB48GaGaly62PH39BB0PjPbYoK++Q2WmK1eYaDrHNGGvfpCcZf+3YpPuAfdC7GemvbT0d
	1B2xQFmaX0+snIOk
X-Received: by 2002:a05:6808:4f29:b0:467:fd4:97be with SMTP id
 5614622812f47-46ef8314889mr7384091b6e.2.1775672698944; Wed, 08 Apr 2026
 11:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
 <20260405055853.3285534-2-weibunny.kernel@gmail.com> <0b4de4de-45d8-4d4f-a15f-87c527b87253@gmail.com>
In-Reply-To: <0b4de4de-45d8-4d4f-a15f-87c527b87253@gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Wed, 8 Apr 2026 11:24:45 -0700
X-Gm-Features: AQROBzBXq_VTFufIeBUrYvScN825PAsJ-o0a9FxrEKp1wf-Grm77rZu21Zk3wgE
Message-ID: <CAGqc4nVMtK4g5Db-r1M8GLU=gq0F8PtfJdMcGd+Z8mndXdfG5A@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 1/5] psp: add admin/non-admin version of psp_device_get_locked
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276677-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: AAE453C0A7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 4:11=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.com=
> wrote:
>
>
> On 4/5/26 1:58 AM, Wei Wang wrote:
> > From: Wei Wang <weibunny@fb.com>
> >
> > Introduce 2 versions of psp_device_get_locked:
> > 1. psp_device_get_locked_admin(): This version is used for operations
> >     that would change the status of the psd, and are currently used for
> >     dev-set nad key-rotation.
>
>
> typo: "and"

Corrected. Thanks.

>
>
> > 2. psp_device_get_locked(): This is the non-admin version, which are
> >     used for broader user issued operations including: dev-get, rx-asso=
c,
> >     tx-assoc, get-stats.
> >
> > Following commit will be implementing both of the checks.
> >
> > Signed-off-by: Wei Wang <weibunny@fb.com>
>
>
> Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
>


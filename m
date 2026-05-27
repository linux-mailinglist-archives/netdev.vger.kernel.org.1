Return-Path: <netdev+bounces-292298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BveEk7wFmpcxwcAu9opvQ
	(envelope-from <netdev+bounces-292298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:23:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D80555E4DEF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6461131A1A41
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B038B30CD89;
	Wed, 27 May 2026 13:16:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAB3F164D
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887803; cv=none; b=LtVPQihR8VtKKT1aNb03vKPeLKXRW8Xuc1UKBefhcphpKIdAFJxk5XaY7QIomOzAKztiBJVgPj1tOIpF+MUHoAtyhXzRyHJp+R6L2T+T2+luWRruO3GRu0KLRxC5cbDPsbYKx3RMamf/9lZ7W2Ujb1boYxe48yVRdQyngVr/Bjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887803; c=relaxed/simple;
	bh=xJbaIu4kbWT3Fd+qBIP6+uFDK1bAj0KqKpunyne2doM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjTKFgbMmUduAR2GrhmbtzdFnO3dZszga/NDWqTVIxQ/u8DK3UL67Y4qMwHwkbK6VMPgxqvBrGqlnWoCzaOIUNmqmEX+NOE6855KFfAzX1zigh/LLcIs5gb5/ElWZcpa8szzYnvJDM9ZBh4dk7KVxo0EVTFzIAg1nYZu76mgx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-575eaa32c7cso4004388e0c.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 06:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779887801; x=1780492601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cwyok8xK1yj/Bl5wm5hSFz/m5QSxpKe/GA3lqyTJoOY=;
        b=IhZRJZw5Zi0HxRAnNdwOSuPY/ghyos5oe3Fgq2Uajig9uVOx3E7QbhpVSL4dsXb6MA
         iEC6JKfChBnBx+RhperWFG0NS8dEdAx710XwKdILIExIe1pJIWo1rxEFfn+ckvYgWh3Q
         R0SpLrLgUrIAbedpN8RSdjb/ekQZAnOwmOcnon6/DYpO300ly6VEc64blXta7KUUh37Y
         Zbm9tH+xVbT7HuyB+mnaw7wER3I5e/545rKNYJIgvrMSfDpqktnBD7RqunlB+Oup9FwA
         7ezemdy0+UjRfcCGAzmcX6CcQge+jas2y4Qsu1RoLrL8lKRjzCietzWMHQfz1iLTCAI9
         Qahg==
X-Forwarded-Encrypted: i=1; AFNElJ/sT5tlXV8lgNVgrhpwU4BqOoWb0jbjMnK8hXqOdEeBMYX8AxDG/7yrDXyN7phEIKBpKr4e0Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+2QH7BgrsHQOxTvUsrlB0z+lELGOFaCcu6FoSpJWW1OCmb4G
	jnJpnzfQ7s7r2kM2AlAk9HGs4O+MHEOtGvHR061qve+RN5AJaWo/eFiwMeI1RVz3teA=
X-Gm-Gg: Acq92OGHDFtQprCIBgFsw8PFIwx9Hld4siqsUpElNKGlfRysoQTZgnM6nvU/vokVUck
	70DP8tHvcPVeOrq7n+ag1yKfHEnUPNfv6xomWkfce1hLsQQ2zaNojh4sjo2MUjzvbkZKe+G23s9
	i5ohXM9UshzCg53twz83aG6kFr6lp2rrYol8TbANVsm+kQy4+5Bi5IbUXc4kyxac+zSCcKRHq+4
	0NbKRn2TK90MMYsa2SxazoodufWMYxlqRzLH74XWUzdgVZHeKaOM1bOXUnDCjBseYHH6nNWfMEv
	CEyQ/2vwtMFIWgxHFGZ7udF91EkGLWjU1dQlxIaX0tUdiDTbFx3+qoZ9lc6PDOvlHzh6loCFZ5y
	vOhWoZwldJwDkFo6wu3m6Fy/s+y0pOh5eonPK8LFtvlIw1TpN9jgBHVSA4HwGPR5N75dM7snWdC
	RfOQPKNQz4XpbadVYKp5LlK6zPyWxJ04XHVKGtJdS1p9PPyzVacc4KRDHUuFJmj4Zc
X-Received: by 2002:a05:6122:1686:b0:56d:4511:9367 with SMTP id 71dfb90a1353d-5865865a0camr10666773e0c.0.1779887794558;
        Wed, 27 May 2026 06:16:34 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96173af3e82sm16974489241.10.2026.05.27.06.16.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 06:16:34 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-575eaa32c7cso4004306e0c.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 06:16:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/JJpAtmn3gnCZUUkYH3yIukF0HIRrVjiKDmkXybd+LcKk44nk50gMC+7weItHdVD+7jvjG0wY=@vger.kernel.org
X-Received: by 2002:a05:6122:4f94:b0:575:a6f4:46b4 with SMTP id
 71dfb90a1353d-586628c2881mr12587422e0c.9.1779887793671; Wed, 27 May 2026
 06:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com> <2243204c0f57f79750de00c072914354d4f65707.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <2243204c0f57f79750de00c072914354d4f65707.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 15:16:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUpn2G5oUVF0r5zKOYXpEFTkdhsgMDVehw-tvYsLhoneA@mail.gmail.com>
X-Gm-Features: AVHnY4LxtxfzOwDFHTzEquNzmA6_xmWByOKk-5QzmexzgJiQPch2ZMC7AIrVBiE
Message-ID: <CAMuHMdUpn2G5oUVF0r5zKOYXpEFTkdhsgMDVehw-tvYsLhoneA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/8] net: Use named initializer for
 zorro_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>, netdev@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292298-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.839];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D80555E4DEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 at 16:18, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> Using named initializers is more explicit and thus easier to parse for a
> human.
>
> While touching these arrays, drop explicit zeros from the list terminator=
.
>
> This change doesn't introduce changes to the compiled zorro_device_id
> arrays.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


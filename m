Return-Path: <netdev+bounces-296186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DnZjKmMRJWqrDAIAu9opvQ
	(envelope-from <netdev+bounces-296186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 08:36:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E98C564EF3A
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 08:36:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=uPGoL7Q5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296186-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296186-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F13A73005763
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 06:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E022EA749;
	Sun,  7 Jun 2026 06:36:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048FC2882CD
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 06:36:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780814173; cv=pass; b=qz1dxcVz8kCAtTtLdlXF5D/4YiG29bXPB5oBXhM6vMZmxmlScLS7gg4ToC2F7hH3ByeiecjZ2KobY0pMQzEMqJ2BLU6Nv5LBFdkYA5iSjmeJD2wEHHfMb0qrd+w7hh61vRndMJ5u5akgEtUs7YGEkqOHpRv8IRmw0Q9yptHUEtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780814173; c=relaxed/simple;
	bh=OjPchPzl3QEGRTz9PXgxGSwm6hVHeil8DvkbBVXWjrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0y7GZxDvshffmxw+37EhgDfPxcXNn1jNnJ7y0GDaCAOUZj07H8dgS/+svj2g28e9ktCno6q5s8L5mZzEXGJpzJpxMLqx2fOQyelDuXbaDSszKJUx42k/5RBeZycAYofd3e5oL2T5gjFw0jrttLv5YxIuJ5BRpvrCrOiucM79do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uPGoL7Q5; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5175b6c4e19so37557041cf.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 23:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780814171; cv=none;
        d=google.com; s=arc-20240605;
        b=DFpD+EUh4utbI/Zw3cjkgdFoF2GAN8g/o8KM/TBktOq6Yt/jCoPy2Yap9EOSQX8J5h
         OqxX8MT3+8uiTDR+1OIzorpRrmwElyMOGUxg3r8hJQyOR8PsLOk7M0DT/q6+5gPeE8Tt
         eidi1f0CsM4g4lnPUpgqp4vGg8y1wa1BviD0P+imJrYdIAxqWvG1etwdMllPq3yra7th
         2kDDZZ/GiCYZv72/mmmQRn2kULcsqJPzC98MiivRNDvQkt3j1xc/V0juQGTekn9th2Y9
         K+V27BGlhGGKKGzYL/vKeBwD6k4BA7OlKzHfUR1r9J/g4B0HoUglRVbP6zLWjeKs40jo
         8RYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OjPchPzl3QEGRTz9PXgxGSwm6hVHeil8DvkbBVXWjrI=;
        fh=zLDvv824RZEwYMe7E4YV6iNeqzPs+NXXhGHlRjrsLVM=;
        b=jKslTEhGkrLoD7vOM8QL4ppjzQ3YkXcuRjkEWelBx954RozfL5aS3zjfS/J6X6SdxR
         PWmUpw0cuj3DhfzFwH1vcW1wTiBGWjqXqP5GZKfpKHAOEjxPWeIy1FYFL4uh6skTHAKk
         QfoZixTrXhtmaqrQOc632V0WesD/koF8iXZSgWWMrbzIWWMYl/wd7wSQsRz5cjVW98Yf
         KPhNaGZTvB6caqQAX7Mw28MSqhgZys31fESVUHlEGnCwivGmoM13/1xAtrJSH2Kn5wfo
         fxjM8kwB2Yo+VPe6aU1K7+KjWRGChE7h+ORQWPFAk4M1wE/9e62XcVtdd6BOPwUpyWtt
         SWmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780814171; x=1781418971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjPchPzl3QEGRTz9PXgxGSwm6hVHeil8DvkbBVXWjrI=;
        b=uPGoL7Q54lO9wjhF4DAhtGa7iNXEESefdJwOLxwAAkVwuiPRRpFVoInYxpItHqAJvx
         9ZLT3/D7ovlFCXJIOje8ZlTY5Qoib37rfXGKnN34VyE/Pf5yqrN4UDt6n9nokdgHEd38
         2DfvhW3Piu+ooCUUSZQZxaUYPEl15YiM5P3tsiJQiWnddyNMjokaxOf4ZHzrhCA/FFwY
         L2lRxxXqK+2edx9boe/+cxElag3c2YrH4AB0z+j3Ft/EEdB66tMFCMCSwiMfXYjL2C7l
         48WYkLmFJwSSn83Klayszjo0g848BWH8by+A+KjRdxcsvFI5aPfVsPmSVBX5FcHNfe3x
         iHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780814171; x=1781418971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjPchPzl3QEGRTz9PXgxGSwm6hVHeil8DvkbBVXWjrI=;
        b=cXFbsUp2dIRd8yWFIBSFPOWCIxOUNbu7hPbcA8sbMgLKoSyFc9Nz3GSCnabmIvTWf7
         DWmyx0d+Hqn68ezx4CuGldHonRPj7OY+BGy9Uwasb+Nv4/jZRfK/D4vXswXr1qln1KP5
         9KSuoodAJSqVqj7QAilOMydLvt4PIDAvAgmYOxOnoaFortweGyMWmsGIjr0louggYtkD
         Z7JNw9rByQHkTF1JtwSdRCSlJTSAGl7ddgRvHmdN/WOzXBTbjHXxavdlC/1M3tJlvnSE
         W5Z+YYDUJVch1DP80p0sw4E6faTgMIiOMRygJ7yUOIt5C1YVjZpU7t7VJp4/t0LcLKKv
         lNhg==
X-Forwarded-Encrypted: i=1; AFNElJ/4zOPd5u2p9HCByU1Vgje6KegSdwNAohpz3Y9Bo6KQcZ4jHpuyBr+XD9GIZKibqmv6QoVC7R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrlgF38EjB0qpG94bIozDlFRZuy4gopqF+MZY3+QIY0ZdVld68
	ajDMWsEFmuhuJcqsP2/nwR8E0W2M2Eg+YBrQM8CDVkyyXSLRHLLpblDDljNVgFWIFZW/KQ3gnUk
	TxvegCcr5tix/2RIkXBDlJVgyVKJ0L6C+et9RRkVf
X-Gm-Gg: Acq92OGCupAnn8kYwAcUOsGlBWq7RQPwz23mJZT/6A9Vn7iPJ7Eslk3XwjSgXd4F9Vf
	Uu1iErfdDHXggHptcCqxCBpy3fzL0NJ2pa21TBtHMTrycRqJVdmHe+B4ZzEPKszzkteeGwiS4x9
	q3mdVtVg509ySOERHa3RvkqSUJijz0UEUUcOd3gZ5hcj0UO7biqRm8PTuYicNNjaJ9j1KfgBM1O
	cyi2yNxaV8bg+SISZ8/iAu2KViiVhKnT/eVR/6IYmocTa8XPcXt501korze5jEUskgwoAuBC6ld
	VPFXg0OEoQErc9crTjSBJhBjKyOWp/b8dMFYiB6V2YMPUg2K2jF87OFUuYgr/7VG+szpVWi2Wfh
	GX27AdesPL2sfg55fJZv5mjYa/kW0
X-Received: by 2002:a05:622a:1984:b0:517:630f:f50e with SMTP id
 d75a77b69052e-51795c6af5cmr161253721cf.37.1780814170292; Sat, 06 Jun 2026
 23:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605073448.6524-1-kylebot@openai.com>
In-Reply-To: <20260605073448.6524-1-kylebot@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 6 Jun 2026 23:35:59 -0700
X-Gm-Features: AVVi8Cd_rWx3uNgmOJZHTfH4FfD7F9ZKSrsn6DAJfzkNum3XNymdRU8sdTAjIk8
Message-ID: <CANn89i+s8ooP5yd6tj71awZNHORFh9gMq9Vy3fxnmXgLihbKqg@mail.gmail.com>
Subject: Re: [PATCH] ipv6: sit: reload inner IPv6 header after GSO offloads
To: Kyle Zeng <kylebot@openai.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kylebot@openai.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296186-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E98C564EF3A

On Fri, Jun 5, 2026 at 12:34=E2=80=AFAM Kyle Zeng <kylebot@openai.com> wrot=
e:
>
> ipip6_tunnel_xmit() caches the inner IPv6 header pointer at function
> entry and continues using it after iptunnel_handle_offloads().
>
> For GSO skbs, iptunnel_handle_offloads() calls skb_header_unclone().
> When the skb header is cloned, skb_header_unclone() can call
> pskb_expand_head(), which may move the skb head. The pskb_expand_head()
> contract requires pointers into the skb header to be reloaded after the
> call.
>
> If the later skb_realloc_headroom() branch is not taken, SIT uses the
> stale iph6 pointer to read the inner hop limit and DS field. That can
> read from a freed skb head after the old head's remaining clone is
> released.
>
> Reload iph6 after the offload helper succeeds and before subsequent
> reads from the inner IPv6 header. Keep the existing reload after
> skb_realloc_headroom(), since that branch can also replace the skb.
>
> Fixes: 14909664e4e1 ("sit: Setup and TX path for sit/UDP foo-over-udp enc=
apsulation")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

syzbot found the issue lately as well.

Reported-by: syzbot+6eb9ca986d80f6f88cf9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a2510bc.39669fcc.33b062.000c.GAE@go=
ogle.com/T/#u


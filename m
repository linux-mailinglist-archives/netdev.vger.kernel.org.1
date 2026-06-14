Return-Path: <netdev+bounces-299186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jkt7IARpLmpBvgQAu9opvQ
	(envelope-from <netdev+bounces-299186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:40:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6DF680ADB
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:40:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C8FW5eeu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299186-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299186-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B09E3009534
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089DC331EBF;
	Sun, 14 Jun 2026 08:40:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0D204C3B
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 08:40:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781426430; cv=pass; b=UBf9UPNe2H41828c9kKfsNkqAn6eAc+R+Ybx0MEyM0+7RSi2NDphFZ/3sykt5jlC0C0PZ+gkyDuFE3/Wzv7oAc1nwCOj1FIQb/qzNIFIUSqPofiYZIToOVp4e+wCx7y/5JH23awopCi5Iall5NwNKOZfCs6mr1V/5sEt6gM2oIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781426430; c=relaxed/simple;
	bh=IcwrsGu/ePAGSMkXJHLq0sLUAslWSf04Bp5vVGyOaxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLJv14XjbzHCYDP9QHmQoYMNqrcYnL63P+O2QHSHC4Sonu85F+IhNiL9fK+mKcqiWK0wTdycJo1v7ErgOrUQwvYnrEr/r+Dwuow6D7vR/EqKWH2MwLi9zkjDqUZjipt21zFP8OLSjwSGT75VMKu3MjObWp6yW56faHNBq8SZvq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8FW5eeu; arc=pass smtp.client-ip=209.85.167.181
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-48611ccd5aeso1541963b6e.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 01:40:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781426428; cv=none;
        d=google.com; s=arc-20240605;
        b=UrgnxIMJXT58LIvBTdiavuU6LAumU9kJTeuj4erZ004xM4ofncGkNcRyGFQEZd6aaX
         KO1Udi+TIT42L/k1gKs3CkEZrqTL5uMU01t/UR0GCThU3Vkhaue9mZqsUVUMqjhnPjXL
         4O26+xljCBTy3HV7886CG3uxftDMBI3lnUTlafajjwQkGRNh+h8BPCo9dL7zk3vF0WAA
         EM7fkJFrp/XQGo5ypM1thAw0+8+xv7s6Zq+KkPU1j8CSNZ0lSTv5mkxUaSVKU87MSCoG
         Z79HS+NneAlQZ7M/W3QWJS+gxVjz7+MweiUJoMrEZmXFFJhZXLMGz7N04x0hI6nXLl3w
         iHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E0aWVmJTW1CTdHcoQnaldMbTodXse2z9ZDLK/9GD4QI=;
        fh=izd0Zb70QWdhHgL62L1esRUzleqX6U9/1T3I0BSMyIY=;
        b=kX4hVW2cE3VgiNfSO5R3AjrpC+5OokBvAl/gMxO2ESpj1qoF8gVhw66V0zQsbfe+bY
         AD2cAwWA3nCFyv36FONImcLrN7V4A+WqSRiM97siw6b0XKuMfruuAMus44zB9qDRZLy2
         ixHIeq2p5DT/9WxdTjxkjF82Y1tpXuZ5JWTKnM6BwkGu3vTvAGXsxt2qn8zMR9AmVoX6
         xRoiCkVXYSo/othlLh/mOQdkmD+ZOUqeUTBHVzMsa/XwmQalNgmbUFTcbg3UiFInqoIC
         /8LrMhFZNn+ihrJp+x1uFZnPApaTetynJ7PcWDQO5ah05gsWIvHdUgNLIqNoSslaQwTq
         I0Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781426428; x=1782031228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0aWVmJTW1CTdHcoQnaldMbTodXse2z9ZDLK/9GD4QI=;
        b=C8FW5eeukN/rWc/VdW+CmTCi/wFrKWvRkl728Ex5cVwCEOyd0uFu5Jk9ebKlYnzQFS
         dgQsqvv+otnAEbvIXTx1bgsa9UYPx0ogxD379+i9AJXcz2cfLOhDIMJOSyA25qgpEM+o
         8t6ObsZ4aFODLyFS1U0HX9MczvrbAQMABDVnCr8kgYNsbzE9BDIXVJ01wFzJrzvGsqtE
         PS//AYOBGeI2pMr+9+iWBsKqwWPOQSsVNF+W5voR02/Dn2ukXNmmLet17O6Gn/IfF3K4
         73ZpWwmYFesT/8+Yn+69mQOlSD/a+Zmbbq9EaEoAA33EE0eWs2xJm+ESavXkxR2dkwG0
         yjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781426428; x=1782031228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0aWVmJTW1CTdHcoQnaldMbTodXse2z9ZDLK/9GD4QI=;
        b=q5W6jDBISVpa54Bqwl2oMo7MFDLVqN8jBFNYs6VvoCnyVAmAGCKhgLc6e8YwShALQM
         sN4GERh0KyTmxHy97ImXBH6DgIPfz0aLLfQhKiLmlFio+sKvPF6ButifTDSNcwkyQvyo
         vObOnQ7ztYSp2P80jTIyXy7NeWRUS7N4P1akDF7st+k95BohDuga6cM+WckqgYQyPjdS
         Pc+u0OQUZUcIAZ5b3DEHMirmnQNEqC0zpdmMzoBEydwlR6kLinjogBANrLUOln0qk4Bf
         /OoPWOy1IPungVR33KtLYEWCUZd3ABWplAUc+cRsLpQUm66p+ng1GAimkId84jG7EtyQ
         Gxow==
X-Gm-Message-State: AOJu0Ywe3TKG9pw0r8d/X+3VDOizBXTuWZRUGzVxYU4Fw7SVv1cJzV7+
	+tG20c1GN3PTU43dWLoJtG9DukFUmV6JQA2qLbmyJyk4tVAr1bIbHBqCd7Nm+BKaGMdowqO6m3T
	/KA5gv6w8wmu6BywrdHRJrqC9Pc7YVfQ=
X-Gm-Gg: Acq92OE02OwEuS0l59+jCu29ZOvrCuF4KltPBW8oIVlebBa0/ICNVAzDcdVidsK0Rfm
	aHdq3Lm/ckK5arihaPNkHVSkGzOF4YqZXQ8QQV+Z0YKBoyaBt7EBT4sVTuc9wvKHrklil0D9Mym
	zGNLun4Od/wT46/VkrlSt/TOcO7oa92UXhmUze7byqwO7VVWtYRaRqkwkH3nTFDVbuZ39yw/1re
	Jv4FF29Nba+YOPbG/L4nJyUlNxKA5U1Q9qSNF56aa0GRCjSiW+y1WgpqjHd7R7quu3TVWAo9NQU
	uFG5E7l7DZ2L5cmfLWm0N5PSAZcV4k/JNc1wsLyij95HgS6BGg==
X-Received: by 2002:a05:6808:3508:b0:479:e7c7:dc61 with SMTP id
 5614622812f47-4872f4939bemr5942436b6e.26.1781426428484; Sun, 14 Jun 2026
 01:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610202508.845328-1-mmyangfl@gmail.com> <20260614004530.402503-1-kuba@kernel.org>
In-Reply-To: <20260614004530.402503-1-kuba@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Sun, 14 Jun 2026 16:39:52 +0800
X-Gm-Features: AVVi8CfZTasBjUka4kKFwv_PV18oVOHaPvvXi3r1pQJHndg5pZz48WMTInqGuoY
Message-ID: <CAAXyoMMvVjmob3fCXM2qxbKPQQj4KzGoT2-14ONfOHh2Auee=w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: yt921x: Add limited ACL flow
 statistics support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299186-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC6DF680ADB

On Sun, Jun 14, 2026 at 8:45=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email says "I thought this is a false positive and the register is
> Clear-on-Read but you seem to be writing 0 to it when allocating."

...

> [Low]
> On rule delete the priv->flowstats_map bit is cleared, but
> YT921X_FLOWSTATn_CTRL(statid) is not written to clear FLOWSTAT_CTRL_EN.
> The counter remains physically enabled with TYPE_FLOW until something
> else reprograms it.
>
> Today this is benign because acl_commit() zeros the action register so
> no rule references the counter, and reuse rewrites CTRL. However, the
> header file enumerates other types (TYPE_CPU_CODE, TYPE_DROP_CODE,
> TYPE_PORT) for the same slot pool. If a future caller picks one of
> these types without first disabling the slot, could it observe stale
> counts from the previous flow user?

It's an absolute hardware counter that requires manual resetting before usi=
ng.

> [Medium]
> This block runs unconditionally for every ACL rule, regardless of
> whether the user requested statistics. When all 64 counters are in use
> (statid >=3D YT921X_FLOWSTAT_NUM), the rule is still installed but
> silently without stats; the user only learns by querying and getting
> -EOPNOTSUPP from yt921x_acl_stat().
>
> There is no NL_SET_ERR_MSG_MOD() at install time and no kernel log
> message. The same function explicitly emits
>
>         NL_SET_ERR_MSG_MOD(extack, "No more meters available");
>
> for the meter pool right above this hunk.
>
> Should the flow-stat path either be gated on whether the rule actually
> needs stats (so unrelated rules do not consume counters), or surface a
> diagnostic via extack when the pool is exhausted? Otherwise an old set
> of un-queried rules can starve newer rules that do need stats.

As I know there is no way to specify whether the rule needs a stat; it
always assumes rule has one.

> [Low]
> After the YT921X_FLOWSTATn_CTRL write succeeds, the bare "return res;"
> on a failing YT921X_FLOWSTATn_STAT write leaves the counter enabled in
> hardware while priv->flowstats_map remains clear. Likewise, if any
> later step (kvmemdup, yt921x_acl_commit) fails, the err: label does not
> unwind the CTRL write or the meter configuration done in the prior
> hunk.
>
> The same asymmetric rollback pre-exists for meters and is implicitly
> healed by the next allocation reprogramming the slot, but the new
> flow-stat path's bare returns bypass the err: label entirely. Should
> this teardown path be made symmetric?

No traffic will be measured by the counter. Any subsequent calls that
pick the meter / counter should reinit and reset it before activating
it for themselves.


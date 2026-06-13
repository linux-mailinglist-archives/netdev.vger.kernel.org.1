Return-Path: <netdev+bounces-299042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aeLUKIS9LWovjQQAu9opvQ
	(envelope-from <netdev+bounces-299042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:28:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C2D67FA21
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:28:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MduQ+v6W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299042-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299042-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FF5D302E784
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65253385A1;
	Sat, 13 Jun 2026 20:28:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31512125A0
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:28:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781382510; cv=pass; b=kkQDi2aK3XBh7kiR8EmpT+0jHDJxjpA9xcHfGgluN78xI1RziUclOEZl/BrfnPUlyLPKRBqx8UCZxHrxkfnukjEvkQ8A+ETbQYtu7DAe6DoCuREOqbpeIAoVtmLMovLCIcZvh31UKqQBdgz+0RFjDL8t/9oXYMCw2qKg6CGEfmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781382510; c=relaxed/simple;
	bh=b9/oSdVSC/EUV8LRtOrMkMKy2c5RqiluhZQ761v3h/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8e2IynA9+OQIbUYgN2CySU5cQwfONjtWfS7/4uE+z2SIrqbvXBqHus1gHqQC84kQLquq0LXJ8V0Slri7xjVvXaoSO/qO5gR9IZyCh2L8s8UTxkuRD8NGgbvP8MfCg2Hz7UwBtXH7BQsa/gfk1RbjDtWdazzXDxrqV9Okm6BUOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MduQ+v6W; arc=pass smtp.client-ip=209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec49f7e35eso269194366b.2
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 13:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781382507; cv=none;
        d=google.com; s=arc-20240605;
        b=B88qnEyDG+s91G4QqwdN1fDy+lF77uZxyArGPIAn5J5g5sjbEoDwPKANGSS+RbCCiQ
         shas81nS4LYCtY7Ht7XvwXDqP5XskyV79dPiGvqTnrXJQhyW1ctLzMVsjQ38+UYFZ1gw
         TzG75CuIVtEzjDIZ0gnIyGX1ZlXm7Dve7REW90GYxjOYJYqZJ7T+CZC0wcX7tYvrXium
         GCUFuXomXDTYB1mzuCcg3EeH0kyw+/a9uM5vhtcQLrSZBy9XRM5P5k1r1st1ABtgHDql
         UBLLJ6NdU1ChjTkSPVn8l91GyR/yBfIKHHZ2eL+o5bzJQ+bhDnhMo36pc9qlKlf8ms6z
         JDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UnkZWhE7tWmZpEwdlkZy3o9x4B2bZY8eOwKFdq4sdpM=;
        fh=ds5Up1sB3aqOTWKMThDXdI69OCqJK/kQQujZEHttxXA=;
        b=QK6T56o3kC97iixttvea5KXPCjSHbKrJmF7Jy8O6L6MWzq511dHstiD7I+1CpNRTSw
         CWKTssHJRYgCDqpriElGi8Tm0VJb7nJuPeei7GvSffuJHguNxgZ4nr9pGXCgONusfsnG
         8K9dM9f5Smjx1EWChLUkLY4AGyyvP5VxqfTHPZ5/3GhKFgQ/YdwrHGtdyXGrQStM580P
         z72NK3JXnK04QfzGtfvY2MdG6mVXI7oAW7FlhQWFyuMS6Q7SF55TGUHOIgSMm5n/AhSF
         MwieeLxM3p8C8fH8/e5NWY5ebgLE5+mEa24JPPPIyrqJdhcRVcGyjMLZ3v1P0OgmDk20
         a0jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781382507; x=1781987307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UnkZWhE7tWmZpEwdlkZy3o9x4B2bZY8eOwKFdq4sdpM=;
        b=MduQ+v6W3HKBdFhqY4J3u9oGYg7x+pC+AQEQ3bXPWrc7DTHSXwnWp5w8o/CBu3tdaW
         36+VfEYTIblbg0LTwsJ9WQANLW8COoumsu8KDUc/I3SBIPVO8Kiu67LLkbmQglNie9Ow
         gIrVpvk0PGsK5JWEBcOO7kl29h8TOvw96r8F18I2etjp4ozldwr2UcS1nICK+jP1WRYd
         GlvhBx55l1ajeAc0xup04TNCxDT97D++tTt23OWrLmV7l4y6MNgHct7qnSjzNA1V8z12
         oPa7LAO5QcbBtpAa8a4PFFteh983kYZO8DHQeUmPVXMzhEx5s4IrnqzOKzFt/SJWsoJJ
         NRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781382507; x=1781987307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnkZWhE7tWmZpEwdlkZy3o9x4B2bZY8eOwKFdq4sdpM=;
        b=axVVfAKjbOiN0tfz1qvG9OSmWi3/3kLxdB+T7duLCC+eLybWp3q0cCB3DTIDQ+KUy7
         zPZ2bOyRSF7yIYQC3EkbwyR2hKkMDOYEjuRurnFp03QCeYMV36iS+XtE770gbX2RZihk
         5NlYa/2fwqQpNdMl13men2UQMQtJzhCFkHlpvGi9+a2u7+WgCAs1qwsbZqce8tkpedPg
         ToWs0seJ/VitaYZORLG7ylQ0L8WHomq7MSit75KX2p9vzodp8Mkl+QZTtCvB0jbeSIPg
         oMzCTTid+w7coul59Vln8Ke1elopYeMy0wk15dLNFUhU68HdMRYFMgtDX9QEAHwIKlMz
         8WlA==
X-Forwarded-Encrypted: i=1; AFNElJ+Ewtc1RxIkR+41rqLrjA5xB0n7qLd/ODjOLaHCm/MkR+cpmF+4yz6ngIKawpWzyHcMVsJbm+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9oBuBAdACJauFgpXmo0+BXGMUHgpE2Jr9ZxjQ++C7jL9rpwmF
	Xg1PNIoUNi/D/6ZFQE5C+sEFGq+sIPn2tVYgy4bOk/YOsvCFjkbSaYbQiCeNdyEg3DKNHzUJwVE
	82bUvLCpddz7F0RPrJItYq+nXpod8NB4=
X-Gm-Gg: Acq92OE1VpdjBSqx7qxy6aNRUNLmjW713zqW2XhxPqdlDx6lzhHvAXVjHKthLuJ5UWE
	+wEQIY/L2f5U24uDI2R67IYxBnCsygodfiIx7eQxf4r0zCmLx+cG+N4p6O+pr21tmlXeIQiQkiW
	TJiDpA3M/7bXP97HfftgfIhbViHZ9oaOzDJH5B17DaWcgMgRX5qx2ntc+dcuAA+ZfgFD8TceQrQ
	uJFdeGjiLHJryJsYPAm7YEUh0U8Df0kCsbc7gU+JqzBhm7s6vs3x6TVY6VY4knvFYgilTToTpmD
	JwSXnPZQhnT6rkxD0XoiPJtYaNsuasHYJr12xgbS
X-Received: by 2002:a17:907:75d8:b0:bee:4562:32fa with SMTP id
 a640c23a62f3a-bff4a00e3dcmr101305666b.14.1781382507376; Sat, 13 Jun 2026
 13:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-rtl8366rb-improvements-v1-0-9232286fc20c@kernel.org> <20260612-rtl8366rb-improvements-v1-1-9232286fc20c@kernel.org>
In-Reply-To: <20260612-rtl8366rb-improvements-v1-1-9232286fc20c@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 13 Jun 2026 17:28:15 -0300
X-Gm-Features: AVVi8CfyDCmc-GKotakf8OfdGX21eeQ7IUWQiSangwuoAOWubeGdejhdY641ObE
Message-ID: <CAJq09z4P0Hwv_v0KPSCh742hm7rSwjqVtQRx2eFuX5K++F749Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] net: dsa: realtek: rtl8366rb: Switch to
 generic port_bridge* handlers
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299042-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04C2D67FA21

Hi Linus,

> The RTL8366RB is using its own sub-standard port isolation code.
>
> Implement the required isolation helpers, use these directly in
> the port setup callback, and switch over to the standard port
> isolation code.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

> -       .port_bridge_join = rtl8366rb_port_bridge_join,
> -       .port_bridge_leave = rtl8366rb_port_bridge_leave,
> +       .port_bridge_join = rtl83xx_port_bridge_join,
> +       .port_bridge_leave = rtl83xx_port_bridge_leave,

Maybe you wrote this patch based on a previous submission I sent. The
merged code requires both port_set_learning and
port_{add,remove}_isolation. Even if the next patch implements
port_set_learning, it will break bisectability.
You'll need to change rtl83xx.c to make port_set_learning optional in
order to keep the old behavior for rtl8366rb.

If learning remains enabled on the CPU port (as the rtl8366rb driver
works today), the host's MAC entry might eventually expire due to
aging. If that happens, traffic destined to the CPU will momentarily
flood to user ports. It will still work as it does today, but not in
the recommended DSA way.

On the other hand, if you do disable learning on the CPU port, the
driver must implement FDB callbacks so the kernel can statically teach
the switch where the host MAC is. Otherwise, the switch will treat all
host-bound traffic as unknown unicast, flooding it to all user ports
in the same bridge continuously. The worst part is that traffic will
work, but that flooding would be a regression.

My suggestion is to change rtl83xx_port_bridge_{join,leave} to check
for the operation's existence before calling it, preserving the
current state.

>         .port_vlan_filtering = rtl8366rb_vlan_filtering,
>         .port_vlan_add = rtl8366_vlan_add,
>         .port_vlan_del = rtl8366_vlan_del,
> @@ -1830,6 +1792,8 @@ static const struct realtek_ops rtl8366rb_ops = {
>         .is_vlan_valid  = rtl8366rb_is_vlan_valid,
>         .enable_vlan    = rtl8366rb_enable_vlan,
>         .enable_vlan4k  = rtl8366rb_enable_vlan4k,
> +       .port_add_isolation = rtl8366rb_port_add_isolation,
> +       .port_remove_isolation = rtl8366rb_port_remove_isolation,

Regards,

Luiz


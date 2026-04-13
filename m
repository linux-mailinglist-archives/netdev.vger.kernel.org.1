Return-Path: <netdev+bounces-278192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Dy4JFtO3WnYcAkAu9opvQ
	(envelope-from <netdev+bounces-278192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:13:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3329D3F305D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96D99300DDF0
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AD6392C36;
	Mon, 13 Apr 2026 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkOFyXYM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454DD391E65
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776111002; cv=pass; b=FaqpwgPAHwJez8YkLtRfGYHJe2+Tw8EyJE19bpBDPiyUWJ3GDtTqg+yctgl+01QsHHJZKVKP+zOHgFcrrzI5wxyqWMxwR7pfNqEkDDlQHf7xK3EL+N2nBHuJJJ8L9zO3kn72kC6gthOhTw7sszjSHBG/KRE27nUCIvDYvcwz0HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776111002; c=relaxed/simple;
	bh=TSaae2JMjMSrj7G8Rx/iOQ52jYnr3TLUvG23wwobwsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaD4S+j7qChNJvV+eM6RB0DKFdumYl5SXX+Mf+QejdlX1WYkVLuWkMmlBMDLByr1PRgRBvHqfQAE4gws5rtMhNX98XiBbG5dK+mvyYmurcAC3fAdmIxCKVwAKyJkbkaB8bqGei0lgZja74S8/eqcHgdYJ5K2dYPuHv28QJw7Qrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkOFyXYM; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d9436f2adso57356091cf.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776110999; cv=none;
        d=google.com; s=arc-20240605;
        b=Hwk7AIlQoxhIRgcPEX+zvtjpQDYY8FcEIZLTGuLagoJjuGdKKJJxM9FZ4K4EB50NvO
         eQuT4FZACrrYlYVWE0spOm1q5dw+6+WElz4WI/OhCltzzY1ipdZuhR7sF8XkonOxxCJH
         3k5Grr5bKU+TjA4lIDX0rDEM0Ie7kSiTPB34xrxCpNn85F+xDy2CQGNgHf/TRXzs2t5p
         hidJ4UQ5AVsX0IsQzbiC7n9uWrSb3V83Tg0b96t7t/SX9FSEGS6fGomx3Cmg9ENXKf3x
         izWMkpygfsaXqIXYJiIw/T5jouDLeol3vElDX9Im02YbWd0wP/8efbaQQ9IcjVq+Rs2c
         2MlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PFVpay9aLRIXw094XmrL2r8cvxtLz/HHt2s41HTeDh8=;
        fh=3Wsg1Jeohsw0YlMf+33szOMqv7SU7qtX2gfEnCstYtI=;
        b=JxKg3fwEXI1UkCked+ltXcKQKf2FjbSJHwnH14MKRpKNyyICAqD9BD2ja7WEUxxmBz
         XhZUAkGLrxv3iNnC8tN+pN0nkUJiAB/16W1MDEhgDmmPjC7VCSK1fOtvaDmkNinRfv72
         Ws2UiHLMdbVdYVkRIRAQkSDRg10lu3T0vJ9tmMVF+Nll6j12StSv4Zp0ko2pMihOwgDM
         IKwOZH59IMu8EkIvpf4VAxyrUN3Jcon8D+ocDtwXc5HhvpPOcuTIueC0yB2VLwuSF+Zw
         ORBCgsmtzaIf+v/dfurLnz8nDnGggMZC0XHV8omrTxzC3iRj52onUrhCSKW1V6lDPjai
         Ot0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776110999; x=1776715799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFVpay9aLRIXw094XmrL2r8cvxtLz/HHt2s41HTeDh8=;
        b=pkOFyXYMYvcx4kH/XYfrjETUbK8ADfl++UYuoQWkNCUFFCfCP/fDPstEsur/6rcUAh
         UK2lLBtYNvPFHFo9J37J0In7MKcnsE/W/zFGLmlXKdShW35nuI7cUlDu7XLaImNlk7cM
         vKHaYQ63G2C8F16varDdcI7HZ8HykkJI6mCEC6QjyDhnoVPrgqRXKepwkM2vgTwGSZiR
         dHvkEkJ9gkC/UbP8bl+cUKzuE3XpiHZEgCxv4v5ZO3FAm+Xeoq/t6Sr3ZnOX/3l3eKjG
         lWT0daW/P+R2tjBXDm+aXrz8UeNBKFolecdWLcPGcW5Smlb1D1fj/qPCY7S0osqKXNuK
         NX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110999; x=1776715799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PFVpay9aLRIXw094XmrL2r8cvxtLz/HHt2s41HTeDh8=;
        b=RuWPxSLcGztURY1zO9oS6G0jM0gFVNpsQzfz2m2/D/31b4LYRuiehQvZzEe9CqBOE6
         f0isBC1AEm2l3PTTUaYArQXiA0LPeB3MsZYb/biROneKEzhFvGApRIDixeFi7uPfM/fS
         NubuhtR0dGaPJcDtNH6n/rfrhNxzfS09SNUDMDganGK6aRH4vTfoRcz1C6HjbF2XwbYy
         YP7s/uSvKqkdRbu+UJB0pMCikNsSZj4QM9LsY6pbOzFOV3q25AcnvpWZdDUa2D+qA91k
         LmKFx72BY4oO+r1vQBXYsSBlLGO3+Fb4qrGWQqE7qDZGOT8xbpmul8MitSrMZZfK2FET
         265Q==
X-Forwarded-Encrypted: i=1; AFNElJ91S8pXIQnKPMpCgkfiHxWCXZ6GHSm9j7KxQSFXAHK8+v89DkV4QyWHHXJnAGh+OtwXWZVH38Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkPcUtPMD4QiBK+Hsdk1dSGaZrY4FxdnaHu8MqiQTfnFMqLzIg
	Dq5Ld+W0ZA05rKMEbW0HnxDPPVf1SJrD8/OVzmG0n/YTgqq1NAEfTqXMGQpLSfRhLNxv7kSKuBW
	9vmdq8qY5S+MDDtfIzjA/BDhjsebulLdJmy1l4ESA
X-Gm-Gg: AeBDieuUL+gjz2rSArmt67IjXhCcJSmS8KvDz4UcUQ6927ZiGZyZS/J1Viynyb3ut7y
	9jP1YkkQ/XqXhBaOVnLw6QDskDsri0Ydwepr4LP1qdmme3P6EE85fL5y9illtnY0V6VkcV0VNLa
	lhvVQgd/qkeAl05QfxwLeNlIgENcmj5WOA+821RNGXVZGP84dCKud2L5INfRwnpOl1sSXug5gYz
	dUypt2/HWA01uon5W62SyMC2GK+fjmJeACyw6FLB+mUy88Btv7Mh3RWKNeIvpveT0rFi0t93HeT
	a5kQw1Ra6mBXbmyHnYrWnxwKPsoAYxHqjlvdYEF4lZ9cRCjRvzT0tDz4IvzyLesZCKL2NUv5kA=
	=
X-Received: by 2002:a05:622a:550d:b0:50b:2876:586 with SMTP id
 d75a77b69052e-50dd5ad112emr226296811cf.5.1776110997701; Mon, 13 Apr 2026
 13:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413182225.10683-1-devnexen@gmail.com>
In-Reply-To: <20260413182225.10683-1-devnexen@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Apr 2026 13:09:45 -0700
X-Gm-Features: AQROBzCNgCRJVXctfDh6yyQzR_TEOYZKCbp1HOyw6mceBcdeIaWVjS3CtoyPHNg
Message-ID: <CANn89iLE4k=N62i9hs+GumpP5v7CU7L+Qj644=4Zk74_P0zDxw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: check qdisc_pkt_len_segs_init() return
 value on ingress
To: David Carlier <devnexen@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Krishna Kumar <krikku@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278192-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,fomichev.me,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3329D3F305D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 11:22=E2=80=AFAM David Carlier <devnexen@gmail.com>=
 wrote:
>
> Commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> changed qdisc_pkt_len_segs_init() to return an skb drop reason when
> it detects malicious GSO packets. The egress path in __dev_queue_xmit()
> checks this return value and drops bad packets, but the ingress path in
> sch_handle_ingress() ignores it.
>
> This means malformed GSO packets entering via TC ingress are not dropped
> and could be redirected to another interface or cause incorrect qdisc
> accounting.
>
> Check the return value and drop the packet when a bad GSO is detected.
>
> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>
> v1 -> v2: reorder variable declarations for reverse xmas tree
> v1: https://lore.kernel.org/netdev/20260408172307.46498-1-devnexen@gmail.=
com/
>  net/core/dev.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

NACK. This is is not needed.

I will not even bother, this is an obvious LLM based patch.


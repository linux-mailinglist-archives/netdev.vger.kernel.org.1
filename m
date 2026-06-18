Return-Path: <netdev+bounces-300544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2jlbHTF4NGr3YwYAu9opvQ
	(envelope-from <netdev+bounces-300544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 00:58:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F266A300D
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 00:58:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="JZ/c/5Ms";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300544-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300544-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F8C303EF58
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C75F34EEE3;
	Thu, 18 Jun 2026 22:58:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6137082D
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 22:58:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781823522; cv=none; b=nXFdJQRM97C4a4hjpQmUzlWn3oB0OGsPczryoyHqeZDcvVkT3/s+ckKmKOlzPBQAXp5cjnAjI0LbCsFJBEtaRWrZS1zTsx9nU/JdLU4RRtOV3eV+mRaAtzSXE6yurX9k+KObODbEzKFxJMZ2tdHJ8BDCN89W8RpQx+7zizxwIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781823522; c=relaxed/simple;
	bh=peJO4E/XtUMXcfGYtDn2YLaZZ1d1xMmVhWDN2BD1s3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vmgw8w1jGeYmKnBj0gRsYc6n50VanSe+qckMpJG55/ZK+iXiV8T37xwpWgSa+ZiKw/qwR4Mf4azdo5NSc60mEbTly+/DVOUQIS0jnpFKMf9WbBaUjupv9qn+zY1DTHaJHAj89eGLn7+t1fwEXX7ZYAsfbIaT3WSXpaFC7Z/X5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ/c/5Ms; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1BF1F000E9
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 22:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781823519;
	bh=peJO4E/XtUMXcfGYtDn2YLaZZ1d1xMmVhWDN2BD1s3E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JZ/c/5MsnVAY4A4Sw/SSn9MbjZ6J7mD0t/ya4NS/HkjC0z/HPhroFZhFfKTaYO1vd
	 VMFKn0CmRdq+OPiXgfQvwqz7BHZ8sKuqn4iebxnJbHwJwZxfMXADoaJB4taL6a4d/M
	 BF5DiRNxtK0dm4jeFwuOoVKVvQFlBoeFQ+o1IqLzmuaWVRVdNnX/vdBA3p0U4XIebl
	 WOBU39fYaZ/jNoyTUQmTYfJqjjsuR633sD+M7vTreoXf7px/IVlyRiPpWUubVZUvnW
	 peac/7Uv3piIzWbVco7IaiADqoFo4d1e+sNUC/ets2DbDMea3AVWj/A5/jVu/rbaLW
	 Tj+tJfH5JVUwA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa61e3d3f3so1548378e87.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 15:58:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YyqJQi/OxRbv1ScguSrMLCBUp83uw7lhW5DOWbajWD9B/1G6OzH
	AXT4VaAPcpTDPHzBEpMgvxg5xWh0rbdOiXn+1V1qVkij+Y933CdQItBHHyrlERTagmSw87mYsHk
	IFsNH5WI+EGOLU/CK5Nz5ATYHTuvyHu8=
X-Received: by 2002:ac2:434c:0:b0:5ad:4875:930b with SMTP id
 2adb3069b0e04-5ad562beb9fmr258713e87.30.1781823518372; Thu, 18 Jun 2026
 15:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618140200.1888707-1-mmyangfl@gmail.com>
In-Reply-To: <20260618140200.1888707-1-mmyangfl@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 19 Jun 2026 00:58:26 +0200
X-Gmail-Original-Message-ID: <CAD++jLkWqJFQb3_A1DY1G6Y4xJ8j67YNk-E1Xd=KgFdt07a=TA@mail.gmail.com>
X-Gm-Features: AVVi8Cfr8AaltGNfugAcZaBqpPicOtQXMh1XVo06OzT8Fr6XHb9Qyb3KQrv8Wmw
Message-ID: <CAD++jLkWqJFQb3_A1DY1G6Y4xJ8j67YNk-E1Xd=KgFdt07a=TA@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: realtek: fix memory leak in rtl8366rb_setup_led()
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300544-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:luizluca@gmail.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0F266A300D

On Thu, Jun 18, 2026 at 4:02=E2=80=AFPM David Yang <mmyangfl@gmail.com> wro=
te:

> led_classdev_register_ext() only reads init_data.devicename - it never
> stores the pointer. However, the caller allocated devicename with
> kasprintf() but never freed it, leaking the string memory.
>
> Fix it with a stack buffer to avoid dynamic buffers completely.
>
> Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Good catch!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij


Return-Path: <netdev+bounces-264351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ11OIlzqWnH7AAAu9opvQ
	(envelope-from <netdev+bounces-264351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:14:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3EE21164E
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3AA73059A8B
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21864397697;
	Thu,  5 Mar 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwFj8wHa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315F334C28
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712799; cv=none; b=BK6nZLok9DRZDhXZi0HZxg+V7G0EedqiB0TJt4P72t86yYme0oSOAAua3AnBNR8MpxZX7N3oFTYI4f0R744Wjs/BwzVwn9uYi/mhC06caCN1+HO6EBCA0u64OfTZ5REQphSIQUCVJMMOZI1fCB1S7sJiYw2RBof4EihcomMpGjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712799; c=relaxed/simple;
	bh=QEEz7bKrTbaIdtntnCFjm16TbQ6yV67W+dRNaUrpuGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gq5wAXoKTokrarucg6jmCjPQ9yTV6RXGedUlJ20qvWRo/tvRxXfEbi30o6gn76mRAk9nJ5b44mkkileIk0+zkGe5Qv2VU9d2tj6fB5eRexvcG1vNYNVuZHO/Ftxp6KxfpYNAuuo7jmW+hNO9Nx/R3VJXvftNOl+Ajh3eF9NHWvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwFj8wHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE720C2BC9E
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772712798;
	bh=QEEz7bKrTbaIdtntnCFjm16TbQ6yV67W+dRNaUrpuGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KwFj8wHaP1ZKLGkPdRDxKwD5C5ZQeR1wz4ZDZeN3/Jd0AcAWvOo/5s2bR4/hAe0yD
	 LrIlQzzcrA2+AscZGZCeip52ikXi7Ac+mUMatonfwDUlRQHvhUXQHQAMdMuQrqjrYV
	 gmIUBezSpHmv2fjOJkeeam1vdneYP0h40mA3zqhB27a0GKBrbR7DLUxdUlbrKdLdxK
	 pEZboCbol+8KNiZ9WiOfxXjsWUgYfXOp9l0wXzaj+b90NDh1VBYrz9ouTLGsa7e0w1
	 tZ4akV29jClHbg7Viz38MHr/rkuFYyEd0lNTuRWgfRjDfGmGRd3GMnbALyIElBYJ9a
	 RufoIGv66Mx3w==
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64aedd812baso7040507d50.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 04:13:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIM48UMdJxqOJVctCglpN5GYcEOoqKnGLe4cLF2IE0reUag7218iRae5GJJtSu9Q1yVYyG0Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcaKZ4Tk+PLK3b+G7i9VdTjovbY6zpEl+vCLQSCdx7hOKc87xW
	K4neCI18eF0yN6sbrdvqdbCcL7+DgGoTqEIZ8InaMKLFzSlrHS/WjGCcY4yG/RvWfUKQb0OVvOo
	41ExPqFnUXyvyS74KH0GQZAsc+leQUbs=
X-Received: by 2002:a05:690e:4107:b0:63f:b4ee:7920 with SMTP id
 956f58d0204a3-64cf9b22cdamr4209918d50.11.1772712798000; Thu, 05 Mar 2026
 04:13:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-realtek_namiltd_fix2-v1-1-bfa433d3401e@gmail.com>
In-Reply-To: <20260303-realtek_namiltd_fix2-v1-1-bfa433d3401e@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 13:13:07 +0100
X-Gmail-Original-Message-ID: <CAD++jLmAT7cQudGp0n1QcnZZLMSd1j4kc7ojEfta8Egaze6yuA@mail.gmail.com>
X-Gm-Features: AaiRm52PEY6bStl9YYAIz4Tc_KcH2BFsUxAmecwE1hn6bFFyXDIQSzuAbuitX_4
Message-ID: <CAD++jLmAT7cQudGp0n1QcnZZLMSd1j4kc7ojEfta8Egaze6yuA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8365mb: remove
 ifOutDiscards from rx_packets
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Michael Rasmussen <mir@bang-olufsen.dk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mieczyslaw Nalewaj <namiltd@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1D3EE21164E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264351-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 9:25=E2=80=AFPM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
>
> rx_packets should report the number of frames successfully received:
> unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
> counter) is incorrect and can undercount RX packets. RX drops are
> already reported via rx_dropped (e.g. etherStatsDropEvents), so
> there is no need to adjust rx_packets.
>
> This patch removes the subtraction of ifOutDiscards from rx_packets
> in rtl8365mb_stats_update().
>
> Link: https://lore.kernel.org/netdev/878777925.105015.1763423928520@mail.=
yahoo.com/
> Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for =
RTL8365MB-VC")
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij


Return-Path: <netdev+bounces-286568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD2CGrOnAWrlhQEAu9opvQ
	(envelope-from <netdev+bounces-286568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:56:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB51350B695
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 206E530053DC
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C793BB9F8;
	Mon, 11 May 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCTCPQOF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE037881E
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491927; cv=none; b=pSPPgeFt4/6Wi1/uu72AnGC4u5npv8g/R9C3t+TrQ43zQYqjdGD/2kP2acWevQ7jWxKB9OzOT7xJxqLRdDxndAAMUc6ZtM9wZMW4ECVsyB7WNUVe/KeStpaY6XKSZPYy3OIbMip7kdl4xcQrhZ0yFjNPYe07mD7YwByEKJopoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491927; c=relaxed/simple;
	bh=fF6sRhRSZaRfuBy+xPUpZo829HUzdAJ6MHidAs32mdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRbzuYDTIOgnObvPg7rhCZBvDjgkj43vwGV709U5kiHqyTO+lCAlN9FEQhpQxGkjC+/W986Z6bhqseLNkKb7pkWyG/7AL/qwAxbQL9o6EPQuSPN5QWW4i/xujGAXRNnIZrlsxlHomd49Mo5zcFASQV1pZFgd2SeuQAjh8NyOS+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCTCPQOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7007DC2BD04
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778491927;
	bh=fF6sRhRSZaRfuBy+xPUpZo829HUzdAJ6MHidAs32mdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HCTCPQOFzrDqYLJGOTl5krcAAtqvMHM/FafelVfk7AfjZqTIQpLW7Bxv/k3RWdP7j
	 Ns3wjUd6yQ0Hif2jej7VJwxzMFlEClop3L6vbNTMLvRPKSMbaKS/SfZQ6TJ6cLYi0S
	 yxo61Jy87wHlT6W7tqxpC70tO0PV2H5k+SW7Lt9AqjiodVfThkx0n5/EwFVmHUDMp6
	 Bx7HtNT7YHZKMz1HcG8tBquROqtmY5FBjl81QmK3+3y10FKOvlslrh3yJt8V6poBTV
	 3HYKpUC7SgBvf2rdLb6LazCM1h41Jc69XDT4ZdnASCyON6Tp5xUNWrLYACrqdjL+AZ
	 FkbOmWg66kj4A==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a884815606so4022867e87.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 02:32:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Tzj8U08FQsQgISCa0pwVo8PC8YCXsMLOFrNKmNsWOLrHXO2FZit2UyjhWCl9aYvLtuKM8P60=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1KT/QItPrvD9vV/oyzq1MteHohKtJfrr0pQL2dVSo6WNMqBI
	OI1LuhdCyu7G4QoKb4NloEtDlnStEbhVonwbb8rVFsFc2LGtxfgElBu2K1Y6GlDvdsKEgGUPbOs
	F9PpePBE98OZbKe55/BE0ucyZKc+n9vg=
X-Received: by 2002:a05:6512:40d1:b0:5a8:88f8:9ed4 with SMTP id
 2adb3069b0e04-5a888f8a070mr7186058e87.30.1778491926055; Mon, 11 May 2026
 02:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
 <20260510103404.21b60138@kernel.org> <CAJq09z6SBALacbkqpv1KUN6_G+Eax_5entFX-_-cnh3wLWN-gw@mail.gmail.com>
In-Reply-To: <CAJq09z6SBALacbkqpv1KUN6_G+Eax_5entFX-_-cnh3wLWN-gw@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 11 May 2026 11:31:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLk6acsFQVOHw6Dq-nu-Uazv7U1Eg=+cNQao0AHme_AQyg@mail.gmail.com>
X-Gm-Features: AVHnY4IJOx3ucXfi34xTmzMcgQ_8FRVMOueoYr4Afa0qubO_IbzPZU4UszbwbFM
Message-ID: <CAD++jLk6acsFQVOHw6Dq-nu-Uazv7U1Eg=+cNQao0AHme_AQyg@mail.gmail.com>
Subject: Re: [net-next PATCH v3 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, Yury Norov <ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BB51350B695
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286568-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 6:58=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Yes, I'll have to rethink how to deal with the HW limitations. It'll
> take me some days.

Thanks a lot for your efforts Luiz!

I'm excited about the patches and look forward to making
some RTL8366RB modifications on top once they get merged.

Yours,
Linus Walleij


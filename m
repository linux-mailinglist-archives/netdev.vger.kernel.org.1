Return-Path: <netdev+bounces-284363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AiwGYbi+WmlEwMAu9opvQ
	(envelope-from <netdev+bounces-284363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:28:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB804CD786
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA6FD303C27A
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797BC43637B;
	Tue,  5 May 2026 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaVy9Ai0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56613428471
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983968; cv=none; b=tfWtgZQrSBLZpKruxsORKJOfePBCzRwlGDGQ95mbnV78sglFJGF7W/sBrpkx0+LSkVKHp9HO4S8iO1bqk0Jqd1ObD/0VSI7IHKjZC0WU/Zx00GbQ10TEumzcrUO+fMKxwZLex3NnXWBeH4eOqsQgGY4lh2s8fx0n6S8GON+81DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983968; c=relaxed/simple;
	bh=5hLVaL28JJfz88TplmvBGKTTDmKhsvXSYeIBe2Tdg+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oByZNf25Acnly7NtDG+NrRO0lTfI00Y1vFDOrYjsaJEHce/ePoSejyOpfVVK6ZBkqca7/aAB6lwAeU7N25TC+/zGxY4zFcHETLweNAoNoOcGTWo6aalurPAM8loAVOmQ6pPINfJt1mZAUjplVa52iyNUcghH1ZsXvAQXzzxU0uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaVy9Ai0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BA1C2BCC7
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777983967;
	bh=5hLVaL28JJfz88TplmvBGKTTDmKhsvXSYeIBe2Tdg+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CaVy9Ai0YIgkSWSdfW1AW0YZni4IP4GHX0xRMD84cr0MXfjxGQ90XAebcuz9A1Zmq
	 CEEnCY3ubpqYPHrG6QM8SU7KzHF4JuggKbjl33PY5bvRaYnd/0TJZ6cPfO5XrQ2qX2
	 D+ZJPvK4S4GnByrv3pCn7IBalEj+VeHJDrxnJkqE9ezgnroR7v/TpvdskaJHUyTwZC
	 1q/P9VYKIclBZbHEQQxB/tC4oaaDAFJBUd9v9R6gwUr4MYmQkRGAs0bCDJ/DpVVxTj
	 Qth3KWWrBiQbv5ZtQSeGcb0D/MQeiGbCLWOmy9I6H9JErdtMrGltjZx9aIuF7VKUHe
	 nl+2BwmIUpv4A==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-393800f638bso25281841fa.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 05:26:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9TlvBYcnRd5zITNlgOBWi2vhosyRkiFL2mCoEP8kY2SpstnGeWLIiWp93XbANsUBBAyi20o4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuHyr92hwdV8LeiDjIzWoIBGISpih72hT1Mg0OVpL7DKQzpSC+
	d4Fax2x0xak1hVKIIMJ75acGq6hktzK/xE/TlUCWshQQ0H5D95c1LlLSdS0idtVn8x0MgQRq80e
	EzeeBpCcJ9xaZB0BcKkgQcR+FMrdliqU=
X-Received: by 2002:a05:651c:b26:b0:38e:a58b:58c with SMTP id
 38308e7fff4ca-393b4e5d10bmr12059521fa.30.1777983966610; Tue, 05 May 2026
 05:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com> <20260503-realtek_forward-v2-6-d064e220b391@gmail.com>
In-Reply-To: <20260503-realtek_forward-v2-6-d064e220b391@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 14:25:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLnc=6qitKh2An-_TyD7Ms-ApxeU+upx48HSEaHbhpSn_g@mail.gmail.com>
X-Gm-Features: AVHnY4KT5elHRuI_L1dXBFmlcySAQMtFk67_n2D4Xf_bRRZNNjwq8ceFVzp_fEw
Message-ID: <CAD++jLnc=6qitKh2An-_TyD7Ms-ApxeU+upx48HSEaHbhpSn_g@mail.gmail.com>
Subject: Re: [net-next PATCH v2 6/8] net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0DB804CD786
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284363-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bang-olufsen.dk:email,mail.gmail.com:mid]

On Sun, May 3, 2026 at 8:19=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Implement hardware offloading of bridge functionality. This is achieved
> by using the per-port isolation registers, which contain a forwarding
> port mask. The switch will refuse to forward packets ingressed on a
> given port to a port which is not in its forwarding mask.
>
> For each bridge that is offloaded, use the DSA-provided bridge number
> for the Extended Filtering ID (EFID). When using Independent VLAN
> Learning (IVL), the forwarding database is keyed with the tuple
> {VID, MAC, EFID}. There are 8 EFIDs available (0~7), but we reserve the
> default EFID 0 for standalone ports where learning is disabled. This
> fits nicely because DSA indexes the bridge number starting from 1.
>
> Because of the limited number of EFIDs, we have to set the
> max_num_bridges property of our switch to 7: we can't offload more than
> that or we will fail to offer IVL as at least two bridges would end up
> having to share an EFID.
>
> Co-developed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Sweet, exactly like this! Good work.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij


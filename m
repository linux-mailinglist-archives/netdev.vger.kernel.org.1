Return-Path: <netdev+bounces-284364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMWiFeTj+WnMEwMAu9opvQ
	(envelope-from <netdev+bounces-284364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:34:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB01E4CD96D
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FF9A3041A69
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8D426EC0;
	Tue,  5 May 2026 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8FPSLtm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC97B426D2A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984053; cv=none; b=C4qGyTizbXMcrj1W9UbCDxtWkpuBV8HxIrhTYLnE3GhXF5DRSVa0QCoVijYyQbeuEsfvTCvEtcO7mVR6B6GYL4iVRM7GFODjzeDczcDXixnZIQzkbt4rg7jsHlxsKue8EohjCSbvSJRQAb5dY0Iupb/B+cnSTSDx3bZniR3/rb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984053; c=relaxed/simple;
	bh=bBlpc4IGb+B5FSJznrdKDrcYMhRcaZ5fQIi6jO0Yc70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgYOWKf+Qw18DorXRcILUgm2k6ZsbERDccWtTqhHCvvatNTY/gAEmyNflBMfMYFLBS396EO0ydV8LSzCD3RfzGzlGrsrl9Tmn0QooUiPIljmE+tFIuH8DOQlI9SQmosgnztMm6sP9d1Bx2tPv2g8Bxi2rF26e0usIlQHhEGZllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8FPSLtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D147DC2BCFA
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984052;
	bh=bBlpc4IGb+B5FSJznrdKDrcYMhRcaZ5fQIi6jO0Yc70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m8FPSLtmwQkjneKcPb+ld7s2FmzhFPpXG9LfR11BMpaxZ3RDqTYJW8hS+I51pH39X
	 V+uWSa2b3rCXS8M4XRYKAvMfSIVIibboE7yNDdJQR7cdDumQ/DglFIgKmgRfkqvMEJ
	 Ba2iwh2bpJOTmulrLLB0EgZRkCDk7YWkJtKYKcwJCR6hUpz0HARr5SV7+a+9SBH318
	 knNihxEgOQ8dwJtgyf25y7qzdFIswA17b4oBK6znGxrw2Ku8jdWjs4YjaWclMG7ykL
	 yurXhm+pPjucLlImzEA5MymqiQgJ8YauVu2BqDsIHYEjRzllehnZEBMWSQhdYdKQpN
	 6bNJRK+7EIDbQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3939d2bd739so19934571fa.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 05:27:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9xE4tsjChdHmKRGw5iMk0vPvkdixey+15uFMo0JmEaMUjaB/U8UYKX8R45kTMmd75Sf7iJHjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNFN9ZquGygDhr7WVOaH3AK9a/pl5cCXlrx/liB8rWqKef+1jn
	t0bIEkQIaY3xmBWnf3dmRDERQFi0lkCYLAVrBOub1WTfbY2S2ADUXZ8KdRz5xwxxbw5Sfs/kF2T
	YySwzKd5WQolJjK6D2UnvS1uaMqtKDRU=
X-Received: by 2002:a05:651c:4186:b0:393:6041:4831 with SMTP id
 38308e7fff4ca-3937852aae2mr43693491fa.23.1777984051570; Tue, 05 May 2026
 05:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com> <20260503-realtek_forward-v2-7-d064e220b391@gmail.com>
In-Reply-To: <20260503-realtek_forward-v2-7-d064e220b391@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 14:27:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLkf_LWPfrN=SHc46iyiPfDbvYy_ksAHNCaTRDcWSwmGFA@mail.gmail.com>
X-Gm-Features: AVHnY4JPOe4aynTmeGKEoZm18agBAVcTHMURBsn1jzhqfTqJQtBu77Qbs9D9YwE
Message-ID: <CAD++jLkf_LWPfrN=SHc46iyiPfDbvYy_ksAHNCaTRDcWSwmGFA@mail.gmail.com>
Subject: Re: [net-next PATCH v2 7/8] net: dsa: realtek: rtl8365mb: add FDB support
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
X-Rspamd-Queue-Id: AB01E4CD96D
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-284364-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, May 3, 2026 at 8:19=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Implement support for FDB and MDB management for the RTL8365MB series
> switches.
>
> The hardware supports IVL by keying the forwarding database with the
> {VID, MAC, EFID} tuple.  The Extended Filtering ID (EFID) is 3 bits
> wide, providing 8 unique filtering domains. This driver reserves EFID 0
> for standalone ports, effectively limiting the hardware offload to a
> maximum of 7 bridges.
>
> Introduce a mutex lock (l2_lock) to protect concurrent L2 table updates.
>
> Add support for forwarding database operations, including unicast and
> multicast entry handling as well as fast aging support.
>
> Co-developed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Excellent, thanks!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij


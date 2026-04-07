Return-Path: <netdev+bounces-275881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CCWGF2z1GnvwQcAu9opvQ
	(envelope-from <netdev+bounces-275881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:33:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AEA3AAD0D
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67B203006B72
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F58D351C09;
	Tue,  7 Apr 2026 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeAxh+Ip"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F54C92
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547226; cv=none; b=G1LilSqOGNolPYUHJqKVkSAEM7HACimJmUpTTMu2+rv7Rdc5v6tKV9RQ3VCOB204v+5f+5SYb64eyXTCjpjYSKzSwCoI4aWn3Ek0WIVCbzj5DeKoNFlLzFd3OtDCMmR+te9VlP1G7I0GmGwUA7XgW4PMZ7YDQtG2aM5nDMurlqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547226; c=relaxed/simple;
	bh=sG6TgmbuXb0uqYclVpBMh2w7dGR+xcvS2cUEOa5zGug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9TxpD6ovvv3A1OKTJeqfn1E6ezDYtMOUL86XFmgTgx2/CMX9kGRyEoCW9OZluph4WIWEoNmbjsLr+KEcuZxuwrXZZDKc+6eE0GRrbIDJT+I2VhyE34XO/VYnyiA5F/UQDNh9ogjqoUc9MftI0pbg3JMr+89aBXZf7EYqRDM9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeAxh+Ip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31633C2BCAF
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 07:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775547226;
	bh=sG6TgmbuXb0uqYclVpBMh2w7dGR+xcvS2cUEOa5zGug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NeAxh+IpUMqu+U+OaXauzYNf17kxhpQwuFpw92naibX/5P9JKZpriOPRJKh/c+Rj1
	 ulGVEZqYKwjkQ7QJj9GBO0M27aQUClB69CoVPTnBeaqTOzBo3UuajI+sLSwDdjnY3L
	 Wnq65y/PAhXJU/cn0+qxXN5Pmg4QZAt8Tiqqni4SH9wu0N4QEa1UpdmUXFRYSWLPtZ
	 fkWuoy4fvTx6EiBD5yXAgo3xKP9U6SZxpAhSBiuE3ek1RCNmWRh+560XDJY4iGLB5t
	 UTE2t7f3MDNAho3m7Zsd6ozNYNUmITrm94ZYFny0BH9vqJzVKpJls6j6PwMhzgB3kx
	 T6hfjIJfLjvQQ==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79ab5fd969aso46088497b3.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 00:33:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHJgLicmqN/251vv2CRuBcguvHla1VI0hGIlVEU/Ny+OY+TizVYOQvDsbnFWvRMJ/vI+B5QRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWVTblXc2tdkYGRpdxx4hB7rFxcme/CK2Tz+CiYVwTDTxuabOz
	JKBy60D/WdvXXTuFtN+k+u54s4i/qwTpP5uZBHvcriftnZtfYVF+3eItYYcIP+/4yStCLw/KFx9
	J/LdGvsnCb1zuuo9fL5UAkIgD4ZW5rRM=
X-Received: by 2002:a05:690c:385:b0:7a1:523e:93f5 with SMTP id
 00721157ae682-7a4d6541973mr165374977b3.52.1775547225357; Tue, 07 Apr 2026
 00:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com> <20260331-realtek_forward-v1-1-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-1-44fb63033b7e@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 7 Apr 2026 09:33:34 +0200
X-Gmail-Original-Message-ID: <CAD++jLkN2K0cRdfhv85pqYxZnvDtdmqUKNuBNp0HX3LaQSQPbA@mail.gmail.com>
X-Gm-Features: AQROBzBkheB7bwd-YZtOJaNEyfCqZ-iZX5cblFSlMUn5r9yI9xeHv9bv-0mEPzo
Message-ID: <CAD++jLkN2K0cRdfhv85pqYxZnvDtdmqUKNuBNp0HX3LaQSQPbA@mail.gmail.com>
Subject: Re: [net-next PATCH 01/10] net: dsa: tag_rtl8_4: update format description
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275881-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B2AEA3AAD0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 1:00=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Document the updated tag layout fields (EFID, VSEL/VIDX) and clarify
> which bits are set/cleared when emitting tags.
>
> Co-developed-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij


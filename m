Return-Path: <netdev+bounces-269447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDUaNWn7u2mzqwIAu9opvQ
	(envelope-from <netdev+bounces-269447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:34:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C91322CC0DC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6158F30000B0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402773D47DB;
	Thu, 19 Mar 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beFzx8w5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE83D47CA
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927266; cv=none; b=KG3MDqP+TY0ZpKXZgPLTHNGghwVvYr+Y8hw6XrYGIffFxYkpbkJmlqgbj84rQfemoj+QpOCBYw+IrIz8w0cJvyk6nN0D/1h/d75t4LFwhhidrC084bGuuobovUlWA8FqU1E7GV+abPg2DkfXIz85prVnep9wyVEbE95dinHBlCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927266; c=relaxed/simple;
	bh=aV3nmB3c2z6lXRjvSI+ciIpz6w1xlpSheU1m+Kyca+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4t+0A65kxsWWAh7Q83SXrwg9PIbz7cd8BDJLoHghMCTlbKEGBbuwsrjcU1tGG0UoyJQoH1v9ABqGH8tQFFJoALuT5je22X+DyMJ+uzRVgkiQ182FYoWP52bVF4l5zt4+46COrNUhPxgJ/V4BOOjw64vmZ+20PgrAo3B5Y6htu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beFzx8w5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19BDC2BCAF
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773927265;
	bh=aV3nmB3c2z6lXRjvSI+ciIpz6w1xlpSheU1m+Kyca+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=beFzx8w5Ju4n+WHbq74IRCwpYL1BAhVpznnwvXTRivP4GzgnjpqVgINaOjFugaW60
	 n/dNJ7ePOpRtcMYrnmuTujwZ0dgVp6tPvKEqkc32PCts1Zjja/srnwyS/FZcHCSQTz
	 BvpzRNot4vsi2An8PajLWTmFEYI1YwpALVq42xkQqXomlCtZK8zL+gKa0PTGDd05HW
	 YrXuladiIZP+/scbwqTZk0fcsdG6FDz/pfyXfFGGzRBc6LphIfiPZGjUNZ69yIe+Zo
	 A6LG7rVLV0tLtX/tDyrXKFpN2iFeWjcWKQfN4jCM9TrRN7yyWYlqLYNY6Br9GY6eo+
	 65x4H7yviOKjw==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a46ebe2beso5636207b3.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 06:34:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhyH8FWoBpuqjo9Z09ixp/pNydtsdcHVBG69Ww3odUH9rroUMxU2jfUNJJbAFh//eTNVsKVBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0boqKENF7xF06kkakO7EaX2MCakj3RcL04EZQlGw9xWszPSAq
	YpBzDPBA40y2nSzrcy9u1WPJNjNU+2MJvI3faVHgeQSvfrOShUoq+4MSFfLbKdpNkG2rDgxmD6q
	mjzK3/kFpuyz8bBnaQ5XwlOKhp/KBX40=
X-Received: by 2002:a05:690c:c50d:b0:79a:4ba5:f34f with SMTP id
 00721157ae682-79a71ef36d2mr74901257b3.59.1773927264986; Thu, 19 Mar 2026
 06:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316-gpio-mdio-hdr-cleanup-v1-0-2df696f74728@oss.qualcomm.com>
 <20260316-gpio-mdio-hdr-cleanup-v1-1-2df696f74728@oss.qualcomm.com>
In-Reply-To: <20260316-gpio-mdio-hdr-cleanup-v1-1-2df696f74728@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 14:34:14 +0100
X-Gmail-Original-Message-ID: <CAD++jL=mu80yoDNH8S50aJjn2KhNfUKmX9QH=z2zczKeRC_YPg@mail.gmail.com>
X-Gm-Features: AaiRm50gH-94QQ41a8d5uBEBVZ9xrrEV_jQSVg76tZU8tVNGtW4Kk4gtl40h7nw
Message-ID: <CAD++jL=mu80yoDNH8S50aJjn2KhNfUKmX9QH=z2zczKeRC_YPg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: mdio-gpio: remove linux/mdio-gpio.h
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269447-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C91322CC0DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 11:04=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> The three defines from the linux/mdio-gpio.h header are only used in the
> mdio-gpio module. There's no reason to have them in a public header.
> Move them into the driver and remove mdio-gpio.h.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Thanks for cleaning up this.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij


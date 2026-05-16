Return-Path: <netdev+bounces-288642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKn4MpmHCGq7twMAu9opvQ
	(envelope-from <netdev+bounces-288642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:04:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE9455C3C5
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DEAB3003BF9
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610A33E2ACF;
	Sat, 16 May 2026 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogsS2TaG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11C3E2ABF
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778943892; cv=none; b=URagielok4wangQxTtUKFGyHL/kYsGnuS8Nw83c6v9mJPc6vG/a+NvMEtFgl/pVAnthgNN0/N4w52D47CjGQop7OwCfbyzla3tfiOe1cvn3ieyfVPPVkbAW+VXIBkSh50uKkOOzIYG1Yya8KZR+2hi8T75Z5K/m8JX+BxsDc7Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778943892; c=relaxed/simple;
	bh=5LVJ/6qTZqzPNT2wqu0Z4SBF5AFUT6L2VpK5ZJvrul4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0fFkVbL24O7uCxMYezgxPB5mto0PSF3HWcAua/+WVU6Giqy54PyCHj5CsSuikodpi9ElvpBuA4/o6itCj4vT0JzFVM04U30YUME1o9SEsZrK454rL5k/W/5+L5oeyuYCh7q1cvePc2u/DNPkvpsJI6B2bdounDN8YVkHAILK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogsS2TaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B17C2BCC7
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778943892;
	bh=5LVJ/6qTZqzPNT2wqu0Z4SBF5AFUT6L2VpK5ZJvrul4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ogsS2TaGDjAf8Pt69tVKDW3+XHvlyLH5xDCzl01YGEu9oX/TW1RjkMlrcmfIUTT5j
	 9sQ242lGcftXOcEhjZDeTdUuJzUDJMUHjP2x4uUQZaKQDCji1X3UyNxH84WppREG3N
	 SZxm0wDKXdIW0nvueQH58McgI++tcGt/kMpv7PeApXtP3Phrd0xf5VpKKZ3Gd1ztIH
	 v5NjTqpaGH1JK06FhYUaqKFXF+BSN6vfz5ZcRgE//hr5JdUCuFdGlIymsgOJDxORkA
	 ZXEkJSpIqoEEc8gXBfR9oFoONSxcWFrRuDvJT6WRSbsp4AY9U7NolxF5a6fCK+rdow
	 LgrcxsweNSBJA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a8f9841616so791138e87.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 08:04:52 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy3AbnsRRMzIhGHMF8rhmJrd+hFQEgZnWOgXXuFsIuUSJq1bOCv
	43VY+OEXX8gPMSE3WadRj3805t8vZFUX/ASACEWQiwYHNiD2N2NSLhsMPMnqSXvRAN9sF0V5OgR
	hXvA1YYyVngtJwKpoe5VDroZXKZgrEFo=
X-Received: by 2002:a05:6512:32c6:b0:5a8:8222:7fbb with SMTP id
 2adb3069b0e04-5aa0e73c491mr2432351e87.34.1778943890822; Sat, 16 May 2026
 08:04:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
In-Reply-To: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 16 May 2026 17:04:38 +0200
X-Gmail-Original-Message-ID: <CAD++jLk81ieH_d2oT_9-bcA3y2dCwT1qxnr5Y+1X9bMNT4whvg@mail.gmail.com>
X-Gm-Features: AVHnY4IfG6w2qYzyFQ-N2GyxSqe-yJl2-SRsa7zWmzyM8icWkq5JOaGWseH676s
Message-ID: <CAD++jLk81ieH_d2oT_9-bcA3y2dCwT1qxnr5Y+1X9bMNT4whvg@mail.gmail.com>
Subject: Re: [PATCH 0/5] net: dsa: microchip: Add support for KSZ8995XA/KS8995XA
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DAE9455C3C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288642-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 1:16=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:

> This series breaks with the dated attempt to polish the old
> KS8995 driver, and instead implement support for the KS8995XA
> in the KSZ driver, and after that delete the old KS8995 driver.

Obviously the patch series should have "net-next" in the
patch brackets. I am just expecting review comments and
AI buzz so I will need to spin many versions anyway.

Linus Walleij


Return-Path: <netdev+bounces-62126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D8E825D35
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 00:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B401C20D89
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 23:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1252B25116;
	Fri,  5 Jan 2024 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bI3cQMsg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104F3609D
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbed430ef5eso93873276.1
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 15:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704497747; x=1705102547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXT1zX9ELti++7aTvyDILTNDJmTY1Ub5NNsdVtyr7vA=;
        b=bI3cQMsgX1jsLn8sKg6AhSZ8JxsS0k1lKyqt5kXJk2YnwJwDkgR0Fisv1aAd4aZmiX
         CxlP1IcbYyZFtm/Fz79QZo3lH7uXH07QP+7i0/X1C6VJPC6yBosrS+hVCsrpj8ja7sX5
         YbEREVs+YSKAHVNcFtGP4W8yZH6/UzbMUKUWuSd05N6HZAY+4m58vd+PTBYbUdjpTwzR
         K5BDFUCvHmy4PZLdVx5TK2KgjhZIu4dLcxjNA5M30x7l/duEiVGJBG2ipFFMACrD9xQJ
         t5TkYOuzE2YvpFh8JAFckkHkwKWBSMNAlxmATq3pDGdzHGAjimvmAI2D9vWjARpVaioN
         jBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704497747; x=1705102547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXT1zX9ELti++7aTvyDILTNDJmTY1Ub5NNsdVtyr7vA=;
        b=PMADFkqFWIMDP6nKe0w1O5wmwMwWrjHhx7vOpaIx2lrcT7yUNY/Ha4tPikCJ4iw/1E
         zSgSFYtUIpBvu/ly91qLoFvdji/Q8nECSXDc4BVi7hghuTLdFXavuTCMFgz+iXRyz6CM
         MfYbubSbGSbgkSGY2SuNj0ZW1miJslFdhkY8okBayGuce1zLjQy/L2dQxS5zRPA5uWfC
         ZNqCWr+G5FtvlrOGIFhXXP7WU24iOXsfRqxBR6Gsek6Yee7aipF0TwBHFzhOpfeM8HrB
         O9zntmx1I4b8AyrTl7IzAMLrksAmMdClAfVhEzUHH/X3Ojn/tyM1ORuyYsG0rdDBelCb
         lHBg==
X-Gm-Message-State: AOJu0Yw7KmPxjMUPQYVWj2GRK4AXRlZV2t8xqFV/lmqCRoKUCK90cihf
	PaCxD+0aHfyfWDyoBCmk/RKWaT+uCV/guc5Y+NUwgntDH3MqhA==
X-Google-Smtp-Source: AGHT+IFXseFr3DIyOTjqGczflM3JoVUhYJnwv36l9c6gs2L+8i5dRhS2vW2uc+Qmb1RRy+At+lGp+kJISI4q/1wc4js=
X-Received: by 2002:a25:9a49:0:b0:dbe:abbf:c9e3 with SMTP id
 r9-20020a259a49000000b00dbeabbfc9e3mr122952ybo.48.1704497747498; Fri, 05 Jan
 2024 15:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
 <20240102-new-gemini-ethernet-regression-v5-1-cf61ab3aa8cd@linaro.org> <20240105113247.wml4ldq3abvizi2a@skbuf>
In-Reply-To: <20240105113247.wml4ldq3abvizi2a@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 6 Jan 2024 00:35:35 +0100
Message-ID: <CACRpkdYE-uSxQRtZXYZyDU7S6vEegFv4nbHj1=M3a_4zPeu2hQ@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] net: ethernet: cortina: Drop software checksum
 and TSO
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Household Cang <canghousehold@aol.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 12:32=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> So are you taking back the statement that "Hardware offloaded
> checksumming isn't working on frames bigger than 1514 bytes"?

Yes, the correct statement is that it isn't working in frames
bigger than 1514 bytes, if they have a custom DSA ethernet
tag.

The previous workaround has made the driver work fine
with the device that has a Realtek DSA switch with custom
ethertype, but it broke the driver for devices that have a
PHY connected directly to the ethernet block.

(I blame manual testing...)

> Have you increased the interface MTU beyond 1500, and tested with plain
> TCP (no DSA) on top of it? Who will provide the TCP checksum for them now=
?
>
> I don't understand why you remove the skb_checksum_help() call.
> It doesn't play nice with skb_is_gso() packets, agreed, but you removed
> the TSO netdev feature.

You're right, I was stuck there and larger MTU would not work.

Simply dropping the TSO and leaving the SW checksum in place
make it all work nicely!

Thank you so much Vladimir for pointing this out!

Yours,
Linus Walleij


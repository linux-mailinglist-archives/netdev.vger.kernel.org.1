Return-Path: <netdev+bounces-57603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9380381398C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3424DB21912
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B5E67E9E;
	Thu, 14 Dec 2023 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1105MNy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0367E87;
	Thu, 14 Dec 2023 18:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B434AC433C7;
	Thu, 14 Dec 2023 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702577576;
	bh=9uDKjR6ENQ/K3Sf5xNvwga0k6H6K4XUFFfjNnkFeRrI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H1105MNyP9Wff0fEMpFolNBcsQf0S9V4M49eBuV3/S7ONiYCzZyNMm9KaZS7xluH4
	 Q1MjaO8tavKqNjas65Hnc+ZSkUioUvCSqRnaBNwnR9n2BaxD9OGqtUc6UFCfX8UDTP
	 hPGad+bvIPFnKJpq09KvMQN2Ez9rfVXgvGfxh+akL2fPfSrV4lRxBS9q6wTy5beJjY
	 lKxIBk654oZ1/yy6VlBVDFHpz8sVZkHkxMgM2fuJDmqGclvuNn9UyafQ4R5vgNVhY/
	 W3VmSeuADjkRRfGho1O9VuuV+3dGGuh8NQt+R4fEWkO029/Rkt7tdzlmVac4YLLxSC
	 wysccIJjt/gQg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e0ba402b4so4544020e87.1;
        Thu, 14 Dec 2023 10:12:56 -0800 (PST)
X-Gm-Message-State: AOJu0YwNDvUTML9jrXqo92ztlVpXAde4hPOPd4jOLQCxW5HlZwbEnNq0
	xWharj5I1ZraL+CDbbR2zC3AdXgR2h7Tur2WaA==
X-Google-Smtp-Source: AGHT+IGJmgByQmzdpXCeRamEl4cngOXuD0FNxHvEbfASuSp1YNGDfU2difQ6xmc2xdlhi8xJtU6GmISDFggf4ernITU=
X-Received: by 2002:ac2:5f43:0:b0:50b:ef17:5137 with SMTP id
 3-20020ac25f43000000b0050bef175137mr4523117lfz.35.1702577574903; Thu, 14 Dec
 2023 10:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213232455.2248056-1-robh@kernel.org> <20231214-buzz-playlist-2f75095ef2b0@spud>
In-Reply-To: <20231214-buzz-playlist-2f75095ef2b0@spud>
From: Rob Herring <robh@kernel.org>
Date: Thu, 14 Dec 2023 12:12:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKaGFfQNwR3HqRnVs3K7SUtevpoG6tEDntM0SNfyyp6AQ@mail.gmail.com>
Message-ID: <CAL_JsqKaGFfQNwR3HqRnVs3K7SUtevpoG6tEDntM0SNfyyp6AQ@mail.gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: marvell,orion-mdio: Drop "reg"
 sizes schema
To: Conor Dooley <conor@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:23=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Wed, Dec 13, 2023 at 05:24:55PM -0600, Rob Herring wrote:
> > Defining the size of register regions is not really in scope of what
> > bindings need to cover. The schema for this is also not completely corr=
ect
> > as a reg entry can be variable number of cells for the address and size=
,
> > but the schema assumes 1 cell.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Does this not also remove restrictions on what the number in the reg
> entry is actually allowed to be?

Yes, that's what I mean with the first sentence. We don't do this
anywhere else with the exception of some I2C devices with fixed
addresses. Keying off of the interrupt property also seems
questionable. If the register size is different, that should be a
different compatible.

I only noticed this when I happened to remove "definitions/cell" and
this broke. That wasn't really intended to be public.

Rob


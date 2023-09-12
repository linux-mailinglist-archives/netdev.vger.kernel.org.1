Return-Path: <netdev+bounces-33184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6900579CEDA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 12:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2381C20D26
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD57A955;
	Tue, 12 Sep 2023 10:50:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39F1FAF
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 10:50:34 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDFEBE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:50:31 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58df8cab1f2so56214287b3.3
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694515830; x=1695120630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1zhy1UCOP1ljrKVhLiacaxWhwvSH+VCp0kMLxhoeYk=;
        b=KGO4rmyNgT3MbvGcXtZJWfne4zfxWs9WFVyf5rMhUGn/hCCcnqfIUVsZgeq+3pFKiE
         DrSDf0kjuI1eF5fCGr9kfZslf1fd9384ubuxn8E6A6QH2hD2PD62p0G2pfSUju8xk5++
         Owf14hbibSTMuVTHKGNvBDAV6vmopbe3/fT0ORAzgDJTPSMuox7QRBeoN4coIiBnZwpO
         gWB9BAwFghuLcW+UKOYW5OMWG9evtCWjTv6VttlH6JTirV1n3VZHPgB0rDB+eZw/8CzY
         fvsMsQRscD/NEAP8olPTXupS4hWrD2Iz/l/LvnQ0SRaEJutPZhJv62Xltnk7adir0Jr2
         VNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694515830; x=1695120630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1zhy1UCOP1ljrKVhLiacaxWhwvSH+VCp0kMLxhoeYk=;
        b=gXX3iHaLopLeecJ6sUv9dZkcI3feYiL41SIR0NEM/SF0ZvAJLMDLocRyM7h3fDiFlk
         yaoLgZ/57dHI5jQ3OtaZl/iZM0YnW87fEKvA58iYPD/fNqvpak5wVW0hC7Yzk/l9mGvk
         jJsF5inX05879CQ6WwqZLhfVp1gHp0s/4cBvn2ATRqMn3+SYOzyrpiOuAL18TgGmvwow
         Mr2isMpJlkJdONCKAUROrYmKoKlfT2samzKDbU95UgOkzTnYpLY+BtDMHWPkVsWg4EsG
         YH/7B/AGCJINYyL+yl70d6pk337a/kJcxNWK2CBs0P6O+xap0RV5BxpIq2u8u5YrmdBM
         lFCw==
X-Gm-Message-State: AOJu0Yxj7hrkaw+aqipWwgRiT1So3TDwa9kFyLTc6t6p1oY9ozrBT+lk
	zgU0xk17EIeDOEoyY0sRqUT7RTniBvO3OoRIY8WtsA==
X-Google-Smtp-Source: AGHT+IF07zf9UK//ddp32dWpF4Y9JXdGQlakVWNajAly9WIIg0061on0AU2876ifTbnQDu3Gsm2uIBLaneAG2d7vX6I=
X-Received: by 2002:a5b:d05:0:b0:d78:98f:4aa1 with SMTP id y5-20020a5b0d05000000b00d78098f4aa1mr12462208ybp.7.1694515830489;
 Tue, 12 Sep 2023 03:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912081527.208499-1-herve.codina@bootlin.com> <20230912101458.225870-1-herve.codina@bootlin.com>
In-Reply-To: <20230912101458.225870-1-herve.codina@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 12 Sep 2023 12:50:18 +0200
Message-ID: <CACRpkdYFuqQYhB7dOnRnUo8kfRiVZFzYBQuWCpEPLLKVSzKkJg@mail.gmail.com>
Subject: Re: [PATCH v5 27/31] net: wan: framer: Add support for the Lantiq
 PEF2256 framer
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
	Simon Horman <horms@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 12:15=E2=80=AFPM Herve Codina <herve.codina@bootlin=
.com> wrote:

> The Lantiq PEF2256 is a framer and line interface component designed to
> fulfill all required interfacing between an analog E1/T1/J1 line and the
> digital PCM system highway/H.100 bus.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


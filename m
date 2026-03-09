Return-Path: <netdev+bounces-265413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MqeC4WHrmnKFgIAu9opvQ
	(envelope-from <netdev+bounces-265413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:40:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFD923594E
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD7F5303CD0B
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AAA2DEA75;
	Mon,  9 Mar 2026 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q76Colmk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA43016F7
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773045564; cv=none; b=G9mBN9nQElxTFBC+uOU757+W5qfutv2uEeBaJtb4rO8127XJmRywo+Ly/zlL56glVR/SOyxpHYSYPTbbrJOwR7vNne61BnTsYf464R+9E92o5FKcyMda6msk/cfFI0ujD9iMGdR6uYzVnvEWhMtFmpVsUIw7GW7MckdhxqlQncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773045564; c=relaxed/simple;
	bh=lmhRRii9BO7pCks+UXBWncpJDHHvOFHDr/1FU5tS2Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTl/tKabmi3IaCKDcMfWc/YrZhqEdoWk5zDI2t6CokxfsTFgKMwJdah4eZbuMpLULMvjtHv7Qd/ivMdbWuUT3vM4v2C3aWrqvMCQgRFi3lizYjpm7cp78o8uI8rFDZ6LOiPlJylwUzQWNK4JSrsPh+0JgU4VQ+pI+2WOyp7x3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q76Colmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CF5C2BCB7
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 08:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773045564;
	bh=lmhRRii9BO7pCks+UXBWncpJDHHvOFHDr/1FU5tS2Dc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q76ColmkRyDJvbq8gxyZoJGgf3AxHslBV45kyyn65Qq5cBxmbhJe86SXjizD2cyIh
	 Xgq7M+lMnWtNQ1vJnYb1nPh35Q/BMP2danCElMzBtdZaop97cbNOzrgMRYUTNt3CY7
	 ghyNh0MZLpNOh5FADHh21tK0Royny/naY6EPSPXDwMnhW2fN448wI29I+ZZcpKC1dL
	 ElNj6Foxoszn//lDzPUdappb00Svjk5EhCnYmYXsbBmeEGw6IYdIIF3v8iePl0jXdj
	 dqhAQoAxOOBrkTX7+jiEQ48ZdretEjEsBWIPhzFJ2UP6V/fO86n3oLXVcTenb75TLV
	 KpRqLgYMTCSmA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38a01c80c34so129336941fa.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 01:39:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvuiiLy+Ep3QD40j6xkxDliyfhyZvsyFaa1Z4QmpcuR/rR3zq3ejwT2qx7XoDd3OfSqArCRcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlRxyPXstYY1DNHjO5TO7oOzYcmytHzW5GpXOV8X44SEzK9plG
	OstJesw/ldyco0MwZCukvfQbXXPZFfck5C8SNEcZXdWafSIWi2AtKEZuKe7U7zLDQyzZW1HFTS6
	q4vePiC82k+rJQLUTKB/FCigaFn6yN5iuyUN1UqQrjA==
X-Received: by 2002:a05:651c:892:b0:38a:b18:f41e with SMTP id
 38308e7fff4ca-38a40b4bca5mr35053151fa.6.1773045562416; Mon, 09 Mar 2026
 01:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-qcom-sa8255p-emac-v7-0-d6a3013094b7@oss.qualcomm.com>
 <20260306-qcom-sa8255p-emac-v7-1-d6a3013094b7@oss.qualcomm.com> <20260307-boisterous-tuscan-rat-1eb9bb@quoll>
In-Reply-To: <20260307-boisterous-tuscan-rat-1eb9bb@quoll>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 9 Mar 2026 09:39:10 +0100
X-Gmail-Original-Message-ID: <CAMRc=MeeHP_ZjhOHu5NNLCU6Cg59EAWQAS0JngEHDQkmcDH3HQ@mail.gmail.com>
X-Gm-Features: AaiRm50wcU1Efh35HOluVCqu3-5afwUUXiIKPiOPr6mPL4PpMSQ1J-X9POGllS8
Message-ID: <CAMRc=MeeHP_ZjhOHu5NNLCU6Cg59EAWQAS0JngEHDQkmcDH3HQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/7] dt-bindings: net: qcom: document the
 ethqos device for SCMI-based systems
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Matthew Gerlach <matthew.gerlach@altera.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Keguang Zhang <keguang.zhang@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com, 
	Romain Gantois <romain.gantois@bootlin.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Heiko Stuebner <heiko@sntech.de>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Minda Chen <minda.chen@starfivetech.com>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, Shuang Liang <liangshuang@eswincomputing.com>, 
	Zhi Li <lizhi2@eswincomputing.com>, Shangjuan Wei <weishangjuan@eswincomputing.com>, 
	"G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Linux Team <linux-imx@nxp.com>, Frank Li <Frank.Li@nxp.com>, David Wu <david.wu@rock-chips.com>, 
	Samin Guo <samin.guo@starfivetech.com>, 
	Christophe Roullier <christophe.roullier@foss.st.com>, Swathi K S <swathi.ks@samsung.com>, 
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
	linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BEFD923594E
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
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,foss.st.com,st.com,synopsys.com,sholland.org,altera.com,linaro.org,baylibre.com,googlemail.com,pengutronix.de,oss.nxp.com,nxp.com,bootlin.com,bp.renesas.com,sntech.de,outlook.com,esmil.dk,starfivetech.com,mail.toshiba,glider.be,eswincomputing.com,intel.com,rock-chips.com,samsung.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,tenstorrent.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265413-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[76];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 11:25=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Fri, Mar 06, 2026 at 04:46:39PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Describe the firmware-managed variant of the QCom DesignWare MAC. As th=
e
> > properties here differ a lot from the HLOS-managed variant, lets put it
> > in a separate file. Since we need to update the maximum number of power
> > domains, let's update existing bindings referencing the top-level
> > snps,dwmac.yaml and limit their maxItems for power-domains to 1.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Romain Gantois <romain.gantois@bootlin.com> # For RZ/N1
>
> Can we drop half-baked reviews? Reviewing only that piece is not even
> possible, because it makes no sense outside of main change context. IOW,
> it's pointless review of nothing, if you do not actually review the main
> change impacting RZ/N1.
>

This is the first time I'm hearing we can't review individual parts of
changesets? I see your point about this particular patch and the fact
it only makes sense as a whole but is this the official policy for
parts of larger DTS patches?

Bart

> Also submitting patches do not really allow to apply reviewer's
> statement of oversight to inly part of the patch.
>
> It's called Ack then. Use proper tags if one does not actually review
> the patch.
>

I need to resend anyway so I'll drop it. I may also drop the two
hundred addresses from Cc b4 added. :)

Bart


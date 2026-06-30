Return-Path: <netdev+bounces-303080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rZJ5L+CZQ2oydAoAu9opvQ
	(envelope-from <netdev+bounces-303080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:26:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 128996E2D17
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:26:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303080-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303080-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0E27302F4D8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A853EDE70;
	Tue, 30 Jun 2026 10:26:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027AC27E1C5
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:26:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815194; cv=none; b=O9CX1OMmfQtiyYwmZR/Izd+Hv1UVIKaRz9XSC73XCGuj/9i0TIeocD8ZK3zhIUiU6rBOZJLRRrNmga/0ej1r5KndEVMR/7Do/7SLkZvGKKB+rX70ZZgjmF2jmL1our2vyWl+cBFegEFy84koSvafAbpcWgLdqnNdE2UyOnx2cwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815194; c=relaxed/simple;
	bh=QB+yFg75hqQqe4KF7RxRn4SKV1v/JdxFtb5/52LHcYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQl5iNdjVzpn5hFhr2kBlokBacl9gIvQk0zOBMHvw1Ox+zeJIRMjLPCMMQ0GTMoKbkgoZJBDgnleU+RsNTpANvKO3QsaplO3mujGsfg/4h9TZJ/0N+y0uPGphy++XSruNWEfO33SVDYhO2IU2olFVilkpUN5tSRZrF6++fLFgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so1766205e87.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782815191; x=1783419991;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u+1GiMffsMJvBdu44BU50jfVnBubjZ5dimn//DJ5+Rg=;
        b=ZAJWSZmU0Xen9Lo2v4/wbFRarlZGUN8gxjaWILTCzMsw5EGRMrO1t9KDOALOpjbbHA
         UjuCqXMpocMySOaIL++/dwiB6Ys5OxpR4qBswrMLde6IhaY4Le/EruoLCBaJfC/2ihM+
         d1ltU4eauThGtOePWX9pehmL3domvhk4yXHaYTqy8NxrfO0Rdv3qktrtwpyhXr1xYZQH
         V9md7sIPiZ3YaKHVhlIgngRg41gzkSMT4i1SqDnENBbv7IwhoOWtLvI2L4n/Y/KsMFh/
         5Bl/eUApv8q+o6Rm6ruGH0ha2lJqDlTbWyKZGwHDL9is471i4EYMRUjfGTCtv/G8u7v9
         BvKw==
X-Forwarded-Encrypted: i=1; AHgh+RqxN/+Vd9EAL0AKfx0mMqKKo2xExrxuKMXqukPP9A/CHE1z9bsP7bxz0TvqAfTSi8dX1HfCvfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEUyv6ON/xoFdLLwxg7pRVV7Ob/+5Fudd4arEGsjwf+XsvIxY2
	1NXaQlGXjJmg+6cNZvwuoqUlV0C61kde1zHG9jZMb0SrXkLZv9aWyRozWh7pyTEFTyg=
X-Gm-Gg: AfdE7cnfQSKc6+Tx0jwMxc9AULUtl5IhHQAWuz2c1fEMHjoO2kKNk0YHS3PO5O3WnDy
	ATek+G/o7271vkdvy56pp8hlhw3oiEuBecj+H2Y1oEZYUjreEoCoD2Q5ztM+2IykzsWuZbVuafT
	3sTkZoLH7VD1+/GaI7/KjDHQhN77HCFhryxxy2Hi1Rab1/2Imapi9qFfKPvR6mj4UywEUVhDxX0
	DSMfP5NblxVuaE7ncepoPTIFk7naUDuxHljLzKNtZOnHOgc0JWc9e4jB3jTIh6O9ofAkGmMUT/r
	Rm+tPBldbmgoDhwblD7nC9W4LKdk+X82geVHfxRh87uayxvqDk3toxOyqkYGAtbwnYqPT1sdvEn
	s7Bf4aUahlDkKp3NI0poQpnA2LxiDmei/JV2k9FlEUPTBDYL5yp2pTju8e+pFrdLIVcPVB5Qqdj
	5Ep9qwxFaq7tlgGl/9a8qRyLBnTAze12eFHjIqDdA0mcaBh8BXlqaEsQ==
X-Received: by 2002:a05:6512:3f1a:b0:5ae:bf63:3e13 with SMTP id 2adb3069b0e04-5aebf633ee5mr426325e87.26.1782815191057;
        Tue, 30 Jun 2026 03:26:31 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aebe333664sm465074e87.6.2026.06.30.03.26.30
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 03:26:30 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39669bcaadfso46939541fa.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:26:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpaxlrX7KSqnOayTxiSEaF+jY9lZqoqrkiRCGuSWwl6XfX2aHwGkHL6Xmj9tOI/eL7xchroozs=@vger.kernel.org
X-Received: by 2002:a05:6402:3223:b0:695:f580:a66f with SMTP id
 4fb4d7f45d1cf-69879e3e43bmr1292708a12.21.1782814728107; Tue, 30 Jun 2026
 03:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-qcom-sa8255p-emac-v11-0-1b7fb95b51f9@oss.qualcomm.com>
 <20260629-qcom-sa8255p-emac-v11-1-1b7fb95b51f9@oss.qualcomm.com>
 <CAMuHMdXen+E-Ai51aWBa_KV9W8Fz2cQPpT-FG_kQ7akhrrYa_A@mail.gmail.com>
 <CAMRc=Me3jaZXiXa1sFXr=8Do4sCd+XN1pKTcWC8-0j78SjCkKA@mail.gmail.com>
 <CAMuHMdVUBgG0EFB16OxHisbxx-sBvDKvBPNZdpyDnmBrnX4ptQ@mail.gmail.com> <CAMRc=Meb58KCuLXkNSJwUq6KJUzZv0u49FBA2L4C8Vd3NVo8Cg@mail.gmail.com>
In-Reply-To: <CAMRc=Meb58KCuLXkNSJwUq6KJUzZv0u49FBA2L4C8Vd3NVo8Cg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jun 2026 12:18:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWAPesQWMR4F_dx5axi6EwL+KfwLUmAyctLuYicaGHrkQ@mail.gmail.com>
X-Gm-Features: AVVi8CfDZI-66BCdudtb8k9h_4xIWUPsPqj5BKaSPsoCDQPTdsJgDTc_K9d7_9w
Message-ID: <CAMuHMdWAPesQWMR4F_dx5axi6EwL+KfwLUmAyctLuYicaGHrkQ@mail.gmail.com>
Subject: Re: [PATCH net-next v11 1/7] dt-bindings: phy: document the serdes
 PHY on sa8255p
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com, 
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, Romain Gantois <romain.gantois@bootlin.com>, 
	Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Christophe Roullier <christophe.roullier@foss.st.com>, Radu Rendec <rrendec@redhat.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
	linux-sunxi@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303080-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brgl@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:vkoul@kernel.org,m:peppe.cavallaro@st.com,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:shawnguo@kernel.org,m:festevam@gmail.com,m:jan.petrous@oss.nxp.com,m:s32@nxp.com,m:mohd.anwar@oss.qualcomm.com,m:romain.gantois@bootlin.com,m:magnus.damm@gmail.com,m:mripard@kernel.org,m:christophe.roullier@foss.st.com,m:rrendec@redhat.com,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:dfustini@tenstorrent.com,m:linux-sunxi@lists.linux.dev,m:linux-amlogic@list
 s.infradead.org,m:linux-mips@vger.kernel.org,m:imx@lists.linux.dev,m:linux-renesas-soc@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:sophgo@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:jernejskrabec@gmail.com,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[47];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,st.com,linaro.org,baylibre.com,oss.nxp.com,nxp.com,oss.qualcomm.com,bootlin.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,tenstorrent.com,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-m68k.org:from_mime,linux-m68k.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 128996E2D17

Hi Bartosz,

On Mon, 29 Jun 2026 at 18:54, Bartosz Golaszewski <brgl@kernel.org> wrote:
> On Mon, Jun 29, 2026 at 4:58=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Mon, 29 Jun 2026 at 16:07, Bartosz Golaszewski <brgl@kernel.org> wro=
te:
> > > On Mon, 29 Jun 2026 15:51:31 +0200, Geert Uytterhoeven
> > > <geert@linux-m68k.org> said:
> > > > On Mon, 29 Jun 2026 at 13:29, Bartosz Golaszewski
> > > > <bartosz.golaszewski@oss.qualcomm.com> wrote:
> > > >> Describe the SGMII/SerDes PHY present on the Qualcomm sa8255p plat=
forms.
> > > >> This is essentially the same hardware as sa8775p rev3 but the PHY =
is
> > > >> managed by firmware over SCMI.
> > > >
> > > > So why can't it be reuse the DT bindings, and be compatible with
> > > > qcom,sa8775p-dwmac-sgmii-phy?
> > > >
> > > >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualco=
mm.com>
> > > >
> > > >> --- /dev/null
> > > >> +++ b/Documentation/devicetree/bindings/phy/qcom,sa8255p-dwmac-sgm=
ii-phy.yaml
> > > >
> > > >> +  power-domains:
> > > >> +    maxItems: 1
> > > >> +
> > > >> +  power-domain-names:
> > > >> +    items:
> > > >> +      - const: serdes
> > > >
> > > >> +examples:
> > > >> +  - |
> > > >> +    phy@8901000 {
> > > >> +        compatible =3D "qcom,sa8255p-dwmac-sgmii-phy";
> > > >> +        reg =3D <0x08901000 0xe10>;
> > > >> +        #phy-cells =3D <0>;
> > > >> +        power-domains =3D <&scmi7_dvfs 0>;
> > > >> +        power-domain-names =3D "serdes";
> > > >
> > > > Ah, this uses power-domains, while the existing bindings for
> > > > qcom,sa8775p-dwmac-sgmii-phy use a clock.
> > > > I guess the clock is the correct hardware description?
> > > >
> > > > Adding to my list of examples for backing a hardware-to-SCMI remapp=
ing
> > > > driver...
> > > >
> > >
> > > Russell King asked me to put the PHY logic for SCMI pm domains into t=
he PHY
> > > driver instead of the MAC driver where it was previously. Instead of =
cramming
> > > both HLOS and firmware handling into the same driver, I figured it ma=
kes more
> > > sense to have a dedicated, cleaner driver as the two share very littl=
e code (if
> > > any).
> >
> > I think you are mixing up DT bindings and driver implementation?
>
> Ah indeed, but the bindings don't share a lot of content either.

That's the (maintenance) problem: it is essentially the same hardware,
but the DT bindings (and driver) are different. Does this scale?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


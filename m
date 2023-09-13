Return-Path: <netdev+bounces-33483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D9979E24B
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0662E282014
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0DA1426C;
	Wed, 13 Sep 2023 08:38:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBAD10F5
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 08:38:41 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E688A199F;
	Wed, 13 Sep 2023 01:38:40 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59bbdb435bfso6613747b3.3;
        Wed, 13 Sep 2023 01:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694594320; x=1695199120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0APiHDSlu5OFa6XpaHfv4wijVgZqQAKCVQiiG02fVU=;
        b=c0sVSqYN2GUA/n+vd4t8S9JUXxFHrj4N58hIjjPcaXK6kio5Xm9wNajH5xXAkiLTxU
         K3usW2hZhariB+uYh9p76gq2AP7jUjTcwCDUBsKPlzM57S7xPWyyw9/dJ9gxMs+R86ae
         IRf6gkdoSd1yzPcfF7TFsdCp/ckPEkltMM3TbQjvLe6dwxmSc0FNiPbIkk2dXFAIPnFZ
         pWBpUUgEoF8yCDLEu6JUA1QHjtHGpfHmu9g34QeCBX0aF5DcpVj/QMqgLLHHdZlKk2f2
         S9VFjepad+aleGqN/g+r9DdUtSvOczcZjhGnqwkWrPLGe/Pwe7FEtnitg0YbgM9SWxLp
         xnaQ==
X-Gm-Message-State: AOJu0YwPVNCJUp9VkorwBKNWZzVrEmi0tyNtK7ATpLmOAoTLn+5B10Cz
	LSpHfEsTgsZY2NYx20QOkTShZKJqPznQUw==
X-Google-Smtp-Source: AGHT+IHVR1+9XMXuviKpXqSnEBQklVh/VeXvICR2YKqFtFEjdRzIK2Ko+TN+Tgm7CUbabYghun5aNA==
X-Received: by 2002:a81:65d5:0:b0:595:8e80:30ef with SMTP id z204-20020a8165d5000000b005958e8030efmr1565503ywb.51.1694594319962;
        Wed, 13 Sep 2023 01:38:39 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id h20-20020a81b414000000b00583f8f41cb8sm2917443ywi.63.2023.09.13.01.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:38:39 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d7b91422da8so5681095276.2;
        Wed, 13 Sep 2023 01:38:39 -0700 (PDT)
X-Received: by 2002:a25:3717:0:b0:d81:4168:3a83 with SMTP id
 e23-20020a253717000000b00d8141683a83mr1659380yba.25.1694594319149; Wed, 13
 Sep 2023 01:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-7-quic_devipriy@quicinc.com> <CAA8EJpo75zWLXuF-HC-Xz+6mvu_S1ET-9gzW=mOq+FjKspDwhw@mail.gmail.com>
 <CAMuHMdXx_b-uubonRH5=Tcxo+ddxg2wXvRNQNjhMrfvSFh0Xcw@mail.gmail.com> <daed3270-847e-f4c6-17ad-4d1962ae7d49@linaro.org>
In-Reply-To: <daed3270-847e-f4c6-17ad-4d1962ae7d49@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Sep 2023 10:38:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxykGwyrKKSHBv9AHy4gAeH7DT7caZarbs-F40zz5Jpw@mail.gmail.com>
Message-ID: <CAMuHMdVxykGwyrKKSHBv9AHy4gAeH7DT7caZarbs-F40zz5Jpw@mail.gmail.com>
Subject: Re: [PATCH V2 6/7] arm64: dts: qcom: ipq9574: Add support for nsscc node
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Devi Priya <quic_devipriy@quicinc.com>, 
	andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, arnd@arndb.de, geert+renesas@glider.be, 
	nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
	quic_saahtoma@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Wed, Sep 13, 2023 at 10:26=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 13/09/2023 10:23, Geert Uytterhoeven wrote:
> >>
> >>> +                       clock-names =3D "nssnoc_nsscc", "nssnoc_snoc"=
, "nssnoc_snoc_1",
> >>> +                                     "bias_pll_cc_clk", "bias_pll_ns=
s_noc_clk",
> >>> +                                     "bias_pll_ubi_nc_clk", "gpll0_o=
ut_aux", "uniphy0_nss_rx_clk",
> >>> +                                     "uniphy0_nss_tx_clk", "uniphy1_=
nss_rx_clk",
> >>> +                                     "uniphy1_nss_tx_clk", "uniphy2_=
nss_rx_clk",
> >>> +                                     "uniphy2_nss_tx_clk", "xo_board=
_clk";
> >>
> >> You are using clock indices. Please drop clock-names.
> >
> > What do you mean by "using clock indices"?
> > Note that the "clock-names" property is required according to the DT bi=
ndings.
>
> Indeed, thanks for pointing this out. Probably bindings should be changed=
.

But what's so great about not having "clock-names"?
There are _14_ input clocks.

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


Return-Path: <netdev+bounces-26462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A3D777E38
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C4E1C21672
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8021F20FA0;
	Thu, 10 Aug 2023 16:28:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8DA1E1D2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A082FC433CA;
	Thu, 10 Aug 2023 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691684878;
	bh=1uOPhd/TGZVc50vJm5N3nOBZuoc7uO6m9eAcoDZzXvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AOjAu3zyP4aIquoh4aUaxep+S85yNfYEbAxhGk+qZnDfJb65+3OnyimfZCrEgnXs3
	 EoiC/pHa9FlRUzTpPQ2BvtYdz3ndsWAYz+mngnDoMSOtxH0UDeQGufvnIWTJajt0Tf
	 eGCll8O+tOuIYqd5DFbgMdQHgitvT4muWTdpnK+IeCl/m4+66yHOBUc5NhXFHGqChd
	 CkQPZzOo2u1NUNh+HODAbokcHQjm1SJSipwALubgKmv+JDAFqpjAraIpRqY7fB9U9z
	 NtJNgQcyJu7OOU5MhIAEsPFHIy8Iq3ELTs7u3RYOWjC73kmWQqAKo9jeKWPIR62yCr
	 bcCcbSvGhUDcg==
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d479d128596so1568341276.1;
        Thu, 10 Aug 2023 09:27:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YxDcTmRcBnSA/htG9RrinX1JkQNuCMpRpa37vwWKdF4fe0QL/Pa
	Y0k0yjSirqC7vKBt2uornzgzt67NftwtLg+nbw==
X-Google-Smtp-Source: AGHT+IFOyMAT+LzUzpq0pyxDfCYUTe6KwSf4qtBrlqGEsIJEOqifg9vah0d+5UFaukDKELTJfTw3ZYA1gkoEbUbdZGg=
X-Received: by 2002:a05:6902:1025:b0:d48:f413:d21a with SMTP id
 x5-20020a056902102500b00d48f413d21amr3258310ybt.32.1691684877632; Thu, 10 Aug
 2023 09:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810102309.223183-1-robert.marko@sartura.hr>
 <169166649202.64563.6248344012653953343.robh@kernel.org> <CA+HBbNE6H4WWW=+etRysPZr0bAXKaAq_0-oB0SnhUb5quQtivw@mail.gmail.com>
In-Reply-To: <CA+HBbNE6H4WWW=+etRysPZr0bAXKaAq_0-oB0SnhUb5quQtivw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 10 Aug 2023 10:27:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLK54gEwMu61n_pbNcS2s+ekuJ2B3DN1S8htgzXfJu6+g@mail.gmail.com>
Message-ID: <CAL_JsqLK54gEwMu61n_pbNcS2s+ekuJ2B3DN1S8htgzXfJu6+g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-controller: add
 PSGMII mode
To: Robert Marko <robert.marko@sartura.hr>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, andrew@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, conor+dt@kernel.org, 
	linux@armlinux.org.uk, devicetree@vger.kernel.org, luka.perkov@sartura.hr, 
	hkallweit1@gmail.com, linux-kernel@vger.kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 5:32=E2=80=AFAM Robert Marko <robert.marko@sartura.=
hr> wrote:
>
> On Thu, Aug 10, 2023 at 1:21=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> >
> > On Thu, 10 Aug 2023 12:22:54 +0200, Robert Marko wrote:
> > > Add a new PSGMII mode which is similar to QSGMII with the difference =
being
> > > that it combines 5 SGMII lines into a single link compared to 4 on QS=
GMII.
> > >
> > > It is commonly used by Qualcomm on their QCA807x PHY series.
> > >
> > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > ---
> > >  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> >
> >
> > doc reference errors (make refcheckdocs):
>
> I am not getting any errors, nor there are any listed here as well.
> Is this a bot issue maybe?

Yes. Converting dtschema to pyproject.toml yesterday did not go well...

Rob


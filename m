Return-Path: <netdev+bounces-33053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC579C957
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80F21C20C0C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4D1773A;
	Tue, 12 Sep 2023 08:09:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3AD1640D
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:09:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C16E10D0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 01:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694506147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=si3gwV/ygFAg4gPICZrwvarcfQiEXTXrZxz91xQWWcA=;
	b=G/+OEg7g3M/YnhEuvGajsGeJ4B/Uflinb3fs1H92KxrTWTccAftin7nhBkKIdtCYk8cXii
	lEk7G9gDrKTIeuXDhk/t6IEqMziThVM62bHgz/pfLN0r9oQDHDhRKoWuWwldWlWrcBuRoJ
	IQKskWUx37iPwlPWnTAwJ3JawHkauJs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-p9SaVZrMNnSQc3XxMLc_xA-1; Tue, 12 Sep 2023 04:09:06 -0400
X-MC-Unique: p9SaVZrMNnSQc3XxMLc_xA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-525691cfd75so1036037a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 01:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506145; x=1695110945;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=si3gwV/ygFAg4gPICZrwvarcfQiEXTXrZxz91xQWWcA=;
        b=FF95bbgBJyNrZIXbDxN7I/uKlpi6/zEHjJH3vxKONGUrZMxsGZxN2TkvcuU1i4vQeC
         IHKpA1LwHcxWA4aJ93zEzXcyEG1YGQOiyu3jtXIf3YbE0hvyjxzgnFJpIAReREQkkdLR
         vGBg2AXrNeZAVQd3d8gTbp0CA1ta8B3JSqKvTmogG6EVg3WvxLTpjna34XrIhVPKilJV
         E6XgqvXmQg9K2nLFEcZ+/wOs8tD3fh3ycIDf449P1jt4J5uemBQc19kvjKBnbRDqEGvX
         CxN9tDXpRUwBCUvJQsE0Y52Z/rstVDj5R3nxBcDZ+t9dYnJU8S0b+LUuzS+M3Mwqk97u
         0r2g==
X-Gm-Message-State: AOJu0Yx6Lkzyyk+h/0HkkuIsk58LSWpJYr0Sr1fD2VMvpnA45KUcXrvn
	U2Iw7BsB0xIfmuijI8QhscDnntOPgmeq5enmdAN4PtokPballLuVO2QVNR1ClgP5nrg+92tVZ8h
	gw24F+cq1vxXl2LZc
X-Received: by 2002:a05:6402:40c9:b0:522:580f:8304 with SMTP id z9-20020a05640240c900b00522580f8304mr9305940edb.1.1694506145113;
        Tue, 12 Sep 2023 01:09:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDu2D2fX9Bjl2fqQfkAplxEI8kO8USfXWam5rdjNtt/hBWG8HYne7UPTRFXBkfrrJIC+dqKw==
X-Received: by 2002:a05:6402:40c9:b0:522:580f:8304 with SMTP id z9-20020a05640240c900b00522580f8304mr9305926edb.1.1694506144776;
        Tue, 12 Sep 2023 01:09:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402028200b0052237dfa82fsm5533128edv.64.2023.09.12.01.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:09:04 -0700 (PDT)
Message-ID: <9dd78edb2476cc5b57ce7f6b5c6bb338ebef43fd.camel@redhat.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8dxl-ss-conn: Complete the FEC
 compatibles
From: Paolo Abeni <pabeni@redhat.com>
To: Fabio Estevam <festevam@gmail.com>, shawnguo@kernel.org
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com, 
	kuba@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@denx.de>
Date: Tue, 12 Sep 2023 10:09:02 +0200
In-Reply-To: <20230909123107.1048998-2-festevam@gmail.com>
References: <20230909123107.1048998-1-festevam@gmail.com>
	 <20230909123107.1048998-2-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Sat, 2023-09-09 at 09:31 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> Use the full compatible list for the imx8dl FEC as per fsl,fec.yaml.=20
>=20
> This fixes the following schema warning:
>=20
> imx8dxl-evk.dtb: ethernet@5b040000: compatible: 'oneOf' conditional faile=
d, one must be fixed:
> 	['fsl,imx8qm-fec'] is too short
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx25-fec', 'fsl,imx27-fec', 'fsl,i=
mx28-fec', 'fsl,imx6q-fec', 'fsl,mvf600-fec', 'fsl,s32v234-fec']
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx53-fec', 'fsl,imx6sl-fec']
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx35-fec', 'fsl,imx51-fec']
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx6ul-fec', 'fsl,imx6sx-fec']
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx7d-fec']
> 	'fsl,imx8mq-fec' was expected
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx8mm-fec', 'fsl,imx8mn-fec', 'fsl=
,imx8mp-fec', 'fsl,imx93-fec']
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx8dxl-fec', 'fsl,imx8qxp-fec']
> 	'fsl,imx8qm-fec' is not one of ['fsl,imx8ulp-fec']
> 	from schema $id: http://devicetree.org/schemas/net/fsl,fec.yaml#
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

It looks like this series is targeting the net-next tree, am I
misreading this?

I guess we could have small conflicts whatever target tree we will use,
so I *think* the above should be ok. @Shawn Guo: do you prefer
otherwise?

Thanks,

Paolo



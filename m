Return-Path: <netdev+bounces-17583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1062752166
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1267F281D70
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1018D8BEE;
	Thu, 13 Jul 2023 12:40:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01616883E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:40:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A46268D
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689252003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CZvuW47A9rnrw9h8tLb1kzJz8cR629REaGwxy53ZPA=;
	b=a+1eqsWrSLYCcsxHEM+cmqyQK5zaEjL7H9JywjzscjJA81w3/QQz0rDBd2U0aIFP7Cb4iC
	FXHro9OJ8zYZ/LU5RrBlMBjVyyS1VHrV0ml8iZLLWh36G5GtERQixl1h7Unx2xlSWdkvNr
	z6eQTKysbjhzbHKANBGIHzqZpK05szg=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-qDabHY1HPE6G9dYr97x8qw-1; Thu, 13 Jul 2023 08:40:02 -0400
X-MC-Unique: qDabHY1HPE6G9dYr97x8qw-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-47dccba4cbcso44356e0c.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689252002; x=1691844002;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8CZvuW47A9rnrw9h8tLb1kzJz8cR629REaGwxy53ZPA=;
        b=I9R+iXZfhzoRQCIxrQAqt1yDagofXm1tJ6H/10k62hc1ZxI+4S575SbEVmybQDus7A
         LaUHo2a4O9rkecmksu4N6zuhv7d04N57M43MAYU1MOqzR/xcdTahhMba17QBr0yQhDQq
         b9gv4MWjOqj0I9nklqS4/ah+V8WHKWZyUXE8Sobv82T3MmNB1Jrr7ChvYPz9J6gEaHTe
         T3gxoEnU24alNV7Fyd7KftNrsqlUBCeGVjDL4uBkiXzYPgIilbmRJMojhWPZqMlK2JMe
         S6WZanWc8Mu7GKuHbbKJ17M1g3RcPSDxyVx6NUY1DB+RM+4l95Eh+N10yw2cDbuZbc0X
         aPOA==
X-Gm-Message-State: ABy/qLYA0yzU7bP6rZhCcsFLYHGuib3z3iGfK+PSz1T2ire6lC54KYDt
	HQeeTYb/uQVHjPrpk9vSUKd4xyzBsyqFt4iRyQcVMgaiFsAhS8bpeqEdJq9I6vXuXDY8E+HFixI
	bFctxnXzCJSFtCIAR
X-Received: by 2002:a05:6102:549f:b0:446:954b:3ecd with SMTP id bk31-20020a056102549f00b00446954b3ecdmr635530vsb.0.1689252002058;
        Thu, 13 Jul 2023 05:40:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEsJ6FCrqJkPOBD8/yVWmSl1NPRq9EdaNMtrewkIoaHljouC4qqwm4w9JakDGHT4VOWH5wubA==
X-Received: by 2002:a05:6102:549f:b0:446:954b:3ecd with SMTP id bk31-20020a056102549f00b00446954b3ecdmr635506vsb.0.1689252001814;
        Thu, 13 Jul 2023 05:40:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id f23-20020a0caa97000000b0062ffbf23c22sm3019688qvb.131.2023.07.13.05.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 05:40:01 -0700 (PDT)
Message-ID: <1061620f76bfe8158e7b8159672e7bb0c8dc75f2.camel@redhat.com>
Subject: Re: [PATCH 2/2] net: dwmac_socfpga: use the standard "ahb" reset
From: Paolo Abeni <pabeni@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
  Dinh Nguyen <dinguyen@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
 joabreu@synopsys.com, robh+dt@kernel.org,
 krzysztof.kozlowskii+dt@linaro.org,  conor+dt@kernel.org,
 devicetree@vger.kernel.org
Date: Thu, 13 Jul 2023 14:39:57 +0200
In-Reply-To: <c8ffee03-8a6b-1612-37ee-e5ec69853ab7@kernel.org>
References: <20230710211313.567761-1-dinguyen@kernel.org>
	 <20230710211313.567761-2-dinguyen@kernel.org>
	 <20230712170840.3d66da6a@kernel.org>
	 <c8ffee03-8a6b-1612-37ee-e5ec69853ab7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-07-13 at 10:24 +0200, Krzysztof Kozlowski wrote:
> On 13/07/2023 02:08, Jakub Kicinski wrote:
> > On Mon, 10 Jul 2023 16:13:13 -0500 Dinh Nguyen wrote:
> > > -	dwmac->stmmac_ocp_rst =3D devm_reset_control_get_optional(dev, "stm=
maceth-ocp");
> > > -	if (IS_ERR(dwmac->stmmac_ocp_rst)) {
> > > -		ret =3D PTR_ERR(dwmac->stmmac_ocp_rst);
> > > -		dev_err(dev, "error getting reset control of ocp %d\n", ret);
> > > -		goto err_remove_config_dt;
> > > -	}
> > > -
> > > -	reset_control_deassert(dwmac->stmmac_ocp_rst);
> >=20
> > Noob question, perhaps - what's the best practice for incompatible
> > device tree changes?
>=20
> They are an ABI break.
>=20
> > Updating the in-tree definitions is good enough?
>=20
> No, because this is an ABI so we expect:
> 1. old DTS
> 2. out-of-tree DTS
> to work properly with new kernel (not broken by a change).
>=20
> However for ABI breaks with scope limited to only one given platform, it
> is the platform's maintainer choice to allow or not allow ABI breaks.
> What we, Devicetree maintainers expect, is to mention and provide
> rationale for the ABI break in the commit msg.

@Dinh: you should at least update the commit message to provide such
rationale, or possibly even better, drop this 2nd patch on next
submission.

Thanks,

Paolo



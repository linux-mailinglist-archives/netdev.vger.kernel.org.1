Return-Path: <netdev+bounces-13176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FEA73A8AB
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93316281A0E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84C8206AF;
	Thu, 22 Jun 2023 18:59:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE521F923
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:59:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079AF1BD8
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687460340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pa+oZK/sS3e2gfb7B5cDcIjFykC7j8FP/PxBLFuYWZ4=;
	b=BWrSGxUCTbEOKX0atpo0y8+5jk6/UCrEECF0YdPYdg0j50bKIgxE9CeJWUSnIE3IXcNDFt
	ru7uGDLwcKXnnKbLFi0f+DnTRpXj6PBZFyGT6g21+5joj7+/QW8wyOjkdRZjA9Pkf7QrcX
	RGKPxakyEbLynRhwjjBq+dzt9E1MuAw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-2EQsUwuAPQGXL6sTS9Mb3w-1; Thu, 22 Jun 2023 14:58:59 -0400
X-MC-Unique: 2EQsUwuAPQGXL6sTS9Mb3w-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b45ae9dfb6so4090941a34.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460338; x=1690052338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa+oZK/sS3e2gfb7B5cDcIjFykC7j8FP/PxBLFuYWZ4=;
        b=fjK9WWR0ohQkqQ6CJPmThSjCQz5DOKINvDpQr2d3EIHhwWdD8LkPbG3XhC4algJqHk
         1jLK3VRalP7yKn1fVxTY5R3igx2wwyfydNH6B7o6fezSFNhD6bF/2eqXoUSgHQAB0KGL
         tYbKlV9CSvgLzNSu7xx9I37q6T97VtxKUr5LWUNMttwm+tY8LUY4rHPmY5vo0h06sixG
         sVzzaAm5qOLWWdeY6khXVsP9syBjAVcASXbgbayI5k5fvXa9AyyFRc1OTQE1FM9Q/vTa
         WJlhh7HifskK4cQ21PD8qxVd41s4M15Dz9pK3kGd/swdr5zJ6tP1kdJJaT1HMujdWTtI
         F45w==
X-Gm-Message-State: AC+VfDy+ut5J6rEcdW0f/+T6t97BtgqRQtQ5pwjPjNs4s7aECVDA/XTn
	jVvD9WfelcFm5QJUzV8Blew4Ne1fKKmywWu5S6L5YiKhsHe5d178FIGae/Yh3qK+v2rV8/RuLrl
	u60AHn9BbPBuup7PE
X-Received: by 2002:a05:6830:104e:b0:6b5:eaeb:63ba with SMTP id b14-20020a056830104e00b006b5eaeb63bamr3193855otp.27.1687460338354;
        Thu, 22 Jun 2023 11:58:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xtiYm1AlCWg8QeHKLFR3de2AQr2M0emZBuj2HLlTxb3l4GMDPlkysba03FRcXQD9vQEGY2A==
X-Received: by 2002:a05:6830:104e:b0:6b5:eaeb:63ba with SMTP id b14-20020a056830104e00b006b5eaeb63bamr3193839otp.27.1687460338161;
        Thu, 22 Jun 2023 11:58:58 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d66cf000000b006b71d22be29sm363209otm.18.2023.06.22.11.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 11:58:57 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:58:54 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH v2 0/5] arm64: dts: qcom: enable ethernet on
 sa8775p-ride
Message-ID: <20230622185854.57f7qem5w3ds5nzi@halaney-x13s>
References: <20230622120142.218055-1-brgl@bgdev.pl>
 <20230622184422.4e72vtqk53nnx42g@halaney-x13s>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622184422.4e72vtqk53nnx42g@halaney-x13s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 01:44:22PM -0500, Andrew Halaney wrote:
> On Thu, Jun 22, 2023 at 02:01:37PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Bjorn,
> > 
> > Now that all other bits and pieces are in next, I'm resending the reviewed
> > DTS patches for pick up. This enables one of the 1Gb ethernet ports on
> > sa8775p-ride.
> > 
> > Bartosz Golaszewski (5):
> >   arm64: dts: qcom: sa8775p: add the SGMII PHY node
> >   arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface
> >   arm64: dts: qcom: sa8775p-ride: enable the SerDes PHY
> >   arm64: dts: qcom: sa8775p-ride: add pin functions for ethernet0
> >   arm64: dts: qcom: sa8775p-ride: enable ethernet0
> > 
> >  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 109 ++++++++++++++++++++++
> >  arch/arm64/boot/dts/qcom/sa8775p.dtsi     |  42 +++++++++
> >  2 files changed, 151 insertions(+)
> > 
> > -- 
> > 2.39.2
> > 
> 
> Tested-by: Andrew Halaney <ahalaney@redhat.com>
> 
> note, I did uncover a bug in stmmac (imo) wrt unbalanced calls to
> serdes_powerup/serdes_powerdown() which I plan on trying to fix shortly.
> 
> Not really related to any of the Qualcomm specific bits though. This
> looks good to me.
> 

Bart already sent a fix!

https://lore.kernel.org/netdev/20230621135537.376649-1-brgl@bgdev.pl/

Thanks,
Andrew



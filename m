Return-Path: <netdev+bounces-120041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0D2958044
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30131B20D1B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0196172BB9;
	Tue, 20 Aug 2024 07:50:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6F18E34F;
	Tue, 20 Aug 2024 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724140238; cv=none; b=s7ghvSw2d8qr7Dj9a5uAN1LrQ9nvGaYhvlX5Eh5KYMIH+TOQ03VE0v7c/C5n/w2AW75UVVrjUCyPv7DA7iBATM7VVS2WGTr4eCQYyWCgexTDr8OtXSwq5nrk+vAma0QAknknvPMudt+9g2dhaZJ0UjZJ+cwtl2yqG3874eaUFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724140238; c=relaxed/simple;
	bh=PYFeMHuy4NKPwrQn4esjL8NQE9W3Q7RAkn8nEn+Ridc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeNRbX9gyk+pLs6x6ZX1EBqSlyf+jcXh6q/bvsNUvSutHo3sgWnW+PCIvK6DW8BOy9WDFmNaTIbhonRtH1RnszSqOOhwWIY+my54bK5rq8IGusR1z7rMufiZVh+VNDROuA9KQtW4SP0aFFy+ItURdfdiPdB9O0JN73tRIydZR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37186c2278bso2912761f8f.1;
        Tue, 20 Aug 2024 00:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724140235; x=1724745035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o12mpnNPmmOY9Ooh8+zOecO26ijzPcijpixgT0QUGm0=;
        b=lhUUG4/2mRJDElXK21vnMHM27i+1hna9zAla/f//8ebKpU2Amp4TWP6f+15+jg3ckC
         LaiWlZy5lXK+DvA977udroA82mOQtv0p0H79U/XgxGqy3DYImt+ATklA94DgQeHvfC09
         4+UBqSkEwuTBiVa29Q/tFlqI6cZuRniFD37nWJmu1XaAIjpM8bXEo8wuj6Htz07GC/Q6
         8t5KF4TW0SOkgJjCJZDt7OoAPSB/130jDk7A4KByaicDMBua21a+S2oI45Fapv788Vjy
         Lw4Nw/QU9XtFuUxQkOCIAvSm4FHXE3B/+borOwZWAuGdqRHSd06bnqxzbIuQnshkkKVc
         SMuw==
X-Forwarded-Encrypted: i=1; AJvYcCXD1K22Daj3irYu/zZr4tW2sVdb7gP6+E+T3MWjRryKZz3NYq//lh8ZgD0B6VWYX5qD1PpVK/I2a5cO/wxG+WCPdrTYwNBSfXE+osjBN7IYP7v3qtmUVx+eK1la22hRr39a4Q==
X-Gm-Message-State: AOJu0YwUpFr4aXQMjve3MXMF+lH2GTfO3PzfOu9vRpqvJ/LMLs2TSpmS
	TBT4GLj9NVnCLCMeomCKmDrt/+a9BDkW5wB1JcbOzYBklwXEfb+3
X-Google-Smtp-Source: AGHT+IHdo8uAZ95ZI3NyDnoyXiLtPPt5QJfyDawzkLfx/jQAGO3yurybsSwDxEc/wUSyvjVMc21iYw==
X-Received: by 2002:adf:e585:0:b0:36b:5d86:d889 with SMTP id ffacd0b85a97d-371c4a9c310mr1125086f8f.6.1724140235192;
        Tue, 20 Aug 2024 00:50:35 -0700 (PDT)
Received: from krzk-bin ([178.197.215.209])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718985a3b9sm12442836f8f.56.2024.08.20.00.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:50:34 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:50:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, 
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: pse-pd: tps23881: add
 reset-gpios
Message-ID: <dag2psqgw5lfzi6d4cdojwupwueoorv5z45ivcgipxcczoie3s@24hrbhsng657>
References: <20240819190151.93253-1-kyle.swenson@est.tech>
 <20240819190151.93253-2-kyle.swenson@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240819190151.93253-2-kyle.swenson@est.tech>

On Mon, Aug 19, 2024 at 07:02:13PM +0000, Kyle Swenson wrote:
> The TPS23881 has an active-low reset pin that can be connected to an
> SoC.  Document this with the device-tree binding.
> 
> Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> ---
>  Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



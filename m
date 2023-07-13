Return-Path: <netdev+bounces-17523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036B8751E0F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A53281CF7
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59568101E5;
	Thu, 13 Jul 2023 10:01:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506B101CF
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:01:15 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6337D273B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:01:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so81710166b.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689242469; x=1691834469;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/M+pj3sOHUyESIK93V4GQh+1nRLUFIcF7Y/I33mUxQ=;
        b=PF7NZgKmP2RkxrFnKSy8s1zMvSzfBwLHcqSq6qpC/yOx85SeOX1/IiEz5B/pYvd0gd
         X3Q5tU+pWDcsIbxZlW0q3x5jZDkYwmoxuELnwD0x+E7wvRCdiS5ldf1pbZPMZf1Nl8bL
         IZScRt/OQVD8uGoFKVqs5zKtJpwVfMYjQYSM9rHz9r82Ny1hJi5TfgqV4W0v2ZU3JBnp
         pMe9L/xGL8jox8/ixOz1oBBXuOndXcz86iAE9qr4wH8GJFsvht0MaZ4hmwZXhTThiDYz
         9LSaAFq9adU+W2nsTYLz/SlmXS/xT2xNAnhAIE3egnJFex1DHAytr3q6VbZ/vl4X7TGw
         no2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242469; x=1691834469;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/M+pj3sOHUyESIK93V4GQh+1nRLUFIcF7Y/I33mUxQ=;
        b=c+x+raJDp/OModhIwPRsxcskrCvRS9ARZt3jX3rQhlnUgbYYFcxlg0wdmKrqLcZyR1
         dEorTzxm/SOBh/fIHO86sgRGNG80q99xeyF7StFsaFqEEaEDMQXS0xjQPgL2uwQdK/6q
         0qgbGOclWjoGGNpyUcjvAG93WtNhBWBqeiRkwSRCs4tgn7m5rdWesQh+w6v0PDRuf2bH
         y8UK9sohuHqBVyLafGieGpFDvrhwPOccnxFcA1PhLs8o8hPT+etRCZjtwsZ8eXetk8l4
         sVj3bE0oB6CDqNBCHcYf0oeOKmSPxgRO+hanWl5VBS6JvqXzBJ0nBNR+Nvz6LZYex4L6
         pY4g==
X-Gm-Message-State: ABy/qLbUVTr1jporiX+MfjVQZZ42eMcO2pW3VK0i1aaPPD3f8wyR+gl0
	l5sb20r5lhYp7Rh4E7c+Boz/NA==
X-Google-Smtp-Source: APBJJlEqtwreGESohUF4BGCg9ioea4Pgd3hPuliT8cWOafgfdREMplipu6B24Py+pFdOX3VMzCi38g==
X-Received: by 2002:a17:906:1c9:b0:994:758:fa4a with SMTP id 9-20020a17090601c900b009940758fa4amr1038460ejj.46.1689242468874;
        Thu, 13 Jul 2023 03:01:08 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id lf16-20020a170907175000b00993928e4d1bsm3776545ejc.24.2023.07.13.03.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 03:01:08 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, devicetree@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20230616213033.8451-1-zajec5@gmail.com>
References: <20230616213033.8451-1-zajec5@gmail.com>
Subject: Re: [PATCH] dt-bindings: nvmem: fixed-cell: add compatibles for
 MAC cells
Message-Id: <168924246786.15304.6050913171032604227.b4-ty@linaro.org>
Date: Thu, 13 Jul 2023 11:01:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Fri, 16 Jun 2023 23:30:33 +0200, Rafał Miłecki wrote:
> A lot of home routers have NVMEM fixed cells containing MAC address that
> need some further processing. In ~99% cases MAC needs to be:
> 1. Optionally parsed from ASCII format
> 2. Increased by a vendor-picked value
> 
> There was already an attempt to design a binding for that at NVMEM
> device level in the past. It wasn't accepted though as it didn't really
> fit NVMEM device layer.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: nvmem: fixed-cell: add compatibles for MAC cells
      commit: a7964674427bdf5aa9ff342e4dfb8a4d345851a1

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



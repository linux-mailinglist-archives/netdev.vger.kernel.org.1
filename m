Return-Path: <netdev+bounces-21354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 564AC7635D8
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8703D1C211F4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D1BBE75;
	Wed, 26 Jul 2023 12:06:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266EF9453
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:06:18 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D67AAA;
	Wed, 26 Jul 2023 05:06:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso67886895e9.2;
        Wed, 26 Jul 2023 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690373171; x=1690977971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kul53tadDBthI+ZaYzNeqd+TymcKzV5bL/24P+6hvFk=;
        b=HJ87S4KwmBeYfs8n8uOY2DvNi1TT5XMvV+W4HvcYCD53KW8wdJoXGMtrkByjWP6E6O
         Rhv+oOjLfMiPiMnpp8u/bx+/d+UlQxqjfaAV4KVZBVpIYiFayZn5kNOheuD4sqybRaAD
         Fngd4YbABMDvlfcq4A4CPw+mgQVhImWjMkN7Xqp993TeDze9R4zXl2/ZQ/Pm0VRNefLv
         QCAa47iZ4WD5FYgIbf/KjvFlFmmFhc7CUDe2tcrBiCF4AyQW+Q142ovOHt99lARzmWQR
         mvM0dLUi7sVuxuRWeSFP1iEexROZfvAZDEXG7Kkh57gKtwywBDO3o1rEZbbdhwfB7V5h
         EaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373171; x=1690977971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kul53tadDBthI+ZaYzNeqd+TymcKzV5bL/24P+6hvFk=;
        b=hhpNYGfng9OonaVz5xpCqWBJVbvHQWTC8K0OGmqdjgjosBx/1+2SQQ9OJf7j69ftJM
         wMRI9sOp9dr5aEFMmL6epJEHg+chA47GgqridU+lAv9l9/IiXWpcEmgpYe2FhsuuRmjE
         GL4KSbfR+N2LGhNLzI9U4CK4o4tq52wpqkyFWIOPaVU+JcoBojA7y5Lvhe01Dwc3QAqW
         lKM6T724dHTR/+QDd2dTKb+JB4JIWJG37VOFox9KmONtBVffB8QsPu7jdzjhE42bzF1r
         iAjZMJBUzYdbI7kjFZOVwuzunmHTjJDZn3cfgR3YYLhtfwSpzlEC+BZL0Ep/ycRsPcQV
         2sOg==
X-Gm-Message-State: ABy/qLbX6ToI4OooARBRFNJRuUzZ8sBvmQRgQSWDBJg6qkJZWFq5kGid
	rJNckhBIl0IGyNCZ6OaT0DQ=
X-Google-Smtp-Source: APBJJlFl5ailxFDydedUb6tBX/nt3ApQLi716/ErNlzeATDHBIA1sI+tWXTMiHZzE2OkPgbDhof/Tg==
X-Received: by 2002:a5d:5550:0:b0:315:ad00:e628 with SMTP id g16-20020a5d5550000000b00315ad00e628mr1307335wrw.47.1690373171442;
        Wed, 26 Jul 2023 05:06:11 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id l25-20020a7bc459000000b003fbaade072dsm1819165wmi.23.2023.07.26.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:06:11 -0700 (PDT)
Date: Wed, 26 Jul 2023 15:06:08 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] net: dsa: tag_qca: return early if dev is
 not found
Message-ID: <20230726120608.idjprlnv2i4uy4jg@skbuf>
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 05:30:56AM +0200, Christian Marangi wrote:
> Currently checksum is recalculated and dsa tag stripped even if we later
> don't find the dev.
> 
> To improve code, exit early if we don't find the dev and skip additional
> operation on the skb since it will be freed anyway.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>


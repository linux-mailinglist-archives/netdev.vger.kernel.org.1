Return-Path: <netdev+bounces-22918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D653676A047
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848B62815B7
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95021DDCA;
	Mon, 31 Jul 2023 18:23:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0E71D319
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:23:19 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD8919B0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:23:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bcf2de59cso762213666b.0
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690827794; x=1691432594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rf2SueqzGQo0vJNgUag9FW9PB32GASllyVQGKBWgKls=;
        b=5dLyn4WKWw7B3rxWFFir/LC1tRlLJAoVZpvvQdLTEpU8+nwbw8vVlqMnf/IwuBFgj0
         d2v2k7swJJ4fJ5Q7P7F4Zmz23MLi9vA98/kr0qQpd2VkGi/l1LtMlTY+WL8PsJUbEcsa
         7RoEWNAD/Y0NnmWYIo43QmdHJCaPiBufBaDpv4w7lGUqSGjXaIG43gMJIVVOKAQPpIVC
         Y0GxhlMsozAB2XQC2jFr3IWwA/Ex+Ow/T0Qa0o/ZU8Y6bgXIREJGMQhvZn1oBa3st+nk
         lAxIBmANtX3D0xD9tZ0lLzNmey8ygWVd17YrmfmlmwqBoQHWlniU7OU5U9LDXR6fppF+
         IEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690827794; x=1691432594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rf2SueqzGQo0vJNgUag9FW9PB32GASllyVQGKBWgKls=;
        b=fbznCVXRJqduH0nQ08eqhBL5Ftd+p6xmqrGyZPgv2eSdG7O04Nb+jF4Nomz5aJOUjY
         sL1JeB31m9ofmtnXRZQ1zq8N6EV2EEYs9aJqn3dClKDm+SfUCYM4twLC0YDPrleVa6JO
         lkinj7Yvr5/izpOBYeyOTx6oe+UX0Y00eMaauvaUAcAWqnHchZZeGsg+LqvbY7K/Zr31
         TAMehJpTb6maYtu+OWs12+dNaRDXT/BYtXod2ICo1LfvNdjodN8TXqZQzk2X41BU6rwI
         uIzE0H+JQXGiV3ABmyNLnznzDZIo/s1Og/nG2aURPgj5N5mlr1m/yzda+HERPC/Sdzr7
         Sx0A==
X-Gm-Message-State: ABy/qLYVtPlPV6Ar1fVx+BRX0zXJWdYEfTDtwYyty0UsIDyFym4EVvSA
	ighSoDZKh1ql42NNbh9lqfQc6g==
X-Google-Smtp-Source: APBJJlEqhF6H+EF9UPW9v/50+fttk+UTCFn+fLaauftKmdzDXQ7UgKfy7xULxO8s4MFkZ/WstAheqg==
X-Received: by 2002:a17:906:530b:b0:992:ef60:ab0d with SMTP id h11-20020a170906530b00b00992ef60ab0dmr321850ejo.69.1690827793970;
        Mon, 31 Jul 2023 11:23:13 -0700 (PDT)
Received: from blmsp ([2001:4090:a246:80e3:766f:be78:d79a:8686])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090681c300b00997d76981e0sm6457533ejx.208.2023.07.31.11.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 11:23:13 -0700 (PDT)
Date: Mon, 31 Jul 2023 20:23:11 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Vivek Yadav <vivek.2311@samsung.com>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v4 0/6] can: tcan4x5x: Introduce tcan4552/4553
Message-ID: <20230731182311.fxq56r35y75j6vde@blmsp>
References: <20230728141923.162477-1-msp@baylibre.com>
 <20230731-issuing-unshackle-20c6cbcbca98-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731-issuing-unshackle-20c6cbcbca98-mkl@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 03:47:18PM +0200, Marc Kleine-Budde wrote:
> On 28.07.2023 16:19:17, Markus Schneider-Pargmann wrote:
> > Hi everyone,
> > 
> > This series introduces two new chips tcan-4552 and tcan-4553. The
> > generic driver works in general but needs a few small changes. These are
> > caused by the removal of wake and state pins.
> > 
> > v4 updates the printks to use '%pe'.
> 
> Applied to linux-can-next/testing.

Thank you, Marc!

Best,
Markus


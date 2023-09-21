Return-Path: <netdev+bounces-35585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AEB7A9CC6
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A151C213AA
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D19CA7F;
	Thu, 21 Sep 2023 19:24:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088114F89
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:24:22 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC14EBCC6;
	Thu, 21 Sep 2023 12:23:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50435ad51bbso312179e87.2;
        Thu, 21 Sep 2023 12:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695324191; x=1695928991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4itH0RtPrQrvEWQ7YNqEtHSYRc/MZwID9TMRLsspzo=;
        b=FOwbGl1N95WlEG3mzvcCIhT8gDBYTnHPSXeHj9rl8fZUyEZPXJOoqUAz9BA3wtHWsv
         gt/AKpELILOGyIt4n946Pj5Ocw92hZZtCfoRnMgAafroFd6520DMiCR7FnBEzp0nJpTJ
         Tc8u77BFrnEsoEKlJpCal44OFxTf7K/Arl1yBIjMUgVVtKJPTG/1d6MsMnQmJXcCg6db
         EeUbNqHrgJh34tOqeha0PbpqMdnroQ3FETh4kriJM5PdxQ2lx3QOOHWBydIQIW0JXPJC
         sztJfptemvA2tkjEkWz+h/IQWamaqvopjDGcZ/H2Vj9zm+JMj/QBM43uLr6QiD3dIQc2
         msAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324191; x=1695928991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4itH0RtPrQrvEWQ7YNqEtHSYRc/MZwID9TMRLsspzo=;
        b=MN3rS+ERGJQi9knZjSaPSmh/o0LuJV3Ql3/kVz8z60yWVAFvHQdTQD/otxVBBD4kcA
         xE0wghzNy23R7f4JCMXLyS4WgqEqEpVA/feSDtlDsRvprV7JC9Oq/5aqB688I9yZCE0B
         PFdS6j6EBDrkoHCyVALXqbeOzAY1YGOd5BSZD33qj52rFkdyB0aM3m2khTnDh77IkUrh
         mhttdbONtF3UY1MUU4/zzTJo8zGXNCI7KY4qr06ZuWuqE1gZmZ1/6Lf/kNtbSwTDYzFE
         SseXwxIaRdevcTjTlnWrbesyomtdq1q0np/NwNUKe4jk2Y26IDrIuQDadR5ygCWgJ/uB
         V81Q==
X-Gm-Message-State: AOJu0Yxa12pVqHwtD5noWL/FCRIckKTL5XnFZP5URbb+WQs4j9kWs0KO
	iVKH2fKRLXyVrOUke1Nzo7E=
X-Google-Smtp-Source: AGHT+IFr/QOQNTwaADJFkWONIUg85Frzsn+vPGhJj1JJdU1yCZkcp3NVAdN2nnHZvoVDAJqP9Bj//w==
X-Received: by 2002:a05:6512:23a2:b0:503:258d:643c with SMTP id c34-20020a05651223a200b00503258d643cmr6689482lfv.21.1695324190909;
        Thu, 21 Sep 2023 12:23:10 -0700 (PDT)
Received: from skbuf ([188.25.255.147])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7d494000000b00531990ec4dbsm1229876edr.54.2023.09.21.12.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:23:10 -0700 (PDT)
Date: Thu, 21 Sep 2023 22:23:08 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
	Woojung Huh <woojung.huh@microchip.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading
 for KSZ9477
Message-ID: <20230921192308.kntudhbwc4j4skza@skbuf>
References: <20230920114343.1979843-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920114343.1979843-1-lukma@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Lukasz,

On Wed, Sep 20, 2023 at 01:43:38PM +0200, Lukasz Majewski wrote:
> Code: v6.6.0-rc1+ Linux repository

Your patches conflict with Oleksij's ACL patches, merged on the 14th of September.
https://patchwork.kernel.org/project/netdevbpf/patch/20230914131145.23336-1-o.rempel@pengutronix.de/

Please always submit patches formatted on the most recent tip of the
"main" branch of https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
at the time of submission, not "v6.6.0-rc1+ Linux repository". There is
nothing that will be done with patches formatted on older trees.

https://patchwork.kernel.org/project/netdevbpf/patch/20230920114343.1979843-2-lukma@denx.de/
netdev/apply 	fail 	Patch does not apply to net-next


Return-Path: <netdev+bounces-24678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04220771054
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 17:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD891C20A98
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D21C157;
	Sat,  5 Aug 2023 15:04:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB61FA0
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 15:04:42 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B015CA4;
	Sat,  5 Aug 2023 08:04:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bb91c20602so6523425ad.0;
        Sat, 05 Aug 2023 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691247880; x=1691852680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ytrMVlVv1UK/Az0eboWXoW3oWMRE9Ry5HZu9EP4O7Hk=;
        b=Mk+wLubbtaR1qwT8sRDFUvnGC6q178WVxAnUzZsXJqb78Bi7HyfLQv37e9+cNYgtfe
         MQvhVW1w9wG3pNf4iVnRViD6V/Mp8AnkEDNpASleivqmUYhIGhJpXanqfrXnkYmH4UkV
         Z2yHlUV1PM3SllRDNxjkTCraMkCryDBud3mNwFmocYm4pJPzqEP5n9/f3GHoM7Vniqar
         Q4xrpQDPfaXefIboS0GHi0BJ/79Le7cHAmeaRjyEPJLEySe48L5MUbzRO44rI+usXfNE
         qJVZhx5e3aSLKKKtUdKrWrKZZgtoCXVv2WE/SE6BSueIAFzmL6a4pRD+DJWqZWssDr6p
         NOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691247880; x=1691852680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytrMVlVv1UK/Az0eboWXoW3oWMRE9Ry5HZu9EP4O7Hk=;
        b=Kyo8Uzoon51Jy8iK2wGCnnosMRENlbocv39ORUNzFpIexuC0KHsO5t/td1GbmJMuBB
         PTrCsylj+phq+WTSNqQDWVglUncnEabMmnceds4JNPPiYKp5qx0DExpRvrsOlxx6yNDS
         vK+NhJeNbswGKnX909faieT4+ZV80Tu7FGZb9W/rtjVHix7NeqAlAocb4vjQBzvS3FIx
         7KLN3oBMltmj89TbdVcOM33msRpsdUgZpOh5EqD35J/fiOrt1kPpOdVvZJcreJVIVuep
         6ytoAtXmtl2Z8BmrE9J0fHT6m2xECzjFYYkbWHkHyTEvkqCi4lU0M2Qaa5GfPZlHi8dF
         HoXQ==
X-Gm-Message-State: AOJu0Yz6jzVx2Ezm7izF2jHAQ5mtwkVhrJ0GNbMAhAKKlv74Ps1xffah
	S1aeXoJeqyER+R3arp9L7FM=
X-Google-Smtp-Source: AGHT+IF82ItI3skCFLQdfd5ecBJpcyON+saJ/4iH20OqWKlhvzIiHpi4OFMsVyx/ucee9F5mPKGlig==
X-Received: by 2002:a05:6a20:8e19:b0:140:5067:84b3 with SMTP id y25-20020a056a208e1900b00140506784b3mr2213271pzj.0.1691247880108;
        Sat, 05 Aug 2023 08:04:40 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id u6-20020a62ed06000000b006870ccfbb54sm3263234pfh.196.2023.08.05.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 08:04:39 -0700 (PDT)
Date: Sat, 5 Aug 2023 08:04:36 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Zink <j.zink@pengutronix.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>, patchwork-jzi@pengutronix.de,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Kurt Kanzenbach <kurt@linutronix.de>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 0/2] net: stmmac: correct MAC propagation delay
Message-ID: <ZM5lBG+eXG9WukOV@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
 <20230804132403.4d9209de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804132403.4d9209de@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 04, 2023 at 01:24:03PM -0700, Jakub Kicinski wrote:

> Richard? Sure would be nice to have an official ack from you on this
> one so I don't have to revert it again ;)

No objections to this version, as the correction is behind a feature
flag that is opt-in per device flavor.

Thanks,
Richard


Return-Path: <netdev+bounces-35239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B07A815A
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF641C20C7A
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5B530FA7;
	Wed, 20 Sep 2023 12:44:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120781643E
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:44:32 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51FADC
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 05:44:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40434d284f7so71073075e9.3
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695213868; x=1695818668; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RVy2qHmRmpE+nH6pRIYrYXxYlE5oG17GOGX+94bGa1E=;
        b=tOBKt2U0NahUa50gIPF5apQPdUxfFQ692XEzuYQ0Uos9yre6EpFv3VUxgOiMVqnGEY
         YPAfMlHaQuBvhKK4NsBnGiWdgArAiDV4tVjVx7OqyQ2OKIWo16PmBl+o98G/I15ZAanI
         DmBCU8Y/6TAkDimow7HxzCOMiXiQQziacIgdzYoyGmhn4ldOtgke43Ye8B5ASlyKfeZC
         Cl44/2h3iZOclrm+fcRT1FqgT0/dYfRQgQVoZu9MkR1LdbBx/w9PN40Q9YbI4b4LkooL
         Z5H+Co+YFn9AFwPNFxK6cXqFsSwhnIk1xqJLOKfpWu1Nag06+IMf7+UO4FHC8EthIwbx
         VKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213868; x=1695818668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVy2qHmRmpE+nH6pRIYrYXxYlE5oG17GOGX+94bGa1E=;
        b=lVtwjRB/pC4DyIV6U2k9J/L979HZoUR3J2OrCN9ZUkvUIYilqTJmFC6dT5MFXkRoLJ
         Epf7BjQ3Q3rxV5mzqWCs7KmmpQchPfvCqsLZn8893o/zIJycmCElK4fWTHIKumMFr4g5
         If4DXlOUHNET05npLcEoUKLYtEpqGXgCCeQRrvc7Si+nipg/DfF8li+jCTS5DhxlRrg9
         0XAGe/CM3KbQHxFOmxLymbqUdZoPlC6T4ttGUB/gbpeanAsB+N32vQXKLt6j1nUYayth
         JBJYN2p1cGY4MPx7SLsjOFgmYGaSaWC5JXQIlJCN4DC8EuA7+E53reaEAkGI7pldTZHF
         pCfw==
X-Gm-Message-State: AOJu0YwdEqkPIjFgDhVdPSVxnHUlLPLISHuENaZvUNkjHZIlMYfzYZZn
	IQax/BkR9OUpJzm7NLS/5Kbgwg==
X-Google-Smtp-Source: AGHT+IF4qWdoFXxkF+qF6ryMq2zGsU1banfQ8fGG0bdHB4MzV8gw3QhiJ46LvoIqntcZ4MygVUV4ug==
X-Received: by 2002:a05:600c:144:b0:405:1ba2:4fc9 with SMTP id w4-20020a05600c014400b004051ba24fc9mr2371610wmm.15.1695213867938;
        Wed, 20 Sep 2023 05:44:27 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id q30-20020adfab1e000000b003177074f830sm16955049wrc.59.2023.09.20.05.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:44:27 -0700 (PDT)
Date: Wed, 20 Sep 2023 14:44:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Patrick Rohr <prohr@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Jen Linkova <furry@google.com>
Subject: Re: [PATCH net-next v3] net: add sysctl to disable rfc4862 5.5.3e
 lifetime handling
Message-ID: <ZQrpKEHqeeTd4j5b@nanopsycho>
References: <20230919180411.754981-1-prohr@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919180411.754981-1-prohr@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Sep 19, 2023 at 08:04:11PM CEST, prohr@google.com wrote:
>This change adds a sysctl to opt-out of RFC4862 section 5.5.3e's valid
>lifetime derivation mechanism.
>
>RFC4862 section 5.5.3e prescribes that the valid lifetime in a Router
>Advertisement PIO shall be ignored if it less than 2 hours and to reset
>the lifetime of the corresponding address to 2 hours. An in-progress
>6man draft (see draft-ietf-6man-slaac-renum-07 section 4.2) is currently
>looking to remove this mechanism. While this draft has not been moving
>particularly quickly for other reasons, there is widespread consensus on
>section 4.2 which updates RFC4862 section 5.5.3e.
>
>Cc: Maciej Żenczykowski <maze@google.com>
>Cc: Lorenzo Colitti <lorenzo@google.com>
>Cc: Jen Linkova <furry@google.com>
>Cc: Jiri Pirko <jiri@resnulli.us>
>Signed-off-by: Patrick Rohr <prohr@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


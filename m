Return-Path: <netdev+bounces-31002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0578A770
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 10:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E963D1C20831
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8443D4429;
	Mon, 28 Aug 2023 08:17:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730083C0A
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 08:17:54 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B405E44
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 01:17:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fee769fd53so26700325e9.1
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 01:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1693210652; x=1693815452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx4zN2rdqgglN0GUYbNzhDcYU7aChImFGXvD0Vx4w2I=;
        b=b7a0UlmiYRwGEaAQOlMJnbVfxSG369d171IGG25QUZ38RbSlY58gJNgwSzF6/PvRYN
         mZugjw7IpjQrgIpbRMDZO+xP9SeSW3DCgm9yh9pNHJNbIUIsogs/AhUha9NGHzMWfvXO
         NZpgl0wwcsOkhyyokUOJyGsqjsAtYucJxN9Cdz3qqea/IoBfByIRWXEQGADdAljPwyaC
         VeVasTuiDbnEeQvpwcc4O4LdJ8UBHrFFjVfIbFLqZjeEmfpyFqFidC381fx/UNi6xSaE
         VpagkXjlol1Vcz0ObFJT3KEy1GmJx/h712xtSC7FaH/QiU2OU1jyLawLzF7aZf9g0TJg
         Y5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693210652; x=1693815452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vx4zN2rdqgglN0GUYbNzhDcYU7aChImFGXvD0Vx4w2I=;
        b=V/fQD6oC/wuyjyi7+6raOLJpkNl1CA9nNVQPSdX7AsmRckTsp6sUJ1wvmGooISwcJa
         CZpviG/4MAS/7Oy17bUCV2FmCFAblBtS/w3QrzJOc3zCkPx+MkEgcNMpkUh3SIRgp1LY
         qfH/G/ZQsYrHFN9f7/TqiP6RoyzBvpRE02DD0qCNI+EXPr8CiGQZD9Z/tKJkhmAr8OdZ
         nx7bNzNOsMmCVr4rrCYruWXOhjWroQ9vBPM2JUJMKFiZlZfUxApD7ucEEtOfG0jUlvPR
         fk1f9atLfxaY0oc/egQo4P5ub/SJFSiyB7Y7huNqy9miEUg2Tp8MGQcwWCeFDnGe9Jiq
         FjSw==
X-Gm-Message-State: AOJu0YxY3FY4EWFhsgU6wpZBuDD6g9T3QoWTNrQ/k/S7i/mAQDpgha5F
	9zRZFpCGGdKdbAKYCq/p7GJNYA5eulTxCvhDID/aSg==
X-Google-Smtp-Source: AGHT+IHsoYP7M+c7yE1fyzPxq+AhdAjR2Ve/XhiETk382RwjoKogO/lCvLPf1vlMAu51MrGLmWLaWQ==
X-Received: by 2002:a05:600c:2307:b0:3fd:2996:9d88 with SMTP id 7-20020a05600c230700b003fd29969d88mr19371575wmo.25.1693210651895;
        Mon, 28 Aug 2023 01:17:31 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d51ce000000b0031ad5470f89sm9810398wrv.18.2023.08.28.01.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 01:17:31 -0700 (PDT)
Date: Mon, 28 Aug 2023 10:17:30 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [ANN] net-next is closed
Message-ID: <ZOxYGmAuVjUJ3hEO@nanopsycho>
References: <20230827172323.1c988b58@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827172323.1c988b58@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Aug 28, 2023 at 02:23:23AM CEST, kuba@kernel.org wrote:
>Hi,
>
>v6.5 has been released and so the v6.6 merge window begins.
>We'll make a call on outstanding patches on Monday, please
>refrain from posting non-fixes unless explicitly asked to.
>

Hi Kuba.

I sent rebased devlink/leftover.c split patchset today. Please consider
taking it in so we are over this :)

Thanks!


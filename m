Return-Path: <netdev+bounces-32531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE83D7982E2
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 08:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AE22816FE
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 06:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E42515C8;
	Fri,  8 Sep 2023 06:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB11389
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 06:58:25 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0779B10CF
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 23:58:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fef56f7223so17773775e9.3
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 23:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694156302; x=1694761102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IS7APAXWLyRKAmVXEey0BMtRb06oUTAybc0N4RvhQnc=;
        b=KFK8tlXXPvW8nsUu32Blic3UJ+2pt2UH5jVJfkBU88QDxKP2v5v86dgzKUXXWHzdow
         q7qk6eJ2ibm3nKUcFdsTCrFMTxsqyWl+5oBqlmug9uL19xxbwOo1fSdYFUYkin+okocp
         4Y3kH2s5KQOgPcGvxVE+VtRUKY/i1HKYfwsPIXvdNOrFzoGtxh7xuF30OZ1qzRjSvtRO
         Q+Sl47pnla576a9pWNmAvGTniOwcUM6ggaKx62+1V6FXXAVHmR1aCw4pVWLqlyEpbKxz
         2/CmS1x9xWmTZdi8GjM6OtQzBXtb8ml4aAqJGVraEy18wDUaqszEPZ15vpNYpXw4vm1p
         +yzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694156302; x=1694761102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS7APAXWLyRKAmVXEey0BMtRb06oUTAybc0N4RvhQnc=;
        b=wRLgeLvgSAtoS7x5MAm1dkLSRFaCatja6LQmkBdAEC+W7+tNf85ODWcCy6j2TXRr8y
         3Ve73FmsnvAQGeeNbKq2+gXQViRFgz0kSRwvoNf6iANIeZvLHHToljBnlJ7XGvn+WFDg
         Fo2P5tGxYvGDBkpRPKFPzXy0NzhnG3QZygwUYtvQ+5iyWszHN6/lug+CPdjc6ZiUp4S+
         dFut8kMt+kfK9/djsVe3vL6leg0UXCvciiFyBkr3grL3d8rjfswDIFPeXHwHqUjtwsqO
         SOfhK3nGNNojY8Pv8wVhEJpkU+cEnNQxx8ySwHHNy+q1YOUyoni/yXvOvA1NoEf4zDNc
         ApSg==
X-Gm-Message-State: AOJu0Yw3gdrb7Uhx2BmkusHz2+ArbmQNVumYZsM/uEYpZV0LmcmgifBK
	tQnWw6vGy0Xi4Fvj6aHP3BlarQ==
X-Google-Smtp-Source: AGHT+IEZV1Q27i9G8hEK5mZxwqpxrF/pwUjpH/zY9fyCoVx23TMN0b8UA/eU3imtpk7CgnINvQq+qw==
X-Received: by 2002:a05:600c:2483:b0:401:d2cb:e6f3 with SMTP id 3-20020a05600c248300b00401d2cbe6f3mr1573418wms.1.1694156302156;
        Thu, 07 Sep 2023 23:58:22 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l23-20020a1c7917000000b003fe17901fcdsm4361670wme.32.2023.09.07.23.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 23:58:21 -0700 (PDT)
Date: Fri, 8 Sep 2023 09:58:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix uninitialized
 variable
Message-ID: <8a7f79be-e775-48ce-9eff-afa399e560d7@kadam.mountain>
References: <9918f1ae-5604-4bdc-a654-e0566ca77ad6@moroto.mountain>
 <51d1ae238aecde07b2b4fe02cdab0dc87287cd96.1694099183.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51d1ae238aecde07b2b4fe02cdab0dc87287cd96.1694099183.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07, 2023 at 04:14:20PM +0100, Daniel Golle wrote:
> Variable dma_addr in function mtk_poll_rx can be uninitialized on
> some of the error paths. In practise this doesn't matter, even random
> data present in uninitialized stack memory can safely be used in the
> way it happens in the error path.

KMemsan can detect unintialized memory at runtime as well.  But
presumably no one runs that on production systems.

regards,
dan carpenter



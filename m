Return-Path: <netdev+bounces-41177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C1D7CA161
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 10:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D72B20C42
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFC518628;
	Mon, 16 Oct 2023 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI7rEVu0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F818623
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 08:14:10 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629BAB4
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 01:14:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d849cc152so4031161f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 01:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697444048; x=1698048848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQjpvg7MGAmM9iA2NCznSunlkzHKe6ycndsouHEmzpk=;
        b=FI7rEVu0d+bcprOnEwUUMLepoKMOAjGOP1ycO2fnjGE5KR+amB55erC0onsSvWp9RZ
         h0E3TeyKZiNeA4+mwMgfU4QDRZQSWL12o1CTpt4KkG0hwobNEtPktwWH2f7ZnKX4BCQj
         hrd9dc6H1tqHpbMJ6sPe65mVEnpX17biggHeISbUJCxijhurPyUpGwsuGPlU43Yig1iZ
         3yInYejnUbXJA0QYgVzJKq2TWQpAuHzHAxIQGwD94rV5HD300tQKFejMPbJZ2w2TSYJO
         8P7NWj8kPePKfHn/9SxGYQje+JDjyD1fhnXjE9Luxc7fvuKsfW7dURuMELW2DjIIkvBt
         cv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697444048; x=1698048848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQjpvg7MGAmM9iA2NCznSunlkzHKe6ycndsouHEmzpk=;
        b=jd8SwgLiARekgJhAImajSReQvyCHmoJaPuRVhOeNnYLlvzEi2N9td6Irkm4OTBKnxV
         1O5Z1lKSTLzXhrRP3Z1BvvvSmuVygcZk23d5E72hQS8e/d+zzIdpG/wZraPmN0tv7YYS
         MaXJYZShqagGECOvmtUwxTLQbpIwAoTvSyjGBgfbV5CK3GRpjnIOcu73ocz0L2lUyfqd
         pBni9+bynn1NBGmAtqDs6WDFKKEn23AQjAiHyYxg92BkEyJlTbjLnDLYk0D5TldBHJj6
         3ykL+qdqUlp0G/CGRy1YP784HUlEyIfqrOuJihrP+vrTFJ0D4Q1WtPFiqKdLpC3fZ/h2
         1OFw==
X-Gm-Message-State: AOJu0Yxr2bSKf9iuZC5ST/8Jizn5kPJYceUnJdS2vSdH0JMbp+VA+Ybf
	q/tp+WGcgB6wLVTne+sXxz8=
X-Google-Smtp-Source: AGHT+IHJ1KBmQhTTq9FucQdsbJI/NYYxMdPPS/M5zXZ3oFtQ7bspxLFQzYZRQa86eK5qXpsCLWebeA==
X-Received: by 2002:a05:6000:1189:b0:321:6936:c217 with SMTP id g9-20020a056000118900b003216936c217mr26853069wrx.14.1697444047600;
        Mon, 16 Oct 2023 01:14:07 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id t11-20020a5d534b000000b003232380ffd5sm26703515wrv.106.2023.10.16.01.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 01:14:06 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: kuba@kernel.org
Cc: chrony-dev@chrony.tuxfamily.org,
	davem@davemloft.net,
	horms@kernel.org,
	jstultz@google.com,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com,
	richardcochran@gmail.com,
	rrameshbabu@nvidia.com,
	shuah@kernel.org,
	tglx@linutronix.de,
	vinicius.gomes@intel.com
Subject: Re: [PATCH net-next v5 5/6] ptp: add debugfs interface to see applied channel masks
Date: Mon, 16 Oct 2023 10:14:04 +0200
Message-Id: <20231016081404.1647363-1-reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012163733.1f61a56d@kernel.org>
References: <20231012163733.1f61a56d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski said:
> The netdevsim driver which is supposed to be used for uAPI selftests
> now supports PHCs. Maybe we can extend it and build a proper-er test?
> 
> Whether we'd then want to move the debugfs entries onto netdevsim
> or leave them where you have then now is another question..

That is an interesting idea. Thank you Jakub. I will start looking onto it
at whatever pace my other duties allow me to give it some thought.

One challenge I anticipate encountering is that even if netdevsim has PHC
support via the PTP mock implementation, we will probably have to think
about how to simulate external timestamp events.


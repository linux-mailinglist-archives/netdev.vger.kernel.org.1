Return-Path: <netdev+bounces-40584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CA57C7B97
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 04:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8E81C20BB4
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 02:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED714A44;
	Fri, 13 Oct 2023 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="QjsGWQkD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5634BA40
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 02:27:43 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842E4D6
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:27:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27cfb84432aso1199554a91.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697164061; x=1697768861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hzd1ftMQtB2BTCy0YmK46EH/0A56hMuJ7a7pVN/TrKs=;
        b=QjsGWQkDqh7XeOimt5zyJjEd94HQyoG6is2+nk1cAN8zf+4HpRZsQ5VhniDLgbEULE
         8577dWPvUCsyaeWahFMqgRwCauU6HBnTCKpp853yHFwVbFV/aZ+yR6sWX69SxO9R8HJW
         0HN60lNPJq/5ACEcF7mEcpzeCUFiFJoX3Q7Vi6tEisdaPYew73iJkccEBn6TTBPxgXl3
         DqmqYflIOQreHHBRjBOLSItjTznWDpeLHZQKzkcXuKF7ojAK+1SPrNxqE2paExIqfXa8
         idmNp5X0EmOtNA/wZxlctZG8a3v6UBGqRY1ymp9c54XnqRj9C9YMDusHVFOVbNXScFnY
         hP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697164061; x=1697768861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hzd1ftMQtB2BTCy0YmK46EH/0A56hMuJ7a7pVN/TrKs=;
        b=anBJIzznj5qRDGI4CboGDpCYKmCXWCx3ZGU6GXl1Zi/M9UMrOSlNjHSENh52+JxIhg
         hQtxpiUsniJJOQTyBtv1/pHDbvYreZsB1auNOmJRtmJFmq7uYI+n4U6Ua6mVGsKfpuir
         yX0D/+UYs7gpRFk8nBNsd6lu/EwqHmv7nF7RfuJjpD2uBRsPWInUnKzr7Xp4r6WhWiu9
         ThNCChaay6KCKcZwsbBKq2kLAmidk7CQ0eSU3lqjcPXLcyeW0y3dt+mgjQuBaZhYr1qH
         FB06JyxeJLfloW8cN90wy7B0x2InTFdxQgAgDL5X8sjdrbE+mTvEXxBjYdwcaLqchwAg
         eUTw==
X-Gm-Message-State: AOJu0Yx5IPE7J1cCbsiHMueL5sQTeg+oz5ZbF0ShgzVTWvNu96gglRu7
	fnyW6qoyheGbcS7Lfp+pPl8p2ZgnHJRTzent5FixgQ==
X-Google-Smtp-Source: AGHT+IGoTN2C4roNtrSYRKYUnUYawQW/M1P5VhRIdVvftnv9XfoPjBlGSftc3z1ZNzMixxESHb0DkQ==
X-Received: by 2002:a17:90a:fb83:b0:27d:4129:ecd9 with SMTP id cp3-20020a17090afb8300b0027d4129ecd9mr2595pjb.26.1697164060876;
        Thu, 12 Oct 2023 19:27:40 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id gm14-20020a17090b100e00b0027d06ddc06bsm2490510pjb.33.2023.10.12.19.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 19:27:40 -0700 (PDT)
Date: Thu, 12 Oct 2023 19:27:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, "open list:ARM/Mediatek SoC
 support" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231012192738.34ed1f19@hermes.local>
In-Reply-To: <20231012231029.tqz3e5dnlvbmcmja@skbuf>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
	<20231011222026.4181654-1-florian.fainelli@broadcom.com>
	<20231011222026.4181654-2-florian.fainelli@broadcom.com>
	<20231011222026.4181654-2-florian.fainelli@broadcom.com>
	<20231012231029.tqz3e5dnlvbmcmja@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 13 Oct 2023 02:10:29 +0300
Vladimir Oltean <olteanv@gmail.com> wrote:

> >  Secondly, it is possible to perform load balancing between CPU ports on a per
> >  packet basis, rather than statically assigning user ports to CPU ports.
> > -This can be achieved by placing the DSA masters under a LAG interface (bonding
> > +This can be achieved by placing the DSA conduits under a LAG interface (bonding
> >  or team). DSA monitors this operation and creates a mirror of this software LAG
> > -on the CPU ports facing the physical DSA masters that constitute the LAG slave
> > +on the CPU ports facing the physical DSA conduits that constitute the LAG user  
> 
> Replacing "LAG slave devices" with "LAG user devices" wasn't warranted,
> and it alters the meaning.

The term slave is not in the IEEE 802 standard.
Most other implementations use member instead of slave.


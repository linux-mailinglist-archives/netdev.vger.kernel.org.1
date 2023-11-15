Return-Path: <netdev+bounces-48025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9457EC50A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95401C208BE
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF73A23761;
	Wed, 15 Nov 2023 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="k6F/3ZMJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19728DB5
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 14:22:44 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A91CC8
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:22:43 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c83d37a492so53305901fa.3
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700058161; x=1700662961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzHvEgkhsVZ/B/5Q7VHoErO65rCeMN9lMbO3/U+qUgM=;
        b=k6F/3ZMJu1O6v3Bu2idhCY81dhj79zGY8j83DXtkuHP082ixAgdHUSXeQWPuPxu988
         hTTmnI9iAh1Dy38BUx3V4mTFtO2no6XW7sgHkmN17Qfouu2Afl5+M5+CuHhI+g1a9LmV
         rwk/LZC0uS6Ki9ukdozheeXECQJ3len7ScR2PZMnEx/T7Ivs0QKO4lZFzKhHrt9J2EEq
         Df4yWDyaEX7q7Vfq50EW5QISYKYKCvaF2+pP0GKbUAgykazGw6YcQTyWdjN9oXB+cU72
         vveUZK8Cg4zi/3o5mltVc5mi2HbylNVaKdZ4tstqrXLz1rT5/jMPNk7FEDxbKZvyPFRO
         Zgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058161; x=1700662961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzHvEgkhsVZ/B/5Q7VHoErO65rCeMN9lMbO3/U+qUgM=;
        b=g07LAvDw9qosBWZ+FP19LIrvZ5MRaY9120DEoHod/kxAsqgEVIBbgpJ+yCgBkfhIOc
         37dGvvS3yB9i/fSLSd98ZJ78hacLzIx2U+1FAMs0L+AaoQ2U4pEIWsORGe4XW6xtTz6c
         bhm713AqPAPSOoxpy8WBF+d9Y1tGV+lhnN14FPESWvbTBt0X5e8oiPFF0cK4FQI1GnuB
         9x2I/KgojexcEg9da3rrgIEHMHcwJ9Yx/a2SkfH4sI7x9VhLAnfXyOdn8KI4efFgrjPw
         R8nWBRWsSToILPpVKWAyEBg4950FzkIL58f+k+HXASvIoFnUzbHbO19bhZwZzQ+Tgrtj
         W9iQ==
X-Gm-Message-State: AOJu0YzXWYBK4b9Rc4wtBiHoTo/dFC11+tG/OhSivxzIKpwVHryGZrOE
	4DoqINuUawKdfwq3wFPOF0yjVg==
X-Google-Smtp-Source: AGHT+IEq0fELpz+Nfb/xCviHqJcZEguReGXAlayiDpQKD5r09Frh2JKGjzpvINjNc8Ld9o2DKd/L8Q==
X-Received: by 2002:a2e:9410:0:b0:2c8:3269:2328 with SMTP id i16-20020a2e9410000000b002c832692328mr4264658ljh.29.1700058161246;
        Wed, 15 Nov 2023 06:22:41 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c26-20020a17090603da00b009adce1c97ccsm7086836eja.53.2023.11.15.06.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:22:40 -0800 (PST)
Date: Wed, 15 Nov 2023 15:22:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, j.vosburgh@gmail.com,
	andy@greyhouse.net, weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next,v3] bonding: use WARN_ON instead of BUG in
 alb_upper_dev_walk
Message-ID: <ZVTUL4QByIyGyfDP@nanopsycho>
References: <20231115115537.420374-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115115537.420374-1-shaozhengchao@huawei.com>

Wed, Nov 15, 2023 at 12:55:37PM CET, shaozhengchao@huawei.com wrote:
>If failed to allocate "tags" or could not find the final upper device from
>start_dev's upper list in bond_verify_device_path(), only the loopback
>detection of the current upper device should be affected, and the system is
>no need to be panic.
>
>Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>---
>v3: return -ENOMEM instead of zero to stop walk
>v2: use WARN_ON_ONCE instead of WARN_ON

Yet the WARN_ON is back :O


>---
> drivers/net/bonding/bond_alb.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>index dc2c7b979656..21f1cb8e453b 100644
>--- a/drivers/net/bonding/bond_alb.c
>+++ b/drivers/net/bonding/bond_alb.c
>@@ -984,8 +984,10 @@ static int alb_upper_dev_walk(struct net_device *upper,
> 	 */
> 	if (netif_is_macvlan(upper) && !strict_match) {
> 		tags = bond_verify_device_path(bond->dev, upper, 0);
>-		if (IS_ERR_OR_NULL(tags))
>-			BUG();
>+		if (IS_ERR_OR_NULL(tags)) {
>+			WARN_ON(1);
>+			return -ENOMEM;
>+		}
> 		alb_send_lp_vid(slave, upper->dev_addr,
> 				tags[0].vlan_proto, tags[0].vlan_id);
> 		kfree(tags);
>-- 
>2.34.1
>
>


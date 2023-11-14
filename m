Return-Path: <netdev+bounces-47810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6722F7EB6F7
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E162812F9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B526AD1;
	Tue, 14 Nov 2023 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="My11lB/0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0326AC2
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 19:40:48 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C40107
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 11:40:46 -0800 (PST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AB47A409DE
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 19:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1699990844;
	bh=eyp5x8KtzWTBwW4/eJM36wtrZEyZoVQtQbaW/z0Dwiw=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=My11lB/0K5JjnDX2sVJXCpg1x7sNz5R9QbN9aq4U4BEA+DfkZc4jCAreY1zqc+XZ4
	 AUK1hj+BjVQxHfhy0vDEQYKKadKlgENBwYowIdre1jlATk/TG6v/Sxknm9lBs7ptxf
	 fodqFc50bnmJMA62s8eEEpk/PYepmMVCTo59HhMVgMPPF5N36E4Dh3AA1qBCIt7R0+
	 opIMxKgA8KQO8nojS/l+p+kSWAPr2TH+1obGLooYiqLtkct1gUlge2nCR5m9huKYaV
	 lLjKmqcNVKkHT4LNIv/T3EI54RfRyuBjNm2Hk8XLgaY/o70nGN1rXwtemjE+Y8rke+
	 Jo2ppO4XWK1rw==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6c415e09b1bso6116682b3a.0
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 11:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699990843; x=1700595643;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyp5x8KtzWTBwW4/eJM36wtrZEyZoVQtQbaW/z0Dwiw=;
        b=DCUHN6Sn9XrZmxDLvk1TWfFdtd9GUgD4u50smoiOEkjsF79Xg+vkGQULQG1/cg2Yph
         CMCob14HF2YXG4Fn0yY9DOjwrJ8qUGyiEyTBIzqHEDk+YQWZLuYZ/A158IZUNEW/ZPZa
         XezKSXlzSNqcnqL3CvaVBCdBLeBI3LsqKb1Fcd3tL9gXcY4q9JNT38rA2uBx9S5mwXjy
         o/BVKDpqjuWvAYIATX90yOW3/cWSZL3SO3jGgS/AQ+zqwr3Te7+bj537NdFIylO32/0W
         jQRZUuW+QteTAaAkkhZCWOVF7U4Lmjag7mcZnjmHSwFxO26+kHczMlo8dXP1csTVfN1h
         qI4g==
X-Gm-Message-State: AOJu0YyzmBFs39eZgHa1LPx7f6YmkPGZ/korkkyT3qNMGR5mhchZctpU
	6lMgJk4vqOw9uV0dMtyNdE4cKCxrWuI7Ga9vpDgHSDHCiJZZd9KooYon6TjzLW41h9xFtMJXY7y
	yO6WQhwxILuudcTitAY0ZtsgXvz7S+HDqeA==
X-Received: by 2002:a05:6a00:1c89:b0:6b2:baa0:6d4c with SMTP id y9-20020a056a001c8900b006b2baa06d4cmr9385618pfw.33.1699990843237;
        Tue, 14 Nov 2023 11:40:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF11Oi0pV4ZqSP5aPkPJp43QWimAMMA8p2xe90v2kx8D5kKkt1NJcvU824qPxJ+3ZvP/unSsg==
X-Received: by 2002:a05:6a00:1c89:b0:6b2:baa0:6d4c with SMTP id y9-20020a056a001c8900b006b2baa06d4cmr9385601pfw.33.1699990842941;
        Tue, 14 Nov 2023 11:40:42 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id t38-20020aa78fa6000000b006bfb9575c53sm1516035pfs.180.2023.11.14.11.40.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2023 11:40:42 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 330D45FFF6; Tue, 14 Nov 2023 11:40:42 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 2C1A99F88E;
	Tue, 14 Nov 2023 11:40:42 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, andy@greyhouse.net,
    weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next,v2] bonding: use WARN_ON_ONCE instead of BUG in alb_upper_dev_walk
In-reply-to: <20231114091829.2509952-1-shaozhengchao@huawei.com>
References: <20231114091829.2509952-1-shaozhengchao@huawei.com>
Comments: In-reply-to Zhengchao Shao <shaozhengchao@huawei.com>
   message dated "Tue, 14 Nov 2023 17:18:29 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20959.1699990842.1@famine>
Date: Tue, 14 Nov 2023 11:40:42 -0800
Message-ID: <20960.1699990842@famine>

Zhengchao Shao <shaozhengchao@huawei.com> wrote:

>If failed to allocate "tags" or could not find the final upper device from
>start_dev's upper list in bond_verify_device_path(), only the loopback
>detection of the current upper device should be affected, and the system is
>no need to be panic.
>Using WARN_ON_ONCE here is to avoid spamming the log if there's a lot of
>macvlans above the bond.
>
>Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>---
>v2: use WARN_ON_ONCE instead of WARN_ON
>---
> drivers/net/bonding/bond_alb.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>index dc2c7b979656..a7bad0fff8cb 100644
>--- a/drivers/net/bonding/bond_alb.c
>+++ b/drivers/net/bonding/bond_alb.c
>@@ -984,8 +984,10 @@ static int alb_upper_dev_walk(struct net_device *upper,
> 	 */
> 	if (netif_is_macvlan(upper) && !strict_match) {
> 		tags = bond_verify_device_path(bond->dev, upper, 0);
>-		if (IS_ERR_OR_NULL(tags))
>-			BUG();
>+		if (IS_ERR_OR_NULL(tags)) {
>+			WARN_ON_ONCE(1);
>+			return 0;

	Ok, I know this is what I said, but on reflection, I think this
should really return non-zero to terminate the device walk.  

	-J


>+		}
> 		alb_send_lp_vid(slave, upper->dev_addr,
> 				tags[0].vlan_proto, tags[0].vlan_id);
> 		kfree(tags);
>-- 
>2.34.1

---
	-Jay Vosburgh, jay.vosburgh@canonical.com


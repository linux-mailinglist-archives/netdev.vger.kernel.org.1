Return-Path: <netdev+bounces-17637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE037527AE
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277CA1C2112B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C051F167;
	Thu, 13 Jul 2023 15:49:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C941F163
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:49:23 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82014213F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:49:21 -0700 (PDT)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BF94F3F71D
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1689263358;
	bh=n3uwF+PhF/LCrAwLUh31M26n0RcXjtVO0HNToCDrTPg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=YKuAHsThL4+04QRzLXeYSSBXOhOTQtZFOMxPYbWq1Uu2zovF68ku3MF9pZXouemUE
	 TZLYndSQpQN3PeY8vyqB2b6YvywChkArZqYx9AHsXGQIUBtYAMeAvbpEZs5+YjQRfS
	 ZQpN2BdYDdQeuaPoNlyHkk2HdOwl+kmj5B+akH9yiXuIjoxqJE1SH9dpMBP5xRDGSK
	 hN58WHYduKTYzW+jQVSoALrXAysrxwOMRNWsu7bPcLBf4dO0beklZANJvZ201fXAuH
	 LVVBRaiJv3ECsfk/Q1Ox+kZLFZIwf7xTYOJLyuifyhXvYkrXOSnXs4ke5sWbVCCWAe
	 KCRAuZTnzfCXw==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-55b1a2f51edso469827a12.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689263356; x=1691855356;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3uwF+PhF/LCrAwLUh31M26n0RcXjtVO0HNToCDrTPg=;
        b=GDcpL4Y78kaRuwaqbNqSlgjUm01ZmOO+6z8dp/y1teHiyk6fKwpsWyq//BWKzCPUL2
         ruAbEenCouNSEBmM961+1/B9yjaqyLGHG8bBr0VU7ljfjEaoWDnCfq+FS5SdA6pxRL5b
         N5brLCdw/+N62Hpo9uuDXss7ToLaKCinNxn8EQ6kJY6BQbTq7P0QpjmfTePXRQM555CK
         oXqofVUBGLMceWEXFeNUCVm8jTsvT9HN+INvX68SDz7U5IGYFqkK5NZw6UrNI1n1dKdf
         wyvqNC2WB/mXSS6Gte8qGDvaObJIjFTrCqNwbjJ/TOcXCPkrZHXqPB1GEL4kGowPh0WW
         0BcQ==
X-Gm-Message-State: ABy/qLYQMEyJwyqa19NU+PJ7njnGNYQtRQD75GgntGlfH5+dP9N4ue12
	M4ZB0TDYtbgUkvEe2MI2/YN7IVbqrE2Umu8syVsS5RbkeNNu0HeGQe6wUHKuYN8na3vwi6txZNQ
	yLgHxaBgbq2I9UOwZwlY+vnIE0eD3066KqQ==
X-Received: by 2002:a05:6a20:4421:b0:131:dd92:4805 with SMTP id ce33-20020a056a20442100b00131dd924805mr1723891pzb.57.1689263356360;
        Thu, 13 Jul 2023 08:49:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHekTUfrweh/EaRRcrm+KOYQucCEEY8g7tbjF9pWZHmVZklspjSNv/1FrXl4lZg9vwDv9ClSQ==
X-Received: by 2002:a05:6a20:4421:b0:131:dd92:4805 with SMTP id ce33-20020a056a20442100b00131dd924805mr1723861pzb.57.1689263356000;
        Thu, 13 Jul 2023 08:49:16 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b00682b15d509csm5550440pfn.194.2023.07.13.08.49.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2023 08:49:15 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 3100E5FEAC; Thu, 13 Jul 2023 08:49:15 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 29F6D9FABB;
	Thu, 13 Jul 2023 08:49:15 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Wang Ming <machel@vivo.com>
cc: Andy Gospodarek <andy@greyhouse.net>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Yufeng Mo <moyufeng@huawei.com>,
    Guangbin Huang <huangguangbin2@huawei.com>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net v1] net:bonding:Fix error checking for debugfs_create_dir()
In-reply-to: <20230713033607.12804-1-machel@vivo.com>
References: <20230713033607.12804-1-machel@vivo.com>
Comments: In-reply-to Wang Ming <machel@vivo.com>
   message dated "Thu, 13 Jul 2023 11:35:54 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24869.1689263355.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Jul 2023 08:49:15 -0700
Message-ID: <24870.1689263355@famine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wang Ming <machel@vivo.com> wrote:

>The debugfs_create_dir() function returns error pointers,
>it never returns NULL. Most incorrect error checks were fixed,
>but the one in bond_create_debugfs() was forgotten.
>
>Fix the remaining error check.
>
>Signed-off-by: Wang Ming <machel@vivo.com>

	Seems fine to me; note that almost nobody uses this as bonding
debugfs is hidden behind !CONFIG_NET_NS.

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

	-J

>Fixes: 52333512701b ("net: bonding: remove unnecessary braces")
>---
> drivers/net/bonding/bond_debugfs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bon=
d_debugfs.c
>index 594094526648..d4a82f276e87 100644
>--- a/drivers/net/bonding/bond_debugfs.c
>+++ b/drivers/net/bonding/bond_debugfs.c
>@@ -88,7 +88,7 @@ void bond_create_debugfs(void)
> {
> 	bonding_debug_root =3D debugfs_create_dir("bonding", NULL);
> =

>-	if (!bonding_debug_root)
>+	if (IS_ERR(bonding_debug_root))
> 		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
> }
> =

>-- =

>2.25.1
>
>


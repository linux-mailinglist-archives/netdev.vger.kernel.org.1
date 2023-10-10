Return-Path: <netdev+bounces-39640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E262C7C03AB
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F901C209A0
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D484E27EFE;
	Tue, 10 Oct 2023 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NNCO4udD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718C028F0
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:45:57 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A1CCC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:45:52 -0700 (PDT)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8543240340
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1696963549;
	bh=7uDgO5gLDihj+WxpSHFmStz2b0y1W/29TrdvVYIjZHc=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=NNCO4udDyQV4oguOSxpLlknNO9Fft68u0/gPz4wjR9+vGctynToYg+CkITonTTPde
	 pmc8yUpwnnvJSQnh3y1VUTwdSeOO7Ge+TAcuycdAn+vJJ66hSjwEmKRG80A3Hf9obi
	 L8Xa+hMfNHlZEoqb75Vmy8CZu+1vI/1yfFuD6slNVnEixTGcV1E2SIE3qITrH4RHL3
	 L6kzZy9AKjk/3XLRiLt5JGUmhq9A1ItuDfHgnT/gR3qAJb1b5SrnBS5JtPgosysMP/
	 R/Kln5YxLbAcPAl+3fhiPVvQ63/pYWkfju8ryPhoh6zFlveV4W61L7rAn+5HMuHVFH
	 SG5chyfhInYQQ==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3af7219c67fso10160234b6e.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963548; x=1697568348;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uDgO5gLDihj+WxpSHFmStz2b0y1W/29TrdvVYIjZHc=;
        b=TR65bgy6q5Gp0GZIZ2jI1nJyRKHH73LkZuE/3ZwphKxbt0BVKOqEiJ9zWtUt+twWuh
         ofHBENkdN1nc7g1F9my/ezXidw3vdH55GEMMsI7v7gENRHlb9/0Pca/ulU92yF9HRPyT
         9ah0itRlnV+ZgdwDYoVl4v7EZzycp3wlFKRfFOkn2C4MofUWcfbsldkwctyQYp4dVw00
         Y5Bs0UeS0SSxjvpo6xNsWUbedCyelayqNy0lN/b1E+lkk8NHk8GwJNkbvibg4Yuz4J2E
         h42eLoRi1OYSIiT4ytnblwZcpNYlbdYO6aoEU85ftX4xVOIY4FH8Q0M7cBHSRp3bljEt
         flyw==
X-Gm-Message-State: AOJu0Yy+O0Q4ZN9yNIAz34KQeR3+LC/z82mpXVLvNqMZVk3yQdiHcNA0
	730O/G+5GeYbD8Ihl638B4Nyeh6eCIwm43qR3I9kM7lHHRz9Zj3exMs0ZlJj4SMISny8weaZ9Yi
	aXvlvQTq9HOBo+X330dMXCD7vR/lpogOMIQ==
X-Received: by 2002:a05:6358:7e49:b0:134:e603:116e with SMTP id p9-20020a0563587e4900b00134e603116emr20013325rwm.6.1696963548324;
        Tue, 10 Oct 2023 11:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjpNZ7blessvYhs7nFaC4OlurVYE3fXOaJJtq+yUNgQ6QRF2m9XVA3nbm7GdpGeukR97FqfA==
X-Received: by 2002:a05:6358:7e49:b0:134:e603:116e with SMTP id p9-20020a0563587e4900b00134e603116emr20013303rwm.6.1696963547998;
        Tue, 10 Oct 2023 11:45:47 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id gd11-20020a17090b0fcb00b00274e610dbdasm12678976pjb.8.2023.10.10.11.45.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2023 11:45:47 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 23BCF5FECD; Tue, 10 Oct 2023 11:45:47 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 1C6339FA77;
	Tue, 10 Oct 2023 11:45:47 -0700 (PDT)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Jiri Wiesner <jwiesner@suse.de>
cc: netdev@vger.kernel.org, Moshe Tal <moshet@nvidia.com>,
    Jussi Maki <joamaki@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
    "David
 S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] bonding: Return pointer to data after pull on skb
In-reply-to: <20231010163933.GA534@incl>
References: <20231010163933.GA534@incl>
Comments: In-reply-to Jiri Wiesner <jwiesner@suse.de>
   message dated "Tue, 10 Oct 2023 18:39:33 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28782.1696963547.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Oct 2023 11:45:47 -0700
Message-ID: <28783.1696963547@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jiri Wiesner <jwiesner@suse.de> wrote:

>Since 429e3d123d9a ("bonding: Fix extraction of ports from the packet
>headers"), header offsets used to compute a hash in bond_xmit_hash() are
>relative to skb->data and not skb->head. If the tail of the header buffer
>of an skb really needs to be advanced and the operation is successful, th=
e
>pointer to the data must be returned (and not a pointer to the head of th=
e
>buffer).

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

>Fixes: 429e3d123d9a ("bonding: Fix extraction of ports from the packet he=
aders")
>Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
>---
> drivers/net/bonding/bond_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
>index ed7212e61c54..51d47eda1c87 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -4023,7 +4023,7 @@ static inline const void *bond_pull_data(struct sk_=
buff *skb,
> 	if (likely(n <=3D hlen))
> 		return data;
> 	else if (skb && likely(pskb_may_pull(skb, n)))
>-		return skb->head;
>+		return skb->data;
> =

> 	return NULL;
> }
>-- =

>2.35.3
>
>
>-- =

>Jiri Wiesner
>SUSE Labs
>


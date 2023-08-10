Return-Path: <netdev+bounces-26232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D227773CD
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91301C214AD
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 09:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7DD1E523;
	Thu, 10 Aug 2023 09:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918F53C3C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:10:26 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4512691
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:10:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so5505535e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691658622; x=1692263422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAcEDNRrH6pEHCwBfOU/n6m16S2gtqtCXBzBAjs/thg=;
        b=yD607BcaPCJRMrxD5iLhD4zMyo16zEC+7+rIREbRnv5yImF70B0Vx1hfJ9l0/kLn3Y
         DyvMYR9Y+WTEj6Vg9+o9OMjXzMgmeAPf+trmHhMWTvuWYTUm4C/VsfuwOrZpMfCNlBz8
         kJ4mjcoa125gTf6w1TtZm/JbDhe/0aK/KpskUJ0DagtN4ktcgmEQaSr7vdTyo5A5hOpI
         N6r/c2evunmXtA+Og60zUbsz3wN1PZozszwwR+9wC7tkvqFeAcHeTV/M1X4j7L5pdeFf
         tYy2tvnrb5OuAhG/7+DJ8g4ARq1EccWK/j3vRNZ6clP9zJGvurp2xUzr/qan4uQGPtmS
         atbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658622; x=1692263422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAcEDNRrH6pEHCwBfOU/n6m16S2gtqtCXBzBAjs/thg=;
        b=cL+PakkR/a0alol3llphzgjTiZP9XhmwtIKd7iZ1uO0VO/WMHMO0HwN02N1c5e3M5D
         puaL80H0hT9akoTsWe26/zf+/kt8Y3/1H5uaVyNshMpLaest2z+TmZ+aXU9oCTu50hDg
         cVMIihs+Pv6H40Tm262Fczmri3fb84Lh9FFIydUhtNdh0HRJykwKNR8rke1H4geZg7QL
         r+xlZ/L/syWLCnv0EATtxj6hazZMjFElLlv3d5DzpKnc1VryLw+mfZO0/qkhNJ1ye3e2
         V/M5i08bQtU5hZA+ze7eYNCkgslruUx92bfpndXafTMZl8q5zeSHlzAeG20lD2k7Zsji
         EA/g==
X-Gm-Message-State: AOJu0YwRISNNREL0JeNCnKE3eXRAvy55dfzIseEbmbKJn3p1o4M3/DfS
	I8JUOShiYSSl91d6POBarfMiLA==
X-Google-Smtp-Source: AGHT+IGxYhJAnKHDxJkWDvXemX7+i6lJpCaE9yJwjIfyTlkE2nHcjgWINtfDkmUL15f0C39X002oPQ==
X-Received: by 2002:a05:6000:1111:b0:317:dcd5:afbf with SMTP id z17-20020a056000111100b00317dcd5afbfmr1542219wrw.23.1691658622607;
        Thu, 10 Aug 2023 02:10:22 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id f14-20020adffcce000000b00317a04131c5sm1490080wrs.57.2023.08.10.02.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:10:22 -0700 (PDT)
Date: Thu, 10 Aug 2023 11:10:21 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net, lorenzo@kernel.org
Subject: Re: [PATCH net-next 08/10] netdev-genl: use struct genl_info for
 reply construction
Message-ID: <ZNSpfeVRb/I4RmUd@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-9-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-9-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Aug 09, 2023 at 08:26:46PM CEST, kuba@kernel.org wrote:

[...]

>@@ -41,6 +41,7 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
> static void
> netdev_genl_dev_notify(struct net_device *netdev, int cmd)
> {
>+	GENL_INFO_NTF(info, &netdev_nl_family, cmd);

These macros declaring and defining struct on stack always introduce
some level of obfuscation to the code. Again, as I suggested in the
reply to the previous patch, would it be nicer to have initializer
helper instead? Something like:

	struct genl_info info;

	genl_info_nft(&info, &netdev_nl_family, cmd);


> 	struct sk_buff *ntf;
> 
> 	if (!genl_has_listeners(&netdev_nl_family, dev_net(netdev),
>@@ -51,7 +52,7 @@ netdev_genl_dev_notify(struct net_device *netdev, int cmd)
> 	if (!ntf)
> 		return;
> 
>-	if (netdev_nl_dev_fill(netdev, ntf, 0, 0, 0, cmd)) {
>+	if (netdev_nl_dev_fill(netdev, ntf, &info)) {
> 		nlmsg_free(ntf);
> 		return;
> 	}

[...]


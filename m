Return-Path: <netdev+bounces-29695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED35784601
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8391C209EE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232B31DA4E;
	Tue, 22 Aug 2023 15:43:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166CC1DA3A
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:43:52 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB2BCC1
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:43:51 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a7d7df4e67so3209710b6e.1
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692719031; x=1693323831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajclIQzbFdLlcdP9DjU7hg1vGqAEUCYg70OjfFGvT24=;
        b=JxGERZVkKqQ2Bmy744D9Ru33N1TutZgya1ICAPiWiy1+kZu9uIq/45eAhuI588k3Q9
         3WYvWs/v2mL26UOfAWP28lWs/9r2cbjttb+HT8ciqwZuv3RUe418lst3bn6jcVELlfUd
         nsybwzla2xh9crYQE8O/PszyoyUPv0nB43NFloLjnP8AGHKLAzi7TbmgIzWPOb+vlilT
         H8BoGwMLJNxiHNuS9/55811fl383GiSGA22YqrjNWgCQwRNt5gd37kYpgtBDlV5FoaHA
         driPC268eqJrAeYt9Zfe2X00/PNwSeTMAVG5AZA7doKCH+p2d8W04kuT1zA0YDZ0jo2i
         wRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692719031; x=1693323831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajclIQzbFdLlcdP9DjU7hg1vGqAEUCYg70OjfFGvT24=;
        b=GzxsjhohRkeZ6IhNm3uAOnwwx9fkIRLIj8a8kr8M8DSI7PhsRHgd1zgz8J5wBdTBiN
         ya38SDjCzaIhNKd5sX474imLgO8yd88clZ1VeKjH2SGIZQGb1K8Q7IoPQpQvrEQHIc9S
         K7dlu+NalVphRXVsOfWbD414V9S05+/0MSri+oWUsXJ3mGB23+YCEpG37BrTlA1w1blU
         H4hHU9tbJXJp0tU1uUolSbN2EqkFxwvxHLk/U4gpsew/Z8kYenySHp5HuxDuW83sK2iS
         iFqCyAVdNY81OfxDbRyr2+BSKpNHQ9mTwcs+wWi5p/dj2eQA3m6/iGZ/yMry11s5v7qH
         pLHA==
X-Gm-Message-State: AOJu0Yw5CaZEwvotOgztsVVGdMA+sJ7rI6x54QrgzZ3HG+wco632g++T
	WVdTvTmjMT6h07Av7gHO6SovTaE1vRXq7XVjo/N92g==
X-Google-Smtp-Source: AGHT+IGIbCz2EPzaat+n3tE+k02t5ph3R+v0j1IIsyrO1oNkN6ryEVeGqp0m4ienBAy8vKeH+Tn8Ow==
X-Received: by 2002:a05:6808:492:b0:3a3:7a28:f841 with SMTP id z18-20020a056808049200b003a37a28f841mr10613242oid.41.1692719030872;
        Tue, 22 Aug 2023 08:43:50 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id m65-20020a633f44000000b0056601f864aesm8171583pga.2.2023.08.22.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:43:50 -0700 (PDT)
Date: Tue, 22 Aug 2023 08:43:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: francois.michel@uclouvain.be
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next 1/2] tc: support the netem seed parameter
 for loss and corruption events
Message-ID: <20230822084348.48ebc808@hermes.local>
In-Reply-To: <20230822140417.44504-2-francois.michel@uclouvain.be>
References: <20230822140417.44504-1-francois.michel@uclouvain.be>
	<20230822140417.44504-2-francois.michel@uclouvain.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 22 Aug 2023 16:04:02 +0200
francois.michel@uclouvain.be wrote:

> +	if (seed_present)
> +		print_u64(PRINT_ANY, "seed", " seed %llu", seed);
> +

Since seed is after slot in the manual, you might want to put
it after slot in the output.


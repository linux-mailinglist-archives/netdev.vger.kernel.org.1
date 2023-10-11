Return-Path: <netdev+bounces-40033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67677C57B3
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615632823C0
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06CC200BB;
	Wed, 11 Oct 2023 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Wa/rr+qY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7DF1F5E1
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:04:20 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E2AA7
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 08:04:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3226b8de467so6492018f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697036655; x=1697641455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRkqB8/peQlqSu9v9E/Jxgpb5iu6r7QHy0PIjTwaP3U=;
        b=Wa/rr+qYC8sSKEtftymBPnBFWOwtAUwirmBF/93mEazjvXl182v0aK/83guW5UIg+3
         LvIf0WO9xMZYUcWGqndZvFQyNv3fquN1seN1VZvwOeirw4vPCD7MDh12zjxaLqd9ffQv
         hN1748m3vSN+fdR/RdIdpJuTpkvGYFb9zcEzQ5yh1s3quTAsF0YbklAEQZED/94QYLTb
         0m6DI96wUlDwZ3MAWvcoUhHkTMbZKej9YJLJIma7++uCinn0aA865VUb8loQQtr96Ots
         AcZBjmyijGPOuiqDGYB6aF/oV5RpLoPrOd+J8FCLK/Bwwq6otnAV9CeslfrBz0WZAJ9C
         DpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697036655; x=1697641455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRkqB8/peQlqSu9v9E/Jxgpb5iu6r7QHy0PIjTwaP3U=;
        b=FK7nE16KnMo9vcr0TKbWHzRqlSOZeZC848dKrl4gJYswNG4iGNvqrVBrmeT7DxHa/y
         BPBIM4beO7sxqT+i8MkV2OFOWVcH629MAbBl74Edv2PjE4n0no2IG52DPUkQ2ZqNkJuf
         mgDGane6mkeE2vQQxeauDNANNLjYTjZHWQhIXcnRhjCeLUoUBF5CWCBp823s4EIVKoOP
         gZs36flTVlV41eMUmPqzWUUsgestmcAgoOBwjHEiFyYhX27L4Pi8uwm3klQz3phNMGC1
         KkENm/ys7qhtZt6gS6SMBKssxVoteZrnObSOaVFLuJtntni98LHeiARyKGgUedMCvlJE
         V0Tw==
X-Gm-Message-State: AOJu0YygX3KngFm2xEJQ/30UdRwT/LaRn8zThjC3IOMCtWjEX9rOJTMe
	IYnKKYR5eSmOGih9Oo2C+lF0bg==
X-Google-Smtp-Source: AGHT+IFfZQ1SiRV7geQ0Uqaa1luLtMmhs2/HZDlMTol8OQRTChK4x+uxynd3PWFf8uF8nkr/44Pylg==
X-Received: by 2002:a5d:548f:0:b0:31d:d48f:12a3 with SMTP id h15-20020a5d548f000000b0031dd48f12a3mr16620164wrv.43.1697036655189;
        Wed, 11 Oct 2023 08:04:15 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d50cb000000b00325c7295450sm15782616wrt.3.2023.10.11.08.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:04:14 -0700 (PDT)
Date: Wed, 11 Oct 2023 17:04:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wpan@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Rodolfo Zitellini <rwz@xhero.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 01/10] appletalk: make localtalk and ppp support
 conditional
Message-ID: <ZSa5bIcISlvW3zo5@nanopsycho>
References: <20231011140225.253106-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011140225.253106-1-arnd@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Could you provide a cover letter for the set please?


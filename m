Return-Path: <netdev+bounces-42962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E8C7D0CF4
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577AA282455
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F08F15E9A;
	Fri, 20 Oct 2023 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HzL6FMIm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8F1640F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:15:14 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273FDB6
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:15:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9be3b66f254so94634366b.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697796906; x=1698401706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cHY0jaF10Yx/Se+7J24DgyevrpF28GDqLCzUygdCLno=;
        b=HzL6FMImGrxrAXAccmfdirSX3HoStKhAfUF2hgvtf1hOIQ4AjgOTBkvh7b3m63ZRB9
         kmXR0N3E/yM/hxyPAt6V1xW5G5Vn9gt3BOzjjbxL9IlV3vUPZgGDGwp9kBhGmtdP9YVS
         cgLEjqsqHbVhwi5IjetQ5NkW8rgeN2iBtoLSFWkTU/zHVQJqHc1yfulIOcH36QaTJZe1
         D5iVzys/RDDw5yOBYGjo2cFHt8legZb8BLWyXqX2AsmU4Crv5F/RMeGq4Ig3yhcCTBbp
         qt+zTan3OlLs1/FwUltPDZSLQfkhs+ZcIbu+We0kkq+x/GxPGBmCdQ2hSvLL775DKXoZ
         Gmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697796906; x=1698401706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHY0jaF10Yx/Se+7J24DgyevrpF28GDqLCzUygdCLno=;
        b=frVcqbp7mWINv7P1v0+3PLByt3jLPr6FU5moKiPKnpZp0VaiTtRq6K9B/zgV/RooHk
         EwnxIZa3CiXr3H9qzirA1uzUsVRytnNylvh31lJxyMRTeSvNT++V0lC/3sBkAbHp5TG8
         D61Yd09XhpNzuTRw+6lEtmN0MkipQqPVJv5MkW9LnirZKCvAkOp62Y91sDPA4HcWRw6m
         9otnK2yd5BkJG8znIx+WoJIDEgdkOtZqVlOk2W9y51qwEqrPqJsdqatqZofv9EODlNJ7
         t+SF5QxvsEGPROdCaYlPKH4FcpPW9AqHtLlKwev9ri4o8OGtMie+e9DNKcuZNN8ZkSaF
         89CA==
X-Gm-Message-State: AOJu0YyECH154L3oZb3jIC+d5YkG2wvdGQrekCeHHg6APqPPrLr62mdW
	upgNs35q8DpVqSQ+fbducNywGA==
X-Google-Smtp-Source: AGHT+IG8qb3AKfSrliLJe3NBKz+HAyDGXBjW4XRbEmumOt1WLbfyhxldHURkqCzPEcmbzC29EHidTw==
X-Received: by 2002:a17:907:7b99:b0:9c4:6893:ccc5 with SMTP id ne25-20020a1709077b9900b009c46893ccc5mr907702ejc.57.1697796906493;
        Fri, 20 Oct 2023 03:15:06 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id pw17-20020a17090720b100b009bd9ac83a9fsm1164551ejb.152.2023.10.20.03.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:15:05 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:15:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes.berg@intel.com, mpe@ellerman.id.au,
	j@w1.fi
Subject: Re: [PATCH net-next 1/6] net: don't use input buffer of
 __dev_alloc_name() as a scratch space
Message-ID: <ZTJTKN5wzf4lWRfk@nanopsycho>
References: <20231020011856.3244410-1-kuba@kernel.org>
 <20231020011856.3244410-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020011856.3244410-2-kuba@kernel.org>

Fri, Oct 20, 2023 at 03:18:51AM CEST, kuba@kernel.org wrote:
>Callers of __dev_alloc_name() want to pass dev->name as
>the output buffer. Make __dev_alloc_name() not clobber
>that buffer on failure, and remove the workarounds
>in callers.
>
>dev_alloc_name_ns() is now completely unnecessary.
>
>The extra strscpy() added here will be gone by the end
>of the patch series.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


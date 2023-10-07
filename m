Return-Path: <netdev+bounces-38771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20467BC6AF
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 12:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F201C20945
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033D1803B;
	Sat,  7 Oct 2023 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TqjR/rQm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89317EC
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 10:17:37 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A23DB
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 03:17:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533df112914so4985475a12.0
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696673854; x=1697278654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmwqVJFJZhYX1nwNiKAJDjZmEjH8n5HDdTZtNatfmcI=;
        b=TqjR/rQm9YVLglf3IkWcS4u6IxHi7ojozK9vKuHEM01QmT5rjoRTkFOkKFJsoLb8xN
         X0uE1bDZ3K/pRKMNVUBM+BWx5RMqDC911OULm5sedpwrmHdEjcO+4M88zLYkgV6WLl0F
         XBJGxbS5SHvAofY81aysaUuesWoGin5jLFN8GntRSx4zVYeluKmXVXAllaVB/gkzwzz6
         YdGYzzCDHBt5kjL7F+Wcx8Pg5kEozlWf4AKetsMH4jYPGsQx2FWL8sii3mGqakb8eDzI
         juqyIYod1EEibYitP8SOWGof8PMz1u1CRvfhwbd7nsj1D1BUjNRxlnHOVxGncyvYU0sf
         AXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696673854; x=1697278654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmwqVJFJZhYX1nwNiKAJDjZmEjH8n5HDdTZtNatfmcI=;
        b=PLr8bCSl5T1SSuijnrW5oSTFuaU5iFthg6+OmzUVjTODPU15GmJIr/Qy17BMGNSwAk
         vcGvqfTB5dRkGmw+juUCC5OMUWOd8z+vT8PzLmvUpQVnMhM+sidynERExAM1LI7pY6PL
         cXuuOBznkcvWSKFWiQHGdciBTaxIA3y96ERRIoPFPk/Z3J8I61aaj8doXv1vjVlHfqIZ
         E4aAt/1QOw0Tlo9aeooLESAzSpeyAX94qvIKyJH4kCw8KMCpnWzzjB6Iuu39uFZQgttr
         yeJstZmFuu4nckvK6va0M/vEZZjpIsLapnSQzS6KzyM6WZvKJBVA/MriUL1YijgJPusZ
         rvdw==
X-Gm-Message-State: AOJu0YxQi2BWay1dyuuNTSKnW/DsdFo3eW/hI0nWBKm4c49qSIgL+g3p
	5eNVaAB+dtYIuEzF4wKf5CBBCw==
X-Google-Smtp-Source: AGHT+IG/g6iz+W4hv6c9f0KfGLlhlzulMdgK8+UNv4VFkae+A/lzrPDaq5m5nQ/EbZTMBeXIIlWU+g==
X-Received: by 2002:a17:907:75f4:b0:9ae:6d0:84ec with SMTP id jz20-20020a17090775f400b009ae06d084ecmr8981249ejc.25.1696673853620;
        Sat, 07 Oct 2023 03:17:33 -0700 (PDT)
Received: from localhost ([91.218.191.82])
        by smtp.gmail.com with ESMTPSA id w10-20020a056402128a00b0053404772535sm3713321edv.81.2023.10.07.03.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 03:17:32 -0700 (PDT)
Date: Sat, 7 Oct 2023 12:17:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <ZSEwO+1pLuV6F6K/@nanopsycho>
References: <20231003074349.1435667-1-jiri@resnulli.us>
 <20231005183029.32987349@kernel.org>
 <ZR+1mc/BEDjNQy9A@nanopsycho>
 <20231006074842.4908ead4@kernel.org>
 <ZSA+1qA6gNVOKP67@nanopsycho>
 <20231006151446.491b5965@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006151446.491b5965@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sat, Oct 07, 2023 at 12:14:46AM CEST, kuba@kernel.org wrote:
>On Fri, 6 Oct 2023 19:07:34 +0200 Jiri Pirko wrote:
>> >The user creates a port on an instance A, which spawns instance B.
>> >Instance A links instance B to itself.
>> >Instance A cannot disappear before instance B disappears.  
>> 
>> It can. mlx5 port sf removal is very nice example of that. It just tells
>> the FW to remove the sf and returns. The actual SF removal is spawned
>> after that when processing FW events.
>
>Isn't the PF driver processing the "FW events"? A is PF here, and B 
>is SF, are you saying that the PF devlink instance can be completely
>removed (not just unregistered, freed) before the SF instance is
>unregistered?

Kernel-wise, yes. The FW probably holds necessary resource until SF goes
away.


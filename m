Return-Path: <netdev+bounces-26637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD48C77879D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D0F1C2110F
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 06:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DE81117;
	Fri, 11 Aug 2023 06:44:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40DED7
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:44:49 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DFD2D41
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:44:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c0cb7285fso222742266b.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691736287; x=1692341087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj650+DsbNJrA/db0zIIgoZRW2ScMigpcxxWUFpmuOs=;
        b=tnVPKXDGJ7yseYASgfRwfc4KKS/OrBH1/WS+crLTqhbeLIGNrJ6F4dSTnjt8WJsads
         jvuELkMW20ItTwjjiZRDDNq31EP9yLtO5v6CsAtORVusQNZo8FeJocYfByW4LqYqGBPH
         yR6aI6iUTg59W6hTZcUSwtBze7efMaE5RNe4fTMRIYaqyOoexoYEIcyYdAW3VnUwgHhV
         Gvm6gFjmtb78GA7sUDSJ4aXKwNPFJmuM9vb6rO8Yd02YL5czjgA+feMo1lkQYm9SJ6XV
         +gfogMMfqDpSjOFpDoahfHEGFcjBFjtDAHpcyEZQ0mppgmSCHlS+lSXeb+LOGuP0E/Pv
         lovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691736287; x=1692341087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj650+DsbNJrA/db0zIIgoZRW2ScMigpcxxWUFpmuOs=;
        b=djGoB6KgS0FE+44VCKtaEXWngy8FKqp8LPNvFiftqCfKnMOiq5jz2YcQ2DvNqOYz+q
         tZHk0BJQWJkDEjbuXylPtJqhdW2nN3VP+9BSfhW+p6tUMdGkeeaGvVGtZk5duPEX3Ofo
         dgi/dhODCttZ7wyCEI7zJLbj0E+ok8UUUF203ZMv8t6j8cWDCe0Cm4mK2N0fxkGYHoI8
         0OgFsFVzYtv7TH2SjNb3URZH0E7jWkOWkrIOCByutqPiXYVRFtFQyHfnlF1zxE9bgGto
         3nHkig1Xj5IIDlA9/7cVWGQYomHMYqnmlBiMPg+SyQSIqhjpiGNTIVdQjF8NvdAZhkya
         S+eg==
X-Gm-Message-State: AOJu0YxJmMhcxwe7cMf5Np9ldYxV3ZcYZfES1wUs0WvSw4R6Nst/ZG/+
	UwkSvgn7FNac/UWpzwvwv8RWcg==
X-Google-Smtp-Source: AGHT+IEEwJhLWh3gIzFFs8ok6xXnBjsGV+oZZAx+oJLncZHDjNwZ4cLfp9tY4wAXTihVtTv6U317tw==
X-Received: by 2002:a17:906:cc2:b0:99c:5056:4e2e with SMTP id l2-20020a1709060cc200b0099c50564e2emr755426ejh.31.1691736286768;
        Thu, 10 Aug 2023 23:44:46 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id kd7-20020a17090798c700b0099ba3438554sm1842502ejc.191.2023.08.10.23.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 23:44:46 -0700 (PDT)
Date: Fri, 11 Aug 2023 08:44:45 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net, lorenzo@kernel.org
Subject: Re: [PATCH net-next v2 08/10] netdev-genl: use struct genl_info for
 reply construction
Message-ID: <ZNXY3Vv3HnMbitGD@nanopsycho>
References: <20230810233845.2318049-1-kuba@kernel.org>
 <20230810233845.2318049-9-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810233845.2318049-9-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 11, 2023 at 01:38:43AM CEST, kuba@kernel.org wrote:
>Use the just added APIs to make the code simpler.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


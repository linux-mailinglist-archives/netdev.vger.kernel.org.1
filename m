Return-Path: <netdev+bounces-26165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722A27770C9
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C890281EB7
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AB820F4;
	Thu, 10 Aug 2023 06:54:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79C366
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:54:16 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D250D2106
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 23:54:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3176a439606so544774f8f.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691650452; x=1692255252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3HHF/zskqC4ALWeNoxc1/rAt4hh2Y2XJAhj+Bezh4zc=;
        b=LGzEz1jVq2bCfLEYJyKgCBoI4OWSJmeD/VOmhlHkAu2sqWvZz3DXJN/TMobL3rmzI3
         OQQvRJQSY4Aml6xZcwzyqay45zfNWJcc2kHvyvfjE5fXOm1TetaukzlJXiWmhOmCEf0S
         ID1Kz5+R1iT7tsW1qaRfqgydtucyXZiIq6zNGFaGRVEci66OtRnLYsmxfYqxI4b7lJ7H
         85R7QChvz2GzEm0UxsQXQpzD0vRTW1pAHWYwmyPFpFm813qPslSiyWoiDlZovVOGqiQ2
         lct5qThlikjGHgvPiQ4q1lgfQS7kF6HD2UxzFIRV6UAt9Rp92GL+8yyCyBUIPcyQ167B
         yXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691650452; x=1692255252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HHF/zskqC4ALWeNoxc1/rAt4hh2Y2XJAhj+Bezh4zc=;
        b=gZL1i/woaJaipI1wWCDbzEa9PKKZBGkkEBPrcpc3xdIFzi3ykq+s9XfjKsubjps7UX
         P3cXkppsiR7wsxKLQaMz+q2D9amdChzVzf9JAmZzSSxqY/cm8sN9S9GnwlCwPtRlVDTm
         UwTYq/zsnBN0PH6C89wlbrUPSw8aypim1kOrIGXgiS+X1U0msDJQ3wsn/TMalJe+tYF8
         PT91vZ3iQJOZDkgfBR4bacQoCqIP6zBv04JyJb/bY4TEc8xkZAVaQ2XnUP5xscu7+kOY
         5v9PcIJKq/00RnIEtLdTw5e0MBCkJhLQA5RW1r8DygOZ5u70cKteQ9VaG59fZ9+ONwjd
         BqlA==
X-Gm-Message-State: AOJu0YyGbHtBnvyiRE+CnTtNpM7ocH6wLTgR9Pt1szUgNUVaK4u9qSBI
	ZAKmSv1tCqZqvvMhdwP0tR/lwA==
X-Google-Smtp-Source: AGHT+IG2DytoeTg3K/uuabZt+oOxUGvoZin4sNMZmaxVeARMaJUHOXAVlv15TsmAzDgvs5dMtJny/w==
X-Received: by 2002:a5d:6092:0:b0:317:5181:90b3 with SMTP id w18-20020a5d6092000000b00317518190b3mr1200351wrt.55.1691650452297;
        Wed, 09 Aug 2023 23:54:12 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id t18-20020adff612000000b00317b0155502sm1098204wrp.8.2023.08.09.23.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:54:11 -0700 (PDT)
Date: Thu, 10 Aug 2023 08:54:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 01/10] genetlink: use push conditional locking
 info dumpit/done
Message-ID: <ZNSJkguAyfDH4iu+@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-2-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Aug 09, 2023 at 08:26:39PM CEST, kuba@kernel.org wrote:
>Add helpers which take/release the genl mutex based
>on family->parallel_ops. Remove the separation between
>handling of ops in locked and parallel families.
>
>Future patches would make the duplicated code grow even more.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


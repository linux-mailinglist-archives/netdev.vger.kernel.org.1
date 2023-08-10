Return-Path: <netdev+bounces-26218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E81777307
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1679282093
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2805246BC;
	Thu, 10 Aug 2023 08:34:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D29627700
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:34:04 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94CE1BFA
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:34:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso636598f8f.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691656441; x=1692261241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YeVV8sIYst38qIW188mtSMHW9U8iOP5K7RSJs0jPau0=;
        b=dRZa7qvsbx1QJA+yNmsL69YTk5XCQVNdqNNQ0U3NYei628mq8a760qk1YlGgXif24O
         f02H24TAcP3XwpvyNh8GHieApllLA9Bs/BEKiG+7G5FDmWl0VNzwrAlOFN0Bg1qHEVz1
         HcN7Fmw7wykvG2zE76LBcFo5MxAeIW9+xYQS3ojvayqIHKLDqgzjWPHcjkeoWmGEkQ0S
         WIi7YlyccvjkK0ZIM1MbD0m0OLuLl9g9xGY7zMJdhDQE0xal6NV5fIWYBdttBKM95SJY
         A65f+ook6mxfcAQ+InMCLHwRSjrV9cIpY6r9fOQbjrpfVFiTGeacBY+vgRaCfgQusA2o
         Ob/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656441; x=1692261241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeVV8sIYst38qIW188mtSMHW9U8iOP5K7RSJs0jPau0=;
        b=KYu1C3pH6CW5wNZstLH5UlC1NQ4W+OqJTk9d1UClTBRoHKsFjrmli2DgMPqIafQp4G
         ywqvhZ9EtV6kxzdjSqgIfiN6Gm0HYn8oRm/rH5g9GeSEB9i2VYWEo3ytpx+NJh0Pa6lb
         pT45ZpU0phhDhaSvYhhSUNXR4+/RmeY3UQ35aGNLJiMkxKGJwxYWPQ5J4oyGBBTYiy9O
         zIZxfFz3t+q26yLP+3xfn9lsyJ1mhHwTbVuOcodAlPZi041E4VTGzdm2xKpXzaS/r5Db
         bRS1GkLskl3ADPyeZXaDrvMSZvc2VkxY7YSz16ce5Wx0L5l10wlAFleQm6IoIxXFvtrl
         2hdA==
X-Gm-Message-State: AOJu0YwC9F0RkbAY4KxZaAS5zz9ymG3+RCTxPIrf4X8L7kLTKDb7hZft
	8cK47wrhA+cAb1R6o49UpSPzWw==
X-Google-Smtp-Source: AGHT+IE+mtveonjGE3KmU6oTuxGSs3pflFLounbhV9gF1sW/9wIrLyF9BFRBvHsr35+9FeTaWIQRcA==
X-Received: by 2002:a5d:40c1:0:b0:317:60f0:41e7 with SMTP id b1-20020a5d40c1000000b0031760f041e7mr1545920wrq.19.1691656441050;
        Thu, 10 Aug 2023 01:34:01 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id e10-20020adfe7ca000000b0031784ac0babsm1385076wrn.28.2023.08.10.01.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:34:00 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:33:59 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net
Subject: Re: [PATCH net-next 04/10] genetlink: add struct genl_info to struct
 genl_dumpit_info
Message-ID: <ZNSg92UgJm0Kq/hY@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-5-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Aug 09, 2023 at 08:26:42PM CEST, kuba@kernel.org wrote:
>Netlink GET implementations must currently juggle struct genl_info
>and struct netlink_callback, depending on whether they were called
>from doit or dumpit.
>
>Add genl_info to the dump state and populate the fields.
>This way implementations can simply pass struct genl_info around.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

The removal of info->attrs I was about to suggest is done in the next
patch, so all good :)


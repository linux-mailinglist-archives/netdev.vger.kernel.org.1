Return-Path: <netdev+bounces-26220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD460777311
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650A0282097
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA3EEAD4;
	Thu, 10 Aug 2023 08:35:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35991D311
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:35:10 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC81FF7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:35:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so5243015e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691656507; x=1692261307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oM5c1fCe71bXjP+/DYMV8fSoBtFwccX2huN11PlbeTw=;
        b=rhsbavql8ZH5JMNDD60tdTd090g32uo+vMaRZiiW0SlZM5sGK+GkhcvSPSgZJZfvfd
         tw+Njzz3+RoZRDO7Yjr7xgvtFekWId6AEhTwHTSVzYA98ppF4HwRJWGHN8mwtzrYkK6l
         aHoxdv9WsZJaV+oRqveXjf3pYR1WtrCAsUcu5Kq9dq97PPeL1p80q5/9e0T+AUcosQei
         w0Fy96IoO+n/TB7kSBpvsu/Kw0zeTyKVTSoIWqrIeRg7+2KJdKw/65vsMDYh5dONSqW7
         KdUn4ZNluER1pGBvnYJSnd+0wqHvBvn9UP7CnVLFXD0bA+n77adBUb6208CDskdA709w
         dEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656507; x=1692261307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM5c1fCe71bXjP+/DYMV8fSoBtFwccX2huN11PlbeTw=;
        b=iSdo9teCntSZ2VDuWGz1Y3merb4/rq7lGz5FImEUkzgcEahHXb86gq4Jdd2+am+EX8
         I9YD3+EUYZCJtKMQBhhHyRTNWTFqvl8xeMKwapAhtt/PhWJFI/AVxNPF5Tj+vb2wrrfo
         xhwuKx2lo6sO6SPBZ7kSl6w099pslI1fhQ6Q2q2NGS1MnQ+Qp00/cROKTMwHkMORdc/Y
         HUOawbQcwlQgju+tv0CaxUVgleQDugcYrq/DFn/cYB9teHsuFvs7OkrmUwned2YPwFDK
         lkMaKpDFc0jUuztJaPX0RFEbPKHeBoCUhYZSZfK5v475LE6ymQbyagSj7EWfamwYD1+c
         K4mA==
X-Gm-Message-State: AOJu0Yyk+dXtaY59JQoQIVsFpX4ZCI/cXTGu7W19wV2wY6as89AQ+H5a
	6pINVtjAOQd0kQKkS3OkIWov/g==
X-Google-Smtp-Source: AGHT+IHUOsbgm9S0hE6ryodK/ySL3LaoxEfx6NRd4v0M2koiBNPFLdL77ypCCq8yK8czVI+c7fvE3g==
X-Received: by 2002:a1c:7705:0:b0:3f9:c0f2:e1a4 with SMTP id t5-20020a1c7705000000b003f9c0f2e1a4mr1329391wmi.34.1691656506191;
        Thu, 10 Aug 2023 01:35:06 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id o11-20020a056000010b00b0031431fb40fasm1382078wrx.89.2023.08.10.01.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:35:05 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:35:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net, Jason@zx2c4.com,
	alex.aring@gmail.com, stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com, krzysztof.kozlowski@linaro.org,
	jmaloy@redhat.com, ying.xue@windriver.com, floridsleeves@gmail.com,
	leon@kernel.org, jacob.e.keller@intel.com,
	wireguard@lists.zx2c4.com, linux-wpan@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next 05/10] genetlink: use attrs from struct genl_info
Message-ID: <ZNShOAs5oLBReCxC@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-6-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Aug 09, 2023 at 08:26:43PM CEST, kuba@kernel.org wrote:
>Since dumps carry struct genl_info now, use the attrs pointer
>use the attr pointer from genl_info and remove the one in
>struct genl_dumpit_info.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


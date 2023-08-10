Return-Path: <netdev+bounces-26159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3624B7770A0
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203151C214AA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 06:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AB1C2E;
	Thu, 10 Aug 2023 06:45:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D001113
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:45:36 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867CAE69
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 23:45:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31768ce2e81so586263f8f.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691649930; x=1692254730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4ffl1XH7KIn+SiaL6sUHT2H7UHV5v1krkqjETa0n6A=;
        b=DDldgCJW7Dq2a+hTMqDydw8C3st3SKwTwiqzsxjJPrc3F2RqjST2+aBrsgFow/Ecu4
         tlKbUhPybA89feLYcoUS1F9cXFxRHxDtcK0OebvThMtEYUuM/TQhZu19oUwdZLRpu8sg
         wZbgAFehdUp+N8899eV1nkf7vs6kPSZF4ibaWVaI3IqWnq3jEZdQl3/vjEQjStW9iDX3
         hBar7reO22GFSQlDwp8tAlEROVglqHuZyUhBEi6X1VZAXi+pYW2jDGGBK4XXWc6joaWN
         sxuW0EwIfgDDHEo5eyGq3Cti9t/W4ksHHctTFpahH/mNqbdsqRPMiaGSqBmUY5x5iev9
         DHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691649930; x=1692254730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4ffl1XH7KIn+SiaL6sUHT2H7UHV5v1krkqjETa0n6A=;
        b=cJPhoVcTpCeJsG12Yb4VxvpI/vZz3q9uIXbmKUvMbjs/qbo7FhODgQRHkQVVD4qJeJ
         9IyiJUxpqZiuh8A7O4H6Ux2nEl0D296k7O++a0crb1QdhjgM5uYFQCXsMrE/yMZxmYtk
         NPniOb9KN6H5I9q+hgt5wovdq0H4uqN9GW4iKfR7czlAXPj1UW80L7luOT+tchGunFrD
         iY6FfzSYcO8d8S31+nw0RBkaRsMhzYtv6ATkvcrfqBjPvJXh5y+2LfuvWoP+fFYPprpn
         EpfK62wCTpJhra5KDQCyeUz7lGResKSv7tjglqt/lT/s2qa0DKGtpKafKM+pszxn8jH7
         MPmg==
X-Gm-Message-State: AOJu0YzrsT0lIz1Tmy6/Y8x4yshqv+cHMq+FLhELnaURxbiGYkVyRuxE
	Y2PJ4KQgCL8gKXy8fvqLiRamJNS4akSbjlvK4OWO2A==
X-Google-Smtp-Source: AGHT+IGFvrLjbuJB4FD5M6F0v2JfDH28y3XkYhjdjaautLE8uNRvGJeA5rtj65lI/y4KtK3nZqgikA==
X-Received: by 2002:adf:da45:0:b0:316:f3cf:6f12 with SMTP id r5-20020adfda45000000b00316f3cf6f12mr1233331wrl.48.1691649929884;
        Wed, 09 Aug 2023 23:45:29 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d444d000000b00317f29ad113sm1060251wrr.32.2023.08.09.23.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 23:45:29 -0700 (PDT)
Date: Thu, 10 Aug 2023 08:45:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	intel-wired-lan@lists.osuosl.org,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH net-next v3 1/9] dpll: documentation on DPLL subsystem
 interface
Message-ID: <ZNSHiOUiTbOAFIIR@nanopsycho>
References: <20230809214027.556192-1-vadim.fedorenko@linux.dev>
 <20230809214027.556192-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809214027.556192-2-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Aug 09, 2023 at 11:40:19PM CEST, vadim.fedorenko@linux.dev wrote:
>Add documentation explaining common netlink interface to configure DPLL
>devices and monitoring events. Common way to implement DPLL device in
>a driver is also covered.
>
>Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Signed-off-by: Jiri Pirko <jiri@nvidia.com>


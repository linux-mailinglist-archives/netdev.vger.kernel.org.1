Return-Path: <netdev+bounces-40181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D507C6116
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36FAD1C20BA2
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F02B74B;
	Wed, 11 Oct 2023 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="CauAA/ej"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32C2B741
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:30:07 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67235A9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:30:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9e072472bso407635ad.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697067006; x=1697671806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JtGjh26Eni4OZxnKSlnsIiPe2l0EQ4vE2Am58DZ21c=;
        b=CauAA/ejXBWZG2MIAjZtObMjsRoq+C7c849zbwIGEbbH0eFA/4/8TmRmkG8K6dqH94
         ZZlsqHFxXaCmKihb2vtlgWN5wAAJICwazDHJItEhPitV1o6KAsKx/ZPSY1KI6YYxMCJz
         XFP7iUKFnPUp3ZSSUDtN5lIfRKy+O/kLrLYJVPS7ZhNgl7qSoo/c/lFw1Ia4YHSeeVbx
         bUcTpO2XDyA4fou3HYLrYL0zG1oKMAWyNYgbG82AAQ2uWcKpbm+Ypw10DycQug9872cj
         fSYn3dX+SqD//Ta0vXezeiPZkmowhTb+7DuPlE+zIkdjUr7CLNxjUsPmy5Z8GRvztakH
         tU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697067006; x=1697671806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JtGjh26Eni4OZxnKSlnsIiPe2l0EQ4vE2Am58DZ21c=;
        b=MzQUHiX0/pApHHexwVbz866yIWOIE0S6DHwwPMTCBG63ZA+GDGymEwlZn01SK97YUj
         qgc6lbmovVrrhUKXWe9VyjSJ5BWTJZEK+Ml6leau+G2EKRpS0P9ebLmGMlOKdMXAIuL5
         jTsUjhaVTiimh7qIWrLxa6YoBQ6hDoG7/qZ2pn4Ym0xjWK6Tj1rSChJpKBf9xjt0nzrI
         Cm2dGAiApYTnenp3BWgu6RUC+07rzc0TMA/MrFNfDPPhEr1dY61UzlnLM+DgvHAscc6k
         Ub0jqryA7Sl089ESO8auF5sRPngv2oN4VrYF7u5qI3xSg9Te06+dBuZ1vIh6jqNKrLpq
         7w8g==
X-Gm-Message-State: AOJu0YzZD/anvhn2z8xNY/T/XqYflmgs44iFRumXpfhDwp1ZY4416W1f
	n+X2KCEZbxpSVKBrJbY0ZKVJ6A==
X-Google-Smtp-Source: AGHT+IEV8H5TPcuvOmSF7vUA4QdCpSp7vHMQFvfV9/tCGGpqvYhz4EcKkmpBt6ew0dUnQElfDl19sw==
X-Received: by 2002:a17:902:c1c4:b0:1c9:c3a7:f96d with SMTP id c4-20020a170902c1c400b001c9c3a7f96dmr5257434plc.62.1697067005872;
        Wed, 11 Oct 2023 16:30:05 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001c9cb2fb8d8sm427832plb.49.2023.10.11.16.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:30:05 -0700 (PDT)
Date: Wed, 11 Oct 2023 16:30:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
 support)
Subject: Re: [PATCH net-next v2 2/2] net: dsa: Rename IFLA_DSA_MASTER to
 IFLA_DSA_CONDUIT
Message-ID: <20231011163003.32036b28@hermes.local>
In-Reply-To: <20231011222026.4181654-3-florian.fainelli@broadcom.com>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
	<20231011222026.4181654-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 11 Oct 2023 15:20:26 -0700
Florian Fainelli <florian.fainelli@broadcom.com> wrote:

>  enum {
>  	IFLA_DSA_UNSPEC,
> -	IFLA_DSA_MASTER,
> +	IFLA_DSA_CONDUIT,
> +	/* Deprecated, use IFLA_DSA_CONDUIT insted */
> +	IFLA_DSA_MASTER = IFLA_DSA_CONDUIT,
>  	__IFLA_DSA_MAX,
>  };

minor nit s/insted/instead/

I don't know if it would be acceptable in the kernel UAPI but what
we did in DPDK for similar situation to cause warning on use of deprecated value.



/**
 *  Macro to mark macros and defines scheduled for removal
 */
#if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
#define RTE_PRAGMA(x)  _Pragma(#x)
#define RTE_PRAGMA_WARNING(w) RTE_PRAGMA(GCC warning #w)
#define RTE_DEPRECATED(x)  RTE_PRAGMA_WARNING(#x is deprecated)
#else
#define RTE_DEPRECATED(x)
#endif

...
#define RTE_DEV_WHITELISTED \
	RTE_DEPRECATED(RTE_DEV_WHITELISTED) RTE_DEV_ALLOWED
#define RTE_DEV_BLACKLISTED \
	RTE_DEPRECATED(RTE_DEV_BLACKLISTED) RTE_DEV_BLOCKED


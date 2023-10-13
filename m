Return-Path: <netdev+bounces-40585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023597C7B9E
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 04:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA29B207E5
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 02:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F995668;
	Fri, 13 Oct 2023 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="t7l4wyBl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3F568C
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 02:30:59 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030C6C0
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:30:58 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57be3d8e738so947315eaf.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697164257; x=1697769057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AlSt/UmPpPe6qrtiCDOOfX5E4Znn3Anpv8O+XesUkY=;
        b=t7l4wyBl74o1MWNd5EGt92ncI1qSBLh26uNgNz1jZidkCSMm/hslP9MwX5JtVy4mCm
         /VbLbnXh0Yer4xJCUYbOMIVWwgdIW+KO3NqgWnNo1+qkCDUL0QG9zCKlpIzbNP6M0aly
         arss5MFB3ibA7cXi5Vv7e0u6gIi7jpMrMcG6IaGRi9ZxjlRXN2uVpDnpMBg6ZOZmICHy
         qQYRPSDJCRlhREyEKFZ33jMeRyzhzW1F6NSPK+ZwSub7/6PRTXzkT8HnrW78J2sph/Ro
         XpqM+ike6rlOx6F82fkyCWo8N8wCH3i8K073kr8cD8WRI6PJApWIG9rQTJClIV7AqPPB
         MJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697164257; x=1697769057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AlSt/UmPpPe6qrtiCDOOfX5E4Znn3Anpv8O+XesUkY=;
        b=Q6BG6Rx3T1bfps5/1LIc4OKUvD0hBRqlT4dSkx4AjkFtVx4aVN5VrcWQebaKloFfzG
         Mow65p9lF7U4+Pylvv7qxv3z+0F/Pgsm78munokfVj66d4PSBv+VXn2qEP881B8G8Q8d
         y+zl8rSc2SM0ftXgjUg2IqLNR8hj1FZnM+emVDJbwsFDamjzfkhqRLy/qT4jHrlPuuyA
         ul317ifB+3QAfTb55afQyPpvOl53kP3fEXtbsgr57yd0jXSLpie3oWNH3bcT+PyLwleK
         e7RCYqvLPz8n7vxFxTX42s1jqSLh6B8CctYuknI7iXAXvhdz6t8br9QpAscsLUfyhXDl
         NjMQ==
X-Gm-Message-State: AOJu0YzT8uxAkE4Dk0NiiqhmzYpxEhshE3zJZtG/+Fyr6Ui0RTRa4RPV
	YnxqAIaUOh2k3oRVPPFVM3/v5Q==
X-Google-Smtp-Source: AGHT+IHH3S84jjyAAYr9ohOLASSdFKUdZmxPJl7BDa8RTAh3YuPi9ZQk+GpkCGTRwxLvo8btmJvx2g==
X-Received: by 2002:a05:6358:9691:b0:164:8742:525 with SMTP id o17-20020a056358969100b0016487420525mr21597307rwa.17.1697164257258;
        Thu, 12 Oct 2023 19:30:57 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id u204-20020a6279d5000000b006b1e8f17b85sm379297pfc.201.2023.10.12.19.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 19:30:57 -0700 (PDT)
Date: Thu, 12 Oct 2023 19:30:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, "open list:ARM/Mediatek SoC
 support" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: Rename IFLA_DSA_MASTER to
 IFLA_DSA_CONDUIT
Message-ID: <20231012193054.4c6759fe@hermes.local>
In-Reply-To: <20231012231345.3thxxxhe7pxs5bib@skbuf>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
	<20231011222026.4181654-3-florian.fainelli@broadcom.com>
	<20231011163003.32036b28@hermes.local>
	<20231012231345.3thxxxhe7pxs5bib@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 13 Oct 2023 02:13:45 +0300
Vladimir Oltean <olteanv@gmail.com> wrote:

> > I don't know if it would be acceptable in the kernel UAPI but what
> > we did in DPDK for similar situation to cause warning on use of deprecated value.
> > 
> > /**
> >  *  Macro to mark macros and defines scheduled for removal
> >  */
> > #if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
> > #define RTE_PRAGMA(x)  _Pragma(#x)
> > #define RTE_PRAGMA_WARNING(w) RTE_PRAGMA(GCC warning #w)
> > #define RTE_DEPRECATED(x)  RTE_PRAGMA_WARNING(#x is deprecated)
> > #else
> > #define RTE_DEPRECATED(x)
> > #endif
> > 
> > ...
> > #define RTE_DEV_WHITELISTED \
> > 	RTE_DEPRECATED(RTE_DEV_WHITELISTED) RTE_DEV_ALLOWED
> > #define RTE_DEV_BLACKLISTED \
> > 	RTE_DEPRECATED(RTE_DEV_BLACKLISTED) RTE_DEV_BLOCKED  
> 
> What precedent exists in terms of intentionally breaking kernel headers?
> If none, would this create one?

It would cause warning, and most applications builds don't fail because of warning.
Kernel already has __diag_warn macro which is similar, but see no usages of it.
My comment was more of a "what if", probably not practical since it would just
fuel lots of angry user feedback.


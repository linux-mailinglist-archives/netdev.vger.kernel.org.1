Return-Path: <netdev+bounces-38936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51007BD1D9
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 04:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212F3281454
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9F185D;
	Mon,  9 Oct 2023 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpcP2f78"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35AF17E9
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 02:04:07 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4027FA4
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 19:04:06 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690f8e63777so1130112b3a.0
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 19:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696817046; x=1697421846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJjD5QyZA+VqQAyCuhSlTazKHGZ4ew607TLuXU6RNfc=;
        b=DpcP2f78BQaw7lvxpfh9trhiZa56/7uwhqvJC5R+KbcAsZ54McVVVeXW9I1e441iaK
         JDayvG2NJlg4CpkXPXLsuQS4HWHlEcIp9o3Od8HR/pgD96TD3uzMGHlq5QOAlPcj9dai
         fp1UWLfAkDnybu0Asoyo2PEd8Adf73DZa1ZisI4HH/rFAmN8TX6LOLseM1XP4a0pWZQM
         PpiuBAtvtB7TvyytAdlCyTIhwfDZDWEc1I/53F13Fd6yzB/y2BDSjt4qtnjXbJn5v+z6
         gtOuF07RPZXq/fTEtarLHuYePwzjjyk+rZKmxyaZCkalMIfe8khRhtIszHftOqhoSIOU
         ldyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696817046; x=1697421846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJjD5QyZA+VqQAyCuhSlTazKHGZ4ew607TLuXU6RNfc=;
        b=Aa0oBMiYXn9euWGb4W6Lry2yXtK0m8VEzC8rsFGL64LnnW/Q+F46lWaNnFh/i6B7Fr
         AsscDvgFmARzpCgVlA74RXSS06zTIJ632lYyUje0TkB5b9EWL45/9anD7VxgTpRa6Rnx
         HkkISVNIAa0pZ2SRjb/rHFuJxNMAQV0V4U0CC/N1UAQToBFPy0d2/IgWvfhfZ8HgieYr
         IIQkA+VKjLnGyVnywFp4+FxOP2IwrKGw6eHwima6goTKwg+37tnbfgW/oJS4VZLy00ho
         h3lpoDVp3gp8l2lqApGFjps4CcWM8Ks4ZG2tZIhkyUGDR9FU2/UBtcUBzTfZs8L/Kx5P
         X20g==
X-Gm-Message-State: AOJu0YyRkSMSRYxhfwmnVVtbGbnLh1U9bsEXPGbTufntVSuK5JCmMLMr
	etNmt4Laq5/wA5pe8WmORDs=
X-Google-Smtp-Source: AGHT+IFqHw3k1/Iixkf7lUNn3AK0GOcATuw86alrHPxaP1t/VF7DykhR5SLcsjJtONJCYPDdDhUhOA==
X-Received: by 2002:a05:6a00:391c:b0:690:d0d4:6fb0 with SMTP id fh28-20020a056a00391c00b00690d0d46fb0mr15528288pfb.3.1696817045570;
        Sun, 08 Oct 2023 19:04:05 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id y4-20020aa78544000000b006878cc942f1sm5181143pfn.54.2023.10.08.19.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 19:04:04 -0700 (PDT)
Date: Sun, 8 Oct 2023 19:04:02 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, tglx@linutronix.de, jstultz@google.com,
	horms@kernel.org, chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com, ntp-lists@mattcorallo.com,
	vinicius.gomes@intel.com, davem@davemloft.net,
	rrameshbabu@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH net-next v5 1/6] posix-clock: introduce
 posix_clock_context concept
Message-ID: <ZSNfkkibqP2Q3Psh@hoboy.vegasvil.org>
References: <cover.1696804243.git.reibax@gmail.com>
 <992c76f8570de9e0549c4d2446d17cae0a959b77.1696804243.git.reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <992c76f8570de9e0549c4d2446d17cae0a959b77.1696804243.git.reibax@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 12:49:16AM +0200, Xabier Marquiegui wrote:

> -int ptp_open(struct posix_clock *pc, fmode_t fmode)
> +int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
>  {
>  	return 0;
>  }

You are changing the functional interface, as needed, but I wonder
whether drivers/ptp/ptp_chardev.c is the only driver that implements
open/read/ioctl.

Did you audit the callers of posix_clock_register(), or maybe do a
`make allyesconfig` ?

Thanks,
Richard






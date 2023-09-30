Return-Path: <netdev+bounces-37219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16707B43F3
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 23:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 858F12820DE
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 21:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EC61945A;
	Sat, 30 Sep 2023 21:38:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A2D18C3C
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 21:38:30 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B4A9
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:38:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27755cfa666so2232544a91.0
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696109909; x=1696714709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rSvml88SkSF8RvqM8CR2kTAtmQ5Aqer3a77F5NOn30=;
        b=it1X5TsOk9tJQvyW1E3GAx5hBj66u7RbsGTQvz64VUwRpK17TLyN2dxWbaPbEX/rmM
         46Dt/Zkc6YicHe8o34pIv3UTKmHBb03i8u04SanqkKzk5X4/jJVRrZ8YpdgBgDnuBjyk
         0WTSH0Y+jaL6mVSOVBsvuQsG6qr5/eKQbW0fsQGg8YughJyuBIJUvuHDdtWOVafedpZ6
         UABDdglDLfEEPSTqSlIx4OWD8l88tgtIKw2lpzr6qJi3qRaQsjt/or72MvwuI+pRHHAT
         eg1YMuxT+M1+6SFG18/LQfBl6wsC32JWZ4HwMhbSHS4fGuZzo4IGBRdUT44izl4sbEBk
         DDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696109909; x=1696714709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rSvml88SkSF8RvqM8CR2kTAtmQ5Aqer3a77F5NOn30=;
        b=XM3ULgb6muStgf5TX7htZsFiIExVAM0oPvu3v5WI7hzngKPkBcrh1NSe4ONpVCdCIk
         i/rHDKPB19u8EgfuTly6DA+QSzUZdNpwDjxNNdHNmviQcOlRrCNzEf3QMwtmU7l0rZd2
         hg7mFHj9g6KaV611+QLit1MMmrqZ+bN6ntnZ+AlnO+t1BlCzBgAuvXX5RtIN+YEgQcnV
         FUnXADQMFwGQvenr0sJbq5CFnzf8RGlQt9EqbZ71fEHQwLtVlMlXtqFR09xYTgaNUEYE
         M2FrfBnN7fheivIS54NrLvLLPD63EIm1vILxuxHIiKlkOS+n7ZW2WcPpvjzgk5blXgat
         kh/g==
X-Gm-Message-State: AOJu0YygNzqMPKOyq5H/0pB2nooA9SAuQrC3hT0eYSPkKwMbJcnBEaCu
	ugJs3pnZ+HneTiKMtHwArGA=
X-Google-Smtp-Source: AGHT+IEVOB+k3D+jJLo6mUlL+AAsAfVdhutP9gpvk1RAuKXwWzCa16hBXCOmsxEX4C+aX4TAN/nLKA==
X-Received: by 2002:a17:90a:3d0a:b0:26b:5fad:e71c with SMTP id h10-20020a17090a3d0a00b0026b5fade71cmr6921721pjc.2.1696109908638;
        Sat, 30 Sep 2023 14:38:28 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id s13-20020a17090ad48d00b00274bbfc34c8sm3598219pju.16.2023.09.30.14.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 14:38:28 -0700 (PDT)
Date: Sat, 30 Sep 2023 14:38:25 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	ntp-lists@mattcorallo.com, vinicius.gomes@intel.com,
	alex.maftei@amd.com, davem@davemloft.net, rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: Re: [PATCH net-next v3 0/3] ptp: Support for multiple filtered
 timestamp event queue readers
Message-ID: <ZRiVUbL48mjzPvDu@hoboy.vegasvil.org>
References: <20230928133544.3642650-1-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928133544.3642650-1-reibax@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 03:35:41PM +0200, Xabier Marquiegui wrote:
> On systems with multiple timestamp event channels, there can be scenarios where
> multiple userspace readers want to access the timestamping data for various
> purposes.

This series is shaping up nicely.  Can you please include the diffstat
in the cover letter next time?

(git format-patch should do that for you)

Thanks,
Richard


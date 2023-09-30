Return-Path: <netdev+bounces-37222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF347B445C
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 00:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E1762281551
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 22:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676C219471;
	Sat, 30 Sep 2023 22:05:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CCD646
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 22:05:16 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0448BC6
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 15:05:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27755cfa666so2236772a91.0
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696111515; x=1696716315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RGMyjtr8QPPNDLjaRlPEnKY0/mtq80hq6tXIQhsL8oY=;
        b=LxuhHTwERswBqvf0hSXsJG01sd5i/HbkAHhrHE5V9g7DeT0gJL+D92twr7bAStVt1h
         lOkRow3Yc/JPcJWRlOODgs265j7k8rqI4g9xXa6zFZ5ND3gz9ZiH7i2dsBs9zZ2qslva
         BdAEtvtXzUqVl/HBWKDQBtd5Y1LvBi/y+uwvZrWra7u0eK9RdR2h2vAnQBdT5u6hm95h
         JNrUrPRt/UYFRsLMYXQR1syVsRVVfvhmfGp1de4GX2KgkDMHR/vU9PM0xbZ1tMX+/niu
         4RsydfUqPFWorq6hcUYeKBV7FqjRULEb2FqOEQBaui4/72CQhkam8rR9VV8wfELOHxF/
         Q8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696111515; x=1696716315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGMyjtr8QPPNDLjaRlPEnKY0/mtq80hq6tXIQhsL8oY=;
        b=AvHw7ibZEWGMU7TkzbCIzd93ccJYL6MC/hqI+CugqVJFa+uhU6XWSqkauGFN3LdE9u
         7S88p3Se5bRLbJEn/IqmoP4ga1uDVX49yqSx/SH4PfFtUTlWYNMygLy2ynn8M54EasPn
         i0taFe8UlLCrJBhENG9PYi3TWKLeMYXZ4B+TEq/NYTKkLs3M2PsnZOrMx9Qw26TnkEbq
         rhFJyiLlGxGgjMHuyRjkpwg5+tQcGFdCPTnAlaPDlg/toNWGbux1DJgQmyWAhEZ1KdRW
         myU8m1Qv9c3jC3yF3BQuQ+oiOvBIUgff6TKp0kNzjrxhq/95N8xW0W+eCrilCiLZoVfK
         MZbA==
X-Gm-Message-State: AOJu0Yx9GJE7ODGy/HH2CPh/792MSrj3SnWPl1J4eXMPVDJiBJtdajY+
	9QSHWXQqZcd07VUqKjhnV9E=
X-Google-Smtp-Source: AGHT+IH9gMT00S4gWLvoQLzOZFFCVi7jv44xRs8ci3yr5NAb/0QrvZ2GkP7NKAVAyXBQ5HZd4OOlMg==
X-Received: by 2002:a17:90a:9cc:b0:273:e4a7:ce72 with SMTP id 70-20020a17090a09cc00b00273e4a7ce72mr6940380pjo.3.1696111515368;
        Sat, 30 Sep 2023 15:05:15 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090a530f00b0027654d389casm3527592pjh.54.2023.09.30.15.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 15:05:14 -0700 (PDT)
Date: Sat, 30 Sep 2023 15:05:12 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	ntp-lists@mattcorallo.com, vinicius.gomes@intel.com,
	alex.maftei@amd.com, davem@davemloft.net, rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: Re: [PATCH net-next v3 2/3] ptp: support multiple timestamp event
 readers
Message-ID: <ZRibmLHEBGUWfOZM@hoboy.vegasvil.org>
References: <20230928133544.3642650-1-reibax@gmail.com>
 <20230928133544.3642650-3-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928133544.3642650-3-reibax@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 03:35:43PM +0200, Xabier Marquiegui wrote:

>  include/linux/posix-clock.h |  24 ++++---
>  kernel/time/posix-clock.c   |  43 +++++++++---

This change deserves its own patch.  Please put that first in the
series.  And be sure to CC tglx and John Stultz.

> diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
> index 468328b1e1dd..8f844ac28aa8 100644
> --- a/include/linux/posix-clock.h
> +++ b/include/linux/posix-clock.h
> @@ -14,6 +14,7 @@
>  #include <linux/rwsem.h>
>  
>  struct posix_clock;
> +struct posix_clock_user;

No need for a forward declaration, since the struct is below.
Just put it here.

> @@ -90,6 +93,11 @@ struct posix_clock {
>  	bool zombie;
>  };
>  
> +struct posix_clock_user {

The idea is fine, but how about calling this "posix_clock_context"
instead?

> +	struct posix_clock *clk;
> +	void *private_clkdata;
> +};

Thanks,
Richard


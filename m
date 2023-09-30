Return-Path: <netdev+bounces-37223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C9B7B445E
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 00:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E9B482819E7
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 22:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E31947B;
	Sat, 30 Sep 2023 22:10:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070971945A
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 22:10:57 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B50CF
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 15:10:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c61c511cbeso20802765ad.1
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696111856; x=1696716656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CNi7AgcNl07vyFXj58Ur1Ua3bFOB8U0ITBPJ7LocmOQ=;
        b=mwreKS9Y/L6WsPtvbJ+IgtBi5u7pZuclGfodGPhVeZ24DVBgs+BMUVgzOjymEl18IA
         W10SA50Ty1f8fEhqPoK9jjm4bGV7mb/6U8nUK7+mObJMxBf2E3zJ256y6RhYrOIKW+TQ
         yOdxIluifIXvE2hKDPF2DtabOywJvyZi2qgb1Kb0eQp1mOYrqj6gFd1QxJk/gW54vVOn
         piwkVrzmoucRAOxUtDYEI4wLwxz+uDot1MACyA0AHR6OgTKcLYt5JTtoSCMOiahVx5T8
         STdXnkFfvzHWzKmatLfXbd7mSqczaPhVr/z3R11yoXwj6oPUBjM7QGd42L6TpjT2Ft6A
         ICjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696111856; x=1696716656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNi7AgcNl07vyFXj58Ur1Ua3bFOB8U0ITBPJ7LocmOQ=;
        b=cb86rfeUV7mPt4vKtQLHsYqPQW2vxoSjYfJhSxX/NTr1KxxNVWb2Llin+s9lNdlQHS
         7cfEros8xiMWUN42fFShekZ1XuuzdWpiaw10Cv3H+bSF3N1RZ5M64gVIESzWQNJeWV33
         rQ5X2nIG8Vn9vQFmdnzWaIZkZYIZkClg399WS0uxcxYMNQKYX3t+C4nvjn+5yCIC4ZTP
         gECbJW4vVlAQiahbyx45GYMi/IrMGC+24dBFRqczBC8cD9jIhliSJxZmGZprJByYvJ6X
         Bvw2E722MH6vojjGvNav+91pET8TT1wwhnU4hs7HkEPEixh997BJCFnKoIfQYjIeyTL1
         XAnQ==
X-Gm-Message-State: AOJu0YwwbZFz/2s8MB4YFY6EHBLiQZW6TzVo7PbtU6CBEn14IZOkjx1P
	vjaveMEThzU6eW5zUqyvJuc=
X-Google-Smtp-Source: AGHT+IGbzKEKifuBI0wkLnuLmNR05v/NuPgph8oo1Y0WbJjZgNNpyXSYaV9n2NUDw5S9c6c7L28c9w==
X-Received: by 2002:a17:902:db06:b0:1c1:ee23:bb75 with SMTP id m6-20020a170902db0600b001c1ee23bb75mr8881384plx.1.1696111856135;
        Sat, 30 Sep 2023 15:10:56 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090341ce00b001bb9f104328sm19181512ple.146.2023.09.30.15.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 15:10:55 -0700 (PDT)
Date: Sat, 30 Sep 2023 15:10:53 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	ntp-lists@mattcorallo.com, vinicius.gomes@intel.com,
	alex.maftei@amd.com, davem@davemloft.net, rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: Re: [PATCH net-next v3 2/3] ptp: support multiple timestamp event
 readers
Message-ID: <ZRic7alWmNrbjU/F@hoboy.vegasvil.org>
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

> @@ -19,7 +19,12 @@
>   */
>  static struct posix_clock *get_posix_clock(struct file *fp)
>  {
> -	struct posix_clock *clk = fp->private_data;
> +	struct posix_clock_user *pcuser = fp->private_data;
> +	struct posix_clock *clk;
> +
> +	if (!pcuser)
> +		return NULL;

You added a test for (fp->private_data != NULL) that wasn't there
before.  Was there an issue with the existing code?

If so, please fix that as the first patch in your series.
If not, please remove the pointless test from your change.

Thanks,
Richard


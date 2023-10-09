Return-Path: <netdev+bounces-39252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943A17BE7BD
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B421C20831
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E5374FD;
	Mon,  9 Oct 2023 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7I8hYho"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF93714F
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 17:22:54 +0000 (UTC)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3674694
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 10:22:52 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3528bc102adso18337025ab.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696872171; x=1697476971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FyrHUncwIbuAenfVDZXIgy/WAecJiWycGhNcLfrs9wQ=;
        b=S7I8hYhoWO0Dke2WGOzGu+y/xeYTRmS7y5b/Dd8CatpuD/lxJtjoTqkBjFltZk/Gxm
         DeYDNQFX69s9vhgMoct6OpDKxokUZRazscn+Gh1KO+TwlHvsqj0ECCPPtqHMNWelPNL4
         Lj2FNFR6hSbRNcVVvGX6PxTA9HIFMhJPvUN1A/LKIQa21E822YCqQG8uF0uGLQvb7ygp
         /w6RNMzcsClSk24ncdlM61x8VKylRItSyHAno8Yq3Ae25ohmbX5lJNu/pT7UrJptkG/p
         OwCvxmxyBojG9c+uavJ/Iyu4UpK6I5jecY7qKJxMvHOM3oXSgo54avvzWbkKL+7TngVA
         Ulcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696872171; x=1697476971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyrHUncwIbuAenfVDZXIgy/WAecJiWycGhNcLfrs9wQ=;
        b=XQcGTKL5dqw/VzVTt2cCG3UABTqaKmWx8uirtNsFj+j1f9nsp9KMwknXRhiS9kRLeD
         NN4V0U2Z3AryQN7bAng6TZHSze6R+BGUm4PHAyj7jWJb6jDspqksBetxxj9oFXKRdPiX
         w1q6loQ1eZck9iaiBvLwOjptSD3qCJ7zvStcwXVDSEdbsjExz+A7kXALCoslxtMudc/c
         hK6VkgOxI2EQ6JsC8T0cQuFU7JNv/3bPy8XeQVZYK/ftyTZK1XbM8PLLhqbCQmnIruut
         CbswwvER5XZTJoNN/YT3aZcIldYOMF3lkpwnuvzsat6iZkb4HF0gyHKRvJ6HnZhLinxZ
         ixmw==
X-Gm-Message-State: AOJu0YzMUTVW/7ihEIGcsyslQO/juorcll9fDendudBg9CX5/ZPS6dwu
	FRCV2V7aWxliuBFwKTHgcX6y+A==
X-Google-Smtp-Source: AGHT+IESGDL5JZuUy4WjDigCmfDdd2PwU93Z9KgGz2t770bhc/dWPwn/PzFLzV84RY8/doRRjiQqFg==
X-Received: by 2002:a05:6e02:1c46:b0:351:57d5:51c4 with SMTP id d6-20020a056e021c4600b0035157d551c4mr21254542ilg.1.1696872171467;
        Mon, 09 Oct 2023 10:22:51 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id cw19-20020a05663849d300b0042bb6431487sm2246205jab.65.2023.10.09.10.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:22:50 -0700 (PDT)
Date: Mon, 9 Oct 2023 17:22:45 +0000
From: Justin Stitt <justinstitt@google.com>
To: Ricardo Lopes <ricardoapl.dev@gmail.com>
Cc: manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: qlge: Replace strncpy with strscpy
Message-ID: <20231009172245.wholw3yhu46l6xiq@google.com>
References: <20231006161240.28048-1-ricardoapl.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006161240.28048-1-ricardoapl.dev@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 05:12:24PM +0100, Ricardo Lopes wrote:
> Reported by checkpatch:
>
> WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy
>
> Signed-off-by: Ricardo Lopes <ricardoapl.dev@gmail.com>

Nice patch!

It looks good to me and helps towards [1].

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
> v2: Redo changelog text
>
>  drivers/staging/qlge/qlge_dbg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
> index c7e865f51..5f08a8492 100644
> --- a/drivers/staging/qlge/qlge_dbg.c
> +++ b/drivers/staging/qlge/qlge_dbg.c
> @@ -696,7 +696,7 @@ static void qlge_build_coredump_seg_header(struct mpi_coredump_segment_header *s
>  	seg_hdr->cookie = MPI_COREDUMP_COOKIE;
>  	seg_hdr->seg_num = seg_number;
>  	seg_hdr->seg_size = seg_size;
> -	strncpy(seg_hdr->description, desc, (sizeof(seg_hdr->description)) - 1);
> +	strscpy(seg_hdr->description, desc, sizeof(seg_hdr->description));
>  }
>
>  /*
> @@ -737,7 +737,7 @@ int qlge_core_dump(struct qlge_adapter *qdev, struct qlge_mpi_coredump *mpi_core
>  		sizeof(struct mpi_coredump_global_header);
>  	mpi_coredump->mpi_global_header.image_size =
>  		sizeof(struct qlge_mpi_coredump);
> -	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
> +	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
>  		sizeof(mpi_coredump->mpi_global_header.id_string));
>
>  	/* Get generic NIC reg dump */
> @@ -1225,7 +1225,7 @@ static void qlge_gen_reg_dump(struct qlge_adapter *qdev,
>  		sizeof(struct mpi_coredump_global_header);
>  	mpi_coredump->mpi_global_header.image_size =
>  		sizeof(struct qlge_reg_dump);
> -	strncpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
> +	strscpy(mpi_coredump->mpi_global_header.id_string, "MPI Coredump",
>  		sizeof(mpi_coredump->mpi_global_header.id_string));
>
>  	/* segment 16 */
> --
> 2.41.0
>

[1]: https://github.com/KSPP/linux/issues/90


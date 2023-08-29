Return-Path: <netdev+bounces-31281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE8478C6E3
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 16:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04B32811CE
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF45F17757;
	Tue, 29 Aug 2023 14:08:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0E171B2
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 14:08:10 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA479D
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 07:08:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27197b0b733so252540a91.1
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693318080; x=1693922880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQenVO/unOFDUGMqoWkT2B8zntkdnduAT+CdqKerxbo=;
        b=BK3yjlsoWnMLFSqFv6TJ9CvpUUIRLc+y0BWtrUYoDRekjxt/4t7ngdhrmbPbiYZgPC
         rCaXM8zXKpJC8pLntZ2Y3XqsdfZjH15G/9hmYhsAs9r+lQEGqjGQwVu1RqiKIkThMNKq
         GSVXMpC2d2QRhBsXGVM2QxYyf5gNcmVwIuPJM2666DnezMcCqxb17Idl/l73P5KDqtWe
         CeGtYuXtz5P5U/aHHL0bVrEQXRjCnEbE6FLCnDRh84Kcv7nNJVlOaj1QCP3XXcjAh3JI
         yhKUJZ9IUrZGrhmEEy+m+TBxizOQ9q2cwJYRow5UxMTUUXweBB6XoCTwk6scpHjbZLdp
         arrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318080; x=1693922880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQenVO/unOFDUGMqoWkT2B8zntkdnduAT+CdqKerxbo=;
        b=AmEAoKUAEPYf7lvDXAHZtMr3v1QKxW+v6hyf5ZzghAOIPapve9AOUvHzCK1PJBkJWU
         opoe+odk1Jv0vMClmpl+sZbihGUGxHogrxd8dUX1Rr4MA6uFUanTkCafO5EJ24bqNZpS
         CpbtrzuO3BrFaOcEFuZkiwXLUQHJ6fcC702MQdhOdXWxSfed6Gtt/cSf4PZz+dvAYIPU
         oq5USyncTJXla3+q5yu1yRLU1567OSJSq2BhsZN5ozySMQH2m2R45UWnN04ZJMiaWLG5
         5cbpsv6SGNaghIZpltuKCVoD7qxBYi5maF90e9XMFUuZbfkCVZVCQ1sA2aWnAyIpSiLo
         MpHA==
X-Gm-Message-State: AOJu0Yw3oKMRlFYwn8oyICa4cWfmbqIeCgm86iiKxLqxQA1U4r0E7hI/
	/XcWoUhPJyqRXbfVsauZrhJZSFfBuJI=
X-Google-Smtp-Source: AGHT+IHHHWV1augxa46PbIR/+ixn/2sFL8TuxgVxq7rRgN0Rvkoeyz8q5X6rnMx8uManXCRjLZvk+g==
X-Received: by 2002:a17:90a:9a8:b0:26d:40ec:3cf3 with SMTP id 37-20020a17090a09a800b0026d40ec3cf3mr26150693pjo.0.1693318079938;
        Tue, 29 Aug 2023 07:07:59 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090abc8500b00268b439a0cbsm8936261pjr.23.2023.08.29.07.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 07:07:59 -0700 (PDT)
Date: Tue, 29 Aug 2023 07:07:57 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	netdev@vger.kernel.org, ntp-lists@mattcorallo.com
Subject: Re: [PATCH] ptp: Demultiplexed timestamp channels
Message-ID: <ZO37vZvXX9OPDLHH@hoboy.vegasvil.org>
References: <Y/hGIQzT7E48o3Hz@hoboy.vegasvil.org>
 <20230829114752.2695430-1-reibax@gmail.com>
 <20230829114752.2695430-2-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829114752.2695430-2-reibax@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 01:47:52PM +0200, Xabier Marquiegui wrote:
> Add the posibility to demultiplex the timestamp channels for
> external timestamp event channels.
> 
> In some applications it can be necessary to have different
> consumers for different timestamp channels. For example,
> synchronize to an external pps source with linuxptp ts2phc
> while timestmping external events with another application.
> 
> This change proposes the dynamic creation of one char-device
> per timestamp channel only if the user requests the demuxing
> of timestamp channels. It allows for on-the-fly demuxing of
> specific channels.

No need to make complex configuration to enable this.  Just make one
queue per open character device, and one for sysfs.

> The operation can be controlled via sysfs. See file
> Documentation/ABI/testing/sysfs-ptp for more details.

No need for new sysfs hooks.

> ---
>  Documentation/ABI/testing/sysfs-ptp |  16 +++
>  MAINTAINERS                         |   5 +
>  drivers/ptp/Makefile                |   2 +-
>  drivers/ptp/ptp_chardev.c           |   2 -
>  drivers/ptp/ptp_clock.c             |  22 ++-
>  drivers/ptp/ptp_demuxtschan.c       | 211 ++++++++++++++++++++++++++++

No need to add a second char dev implementation.
Just change the existing one to have a per-file queue.

General comment: Lots of coding style violations here.
See CodingStyle and use scripts/checkpatch.pl

Thanks,
Richard


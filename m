Return-Path: <netdev+bounces-46093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4EE7E13CA
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 15:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2692FB20B96
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AB8CA49;
	Sun,  5 Nov 2023 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/+vKx3d"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B703C8E3
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 14:02:44 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A75AB6;
	Sun,  5 Nov 2023 06:02:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-280b06206f7so674034a91.1;
        Sun, 05 Nov 2023 06:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699192963; x=1699797763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMML29XmljUBP73d1u+oACTcGOeBeUKVNwdj0nRDrlc=;
        b=m/+vKx3drawUZpLERM5bsvrwdbTBqX5SIm76vZJEoasUs3GSZs6/Swq/eg2uQBstVf
         DwjeKkvrNxxyD1f5FbGzv/oYVlnI7K1RN8rPoUfxD14kfaMCqpn7Ruz4SNBaQKvt2wR0
         oR7PAvYKIa580Te2wVE2I1SW6l2rndPVZbRFhf8oFKyf0SCGrDaOtr4FZzQ9d4jE7xTq
         N2LFt8l/Qh3GCJORbfvgVzE34p+yyzfvRJ0/sJZ7SXSnDxEl4CvW9G706Cr0S80DR7CL
         EZ/QBcberVaxNcpi93FeduzJ0gmgBRbhRGXGKovT6s7QaYCmBm3X8paVVS+C3U6mKtU3
         VCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699192963; x=1699797763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMML29XmljUBP73d1u+oACTcGOeBeUKVNwdj0nRDrlc=;
        b=Fs1gJaMCKz1lHdrdc2o8wz5XwagVxszZ1khBAbrjuComIZUSmrEZQusZblDJ1mblV2
         xa8Mn3x8LG4Sd7iUURFOBtZlmq9issgTW/TqwqrHdgBsaMcH0hVln0E/LVcgRlPQgpaq
         g0tlwr3a/2rDd9rN59/F19gIdmZb4cLPv38BYjppDzjTb+pgiA22qhoazZiBv96HfN8O
         BtuI5xcQCveGp75UqDqLaek+kc96J2VQu+H4Mp6aYQFzN7f3PzZb4ra8EP37rjQwHe9Z
         njwyF7t3kbhoTneads2ZXbi2bcfdpXbE4+kIJ+nwnoRG9fOp1cFzRyNcll4SiyTC3Obt
         s6MA==
X-Gm-Message-State: AOJu0YyaMd+8OufURbz5Y7MCogl0oY2aIcVASiFdgRS/JmDMvF95P682
	VUQ6cP9yd/p/fuUV7wc6nGM=
X-Google-Smtp-Source: AGHT+IGzCQDltgsQsyhXMBZj46CfBvqvXf6imqmbWz+g0+MwMI1JRQh72FBG2pHKMz0ch2CSnlsdOg==
X-Received: by 2002:a17:90b:4396:b0:274:99ed:a80c with SMTP id in22-20020a17090b439600b0027499eda80cmr24254426pjb.3.1699192962758;
        Sun, 05 Nov 2023 06:02:42 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id fh6-20020a17090b034600b0028031e87660sm4108981pjb.16.2023.11.05.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 06:02:42 -0800 (PST)
Date: Sun, 5 Nov 2023 06:02:39 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, habetsm.xilinx@gmail.com, jeremy@jcline.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V6] ptp: fix corrupted list in ptp_open
Message-ID: <ZUegf5Od1rWxZ7rO@hoboy.vegasvil.org>
References: <tencent_856E1C97CCE9E2ED66CC087B526CD42ED50A@qq.com>
 <ZUeaaVHlYCaq2NwG@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUeaaVHlYCaq2NwG@hoboy.vegasvil.org>

On Sun, Nov 05, 2023 at 05:36:41AM -0800, Richard Cochran wrote:

> > @@ -44,6 +44,7 @@ struct ptp_clock {
> >  	struct pps_device *pps_source;
> >  	long dialed_frequency; /* remembers the frequency adjustment */
> >  	struct list_head tsevqs; /* timestamp fifo list */
> > +	spinlock_t tsevqs_lock; /* one process at a time writing the timestamp fifo list*/
> 
> Please change this comment to "protects tsevqs from concurrent access"

And please don't forget to take the spin lock around
list_for_each_entry() in ptp_clock_event().

Thanks,
Richard


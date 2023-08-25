Return-Path: <netdev+bounces-30790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B767890CA
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 23:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B671C2104D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E1A198AC;
	Fri, 25 Aug 2023 21:53:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B8193B2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 21:53:57 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BF2701
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:53:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2685bcd046eso838078a91.3
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1693000434; x=1693605234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EA93GbJhFaX1RD1S1v1NWvgWKkuCopUaLEmO6z67OS0=;
        b=cH08dFt6/4c3wH/stFXC+uGu5D8z0Csp+c9btLL74n40FUQC+soJCMHngcXZEBLgzm
         qybrDAhkHNIQidm6McS9k7OAisvjKsYcisQszCCpar5CuSiRIpSFGB178B7PZGJmjIVI
         4C//pqzQHhkBzMUsweM/Ox4iwIPKOu4SLlyG1BwihVAd4isMoJvmKve8ppg0AFR80Lm5
         +9HwDLBwFdO48zPf3pAy2OfApTkcKybUvjmHUA0hm0UnLP/VyyPd03hkf4rprWixbIcJ
         VF2B37IJ0D+t2NzeGs35vYm6/AeFMMVd3Duqbo/sN/EdZ49iAcVRSUTD7gvcubzYge+h
         CorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000434; x=1693605234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA93GbJhFaX1RD1S1v1NWvgWKkuCopUaLEmO6z67OS0=;
        b=D2TI+2CwhZ+FrZPQrXJIGEWkpB7QBqN6Ru5iLj+x26RPMPTh2K48TucOUl4QcWJdWu
         QrNCeLw/kOHgLdO5K+p5rqxvzsglOWUFrR8GuvqkYkKUZ5a0UZGEPtEv3ob1tSgBjlL1
         asSE2yTK032Gg5Lwcye3kbtudw6d3wrW5Chpx1hKAqkx/eAe0FseO9D/YUcb97orkqer
         W2AF5W9dSflRoZ8AxNxNM6JmbvSUzHHgiIdwvRAYeI0JOoS69w2QC6zO7DjwMnUcxlty
         hnBJMbMLlzVUinl3BzM0GjopsIZKf47M68t3DPxBPaADK9rmiQgoAXse2Blw0QTo/oNP
         pCfA==
X-Gm-Message-State: AOJu0Yw+UnzX+9X+GoIXMgnWNe2oA3/TEYdjrMKXrLbgzGXafwJoqU/s
	1Kq4UMmWIOU1l/nVVQUyfIQ+gQ==
X-Google-Smtp-Source: AGHT+IGuXiZpaiaSoWbg0vAVB9MheRguVETxlh6z74Aponrqbg78kQHVeidygYbMeETEncHmOPB93Q==
X-Received: by 2002:a17:90a:bf88:b0:263:5d25:150c with SMTP id d8-20020a17090abf8800b002635d25150cmr15563047pjs.29.1693000434105;
        Fri, 25 Aug 2023 14:53:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id fz23-20020a17090b025700b0026b4decfe59sm2177778pjb.31.2023.08.25.14.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:53:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qZekY-006V5n-1X;
	Sat, 26 Aug 2023 07:53:50 +1000
Date: Sat, 26 Aug 2023 07:53:50 +1000
From: Dave Chinner <david@fromorbit.com>
To: Hao Xu <hao.xu@linux.dev>
Cc: io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-cachefs@redhat.com,
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, codalist@coda.cs.cmu.edu,
	linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
	linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
	devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
	Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCH 24/29] xfs: support nowait for xfs_buf_read_map()
Message-ID: <ZOki7u/zJGmZtL6g@dread.disaster.area>
References: <20230825135431.1317785-1-hao.xu@linux.dev>
 <20230825135431.1317785-25-hao.xu@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825135431.1317785-25-hao.xu@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 09:54:26PM +0800, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> This causes xfstests generic/232 hung in umount process, waiting for ail
> push, so I comment it for now, need some hints from xfs folks.
> Not a real patch.
> 
> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> ---
>  fs/xfs/xfs_buf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index cdad80e1ae25..284962a9f31a 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -828,6 +828,13 @@ xfs_buf_read_map(
>  	trace_xfs_buf_read(bp, flags, _RET_IP_);
>  
>  	if (!(bp->b_flags & XBF_DONE)) {
> +//		/*
> +//		 * Let's bypass the _xfs_buf_read() for now
> +//		 */
> +//		if (flags & XBF_NOWAIT) {
> +//			xfs_buf_relse(bp);
> +//			return -EAGAIN;
> +//		}

This is *fundamentally broken*, and apart from anything else breaks
readahead.

IF we asked for a read, we cannot instantiate the buffer and then
*not issue any IO on it* and release it. That leaves an
uninitialised buffer in memory, and there's every chance that
something then trips over it and bad things happen.

A buffer like this *must* be errored out and marked stale so that
the next access to it will then re-initialise the buffer state and
trigger any preparatory work that needs to be done for the new
operation.

This comes back to my first comments that XBF_TRYLOCK cannot simpy
be replaced with XBF_NOWAIT semantics...

-Dave.
-- 
Dave Chinner
david@fromorbit.com


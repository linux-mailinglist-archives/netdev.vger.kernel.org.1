Return-Path: <netdev+bounces-30792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9111D78914C
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 00:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5393828188D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811D31AA61;
	Fri, 25 Aug 2023 22:00:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1F198AC
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 22:00:06 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EB12703
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:59:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68bed2c786eso1101214b3a.0
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1693000786; x=1693605586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCmT1oESbAYhZeNNKJ5ShtRN4csCjH3Kne0S41EAnjg=;
        b=41e5WqQODP0hmu8CXJSYnJoxP9CYCTQIjvtSx0suLjuCd2LQoihd/jLrKiko4xwooZ
         7dYHeAbwy4v/acegR7zM2t87koKR6b9HdwUQM9+1khEZHSlP6Ay9Gyi1BnTTJyQ+N1sf
         Tihv+CPf4TPS3j/ZySi0TL4gDqhyuMZ+nJxTaDnexRh6Pcmjy8aRHLfP/t/1vg9xEN/C
         0OJKzvJcUqwLuYg4eu+OPeBIRa0lo/YObVmgzaCCijZ7OHy87LLvHUMM6er4JE4Dhtu4
         AWYpsvb+nGYnjp1AziAY3+XfPWUVf+GXDgs/Cvrt+UTpnf3nupIw3K4PynKsZ49o3GsI
         BY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000786; x=1693605586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCmT1oESbAYhZeNNKJ5ShtRN4csCjH3Kne0S41EAnjg=;
        b=Fuv7BoXDGbosn+Ooy1CkwndtRSQfPOJ8QkE+xdiRKn2kPt5GYKhcOtW8BLKWcReViT
         p9ZlGNsrjEuDCVHsXl5l8J+NFOTCgLbMEJ1Is4bsL0aqz85vKpADuFXG1oFqijsep0pb
         /pY7SBw2M68eVn0gBklLsCTH7yEhvgtXtRV4QVhfBrV7yZMIfBW5DS1PJPfuN/bgSdAF
         3KFC2Apl8dDuiEIsYi90y8wxA0oAVWPLt/E6s+opD0tmyUVtyAs8yziF2c1JfPioqAUd
         vfBPHr2IVyBXIuiZSMhq8otoDlcrVtyhNmZ/aXquhW5BW07BF4lbE/Y4lXZvxwetQb9B
         rX6w==
X-Gm-Message-State: AOJu0YwXIFDazn5Sri/zzxsQU5wc4XZ3lMiN9ks6COyaQIaE5zQz8eBB
	AOZQQQQ9bs8uPd/Dek/9Z8Zakg==
X-Google-Smtp-Source: AGHT+IH1qPsbAkUY/ApYOINMHsRtAsDWZuWyGwI872JdnDKqNbs04KgeM02oT1drFck2zagaT8PEnw==
X-Received: by 2002:a05:6a00:cc2:b0:68b:a137:3739 with SMTP id b2-20020a056a000cc200b0068ba1373739mr11002510pfv.4.1693000786153;
        Fri, 25 Aug 2023 14:59:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0068be98f1228sm2025436pfo.57.2023.08.25.14.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:59:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qZeqF-006VO2-18;
	Sat, 26 Aug 2023 07:59:43 +1000
Date: Sat, 26 Aug 2023 07:59:43 +1000
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
Subject: Re: [PATCH 28/29] xfs: support nowait semantics for xc_ctx_lock in
 xlog_cil_commit()
Message-ID: <ZOkkT5Ai7wyMGcWC@dread.disaster.area>
References: <20230825135431.1317785-1-hao.xu@linux.dev>
 <20230825135431.1317785-29-hao.xu@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825135431.1317785-29-hao.xu@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 09:54:30PM +0800, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> Apply trylock logic for xc_ctx_lock in xlog_cil_commit() in nowait
> case and error out -EAGAIN for xlog_cil_commit().

Again, fundamentally broken. Any error from xlog_cil_commit() will
result in a filesystem shutdown as we cannot back out from failure
with dirty log items gracefully at this point.

-Dave.

-- 
Dave Chinner
david@fromorbit.com


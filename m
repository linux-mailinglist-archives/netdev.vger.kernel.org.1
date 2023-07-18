Return-Path: <netdev+bounces-18452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1BE757198
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 04:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756DE1C20B14
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2824215B7;
	Tue, 18 Jul 2023 02:10:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161EC15A6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 02:10:07 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA514E6C
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:10:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8ad9eede0so41621645ad.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689646205; x=1692238205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sF3UOV1H64xpOm9y1LJuIbQj9Ap6aDPxUDY6iD//qVg=;
        b=IMjQ9T1j1+nD50XSggvKpopEz6JfsMx2nWV9Hx0sm9w+aOBYE3irtKc3QS14KcsjOI
         BkCDYv3EBMzgUYRuof+os+oWiKyItuid6afZFt5k9AeswGCqxybT0dYnADsk+brfetSB
         0kF9kiOFmSwhijAZOsFghUi/cF3hPy6X+/mh9pPJ9zLVfgx/9synpm+kY/kCs7M+S7c8
         zSwwdx4OQ9G2V0QNoe70v4rEX3Ko2HMycLgVBFtCbCHzLhcVaCmnG0LpO/O2kBGYqGDn
         +yQcp6aeboRFuoJBTacHQ5IcVMCsV/wbV0RKW1aY5XK4JQqksd4Rm+xEKN7PFS0VFbhL
         MpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689646205; x=1692238205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sF3UOV1H64xpOm9y1LJuIbQj9Ap6aDPxUDY6iD//qVg=;
        b=ih8jeGFfJNTnRpPOeZLqhb+6JjDleLic7r/xpfl7SZZIMtMIk84eWo05l/J92J2raG
         B+I0i9YX5kum3nJ3pdxoRst6UTWK+03cUVQlXquKQpQenbXlTE2coq/bwOdzl2kMoU3p
         8e7fvpzQG6bd+ypBvQtvmQ1LfBNrBOibBhLDf2h6i2avLImCfJZrVKIqf+A0Xj5Znj5G
         4FXNUKZ4h5zHhZIAjqVWBh41iX5XLcvhHzVxaVH6RvZGz8IjLOh9e/zC0ubBcRRvZK95
         kJg8sCxjnzx68/NRfNj2PLI7/sC6OY7pixr++Mn++uBkhoMKV/A4m8r9typbIDpSwyOA
         ZCMg==
X-Gm-Message-State: ABy/qLZmiEew/E4pHP/9WLbE79CEjWdafu2ttb9zf0rEiNcDEdVFb6Lg
	FMzKeo96a1EuN9HY7PtH2uadgHwNRnujrw==
X-Google-Smtp-Source: APBJJlFs8FHI3vzSVDDANslfF0agT0aaXeVOkwG48T9YS5uMg7iI0QEadBSPX8P8F6k9aw717BZoaQ==
X-Received: by 2002:a17:903:32c9:b0:1b8:9598:6508 with SMTP id i9-20020a17090332c900b001b895986508mr19309782plr.18.1689646205246;
        Mon, 17 Jul 2023 19:10:05 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902968c00b001b9ecee459csm547712plp.34.2023.07.17.19.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 19:10:04 -0700 (PDT)
Date: Tue, 18 Jul 2023 10:10:00 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: selftest io_uring_zerocopy_tx.sh failed on VM
Message-ID: <ZLX0eKfTO4V28hj9@Laptop-X1>
References: <ZLS/iWz+gF0/PGyR@Laptop-X1>
 <2bf18f5b-9539-e706-b887-3de330950061@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bf18f5b-9539-e706-b887-3de330950061@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 01:34:04PM +0100, Pavel Begunkov wrote:
> On 7/17/23 05:11, Hangbin Liu wrote:
> > Hi Pavel,
> > 
> > I tried to run test selftest io_uring_zerocopy_tx.sh on VM, but it failed
> > with error like
> > 
> > + ip netns exec ns-45iLeE2 ./msg_zerocopy -4 -t 2 -C 2 -S 192.168.1.1 -D 192.168.1.2 -r udp
> > cpu: unable to pin, may increase variance.
> > + ip netns exec ns-45iLeE1 ./io_uring_zerocopy_tx -4 -t 1 -D 192.168.1.2 -m 1 -t 1 -n 32 udp
> > ./io_uring_zerocopy_tx: io_uring: queue init: Unknown error -13
> > 
> > Do you know what's the reason? Should we update the test script to return
> > SKIP if io_uring init failed?
> 
> I don't recall anything that can fail ring init with EACCES, probably
> sth in your system disables io_uring with some syscall filters or so.
> I think skipping the trace on EACCES is the right approach. Do you want
> to send a patch?
> Apart from that, if you're curious you can try to trace what's going on,
> ftrace should give an idea.

Ah, thanks for your reply. I just recalled that I also asked our storage team
member for this issue, and he told me I need to specify "io_uring.enable=y"
in the kernel commandline....

Hangbin


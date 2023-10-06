Return-Path: <netdev+bounces-38627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64777BBBC1
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 17:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A029A281C94
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C6727EC9;
	Fri,  6 Oct 2023 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzQ2P30H"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B7273F9
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 15:30:40 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0FE9E;
	Fri,  6 Oct 2023 08:30:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so21662385e9.3;
        Fri, 06 Oct 2023 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696606235; x=1697211035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I3c82TQumh06vWIwbRDa6r1GsoIQwjGbKt5vXDIgETs=;
        b=CzQ2P30HFOfKEGsyB5/XFp+3hxxi0dh0MeEzKSRHf8gnzhf+MZBzfhIqTJNU/q2H1Y
         YQYrCdLl9HhB1k1k6zVEDori+uzUjzbfQE6jn1Cwa8wHP8de7W17MPGsP8dh08Jw0fK9
         +ZotLkVY/TvyGBQlANcJ5pKw7LSq8c5JYjl6DiIuVDLqj4qj0Nq7htafA0g6A5SvcCz9
         CL/dOeX/6rKJIKWMCrszXUu48yLtckJXcF3yZ36P6m1Qv2nmu8/O3bwtqrDwrM4lbGP1
         YZnOcPjA8m2amGiHOIkedBVIDp7jPw4phG3SsHsh6TVpdlLyjJhFZ2ISCvp50mAaOASV
         /N0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606235; x=1697211035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3c82TQumh06vWIwbRDa6r1GsoIQwjGbKt5vXDIgETs=;
        b=vjz3xgVdnUdmLI3ji4DyDbcxt42BtenyWFTO3wQLu9RBdN9GpNyr+HaLR9LhZk596l
         zIDhLWGbZjRJ9PTGexC8Z90Crw87YjCjaF0fK7Kq+IlmasAzaXCAWtR6x2PY18y/oHRb
         NqkScUZyRimTugjz1vijufKLbrp5du6wPJYBDut5MU3YkXWsMB5NHddoSYS1ix/5ffKl
         BaFs+vWxNmhsMbUQI7FO7b+SqIOd/qrUy5icCePEQJE6feVdqT1zyN+sKLR6Ql8B7t7v
         tc/b7GQU2qPR5UcTTBjbTvkdLLvAcW2STvCcAg1CVef1xKDcvTViP3aiuKZRCnzGTq4p
         3Oow==
X-Gm-Message-State: AOJu0YxRyWAxgl38nJxdoQpQuhVdnyukH/+hqLPjOG9HpfRJy8pRfzIN
	J5Y29HVIXT9PoNdfqwx3ZGWOPS/1zR8=
X-Google-Smtp-Source: AGHT+IEa8xsqBPHQqp2wAhP91yEP0x8xXrYcu5d9meoWgs7nJt5C4R28dW32XmTynfkfrqxHsZAE8Q==
X-Received: by 2002:a1c:7c0b:0:b0:401:daf2:2737 with SMTP id x11-20020a1c7c0b000000b00401daf22737mr7557350wmc.30.1696606235095;
        Fri, 06 Oct 2023 08:30:35 -0700 (PDT)
Received: from babbage ([2001:818:e906:400:b2bc:40c:b83d:9c16])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b00402d34ea099sm6210733wmc.29.2023.10.06.08.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:30:34 -0700 (PDT)
Date: Fri, 6 Oct 2023 16:30:21 +0100
From: Ricardo Lopes <ricardoapl.dev@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
	netdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Replace strncpy with strscpy
Message-ID: <ZSAoDYYqgoXXV4s_@babbage>
References: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
 <2023100657-purge-wasting-621c@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023100657-purge-wasting-621c@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 03:32:28PM +0200, Greg KH wrote:
> On Thu, Oct 05, 2023 at 08:14:55PM +0100, Ricardo Lopes wrote:
> > Avoid read overflows and other misbehavior due to missing termination.
> 
> As Dan said, this is not possible here.  Can you redo the changelog text
> and resend it so that people aren't scared by the text?

Yes, I suppose removing that sentence and keeping the checkpatch.pl
warning output would do?

Thank you,

Ricardo Lopes


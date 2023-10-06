Return-Path: <netdev+bounces-38628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B577BBBD8
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 17:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F48728209C
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FB027EE9;
	Fri,  6 Oct 2023 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOJ7NcYc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3062F27720
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 15:37:06 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C652AD
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 08:37:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so1982954f8f.3
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696606622; x=1697211422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/urUhEVDb9b6U6nA5x5SbH6GwCmmMY65Q2l1I2ccds=;
        b=QOJ7NcYcFa0kNQgoR0RyonVx/ho0xtsyKOojeMspRc4xNhPP65tUpT9EItb/CCNeo4
         9l9U9R473s//cZKsj/GqGmcr00T91apif6cB9xiPzclZTnxcgZ6t/kmhK2X/N0y30bsS
         APj25lV6zpoQGx6wNBMt2c3n3K4HWYQoldM6BmTxMhtnMfIBSWTFJHxEfhFAsZfRrTwZ
         5Pbx12HNf9qV2YEIJgULV3q2RVX36tRzwKn9FFkpxsjXd9mILrue3RoRw9KJlavgHcKx
         zh0DwWrJMOj164ZONuRxUEv7JKC08gcnW7zcSoF8RSU3bKF4Js3do1zoRsmuh3iSlCzY
         v/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606622; x=1697211422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/urUhEVDb9b6U6nA5x5SbH6GwCmmMY65Q2l1I2ccds=;
        b=XrJX+VgXEAM2W0rwu4++4tfcbQaQ1JGIze8rmGWJlHYIInp4eCc81F929HH03CI6Bj
         VM6VNE+uTPLyRLx0W9adD6r7FnYeoyP8SWkq3861Tgye6kvG5i6aUNMMJFHJ1q54NGsL
         YkIQLDn+rY9Nj3QcPEbR/Hdcxc13vhIzLGcRlPbOAraPM36DIHY4hV8GGJiuMgWJVOBB
         OhrCK5saByAuSNvOAF+jksuvYW9+CHbetr9tqeroEtn5Uncy1+Xvx0m6kkMkS37KN8z1
         t6wLB3qGdR2iHDCaf7tmtjYYYAwcUMz28lDD03yDcyrtlN3kC/hO0+0ug9SHPeVlLG88
         mhHA==
X-Gm-Message-State: AOJu0YxbXvtF2zIBeXvCJiANvDE+0hn4DwvwYQh53pZMD9gVziuK3NPw
	g3ID78bzg74cgDDghZlcLE3gBw==
X-Google-Smtp-Source: AGHT+IFhUnnVEJUHmy1LCmhtDxaQkbgyka+3XLQF18Cyaq/blQPoPH0cdviXGeLDfUZ6BOOYmD2gUA==
X-Received: by 2002:a05:6000:12cd:b0:320:976:f942 with SMTP id l13-20020a05600012cd00b003200976f942mr7751664wrx.7.1696606621912;
        Fri, 06 Oct 2023 08:37:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c6-20020adfed86000000b003279518f51dsm1909859wro.2.2023.10.06.08.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:37:01 -0700 (PDT)
Date: Fri, 6 Oct 2023 18:36:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ricardo Lopes <ricardoapl.dev@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
	netdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Replace strncpy with strscpy
Message-ID: <9987d46a-ffbc-4a1c-bddf-084b17d14cf1@kadam.mountain>
References: <20231005191459.10698-1-ricardoapl.dev@gmail.com>
 <2023100657-purge-wasting-621c@gregkh>
 <ZSAoDYYqgoXXV4s_@babbage>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSAoDYYqgoXXV4s_@babbage>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 04:30:21PM +0100, Ricardo Lopes wrote:
> On Fri, Oct 06, 2023 at 03:32:28PM +0200, Greg KH wrote:
> > On Thu, Oct 05, 2023 at 08:14:55PM +0100, Ricardo Lopes wrote:
> > > Avoid read overflows and other misbehavior due to missing termination.
> > 
> > As Dan said, this is not possible here.  Can you redo the changelog text
> > and resend it so that people aren't scared by the text?
> 
> Yes, I suppose removing that sentence and keeping the checkpatch.pl
> warning output would do?

Yes.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter



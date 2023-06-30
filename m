Return-Path: <netdev+bounces-14871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CE27442BF
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 21:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972D62811A5
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4E917720;
	Fri, 30 Jun 2023 19:37:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A2174F5
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 19:37:10 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3333A3ABF
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 12:37:08 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b5e7dba43cso36491281fa.1
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688153826; x=1690745826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+Mkiq1H8AQsshdPHlngN5syzAkvmDSEm7qP0aIR3p4=;
        b=BPyVz6YCA3G7U+g+d1ik7sG4EXP9V6gMtYzhwdeNoT0RJrfpfFgLmH2ZCU6RrgqA4g
         o+6vS6SA8/heYQmjpXepvuGIL68gXYLAFzdxGUK0BV3T50IbwL3wCPcq/8Nfc/j/5UEn
         O7VZoIBuIgmIIvcpyBeIKmnN2bl0dUAt0E5ZTdwm7c3LJdV7kJRIG2Uxa9wB2YqknobY
         UglbEchlUKIuAgiJR641+aqsJP1XgAj8/oj6uDrBKQsoPqk5oO1WPsowpifIOzywaEm9
         Y83M8shMtvT1KoLkY2R1tGYGOQlYE3od5pkP/+Dtq9gOtqrmeYK7L+Pn2uoJah+YDW1H
         lPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688153826; x=1690745826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+Mkiq1H8AQsshdPHlngN5syzAkvmDSEm7qP0aIR3p4=;
        b=jA3W2lh/9onRGn7v6QTNGGwegN8BOpOheOHsZxbBZtWZcS4Uz4TWei47hzbQu0bm8i
         dOzFy/+SNz9kpLxBnGKdzLNjX6usEDBtbL0THzp4QA+iAl9jdZHctPvtFQByTFB83oXf
         jTMPDjSbAHvJpTfms8SSU3qN2l/aJw4DCTkBM6cJGDsxLcXH6pGutEGilV+gXldPeY5L
         mekVThJOZbijsE5/K6TDsRiA1AMF1w4scfyBa+aGNYBTCyntnl4LkVZgjRBLh9Lxu4/x
         GJuJ1FpO7TqojvMmhK9noU4LwBWIx0WZ6c8ZX3suHdMOSJ93xP58SKggQrg/fHwDM7Vt
         Op4w==
X-Gm-Message-State: ABy/qLZSBSouTg1JvzKC+nPUwWvGfOXIQ2Z5NDX6SuVYL/DP4yJ8mAUD
	6sDaUqNB6gIEw//Jve2iZJoR+c3lbBEZWA==
X-Google-Smtp-Source: APBJJlFEbHsZSSQ5+OVZFXWAx3oUk0JpzBTy2MI8H53jRUQyfUxbZqshp6J7iDldZN+vyQOb5PtN/w==
X-Received: by 2002:a2e:998e:0:b0:2b6:cd2d:388c with SMTP id w14-20020a2e998e000000b002b6cd2d388cmr2756738lji.22.1688153825953;
        Fri, 30 Jun 2023 12:37:05 -0700 (PDT)
Received: from tycho (p200300c1c74c0400ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c74c:400:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709063a5200b00988f168811bsm8370973ejf.135.2023.06.30.12.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 12:37:05 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Fri, 30 Jun 2023 21:37:03 +0200
From: Zahari Doychev <zahari.doychev@linux.com>
To: Petr Machata <me@pmachata.org>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org, 
	hmehrtens@maxlinear.com, aleksander.lobakin@intel.com, simon.horman@corigine.com, 
	idosch@idosch.org, Zahari Doychev <zdoychev@maxlinear.com>
Subject: Re: [PATCH iproute2-next] f_flower: simplify cfm dump function
Message-ID: <6duucu3iqlcp2idmncdakshwc6on7p5saj4qvlfb5zoqq7thbn@vqowawr7tgxm>
References: <20230629195736.675018-1-zahari.doychev@linux.com>
 <87leg1xkax.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leg1xkax.fsf@nvidia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 01:22:45PM +0200, Petr Machata wrote:
> 
> Zahari Doychev <zahari.doychev@linux.com> writes:
> 
> > From: Zahari Doychev <zdoychev@maxlinear.com>
> >
> > The standard print function can be used to print the cfm attributes in
> > both standard and json use cases. In this way no string buffer is needed
> > which simplifies the code.
> 
> This looks correct, but please make sure that the diff between the old
> and the new way is empty in both JSON and FP mode.

I have done that. The diff between the two is empty.

thanks

> 
> > Signed-off-by: Zahari Doychev <zdoychev@maxlinear.com>
> 
> Reviewed-by: Petr Machata <me@pmachata.org>
> 


Return-Path: <netdev+bounces-40968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D93A7C9357
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 09:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D8C2828B3
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24F4569D;
	Sat, 14 Oct 2023 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1Xq7tGv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D7D5690
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 07:50:34 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101B8A9;
	Sat, 14 Oct 2023 00:50:33 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d865854ef96so3165264276.2;
        Sat, 14 Oct 2023 00:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697269832; x=1697874632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPY90v//iOlz4xzjpngsgS9qOCgffU46A47kFOVCgRk=;
        b=d1Xq7tGvzHwtrc5cVOu6oEvaYl1fA6cWDci4gYfAaCR78S49p/y9E3GRZbGH6i69MJ
         YKM09rUr/8UDZHIE7Q4kZT25X+6XOtEr3B6/k6dB+n/A6LmNEB+Nccr0OLx+KGwG8Gzu
         BqswuSVJMUpf97zRaY2pMpswxsf7DjfHX/WsSV/HO+kKWHJgYsEjfL1djgh95RjLp5pl
         bDvdDQZzqio5nMjrzL+fvx1KGpt9gJnIg1B1SB7ASx1DOaUkVegFDTKeqImqA0rBzfJ/
         LswlbYXF3zs7ba3ZxC+uZ0Gl7X7dpotYk5QfcrkiA0UaFq/o/+n5httVIm3icB3lJm5B
         yMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269832; x=1697874632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPY90v//iOlz4xzjpngsgS9qOCgffU46A47kFOVCgRk=;
        b=oalxFj9QG4kZOt4I3F9m021br+0dWFvjYkCQNKvOHh9Uadg9F5MPrhA+bZklNbdqOl
         0/iXePhEvVzqkAcLAjCDRjDwbQw1v5PX2USyLSj5GNM1ttptISCqzNCldRwYLmIPvleo
         26zhdW0+1TlXsHvhnILRjBnhVf7hxNqbcz78P9e18Zp2tLthUh6h3olqg417dFMZ2acb
         Yh9XarjsCfyZUDpeXtIX+5Vn/7JTjZfTSiWf/gQyriOqUBFtKR24Ymsi2REqKEdTSd8E
         V+pBAzITHJPRFmTRM/oCaAjzqrEsPTtUgA/uUmUbp7AqPDW9URLC3D3+HBFfs1QE5koO
         lCwg==
X-Gm-Message-State: AOJu0Yz0x/3P0D2qZFJ890FJMTljLKHT6SYWAci7ZqQMYJwM9Dd5xXUX
	oB+osKBV3CWMwsmxKm/1N78=
X-Google-Smtp-Source: AGHT+IFht9Pdhs+YTaM4rxnXiM2VmkWzCxyw1wFLf+EfItgEJyZaPCjpLfoN989eNS/y3/xAN71mXw==
X-Received: by 2002:a25:c702:0:b0:d9a:c946:bb47 with SMTP id w2-20020a25c702000000b00d9ac946bb47mr6793962ybe.5.1697269832173;
        Sat, 14 Oct 2023 00:50:32 -0700 (PDT)
Received: from gilbert-PC ([105.112.18.68])
        by smtp.gmail.com with ESMTPSA id 81-20020a250154000000b00d7b8a1074d4sm1042967ybb.57.2023.10.14.00.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:50:30 -0700 (PDT)
Date: Sat, 14 Oct 2023 08:50:22 +0100
From: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To: Nam Cao <namcao@linutronix.de>
Cc: outreachy@lists.linux.dev, manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com, coiby.xu@gmail.com,
	gregkh@linuxfoundation.org, netdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: Add bool type to qlge_idc_wait()
Message-ID: <ZSpIPippZFtMw2aG@gilbert-PC>
References: <ZSoxLxs45bIuBrHg@gilbert-PC>
 <20231014065813.mQvFyjWb@linutronix.de>
 <20231014071423.UgDor1v0@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014071423.UgDor1v0@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 09:14:23AM +0200, Nam Cao wrote:
> On Sat, Oct 14, 2023 at 08:58:13AM +0200, Nam Cao wrote:
> > On Sat, Oct 14, 2023 at 07:11:59AM +0100, Gilbert Adikankwu wrote:
> > > Reported by checkpatch:
> > > 
> > > WARNING: else is not generally useful after a break or return
> > >
> > 
> > What checkpatch is telling you here is that the "else" is redundant and
> > can be removed. Although your patch suppresses the warning, it makes the
> > code messier :(
> 
> Ah wait, after reading Julia's comment, I realize that the "else" is not
> redundant at all. Seems like checkpatch.pl is lying. So ignore what I
> said.

Thanks



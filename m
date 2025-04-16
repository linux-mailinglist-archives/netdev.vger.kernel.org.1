Return-Path: <netdev+bounces-183230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C07A8B6D3
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E041902F0D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D1B1FE471;
	Wed, 16 Apr 2025 10:34:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B61BC9E2
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799667; cv=none; b=l6Yw2PiIszdfcVVKWs3cO0QryV2SCSKY12wMkWvlfwbEIvDU7LZDf7FzEm2Cxb0jHmX/OCOvArYM2jxbGxkodCy5NHuVqcaRGx5D+qG3jD9YClkhxgux+SBrU8HhHCY93VQHBJX+U8TEzHqGyCLo8/vk7FEj3LniuirRx24WsQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799667; c=relaxed/simple;
	bh=cH35qVjrcnkulPMSh0e8mOB5TGNIM8hCT14BHgdo2DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdRVe+GOj/oB8sZKtICaMU9MrBSd8FCRqQ2LsGK2YM0GomoWHvL//0W4IcNEDgXSZ5vSLRYT5q0aQ9v/lIzUxECerw0loc2gSt00feeWD93DTeo8rF9yEVjcHOTXre8H7upsRYHY87Aid2934Kb5MoBT6jyAPGGR55vlW/9eQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70433283ba7so62751087b3.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799665; x=1745404465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cH35qVjrcnkulPMSh0e8mOB5TGNIM8hCT14BHgdo2DU=;
        b=obHTFJvh8wr3e3aHq3TfCHpnQtSpB3QJG4L1ixIV6/JtAQ2A7/3QnqdQ3DTne6MEXW
         gO+10/TklaPWrdT4YLnGSXwiuJlhOaiqh6CUFBcQQQwceWr+94PpHv9htGPy30jkUyv5
         TuJskUfVWxLQXDd1o9BzUGZZuZw9lsGlzKVFzOHwsLzXtTnurCHnStyV5iIRc5qFAVjx
         0C+oC+GefSvl2Xt+Y/n8wRIV2sWe2LWjmtW2PwZbUhKcdMuN+TFV/WawyGCkDLazT9+F
         iMF2PmNr5l+v4ZA4EGYWPbtACBMYJW7FE9DVJ6aFEQXJ5D0C1jrRt7w898XxAUpu0lOk
         0RFA==
X-Forwarded-Encrypted: i=1; AJvYcCVuG7ccxTBSHMUDx9nRdY0sv1dXladrN/WFHeapDTfAA6lhIfaZeU8sxeJylHr95ges0RbTgEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbdLau17kD/6IYVS9nhGtnc2xUsqC822i/boD0zA03KA4yrpAk
	qp2jhBehCtb2iU1NxWirleQ08eai60Y4IHu7kVcxefB9BaXlA7UT2G4mq8nx
X-Gm-Gg: ASbGncuRStuNGNbMqli5b5TWFXK/KuWWpLnm+NYYGGTzf3NiKDZcgBqkWQgNh9kL+bU
	837vdd7YNBJf2nrFlvdvNNWPxJe4CfNHlhKZ7AXl/WOxDQfzPrW6jO36pWOiOrl0ARLsktG+l1q
	wTvUzmHUwqe5b3WNBAYHWHmvSnOyLnUUrwpmXVTZWG87Ottpf3LU73TbRcacru/JQlVW11HkBpZ
	6avW3Khzkb3jNA1CgeYR+YIXZ/WzCR82BLopNHY3hlv48T1C26tB+QnJPbT+nYQlJX8UHstlh7o
	N+rhJgRdoXBp76bClOzeijlf3x1AmKbqioCVbHWWjt/ASX4ilqFK6M0YbuL55TPI5X3cqysNGLr
	SJw==
X-Google-Smtp-Source: AGHT+IHaZOGqgzTYrjMgtPe5AC+PuWyX/Y5cIY5Iw2chZH0F5y9OvOj4MyWOlzvZ7RV40nxxojSxgg==
X-Received: by 2002:a05:690c:6809:b0:6ef:5013:bfd9 with SMTP id 00721157ae682-706b3276583mr18387857b3.10.1744799664668;
        Wed, 16 Apr 2025 03:34:24 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e37180csm40627147b3.75.2025.04.16.03.34.23
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 03:34:23 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e6dea30465aso5548925276.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:34:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/WRcavL9Ks8QMz7lN6ndIJt/okAXFg5gIj3ioQzPjVs8EBUwNAIxUAbjlhv4GpHrgyR5lU2g=@vger.kernel.org
X-Received: by 2002:a05:6902:138f:b0:e6d:df8b:4658 with SMTP id
 3f1490d57ef6-e7275e016ffmr1615820276.34.1744799663143; Wed, 16 Apr 2025
 03:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174471593618.5319.11061380619817212706.reportbug@localhost>
 <CAMw=ZnTZeodMmFFtc9ft39qMn2ffzM7jyWs_bqnp15_qmijYQg@mail.gmail.com> <9fc9360d-dc85-4486-a1a8-347495376165@debian.org>
In-Reply-To: <9fc9360d-dc85-4486-a1a8-347495376165@debian.org>
From: Luca Boccassi <bluca@debian.org>
Date: Wed, 16 Apr 2025 11:34:12 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnSZZgjN3asWLO9BvHTXDeiAf=Peo23sSvZRQbds3vWP=w@mail.gmail.com>
X-Gm-Features: ATxdqUGC8u4feNCRvZWx7_1aGnVGBsZY1hPCS7ELYMOoqNeTL6Lw69wjwCcdvMk
Message-ID: <CAMw=ZnSZZgjN3asWLO9BvHTXDeiAf=Peo23sSvZRQbds3vWP=w@mail.gmail.com>
Subject: Re: Bug#1103242: /bin/ip: "ip mon" does not exit when output is gone
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>
Cc: 1103242@bugs.debian.org, Simon Richter <sjr@debian.org>, 
	Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 00:06, Simon Richter <sjr@debian.org> wrote:
>
> Hi,
>
> On 15.04.25 23:35, Luca Boccassi wrote:
>
> >> I started "ip mon" in the background, and closed the shell and the terminal.
>
> >> The "ip" command is still running, receiving netlink messages and writing to
stdout, receiving EIO for this attempt.
>
> >> Monitor mode should probably exit when it cannot write output.
>
> > Isn't this normal behaviour? IE, if I do 'sleep infinity &' and close
> > the terminal, it will likewise hang around
>
> Yes, but "sleep" will eventually exit, and doesn't produce output, so it
> doesn't have an opportunity to notice that stdout has been revoked.
>
> And since the only function in monitor mode is to produce this output,
> it can just exit here.

I see - then this is more like a feature request than a
packaging/downstream regression/issue.

Stephen, David, what do you think about the above request?


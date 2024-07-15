Return-Path: <netdev+bounces-111466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3802931318
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1A3280DDA
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C101188CD4;
	Mon, 15 Jul 2024 11:29:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB31465B8
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042961; cv=none; b=o8Y3tGyNdacity2B9Jiz/CfysLJsB4dF47T8wg3t2bkA0V87dryDdQoUTQNFnb51uY7E8SLMH3ftNeWCKwrqcSNSlEw6IUdJ7mLU34fLVRBBeAwHIA2S2EgueK8Ec5hm4uUZ2xdR5pvX6iyYjDCyQhJzhnBqxDJZpcMiF/5SKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042961; c=relaxed/simple;
	bh=/Wg9Bwx5UzSAg49nSBeaQFr6oiEsAjYEDRog5ptG4Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL0Lp4uYJKvGuew+RlRLnN7iB+jj8xdkemixPWhRzpfBzYeifxJWmXuqs7yaefAUl3VJyhqUIEgXi+G+KZNvjLLeD/jUQuFllaua04aREIx4TelmiEg6i0yoV2Wv19ZEXpZuYd2mIuP05i5LlcFKon0m1l1V/hDuJBFVXDU78ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eebc76119aso47007571fa.2
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 04:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042958; x=1721647758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNXe5eFWgRVmYvF1FXndekoHf0mNH5gGNvXJ/aco47U=;
        b=ifAgk5FLwOP4AKf2G4WNESk0BmgohViQOwajBgev27I7QOQO7XXStcKpKhsE1jke1T
         Pr+wrrWLFl9rK+XU2D5qobcYDqD11F0idAOEl5Lf0hsc0dWdQmx6gynB1l/DC+jwG14m
         PPyFZhuYhAUtvpmeL0WKJaEEVCDRT7uClyLWGmbeg5hiTkj1cS9tNofRloAu5qzhsvJP
         Ohy/G4tcMjQP8Uygyc2yMCoUjtAc6kxyoO7Ycr6x4fAUIOG8HgErFdmp+cveA8Vr0ejW
         2AnB4iELj0dzUUJ5o5zd9nQrPoHgJ8svWXsiEFWJnEg3zUKujsIgvQO4EExduXUcCXVE
         nNjA==
X-Forwarded-Encrypted: i=1; AJvYcCVYS7CRMzjXYMaVs4p1UAJbTRNmInqu8JLBIYN1ePAVws+PziUN6WaMjUmuvv/H7Jd7WM6EJN7G25oraE9bcuJu8ZmI3rRG
X-Gm-Message-State: AOJu0YwPTg2ROnbEXMtU7p9IemTOtMi7/ph5z5szGpi4oEkX9XWxEa6L
	w8Ep3fPm3XTbLql1bGtouMzYhYA9iXNv82Jj8DD90xWuTpGceUxCiCSNzg==
X-Google-Smtp-Source: AGHT+IG755+7hsbhRlut6EmwkaH93+OxoNv3c67sNj2YFIIlGzGMFTj4yFRNE3y52trenmCy321NPA==
X-Received: by 2002:a2e:81c7:0:b0:2ee:8d04:7689 with SMTP id 38308e7fff4ca-2eeb30e5f12mr122983671fa.20.1721042957326;
        Mon, 15 Jul 2024 04:29:17 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59c51dc51b4sm2106648a12.30.2024.07.15.04.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:29:17 -0700 (PDT)
Date: Mon, 15 Jul 2024 04:29:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org
Subject: Re: net: bnxt: Crash on 6.10 ioctl
Message-ID: <ZpUIC2ESlEQP0PP1@gmail.com>
References: <ZpFEJeNpwxW1aW9k@gmail.com>
 <CACKFLikzwRQFJ+wbe5iRYimBmvAwDo2MCHS+unsvUH-=rw8wWA@mail.gmail.com>
 <CACKFLi=Au=9H_O4QtgUJ101NZHAW97DF+isGQ4OOsC3x6O5k0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=Au=9H_O4QtgUJ101NZHAW97DF+isGQ4OOsC3x6O5k0g@mail.gmail.com>

On Fri, Jul 12, 2024 at 10:02:06AM -0700, Michael Chan wrote:
> On Fri, Jul 12, 2024 at 9:03 AM Michael Chan <michael.chan@broadcom.com> wrote:
> >
> > On Fri, Jul 12, 2024 at 7:56 AM Breno Leitao <leitao@debian.org> wrote:
> > >         BUG: kernel NULL pointer dereference, address: 00000000000000b8
> > >         #PF: supervisor read access in kernel mode
> > >         #PF: error_code(0x0000) - not-present page
> > >         PGD 0 P4D 0
> > >         Oops: Oops: 0000 [#1] SMP
> > >         Hardware name: ...
> > >         RIP: 0010:bnxt_get_max_rss_ctx_ring (drivers/net/ethernet/broadcom/bnxt/bnxt.c:?)
> >
> > Maybe bp->rss_ctx_list is not valid.
> >
> > I think we can add this check:
> >
> > (bp->rss_cap & BNXT_RSS_CAP_MULTI_RSS_CTX)
> >
> > before proceeding in  bnxt_get_max_rss_ctx_ring().
> 
> I've confirmed the issue on older NICs not supporting multi RSS
> contexts and I will send out the patch very shortly.  Thanks.

Awesome. I've tested it and it fixed the problem.

Thanks!


Return-Path: <netdev+bounces-65823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BC683BDF3
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F6D1F2EB54
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B7B1CA90;
	Thu, 25 Jan 2024 09:52:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330A91CA8F
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176338; cv=none; b=gMRqZYL2YMFiebk5wztg9yWRpCUgZlZSy+BItyiFYkZ39Dz5KzOOeuTXGsgunCYkwNh3jrBw7RU6z61eVcsbM4vehSiipfAICsAdz3RwbYAANSBnkNoTDkbiWBZe6ONiXK5W3rjF8QjBjtJI3iP/9q/cpblhRRMqtQa5bqfKCTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176338; c=relaxed/simple;
	bh=oh+WEySTztPnO3+78993ZhtHZ3rxz4LPQdNj8y+YYtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNgxSIYnxIa8LkBf7H2eZhF9tns8ErCbvswSDYs9GEKbglu1Z5ASzQS8V8lv5BsluGQ7v14/GyXVmDoryleyts8lGt4XQvnqoJxUyLdzNAclrr0GzYr3dDdb83azNcPMSNL11T4Zy0FWhxZ4kiFu1EE+deBMMzDXf4popobXoBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso8383780a12.3
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176335; x=1706781135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3UM5f65UWDOfJVRgA9Gbxt3onZ1XoS/tyM95kCLEBk=;
        b=Ngr3Fu5BSWpp49xVoNTeBjNt9H6ZQVdSr8fW7nOi//jxCCoJJW46A+MBzMz18Hksih
         P73J7xqdiYV3sr+Z/oYSI0Vjgh2q6MMab3UUNB8wE5C7ysaxWFlOCJQxhdO8l31SJpyu
         q9RLf0E+ornqK9HtYBzmwNPacKB4pEXa024qBAdAk44pDvaruoM7vwNIRTKRgp4+O7nr
         QiAEMvVPSEEHTN1P6Ft1viazOdDRnNBjS9dK/IDIFsGK1FIKsx7322+6MsWyV8UlhsHu
         0+/VahH3fTfWYTiD4/iGWamkbvTYPM5OskxqVvZL5/nnGdDC9dOwA+l7GyHbGkr53Pas
         JsPQ==
X-Gm-Message-State: AOJu0Yw6A+VV/Z1OXlCs96B28cpMa88us2XvNns6iUHC9oVCgsBpoBQG
	p3k+vKbXdMYurEMn01qumShKDr1CjUWFz/5QlfAdDpWMWLt6jzSO
X-Google-Smtp-Source: AGHT+IFHju5PBX0CmyeYmW7g2Nk7xwqVofW2eZs8OPMQUR40jzQFUkVp3aol4m2mzZqUOsFBRfRsEQ==
X-Received: by 2002:a17:906:1c0b:b0:a2c:cec9:ec06 with SMTP id k11-20020a1709061c0b00b00a2ccec9ec06mr159845ejg.119.1706176335105;
        Thu, 25 Jan 2024 01:52:15 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-120.fbsv.net. [2a03:2880:31ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090613c100b00a2bf375ceebsm823944ejc.208.2024.01.25.01.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:52:14 -0800 (PST)
Date: Thu, 25 Jan 2024 01:52:12 -0800
From: Breno Leitao <leitao@debian.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, gospo@broadcom.com
Subject: Re: [PATCH net-next 13/13] bnxt_en: Make PTP TX timestamp HWRM query
 silent
Message-ID: <ZbIvTC7rGlUU61LK@gmail.com>
References: <20231212005122.2401-1-michael.chan@broadcom.com>
 <20231212005122.2401-14-michael.chan@broadcom.com>
 <ZbDj/FI4EJezcfd1@gmail.com>
 <CALs4sv3xWaOg63a3ZVPDSq8nf2E84XNNLC1L6fJe9zphuWpgYg@mail.gmail.com>
 <CACKFLikNDhvtd9-98eD+Ah1Cr7MH3GkE+N8VucwBhTqYarcv-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLikNDhvtd9-98eD+Ah1Cr7MH3GkE+N8VucwBhTqYarcv-A@mail.gmail.com>

On Wed, Jan 24, 2024 at 08:47:03PM -0800, Michael Chan wrote:
> On Wed, Jan 24, 2024 at 7:35 PM Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
> >
> > On Wed, Jan 24, 2024 at 3:48 PM Breno Leitao <leitao@debian.org> wrote:
> > >
> > > Hello Michael, Pavan,
> > >
> > > On Mon, Dec 11, 2023 at 04:51:22PM -0800, Michael Chan wrote:
> > > > From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > > >
> > > > In a busy network, especially with flow control enabled, we may
> > > > experience timestamp query failures fairly regularly. After a while,
> > > > dmesg may be flooded with timestamp query failure error messages.
> > > >
> > > > Silence the error message from the low level hwrm function that
> > > > sends the firmware message.  Change netdev_err() to netdev_WARN_ONCE()
> > > > if this FW call ever fails.
> > >
> > > This is starting to cause a warning now, which is not ideal, because
> > > this error-now-warning happens quite frequently in Meta's fleet.
> > >
> > > At the same time, we want to have our kernels running warninglessly.
> > > Moreover, the call stack displayed by the warning doesn't seem to be
> > > quite useful and doees not help to investigate "the problem", I _think_.
> > >
> > > Is it OK to move it back to error, something as:
> > >
> > > -       netdev_WARN_ONCE(bp->dev,
> > > +       netdev_err_once(bp->dev,
> > >                          "TS query for TX timer failed rc = %x\n", rc);
> >
> > Hi Breno, I think it is OK to change.
> > Would you be submitting a patch for this?
> >
> 
> Why not netdev_warn_once()?  It will just print a message at the
> warning level without the stack trace.  I think we consider this
> condition to be just a warning and not an error.  Thanks.

This is even better. I will send a patch shortly.

Thanks



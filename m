Return-Path: <netdev+bounces-65821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CDD83BDEF
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8003A1C230A5
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8731C6B2;
	Thu, 25 Jan 2024 09:52:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033651BF2F
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176321; cv=none; b=mpuvr/oL/dsJGt+wlkpBUs//8jy4onBvOir3V+4WpPILjyOquYLzVBEXioQWAFHNkmBAJ3mNDfEg0PyjUkp6uFFR1j6Y8EK5f7lvLzxwziX0igyo2pFonL5b4Y4FnGgmcabTtvjrpGW6R+EUoQlQb6tTErd746ziUBbEsYbNv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176321; c=relaxed/simple;
	bh=0ZTW4a1bQ2OiA6LA5EpoPRlyj/RHJspj8XATgyLrU0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdPwHWwvgFP4VMPVH9aphE2XPHPXq981SqlSAa2kkoaMQQYCL9BJuw38kiXx0s8TpWzB5sPo0/U20yK2QmWJyGqayrhfGnNnn03S9FkJKCOw7vlcNlpZDaBKH23Y2OrY7OPDdQitAOqw13P1a7PyDJc7C6l+0HDzG2GBS9OdM80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2e0be86878so103811566b.1
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176318; x=1706781118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYgzBlcJnu+v9spDBmTEjXD0OAEIxBQnl2jQO2RurBM=;
        b=raa9++Kdi2WAQuPOdXpEZVFHumR7M3pXfKLNILnlFFN/4KL2WVWT1gjtjJlKhC/H7r
         BBbvg9txoa6EPpeXYP9FgQ0R1IUa+C//GlDspW+94yzqdJlHVz45yQ9D31LleuDLJs5d
         cN2g0Co/eGO86okr2BO4GAXCdUAP1tecwn+DRIG0vdemlg0d0A2W9Ukr+LMaYm3ZfW9y
         9djkDFGcI23JJQAC6fF9hrd76J73ojzRmmT9cZRjYxc1O4EszVfZFHinK0RFJ3lIcFzl
         1OjeXcoXd5Rcz5r5FimyLB/6R6n+TNsE4/WHRPyBsO3fzkHs4Up4OdK7GejftkuWJMnb
         A2YA==
X-Gm-Message-State: AOJu0Yw0H5YyEfHmPjJVNSb2J8+7yjZIbsOsgcxUUhSqfZOj8tM8T0M7
	oz8iltGKM8vK5YLvEfAJs6mJ0WK1v/gNL8OKPk3BOtViFL5gClPz
X-Google-Smtp-Source: AGHT+IEQsMzTWJY02VKGQBU4XFzfvqzBMchQuFLksqsximxiSyuACebACssJ4w9QdkyJ5gZ7rEA8HQ==
X-Received: by 2002:a17:906:3a88:b0:a28:c04e:315b with SMTP id y8-20020a1709063a8800b00a28c04e315bmr685180ejd.13.1706176317799;
        Thu, 25 Jan 2024 01:51:57 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-016.fbsv.net. [2a03:2880:31ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id cu15-20020a170906ba8f00b00a318cb84525sm255818ejd.216.2024.01.25.01.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:51:57 -0800 (PST)
Date: Thu, 25 Jan 2024 01:51:55 -0800
From: Breno Leitao <leitao@debian.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, gospo@broadcom.com
Subject: Re: [PATCH net-next 13/13] bnxt_en: Make PTP TX timestamp HWRM query
 silent
Message-ID: <ZbIvO+y+Pbnni/3N@gmail.com>
References: <20231212005122.2401-1-michael.chan@broadcom.com>
 <20231212005122.2401-14-michael.chan@broadcom.com>
 <ZbDj/FI4EJezcfd1@gmail.com>
 <CALs4sv3xWaOg63a3ZVPDSq8nf2E84XNNLC1L6fJe9zphuWpgYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs4sv3xWaOg63a3ZVPDSq8nf2E84XNNLC1L6fJe9zphuWpgYg@mail.gmail.com>

On Thu, Jan 25, 2024 at 09:05:39AM +0530, Pavan Chebbi wrote:
> On Wed, Jan 24, 2024 at 3:48 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > Hello Michael, Pavan,
> >
> > On Mon, Dec 11, 2023 at 04:51:22PM -0800, Michael Chan wrote:
> > > From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > >
> > > In a busy network, especially with flow control enabled, we may
> > > experience timestamp query failures fairly regularly. After a while,
> > > dmesg may be flooded with timestamp query failure error messages.
> > >
> > > Silence the error message from the low level hwrm function that
> > > sends the firmware message.  Change netdev_err() to netdev_WARN_ONCE()
> > > if this FW call ever fails.
> >
> > This is starting to cause a warning now, which is not ideal, because
> > this error-now-warning happens quite frequently in Meta's fleet.
> >
> > At the same time, we want to have our kernels running warninglessly.
> > Moreover, the call stack displayed by the warning doesn't seem to be
> > quite useful and doees not help to investigate "the problem", I _think_.
> >
> > Is it OK to move it back to error, something as:
> >
> > -       netdev_WARN_ONCE(bp->dev,
> > +       netdev_err_once(bp->dev,
> >                          "TS query for TX timer failed rc = %x\n", rc);
> 
> Hi Breno, I think it is OK to change.

> Would you be submitting a patch for this?

Yes, let me send a patch. I will follow Michael's suggestion and use
netdev_warn_once()

Thanks!


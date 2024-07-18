Return-Path: <netdev+bounces-112130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6129493524C
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 22:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0D61C20BBB
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 20:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73833745CB;
	Thu, 18 Jul 2024 20:02:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49CC69D31
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721332953; cv=none; b=Fo9bXg5rK9yu2IkZ5bRQ6uqlY58JuMDybXUpCNJtyGaVUc1mxmP0mqEUf2zDK19dHRHgRvPOgjqrerND/I2hO+7gjeA5Zj24vDrG21w/1bEFt9HqBJM/czss09h19Ze4K9F5n5wIUzFrsVM7ZGH1z5t0TWTmHOmdGa8UEy7SunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721332953; c=relaxed/simple;
	bh=7JCZwAJ4XEtVVJSel4LDYPjxDmRXoGQ+/zskSBsbTt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edyVp1ulTej65byiEQ/7tVpZ85rULWt25N9c4nlyms2XO3LY8lrf6LjktcQYpPiDINOHzO9DES9NRTzzOE881SFEqfImET1UarFlwsOPRV/rkkVWvFVckuRPEowT5kFLgM+Ou4+7Nh8H1RkTTZ0ONfub7T283qfwaLUe+TmSAgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eefe705510so14311091fa.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721332950; x=1721937750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV3E255lhFXFGo9mt53fS35RfMVjcwBwH1TjGSTkwNk=;
        b=euR1FUligvWrLlfe/VgaYqcIaQf+jVj0eXGupgYv3BD6pjdTBOZ9eRkEpah1mjQKeN
         x3r+93YdJyA99jgoNa+jEM19XjOSBYeJlqTZde9uRTuo5nOND770M6pjQ8kDAZjG/1ZN
         QLAdTpP/buhhmsJdZSlAS2NFgnIv5EupIR7YQuuRbiyuSqRBU/mULvtfKPo+YmQVOeKg
         B+K5l4FjRlYbcqM9dO67W0YEHekTVSbO+8hwe37zA8z54YysKkxT6MLkLKgGZhuouItf
         bjavwy1OmD3/DEBuRgTtMHdD70SUfsyeYEXtAuqXoihPat1wJoA19ydFkGj/OqS/9paK
         6Uqw==
X-Forwarded-Encrypted: i=1; AJvYcCWstOpq6weI8alEc2BtZHLN1Ldmr5/pQo+uK1lsZ3JrPdM/3OtMDMic1dun+4z78Ab3uLCvqC9534N8tcuX9gIdJqGAf2iC
X-Gm-Message-State: AOJu0Ywc4EvThS0ARvrQyDwItHXW0bhkD+ORU8kVKaH9JWZuoJSHm999
	AozjP8HRBWXXghS4tK1k4CMFZ46wBgSq/b7sNspkc8G4NDJhz01u
X-Google-Smtp-Source: AGHT+IHpTF7lxwahqGtImAuokLPoqjbwpKmdjke1GDRTU+b9U777emdC8kw/yI67ie8D2yFxI9YAQg==
X-Received: by 2002:a2e:3c0a:0:b0:2ec:56d1:f28 with SMTP id 38308e7fff4ca-2ef05c9ac73mr22818301fa.26.1721332949940;
        Thu, 18 Jul 2024 13:02:29 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a2b866a0d8sm258166a12.82.2024.07.18.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:02:29 -0700 (PDT)
Date: Thu, 18 Jul 2024 13:02:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Ken Milmore <ken.milmore@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: r8169: Crash with TX segmentation offload on RTL8125
Message-ID: <Zpl004GjvJw3A3Af@gmail.com>
References: <b18ea747-252a-44ad-b746-033be1784114@gmail.com>
 <75df2de0-9e32-475d-886c-0e65d7cfba1e@gmail.com>
 <20240522065550.32d37359@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522065550.32d37359@kernel.org>

Hello Jakub,

On Wed, May 22, 2024 at 06:55:50AM -0700, Jakub Kicinski wrote:
> On Fri, 17 May 2024 15:21:00 -0700 Florian Fainelli wrote:
> > > The patch below fixes the problem, by simply reading nr_frags a bit later, after the checksum stage.  
> > 
> > Yeah, that's an excellent catch and one that is bitten us before, too:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=20d1f2d1b024f6be199a3bedf1578a1d21592bc5
> > 
> > unclear what we would do in skb_shinfo() to help driver writers, rather 
> > than rely upon code inspection to find such bugs.
> 
> I wonder if we should add a "error injection" hook under DEBUG_NET
> to force re-allocation of skbs in any helper which may cause it?

Would you mind detailing a bit more how would see see it implemented?

Are you talking about something as the Fault-injection framework
(CONFIG_FAULT_INJECTION) ?

Thanks
--breno


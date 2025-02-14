Return-Path: <netdev+bounces-166395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BF5A35E6E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B3016F04B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039CD2641CB;
	Fri, 14 Feb 2025 13:05:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D99F507;
	Fri, 14 Feb 2025 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538324; cv=none; b=fIH2SdtnjadkeaItSBtk2yDbcle7NIAyLuioi9slrKsZGSN1vPwpHFDD4mNOxlkP4zaDnTJ2mE7S+CxMAM5yioI6GJlLxh+C4Y+fkX0x+RKh88eSMbNLwF0PViEbOJ9I+yNvGcglsYbYWXK7YiY3ZiJzPiFKkPN8DrkTOKyhdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538324; c=relaxed/simple;
	bh=TExxYGL2g1GIs+G42A58gEs8Fv/48l/Y6gh+XSSRzPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNde7hBeC86W3p4p+fdbQO8bAv3rMcnFR3JzfNVLinH/vGGLEwgtQQT4kdeDXysNkPG9NRvU9xfDvRtXKFyY/GCl+POkTBk4uDDZM4hucgNMwmKMMjCBqrE7jxDGGFkZ+LCnyxqJwiZB8Dlft8FB+Mhtm6ri5qloDWb5eSOakIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7c81b8681so351752866b.0;
        Fri, 14 Feb 2025 05:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739538321; x=1740143121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00ZjsPVy/ck54B3KQOxyx18bQduThNAmRPFGnxfYcmw=;
        b=TyqRukQriF47yBO/QeZSRm+fICR613qn9Ic5asOGnJ0142kWEylcb121OUIiBrWdsO
         E1Gy0Klt/3SQQTfHdDZ4Lsp7DjSI/2CoQtfnRBr8mM6VFqnDqZtW05k/ReL9CFae3d9x
         rCif7mDzrUiz4WIg04wnPy0xAOfAs4ljxRxx9UWq7VOFq3FINHsq+QJEq9q0fQht0o3J
         Y+RdUKM9JiBa8YysC9tIUjRhbXXOqNxSeKz0Ykepnkkn4fwrIYty+uzZJMg2DFkYSiOY
         ICamVPD/eCJ18UOHk1940nIiu6qNP8dSqVHki4lyBLnW0a4n31vRAQS1qyy04hAGO42J
         je0A==
X-Forwarded-Encrypted: i=1; AJvYcCWNs4hfPYvHqjcs/aB9hop1j3NtMBXO3oJFDY5BQmPOiK/lkTb2zimntcwsO2jrTVNFAy3ZHjEx@vger.kernel.org, AJvYcCWkKZNb8bt3IuQsSPBSEzGZnf8l4TWSM0uY9QXwHhnQGiAdpj8B4q/KK4iVPTPjBTbq3Yq0RnKP9B6oWFc=@vger.kernel.org, AJvYcCXaGO0rqeR6MTWClseOFpGRgZOZvr2ASWyDdLNBkDy1X7KrhiPGgalcO0ER9P9siOT2Eg0vzXfPb7Hn@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8bY1Qn58blH37BE6ClCVmigvbBHjcyCfveJXiuKdtm/aCxe2
	AnWid66DWSuTC7b0KwrQFXk/sp90bneI73QngHaJ0Vmd1QK70kQZ
X-Gm-Gg: ASbGnctoTCsF1g+/dPTrS90r5/z3WKx6sQbvKHzuSLsX1UsYMV59JJs+b6wu6vDRQXU
	0tBhEQsy7e/MfY9h24MBjqflLfWXC3L5jJXGuZlPrWeXLEc4MRbF0Tatdjr/hKgnBbEhd1dsp03
	NwasiXbgIHTzZWk/u8OKR8TlY9BAhEz5cGGwoni7IhO7NZZ+QLktT7cOsRFomw+Ii0V7FtylEJZ
	gtGBQ3KPfq44NmzJhlMzuMBI/wo83rEvWBjgvVbn7wVbNRvuuL60oZDmqHoYz+SzDdEPkBI1WIV
	nwzO5Ac=
X-Google-Smtp-Source: AGHT+IHQk+IPmCfAJHCjcco7sECqNGd7fWJltlvwAvnfYmj/VMo7R3fuWFr2fvA/4EBMwe1nk5M9vw==
X-Received: by 2002:a17:906:dc91:b0:ab7:c4db:a044 with SMTP id a640c23a62f3a-ab7f3714983mr1158317666b.8.1739538311827;
        Fri, 14 Feb 2025 05:05:11 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270967sm2885102a12.55.2025.02.14.05.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:05:11 -0800 (PST)
Date: Fri, 14 Feb 2025 05:05:08 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <20250214-belligerent-invaluable-nightingale-cd8d95@leitao>
References: <20250212174329.53793-1-frederic@kernel.org>
 <20250212174329.53793-2-frederic@kernel.org>
 <20250212194820.059dac6f@kernel.org>
 <20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
 <20250213071426.01490615@kernel.org>
 <20250213-camouflaged-shellfish-of-refinement-79e3df@leitao>
 <20250213110452.5684bc39@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213110452.5684bc39@kernel.org>

On Thu, Feb 13, 2025 at 11:04:52AM -0800, Jakub Kicinski wrote:
> On Thu, 13 Feb 2025 10:14:02 -0800 Breno Leitao wrote:
> > > The problem is a bit nasty, on a closer look. We don't know if netcons
> > > is called in IRQ context or not. How about we add an hrtimer to netdevsim,
> > > schedule it to fire 5usec in the future instead of scheduling NAPI
> > > immediately? We can call napi_schedule() from a timer safely.
> > > 
> > > Unless there's another driver which schedules NAPI from xmit.
> > > Then we'd need to try harder to fix this in netpoll.
> > > veth does use NAPI on xmit but it sets IFF_DISABLE_NETPOLL already.  
> > 
> > Just to make sure I follow the netpoll issue. What would you like to fix
> > in netpoll exactly?
> 
> Nothing in netpoll, the problem is that netdevsim calls napi_schedule

Hm, you said the following above: 

	Then we'd need to try harder to fix this in netpoll.

I was curious about the meaning of that statement?

Thanks
--breno


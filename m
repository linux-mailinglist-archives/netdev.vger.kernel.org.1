Return-Path: <netdev+bounces-157156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DFCA09178
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA7F169CAB
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034A20C472;
	Fri, 10 Jan 2025 13:07:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6625520D4FB;
	Fri, 10 Jan 2025 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514451; cv=none; b=R8wopxIw9C4bNTZf5PdK2AFQfCFfuUHgKEgCPPY74GD73i6KmhrzYsRAqGuLSWGhnf6MXsxWLX9qMpc3w1fDyqglWE4/KSdKjJ7tYkbwFzmsmbK5lNFocMVLB8/Bnz7gR5kpdfYTimvIN8K30Pv1OUKO94EWbtIAu0E/e8Dd7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514451; c=relaxed/simple;
	bh=iGOwrTxp1iwrWsEtxrYr0QhuHVgZQGTuHNCLHmY5KNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szAn+IADfj0W37Lh6KDAidXxIUlyS5Rv3v0d1Sy4OHNqXcckT8dR+xh8YIhSP/qfhMboy9b+tMo1dFGVKlzbrqtYM+UHQQA79HcBa7ZZC5ZqdlLohk+Mv98UG7V68FrFlrfZevLw97iBzhjI0qb40XcvRY36DQx9c3V7seX3tlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so413741266b.3;
        Fri, 10 Jan 2025 05:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736514448; x=1737119248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZTa9SRy8e4uUiU834dj+GSJNNuY8KbOwXWTK1jw6cw=;
        b=mFLwIinq6mLedflnmdznhe9ZD7E50EBZhwP6n3eoJh6NJc+tN6HwzOA+t4hP59IVmD
         C3lfXuU6Pch2t0juF314hEl2zcFZQQqHyL6dNS1zBXzeS7Ziiwv+iH2pgYHvHoUtg/+F
         ThAIqePNkaqeAU4/eZ4cDG7wA16r6U8zMa/3A9mV7YpI+MNXTEMUnYmXLdxb2u8ZRARQ
         EplYLj2e4VCXw+LZAfIpurvAIgtr05u0z3m0Qyl14zaEZtivBDedjefHVAmNhGLkKafa
         RV/tKcDP60kh4lke9qSqTZy6DCYYHTIeNREjzvgYcDyRFXrgKkvX8dMRx5SEK1MnC42p
         zcCA==
X-Forwarded-Encrypted: i=1; AJvYcCW0sxCfPN75bTiQ8Ez7//ruFsdFIXDLe4exI7Hbv3h9R9kIoQ//SItC6AMRCQjAQNLCbJAK3Ull@vger.kernel.org, AJvYcCWgV+Dfjmhgihb6WgfruZVp39KKHjE0nXPPT2zBSDFYpJyi5YFCc24GtPfxWJG5IP29ldOGN2F3NEMEWRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcF/vcL+QXKeH9AJsNZZyi1lc0zhckMuFxiBdS9uJ2rVRgrR6
	WXawijcOHPZ2ZATxgxug3alweIWrhVUs4IwHqtNNF1oNuZJ4CdiD
X-Gm-Gg: ASbGncu2Lv5cB4Pzrwi3PTF8WxEUOammgRz/VgjoskGb1SpxStzFJxr1HOzXL3tkamm
	uGiDAPcyS7hXWZb9EI0RRKujoQdLG+ikUvA/k38dN4q6ryUJfmHJnZpoGOT+neNzXUqKTAZHzGs
	6rjXK5topyL1H+SdobJSnC2luouuk3oql4QH1BkeG8TZ7SgBfDds3taRteDVi5C/RZsMzuggwnu
	aOWjIJodpV/482BzXcURqA06vHgGwRxNUZAdEv3Yzbh1PU=
X-Google-Smtp-Source: AGHT+IEgvYDEnIPshGw96I+Ux8ECjgHbRJMmCaQ5VDza5/5523KmXoNgYfEXTmdWQufxGFigK3wN3w==
X-Received: by 2002:a17:907:9691:b0:aaf:ab71:67b6 with SMTP id a640c23a62f3a-ab2ab73c487mr944591066b.31.1736514447434;
        Fri, 10 Jan 2025 05:07:27 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90db325sm167404666b.65.2025.01.10.05.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 05:07:26 -0800 (PST)
Date: Fri, 10 Jan 2025 05:07:21 -0800
From: Breno Leitao <leitao@debian.org>
To: jsperbeck@google.com
Cc: John Sperbeck <jsperbeck@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH] net: netpoll: ensure skb_pool list is always initialized
Message-ID: <20250110-wildebeest-of-optimal-unity-06c308@leitao>
References: <20241222012334.249021-1-jsperbeck@google.com>
 <20241230175707.5e18ae96@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230175707.5e18ae96@kernel.org>

Hello John,

On Mon, Dec 30, 2024 at 05:57:07PM -0800, Jakub Kicinski wrote:
> On Sat, 21 Dec 2024 17:23:34 -0800 John Sperbeck wrote:
> > Move the skb_pool list initialization into __netpoll_setup().  Also,
> > have netpoll_setup() call this before allocating its initial pool of
> > packets.
> > 
> > Fixes: 6c59f16f1770 ("net: netpoll: flush skb pool during cleanup")
> 
> The fixes tag seems to be off by one? Wasn't the problem was introduced
> by commit 221a9c1df790 ("net: netpoll: Individualize the skb pool") ?
> 
> Since __netpoll_setup() can be called by other drivers, shouldn't 
> we move refill in there? Since the pool is per np?
> 
> Optionally, could you extend the netcons tests to exercise netcons over
> vlan? I think it should be able to trigger the crash you're fixing?

Are you planning to resend this fix with Jakub's suggestion?

Thanks
--breno


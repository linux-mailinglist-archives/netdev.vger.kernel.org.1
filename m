Return-Path: <netdev+bounces-183725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B96A91B1A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018E51798A6
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91223F410;
	Thu, 17 Apr 2025 11:42:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB2112B93;
	Thu, 17 Apr 2025 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890152; cv=none; b=SyXHhsDCdbq4dQGw/h4XDttT+tdtasd/PR7wuH9eMr3/FS+YSVz9lqIIhNI5LWa95aswxvbyyCc3do1I+vti69D4xrjwKmKW0CfkdivaqzeoCzgNscGj1Thqtvn4nlDEmldXDmWChAipvYJfMlhR/tKydN4zxAxTjPAo7kgLoIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890152; c=relaxed/simple;
	bh=CPd0GCM24ayWy7MHkJZn7zbc5mTFXULN2Z19tNHvWxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFOCSl9tR3o/tkfRlpk4r8bgrMEm6//DTHKD9lwDXbaSUoY9LT1d3o+4Hlb6dGAt1L1QxvN/bO+WvR0ZpabZHxj6DgwG/DRfroxWL/SL/INT83MN7KAEzh9Fqbr6KcqXKO574uPXIaxwNlVqaoNYH+T3kUwtex/nmDYbG24xFUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f6214f189bso102114a12.2;
        Thu, 17 Apr 2025 04:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744890149; x=1745494949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNx+ddNaE8eAigdlhQFQqI5NmsEB8TR3H/8O6yqaYoY=;
        b=AxcvRqekuxoyx8I2ET88pZckSYxNrJH3eJwZtvYXDxI8DNabz/Sg8amasYDyHN6Fal
         MaEVfzn9cnty2ySgadWVsLbMpgFFfMe7wLpMbB7VyvJ/HGl8jmKsIybXcCIsRC+aUqkK
         z9DhnmsQgEzL2HXFsnMrWZb8Og2ex0HHcDRqrak2iONO/S77nLupwgI+yCYgAlugAu4j
         AD9i5yn8ixEEm+cuWNkasyKliPEi6Yipz8dTH/5tDki/gFBBOLgCglBjA+l4+hAZG6FG
         /Rc6TmLPBG8+y+coQ3/odv2MsTgNtXuo56pFE86X6uHEroTnvQWkihtlWLa4mMAnnpzM
         EgIw==
X-Forwarded-Encrypted: i=1; AJvYcCU2bDGwCdTyqrt27T738zygAHMi9iTKUluq1IJKBPK1bC9Ha4Gg/Riwb1Wc2SK2MHbjU75IgVD+79UJ8uA=@vger.kernel.org, AJvYcCUPAlMWbAINt5PKVf50tllto7f0DR5HY96WMIISemGadqNeZ+EN5qC9WAYe0aUcwXy2Y+zLol8ve2CM0LLyHHTh7CWn@vger.kernel.org, AJvYcCXYYbTd2LrS1x0FzmC6hZMMuTEdRiMCgeDwW4pG1UrMSO9lpfs+xyc7b2NrdT6jZnES1Nz9Z2UV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3AI7cqJW3O13egOXS34Z5A2pgiSXHqEy58kzrkvVbwJscEK7
	Z7JLo6lwNRUhjdAyESll70d2Yvpq5jKlipFmBlGz1BIZdGtXjmAr
X-Gm-Gg: ASbGncvSxwBwJWegjpsms+ZsTOEgTaYADNHuOOKBsOkIEEcUhr60HhStTD9eVdYQvu7
	xL6dDSAujkcd43+P3IY5RbkgqASaKtHSU1lzYwHYBhyQbuD1FuGW/aCkEHJFq5EXaTSMjtGLqAw
	Gw5b6jT091I9QmQCXO6mNWjJ4DdODMTV1LLgWnoPzG1sJQQFJMt/HoMHNO6IC7wkjDn3cxFlos2
	+gObUe74Bnpz5zCXEklyRzgMuqgsEwRt7Zw/8SvFAkqy7JuaoSnduxe4EFA49Yb5Xu6eJcFOh25
	ogAQppY+IQptszmRwhGfSvEO0v40dv+H
X-Google-Smtp-Source: AGHT+IEG0nj7+X986PDK+2BfnVdeZrPBCfuj9lz9dnbQeJQ31uRdMJIwqLMlUkT7HUXaNyl+5avzQA==
X-Received: by 2002:a17:907:7da4:b0:ac7:81bd:60e3 with SMTP id a640c23a62f3a-acb42a4ae8cmr493942966b.27.1744890148912;
        Thu, 17 Apr 2025 04:42:28 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb5f3006a3sm90684666b.151.2025.04.17.04.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 04:42:28 -0700 (PDT)
Date: Thu, 17 Apr 2025 04:42:25 -0700
From: Breno Leitao <leitao@debian.org>
To: David Ahern <dsahern@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, kuniyu@amazon.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, yonghong.song@linux.dev,
	song@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Message-ID: <aADpIftw30HBT8pq@gmail.com>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <4dd9504c-4bce-4acd-874c-8eed8c311a2f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd9504c-4bce-4acd-874c-8eed8c311a2f@kernel.org>

Hello David,

On Wed, Apr 16, 2025 at 04:16:26PM -0700, David Ahern wrote:
> On 4/16/25 1:23 PM, Breno Leitao wrote:
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index f9f5b92cf4b61..8c2902504a399 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1345,6 +1345,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> >  		connected = 1;
> >  	}
> >  
> > +	trace_udp_sendmsg_tp(sk, msg);
> 
> why `_tp` suffix? the usual naming is trace_${func}

I got the impression that DECLARE_TRACE() raw tracepoints names end up
in _tp():

	include/trace/events/tcp.h
	DECLARE_TRACE(tcp_cwnd_reduction_tp,

	include/trace/events/sched.h
	DECLARE_TRACE(pelt_cfs_tp,
	DECLARE_TRACE(pelt_rt_tp,
	DECLARE_TRACE(pelt_dl_tp,
	DECLARE_TRACE(pelt_hw_tp,
	DECLARE_TRACE(pelt_irq_tp,
	DECLARE_TRACE(pelt_se_tp,
	DECLARE_TRACE(sched_cpu_capacity_tp,
	DECLARE_TRACE(sched_overutilized_tp,
	DECLARE_TRACE(sched_util_est_cfs_tp,
	DECLARE_TRACE(sched_util_est_se_tp,
	DECLARE_TRACE(sched_update_nr_running_tp,
	DECLARE_TRACE(sched_compute_energy_tp,
	DECLARE_TRACE(sched_entry_tp,
	DECLARE_TRACE(sched_exit_tp,

But, I am happy to remove _tp if that is not correct.

Thanks,
--breno


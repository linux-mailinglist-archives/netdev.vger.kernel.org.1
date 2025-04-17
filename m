Return-Path: <netdev+bounces-183724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358F6A91B03
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939363B7124
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744EF2405F5;
	Thu, 17 Apr 2025 11:34:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0C2405EC;
	Thu, 17 Apr 2025 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889699; cv=none; b=NLZ6p4ny0PI4Fny9L0mJpgS8w48ol7BKcAo9ITcT+l7zTdaXnzo05QNAXLho+jxSkRPoTF6jobfTGGQum6/lhTu5jwzJOW+KUzcC7kmQI8WWm1o+Cd1lGHnEsvCRrYMJwhaq37kRWj/BmpIhyLARAloi12RPJRdUCvy3/x/vMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889699; c=relaxed/simple;
	bh=P6H/9oIh8YwXto1XwjWJZ8GncpyhQgEz+91HEHPpqTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoaYU+xdTDZ9LbymwEZyzPDJieRTF905taNuhIqfUFnPUY+lTnSe56rDC9SzSzGDwpP3gCqtA56aK7sdGiUr4kP0pp0tyrGKff0/+jpSMdMZv/0rhL7SQqTxFVH6KBCCjb40WlkoqZ95x+8D/hiERJEc1VK6GEVlcaZjvuRKM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f4d0da2d2cso1392072a12.3;
        Thu, 17 Apr 2025 04:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744889695; x=1745494495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIUvErEBIpRI5tUBQJkvsPSXYol1UJK+nMELoBrMmZo=;
        b=vdh/D9pOmRtYfNhmrmTueJEOZoT0SSo95LCmzk1aieq5viC3PbgKgPQP7V2kUk/UWq
         wI9+y6fA3Mn7Kp8dBzIzfHOL1QWZLYAp0+HJUruK+gI7NHBwErIeE6rN6nFnsxFAOsel
         vhO+6vEi6H0kh3dGnnhEQVuq18a2m0UYPsr4+AoUd6zU++G2IGFxfCPeir5ZAgx/sTIE
         hCTSQIGThKF5Cu/WPLrH8cTO2MKAw0Mi9puCfisqLYe2XQ6btSW84v/ktl3YG5VO0iec
         byMH2MkAdOk1K/8dB7CgHQ05+ed2Ebmu+z6ux0SC3il75V97m4U6tER9AncWpLA1dl8H
         rwuw==
X-Forwarded-Encrypted: i=1; AJvYcCW6nnWGryEclahPU5KyaqskYdU9vv7kwevuJA8YEr2T88aPhpg4W2Z4sygYZWjL5lIJSdz95KDC@vger.kernel.org, AJvYcCWuCPcGUhoN3+sUc8BJngcr6NGKQoAWj5CDwlXJIcQGn25DXaqigQ+G2elmbtWotT+9adKQhsGzwkPhUtEbkhe0fthA@vger.kernel.org, AJvYcCXM8Ztxk/Y/2FsKss8p36tgv/jrIw/y3/HUtbJHxMU3yz6RKxUG/MdyEFMHsYh9M5f5geM3YkQcuD48eV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5byhhTN8k1iqwgpP3vMVZelCo86kVBltzWvPX5t34SZAd4nSn
	WEc48JGDLLLQ1emearr2/3tDXJPw44tyfAtxADs6kJMtokp7m7ZW
X-Gm-Gg: ASbGncvXGbwkPWXNmfalyWL/uXgQq2XK3IXyiOKZF+eX+pI5WqMW0+9NekhFmTaUnl/
	u7riAJqnzmnnnACGUqr+1PAKHTClWPIo/85q3QfZKK1LppItOcuUqgYgma9Yf3Hb4GKDpuEZP/y
	Oo6qEfbFb6EYFn2G5kI+2Jc5YRPyY4Z8nqFu6fO8FXaUBHSZGrgMfRrlXbInO/agvil34LLcn9+
	P8sMg0OriIWRbZV41RJdAsf7KZ4L+0ZdKhGULO8xAsafMd8BD7j1ZJv9eQxR1bFoAY75H48Hzt4
	TMPMQuJ4/XB2SKgoZwzexYaW8cZ1NaC9
X-Google-Smtp-Source: AGHT+IFfNnfOtp70orRNBAEBtit7rOYUx++BIFV89Pttj7LgXZLBjwyNI0dUuH3/U4dYls3hkOyhQQ==
X-Received: by 2002:a17:907:6ea1:b0:aca:e338:9959 with SMTP id a640c23a62f3a-acb42c762c8mr520605566b.61.1744889694583;
        Thu, 17 Apr 2025 04:34:54 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:44::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3cdeba0dsm277329066b.70.2025.04.17.04.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 04:34:54 -0700 (PDT)
Date: Thu, 17 Apr 2025 04:34:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	kuniyu@amazon.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	yonghong.song@linux.dev, song@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Message-ID: <aADnW6G4X2GScQIF@gmail.com>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <67a977bc-a4b9-4c8b-bf2f-9e9e6bb0811e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a977bc-a4b9-4c8b-bf2f-9e9e6bb0811e@redhat.com>

Hello Paolo,

On Thu, Apr 17, 2025 at 08:57:24AM +0200, Paolo Abeni wrote:
> On 4/16/25 9:23 PM, Breno Leitao wrote:
> > Add a lightweight tracepoint to monitor UDP send message operations,
> > similar to the recently introduced tcp_sendmsg_locked() trace event in
> > commit 0f08335ade712 ("trace: tcp: Add tracepoint for
> > tcp_sendmsg_locked()")
> 
> Why is it needed? what would add on top of a plain perf probe, which
> will be always available for such function with such argument, as the
> function can't be inlined?

Why this function can't be inlined? I got the impression that this
funciton could be, at least, partially inlined. Mainly when generating
ultra optimized kernels (i.e, kernels compiled with PGO and LTO features
enabled).

Thanks,
--breno


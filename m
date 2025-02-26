Return-Path: <netdev+bounces-169946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FB1A46995
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF843ABA68
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD12356C7;
	Wed, 26 Feb 2025 18:18:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B322540A;
	Wed, 26 Feb 2025 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593916; cv=none; b=rHaXla36FlL5UAsPeRX7WivORFglP/k01fJZtkDnE1tIYx77kiqoJpaoVCltqZ6PtjvOgfPMrkO3odtOqLNG5K3/pjZOV7gScf6asY0ayVoSzVosK52pqAP9PyEfw8OOT6MvK2eb6KN3WiQgaNawdgBIZSOMzJGdmQjlYZ5CizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593916; c=relaxed/simple;
	bh=VIygefJsmrqlayJetk/TuRE//08XHGhMXg4SxJl1N7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/SwXZC95Ks6qXrjJSbevxbt2WfuaIkrKaWa5hjWrFnY/n+dIDkQB7C/u3WaM9yYckl1TEzIm5cAP7n/QjsoMAkytamZ+AQtpoei2YT3T4oESCrPLOm+WHBMMT6JkkMqSjssJ1XnnVZ6OUKczFmQprNq/mKAd2N1C08EKOKx49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb86beea8cso8867166b.1;
        Wed, 26 Feb 2025 10:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593913; x=1741198713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANOUXq6Q4nNmGnkwfSvFwfZWJzxkc6uaWJAjlNi6mrw=;
        b=FfuFw6x4R1MjPcJV5iQBUDYP19L4w0UxZPtGELt60sGFAC2JgcSD3NSeLb4gETakMz
         nJADBYI1nLzRIkm+asNkvHM9Hb9vcSTDx9T9sROfDJgZREywwtqaYLHnL9Qj9eErpDwt
         OOs1i/Em4cd4BXXLndxBgx00YeeC8bzIGPdz+Cq1yjsJJmdl5KkLbtez4U2ViHkJLoYU
         DXmExVsbtbmsW6FngHvPUV0Ex6FAL/6EUH/A5b+nNh8KKBKiFCwJszxtuBcuQJKttFRd
         mMz8bOU18j9552NA7BFhKalfN7w0uQZ4va+AyniAlnxjGLXx6oJGt7/h6R7ceGN0NL69
         VMSg==
X-Forwarded-Encrypted: i=1; AJvYcCUzbFs+kAczICxZsGKmxIKpI097aF08XxrXFwfG1oDAiMk4tLL0ZWHOMQ83DoCltLorqBZG4qbOXIz9NT0=@vger.kernel.org, AJvYcCXQMCkFipIYBiqdUv3bII3vAwrnwtNumPnQ3acyK1gLu3+0z2BnxnP7yF/eq3yF4ODROInr5HmRgVI/+rRge4Fvt8pw@vger.kernel.org, AJvYcCXiVKkZmjhuoNCFeom82oAlUfKbu+wd5hGMjVvrVUJXjf7CMPygcPffIBt5tFvoAfsjNLPocWPW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbq+I8I9JA9oCGSS5v38UZ0z+5tQAXZ/I5+Y+lzqVSqBdhOUzC
	4ObwPOPAtTIwGTeTxEwqhEqxgdNUwH9ktybH1X3D6+rEFd2x+0u4
X-Gm-Gg: ASbGncttpHYl46vLQB5T8v0cvvNmHQTLwwkkHM37m8O+z/Zo2x+g3rnpO7TQYkUWCsP
	hZ6m+dT86vsYQ0hcBWwthyhoO/MiZ2zIYV8pvSbUwZX3O0P1z09eR/u5v+goBkDNSV5CTy9AgW2
	cZ3tRIFk+bXzZ2LKkRBPX+ZPESrRmA4+1OZiYTOaIozb5+q5RuP+zBJXNhJlixo33paH216rkRB
	ZmuhLCRZ70BUYAU2vUlnNoPkQMVDQTC3mVl3xh+kB3SfxZkjlCi/RgwHmO/bCZUOnhLm0Rf4XSV
	NPAcd0KrsqxajaBH
X-Google-Smtp-Source: AGHT+IGHOxW1BBkFTturFyL0nAQ4vwJGMPYFC9ml9D+kyEb7X/IH12HFXFvHGQMhPjAVMLuRzx9bPg==
X-Received: by 2002:a17:907:2cc2:b0:abc:cbf:ff1f with SMTP id a640c23a62f3a-abeeef42910mr615585566b.40.1740593912702;
        Wed, 26 Feb 2025 10:18:32 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d55b90sm373260066b.54.2025.02.26.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:18:32 -0800 (PST)
Date: Wed, 26 Feb 2025 10:18:29 -0800
From: Breno Leitao <leitao@debian.org>
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com, yonghong.song@linux.dev
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Message-ID: <20250226-daft-inchworm-of-love-3a98c2@leitao>
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org>
 <20250226-cunning-innocent-degu-d6c2fe@leitao>
 <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org>

Hello David,

On Wed, Feb 26, 2025 at 10:12:08AM -0700, David Ahern wrote:
> On 2/26/25 9:10 AM, Breno Leitao wrote:
> >> Also, if a tracepoint is added, inside of tcp_sendmsg_locked would cover
> >> more use cases (see kernel references to it).
> > 
> > Agree, this seems to provide more useful information
> > 
> >> We have a patch for a couple years now with a tracepoint inside the
> > 
> > Sorry, where do you have this patch? is it downstream?
> 
> company tree. Attached. Where to put tracepoints and what arguments to
> supply so that it is beneficial to multiple users is always a touchy
> subject :-)

Thanks. I would like to state that this would be useful for Meta as
well.

Right now, we (Meta) are using nasty `noinline` attribute in
tcp_sendmsg() in order to make the API stable, and this tracepoint would
solve this problem avoiding the `noinline` hack. So, at least two type
of users would benefit from it.

> so I have not tried to push the patch out. sock arg should
> be added to it for example.

True, if it becomes a tracepoint instead of a rawtracepoint, the sock
arg might be useful.

How would you recommend me proceeding in this case?

Thanks
--breno


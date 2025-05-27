Return-Path: <netdev+bounces-193658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF010AC5028
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCF9189B82F
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EBD2750E9;
	Tue, 27 May 2025 13:45:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30E248F4B;
	Tue, 27 May 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353537; cv=none; b=aMcx2tJ77eV9i2sVpwLLGje5j/bfQZGyeCttk+Jwc/nu4CqbuuhEqACBTd3HG48DkB+uuXygUh4LazHTbuzozHxmxDHt36btLwa3r2coV1JmcO4DbrhAkWR55pOU4pR5SwbR++9SZzVbjARnYHouY2IM38SkMgCJQDB3wZ5GrRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353537; c=relaxed/simple;
	bh=Qfbm2sNLA0vn8DCioBPKrEQvyUb4mLsh3zo14odwXcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeFSTbt+rOZQwdFRZybSwDnoW5czjCEYC08iubpDTI2MkAtGUiXnqHqGeuG8WkQrqBv9DPcfK/DJmqx/XP6daYEzgGEIjXqkSxMSbkGuTb14AJ46XRg2DQIbQFocYISBT7p3w07Fl8+/jf3v20BGsbv+4KZzr2s8qBQ8qnqFfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ace94273f0dso660221066b.3;
        Tue, 27 May 2025 06:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353533; x=1748958333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAZ7tO9uQ2iBPuBw8kzZnx9pJG/ibWbywo2r/XgEUb4=;
        b=X7HHkntkWtY0XuAbqLvuzaY/tWQXULgg+83c49w51irqhfeM3APfbMIxc/oQIMGX5+
         EIWBtsfZtmJbOiFenI0bdA1dk8TP/Oo3ZDxMQDASUxbGOQphiOvDABZU1EVSLvbqdPZK
         iOnPqr3KqggoQ5hACrTXBev8PjgUtrlUtQivCqr4DiNs06HePI5Ilh8buDiDHvrDEUiy
         /rBcoPK1YBMXY0j5QbOfvDPRu4NL6W66QbyvNGRLl3qC5UKvUtG7Hwi4JRDV/Dw/wOo6
         /sRWjBgCYLae4dERLhTL5qdazNGU4ZpyFCmlgJKmFfpLNF9ivr9Rzg7pFoixeWXohHCi
         UwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQa5zLzl9lYeP+1ghCWy32CpOlpQD02BReEGWqb2CgXHN51dOh+345Pg0jPcQ2UV6//wQhm9R1O3A12Yyz5HCt2aMx@vger.kernel.org, AJvYcCVEq/DhBgc6JVjBZJdzWClnRVgI6/OSbaiOpsfyoUfB3RJ1S7oyL5c0nvz68dYaH7cFcrBRrR+j@vger.kernel.org, AJvYcCXBHbLlxduO6UBmC0rF0WadIL5sF4zpelst/SsCwTq7YoKQqCUEMARVs4MrJMylJadX0omnKnGWcdUP34c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgmFvdbuMlRr8cLLd726V8pwbe4xh7SGzpXeeZKpZzb0n9hXm
	VKqUORqU5umfAXptlQnfwAXPVu2rGEQ30fgzLJK8qGqnQnr1gelWP2dL
X-Gm-Gg: ASbGncv0d36u8ZvyO5YiHiiN8ilFfE9slV5Axp/ULC4yGgFBLc2cRmTkPJ8Mt+cDVZ3
	Upi2Fv5ZLCAMgq6RUVTN6Bgium1c4MVeIXCpaxkXMyV0im3GfCUtbf0Qn62AUS70fGJwyM+djFi
	YoO4iOgZ92duvoq+9LfwJyarjgwBODDA6TOUfNMSAp9a5TOtVbCCl/8W7kOu5Y5xUq9XrV8vfgz
	dkn8Ims7T+pAzjmFvlgxmWT4i7wh209lnk08VGTUHEDWpzwlGU+I6tSwIbAUhAuM9RM18yLraos
	+U9DqplkEi2K7bFC3LiIqBH9ysXsIjUHzgjghGxENQ==
X-Google-Smtp-Source: AGHT+IH6j/BghWYjYKpMeSsKyBBh+LmICoGS6swWWHK7btRyaIUSVFGpwNJybOBUK3x7YvyreV/gCw==
X-Received: by 2002:a17:907:3e95:b0:ad2:3f1f:7974 with SMTP id a640c23a62f3a-ad85b12061bmr1022077166b.10.1748353532576;
        Tue, 27 May 2025 06:45:32 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad892483ba9sm83515466b.147.2025.05.27.06.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:45:31 -0700 (PDT)
Date: Tue, 27 May 2025 06:45:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Song Liu <songliubraving@meta.com>, Paolo Abeni <pabeni@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	"kuniyu@amazon.com" <kuniyu@amazon.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"song@kernel.org" <song@kernel.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Message-ID: <aDXB+ZqQZyQkEREM@gmail.com>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <67a977bc-a4b9-4c8b-bf2f-9e9e6bb0811e@redhat.com>
 <aADnW6G4X2GScQIF@gmail.com>
 <0f67e414-d39a-4b71-9c9e-7dc027cc4ac3@redhat.com>
 <4D934267-EE73-49DB-BEAF-7550945A38C9@fb.com>
 <680122de92908_166f4f2942a@willemb.c.googlers.com.notmuch>
 <B5B46BE2-C4D8-4AB8-BEBC-E0887C9B175D@fb.com>
 <68026672df030_1d380329421@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68026672df030_1d380329421@willemb.c.googlers.com.notmuch>

Hello,

On Fri, Apr 18, 2025 at 10:49:22AM -0400, Willem de Bruijn wrote:
> Song Liu wrote:
> > Do you mean we need to also add tracepoints for udpv6_sendmsg?
> 
> If there is consensus that a tracepoint at this point is valuable,
> then it should be supported equally for IPv4 and IPv6.
> 
> That holds true for all such hooks. No IPv4 only.

Revamping this thread to make sure we have a conclusion.

Any objection for not having the tracepoint in UDP sendmsg, both IPv4
and IPv6?

Thanks
--breno


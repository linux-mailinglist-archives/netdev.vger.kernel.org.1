Return-Path: <netdev+bounces-183821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C85EA92227
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2063BC2C9
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527625334E;
	Thu, 17 Apr 2025 16:00:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5A35973;
	Thu, 17 Apr 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905632; cv=none; b=YzdmbX6I1/IB605OzMuDR+pYg6jqCU6kiCeaH54cNGDxtXsKMEmscVf47a2awcy0tgDuENwjPPdoz1UFe32t0nx9fjfVdBnQVqoTFlmHP2RU/Q7kfnEy7uLjxM6CyblZsWsEXv/Nv3kXxnKrzPZm8hpfrUSyn0gJk2Ra7yKJm+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905632; c=relaxed/simple;
	bh=jPT4AAmgibTmxA0V1ba3CsDn4XHtwbX+E0BP16JAB6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWg37kUd39OVYRDf9OJ67UJSMPyMOruHgdDZdQVRjRWJe55Z2SxgFR3mpNRc34GLf3adqQ58I8/F5AUMLMe/nns/QGJqrFNRv0O7Q3GvfTtCjbdh1C7YEipK4fAAq5MgkcKizNP+VhUYar21KHIymC4sqAQtq9yTFtOv9KlJcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaecf50578eso143681666b.2;
        Thu, 17 Apr 2025 09:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744905629; x=1745510429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdOx7XTFcnn2/BAlCI2D+h+r/z0wXd9nw799U6rFfxY=;
        b=p9CrlmPvNOYX3OwSRRthscHDcVfhPo9OUuYNays2SjsQq6FLVMCN1C1RZkcpwX/0TZ
         MpjQp+2Y3puRWofS1xb40lTNKlD4Cp0Al20tYvCbZ6BvAZ4QYIF1EDRTKi/Xwyc5UZ8Q
         TC18vUa9RrFwmKhGYg/B0mWVUMQSBObRIBEFvyhyYwkxdhUCJo/sqrAfxqANzTqujQpv
         Nir5lccu5sp8XAwzutA3O0C3VXa4KpNLJPzHtS29JCNKv6TaOzJ6s4uW7GxFSHd7vacR
         r8o4SP+tu3u1N9fIHrluFmspfP6yZcjAcPzY4NtC3O+vV7jPQzR/H4VWa/DUliAIk8XN
         WaOA==
X-Forwarded-Encrypted: i=1; AJvYcCUYKx0V/NRZurRGSS3jfShZ5KdYrvFY5nEKa9cy2Mqkxud8ZA61Qmhd6TPDSeVrVGFgQv4D2YiObB1jKBM2udhby48W@vger.kernel.org, AJvYcCXNk/8FCCzusw+ZpAVgsPojwxP0u2FdB4eBWc95M3pLKiI7/rUhS+oHZVOnOwdQwQNnIqPdGndv@vger.kernel.org, AJvYcCXU05X3aBUi0D6csOpKl1fiNID6PBtUKbCTqO66KKqvCYj7TomskAYIUixOmUEdSR+7EZ8JqgDo/jiseyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfm2t+32l5cu26DBX4wxRgJ3h2WGS/tFku9UBPd7UaUtocWeZT
	lSEzwus9oYYy2LOxLfl/VXsqicrl+960/8fQf+e5QItyylZ8oobT
X-Gm-Gg: ASbGnctiJ16DEBlFMIHkr2bABFLcka5/mP21lAcCMuagKUk5EfF8Zi5HKrteN+VUlGw
	cL5tGxhmv45rK2vtvx1hSBn8IUlj7w6uWOm4tupbN/6cvCkQwwE7iGJ8tm4G5sy8IRBueiON4p5
	Aa1kANvKj3jLm6SFinMaCJkYW4l5ILZmI4ITBFqDVb6URw6vsEX42L3waa2kphKYt62StbX7ZBl
	wbjTaQvEk6ENDeaqZCSqZ3Lj7cDDhxID92WNkJWn21s6euL9Sh2bnif15lkvxjzbq4XvK0PnNgO
	xQkl0z1A1qjlQorhy79MfF5jel/A/0E3
X-Google-Smtp-Source: AGHT+IFg4hGasvyei5xLACSA3HpwvnF6HI6RRu6z/wrf4G5UdT6oO446RzgPjKkvGp1FKyY2gZJZWA==
X-Received: by 2002:a17:907:9450:b0:ac7:c66a:4702 with SMTP id a640c23a62f3a-acb42c2ac4cmr596741866b.57.1744905629341;
        Thu, 17 Apr 2025 09:00:29 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec4c673sm11910066b.52.2025.04.17.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:00:28 -0700 (PDT)
Date: Thu, 17 Apr 2025 09:00:26 -0700
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
Message-ID: <aAElmpUWd6D7UBZY@gmail.com>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <4dd9504c-4bce-4acd-874c-8eed8c311a2f@kernel.org>
 <aADpIftw30HBT8pq@gmail.com>
 <8dc4d1a8-184b-4d0d-9b38-d5b65ce7e2a6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dc4d1a8-184b-4d0d-9b38-d5b65ce7e2a6@kernel.org>

On Thu, Apr 17, 2025 at 08:55:27AM -0700, David Ahern wrote:
> On 4/17/25 5:42 AM, Breno Leitao wrote:
> > Hello David,
> > 
> > On Wed, Apr 16, 2025 at 04:16:26PM -0700, David Ahern wrote:
> >> On 4/16/25 1:23 PM, Breno Leitao wrote:
> >>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> >>> index f9f5b92cf4b61..8c2902504a399 100644
> >>> --- a/net/ipv4/udp.c
> >>> +++ b/net/ipv4/udp.c
> >>> @@ -1345,6 +1345,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> >>>  		connected = 1;
> >>>  	}
> >>>  
> >>> +	trace_udp_sendmsg_tp(sk, msg);
> >>
> >> why `_tp` suffix? the usual naming is trace_${func}
> > 
> > I got the impression that DECLARE_TRACE() raw tracepoints names end up
> > in _tp():
> > 
> > 	include/trace/events/tcp.h
> > 	DECLARE_TRACE(tcp_cwnd_reduction_tp,
> 
> that is the only networking one:
> 
> $ git grep trace_ net drivers/net | grep _tp
> net/bpf/test_run.c:	trace_bpf_trigger_tp(nonce);
> net/ipv4/tcp_input.c:	trace_tcp_cwnd_reduction_tp(sk,
> newly_acked_sacked, newly_lost, flag);

Do we want to rename them and remove the _tp? I suppose it is OK given
that tracepoints are not expected to be stable?

Also, if we have consensus about this patch, I will remove the _tp from
it.

Thanks!
--breno


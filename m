Return-Path: <netdev+bounces-146781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83E59D5BFA
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 10:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6603BB241FA
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC51AB535;
	Fri, 22 Nov 2024 09:31:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C218BC29;
	Fri, 22 Nov 2024 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267875; cv=none; b=Sqcmrbivs1FH2nhUXSkMW7ru5yvv4nuTvWr9g3Vqp19p6lrYOlo3NXStCsJUklBNjPzpACnnvAfLB/kk3RbMvs0BoW018IfFzM0H4hxHZT37/XBM+Fj6cYpUVGzMNKWF0jFlDSRyDRUcm88CDuLAq9I/K4SgAP7YYv8LVd07mFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267875; c=relaxed/simple;
	bh=nl4qbvt1UWsYtev+vO7i0zhVmWBBXlcrRz0Rr8/UfoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm4/GBoXr+jnOpQor7UhJZi7zLTTA5rk3EV0WEUw/WMPiiPYy40Da1J5m63MywQk0PiC4NtwdA5WCSPpdYTursVyu8XbXw/kjqJJsisBdQ04sIPKbwgCP40gpBYX6hc/j/ihFPsG544wUaOltgLEt/6i6jr0GWZJOt2EoiJ1gw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffa678ddd2so5663441fa.3;
        Fri, 22 Nov 2024 01:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732267872; x=1732872672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOWot/XJrMtQAx+HvNWYXnmSZ9Bq/WtFgg0IV9J4cqY=;
        b=pbLvm58uXJfS4c1Ct1pNLsNsd9dQucMN1qmS1CEtvFR67NQxfIDoRh2HjTNioH09Wg
         4IlAD8qC60XA70CbMWeMsqrFm89juulljpNWBQSkATrNLyEZT2Xe3ASuxl/jcmdS9agu
         Ljuh1fDOGfRT5D6udDTmXPDVXYiQ4BZqxEGqi1tR/gXbFXCjRFYhfbl87PznU0jp0FBF
         NSEcUZ1DB6eKNkyFBqB4Hfc9MyUI2gixAKif30hjOoVQF+kRqRGI6bgWWtUViPNircJd
         tqXw9W/dy9K+dGJmDlAAl0ocyYrXnSosaCGXyTXcJ5Yh5PAC1Ta5CEYwSLQdizJaLgwl
         IRgw==
X-Forwarded-Encrypted: i=1; AJvYcCUYA7VlVKyt1aGpTvxhGESxdsZSK4zfmXGKIZXbano17MjjBg7aRo4gu/CFbiPsqa3qLzq5tLQqztUu22s=@vger.kernel.org, AJvYcCWPJYt3MA743QbuOa/qv7dsUUAGV6MafPss7IuyiKA48p9JY5067EYAXc/eSeEUO53TYT3KQuqh@vger.kernel.org
X-Gm-Message-State: AOJu0YzeoFxAl5UAuhlG/8CqjrdFjh7YtculpwCNluTCDcEHhVW9m0YP
	9te/wKRAor3CNeUdWVEDqEcxWjInsSxLJQDWth94hyWKwFd01ArK
X-Gm-Gg: ASbGnctqbF0hf6ugBoEnDvksblRA1MGNn41o6EWSbw+eEZmszv3mddjjfp9yI3LheBp
	1+GSgrNBNEsG7WJ/q5sw24YfQJdHP0AmCKqeBVtWnlXIusEKCSZnmWbkdn5kydnv0IuGcUd/xKW
	rty23JfhkqxlKdVC3Ri8W3xJf7L9lNNZuf8D5aW0hgZrkFRqSPVYSgQS4tERCqZ6k68W9kNskuS
	WVbDPzaDNHqOYtXGFgFwQD/hajanOpfaI/MN5jJjl8jyIfaw5hui7iDdjg9E0rAZDBAFJqffqPj
	BA==
X-Google-Smtp-Source: AGHT+IGW9r+VDyArXzN23rCsOrw02D9bzUQ6jX1n1VULP++Z7f09DS/5dVmHEEkzts6ce8e3p0efRA==
X-Received: by 2002:a2e:a5c6:0:b0:2ff:a246:f94e with SMTP id 38308e7fff4ca-2ffa711baeemr8652611fa.12.1732267871742;
        Fri, 22 Nov 2024 01:31:11 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3bf926sm699681a12.42.2024.11.22.01.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:31:11 -0800 (PST)
Date: Fri, 22 Nov 2024 01:31:09 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net] netpoll: Use rtnl_dereference() for npinfo pointer
 access
Message-ID: <20241122-pronghorn-of-astonishing-innovation-dd8d6b@leitao>
References: <20241121-netpoll_rcu_herbet_fix-v1-1-457c5fee9dfd@debian.org>
 <CANn89iJeaaVhXU0VHZ0QF5-juS+xXRjk2rXfY2W+_GsJL_yXbA@mail.gmail.com>
 <20241121195616.2cd8ba59@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121195616.2cd8ba59@kernel.org>

On Thu, Nov 21, 2024 at 07:56:16PM -0800, Jakub Kicinski wrote:
> On Fri, 22 Nov 2024 00:41:14 +0100 Eric Dumazet wrote:
> > > Fixes: c75964e40e69 ("netpoll: Use rtnl_dereference() for npinfo pointer access")  
> > 
> > This seems wrong. This sha1 does not exist, and the title is this patch.
> > 
> > We do not send a patch saying it is fixing itself.
> > 
> > I would suggest instead :
> > 
> > Fixes: c69c5e10adb9 ("netpoll: Use rcu_access_pointer() in __netpoll_setup")
> 
> Or no Fixes tag and net-next...
> 
> I'm missing what can go wrong here, seems like a cleanup.

I decide to sent to net due Herbert's concern about the previous patch.

I will send a v2 targeting net-next, then.

Thanks for the review,
--breno


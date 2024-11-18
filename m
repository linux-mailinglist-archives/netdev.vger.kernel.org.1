Return-Path: <netdev+bounces-145905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D969D14A0
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16D6B25CC2
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298C1B21A0;
	Mon, 18 Nov 2024 15:37:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC118EFDE;
	Mon, 18 Nov 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944270; cv=none; b=d20FaJFIsFBMYvhtX8ZRWDFbCLYHz+bUPd0KKFckTDPy0Vsbi6L9qIg5JZbYfmfS275JrFLTLgGA/5FTdahhZd2ba/jU48aManxv+7RpVYnmAl1ICWV15o5icL+4peYzZkEAkONUN/+lSkKOUk3Rflj63Io690PfG3poSYSBXYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944270; c=relaxed/simple;
	bh=B0VubLmz0Pv7VwrqAtHiycswd5+LrMziyvAc9MpzHzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9ECP+d6iXLYC/antTviUqhbqHcn2y1YjmUUz1hg20Ed2wLERfm+NQzdlPgcj6ZcSWVI9+X5PhbhnyB0ihXHJGLbavVaIOyNVI4ruwdNzi731hcA0/e58xavImNxus2amD/Wv6t6H1i0ciNwzhxtdpCAd8/8QnNp/NAHowGYAEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so4683711a12.2;
        Mon, 18 Nov 2024 07:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731944266; x=1732549066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEVzQiFOyDIQvdPbae67vbqyUHweeO/zHbrTBMA03mY=;
        b=LrMn6Afaeecqi/K8ySPJWXuPB7eFI19eo4MfNBnVmnGRrwDvarvKqmxZIHiWhoWAxk
         73lLXOdeGbTYLH0fWCCczjOS4jNv6J/psK+7A+RgbJwoXyVYIUDYgtvWWXkMsh3EB/TR
         Xs37n37CO1LfQZ7ZsieNEVTrrmC6+YQWo5tL47EH336Zv2KhMlEY0u9t40MO0CarLS7s
         odUAuyYdS0I3CViDoE1DMuOqtmPxDXvdeFmyn77aeZNJwBsY2s0i9MwrLK+Luus9HxJg
         e4u/POEXhSr7VugVW2OVB2dj+xzrKlqAZnNh9L8PjKt4bSM9PPzf2HDbwN5XX2Cla6Gz
         eTBg==
X-Forwarded-Encrypted: i=1; AJvYcCUvoSifJhBVvfysftKZBxk+mmzOLwbiiqkOeuGS3LNljfn08P8a+XYp8N7/fuBfNdDFWdrnq4g2urz+pv0=@vger.kernel.org, AJvYcCWI7apLMpu8Lycqu8E/nt7mFX/p7GtdaSt0eFI+q9x/0nARhlNRkex9LmZ1n4i2lJEuvryP2EuU@vger.kernel.org
X-Gm-Message-State: AOJu0YysmjDvfFU7hPZ+Myqm6APmgS7Zkih3HJmT5mXFlRBOkp4xSmEj
	abqwnVuiGHMGzKKgf54wO54yKf8tMOtuTz94ddUSHT/xjAUCpNl3
X-Google-Smtp-Source: AGHT+IHQ8CAAWSP5RfIdvWUK2Cj8/LDiPNPVOPfAUOxhYEoSqtKGFv7nzXXwas1cSy2GOX0gKOKPTg==
X-Received: by 2002:a17:907:3f97:b0:a9a:49a8:f1fa with SMTP id a640c23a62f3a-aa48341263dmr548012366b.23.1731944266407;
        Mon, 18 Nov 2024 07:37:46 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e043316sm552492866b.135.2024.11.18.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:37:45 -0800 (PST)
Date: Mon, 18 Nov 2024 07:37:43 -0800
From: Breno Leitao <leitao@debian.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: [PATCH net 2/2] netpoll: Use rcu_access_pointer() in
 netpoll_poll_lock
Message-ID: <20241118-bipedal-beryl-peccary-ed32da@leitao>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
 <20241118-netpoll_rcu-v1-2-a1888dcb4a02@debian.org>
 <ZzsxDhFqALWCojNb@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzsxDhFqALWCojNb@localhost.localdomain>

On Mon, Nov 18, 2024 at 01:20:30PM +0100, Michal Kubiak wrote:
> On Mon, Nov 18, 2024 at 03:15:18AM -0800, Breno Leitao wrote:
> > The ndev->npinfo pointer in netpoll_poll_lock() is RCU-protected but is
> > being accessed directly for a NULL check. While no RCU read lock is held
> > in this context, we should still use proper RCU primitives for
> > consistency and correctness.
> > 
> > Replace the direct NULL check with rcu_access_pointer(), which is the
> > appropriate primitive when only checking for NULL without dereferencing
> > the pointer. This function provides the necessary ordering guarantees
> > without requiring RCU read-side protection.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: bea3348eef27 ("[NET]: Make NAPI polling independent of struct net_device objects.")
> 
> nitpick: As for the first patch - please check the tags order.
> 
> Thanks,
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

Thanks for the review.

I am not planning to resend it now, since I think maintainer's tooling will
reorder that.

If that is not true, I am more than happy to resend fixing the order.

Thanks
Breno


Return-Path: <netdev+bounces-203229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 856B7AF0D8F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569877A72F8
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD102367AE;
	Wed,  2 Jul 2025 08:12:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1F9235C1E;
	Wed,  2 Jul 2025 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443933; cv=none; b=XcuBJ8j9t+6albnDxALUi9QPHshQAA1alSzxSeO1sPL6DfudIk0fIrpNsbWcm57ONiGGP1jb1fOEv/oWNIHDdM0deNcnh+ca6VHXzuXod51uILdy4aiuvLzql/hiZjUvOpmfH1mo6BA19RSUwnc3wb2UkC6W+uG8dVG29M16RT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443933; c=relaxed/simple;
	bh=tFK2QrFWWvDmP6CtwVKqwbt9Ox9i2kJm+VJCmIta57Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGtbkor95PEPinCkscP3d9+HCXBklj0Nm++aCsglOrSlfmslEYqf8/OhEQtpd+DKaEyAzPcMo10VbA92Ou0zctryFe6TbeoyvVTtlUIW9pThySVYJbF2ubUa/HxJs9gJd6HAQiJ4WcA2GId089I3SilrWfHduXQrEqufkd0TRlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0d4451a3fso711080066b.1;
        Wed, 02 Jul 2025 01:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751443929; x=1752048729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DBqyISpLzZ1F6OIkdnY4d5pPYWOFwQa60NPg+vWa3c=;
        b=mKqaZv3CDwcP5aoarbxdrz/zX3HGs32+/qjPm5FKgEDHAyaBxz/Bgxh6gFlRo0t8aW
         D8bSSHIdhoQPIofmP/hBBcPkTr4FQBticAIkxZmFCBXgcU6rdjTerT7kKy+HFiLku1UY
         CfU6H0ZnK8XfeE9mJ3swSEq/d0Qu6aTFa+xKnLRI5vjfpn6Xy6AwddE2dwEM4tWuXlF4
         Tx7WrXPkv2XHDW1OXU9yWCDJ7iActF3jxW8ipd9Rbi8oab6UQ+Y4VxZ+jrPWtr39Fi4B
         ZxLPB8jtTGi9PQl+UXrBVbx2q3BIB1I4RpLEdEx2smq/Z3TSev8aeT6d6DDV8TTzPwy7
         GBKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaIoOIxv77Jpn+J3VLnwnSDulQj3WHbUl3zbZc3r+BMtBt4/gXxc6k5DrS16x7ftjFGR6xesG2Ea+Rq8M=@vger.kernel.org, AJvYcCXizBd3wTwT2eyUiSOOVzgFmMRUsXRgbgWP92MphF7go/VDb5/TXwBUvE1YhNQ4YQA+6KR5cQC+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg038nXftR1Y8I1vuj7OXUoy2FfhWjTTT11zAZUWoyseKyzlsw
	CGUCve3aLraXe/N84pmlv0wO12ilEmAUYTyD6A0WI0iSupoowLefUI6B
X-Gm-Gg: ASbGnct0U4KgP9NuF854om4Kz56/yfKBbTXyjXeNwidxU1XFH9MlE9pQiAM4wiu1n0G
	yHm0PowIpZAoGf6gOr2ak+IxPCzxGk7CLseNzS2qDtv3KEAmshOUnFOi3diniJRSwfEVpQKu2oO
	4pefkX0kBjBkZoBZLqudLUfMyV9vN3Yi0NZQDZB5DUTGL75YixFxk5kguwcQ2ZpRzPr20jWuMre
	qGp6xC2UUIWztW6L8w9G5ZEnTIYtJNZu036gT4BiSnxk2XSxaK8Ut3q3Mwde72e2prDXB3tcj69
	3DtzxJUIu+8c0raWngpEnzRjKSgPDQ5yun8tALZfQS3nhATsdWdf
X-Google-Smtp-Source: AGHT+IGrO9ErcnjBzEPzLxx1bncjHYEKO95UD6i9tGNB/o6pu26Usxro5kPM6D4u12Yv1s6fmSi/HQ==
X-Received: by 2002:a17:907:d8a:b0:ae3:b94b:36f5 with SMTP id a640c23a62f3a-ae3c2c4bdcamr141731066b.34.1751443929236;
        Wed, 02 Jul 2025 01:12:09 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b416sm1019235566b.28.2025.07.02.01.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:12:08 -0700 (PDT)
Date: Wed, 2 Jul 2025 01:12:06 -0700
From: Breno Leitao <leitao@debian.org>
To: David Wei <dw@davidwei.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next] netdevsim: implement peer queue flow control
Message-ID: <aGTp1oyDGPwErXNO@gmail.com>
References: <20250701-netdev_flow_control-v1-1-240329fc91b1@debian.org>
 <e87a5ba3-956e-401e-9a1e-fc40dadf3d87@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e87a5ba3-956e-401e-9a1e-fc40dadf3d87@davidwei.uk>

Hello David,

On Tue, Jul 01, 2025 at 03:26:07PM -0700, David Wei wrote:
> On 2025-07-01 11:10, Breno Leitao wrote:
> [...]> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> > index e36d3e846c2dc..43f31bc134b0a 100644
> > --- a/drivers/net/netdevsim/netdev.c
> > +++ b/drivers/net/netdevsim/netdev.c
> > @@ -351,6 +406,9 @@ static int nsim_rcv(struct nsim_rq *rq, int budget)
> >   			dev_dstats_rx_dropped(dev);
> >   	}
> > +	rcu_read_lock();
> > +	nsim_start_peer_tx_queue(dev, rq);
> > +	rcu_read_unlock();
> 
> Could the rcu_read_{un}lock() be moved into the
> nsim_start/stop_peer_tx_queue() functions to keep it together with
> rcu_dereference()?

Yes, for sure. In fact, I will update and move the locking primitives to
inside the functions.

Thanks for the feedback,
--breno


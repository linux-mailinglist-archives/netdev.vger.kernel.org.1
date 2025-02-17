Return-Path: <netdev+bounces-167054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39024A38A06
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C49618852A7
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FD1225788;
	Mon, 17 Feb 2025 16:47:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450462253A9;
	Mon, 17 Feb 2025 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810820; cv=none; b=pfHO6aFVjbrEyl7nGpBqiqthEs4ZXm7apbIbikO3+8RgqZKsCgymAPFEPQyLANSWHsPX2Z6hAtZ3WcqiBqV17WmJ1NobAZz3iiq9TfxvGTxvygQEE3n0pNIWKJ3gumYaee3NMw8fntSvQu8dyB4KsJBnNyWNpjR8zIg6MoLpgSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810820; c=relaxed/simple;
	bh=t+b3ybGYpFxi7vBp9GOPMu6FsSNmKDDER0cb7jv1lpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5XI2X/gn3wdf0li9peEwDQc9CXo4wXnLuPHENlpFZiQZgmjNiJANuLsPi2ZvK03kVw4jNKFHfTkD4bWrUxMaip/wPDDQflg4geEo4eyw4nHDdQUb31BCy5kFvEWv0y0j4kVXpkFMQ7y9IVwhyT5yq9ev4AJLsuLw+jd+kP6JHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb705e7662so403452466b.0;
        Mon, 17 Feb 2025 08:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810816; x=1740415616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBd0yiOIPXavPzgm2NZ4+SGl9Cs0pl8f/uGPEvGNJKk=;
        b=gI+I4zLjXLLggyl3XkC6Umbinn34IHVwZM1ZL2+4jSUaUbVl5huLGJ+e+EfeZ1v9dF
         AJ3ZkvcjNYkb3EUc8FuWfh35vBkLRqwztIR11PYY/L9EieKokOZY6yaUwVDl/Cj8zyIL
         JF2ft8qunYiY9rDfEIvWsg3vm7g7ImY/+e+/o9cy/RJ1PN+J/EQLTX+Kz90Zst0/mlSU
         UkvENlUQlkpYLCQqnQlQDCscZcFg4n1SSYzKwGNEcChMbjvvzPjVGi1lJnfMaWtFlbqL
         Npnbt9E/wS4m+eAuZAoUwndOpdfU5hKvtYL6uSy0JVj+owIF3Rd8bhE+h2pvYvlGniiV
         3uJw==
X-Forwarded-Encrypted: i=1; AJvYcCW2YaiJyQqwZbyi4ZZIcBh3V3WfZpiIVtT98GEnW3Wky4Qqkzz6yITUnyibk0JnVSuAwAP/jS3reVwSSSo=@vger.kernel.org, AJvYcCX8leeqmVg52gMSmggo8LjB0wrp8FDIqkskA8PhUUaS7Zu2K8Fys81oxcMTU7vhf3ItgVLOGEom@vger.kernel.org, AJvYcCXkp+hYGn+jCVJQZuSyM/kluel+oV+JYRU6qCJ8f8ifrt4u0MQcTbDjOH0NNJ45QM/NttBxpfo/GZ/b@vger.kernel.org
X-Gm-Message-State: AOJu0Yw45W43qYa5bgpWOvVFftf5Bb9WlHiH7/1ObcSYQbMuA7HK4XQO
	BJ5IyLG54DOk9Qov9Trb5V7YpiVweBVdwQpL5gbUA38sZtK6a5Ac
X-Gm-Gg: ASbGnctcNfl+A81vP0hH5W0O0MSPAFvShAeewYaPLas5Qu+T75YzeDEDhpicDxgihct
	Tjw5ivtHa3vHvBGXYB7DezskgK3d6yDzec4AgHWVEDfXrBJN/rr4VliMMdYfTNAhOavN1QFOhAw
	3yK9MciLwTehKfh9WoOvdU/bNOKRmWiIEg87vPRU39nUDr2NxtXQiXBu7Q5f63T/2Tqyb/2kYho
	9gdtx032ztXei7FskZB1gotdETLZyA4v9jRAlvjWszeXIUQ8vjAWkPuWN1k8vfIU8UbxteQ+M2Z
	5bvZ3Q==
X-Google-Smtp-Source: AGHT+IFYSyki8aI/+MEgHPATaWpDyxRwWxLPhT2Gjm4k1Zaase1sMcjdmdm/SWF1aVutqas0VI4wXw==
X-Received: by 2002:a17:906:c14c:b0:aba:620a:acf7 with SMTP id a640c23a62f3a-abb708aaf52mr1170804666b.10.1739810816110;
        Mon, 17 Feb 2025 08:46:56 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7d4dc4dasm459322666b.3.2025.02.17.08.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:46:55 -0800 (PST)
Date: Mon, 17 Feb 2025 08:46:21 -0800
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
Message-ID: <20250217-weightless-calm-degu-539e59@leitao>
References: <20250212174329.53793-1-frederic@kernel.org>
 <20250212174329.53793-2-frederic@kernel.org>
 <20250212194820.059dac6f@kernel.org>
 <20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
 <20250213071426.01490615@kernel.org>
 <20250214-grinning-upbeat-chowchow-5c0e2f@leitao>
 <20250214141011.501910f3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214141011.501910f3@kernel.org>

On Fri, Feb 14, 2025 at 02:10:11PM -0800, Jakub Kicinski wrote:
> On Fri, 14 Feb 2025 08:43:28 -0800 Breno Leitao wrote:
> > diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> > index 42f247cbdceec..cd56904a39049 100644
> > --- a/drivers/net/netdevsim/netdev.c
> > +++ b/drivers/net/netdevsim/netdev.c
> > @@ -87,7 +87,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	if (unlikely(nsim_forward_skb(peer_dev, skb, rq) == NET_RX_DROP))
> >  		goto out_drop_cnt;
> >  
> > -	napi_schedule(&rq->napi);
> > +	hrtimer_start(&rq->napi_timer, ns_to_ktime(5), HRTIMER_MODE_REL);
> 
> ns -> us
> 
> We want to leave the timer be in case it's already scheduled.
> Otherwise we'll keep postponing forever under load.
> Double check that hrtime_start() does not reset the time if already
> pending. Maybe hrtimer_start_range_ns(..., 0, us_to_ktime(5), ...)
> would work?

Reading the code, I got the impression that
hrtimer_start_range_ns(..., 0, us_to_ktime(5), ...) will reprogram the
timer anyway.

	hrtimer_start_range_ns() {
		__hrtimer_start_range_ns() {
			remove_hrtimer(timer, base, true, force_local);
			enqueue_hrtimer(timer, new_base, mode);
			...
		}	
	}
	
I think a better solution is to do something as:

	if (!hrtimer_active(&rq->napi_timer))
		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);


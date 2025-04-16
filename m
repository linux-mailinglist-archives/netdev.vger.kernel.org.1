Return-Path: <netdev+bounces-183330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E4FA9061C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F42F1891026
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAB5205519;
	Wed, 16 Apr 2025 14:14:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8628D192D68;
	Wed, 16 Apr 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812852; cv=none; b=W8u9eV/esLiCVMRIl3bphG/3C7qoznDa1dNN6SX0edZ8sQ/DPnYcEJkvd+XMyLE+R2xAWY1oddLzbeLMVZH7o3sf8AhCS+J907CpFXmpjWUYQSwKn/bXU7zQn9xZBrJkBFrk5GfzJfdmoI1/GM6krkwJl5lk0qdgxqNpgNdFp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812852; c=relaxed/simple;
	bh=P8RyqmbFkaSkJG3Ix7pdpJZrWqUmUydL79exEYIicoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy8XAcCVVqPWJ4LihS9JeyGdPAnFOZORvmOQh4gF/6XehZ+OTX8seC0uvTj+VmlYfSBImYvqX/iD0lboSy6Z/IiBzIdERvn1fzHpgKspFYQqsp4/zHJi7yxrg9eydhLfJR6Q/D/OaAqOqolgYxr0i5QrqivVEn7jk4gl+8Yw9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f435c9f2f9so5195726a12.1;
        Wed, 16 Apr 2025 07:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744812848; x=1745417648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQgHDDXnnzWRzJaD14GNyp8/kByAyC6tvTlmaDv4JQU=;
        b=kBU0ozp/u6yQMyHiesVVqPGZcXCmmqcJsS2PttCIqVDFzRrs1YKUG50/CPmnuyO0rt
         da8iad6DJkkwY6IMq9Zz5C2Oo+y99NWhVAJWtpeXpkxt01IDK05RjXurpbBmEeN/0ARi
         7Je1aaf7N5bCeBu6aCKNlu3CbST3tr5o/Yesb2voiLb40hLZoVhYjYCeZlKn6x0vpJNI
         hgx75579qZ9m58dLAnJuuWK37EAeKB/1bt1/oim2hwWdX2y8RjFhYtrf7PMDqwmow5ht
         z0viyClTo4HAfdoM4xGIsr1xF62F+5hOwZy0YVPru1cb7cbwuO1PjzZgnWe7G7CCGd3m
         28Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUXFUS/kRK1dJeTQps1of4HC/TM6N3zBsc4XAWR49/N+7ImImJuPEjWfrcwrp/cQ+Ov+Uofp3b1@vger.kernel.org, AJvYcCV/k8dOtcNscr50sxDcFwchadBLpWHOXFGX/h93ul873HMk+tgm3jXS1HYHdRHmi3RrnVllyBpgtNYkq0M=@vger.kernel.org, AJvYcCWLD88mM9aAcwnChlnbOgk5sOBlSJG9LcnC4lwwbcK5H201nH+pis1dK9Q/PqBgG49fS9nX@vger.kernel.org
X-Gm-Message-State: AOJu0YymdQA7Y4rwCUFTS7PZGITPBw2UoyE4olHu4qvo5hwwVpXq8NB/
	26CwtrwMwtAVV39aEw21fOeAcIXWRL6eXaDeTliV4qKiUsiQW8tt
X-Gm-Gg: ASbGncuM+mzatgapFxXqvwUP1jrK99O16UTWs1d8wsMKTzSTX5ZrcYqZUKpjWnElLmg
	pFQCf7yNaDFMgXR3exZ109Wodpxx/JOVLMNUro9MqadG0DgxL3L2MSu6BuTJu/RwTWN/boFnTVI
	fgJ0crj0AJuwb3Nh2Ga/w0Xof9+tFMnP4adCZcfGIJHPxUDO0K3nKO6WwrUJn1jdGu9NuHbVpM3
	jd4bUtP4TomDOpscjgnCOSv7y84+MgkIuu3XB6k0MI3ioXR5PrVUv6jMutSC4Q4eSGJbUzel+eE
	+XaP39AE6Rpmo7D9NERUp7Fe7nsIhmk=
X-Google-Smtp-Source: AGHT+IF/gy9/45ncvysC9Q/2W6qeo7ZVy26R66Z4JYMUvVjVlHXtwBR64Y2bD+mMPpEWZZIP4NNGtg==
X-Received: by 2002:a17:906:c108:b0:aca:d4f0:2b9f with SMTP id a640c23a62f3a-acb42875ecbmr212168066b.10.1744812847353;
        Wed, 16 Apr 2025 07:14:07 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3cdeb9f7sm133316866b.58.2025.04.16.07.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 07:14:06 -0700 (PDT)
Date: Wed, 16 Apr 2025 07:14:04 -0700
From: Breno Leitao <leitao@debian.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	aeh@meta.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] Introduce simple hazard pointers for lockdep
Message-ID: <Z/+7LMnQqtV+mnJ+@gmail.com>
References: <20250414060055.341516-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414060055.341516-1-boqun.feng@gmail.com>

Hi Boqun,

On Sun, Apr 13, 2025 at 11:00:47PM -0700, Boqun Feng wrote:

> Overall it looks promising to me, but I would like to see how it
> performs in the environment of Breno. Also as Paul always reminds me:
> buggy code usually run faster, so please take a look in case I'm missing
> something ;-) Thanks!

Thanks for the patchset. I've confirmed that the wins are large on my
environment, but, at the same magnitute of synchronize_rcu_expedited().

Here are the numbers I got:

	6.15-rc1 (upstream)
		# time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
		real	0m3.986s
		user	0m0.001s
		sys	0m0.093s

	Your patchset on top of 6.15-rc1
		# time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
		real	0m0.072s
		user	0m0.001s
		sys	0m0.070s


	My original proposal of using synchronize_rcu_expedited()[1]
		# time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
		real	0m0.074s
		user	0m0.001s
		sys	0m0.061s

Link: https://lore.kernel.org/all/20250321-lockdep-v1-1-78b732d195fb@debian.org/ [1]

Thanks for working on it,
--breno


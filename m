Return-Path: <netdev+bounces-58595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 793C4817671
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6C41F22AF6
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAAF3A1B6;
	Mon, 18 Dec 2023 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c97I722j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2A1EA71
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-db3a09e96daso1933988276.3
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 07:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702915074; x=1703519874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zygwJSjMe2eYUZaDyLafoB0FdFlBGABC230eRNUsyrM=;
        b=c97I722jYGBSf69ld0eJdfST3NMGpRWI53kpzYAStrssW6lEiAgFk9Cc6GPvv9FW5N
         O4YHUSKs/gbUFsJWDF3z/6Jt5M98MupuMGJMvssjtxdqz8gf+lS+l64p7jbPa7CAKn+I
         th9HE5HBc07Jb66vtc9Rzvq4Xr/7UVbFgQwozMe+0dKtb6jdK+QFwNymBYDVMitBiLyo
         sQRqgWodyJU2zDkh+HhnSIUUCwDF4lXOhfZFuUGF8lrOs/SjzgmTf75hm/1CwdBA0R8P
         QnGN/9ixgG88EWJJ2geHPSeh1G3gXwxTRoSgIOzaiKazbz2aoyIGz6O7PGktUXY8PJHr
         PMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915074; x=1703519874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zygwJSjMe2eYUZaDyLafoB0FdFlBGABC230eRNUsyrM=;
        b=AGDRfOdCFn7PgXcwjqZ6tZbfBAiHqUPAZtNvglek0QhHJQlUyyenfgMYAUHeZsatJ0
         DYPsBluT9G7cC5sXnAr7ThMBhCTm2oY6ctomL6+83yDe58iQ2lLLX00y7123wz/+UcKK
         g9d4KDihkiv0uG/Xk2bOkK9y+UEmQHOyGwnHXih3eR3BoKEV+g5SWRciZ5b3KnxpkPx6
         imAxYHkGMKeX2qXRQKAO92igWiYGKDeEm0VWHLzRpvE+isnTvUMtH4C5ND3M9Dtrjn4H
         f/aVMEIZgWoB+pJJVom5s0g5xGtXVoyZQC/w5vg8DRDN8qPdXI686S+N8DNbMY18HfDc
         H9Ag==
X-Gm-Message-State: AOJu0YxHaa6IcK25xp4hXLMwni3p6aIEHdSsUXxVLDljhU9Y9IAA17On
	BbLHRuUu2ltgtB5hnQmh8Zk=
X-Google-Smtp-Source: AGHT+IHenxc44IBKqvf9+YpIc5gdTJ+X6U7J9szWeK56xk4R6IXcAibg8OOKyP6YFyuok23IHHMF0w==
X-Received: by 2002:a05:6902:245:b0:db7:dad0:60c1 with SMTP id k5-20020a056902024500b00db7dad060c1mr8289686ybs.78.1702915073569;
        Mon, 18 Dec 2023 07:57:53 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:9c41:1dd2:7d5d:e008])
        by smtp.gmail.com with ESMTPSA id g13-20020a258a0d000000b00d8674371317sm7720490ybl.36.2023.12.18.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:57:46 -0800 (PST)
Date: Mon, 18 Dec 2023 07:57:43 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Potapenko <glider@google.com>
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, pabeni@redhat.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	michal.swiatkowski@linux.intel.com, wojciech.drewek@intel.com,
	idosch@nvidia.com, jesse.brandeburg@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jiri@resnulli.us
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/7] Add PFCP filter support
Message-ID: <ZYBr98sd+XzSfy9v@yury-ThinkPad>
References: <20231207164911.14330-1-marcin.szycik@linux.intel.com>
 <b3e5ec09-d01b-0cea-69ea-c7406ea3f8b5@intel.com>
 <13f7d3b4-214c-4987-9adc-1c14ae686946@intel.com>
 <aeb76f91-ab1d-b951-f895-d618622b137b@intel.com>
 <539ae7a3-c769-4cf6-b82f-74e05b01f619@linux.intel.com>
 <67e287f5-b126-4049-9f3b-f05bf216c8b9@intel.com>
 <20231215084924.40b47a7e@kernel.org>
 <ff8cfb1e-8a03-4a82-a651-3424bf9787a6@linux.intel.com>
 <1eb475bb-d2ba-4cf3-a2ce-36263b61b5ff@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb475bb-d2ba-4cf3-a2ce-36263b61b5ff@intel.com>

+ Alexander Potapenko

On Mon, Dec 18, 2023 at 01:47:01PM +0100, Alexander Lobakin wrote:
> From: Marcin Szycik <marcin.szycik@linux.intel.com>
> Date: Mon, 18 Dec 2023 11:04:01 +0100
> 
> > 
> > 
> > On 15.12.2023 17:49, Jakub Kicinski wrote:
> >> On Fri, 15 Dec 2023 11:11:23 +0100 Alexander Lobakin wrote:
> >>> Ping? :s
> >>> Or should we resubmit?
> >>
> >> Can you wait for next merge window instead?
> >> We're getting flooded with patches as everyone seemingly tries to get
> >> their own (i.e. the most important!) work merged before the end of 
> >> the year. The set of PRs from the bitmap tree which Linus decided
> >> not to pull is not empty. So we'd have to go figure out what's exactly
> >> is in that branch we're supposed to pull, and whether it's fine.
> >> It probably is, but you see, this is a problem which can be solved by
> >> waiting, and letting Linus pull it himself. While the 150 patches we're
> >> getting a day now have to be looked at.
> > 
> > Let's wait to the next window then.
> 
> Hey Yury,
> 
> Given that PFCP will be resent in the next window...
> 
> Your "boys" tree is in fact self-contained -- those are mostly
> optimizations and cleanups, and for the new API -- bitmap_{read,write}()
> -- it has internal users (after "bitmap: make bitmap_{get,set}_value8()
> use bitmap_{read,write}()"). IOW, I don't see a reason for not merging
> it into your main for-next tree (this week :p).
> What do you think?

I think that there's already enough mess with this patch. Alexander
submitted new version of his MTE series together with the patch.

https://lore.kernel.org/lkml/ZXtciaxTKFBiui%2FX@yury-ThinkPad/T/

Now you're asking me to merge it separately. I don't want to undercut
arm64 folks.

Can you guys decide what you want? If you want to move
bitmap_read/write() with my branch, I need to send it in -next for
testing ASAP. And for that, as I already said, I need at least one
active user in current kernel tree. (Yes, bitmap_get_value8() counts.)

If you want to move it this way, please resend all the patches
together.

Thanks,
Yury


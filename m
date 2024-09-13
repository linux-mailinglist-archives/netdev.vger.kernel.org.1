Return-Path: <netdev+bounces-128128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F8297829F
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEE7287732
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2398F11187;
	Fri, 13 Sep 2024 14:35:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792241EEE4;
	Fri, 13 Sep 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238154; cv=none; b=DLqCDA0w82RcZsmohIyzB1mdAo9czNN3nJLHrms2LXAV8bBR3Yd9C8j/H4nKnLEV9/UF0a6WJU0U9ke0lJZ4XUpvZ1anJQHwKOMQ39KClz8JpdhUNBwYgbq9PMXNkfDx/PDPzOtbh1I0wpHt1xotws0LbP01KAHWSTfJzqkivno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238154; c=relaxed/simple;
	bh=JhyTzo3aikjjpTPzSV7Kvz7uheS02ArPm41bDT4HB2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koY04GYUqn7NdBc/Qe2NW/RLNCZIJ66dFfaqthke/l0qb4CH8hFWk2+H4Oa0HvP5djaUXrPZLEAV+//eb7VuZzGfAIaGZssgvcT6GUL3n/JDOS6wUy8eGeWmCY8gXpkj9JqTpji7xaWakomkBrUTqgIG5oennO/NHl67sijxz/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86e9db75b9so314732166b.1;
        Fri, 13 Sep 2024 07:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726238151; x=1726842951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm+dR1664dPEgPhcRetqbGRDVSXQa+mLM+gJeE53tFk=;
        b=Fx92yb/M1N2BU4TePTiFN9sSe7WNZgOJ5CZtFZ+iEs+y7ARVNt1rP9nUpNKQwyuzy5
         1OJiRrRJRskeUY9idItidEgvyFYwDDgR/R7XksMn+njJcPuMhAI6QWZIwPLLIAhDC/OW
         /USl0aZjuLuQ9QivxngLK9KxqgZBKYqI9dszAMK3W7dtD2nw86x6JNYioivrP+O9Xd+z
         sLPBZb/VgZ+/HPUY93ppKJBmbdv6zOyIx13tpkQ/J96HmqO7Sua3VuN30VKua2iIV4k9
         HWYOvXWGifpMW7ladoMeqT4y2zwJAKaU9bsrA5KYICdPnFtJ/UZxUA/KO0jPYADeprpr
         avuw==
X-Forwarded-Encrypted: i=1; AJvYcCWI8yOmu28MUYXF85L9qOhV7mNYhekGcETBs+xinIbjfCOnzFsLAaGd7R+qS1u2cVlXIYfzeePy@vger.kernel.org, AJvYcCWivO/S4qLt87gl0QeEeOx2UmUYN9vOgdTk1BbKWOXKSeniYscKP+CnKbwTCn2Wc902lq+2CduO4kWe9MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8SDix6XFeuznnjysuKQVxpkvaCCH8GiEirACRn6UwrGmDt7D
	dSCEjRYanL5zLrWlstm8tB2x186vuf3V3QhH9FLqER/ahEwSZLHA
X-Google-Smtp-Source: AGHT+IGr8SNoeb9wf25etpq18ndZ099n9SGFBaifGuHqgJte16C3gDGByXZ00Spu+gnwLZ/nyUDEbw==
X-Received: by 2002:a17:907:9618:b0:a86:ac9e:45fd with SMTP id a640c23a62f3a-a902974b93fmr614825566b.62.1726238150089;
        Fri, 13 Sep 2024 07:35:50 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25952c01sm882882066b.64.2024.09.13.07.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 07:35:49 -0700 (PDT)
Date: Fri, 13 Sep 2024 07:35:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] netpoll: Make netpoll_send_udp return
 status instead of void
Message-ID: <20240913-honest-mindful-ermine-514d3e@leitao>
References: <20240912173608.1821083-1-max@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912173608.1821083-1-max@kutsevol.com>

On Thu, Sep 12, 2024 at 10:28:51AM -0700, Maksym Kutsevol wrote:
> netpoll_send_udp can return if send was successful.
> It will allow client code to be aware of the send status.
> 
> Possible return values are the result of __netpoll_send_skb (cast to int)
> and -ENOMEM. This doesn't cover the case when TX was not successful
> instantaneously and was scheduled for later, __netpoll__send_skb returns
> success in that case.
> 
> Signed-off-by: Maksym Kutsevol <max@kutsevol.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for addressing it. Two things you might want to consider:

1) There are some warnings related to this patch.
 a) Not CCed maintainers
 b) WARNING: line length of 95 exceeds 80 columns

You can see them here:
https://patchwork.kernel.org/project/netdevbpf/patch/20240912173608.1821083-2-max@kutsevol.com/

Also, this might conflict with the refactor I did a while ago, so, you
might need to rebase:

https://lore.kernel.org/all/20240910100410.2690012-1-leitao@debian.org/

Other than that, I am happy with it.

Thanks for doing it
-breno


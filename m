Return-Path: <netdev+bounces-197126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB31AD7996
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F17A7A83CF
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A39829C32B;
	Thu, 12 Jun 2025 18:04:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9D29B200;
	Thu, 12 Jun 2025 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749751491; cv=none; b=FvuXqssZY1obFs1OTPOVNdLVuP+bUdp9lgLiaByHrxTpDZAjGyvxXc8zoYhKPzBdJNnHOXXmt/eNhk5mrrmkIsCX29ZfJJYOiqGc3Ee1Z6QSNePlKIzmUbYe7ii1oJP/u+0pPKm+9UxKIHRku2/hXfiJluu6kzHoJXCDouJxBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749751491; c=relaxed/simple;
	bh=w4nmA+td2ExYiaBNDnEm+Ltur33N4rnCwWlrsEz9qx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsYZSkaqKOhx0Q48Hb76KE70b+VBUBF13zoOuZEpu37UGuTocjRfd50TRclLlx0nA4gUZcaW6O/By1aGU1nODGQZ1WZ2c4JFeeiEJLZsZofaVsPWk6yRitsedsuc72Dt9GKHDsE7iU9wGlsRN9vDz6Fl2Yn1jfj22WghS1jE1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so2238425a12.2;
        Thu, 12 Jun 2025 11:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749751488; x=1750356288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNunZIgYlwEtLu9L7BQi2+QkqU/Yq8JzmhNXkx9O8/Y=;
        b=Dw6lt2jnxHGjEUlG7fOi7W651HIGWtjT/X6sCAmSvrRqjNXhySc5shRTSSgqDQXNE7
         +mSBf1vxzSo7pDkIeQzPJ9TYlsh268/nj/sWuqxyVDp9SMVbHptSZtIEfuvyHzkkFU2j
         sjKAq+I2/kiYGojPJ6VJYTDicz0j0d/0Yrq09OWJF2qdLWe/vBSsjkNbdrSHf9x/hSIM
         ZkL9xgMiTaDdicDEjEy+pA7xedD1x1JazfgflgfHvMl3PewdWRag4NCyJWgp5bx/oEgG
         qVWGGEhfdTjgChYye8ZQFTSfFDcHu+RxNsLJBNfd4FKyiX0JwZ2QN+KfIBa7KfO4l0xb
         vi4w==
X-Forwarded-Encrypted: i=1; AJvYcCW4GKd1fHjglgBvo6FfvPB7tsGhJAlYMdL46EqgEz0TxSH0TqgY2Q369qUG5nlXuez2fFxvnYrB@vger.kernel.org, AJvYcCWNaE4dDe7yZ18maCLJK91LxbEwDLYLsYK23kMZrQYCCxR28jTArFtU/1h57AG+wtVbbhfgS7tauw3extA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwskjXqO+/ou/Wwz1a3BmuVc1sSivpJiwXlfuSTEusN3+OLyl2I
	a7I0Lzm7wNtSP4GvJqh1kQiTO3gMCWxn7H5Ok4e33VW6UwspaTn+8gqL
X-Gm-Gg: ASbGncvOsnvybrcHhpKN0iYjDgLfO6Jytwy6aHJEWvCY+9EQ8SyvaZfLfIRh7Yyrd82
	nc96uvoi4MSVxHN1m31iZXHzlnGiFK9hSpiEmR+/D9Ulhw+M5Nr6zmdzUpW8JDQMtycdi41WTU/
	pJgSjuvw9XjVQlEAQ7ZNHiaqW7of9kJv5qUCTW32FCPQ8g/pUW1tpoKZgSTS+LbT1SlluRliDq5
	STRjvyRnUBUJqn09yd5IKnMVHChxJuxGLuuluohr+EssgA+cYp5zvJ1lA36mOU9yvWqAXvPeXA8
	Rz0j+HSE+cFXS4fuWXf4dPKLe9k+lke514NNDG0Db+1rZmnW2A==
X-Google-Smtp-Source: AGHT+IGc8l4XV7XaWNdsUBfEtSOZFeyD8ieAOH2P/GzmS2eLYMPjEoV7DIpAN6MPaRb5Fn6AFKwxmA==
X-Received: by 2002:a17:907:6d1c:b0:ad8:8621:924f with SMTP id a640c23a62f3a-adec5d6b20dmr20554366b.56.1749751488133;
        Thu, 12 Jun 2025 11:04:48 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adeadf3bb7asm171135166b.172.2025.06.12.11.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 11:04:47 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:04:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Damato <joe@dama.to>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 2/2] netdevsim: collect statistics at RX side
Message-ID: <aEsWvciIxKqlD2W8@gmail.com>
References: <20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org>
 <20250611-netdevsim_stat-v1-2-c11b657d96bf@debian.org>
 <aErjcH3NPbdP7Usx@MacBook-Air.local>
 <20250612074503.1f80b816@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612074503.1f80b816@kernel.org>

On Thu, Jun 12, 2025 at 07:45:03AM -0700, Jakub Kicinski wrote:
> On Thu, 12 Jun 2025 17:25:52 +0300 Joe Damato wrote:
> > It "feels" like other drivers would be bumping RX stats in their NAPI poll
> > function (which is nsim_poll, the naming of the functions is a bit confusing
> > here), so it seems like netdevsim maybe should too?
> 
> Good point, and then we should probably add the queue length to
> rx_dropped in nsim_queue_free() before we call purge?

Thanks Joe and Jakub, and after a review, I agree it might be a better
approach. I will update this patch with this new approach
and send a v2 tomorrow.

Thanks for the review,
--breno


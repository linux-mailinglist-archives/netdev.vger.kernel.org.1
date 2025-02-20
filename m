Return-Path: <netdev+bounces-168108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B87A3D88C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 234477A512B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FB21FCCFF;
	Thu, 20 Feb 2025 11:23:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972C1FCF60;
	Thu, 20 Feb 2025 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050583; cv=none; b=Gyv7LF2wnCrl/KauB0Ax3peMEE5AmX586jBuuqFAfqCrp+lIZSoiRj3ihMwsB+qTPFjk/hZnNQQMK6FP6jCSTcuX7M9iSsXy1YsnWkJXjc224qNuyGW5Ab22sZMAisKT4jj5DcpvYFDDYxl5m38ec30HRobR78t1/gX7GHpcyt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050583; c=relaxed/simple;
	bh=937swDBv/4tESpJoLAiVpvmztTsdxbMeFlQ3HC4lwKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUcv8RGEPjl4qoUXrO4GFMQ3Wy/u+dy2JvuXt/fQOo/NorTx9MKa6SU5PccEVWDOV8dUbeL74lkKsJOrVcoLH5kcTA5PU1j1ovWhvz9zmgDNrxqXHfKFzySMWwBSO1uQFxWnQ9XFuD9tnbJqoVm6f2vj28xZ3LToX5cl3whP+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso1080559a12.2;
        Thu, 20 Feb 2025 03:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740050579; x=1740655379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XD9odAiTaOoZIvBUhB+j1xV7nylcFW+OianwZ8HY0v8=;
        b=o5o2vApjkBfAvorVgX+xcBMVBSwdUSFfYHHawyxJYWcIhKRb1kp5wOqt8Xxy0aNvVn
         vbA5UNFjmWM4gI9vNPNFUKiyqDryQ4mY/6/eRa28ucxExbOCboJNKwgBeZ3edh94NRH2
         zgJ+y++Jx86WOSi/PgOE7bBHH2my1KP4/MI4t/KW8Rfo7kdS8sp/NpeA72r5ht37zfX3
         M+8bnX/aOuLdOBTwcGdDY3y77/RrQsWnb9qE9kZf3h3ZrPdtc2PY7k+v2KWmeIcZxQ0i
         VMPl7FaFW6mXEKJ6Yv/r+QlckmL47Csx7h8hnPe54rBvXvSvjrx+JJyw6KbTCQQSxvDL
         bk0g==
X-Forwarded-Encrypted: i=1; AJvYcCU3nKK4JHkdu3X/2yIU2eXzfqa7eX8fEVLf2hDAb6/vAtqcY3A6iOT1bBwJ7Jx0oynyR/j+/OWLMQdpoUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBNNl66DuXk/s5aTeTM67clyEImGDEHwP8w7XN1HiaU4uu4hEI
	3qMqTRJmdGcHoUiT2b7vn+OznhrvCeWNZYsBZj9etB6tvM19S3LR
X-Gm-Gg: ASbGncvYY36ejR1lZLeQhYg17X7/LJla72aL0wlb2Tv6do52/Zb+4qTvIGcBqzhJQNw
	o+A9DY/i6L/KZLxlfSfzu5v468jV6uh8SIDZW1DOLCvpSUiACuN9GEQbxE61KBUkFsDB8SMh2X4
	suxxCAapqKKPv36PP1h3NtuKabtLy3d/XaP4/opxQ4esAqjIkX+eS2XOht4niRtiuXcurJxYb/U
	VjYEAEk+IFahJE7CZLpxUalqL3YoS1giDYLgKrI7qBFX1gWbi7tKBVoC87thsQMeWaGwM5Z+RZb
	Wcg16A==
X-Google-Smtp-Source: AGHT+IHT5LXolvtX2+Vm9JGvTxa3pFzLchGGSykVFvDSmRcx7IyyW9y2kALsn2C/3qJ5lwGFuTKviA==
X-Received: by 2002:a17:907:72c8:b0:ab7:f245:fbc1 with SMTP id a640c23a62f3a-abb7091d9d6mr2190619566b.3.1740050579019;
        Thu, 20 Feb 2025 03:22:59 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9b81aacdsm755900766b.104.2025.02.20.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 03:22:58 -0800 (PST)
Date: Thu, 20 Feb 2025 03:22:56 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] netdevsim: call napi_schedule from a timer
 context
Message-ID: <20250220-spotted-obedient-chameleon-2cda9b@leitao>
References: <20250219-netdevsim-v3-1-811e2b8abc4c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-netdevsim-v3-1-811e2b8abc4c@debian.org>

On Wed, Feb 19, 2025 at 08:41:20AM -0800, Breno Leitao wrote:
> The netdevsim driver was experiencing NOHZ tick-stop errors during packet
> transmission due to pending softirq work when calling napi_schedule().
> This issue was observed when running the netconsole selftest, which
> triggered the following error message:
> 
>   NOHZ tick-stop error: local softirq work is pending, handler #08!!!
> 
> To fix this issue, introduce a timer that schedules napi_schedule()
> from a timer context instead of calling it directly from the TX path.
> 
> Create an hrtimer for each queue and kick it from the TX path,
> which then schedules napi_schedule() from the timer context.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

Looking at the tests, 3 of them are failing:

https://netdev.bots.linux.dev/flakes.html


2/3 passed when retried and just one of them (ip6gre-custom-multipath-hash-sh) failed
also on the retry.

Looking at the flakes, I see that ip6gre-custom-multipath-hash-sh was
flake during yesterday:

	https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=ip6gre-custom-multipath-hash-sh

I've testd manually it, and the tests is passing:

	# vng -v --run . --user root --cpus 4 --
		make -C tools/testing/selftests TARGETS=net/forwarding TEST_PROGS=ip6gre_custom_multipath_hash.sh TEST_GEN_PROGS="" run_tests

	...

	ok 1 selftests: net/forwarding: ip6gre_custom_multipath_hash.sh


So, from a NIPA testing perspective, it seems the patch is good


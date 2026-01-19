Return-Path: <netdev+bounces-251085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BE5D3A9F2
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36E8430022DF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2DA364EAB;
	Mon, 19 Jan 2026 13:10:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75671364E87
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828213; cv=none; b=fRoJjDT8SOPGVCrCpxO5i9g8zRE31zMKIGlNIxea+0ofPCvR2YXIeDGC9D3y5HShDUKCyHee7it5zFN1w7RVDG/JqoUmKf1m0u4ErCIbQBEX33OQhtAPCfGip2FPcIGWozjKWRzZyIybEn6Bdh/sPrB3PVx5OpYUnv91pLmeAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828213; c=relaxed/simple;
	bh=7Zau4Q3L+wZoTMe0dwbmPaGjdSy92gfx9V0yzD0gCIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxtfs8oi2u/VR0qr2hddLKYQLdUkdvkYb97A9l/A1ZLLHSOeYCC3j35edWuNZPmDAW0I63DZiD6h3c76VprdTwH51Aj6AUavAZuuntYyTpsSlYTzD6IKJcYfyR4z1JeTIjaPOhs6B+NlpPHzCFIWHA24TQSuqkJKaHpTZpXcS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4041500d9c3so2790747fac.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 05:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768828211; x=1769433011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcJjT+zAvg6W3xCA74ueew1cpFbuijNuFU3eUN6vwuI=;
        b=FlzyB0yP3Uy+8wwNaht+uGRV3mVTtQtRddK7JEam17rzH4Uxtkx0gV2BQh5FvDBX3V
         fpMZgPIiGM19rVEP+ByqksQKkl123wV7FYjAJGtAtwm8PfoWgi0QszZzezCINd+RCar0
         cFOr2x7O3oDzZdNQb4ZpHJIVqDI0G3UST8ukAUpPO34QFeK4hVvFWMXHwXpY1HHbwfWu
         OTB+BLC2dYIbla99YS1yWN61iSBAW8YQYyQSyOPb1+CKKqpaubJxJtEksv9qnkg/7oMe
         BKlhtTw00yvOe/pktBhZNt6ZkJYG/wUUxAYt1zwYZ0fu1fD6xZsZwSLy4pR7L7OCqFUP
         WCkg==
X-Forwarded-Encrypted: i=1; AJvYcCVKYwTBOmud0d99SBOlnWLjCIn611AkcdvJW/V6P5r7ZBpK2nZNi6j2O5TFc8cMxvGCuhtQbQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bMl3XmFVYdYnnJuQIbObeiRGNmzGT4FAKN5HL/TWKtD7KtWp
	QEHRU9VQPKPw+jsKLWJbe/PtWI6J/Xr6wPMsn8/BDswHqCDOJ6/pZvj+
X-Gm-Gg: AY/fxX6lOuW2lQHFSHURvKCnqXZmOuExtB64CKxyssdwu0vRiPkO6Z23OabjaBVfVVz
	1M/dJkw9OR3rR3CH4mn5HWEG4E5JLXIQtKXrfV7bD1XBtMgY8u2idFCRbeaKmyb/Gmr3os4Htfx
	zjn5BHpsOJCwZAu/3kSokIXf8oTSu8EkhN7VJKRYQ/Ak3P3BPc4YMf3oeZJgvPZ1JSvSpV2LW9c
	nOvNgXi1Zsz/qlf2CTr7c7baqPRNHHYrjneOqQm4fCOLJK417XbLYU9gXiG2Jr61pWGlECFD4l8
	uTkh15k5QkEObRnYS9/XudJ5wVInUjjiNv0lLWtTpScwDORLUPRtrBA8IzSjm1U4bEBrzNBn7Us
	9bEm3mPBI/OJ2D2KsUuVZ72RdCCWSdjDXtupqgnvQ5sCd/iK6YKjz7Kh4bl8tr5s6ZsSzFQG4o5
	Z8BA==
X-Received: by 2002:a05:687c:2719:b0:3ec:2fc8:97a2 with SMTP id 586e51a60fabf-4044c1cf3d4mr3903361fac.19.1768828211425;
        Mon, 19 Jan 2026 05:10:11 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bb51d4csm6787856fac.6.2026.01.19.05.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 05:10:11 -0800 (PST)
Date: Mon, 19 Jan 2026 05:10:09 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 5/7] netconsole: introduce helpers for
 dynamic_netconsole_mutex lock/unlock
Message-ID: <ss4qejqrx2vtzbv7gpq3n3b2na2hqg6jmjuzc7jgfubjuie2cq@ql56alvspndg>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
 <20260118-netcons-retrigger-v11-5-4de36aebcf48@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118-netcons-retrigger-v11-5-4de36aebcf48@gmail.com>

On Sun, Jan 18, 2026 at 11:00:25AM +0000, Andre Carvalho wrote:
> This commit introduces two helper functions to perform lock/unlock on
> dynamic_netconsole_mutex providing no-op stub versions when compiled
> without CONFIG_NETCONSOLE_DYNAMIC and refactors existing call sites to
> use the new helpers.
> 
> This is done following kernel coding style guidelines, in preparation
> for an upcoming change. It avoids the need for preprocessor conditionals
> in the call site and keeps the logic easier to follow.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>


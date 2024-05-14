Return-Path: <netdev+bounces-96343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB28C55C1
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C8FB2190C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714F81E4B1;
	Tue, 14 May 2024 12:06:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B647F4B;
	Tue, 14 May 2024 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688392; cv=none; b=ik+2TF6mxlGLHc1uvJ8qy8YhW7xSdkUrx+7YwON7r8jEjTp0UDMzzYxgllcNe3o2Nn0qHu2QqrhPNm54xVjxyfwTD5s/BVIZwcYE/5YUUHhgfPUGc/fiyKz/UxjjP+4u/0suLdFRBY5vzTK/QywPw2K1BGzO+6kuSHgatMhw4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688392; c=relaxed/simple;
	bh=9155WRY98DaWbSA/SvQg5vVQwzBmCC5BMumb5sZl11Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoLMqbiRz5tYKTdUg1zTMLKN/rxUuD9sDarrCOExxSKcsARDyrCMhPvoMRZTjTqB2E8JdhXx8by41y+8rZfiD9g4b4p9vVSKuXgrgFkRukihqa6h5pjmay7w2Nm0FeoUMzZTh5NCg5zcH3Hx9M0NQOEG7kQBa7A8uKjGFJe2txg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso7584007e87.1;
        Tue, 14 May 2024 05:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715688389; x=1716293189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGkgGEHSqVLLz9R443YRfxbCiDfzB4VKiKAy/L5beOQ=;
        b=hbE63WYkYw2MOUhF87qDBuouYmARVPnTIxOGEjANiJHwLGBz7MZthZcNI24/YNwXJa
         mHpFw/Xd3hsVARmze9LNkcYR7ND08AB841HImY+L/5nxg1xO/VzjCsQYjVG9Uav/G5mT
         gvIIQBO/kVAAyEiDnxSMYtyqJi72O1BwlYYr9MAF1x4VAsG4W0P/bGgOS+/aSZE3B8mk
         D6YjyIVVle9EZe07BAOKp6g/YKzyE6mvHJqN56Lm1vbcdB1gVRE+pyBUd3tWkKPWXNnO
         ojOsLjR5GKsTVR33aRP9CVmVG6d1hcx5jVavpXFHrHcUeDL2it1dINu1LLcQxc0VSAIh
         t6Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXfIWWoBwi2jBeNAWo8Qk/g5WLi8vMyqlM+9A7KTocEPzzt0u3fx5gsM3vZ9jN1jbJjWgl3VlTAyO/pUeQqaPjqiq8xLwHmNJMa/IVAHqsY5KuhhxCZWkrgEVu7fbajP3uFLj9n
X-Gm-Message-State: AOJu0YwXzOnfVBuobxSakPnSWe1J44lfxSynd3wdbOHfU5S60kQU/6T0
	GaPZG1FRW73eGqjdXWB0dyAE6QLnGXyVzawvPbknfbaQXWvmST6L
X-Google-Smtp-Source: AGHT+IGMr05Y60lrruFUFnI8kXR9DXre6tVIZf/nmdvmabZ4MKTWKPmXc2BV0Vh2JS6zNm6KK7f/yA==
X-Received: by 2002:a05:6512:a91:b0:51c:a0e1:2a44 with SMTP id 2adb3069b0e04-5221006fde3mr9451845e87.26.1715688388551;
        Tue, 14 May 2024 05:06:28 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c6ffsm711848766b.49.2024.05.14.05.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:06:28 -0700 (PDT)
Date: Tue, 14 May 2024 05:06:26 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	thepacketgeek@gmail.com, Aijay Adams <aijay@meta.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] netconsole: Do not shutdown dynamic
 configuration if cmdline is invalid
Message-ID: <ZkNTwrlLLol1w4gw@gmail.com>
References: <20240510103005.3001545-1-leitao@debian.org>
 <20240513145129.6f094f92@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513145129.6f094f92@kernel.org>

On Mon, May 13, 2024 at 02:51:29PM -0700, Jakub Kicinski wrote:
> On Fri, 10 May 2024 03:30:05 -0700 Breno Leitao wrote:
> > +static inline bool dynamic_netconsole_enabled(void)
> > +{
> > +	return IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC);
> > +}
> 
> Why the separate static inline?

I thought it would make the code easier to read.

> We can put IS_ENABLED.. directly in the if condition.

Sure. I will send a v2 with the IS_ENABLED() inside the if condition.

Thanks for the review.


Return-Path: <netdev+bounces-243451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DC3CA18D4
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 21:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D9EB30022E9
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 20:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6C311C39;
	Wed,  3 Dec 2025 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZgKVjFh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0882BE05E
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764793574; cv=none; b=f4oNlA/mp6dmVjwJVmRiyeFffUxGdKoQeTURz5KkctSm9oB3vorIJpvU5ECsP0CbGE+LmuVqjxnMgYUt6CuSSzpohqQiCVHUJroYFTe3CT1YTKTPvQbvv+BqZLbQ3ERPunAsvjMJxlzMl7mA6bHJ92M1QLKyz7ngQn2YoA4sSRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764793574; c=relaxed/simple;
	bh=YEqoF5SzZx116Sccpcvt4hXy3j1TYKypmL6WYWEBLec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTdbI9ZpU8b435OY+xS7jAO6AcC3x4L/0Bs5SAZFHXkjPnc/QwKV4H/dJCIgRGpG6++zB0Fpg+s8eRd0gTMg2AzjbBkvdDT5gc4DbkzI+OpNk2xF6kzQ+4N0VvocykSofSp8LTcjUYAMFZjD9SIZHLXXkGps5hxnb+3mT2/sgj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZgKVjFh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47798f4059fso249405e9.2
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 12:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764793571; x=1765398371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4U+z8diuyXhssitIdfr3VF+3PrEfPEyJkTdI0+umjk=;
        b=PZgKVjFhY7XC2vIqYC5Ntqfen3siC8/LLbsfiK3a9SYyF/9ypYQTq07sV2eI6HBb5Y
         EPQ6/Tj4wZA+kNRwM3qeSeHdCAQOCXzDmeiaaoXWJ4y6kgalbZMuX5EhZI9ZvTz30FMU
         5BsfN8wRnu2Hd9nQke/DLJCIdSqXK6qNTOz5j0HFhVLyUAu/nvZkXyO2yWkImb/VpIsl
         Q0Vis5lGoP/mG1iMRwoBe3UdZxcfrdnWRulzOyJlwu34j2e2m2pzipW5VLWzUXwhMuxb
         J52kKYzI6HZQz1tfS7Bf0LHrOIS30tsdBmHKQqJ7TKdclTTv1uhCnUWg6AbegcB1Lhru
         Aluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764793571; x=1765398371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4U+z8diuyXhssitIdfr3VF+3PrEfPEyJkTdI0+umjk=;
        b=A5ABv3MJBvaeg+GTtzAHF+mz+L7/lTkaySs5iKEACVk4Q2ahxS0na/YcBLOu9vAqM3
         QxhixGTOaZwRm51noQzEZWPxuhoNLZf3vzRboiDcp4HLDKZ0L89Fj6xiOeW37fGxGMzA
         UUoXdXA1t9MVJEAg7qOlchMmAO/568/6dFybmnBEvYO5HtsHTeCxchBiatTKKy/aE3wt
         uf0hthOfSSwcfE+83/GBY4kZTNVsmkpGOby0DEg79QmnZ9Ews67/h6zCROg3rfzCZ1t9
         b7228LiUmFQ9ECKBr0CH0HPXJsJYhF1OhI7lX74ZojQlFVUO+9CEliY231oWC+Jw5Qe6
         TJWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyJd+xJ9hmA0uNp0MrmGB2ml8D/Yi/lkiqs5RgxkODTJNBE34OMwM4AOfbZLPl8eDglvjxbIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRNwG0JSGk/rAbbziv9QGnMhhRDS5/ZkPgEPRxUiYjjOOMyN6C
	urlgmZo3lnm6S1gly122hB5jL5P6CrSMTKFSq5SBY34S9sX2GhmRYT/Z
X-Gm-Gg: ASbGnculJz3KDDM1P5j9tiRhfoiR1uG4lOQLoSmKjNjA7Mc3BryBi1igEhq6K3dJwHK
	ZjqD0W63ivrZiy5I9tQztwjpPF4kP/3YHmnKD5v5gTWm2qeMGaJuVgAr3cLNessonWE/GtJXaao
	1XAzTL1n5wpFSb4LyEplM3my+jFmPlO275hY9t4sgX7ssjQ/ANXnllFQDi+1mRo8YzJfn4mq5IR
	/ReVD066HgZviIQ/DZiM0FWXPIduFApCdAKuOFzzf35WtAHVBdTtB01aV+IcZJyw70jATs7KF0i
	0yg9TDmkjafzB54vuyJl8Yq1O8VGQLEAD5m5nfttV8SneOzdFNjeeU8LRWlaiuyn4ohO1FyRasp
	t0ELJUs1dSdq3/Jsh74ptMDC9Y1a/KRdI8JRJVq4F0VdaPg34ULIzoM5zCsWeC6cn04ZcKzrLuR
	JPIv0=
X-Google-Smtp-Source: AGHT+IGQX4FBRFi6oZxQ8snoDehTEr++YiEbkXccxBzPY9CWH/aUFpQkryVpXYyT9Si1SaWtVfs3fg==
X-Received: by 2002:a05:600c:1c27:b0:477:a203:66dd with SMTP id 5b1f17b1804b1-4792c8ac743mr18376385e9.2.1764793570705;
        Wed, 03 Dec 2025 12:26:10 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:bbd5:36b7:a569:69aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b157783sm26556215e9.5.2025.12.03.12.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 12:26:09 -0800 (PST)
Date: Wed, 3 Dec 2025 22:26:05 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 0/3] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <20251203202605.t4bwihwscc4vkdzz@skbuf>
References: <cover.1764717476.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1764717476.git.daniel@makrotopia.org>

Hi Daniel,

On Tue, Dec 02, 2025 at 11:37:13PM +0000, Daniel Golle wrote:
> Hi,
> 
> This series adds very basic DSA support for the MaxLinear MxL86252
> (5 PHY ports) and MxL86282 (8 PHY ports) switches. The intent is to
> validate and get feedback on the overall approach and driver structure,
> especially the firmware-mediated host interface.
> 
> MxL862xx integrates a firmware running on an embedded processor (Zephyr
> RTOS). Host interaction uses a simple API transported over MDIO/MMD.
> This series includes only what's needed to pass traffic between user
> ports and the CPU port: relayed MDIO to internal PHYs, basic port
> enable/disable, and CPU-port special tagging.
> 
> Thanks for taking a look.

I see no phylink_mac_ops in your patches.

How does this switch architecture deal with SFP cages? I see the I2C
controllers aren't accessible through the MDIO relay protocol
implemented by the microcontroller. So I guess using the sfp-bus code
isn't going to be possible. The firmware manages the SFP cage and you
"just" have to read the USXGMII Status Register (reg 30.19) from the
host? How does that work out in practice?


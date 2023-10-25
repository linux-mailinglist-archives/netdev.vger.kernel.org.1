Return-Path: <netdev+bounces-44141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BEB7D699E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BAE1C20C5C
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 10:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187F826E09;
	Wed, 25 Oct 2023 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx1ldWRH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2E1A58E;
	Wed, 25 Oct 2023 10:57:45 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F93131;
	Wed, 25 Oct 2023 03:57:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bcbfecf314so1207874b3a.1;
        Wed, 25 Oct 2023 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698231463; x=1698836263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPV1eC0VX1GKRD0tECZNDnHG0ZRaMmkIackM1YSkXwI=;
        b=Jx1ldWRHDZItvKx8ZqhFtdq+QuHi/UPmImcQJuvazN0Kh7UvsK4kcfCVkN4kS/2yax
         lRsLUbOa7JEJ5RZ3YFRN8UDJ78zLyqrpnLXXCVr+fbX3UpEV1XlGM+L2Rbzc7BSSMEwZ
         r4f0wP5cBRIjui6bOZVqS+X8hTPaWpk1hkch3K7Qhx1/owB6/5MnTowwcwjrn8451VEQ
         PJzBaGvlQfEZ8rHpCi3v9s49q2GFKynRLXYaf+jCP1Yqav6aiWT1V76yckB2CIGAW/JM
         zravFl2FzeiEK5ZWcdNRbztXQffzr1juSUijtyLYF9sTIvpn1xMiTfyKukNrksvZPmjE
         KMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698231463; x=1698836263;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZPV1eC0VX1GKRD0tECZNDnHG0ZRaMmkIackM1YSkXwI=;
        b=Fdieh3luf+3eJm903J3hV4R65hnJQRBHj7Nq/b/SKBTRBOEUD0pmIvmd9qgVl6GCJK
         cRFWDvpcKg0tfdCbuDQC8yF7yTnK/D0m65BKZMV6c4mphgTosTEEPMmV1xltR9E7nuOL
         7fbPXPWCIocNzkua5ugHLE5d+VZw3CDE54/xLfr9upc622x/Q10WEuefJ6F2yZe/6wVB
         FTKdv8oRqRybbqAVXYfuJUmyZ2oFn6fX67oL9fSuB5K5STVSVPmMnx/ax1+s9UM+ja8s
         TOUROCq0pzDg2Xu718ChQ1Mvk1WHSXe2RhPahJ+TDUVuY2Fn5rlN6nGqCIVCohVpu7UJ
         dLZA==
X-Gm-Message-State: AOJu0Yx6QOeGSqNrVFZtLUmvOqx9rkRCKwH6cvkFLRK//AlWo9cRVLKw
	NxlbZ3OfpBh+9A3+zj6uL87pinQHavBAu7vG
X-Google-Smtp-Source: AGHT+IGX64kVo/YlorKG9TSNQ3dIMcsdZWIZIfYl1HgrB+BFik7GHlYG0UeebHLEFudnkGtpZDd0yw==
X-Received: by 2002:a05:6a21:8cc5:b0:17b:170c:2d11 with SMTP id ta5-20020a056a218cc500b0017b170c2d11mr14041640pzb.6.1698231463117;
        Wed, 25 Oct 2023 03:57:43 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id e28-20020aa7981c000000b006a7083f9f6esm9107629pfl.23.2023.10.25.03.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 03:57:42 -0700 (PDT)
Date: Wed, 25 Oct 2023 19:57:41 +0900 (JST)
Message-Id: <20231025.195741.1692073290373860448.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v6 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <46b4ea56-1b66-4a8f-8c30-ecea895638b2@proton.me>
References: <1f61dda0-1e5e-4cdb-991b-1107439ecc99@proton.me>
	<20231025.101046.1989690650451477174.fujita.tomonori@gmail.com>
	<46b4ea56-1b66-4a8f-8c30-ecea895638b2@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 07:24:00 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>> /// PHY state machine states.
>> ///
>> /// Corresponds to the kernel's
>> /// [`enum phy_state`](../../../../../networking/kapi.html#c.phy_state).
>> ///
>> /// Some of PHY drivers access to the state of PHY's software state machine.
> 
> That is one way, another would be to do:

This looks nicer.

> /// PHY state machine states.
> ///
> /// Corresponds to the kernel's [`enum phy_state`].
> ///
> /// Some of PHY drivers access to the state of PHY's software state machine.
> ///
> /// [`enum phy_state`]: ../../../../../networking/kapi.html#c.phy_state
> 
> But as I noted before, then people who only build the rustdoc will not
> be able to view it. I personally would prefer to have the correct link
> offline, but do not know about others.

I prefer a link to online docs but either is fine by me. You prefer a
link to a header file like?

/// [`enum phy_state`]:  ../../../include/linux/phy.h


>>>> +    /// Gets the current link state. It returns true if the link is up.
> 
> I just noticed this as well, here also please split the line.

Fixed all.


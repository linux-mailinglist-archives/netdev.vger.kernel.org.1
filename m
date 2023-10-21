Return-Path: <netdev+bounces-43204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E20A7D1B72
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 09:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A6F2826B3
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 07:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CCC6AC0;
	Sat, 21 Oct 2023 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jQsAol2Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5367E63B3
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 07:00:33 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F87D57
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:00:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so908592f8f.0
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697871629; x=1698476429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPPlQ+53yQWinjmuFpNAJ31cVJsirVKx8ATVLekVt40=;
        b=jQsAol2Q0IkfddkyYuYwxE+ZsPtkOoNTg/NMGfd1UA9VMWqJNCoDY6g+qz8hrUU1ub
         fipm71Z8aJGXsJf5ORHt7v2OuYmcSEWlA7Su4Thdc8HNG3mIbUhjvoKJYvFBG8IO86d9
         uvNyrfN60psCF1964kGtGPKSHJaajTwdct+ujiDlkCdXXOAJR40I5yC0ylVNTSJh4zCY
         k8vg41CNnrjfrMLp1CdCngROcaEeHiBART/fjzvJ9Yh3kSwgJdyJqWfGS3+ItZ6C7PJr
         eEGZNhVcz7aMsvJ0GqxAYZMPBXKR8H6XurCXw7UokZrMf2YpoYQxbN/EhKNFhFN+UwJr
         JsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697871629; x=1698476429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPPlQ+53yQWinjmuFpNAJ31cVJsirVKx8ATVLekVt40=;
        b=O5SAUe5T+cjLG7tiRex/T2uA0Aipzf3w3j+QonNO2tAhQMCCcKp2ctgqg61kMkfRBE
         6bv5NzbUvqX02N+gPtVxYQPNdb2TSQGM/L+JpFwy0z0KIPkhlAXK8gA4AF3+GqE/0FJ/
         dPtUo8ONu8WcsL2IwG0Z5/QH+meI/BnDVJyTPqaT2twefcaXXBnfkLdWzljIokP2EQkk
         uQAPPGfV9JSHkck4BBW5GE4WR7dhCO9iQFx7hf8qFWmQEpqwNSA35DKy8+5ThEwa+qBx
         8J1IImClEg91T5JkwpR9r8WCjjs004y/D9QIPeKz2ThxDSt82ZD2JED7gm6qK4jDRNB9
         YLGQ==
X-Gm-Message-State: AOJu0YyoHF7lvTAOjU2fxLYz8guT2gGfcVcD3Iv7hzfpFYBCZCG24SNY
	BfinRafcHUhydRcK4dMexhN0ag==
X-Google-Smtp-Source: AGHT+IHSLZdQ5JbMKcnYf86/jR8kJzP7mxH1JRz1Zn8XV3uZk6kf/UB0wEYHqTOZwQKAEe2bv8svnA==
X-Received: by 2002:adf:fdd1:0:b0:32d:dd04:bb81 with SMTP id i17-20020adffdd1000000b0032ddd04bb81mr6314251wrs.17.1697871628655;
        Sat, 21 Oct 2023 00:00:28 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v19-20020a05600c471300b00405959bbf4fsm3841310wmo.19.2023.10.21.00.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 00:00:27 -0700 (PDT)
Date: Sat, 21 Oct 2023 09:00:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes.berg@intel.com, mpe@ellerman.id.au,
	j@w1.fi
Subject: Re: [PATCH net-next 4/6] net: trust the bitmap in __dev_alloc_name()
Message-ID: <ZTN3Cn/4KA+CmY+3@nanopsycho>
References: <20231020011856.3244410-1-kuba@kernel.org>
 <20231020011856.3244410-5-kuba@kernel.org>
 <ZTJYpx5dn4UPa2/j@nanopsycho>
 <20231020120436.7fbed61c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020120436.7fbed61c@kernel.org>

Fri, Oct 20, 2023 at 09:04:36PM CEST, kuba@kernel.org wrote:
>On Fri, 20 Oct 2023 12:38:31 +0200 Jiri Pirko wrote:
>> >+	if (i == max_netdevices)
>> >+		return -ENFILE;  
>> 
>> Hmm, aren't you changeing functionality here? I mean, prior to this
>> patch, the i of value "max_netdevices" was happily used, wan't it?
>> In theory it may break things allowing n-1 netdevices of a name instead
>> of n.
>
>Good point, I should add that to the commit message.
>But we don't care, right? Nobody is asking to increase
>the limit, feel like chances that someone will care 
>about 32k vs 32k - 1 devices are extremely low.

Yes, I think that would be fine. Rare conditions.


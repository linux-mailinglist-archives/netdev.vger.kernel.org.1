Return-Path: <netdev+bounces-63208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D413482BC2E
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 09:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E79B24333
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38B45D734;
	Fri, 12 Jan 2024 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="e4glgK8R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090665D8E0
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33678156e27so5143878f8f.1
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 00:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1705046818; x=1705651618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vhwu0YCFVSGVl8jol1lVQ4CcxP9YFdobdMR6xyXJHsE=;
        b=e4glgK8R7P2KZWNVFEouNFTsBSePLFGlqODcwb9Ck+Ous6ZVCw9L+S+EREkJxGle70
         LbgMAFtUE4X408ojeWYRRftM/81BfOrZmTj8lIOY1A8qGYsS4StCTzakjoF3trQSGjDH
         n8z/pCpMMs3LO3aD/byEKzb7JLDrkv/dO6Iw5ZT+mYRtYud8PVOPZdEuw/uoAlWs9aLv
         /uNycRWU98Hb/PJv6+8JCzLeFGzxD8E6cffjNT04gM0c+wNUSoFzxcIJFS7ONGrfdB6s
         U0C9rXqSoQByotPt0mjp18e7muVI7LO5OZAH1AoIz8aTm6dEL6zA/vUdTHqONAKHc19y
         iBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705046818; x=1705651618;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vhwu0YCFVSGVl8jol1lVQ4CcxP9YFdobdMR6xyXJHsE=;
        b=RTIua2MyMOGAPGISUWSei6cXAK+g9bulZ2hpXOnm/lCmGUvFDJcYs+iEP0zAu1g7Ag
         rDkqooyITTCv7lmxhVWt7tt+Jh64QktrwePU9BVDqvQmHpqqv3d4fNnHEik0SpObRfqX
         wcUdC9IbjOVyXbX9e8k592E9CJfAN5uQo7xiyJnxgmVR+9FXAaXHChUNnVoyrxPExe8i
         6tPLJfQL3Vgz3zg/uEAU1bjD9rNBZ2vHMTe6boiC8jm/veuLG2obdHlEGhAtXPXYDoqV
         mD+00DexMHw0t1Mt2uc1f3ciNvajv8Oq1anDRrGEzX/44omfmha3razfhX6wFaSlGid9
         PIuw==
X-Gm-Message-State: AOJu0Yz+dla+BgsvOIlIWU2/6umCJKk5Dk8AqIQ2rv2WNS+OAZQyGudN
	O3NzaVof6LWbsX8m8PxXrqybImaiPxQTSw==
X-Google-Smtp-Source: AGHT+IHN0wwwv8LxOHhu4cKSd1XEzq26D2q2x4wn5fzzDxJFdN3hKItTYoAHhwYsGFQp4UuR86JXnQ==
X-Received: by 2002:a05:600c:46d1:b0:40d:8a24:12d6 with SMTP id q17-20020a05600c46d100b0040d8a2412d6mr497165wmo.113.1705046818000;
        Fri, 12 Jan 2024 00:06:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:5f4a:c3e5:4b05:edf2? ([2a01:e0a:b41:c160:5f4a:c3e5:4b05:edf2])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d6603000000b00333404e9935sm3109789wru.54.2024.01.12.00.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 00:06:57 -0800 (PST)
Message-ID: <21c2ac76-8491-4e3e-80ba-9c7e5a62a593@6wind.com>
Date: Fri, 12 Jan 2024 09:06:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v4 2/2] selftests: rtnetlink: check enslaving iface in
 a bond
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
 David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org
References: <20240108094103.2001224-1-nicolas.dichtel@6wind.com>
 <20240108094103.2001224-3-nicolas.dichtel@6wind.com>
 <ZaCSog00Bj8GmOZ4@Laptop-X1>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <ZaCSog00Bj8GmOZ4@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/01/2024 à 02:15, Hangbin Liu a écrit :
[snip]
> Hi Nicolas,
> 
> FYI, the selftests/net/lib.sh has been merged to net tree. Please remember
> send a following up update to create the netns with setup_ns.
Please be patient and don't worry.
I said I will send an update, and thus I will send an update.


Regards,
Nicolas


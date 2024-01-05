Return-Path: <netdev+bounces-62127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21908825D38
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 00:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5014B223C6
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 23:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E012E855;
	Fri,  5 Jan 2024 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilSUszlY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322D360A4
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso68504a12.2
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 15:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704498332; x=1705103132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8pYK4P+lIdFBIIU3TAbqmdl+GbJR2C44IcFKNeu4Jz4=;
        b=ilSUszlY4VpMiOIFKa2ZmmwrH5f4AQJRsVaaf1s9Nsf3a34SZoC3rpQVfi90PC/UFW
         UHe9hFZUfa5F0hndwN4XRQNNB2ST/HmIK37/CTfdzvsGFIlr0Z8tABmM3yJV6SBLVMzc
         /pA28oaZgMv/Z28nFo3/zv9uoEyQ8/L+huBpqkow1G2sk0E7OsjPk6h/1wG0fK5jWW0x
         X0nxN65LiDdsOHST9WRQYAchVBLRl0VRmim9y7vIvKAGkSgbkjoSQFyu7rPegPmFKAlD
         RqR3rsfeSFjctAm5lBrIIfYX9s4vL95hVnCwn/qMBzxtEeYoZ57gs6V7yAQPQf+IYh2f
         EBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704498332; x=1705103132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pYK4P+lIdFBIIU3TAbqmdl+GbJR2C44IcFKNeu4Jz4=;
        b=l+Y72KEJ+JUYSrW4RCODuvoaI3eKLN3PP1F22l99jVd+8cW4UVPB9x9VCBd/gbsVxa
         Nq3peQlV7x5opaO3dHSGb3ateKD/2PwC9RLeuY05Oy0OMgEtPZni6M83XyqXkBDglVA6
         iEq/fZCKw+A7hdDaXNIzLx+L6ILLIR6Hh+8+g6mtbPLh8/huKEqrgf4llvE/RYUc5Tyj
         9G0HaqkpXAdqJsEhgVWDknphB3WhLlLddG//hKJzqV4UJzkcpcBgsO+Z0MRFPiAzhqit
         D+9/YB1P3f2oSzV3zQCqoK8ZmKq0PWoQhi5oe2AB1UXwiEiTUeogy9jX3q3QVfPyo+Hs
         BdPg==
X-Gm-Message-State: AOJu0YwDLVjfReCqxRO7NB3xJahqRKox7xqyyOCZshZJfkmayiyIugoo
	9SzL6qJvcpJTRhiTNkfd1QE=
X-Google-Smtp-Source: AGHT+IEsojvd5MnMVyfOtCYQT2S6cEqjn7uFTlgc85xJLGw4WCHZxryNGn0WkVkBF9HB6gJau7J6UQ==
X-Received: by 2002:a05:6a21:9991:b0:197:583a:5e1a with SMTP id ve17-20020a056a21999100b00197583a5e1amr172979pzb.1.1704498332618;
        Fri, 05 Jan 2024 15:45:32 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ey1-20020a056a0038c100b006d9a6039745sm1938277pfb.40.2024.01.05.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 15:45:31 -0800 (PST)
Date: Sat, 6 Jan 2024 07:45:27 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] selftests: rtnetlink: check enslaving iface
 in a bond
Message-ID: <ZZiUl4hVtwQR-z4c@Laptop-X1>
References: <20240104164300.3870209-1-nicolas.dichtel@6wind.com>
 <20240104164300.3870209-3-nicolas.dichtel@6wind.com>
 <ZZdow05irUiN1c8x@Laptop-X1>
 <7fe06d6c-0e4a-41e3-a111-71084972d023@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe06d6c-0e4a-41e3-a111-71084972d023@6wind.com>

On Fri, Jan 05, 2024 at 11:48:59AM +0100, Nicolas Dichtel wrote:
> > Hi Nicolas,
> > 
> > If you are going to target the patch to net-next. Please update it in the
> > subject. And use `setup_ns` when create new netns.
> As said in the v2 thread, I will send a follow-up once net gets merged into
> net-next.

OK, got it.

Thanks
Hangbin


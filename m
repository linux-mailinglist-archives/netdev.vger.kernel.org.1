Return-Path: <netdev+bounces-78817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F92876ABF
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 19:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C96E1F2171E
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 18:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DCD5A4E0;
	Fri,  8 Mar 2024 18:27:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9658ACD
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922427; cv=none; b=UEbBoVAytOpBpb0olXVkRSEEg6BoUFAhl2//t7xd1XQYA3bm92Y9XyegUtYkwOEJohA9rqsEtWG77OrksR3iDXnnKQNm9xcFOrqaVJ36MUkrr4HLgAfGC/kvVTEezrn9olD+vsi0zZiDvGMOOtSwzXjCz5RMGuzD6eP1QJUUVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922427; c=relaxed/simple;
	bh=iXwzuacBofH6bC0a7oSO4vPfo6ryJTiF/nYh3txbJ74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBvpK/Rpj1bY/MiL6Isi0qywglLbBp4UNGMYOn9uJ/BzuM0GI/lqz6WZOKNH96VHXWgdcFCTavR00JU5Bxa3BoRUoENxXRhgu/8Jlj6wpVYafR8HL/fU+RVqhyGDwqwtd2XR6uX+R8PfZM1VwqgIAT2zMHV4qiuPNb9ZXbYDNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso2715970a12.3
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 10:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709922424; x=1710527224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0coDjj/W9udBP2f8Zrmu98g7Pbpaq8D0hcKcPmgdTQ=;
        b=jC/enb+2cf8Kl3g9iysQH/RIIUNomGDzWdBT/vw8Jfxgt7AiIFzMtBq1u1MVyRhUk1
         Cl4c31+MTF1yn40Le7usrcGza/5GUPRDmPfYOW/nFWsPSfk910wQ31F5BpmieZAUGf+X
         UiQPuX75NAMF7ebrVKfqO7JREKCYxw9/vm3LS19Ki1d2oTy1YltWT1DGFyuVPnbMM39Q
         FCjXynH+LFpZrm8k4H4X6vV39qZ1dy8NWRk1NdW4m8kRbAXb3EzCcxmCjHG8VTymu3YF
         ZiFVVvFs/r25AkqHwmADG1i+kNzDcUzPCRHXOBTuyZJAeVLK6dcdRdFeNpdVkqkLucdO
         mm9A==
X-Forwarded-Encrypted: i=1; AJvYcCXppZznD0TyU6hEITxzOoFzsBKpqftMZK/B3Yxv7Fl+SpD5k8F5WHbEszEqUBtLVbluzCKCEenltNm7q8ufjkahkMRqnwfU
X-Gm-Message-State: AOJu0YwvUx1EMwiKdwSvwAvfzb0Dk5FnESq9GQTdHuomQnkmtBsQ98yI
	H+HUmPrf14PGuOuJKnQn8eN4ucVe44DsXJbKYb0OVORLVDY65kY2
X-Google-Smtp-Source: AGHT+IH/WnY2LO42tEbDz1T9ia8NVW+AGNk2DaR8awcZxQxPjdzeLWM4Mtsq1JLD9ZYCx/vEzO+Knw==
X-Received: by 2002:a05:6402:907:b0:568:3362:cccf with SMTP id g7-20020a056402090700b005683362cccfmr53812edz.7.1709922423857;
        Fri, 08 Mar 2024 10:27:03 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id i5-20020a0564020f0500b00567f780d4a2sm25446eda.78.2024.03.08.10.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:27:03 -0800 (PST)
Date: Fri, 8 Mar 2024 10:27:01 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, michel@michel-slm.name
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <sdf@google.com>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 2/6] tools/net/ynl: Report netlink errors
 without stacktrace
Message-ID: <ZetYdY7DXcElIKwa@gmail.com>
References: <20240306231046.97158-1-donald.hunter@gmail.com>
 <20240306231046.97158-3-donald.hunter@gmail.com>
 <ZemJZPySuUyGlMTu@gmail.com>
 <CAD4GDZyvvSPV_-nZsB1rUb1wK6i-Z_DuK=PPLP4BTnfC1CLz3Q@mail.gmail.com>
 <20240307075815.19641934@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307075815.19641934@kernel.org>

On Thu, Mar 07, 2024 at 07:58:15AM -0800, Jakub Kicinski wrote:
> On Thu, 7 Mar 2024 11:56:59 +0000 Donald Hunter wrote:
> > > Basically this is just hidding the stack, which may make it harder for
> > > someone not used to the code to find the problem.
> > >
> > > Usually fatal exception is handled to make the error more meaningful,
> > > i.e, better than just the exception message + stack. Hidding the stack
> > > and exitting may make the error less meaningful.  
> > 
> > NlError is used to report a usage error reported by netlink as opposed
> > to a fatal exception. My thinking here is that it is better UX to
> > report netlink error responses without the stack trace precisely
> > because they are not exceptional. An NlError is not ynl program
> > breakage or subsystem breakage, it's e.g. nlctrl telling you that you
> > requested an op that does not exist.
> 
> Right, I think the YNL library should still throw, but since this is
> a case of "kernel gave us this specific error in response" the stack
> trace adds relatively little for the CLI.
> 
> > > On a different topic, I am wondering if we want to add type hitting for
> > > these python program. They make the review process easier, and the
> > > development a bit more structured. (Maybe that is what we expect from
> > > upcoming new python code in netdev?!)  
> > 
> > It's a good suggestion. I have never used python type hints so I'll
> > need to learn about them. I defer to the netdev maintainers about
> > whether this is something they want.
> 
> I'm far from a Python expert, so up to you :)
> I used type hints a couple of times in the past, they are somewhat
> useful, but didn't feel useful enough to bother. Happy for someone
> else to do the work, tho :)

I am a big fan of type hitting, since it help in reviewing code, as also
with tooling that help you to find problems, since the function returns
and arguments now have a type.

What are the top 3 python scripts we have in network today? I can try to
find some time to help.

> FWIW I reckon that trying to get the CLI ready for distro packaging 
> may be higher prio. Apart from basic requirements to packaging python
> code (I have no idea what they are), we should probably extend the
> script to search some system paths? My thinking is that if someone
> installs the CLI as an RPM, they should be able to use it like this:
> 
>  $ ynl-cli --family nlctrl \
> 	--do getfamily --json '{"family-name": "nlctrl"}'
> 
> the --family would be used instead of --spec and look for the exact
> spec file in /usr/share/.../specs/ and probably also imply --no-schema,
> since hopefully the schema is already validated during development,
> and no point wasting time validating it on every user invocation.
> 
> WDYT?

This is a good idea. I've had a chat with Michel, and he can help with
the distro part. Adding him in the CC.


Return-Path: <netdev+bounces-47921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA5C7EBF38
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C22A1C208D0
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1418B5239;
	Wed, 15 Nov 2023 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA8J11Ky"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3E7E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:13:51 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857BFFE
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 01:13:50 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c396ef9a3dso5687422b3a.1
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 01:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700039630; x=1700644430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=shzSNLKjeBGZlzshuHQ0IDJbnCmF6ysl05Xn7LAj+I0=;
        b=PA8J11KyGVZvG+jiTAV7z9aeM4XLGtOm112IrIYU3MWNPt5NGwak4qFd+gGg8rwFxp
         b1uqHCAtACEAVUSYkX0EMBWACz1ZUtmFvK8c4FDEnB0cnLCvuwCgvmv4BUktGx/Psy/p
         iq+t/A91gT5O+4prJzvxJQar6F+ZChtdMixZOrt+axlRGGUDCBFT4ud+wdM32TB2M0bz
         mZm9B9cxTxxc4sj23SY2QcNges4KMGXFn6oZZYYQyskSHr8nbWGZhyhQTtZKuGu8dCfj
         ykC2u1wV50lpns2LPX/57fF5rB7Poamxt1QpwJ/ZIRbfCl9+6ca+bsfBuz+2aC3e0iD5
         wIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700039630; x=1700644430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shzSNLKjeBGZlzshuHQ0IDJbnCmF6ysl05Xn7LAj+I0=;
        b=WC0apNFSvYq90gl7SOG/uuXT4Jku3VeTjZkQoO3nSWwdJ0ZKXvFQ5widMCsYgfKl9Q
         hN6WH4JZP1nNpT98o0QFzJwYxlh1rWPhC43DCUfJ7J3HB4XJ2Bsdhpsin1m8VT5E8qC8
         cPkrdz+cRsI+T0kI6McNLcsESHVB8xSV0hsvZwaWye5BvN/Pyw/kFFIeqX1c/trCeL4A
         sd8kr+4pG5s2oapc88gBV0nIXtoSmQcAFNA20GEhH89hZ9ry1herZKS0DJsAcpjSRzzG
         7MzcHomus5YEtWYL5hZangZKIcXJ07fNIz4MnLCj5RooDBvNkuCTfkLcwWFfezgTDKjg
         Uahw==
X-Gm-Message-State: AOJu0YzWoYAlr5HoH8gsQwoKbuA/Ela/G4uPbN8o+lVdkNI4iUnYEy72
	mwFpPpXzraH3/g6EoeXlfnY=
X-Google-Smtp-Source: AGHT+IHFDbuiQ0gZVR052yLmTTOLElphtgzDoREVNl+4L2CJ4zCW0FtfOrIY5dcYw1Ee/siLIHq0VA==
X-Received: by 2002:a05:6a21:7889:b0:187:15e2:fe02 with SMTP id bf9-20020a056a21788900b0018715e2fe02mr4752614pzc.13.1700039629940;
        Wed, 15 Nov 2023 01:13:49 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id mm24-20020a17090b359800b00280a2275e4bsm8357826pjb.27.2023.11.15.01.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 01:13:49 -0800 (PST)
Date: Wed, 15 Nov 2023 17:13:43 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC PATCHv3 net-next 04/10] docs: bridge: Add kAPI/uAPI fields
Message-ID: <ZVSLx9JH7MQGTWGU@Laptop-X1>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
 <20231110101548.1900519-5-liuhangbin@gmail.com>
 <873cd494-dbab-96a6-c6cb-0ee3689f9010@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873cd494-dbab-96a6-c6cb-0ee3689f9010@blackwall.org>

On Mon, Nov 13, 2023 at 11:49:28AM +0200, Nikolay Aleksandrov wrote:
> > +Bridge sysfs
> > +------------
> > +
> > +All the sysfs parameters are also exported via the bridge netlink API.
> 
> drop "the" here, all sysfs parameters
> 
> > +Here you can find the explanation based on the correspond netlink attributes.
> 
> "Here you can find sysfs parameter explanation based on the
> corresponding  netlink attributes."
> But where is "Here"? Not sure what you mean.
> 

How about change it to 

All sysfs attributes are also exported via the bridge netlink API.
You can find each attribute explanation based on the correspond netlink
attribute.

> > +
> > +NOTE: the sysfs interface is deprecated and should not be extended if new
> > +options are added.
> > +
> > +.. kernel-doc:: net/bridge/br_sysfs_br.c
> > +   :doc: The sysfs bridge attrs
> 
> You use "sysfs parameters", here it is "sysfs attrs". Be consistent and
> use one of them. Drop "the" here.

Thanks
Hangbin


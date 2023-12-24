Return-Path: <netdev+bounces-60142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28DF81DBA8
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 18:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63BFB20CC3
	for <lists+netdev@lfdr.de>; Sun, 24 Dec 2023 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24C579ED;
	Sun, 24 Dec 2023 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Dqnl0/Br"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB7CA64
	for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9b267007fso33031b3a.3
        for <netdev@vger.kernel.org>; Sun, 24 Dec 2023 09:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703437881; x=1704042681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJHN9LiCnWvE8qH3acmMZV5CcMk7yRyXdVx50bWlJQA=;
        b=Dqnl0/BrU0P6zdxRhPbauX7iZwRWPPq9SmpuILWt6V9NsOpTTkObqGhzFJm9r4hA0O
         ZvW1Vwi6YakGJgjcz96DSTJSQDvESOrumwLw3H4aoTj9+0h2bZ99zQyFD3BgS2pz9KNG
         zv0JSROgzK0aygMsQusyG3+pk0qVNIYZDM5FlAdfDK1SwHP4LTznEmxETPVWlDu8EtZh
         B65cSiocUbaJN1mSPtgwcbNLbQO6Thilp/leVisEP+gb/jIr3AfylkNmaJbKaBH0hL7V
         CtMtP6LxzOTABPj0Ei6t+pTab+LrkGS1IxdONeM3VXyhZYeZHlldYb/AQ2cpm7XfA93D
         YclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703437881; x=1704042681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJHN9LiCnWvE8qH3acmMZV5CcMk7yRyXdVx50bWlJQA=;
        b=YMVBwArB8ZOFfDuxxHjpYV8wSp+0UXPI9Q2ji/6hIKBXINl0imhei4UTOUhpHW8jMK
         YGBPdKMaC+XnJcI0+ugL82YiZ4d8WPuMdJkfX0J/tZN/8AkoL7o1yPvCLCda3NxW+nwM
         7IBctG0FZmx3XiYG0mXOob5R6A6Z+TZL/pkxomVM4SHgcgGjrJTrmILucDlXQSLpyLpz
         QXlsyUukj4oiCoKrumxwBZSPLnkD+b6Hna7r7uPmj6i0stxAMJOSLvoW5UrdpHhll5Xz
         uy538PrdtP4fjhYeX4nRrnMM1TPiYXyPn7XrbSJXYYtQRFj8oWIOSkRbGwdgHyiKXrZV
         Bf5w==
X-Gm-Message-State: AOJu0YxcRD4itmeXFdu3WMMmc7BqPrBA3FwtasILQfc53xWdJ5TVAgmZ
	WH83zPFpEDUaxedW/hzGzmPUgdSng1w8GV0R9oeSUXnZ76RGsQ==
X-Google-Smtp-Source: AGHT+IFtXs3mynXJmsUIc4mIn6pYc3w8gqOmkRx8qa9ObpwMjXD4heCK7T+l0/I1NmNF5kz15SN4lA==
X-Received: by 2002:a17:902:b94c:b0:1d0:6ffd:6e85 with SMTP id h12-20020a170902b94c00b001d06ffd6e85mr2236470pls.125.1703437880766;
        Sun, 24 Dec 2023 09:11:20 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id b16-20020a170903229000b001cc1dff5b86sm6651056plh.244.2023.12.24.09.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 09:11:20 -0800 (PST)
Date: Sun, 24 Dec 2023 09:11:18 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Florian Westphal <fw@strlen.de>, Jamal Hadi Salim <hadi@mojatatu.com>
Cc: netdev@vger.kernel.org
Subject: Re: [RFC iproute2-next] remove support for iptables action
Message-ID: <20231224091118.2ffa84bb@hermes.local>
In-Reply-To: <20231223123103.GA14803@breakpoint.cc>
References: <20231222173758.13097-1-stephen@networkplumber.org>
	<20231223123103.GA14803@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Dec 2023 13:31:03 +0100
Florian Westphal <fw@strlen.de> wrote:

> Stephen Hemminger <stephen@networkplumber.org> wrote:
> >  tc/em_ipset.c                        | 260 --------------  
> 
> Not sure if this is unused, also not related to the iptables/xt action.

There is both the xtables and ematch options to TC.
Jamal do you want to remove both, or some subset?

The problematic area for iproute2 seems to be the dependency on libiptables
which is not very stable. On the kernel side it is one of the places
where lightly tested integration could lead to lots of syszbot errors.


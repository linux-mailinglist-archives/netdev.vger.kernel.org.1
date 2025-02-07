Return-Path: <netdev+bounces-163957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79701A2C27B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE463AB09D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA66D1E008E;
	Fri,  7 Feb 2025 12:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE6E1DFE1D
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930652; cv=none; b=a2aT7Mnt9lHLpU7YpPIaf4JODt+pNftRBaM2v+HjG83kxSg9xtmoW16cz4ZBELffBEFFrUJJ9AzEzdkGJ7SQld8zSrNXiisOcgmm3mx3LmMsVhsft/WurLnfbOPHqCHlsN7LYXWYlXTBOFkNFv9YHoB0kGxjVVExDcRmK/rF1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930652; c=relaxed/simple;
	bh=cPSMbzArNy/baEUK1nUnuJpyu/dxPVIBHIk3E6ECibk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhR9azpr5VRWyXNj9u/RcJqeDJ+AP9601I7G+R3Wib6yeIaJOuj6l+HeSuokEyH/GWCdVCl84LGLIYObPdMi1g4kpsScdmOYja8olcPOgw9R0ihvhYg5JEPdwDeMk9s4BNzcMvCHHjYCJjEJFRjzKZMDWBd7g11hfYMO/K6LuyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dcf0de81ebso3867696a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 04:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930649; x=1739535449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPSMbzArNy/baEUK1nUnuJpyu/dxPVIBHIk3E6ECibk=;
        b=r93dFeB3G8BZKMf+UT0/7rTcVVLSltaPjpJ1vLdHtTHrAVfzJTAHs/A77MeOWZkRjc
         BvWPOKCB8L+0bQMYasXjXxU74qixvkEk71J1mkhvHqEMLeXjrD4w26waJzQVnkftWffv
         2hf4I88bQyrsMGf65vZJK9w1hbXyT99iGMdCJ0W+IwV7YoCAiAXRQK9VOSANKK3HJeT/
         DoEkxVflZcU8dfeZK/MRB0fSNtlkfjVN5cSfm4Mwt5i5kW1yvQhDXdAI7UdObXRzO6Kj
         aEn0vbRlqjNUfgTbWpwElSJJgdxwRZ5zUOQ/egd0ZIQSri75RpgJI3EAtzEZcG33Xm9I
         UBlw==
X-Forwarded-Encrypted: i=1; AJvYcCXBBKaEH9IVt+GBGqh0VHWDvXi2M0tIWMnezIe0G9/LuIw02md2+5LCso66pnSiEX0HkZnTy/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdP3PsC/UzYRSTkWoZ71KYQi5tjT5zrdYmtHlCew1aBepoGsVd
	H76twXajlDKtwUZNfioHIGg0e5bVBL9ExvqbyCbIYu6kWq7NiDMF
X-Gm-Gg: ASbGncslGQbIeESNVqAOOzeGP4YyjAItI8HQ1e0PkeRgz6rNeWzGtSLbsPT+OTsNjwr
	TFFlMLMh75VsM2SsPVRZehSzNuPS2wE0gL5vrzbHuMDnC2TdPz7R2wuNyQEUQg0Ve/9i1CWAbg1
	CFZS623PER0f+8yvO7tcqTp2HNhGCOFfJR4/sHa2ZZlUxn4NkvWRtAlIjXFM4snGJbclKPQxUNp
	fuofpIopstIEjZ1DkyS/qewLoRN+ENa9jat27m2oCFObViu19CyGtSgGQlh2RGlkPbXsS+kPqGP
	5pEI2A==
X-Google-Smtp-Source: AGHT+IG9VEWB9XU3sGfnb9MVyuqazFNMybo6Bh3g6bQBp7IpSI8gY7p41m4xxnOoRYE/HhG1AlhQfA==
X-Received: by 2002:a05:6402:3907:b0:5dc:7823:e7e4 with SMTP id 4fb4d7f45d1cf-5de450479f9mr3458325a12.12.1738930649044;
        Fri, 07 Feb 2025 04:17:29 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de4d250084sm621670a12.16.2025.02.07.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:17:28 -0800 (PST)
Date: Fri, 7 Feb 2025 04:17:25 -0800
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, andrew+netdev@lunn.ch,
	kernel-team@meta.com, kuba@kernel.org, netdev@vger.kernel.org,
	ushankar@purestorage.com
Subject: Re: for_each_netdev_rcu() protected by RTNL and CONFIG_PROVE_RCU_LIST
Message-ID: <20250207-tangible-quartz-shrimp-3afdad@leitao>
References: <20250206-scarlet-ermine-of-improvement-1fcac5@leitao>
 <20250207033822.47317-1-kuniyu@amazon.com>
 <20250207-active-solid-vole-26a2c6@leitao>
 <CANn89iJ0UdSpuA9gMEDeZ1UU+_VwjvD=bdQPeEA0kWfKMBwC8g@mail.gmail.com>
 <20250207-adamant-copper-jackrabbit-27e9fc@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-adamant-copper-jackrabbit-27e9fc@leitao>

On Fri, Feb 07, 2025 at 03:26:14AM -0800, Breno Leitao wrote:

> > Note that we have different accessors like rtnl_dereference() and
> > rcu_dereference_rtnl()

> To explore this idea further, I'll create a proof-of-concept
> implementation to see how these new functions would look in practice.

I hacked a bit, and I have an RFC for further discussion:

https://lore.kernel.org/all/20250207-arm_fix_selftest-v1-1-487518d2fd1c@debian.org/

Thanks for the suggestion,
--breno


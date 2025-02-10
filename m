Return-Path: <netdev+bounces-164692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4DA2EB7D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FF01881C19
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD161E1A20;
	Mon, 10 Feb 2025 11:40:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705391DF255;
	Mon, 10 Feb 2025 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187631; cv=none; b=SH3VNCcBs5KcJxf4dyqtTTUgUDuTe8drw+Xa/kB8snSFUDFC2VsyGmmJtBQrX6R9H3TafSHCH06avJ4NfEx0EERWy6XM5y+S5x86wQFAeiBv1nICM1azG9PHsAQJ3n0CXx+f/g2k5QjItJDOmKcXhctKdFT3yrYzVOPigAV+Hqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187631; c=relaxed/simple;
	bh=TGHXxe8wx8I2ur48GAs8hCIjesrBs1bBEW0IqAvNpW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+q4J5fDr5Rp7njmnRFf6xOpz8+gAxgw72ajdV9llz24uHI8xSMy6aQa7B3iB2AsPqB1Cf6XBROYoS0ybYVamBqibZhUynqQ76jSjk0xVjfrIrgl1VmtDTw5SHA8Hu3ZOhU2q0MAB6sq1hXtamQ2OVpgmps1P0n4xs3qfPbXkms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de47cf9329so4901689a12.3;
        Mon, 10 Feb 2025 03:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739187628; x=1739792428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1+x4PaTh4h+P+RGSOhj4ONKpjrMgR8e1unjSRPDp2Y=;
        b=iBsF1ZmeuBZzwH/I8LlOQGFVM8Pq+6lJzGSEW2QaA5jjl8X86RAwUa6MRfmNljEi2L
         OwlozIrNunasagtXPtraVQMKsDt9rb1o/E4AwygD45y+OHUlJSmyS6Err+EsXi7fHIPd
         LdDOLRTRnoBFkAPq3Ryjm2iKcuFmzdY6gj8qKDWzScXfCuQxcBgAQzcvk60j2dj8Pth3
         jq17U4fsncnCnrn3ICOrpCE1OZcZ3SP3JzECajofXMgLLoWqTKRZw/CQMxEwm1SI/OX5
         cfD3cQtihnvUxNuPnRCmEh6mds/XVN/YPuEtMiyqJfP0JWwYI0FR4sRmZIAgbeMt/xiY
         f0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUnbGeXSRC9cyZpP9gE+dren+9GSSXnKp/+2sWFjGxg5Pkicnk+WKK9rvqJEXQVs+x8PN3CGJSk@vger.kernel.org, AJvYcCXbMYj+Ian5G14owNrrq/Upk2Y4+Wkg2pq037KUY11loq6ywpqsTUEfebcOhGe4ejz8yfVqsU6eWbrAKHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfpezm6nKm/H2AN6Jsyil3kG8pjDTPi8GFTs7gH0FaEJLnunty
	TO38eDl7c/deCReH2ge+iiKEH+prXfEktfG9Fz2PHfUH4KcVm8w3
X-Gm-Gg: ASbGncsFwJNCXCl+ZOoUuGPTRPpNRELCeIKN6sMs55D/o+f0SusmT3/JQ7JuvL+RwVR
	y3p9quhpOUhVd7FaY0Ha/GDL4EXPSuuI9Qjm2i0oMqY+V15XitkbeRcUEqIxBm3bD3EwNxm9pha
	DM94hSjVmZqwKeyzsvLN/zOvvfYhvo8WtNxGLJs3+o5q11S8J+3wduVFLIQ9q6NSJ2LSk63CbHc
	jmDk6lrNtx2zr7+iktm3XFGMdL+xbk6kntBcm7y1wnHN8W4d4Sky7AIIwm6/QushQZr3jUWiiBp
	x+uu5A==
X-Google-Smtp-Source: AGHT+IEyGe6A3tyAukAWlIjzWLta6wiu0P6GcVHRBURMnG/JgVDbAY9lpdr4Y6owC6HGgNljr8g49A==
X-Received: by 2002:a05:6402:13c8:b0:5d0:ed71:3ce4 with SMTP id 4fb4d7f45d1cf-5de44feaa0bmr15682084a12.6.1739187627478;
        Mon, 10 Feb 2025 03:40:27 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de4aa38a1asm6172554a12.79.2025.02.10.03.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:40:27 -0800 (PST)
Date: Mon, 10 Feb 2025 03:40:24 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, kernel-team@meta.com, kuniyu@amazon.com,
	ushankar@purestorage.com
Subject: Re: [PATCH RFC net-next] net: Add dev_getbyhwaddr_rtnl() helper
Message-ID: <20250210-furry-toad-of-satiation-fce507@leitao>
References: <20250207-arm_fix_selftest-v1-1-487518d2fd1c@debian.org>
 <20250207162718.4f26219e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207162718.4f26219e@kernel.org>

Hello Jakub,

On Fri, Feb 07, 2025 at 04:27:18PM -0800, Jakub Kicinski wrote:
> On Fri, 07 Feb 2025 04:11:34 -0800 Breno Leitao wrote:
> > +static bool dev_comp_addr(struct net_device *dev,
> > +			  unsigned short type,
> > +			  const char *ha)

> static bool dev_comp_addr(struct net_device *dev, unsigned short type,
> 			  const char *ha)

This one aligns better with the other functions in the file. Example:

  struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
                                         const char *ha)

> > + */
> > +struct net_device *dev_getbyhwaddr_rtnl(struct net *net, unsigned short type,
> > +					const char *ha)
> 
> You missed adding this to a header file?

Yes. NIPA caught this one beautifully:

	https://patchwork.kernel.org/project/netdevbpf/patch/20250207-arm_fix_selftest-v1-1-487518d2fd1c@debian.org/

I will send a v2 soon,

Thanks for the review
--breno


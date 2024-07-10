Return-Path: <netdev+bounces-110551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A832C92D07F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E29C1F210F6
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5C418FDD5;
	Wed, 10 Jul 2024 11:19:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBF284DEB;
	Wed, 10 Jul 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610380; cv=none; b=RN6I//+Kut8ouNycONbG/Th2L28tLftTbF2K5Le964TI4vemF3gYlTEOfGOPIffkMQ+NSCs5hD+Ug7BJJDWnPVpsFzOpggQosoNEwtFgz4/b9TOPIL9ePzP+E50CyuohSpEv3CCIXx3aUcGHxhTZ7GVCCeS5B11LcRqqsx/OJVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610380; c=relaxed/simple;
	bh=MNptc+guiBaZ6LJNyDtjKMoUQhJ8jEWJt/DJ+8mtBwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j24zEq+Vytz18KvAAtDOw3JnlWCyRHrJW5ZiO2LFnx+C3b5x9JVK/cQiFbCYR151TPMQuxtuXFRArSmZtYFAHsMATTMoWNhS8w3j9miWzUOOQDq3oqPfAQVWJLI29LXHa/rJaiVgnGbprf0r2g7QuT89O3KJNcfrNkAFVdplzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-59559ea9cfdso2012542a12.0;
        Wed, 10 Jul 2024 04:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720610377; x=1721215177;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IJZqrCwCFyJZ8f758b8FPSiEMk6i0fZRrbXvGxZ7Xw=;
        b=rMbaJ7tCU+3epQ/T+vG8po3X3os7nFolZo5/fdNn2JJ0MGH4DekLKguhpTC1EVUPWH
         e7B26YbcyjOHkq6lFz/x46ce8Err/hI85pUphDLJgOTUR53C5whKeZqkV+wq0XvKBKbl
         cG+qHGJ+68A4Oy3ysB9LgfxU7iXAGVpqDgyMq/VKNRwpyETuv8vpmmgVpgq8bHVzS+Iu
         t3RjVw1ZUICFmcyaZQUcScG2bALACmCXJdRvQp+ywVuMcjVuHcdLkCgDt1YIva1wmR1A
         hno/9RvcodQtUGE0TqR1CYrv5mQjn8MzBkEPePmM9F1lslM5iLIuihAOKVjpjmgkPg9Y
         Qy3w==
X-Forwarded-Encrypted: i=1; AJvYcCW5lmBTQFgz4jyXiTd4OLhrIK+xz7ljp6LFqWjRrpO1f2VH3xAG4NQPVXeIDF0JhBKvqDkO44/GGFA8uHIHTft1te9oSOHyBd3MuFJUgMv1HTLt3lOra2tOzAmgsnOKOlvmdt/bkRhKEnASzGJr83jd+SywNfVZRzE8DbQnwwhzoHIN1S1m
X-Gm-Message-State: AOJu0YyMPPbEJ+60+paypS42X5GUObdsohknyYukjpzay0cf1XZ9XEjR
	Is6XS8h8m9D4QbHezHmAXiCKH07SLRYOUSry9xidXaRVqE6aGZ3P
X-Google-Smtp-Source: AGHT+IGOuyI2WyIM/xtN+z88kAaLuxoW/cKKRT6dktT65dQXfrCB2k4BVG9s5nqWhwodCFUxfGwb0w==
X-Received: by 2002:a05:6402:520d:b0:57c:a422:677b with SMTP id 4fb4d7f45d1cf-594baa8ba6dmr4628896a12.8.1720610376712;
        Wed, 10 Jul 2024 04:19:36 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bb9604easm2107957a12.4.2024.07.10.04.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 04:19:36 -0700 (PDT)
Date: Wed, 10 Jul 2024 04:19:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keescook@chromium.org, horms@kernel.org,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device
 _properly_
Message-ID: <Zo5uRR8tOswuMhq0@gmail.com>
References: <20240709125433.4026177-1-leitao@debian.org>
 <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>

Hello Eric,

On Tue, Jul 09, 2024 at 08:27:45AM -0700, Eric Dumazet wrote:
> On Tue, Jul 9, 2024 at 5:54 AM Breno Leitao <leitao@debian.org> wrote:

> > @@ -2596,7 +2599,7 @@ void dev_net_set(struct net_device *dev, struct net *net)
> >   */
> >  static inline void *netdev_priv(const struct net_device *dev)
> >  {
> > -       return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
> > +       return (void *)dev->priv;
> 
> Minor remark : the cast is not needed, but this is fine.

In fact, the compiler is not very happy if I remove the cast:

	./include/linux/netdevice.h:2603:9: error: returning 'const u8[]' (aka 'const unsigned char[]') from a function with result type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
	 2603 |         return dev->priv;
	      |                ^~~~~~~~~


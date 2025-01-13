Return-Path: <netdev+bounces-157700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C87A0B429
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4020A161C4D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7121ADA4;
	Mon, 13 Jan 2025 10:09:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D72045A3;
	Mon, 13 Jan 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736762998; cv=none; b=ZMooa7aJIBSem04hdrZhxM9H5lvdQvRnmbcz82I7QgAaZSvXTJt7q+prImkdlmFi5qg339//GPbN8/W3rn70qeqmSo8l4M52BnxyrM5KuoDUrphp1km/kisqNAdNR4aocXC/eYTTPcwd8yAIIvTJobStao1FRl+rFaNS8ghkeTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736762998; c=relaxed/simple;
	bh=argc1vQqGDFEyiqXT3Vw5Py4XgDHTBchhf8XHbvpeLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv7BswzZrxDHRhq8VEt0cinzvualsaZQK3+t5XTecLtrTWqpHPrkNEoK6OZyUmy7VjNeIpipw1cOsK4IYITktHlou1SWqX0kBRtILnnn4ujmrD068UQ5jXqZGYYhZCPaXIPDcY685YNbee9wIMPD9PeHvvIhQMqVl59EU5uGW48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso7946775a12.3;
        Mon, 13 Jan 2025 02:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736762995; x=1737367795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v325B9y3nJnj/l5Wu+V3MROqhu0jcsoi8BysPUS2rbU=;
        b=Q9wxHX5pK83XC/yhzUtIUTJ34Cp6sf0PlDN51OUDsHbCoxTCSVotmUENWESZtEiU+y
         YTjxlP+SMCSdtX+4tpSU0VO5PuGIP21vm+a8ObdoxiJJ/6Rz0U0P1ozC/hfpqhtW1X5J
         ChofW5IT6759LRq8FxrLIMtMurGHW89dTAt+hiYkLuHwTFAtVe9QDDzovA39PNfaP4GM
         bD10z/i7YpfK/Rio0OSYi3r9hekDWQZCbaXeb2G//yvOKh6TFuoUhBen8CpYj7EEAkNc
         kfg1zTWklcJ1Gfxf/c+uzXo10nARlnj4u0d1X5kfMu87SRYIO/emK5uXWPe96whHPDSZ
         6Hww==
X-Forwarded-Encrypted: i=1; AJvYcCVDNADVNY5hy44bN1TP0kKSpJcDLJIzb6dIqJ0h+Ih0yZT6M31kTexRpVXEWYGKYcPdmDswCxiDz8wdkfw=@vger.kernel.org, AJvYcCVVntb6TgENuhn32HZ8OmP0VLPg2dNnA5t894ps7KKil8Fvwm/h7zGEOMehK7zfPFrCMGm9GzEx@vger.kernel.org
X-Gm-Message-State: AOJu0YyjTaaB13qjEoGJ0qb/Q+iucTLMopZN07JTy+ae23HEoxwpGEga
	CZzhHnk9rgtdzHVkfD6Y/2L6nzyRLMC+p4+Pxvwy9NmNo8hd5w11
X-Gm-Gg: ASbGncvxvD6UCan0+WQeTpnXcqQ6JIXOf022jJ2vpRSFPJqfGXCHZ2h8nk1YvXJjNpx
	BiONHdxzWeuVvmVcwFYQxnZIQBDFpo1i0qVgqQAnOIXhPhruaK/wa3HHEPE55EIDt4SXbPDM1VS
	PhANt2+zuK0WNih0QLkzVggDE/udXUanSaDSZ6Ig7thyrV8jl67Ca3wc+s/XmDm3D2XQyS7Pv3W
	j6ANXAk3ylKoosqzKtjnxhxMowcG7CrgG0/H43edhdvTcPG
X-Google-Smtp-Source: AGHT+IEOyaJ5u8WNUWUgI2hxaxPEdiy3zc9nvfy5Nnc7sOwFQT8dED7MB9NXNirXnPXwPYn2XYl9lQ==
X-Received: by 2002:a05:6402:4023:b0:5d0:e2c8:dc8d with SMTP id 4fb4d7f45d1cf-5d972e1b962mr18026426a12.20.1736762994652;
        Mon, 13 Jan 2025 02:09:54 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9900c4b56sm4597578a12.32.2025.01.13.02.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 02:09:53 -0800 (PST)
Date: Mon, 13 Jan 2025 02:09:51 -0800
From: Breno Leitao <leitao@debian.org>
To: John Sperbeck <jsperbeck@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH v2] net: netpoll: ensure skb_pool list is always
 initialized
Message-ID: <20250113-spotted-independent-kittiwake-309cab@leitao>
References: <20250110-wildebeest-of-optimal-unity-06c308@leitao>
 <20250111003238.2669538-1-jsperbeck@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111003238.2669538-1-jsperbeck@google.com>

On Fri, Jan 10, 2025 at 04:32:38PM -0800, John Sperbeck wrote:
> When __netpoll_setup() is called directly, instead of through
> netpoll_setup(), the np->skb_pool list head isn't initialized.
> If skb_pool_flush() is later called, then we hit a NULL pointer
> in skb_queue_purge_reason().  This can be seen with this repro,
> when CONFIG_NETCONSOLE is enabled as a module:
> 
>     ip tuntap add mode tap tap0
>     ip link add name br0 type bridge
>     ip link set dev tap0 master br0
>     modprobe netconsole netconsole=4444@10.0.0.1/br0,9353@10.0.0.2/
>     rmmod netconsole
> 
> The backtrace is:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000008
>     #PF: supervisor write access in kernel mode
>     #PF: error_code(0x0002) - not-present page
>     ... ... ...
>     Call Trace:
>      <TASK>
>      __netpoll_free+0xa5/0xf0
>      br_netpoll_cleanup+0x43/0x50 [bridge]
>      do_netpoll_cleanup+0x43/0xc0
>      netconsole_netdev_event+0x1e3/0x300 [netconsole]
>      unregister_netdevice_notifier+0xd9/0x150
>      cleanup_module+0x45/0x920 [netconsole]
>      __se_sys_delete_module+0x205/0x290
>      do_syscall_64+0x70/0x150
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Move the skb_pool list setup and initial skb fill into __netpoll_setup().
> 
> Fixes: 221a9c1df790 ("net: netpoll: Individualize the skb pool")
> Signed-off-by: John Sperbeck <jsperbeck@google.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

You didn't specify the network tree you are sending this patch for.
Since this patch fixes a commit in 'net' tree (also on Linus' tree), you
want to send it against 'net'.

Something as:
	# git format-patch --subject-prefix='PATCH net'

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#indicating-target-tree

Thanks for the fix.
--breno


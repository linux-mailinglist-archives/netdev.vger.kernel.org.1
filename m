Return-Path: <netdev+bounces-131648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A288498F21A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149DF1F223E4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5641E1A0708;
	Thu,  3 Oct 2024 15:06:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88319F46D;
	Thu,  3 Oct 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967991; cv=none; b=qwrHRnLjtbX/Ysc7FRSdwt/L5d8jf5WWXE1EBT7SdmctR3hO0vWxCC6dns2aNCtE2JigToOZXHMKCHoI+E2eck4LU9rNgmSEc28fsc4oUmdTv724mF3M1VCIT5dNyXz2USzHFp1oZC8v0Bz2E375G3fp7i6huHVYanD/jvcyws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967991; c=relaxed/simple;
	bh=7issmRctBTQCoGM92lUpsl5d1G0utqmexzVnmphaKTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jvh4olB9Ngysro8Ty1AP3AeG52JkYp2cCoSQfiJd5j1egJbpGMUsDJp0KursUEWVQAySgIKiI97NYvQewBumjxbuyWdzTuHjBVMC3DmsRfOEIWtcuf17DKQx9dGo0VC4sHqcbfsS+bpyfnTvikoJcO/FD4x+CVh7icpgxB2iU9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c8a2579d94so1296132a12.0;
        Thu, 03 Oct 2024 08:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727967987; x=1728572787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4KSvx73nCV7n78PZpzu/vzXVS1JSUP4mhHufTr6XR0=;
        b=my+TgNZx29EL1vIfkTXK3XZSWV5zq86IBTef7VE55KYICMVhIirTKKA9UYI+JYAN3I
         hBdtZUJe9w7RW1ib77y5EBR6Wz5f0ziMELphKagiyKumDw5TYsKtede+R69ssUkX8P1u
         tuRmC7el3VlHiMtD4+bA7mSAaPtbHc8edXeYA87zq8so+gzXd0vG+UFRoJ9I1bG1QjYP
         RMkuxfjszu566j6ry3JlK93ct5Mr/iz9i4EH1W2vY/B7r6imEZ9+seDOYVFsuk5v0I71
         2ENDK8CQDYhHN/Ev79BC9c3YIS+PQ93RDRGS3G04teV8gMS59ZSbnDWAMQA02U6p+AHY
         UaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeVia8Iqf/3ect9cmeQUm1xg5UYsPf2MPb1BwSrxa3XE1HZPnZdMTkBvDzUtzUb593FBxx5GyU@vger.kernel.org, AJvYcCWwR+vYWUoNFcnzhGgmdRLbwlEX2iGdFVa9gGEfmy47Y5K3MT22CJbzKiWgZT3bDGBHrrtr180PL+LiTtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6BO6wjHYnNPEBUAGn2tq0aEaW1Yfv1jsVFa1Yr9cO6fwAjuK
	JpjH8ZlZwa6Auh3N5o63Dgnbcydh4FV6WTvXE78d3Q/AhFINT7t5
X-Google-Smtp-Source: AGHT+IGX0d8aLok+9ELChOJIxFbkKzG0uUZ3DH4CXEIF891HICs1E87mXL2LbG4Pozd4DP6bCTHGqw==
X-Received: by 2002:a05:6402:26d4:b0:5c8:957a:b1e5 with SMTP id 4fb4d7f45d1cf-5c8b1a3ae69mr6018028a12.16.1727967986881;
        Thu, 03 Oct 2024 08:06:26 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca4f70cfsm799418a12.92.2024.10.03.08.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:06:26 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:06:23 -0700
From: Breno Leitao <leitao@debian.org>
To: peterz@infradead.org, gregkh@linuxfoundation.org, pmladek@suse.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vschneid@redhat.com, axboe@kernel.dk
Subject: Re: 6.12-rc1: Lockdep regression bissected
 (virtio-net/console/scheduler)
Message-ID: <20241003-unbiased-adventurous-chupacabra-6c8acd@leitao>
References: <20241003-savvy-efficient-locust-ae7bbc@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003-savvy-efficient-locust-ae7bbc@leitao>

On Thu, Oct 03, 2024 at 07:51:20AM -0700, Breno Leitao wrote:
> Upstream kernel (6.12-rc1) has a new lockdep splat, that I am sharing to
> get more visibility:
> 
> 	WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> 
> This is happening because the HARDIRQ-irq-unsafe "_xmit_ETHER#2" lock is
> acquired in virtnet_poll_tx() while holding the HARDIRQ-irq-safe, and
> lockdep doesn't like it much.
> 
> I've bisected the problem, and weirdly enough, this problem started to
> show up after a unrelated(?) change in the scheduler:
> 
> 	52e11f6df293e816a ("sched/fair: Implement delayed dequeue")

Errata. The commit is missing the first number. The right one is:

	152e11f6df293e816a ("sched/fair: Implement delayed dequeue")


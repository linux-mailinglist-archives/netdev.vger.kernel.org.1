Return-Path: <netdev+bounces-205362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C17AFE4D3
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B416B3BEEFD
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105FF288524;
	Wed,  9 Jul 2025 10:00:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B9B288518;
	Wed,  9 Jul 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055248; cv=none; b=UswT9NMcDJChhfb2rcXqZT32blV62F3YXLt++ODDFhwh9eUSr6VeQAhZpCDX9SsCuFdBZAhkG+ZqVoAUhk9ZXpOKyWZuwowML6pdHwDGZlWDRZsN+2RfI+PzkpDxtqgeiFaYiSkO2piQtFm1GFUm6SwZncY0JZYxtw9cFB8f8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055248; c=relaxed/simple;
	bh=DiJ66SBLFFMb0WUrOcvORVE6I+A3wUkQ1Hg21qfF7hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDOc8q9kzgD7zegEKBeKuJtgyBEc5jx8Vv4X9H5gTyv6uThvdoXIFdAhQ8ztbHp33fDxUZDzr0SFJNqpwEey8oVk5U8ulqQp8clCoovb8qvmJHIeiQp/mv8Gmts+5aqkIhrKoVdOy6ovA7YPPKA1jsM4t60jwYMajYE9FguI2IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so10562450a12.3;
        Wed, 09 Jul 2025 03:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752055244; x=1752660044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWi6412PxfvPQWQmWLJWGFciwerksItXBmye60DGX6k=;
        b=fQXzPk9/Yv+N6UcTE/7/JCqpaQx/3jshReedWy9H4EUDLX20OMCUgMtGBYYeQAoGEn
         wmBuRB0jX90556PMAjN17wfJRRUfugAUFHzTAmSjL2HLVjVGWQ0eNxRJ/5xTm5BKojZv
         UTPOdFkXKxk4o79oOTaF9tc3Zg3rn4gdA85gKZa70sisb4Afl+T2DwjAuKHE5SuIPhQm
         d8FfyakKqaj4DPn2d3ySDN5b/9Qrh7/VyA7choomoXHZ8PpYM2NVzmZNjlPMTaDUWkvf
         /TyrwtcQgtqG1hLtBv71DCF/PUPvSi3CKNs2i1emPoUvctojL0iL7gBedprKvIaj7eSK
         fErw==
X-Forwarded-Encrypted: i=1; AJvYcCUA7n8O65Dl8YaEFGXkExiHexAmoSAJuT7mDs3dvmE+FaPKuKPQDvvxO96JL9j3Lx0H3rrPqTe8O8/n7qE=@vger.kernel.org, AJvYcCVZzG5GXJC65PQrkQMF44qpkoGJry0eKxUrE9bRof4IzDEM8admFp2LbEHDeCZ8pJjxvpM/j6Ct@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wShulWDY7Z9hx10Uc5gAj1vBdgVe2ntqBbAYyWC/wYfXOOZZ
	hALraSABNFjwK9idane0rvl1H7a1LHUcL325E2fWWHVSfP9vqMIqFlLFjIbYcA==
X-Gm-Gg: ASbGnctgyVfCwhmwaxRJ7RGZZ8tpTBVgkeTYTVxumZ1cE5G2WGy/WJO1JgzyBxqHk7V
	OBb+TlRjIhqXuNGU4shlvUN5Ew2GzdEhiUtLQIE8BIBZTctppiq49UOcwLzQNJN4ERcvNtKfSZw
	MpGsyyXdp8P10LGW8Wwx47J5YAy6+sAWRD9m/NA2Kkg1LNBXf+kV/LMq8K0uxnHuoRFQKKx64OD
	DspHOY19MpjzvWc8bCG7xfJkTe+c6/UZKGq4O/quiV9cqxdfmgGlwUdvvmDOYcj5I+qYEWUqCBe
	qTbo3JVVjQO3EdYPyOsCkbIh+dgHnYVLrI0EeSdDoL/VhzkDDmKm
X-Google-Smtp-Source: AGHT+IHTug5FbnVKS42RlgmNzRUm0MMv7wK2bjJcwMWaBDXUVoh/N6npNnhGvrdluT21Di3sx8BJGQ==
X-Received: by 2002:a05:6402:796:b0:60c:3c19:1e07 with SMTP id 4fb4d7f45d1cf-611a659495dmr1246210a12.15.1752055244073;
        Wed, 09 Jul 2025 03:00:44 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca696480sm8718676a12.27.2025.07.09.03.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 03:00:43 -0700 (PDT)
Date: Wed, 9 Jul 2025 03:00:41 -0700
From: Breno Leitao <leitao@debian.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>
Cc: aeh@meta.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Message-ID: <aG49yaIcCPML9GsC@gmail.com>
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-lockdep-v1-1-78b732d195fb@debian.org>

Hello Waiman, Boqun,

On Fri, Mar 21, 2025 at 02:30:49AM -0700, Breno Leitao wrote:
> lockdep_unregister_key() is called from critical code paths, including
> sections where rtnl_lock() is held. For example, when replacing a qdisc
> in a network device, network egress traffic is disabled while
> __qdisc_destroy() is called for every network queue.
> 
> If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key(),
> which gets blocked waiting for synchronize_rcu() to complete.
> 
> For example, a simple tc command to replace a qdisc could take 13
> seconds:
> 
>   # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
>     real    0m13.195s
>     user    0m0.001s
>     sys     0m2.746s
> 
> During this time, network egress is completely frozen while waiting for
> RCU synchronization.
> 
> Use synchronize_rcu_expedited() instead to minimize the impact on
> critical operations like network connectivity changes.
> 
> This improves 10x the function call to tc, when replacing the qdisc for
> a network card.
> 
>    # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
>      real     0m1.789s
>      user     0m0.000s
>      sys      0m1.613s

Can I have this landed as a workaround for the problem above, while
hazard pointers doesn't get merged?

This is affecting some systems that runs the Linus' upstream kernel with
some debug flags enabled, and I would like to have they unblocked.

Once hazard pointer lands, this will be reverted. Is this a fair
approach?

Thanks for your help,
--breno


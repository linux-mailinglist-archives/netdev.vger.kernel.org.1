Return-Path: <netdev+bounces-140962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E3A9B8E37
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF344282469
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4383415A85A;
	Fri,  1 Nov 2024 09:55:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6742C0B;
	Fri,  1 Nov 2024 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454954; cv=none; b=twu8wPckR2X9wVFduClZzlYC4s4z1DTsZ7FpH4HX2N9q7K+HRDACI4/rSFBy+dLx8DC3tLcXgQBi0S9fxW+uDQSpB2ia65MofWRfYssJyuhvsjNbTDXqF69qi+6gMayDnYM4ZxYbM5zNakHTmpOFXaiiNCgLcTJkL53y7z/Ml/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454954; c=relaxed/simple;
	bh=WTYnH8m7kXjv8qZInYAhGdSknl4/AE4BuBqGwmmfme0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Np/46xcta5Hs3uTgAiEV6Px+vUHZ1FJvXxFJqSrrqTEONyCmYwKl4ua0f9FFWkPpsN6zyramtDmcr5h9Yd0q+ES5jgvV+N2GM+SFznK5GUCoHNXluOZLD8EycdT953GkEji44vmyVt4vlHCznU3kHSTl/xFg1Yak53Q57AeQSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99f646ff1bso218807166b.2;
        Fri, 01 Nov 2024 02:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730454950; x=1731059750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t+QYyf8qZDtsRwJcXowF6EM2CgFAnHXFELfH+lEWqI=;
        b=gYX1RaQ0MlVJJ+c7J8jfgDm+GH/0R3zyq+b1OctAr+pI97pnbvI6tcmDj5bauVqJeo
         TUcSj8YWUZcQ+3f41F0WkjWrBGEKejsoJAwbKuNQ4nGbPHs/EIodily2j3yjVj5D5UTT
         YGwgGt01TThpeneWl5j1fYYWZO/64lfj89e5s0V2n5SbTul4mKYpHpsWwgFlUirPp0XV
         zUvQkmQvzxuq5VG/ivD2LZdHGkuIKPL8EKc5c/7L4ybztQ1VJWjPXtghLYT4TQWFIGce
         3zRYRONBveWeV706MPy9Th+DOKqKrOcH8MO24xH4x1hNCUDcRViEaegqkghw2tviefQH
         1YIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6xPpXcxrAQ5Rxf7YB/486pnNDMctzBvWDgAtAzMMjqi1txnrP77PsmRYKdc45us44TG0B/YWRCX2laBca@vger.kernel.org, AJvYcCVQ2FvZj+3lWk9++lMhZiMaP9xYrltiNCgCwzS/UlXh04s7bhEV2ApPBbs7Rj/imVFv6/7lycyYmFo=@vger.kernel.org, AJvYcCXz6gGVc0+wp2d9INCJb7b3eW+VTJHk4Az2l88Zi3rh715sHpuQWU+AKF8E0UIzNxNUEtYZrLk8@vger.kernel.org
X-Gm-Message-State: AOJu0YyPU23VjHM82f7+Yu0SbLdZyIInlBsK+Q4ij1vpxE5jdqD4H1Zn
	YRrxhrx8oSuADGtEyGVvsgXoC9je3ibXZmFQPSYjB0kRatdPUYEu
X-Google-Smtp-Source: AGHT+IGCLOakR0b9WPcsve9Vt1k91BRnbuy4Q1X5xpkkj29pof6MeeJf5jFzuWN+7Je/9pRzsXBdsQ==
X-Received: by 2002:a17:907:7b9e:b0:a9a:dac:2ab9 with SMTP id a640c23a62f3a-a9e3a6c99ebmr932418066b.42.1730454950171;
        Fri, 01 Nov 2024 02:55:50 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c4fc6sm162479666b.69.2024.11.01.02.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 02:55:49 -0700 (PDT)
Date: Fri, 1 Nov 2024 02:55:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Akinobu Mita <akinobu.mita@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@meta.com,
	Thomas Huth <thuth@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4] net: Implement fault injection forcing skb
 reallocation
Message-ID: <20241101-macho-wolverine-of-glee-2ea606@leitao>
References: <20241023113819.3395078-1-leitao@debian.org>
 <20241030173152.0349b466@kernel.org>
 <20241031-hallowed-bizarre-curassow-ea16cc@leitao>
 <20241031170428.27c1f26a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031170428.27c1f26a@kernel.org>

Hello Jakub,

On Thu, Oct 31, 2024 at 05:04:28PM -0700, Jakub Kicinski wrote:
> > > the buffer needs to be null terminated, like:
> > > 
> > > skb_realloc.devname[IFNAMSIZ - 1] = '\0';
> > > 
> > > no?  
> > 
> > Yes, but isn't it what the next line do, with strim()?
> 
> I could be wrong, but looks like first thing strim does is call strlen()

makes sense. Let me send a v5 with the fixes, and we can continue from
there.

Thanks for the review!
--breno


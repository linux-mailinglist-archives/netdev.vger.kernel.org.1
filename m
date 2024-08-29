Return-Path: <netdev+bounces-123090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C89963A2C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020C61C23288
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E301547E8;
	Thu, 29 Aug 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="SUuiEAy+";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="jytuvKZl"
X-Original-To: netdev@vger.kernel.org
Received: from mx6.ucr.edu (mx.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363EA1537B9
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911215; cv=none; b=u7cdDfFSu3yCrHYKV8h646vIfFut1d3HfS0+xo/dmlu56kdY/LnhJZbGWUpsZoYSjYMV/WpC5jYrLqJ5+FA/6L52EvstTBHBenMOlpJZaskJV3qYjGleRsoNDVox2pAN9aHIZ/HypcJNd5kNq+nNHNuqySHF0bH3rZwzKTtXjT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911215; c=relaxed/simple;
	bh=c5+BxaXWvRBxDUcjcZvL61zh83/XIf0pWGMRioPHBrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZgEdnGyT5iJTu/iN2I32ASQrseQVm5jV6xVRc1zPABS1zuXJa+lzjhbd2s/Y1iGCThnF6+JkigojwG86Fq6uvqrglE2DjtXj57zkEgXHrR55q+w6i5ebt197+ITU47AFICkzaZVx/KZ/BZWVmBVxIPGetreKHbZ1S3Y30lPuNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=SUuiEAy+; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=jytuvKZl; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724911213; x=1756447213;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=c5+BxaXWvRBxDUcjcZvL61zh83/XIf0pWGMRioPHBrM=;
  b=SUuiEAy+KnMNo2bwRJqDaeow9282yOKE+I5bzfw3ajRzlvU1aEqJllvR
   vi0+TMLFrDGa7wjDHKdqs/E2pn81P4isi0VvyjOxYH+3PmcJ4jyOsGjqT
   wnEpu4wRH6QQ0UG69Ie1k5lQReOww111gVKy+gABgvFnJrSTMNfMVp0ze
   XqjddB+anOI2b4ijqTHvv6jKu11hTWI9zzyxJ5EkuMpGWfiLpcBH66E3J
   AGIEiUXHKGwlG5iO1YRq2G/b8CXlCTWIjSV0VzW96tkZbnbhQtVBf+XtG
   h6BKSbCfwbdUaYBS81Shi9RrUJJVEH0Je8QkLKSTT+U0QvUytsWsCo8Pf
   w==;
X-CSE-ConnectionGUID: 5AvBRBdgQNKmv5+0UjB1QQ==
X-CSE-MsgGUID: m6g6WHG0Q0mW2n/RqEfiLA==
Received: from mail-oo1-f72.google.com ([209.85.161.72])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 23:00:11 -0700
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5d5ba2d8d5dso348562eaf.2
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 23:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724911211; x=1725516011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5+BxaXWvRBxDUcjcZvL61zh83/XIf0pWGMRioPHBrM=;
        b=jytuvKZlUOMeiYJnv1EfA2q7BIvZIREcrF8X3yTebJ5cmI00Ln9uJHGKQp2uWoHBRX
         /6q78ByY6R/V7YF8dsTuGK6ZhoC/SswRAl1h0EHKe4rU4BarERXBbxTEp0OuijXMBJHh
         ru91xnuNBrh34OnOhb1XXQJA1RQFW4XEIgRcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724911211; x=1725516011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5+BxaXWvRBxDUcjcZvL61zh83/XIf0pWGMRioPHBrM=;
        b=jNlX0WH6gvNRAAppzFe6HYXDbFGWZwc48i/fyJ6k01E1CL/c1hofLN+RC/IRTzhQl5
         gqF5xcUY6ahzgOjpyY6EBoGl1/rgih7RtOLzSklbongq2yQNnI49pHMCm+aKpNRY0HTy
         jxKFoIf5BfZuvJ55zHVnWY9LwlkmUw2lgqW2UZse73StZzsHOcbhXxtXd0+hTZJpT5Zt
         dCipXG95uVAjE3SEf0Yvt+rYZE7+JabJtv110CV8eDHW95zc7GGUltXZFJTo4FJ4PmvA
         PkgCchSTCzwkMTVFTRez7EUYKcGbD6Qo16un+8s8bQSrPG234ZZdmGG/aHWPikRc2/4T
         PROg==
X-Forwarded-Encrypted: i=1; AJvYcCWGJUoEUnQwcS1MekqIyAVrPHqsjsIYGERe7ohwSR/ocRs+1RHrJX36ximuZZVay+tg1v5UVyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPE8aparX3SStLj0r/vpENFq3j+ATHizQBjOSMiy/4Y6hMHJ0
	ZIFCDpeZDIvsygOpy0IBce7p+7Gb3igvjhmKRCfM7sQZB1OMA3l4t5zKlDbQX4Lhr7zYLcCw5AE
	srMDn1BP3w8Y1xwNveX/L3IEprwVBH/ejdfdKtw2KVqk0Owku5Ug5vMXWcPXJt4KnZ5sxXdidFc
	l88DIRI4l7R5wdqrXNt/pBY/6qaMMT7g==
X-Received: by 2002:a05:6820:2295:b0:5dc:a733:d98a with SMTP id 006d021491bc7-5df980cf733mr2263965eaf.7.1724911211517;
        Wed, 28 Aug 2024 23:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5thjR14Ks+6judAwL4nDPvcXZjzFPCcbYGPrB7DoyTxw6g4i4UpkLaTzBuGzQKTfzqhlcGKfYt1vxkUxvhM0=
X-Received: by 2002:a05:6820:2295:b0:5dc:a733:d98a with SMTP id
 006d021491bc7-5df980cf733mr2263936eaf.7.1724911211146; Wed, 28 Aug 2024
 23:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-4uup-u-7rVLpFqKWqeVVVnf5-88vqHOKD-TnGeYmHbQw@mail.gmail.com>
 <202408281812.3F765DF@keescook> <CALAgD-6CptEMjtkwEfSZyzPMwhbJ_965cCSb5B9pRcgxjD_Zkg@mail.gmail.com>
 <BA3EA925-5E5E-4791-B820-83A238A2E458@kernel.org>
In-Reply-To: <BA3EA925-5E5E-4791-B820-83A238A2E458@kernel.org>
From: Yu Hao <yhao016@ucr.edu>
Date: Wed, 28 Aug 2024 23:00:01 -0700
Message-ID: <CA+UBctBGbAc5rDV97DaJGJopqTKkeuC8hHiMrN6irt84r0NoRw@mail.gmail.com>
Subject: Re: BUG: WARNING in retire_sysctl_set
To: Kees Cook <kees@kernel.org>
Cc: Xingyu Li <xli399@ucr.edu>, mcgrof@kernel.org, j.granados@samsung.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Waiman Long <longman@redhat.com>, 
	Sven Eckelmann <sven@narfation.org>, Thomas Gleixner <tglx@linutronix.de>, anna-maria@linutronix.de, 
	frederic@kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:33=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> That's excellent that you've developed better templates! Can you submit t=
hese to syzkaller upstream? Then the automated fuzzing CI dashboard will be=
nefit (and save you the work of running and reporting the new finds).
Yes, we are also working on this.
And it also takes some time to figure out the differences in the
syscall descriptions and to satisfy syzkaller's style requirements.
So we are still working on the patch of syscall descriptions for Syzkaller.

Once again, we apologize for our mistakes of some helpless report
emails and thank you for your reminder and understanding.


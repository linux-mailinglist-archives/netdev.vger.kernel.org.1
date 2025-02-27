Return-Path: <netdev+bounces-170359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B62A4854B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6481748A4
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B641B041C;
	Thu, 27 Feb 2025 16:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3771ADFE4;
	Thu, 27 Feb 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673575; cv=none; b=ZHCMtmBjvLWDxd5ZgLXTa1lbF/pwHsrEWjANBQ+gbsARUvO8eW+y81tTLQglZZTd2uUsVqxziGwz7RGd6vhPCVZdE9RYPIIgHsqg/P0XIgqyrfNI8LAyqj4POHgB9/sGlFwlHwGkXw+1QYHpbzpjlL9uXlNhhAYCz3AMx6LbAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673575; c=relaxed/simple;
	bh=9pV0PaNRiWoRB5N+sSMXlSy3Ekhc7h6RUle+VERQ06Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSLBoHBbAILSiM/eAbYUFHdaonr6inVWZqeDkuFmMledo3hpR29hMVywOPmzHfofFMLaBtrgMiNObZUIdWfrdIQow9+RJygoI0qqAESUgwvjwRGXxs2Pj5DdMeYc4XJvNGTuJmbzPnVx8SZuolkOLdIHRImLA1+uVCC0MlJfa7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so1596584a12.2;
        Thu, 27 Feb 2025 08:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673572; x=1741278372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SiNTLmXpB44ayGIMhxkuJJ/NuIXuy/J+wOgM1W1l6Q=;
        b=hkkRbu/mKDIv/reoQWGu1A765zT8jZ6R/5OVCJ6MIAIQcAIWUf1Ld/jYHp6u2GKgCC
         +XyjIaNU4lTbjcNtXaqgOSKeLp8woz5nh7pj/1LxIRHXcWoeipi2flBlG3MSdW10WoaD
         Z3EKe0e3cXkMpt2u06+4FhYN6pC+2DELp/LordaRrRx3pJeFW9MJ8vpmKt78bZAKfX/+
         4HQ5Z4Thmzfqk5qUNUFnc+xzlx21P483ONnvAZsKCHgpIrCR2vkFztvQqB7/HftHdfOv
         wz0f8bYRofq7NBqR+0AsbPeHNR7weDdBPx0P5dv5T8nMMVvkgaxs7oC2tmWJQgmhBvlx
         zjlg==
X-Forwarded-Encrypted: i=1; AJvYcCUlyzkFFbwJ1L8cJgqMsjgyRi2RzRkclsOxZuYXc5HjP1XBV/isnmr3Ad25Pop4Oq52TTh/1us7@vger.kernel.org, AJvYcCWBwM56Q70eRg0qYh174TPs9BG3AbPkaf6h7pJhRfEE9ZJ1OfGZDgg0MzhhOdOFHHZkaOx4nrG265VaqvqAsqkB4FF9@vger.kernel.org, AJvYcCXC9ly9hZem7cHPyJA+cimeis8iMYZZOGp6Yh2hQfL8oKykVUiPnho8vgH++KDPA6TGFx0VMahuE9OF0NM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8MEdrDyF6fVAUoZZft9OXwnnQq3KdxtURuNGZhBLalEVHsoQk
	4LU8LUfQ6pRh0/D9VXfPT0G7T4ZCB1Gw/6H1kJgKZTn28xnXUr4Y
X-Gm-Gg: ASbGncuCGx2UdJT4r+F9rWYOGPIc15739Q01V1qCY2WgW14MbPMm0WQtFNfdDrYrMYE
	i1c5V5d0k5eqz3rNNc4HvOpnhj96tG8QUQKgys405lk8ELGe44YluTvSZEqk55VlfJyqw6GTndv
	/8iq6keN5vBIkxgXU+rFEr9gj+RFJZFcrCli+J94uh2MtkVAwpc0budzgQyEXJBFkMHS/P+DiWf
	Q409y6TrU+nky8rKLsoZzV1y8p9KjfxmZiFWNbmDwKv+tTviZuBgbDsON4We4X78K5HJT1kUF/6
	xZEpe3vw/CoLTw5lKw==
X-Google-Smtp-Source: AGHT+IFl++/yOYa9Rn+HrahvjmAv7sDLMp+8sFdPJunRtah/54z93OmcU7nX22QHGuCBIFZWglvWyw==
X-Received: by 2002:a05:6402:2813:b0:5e4:ce6e:3885 with SMTP id 4fb4d7f45d1cf-5e4ce6e3c13mr1888970a12.2.1740673570860;
        Thu, 27 Feb 2025 08:26:10 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6d279sm1333711a12.23.2025.02.27.08.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:26:10 -0800 (PST)
Date: Thu, 27 Feb 2025 08:26:07 -0800
From: Breno Leitao <leitao@debian.org>
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com, yonghong.song@linux.dev
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Message-ID: <20250227-ingenious-therapeutic-dingo-e786cc@leitao>
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org>
 <20250226-cunning-innocent-degu-d6c2fe@leitao>
 <7e148fd2-b4b7-49a1-958f-4b0838571245@kernel.org>
 <20250226-daft-inchworm-of-love-3a98c2@leitao>
 <CANn89iKwO6yiBS_AtcR-ymBaA83uLh8sCh6znWE__+a-tC=qhQ@mail.gmail.com>
 <70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70168c8f-bf52-4279-b4c4-be64527aa1ac@kernel.org>

On Wed, Feb 26, 2025 at 11:31:49AM -0700, David Ahern wrote:
> On 2/26/25 11:27 AM, Eric Dumazet wrote:
> > In 2022, Menglong Dong added __fix_address
> > 
> > Then later , Yafang Shao  added noinline_for_tracing .
> > 
> > Would one of them be sufficient ?
> 
> tcp_sendmsg_locked should not be getting inlined; it is the
> sendmsg_locked handler and directly called by several subsystems.
> 
> ie., moving the tracepoint to tcp_sendmsg_locked should solve the inline
> problem. From there, the question is inside the loop or at entry to the
> function. Inside the loop has been very helpful for me.

Inside the loop would work for me as well.


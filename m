Return-Path: <netdev+bounces-45624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D2C7DEA45
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 02:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D62B20F1C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 01:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809AC10E7;
	Thu,  2 Nov 2023 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="GHzI/X/W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE615AC
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 01:42:14 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361F610C
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 18:42:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28094a3b760so433888a91.3
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 18:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1698889331; x=1699494131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fm1ZyyOcsA8wjDRuIpsTTo8wiDi5ib4FYzkiHs1w04=;
        b=GHzI/X/WuonoSMf9/6HfZQMyfuW3RN4Jn82Pn6rudUtQXYfufncCQ7R+nHJfhvHfXG
         JhJxOW/lUcBfkXgt1n/mfoAbf7maRwe0e7suxR4cJQ7d3C3JcsJ9OjYKmeSo3mOFSQBx
         JkvLiEMYDuhHSol9wy23yYvlqUrlMR9KU7KCAhK0vzf1ahhudVd9uw+VKRKQucDISnpG
         MvexNEklzhAqxy+RGJG7LnjFrdsgw759L1NIsunZMNy8htZZl78L/9c7MIkd7mkFuVh2
         aLqa4+rILA4nV/nYIWSgmekuoFA31zs2yshv+D11rRPr9+0SGaQyfLxva3SdbIfM9qIO
         td3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698889331; x=1699494131;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fm1ZyyOcsA8wjDRuIpsTTo8wiDi5ib4FYzkiHs1w04=;
        b=GmFw2gjdNz9pwzNwhRRGTUI/t6dTPYgAT6+cGAt7YsRhZEJKYq9di4R6ytOKP7sYkA
         7cOE6LqS3huNuHnLAohGyRu3961LtSr/6SjelpRXHTb2pETv+hxt3Wz+UloeuasrEmWr
         kAV4/hSQxRKIJdBIUpLc24XtQnCxMn6XQA/HRw/A1joabanhHR0gqx9463KmyLTFHzjK
         kPgfNvf3wwSA3C1+vM23ynIsel8rwKBLWMcRiI6to2SPKJXAaXbxIXhWdZkX7lUwiBgd
         FPUpPkmgUqUMt9jRdSNLTSxNLkh82YzC9WTWEIGev/Ku3x4bFrVZ3xhvezumVpmu/f19
         r9uA==
X-Gm-Message-State: AOJu0Yz55jw3hqapImFTpAIkb+hT2LGpjcEaw+vaNlRRLKdWLv88ftg/
	m8uNN0iXyuRY1B3FynGN2/He9g==
X-Google-Smtp-Source: AGHT+IH51zTtsKFSOlKMwd/y9VfDttx+UnqJ+HS5r6aeeTGJRnYLq7FIrav7895W+8HTqdLQf2H4ow==
X-Received: by 2002:a17:90b:2485:b0:27f:fec6:b9c9 with SMTP id nt5-20020a17090b248500b0027ffec6b9c9mr14402082pjb.9.1698889331490;
        Wed, 01 Nov 2023 18:42:11 -0700 (PDT)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a1a4300b00268b439a0cbsm1495151pjl.23.2023.11.01.18.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 18:42:10 -0700 (PDT)
Date: Wed, 01 Nov 2023 18:42:10 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Nov 2023 18:42:09 PDT (-0700)
Subject:     Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
In-Reply-To: <20231102010723.GA406542@dev-arch.thelio-3990X>
CC: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
  pabeni@redhat.com, ndesaulniers@google.com, trix@redhat.com, 0x7f454c46@gmail.com,
  fruggeri@arista.com, noureddine@arista.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
  llvm@lists.linux.dev, patches@lists.linux.dev
From: Palmer Dabbelt <palmer@dabbelt.com>
To: nathan@kernel.org
Message-ID: <mhng-41e9fb36-f703-461e-b585-9e8dd5984714@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 01 Nov 2023 18:07:23 PDT (-0700), nathan@kernel.org wrote:
> On Wed, Nov 01, 2023 at 05:41:10PM -0700, Palmer Dabbelt wrote:
>> On Tue, 31 Oct 2023 13:23:35 PDT (-0700), nathan@kernel.org wrote:
>> > Clang warns (or errors with CONFIG_WERROR=y) when CONFIG_TCP_AO is set:
>> >
>> >   net/ipv4/tcp_output.c:663:2: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]
>> >     663 |         }
>> >         |         ^
>> >   1 error generated.
>> >
>> > On earlier releases (such as clang-11, the current minimum supported
>> > version for building the kernel) that do not support C23, this was a
>> > hard error unconditionally:
>> >
>> >   net/ipv4/tcp_output.c:663:2: error: expected statement
>> >           }
>> >           ^
>> >   1 error generated.
>> >
>> > Add a semicolon after the label to create an empty statement, which
>> > resolves the warning or error for all compilers.
>> >
>> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
>> > Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
>> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> > ---
>> >  net/ipv4/tcp_output.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> > index f558c054cf6e..6064895daece 100644
>> > --- a/net/ipv4/tcp_output.c
>> > +++ b/net/ipv4/tcp_output.c
>> > @@ -658,7 +658,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>> >  			memset(ptr, TCPOPT_NOP, sizeof(*ptr));
>> >  			ptr++;
>> >  		}
>> > -out_ao:
>> > +out_ao:;
>> >  #endif
>> >  	}
>> >  	if (unlikely(opts->mss)) {
>> >
>> > ---
>> > base-commit: 55c900477f5b3897d9038446f72a281cae0efd86
>> > change-id: 20231031-tcp-ao-fix-label-in-compound-statement-warning-ebd6c9978498
>> >
>> > Best regards,
>>
>> This gives me a
>>
>> linux/net/ipv4/tcp_output.c:663:2: error: expected statement
>>        }
>>
>> on GCC for me.
>
> What GCC version?

12.1, though I can't get a smaller reproducer so I'm going to roll back 
to your change and double-check.  Might take a bit...

> I cannot reproduce that error with my patch applied. I tested mainline
> at commit deefd5024f07 ("Merge tag 'vfio-v6.7-rc1' of
> https://github.com/awilliam/linux-vfio") using GCC 6 from kernel.org and
> I can reproduce a similar failure with ARCH=x86_64 allyesconfig:
>
>   net/ipv4/tcp_output.c: In function 'tcp_options_write':
>   net/ipv4/tcp_output.c:661:1: error: label at end of compound statement
>    out_ao:
>    ^~~~~~
>
> With this change applied, the error disappears for GCC 6 and GCC 13
> continues to build without error. I can try the other supported versions
> later, I just did an older and newer one for a quick test.
>
>> So I think something like
>>
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index f558c054cf6e..ca09763acaa8 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -659,6 +659,11 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>> 			ptr++;
>> 		}
>> out_ao:
>> +	/*
>> +	 * Labels at the end of compound statements are a C23 feature, so
>> +	 * introduce a block to avoid a warning/error on strict toolchains.
>> +	 */
>> +	{}
>> #endif
>> 	}
>> 	if (unlikely(opts->mss)) {
>>
>> should do it (though it's still build testing...)
>
> I am not opposed to this once we understand what versions are affected
> by this so that we have some timeline of removing this workaround.
>
> Cheers,
> Nathan


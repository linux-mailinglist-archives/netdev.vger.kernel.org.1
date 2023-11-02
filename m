Return-Path: <netdev+bounces-45618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A2B7DE98F
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 01:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE181C20756
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 00:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC2B372;
	Thu,  2 Nov 2023 00:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="pmRqAN68"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395010F6
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 00:41:14 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB73119
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 17:41:11 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1e993765c1bso249549fac.3
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 17:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1698885671; x=1699490471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAmpgjdK8hmw86qRod49rM//sCJ8Bz8+YBV91rFwGG4=;
        b=pmRqAN68uA/Z+sMMnSXl8Vq1vVwhLK0wu4dZKngIJHgdls8NWpwRc0eH1l4einry14
         yJ5O9IxPQ6fvGbC+xHtD6mzff5OEYFRYrgFuy75tBX1kLlmAHwoZ+OBd4EarNNPGQ5zV
         Z9dL1+jfk7VmScDUdeYCCDir/OzPIh8gMa+23zPVD4MujDfwGUKKuYlUccAOd4y9GDpN
         1rFip/8WBKwGAqt+A5Fh9SPq1U9wPeUxiN0KBfanHnaVHrn2ew50EJtv5wzmMhSvOS0S
         QFDogJzqR3+36UXf6arBW/k3pVPm7rTEEbC89JQjT5yUnMwkDMRvcGyhTCSKg8/aAeVI
         /+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698885671; x=1699490471;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAmpgjdK8hmw86qRod49rM//sCJ8Bz8+YBV91rFwGG4=;
        b=daBh1eX7ySzu+UfA6vQ64tiG0uUlNuPXKp7lBPdLy7mZlcPJBFSxDfQYYMNYujDhzr
         OiAt0pltp450SdkBduW65S8UfAruzTVrs/KgioMBMjj17bdZuu++3HEkc8JkhZ+aq8Ee
         LF/l2Y1K+o28S624ZGQSzuJwOh3R317Wcan0I2Vu6C3zqiJCx6n9FplWa3WOW2+AkNY1
         NytMHQEVSNUl843pi8pQVp8U0RxhzQZ+tzIrFrO1rjYX12US+TMrVm5zVH0RAyQ8pA0P
         Z62SYnih5VTcaSVzsdfiAU/y8EwTsbhPofXOp1ENxSIJOaf1dtQ5freDXo9Ydc+Os1BN
         pKjg==
X-Gm-Message-State: AOJu0Yx3mswwiFluhMINyUX5LvFV9BjteLGbR0QlodwQrxsgkhxYO2+k
	pVfC7XLwsCB8MhajKhz1XUeYjw==
X-Google-Smtp-Source: AGHT+IFFaftpgSzJhJuGLJNG/sHeW9v22Ui/IWzm0dd7hWk1pkaNfdav4oOzey1zsg3meE6Ku8MPMQ==
X-Received: by 2002:a05:6871:528e:b0:1ea:6883:9a01 with SMTP id hu14-20020a056871528e00b001ea68839a01mr24276948oac.32.1698885670962;
        Wed, 01 Nov 2023 17:41:10 -0700 (PDT)
Received: from localhost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id s15-20020a63b40f000000b00588e8421fa8sm308240pgf.84.2023.11.01.17.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 17:41:10 -0700 (PDT)
Date: Wed, 01 Nov 2023 17:41:10 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Nov 2023 17:31:33 PDT (-0700)
Subject:     Re: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
In-Reply-To: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
CC: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
  pabeni@redhat.com, ndesaulniers@google.com, trix@redhat.com, 0x7f454c46@gmail.com,
  fruggeri@arista.com, noureddine@arista.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
  llvm@lists.linux.dev, patches@lists.linux.dev, nathan@kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: nathan@kernel.org
Message-ID: <mhng-df0ad8f4-f79c-427c-9798-8682fca4f516@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 31 Oct 2023 13:23:35 PDT (-0700), nathan@kernel.org wrote:
> Clang warns (or errors with CONFIG_WERROR=y) when CONFIG_TCP_AO is set:
>
>   net/ipv4/tcp_output.c:663:2: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]
>     663 |         }
>         |         ^
>   1 error generated.
>
> On earlier releases (such as clang-11, the current minimum supported
> version for building the kernel) that do not support C23, this was a
> hard error unconditionally:
>
>   net/ipv4/tcp_output.c:663:2: error: expected statement
>           }
>           ^
>   1 error generated.
>
> Add a semicolon after the label to create an empty statement, which
> resolves the warning or error for all compilers.
>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
> Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index f558c054cf6e..6064895daece 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -658,7 +658,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  			memset(ptr, TCPOPT_NOP, sizeof(*ptr));
>  			ptr++;
>  		}
> -out_ao:
> +out_ao:;
>  #endif
>  	}
>  	if (unlikely(opts->mss)) {
>
> ---
> base-commit: 55c900477f5b3897d9038446f72a281cae0efd86
> change-id: 20231031-tcp-ao-fix-label-in-compound-statement-warning-ebd6c9978498
>
> Best regards,

This gives me a

linux/net/ipv4/tcp_output.c:663:2: error: expected statement
        }

on GCC for me.  So I think something like

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f558c054cf6e..ca09763acaa8 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -659,6 +659,11 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			ptr++;
 		}
 out_ao:
+	/*
+	 * Labels at the end of compound statements are a C23 feature, so
+	 * introduce a block to avoid a warning/error on strict toolchains.
+	 */
+	{}
 #endif
 	}
 	if (unlikely(opts->mss)) {

should do it (though it's still build testing...)


Return-Path: <netdev+bounces-22034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4C6765B9F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6061C21595
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E1A18049;
	Thu, 27 Jul 2023 18:48:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F9E27127
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:48:05 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8251BC3;
	Thu, 27 Jul 2023 11:47:48 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7654e1d83e8so106187585a.1;
        Thu, 27 Jul 2023 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690483667; x=1691088467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CsJihqU3W0SWy4MPkYCRdSBSFBxwsM2Bi0gkXaNib1k=;
        b=HbnqsGfmY3seITOXIykIsZwnW5cfZ5mpB6+xAChflATKmIgC2SPtLUQQWQI8vKA3sP
         kTXcYnMw6LH1Sia9TANJrCeWe9QaZpTLdiHpUCACtKjUzMiJLpJr8jowtdGraxpARaxr
         rHIDAdBg1lN5aw1Ayu7j3zlLk4dVoDMDFLAYEeAqkP1rwe1AYkNkab70VSUnVgzuDiPn
         EzB6cfduNcVOKQ2k8Z7wbWgitxOz9hbLeZJXjxCzagi/VZNXeZrXPGxedXMUJCyyTVbs
         CmD5lB+o0YaFYaqwCWjcgJKRoPAsnap+pRvTHKQNCcahqxpO98VGd+ZsuBjVKtC3p+o+
         tR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690483667; x=1691088467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsJihqU3W0SWy4MPkYCRdSBSFBxwsM2Bi0gkXaNib1k=;
        b=LhdySvfk78Birr1F4iu0OvtMMlSsJykR6aYt+Tl6tQCPqEyOoAPnPciy26K3Z/WN+3
         nFkV/2ctFWOAaf0A4MuNiyS31HSBeFHrG4etVhajcoFJ/FScT00A1EBS+F7KcZibpPOD
         N5klVeuGrSq9VEC5L7OjsvQfQyiT0qrMjohqhHK6DsegPoMiM+4ejEiI67b9RJIBMPz3
         3DWtvy8OwnA3ycvzUhwedoNixpKdURLj+XU/hX8jPYvIp8xGujkQvJMPCWHn+mB4pLHU
         TeUo33n3X+1uyr+zEGq6+Xe3tRY7L0wUcO+f7G/wCRPEERmtxPw/SgAC1bg/zSGfEKQ4
         ZlCw==
X-Gm-Message-State: ABy/qLZFpejFtEUvTmVq8tg/x/uMGGQuKIWfxEpKZWVskGWWNhbcAlri
	l7NzUwIuKRU7ArR9QocBYgI=
X-Google-Smtp-Source: APBJJlEdqX9cpPhbMqSWWrAxvt/9UKSwWYzZ4Y5b3DvWdY9N0mcDQugsapME6E6W79yamZOjWyf6dA==
X-Received: by 2002:a05:620a:4727:b0:765:3e81:e74c with SMTP id bs39-20020a05620a472700b007653e81e74cmr315331qkb.21.1690483667103;
        Thu, 27 Jul 2023 11:47:47 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a074a00b0076c60b95b87sm586411qki.96.2023.07.27.11.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:47:46 -0700 (PDT)
Date: Thu, 27 Jul 2023 14:47:45 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	leit@meta.com,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] netconsole: Enable compile time configuration
Message-ID: <ZMK70fqdnfMPpc1x@d3>
References: <20230727163132.745099-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727163132.745099-1-leitao@debian.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-07-27 09:31 -0700, Breno Leitao wrote:
> Enable netconsole features to be set at compilation time. Create two
> Kconfig options that allow users to set extended logs and release
> prepending features enabled at compilation time.
> 
> Right now, the user needs to pass command line parameters to netconsole,
> such as "+"/"r" to enable extended logs and version prepending features.
> 
> With these two options, the user could set the default values for the
> features at compile time, and don't need to pass it in the command line
> to get them enabled.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 368c6f5b327e..4d0c3c532e72 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -332,6 +332,26 @@ config NETCONSOLE_DYNAMIC
>  	  at runtime through a userspace interface exported using configfs.
>  	  See <file:Documentation/networking/netconsole.rst> for details.
> 
> +config NETCONSOLE_EXTENDED_LOG
> +	bool "Enable kernel extended message"
> +	depends on NETCONSOLE
> +	default n
> +	help
> +	  Enable extended log support for netconsole. Log messages are
> +	  transmitted with extended metadata header in the following format
> +	  which is the same as /dev/kmsg.
> +	  See <file:Documentation/networking/netconsole.rst> for details.
> +
> +config NETCONSOLE_APPEND_RELEASE
                     ^ PREPEND

> +	bool "Enable kernel release version in the message"
> +	depends on NETCONSOLE_EXTENDED_LOG
> +	default n
> +	help
> +	  Enable kernel release to be prepended to each netcons message. The
> +	  kernel version is prepended to the first message, so, the peer knows what
                                         ^ each

> +	  kernel version is send the messages.

"kernel release" is one thing and "kernel version" is another:
root@vsid:~# uname --kernel-release
6.5.0-rc2+
root@vsid:~# uname --kernel-version
#37 SMP PREEMPT_DYNAMIC Thu Jul 27 14:20:44 EDT 2023

This option relates to the kernel release so please use the correct
name consistently in the help text.

> +	  See <file:Documentation/networking/netconsole.rst> for details.
> +
>  config NETPOLL
>  	def_bool NETCONSOLE
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 87f18aedd3bd..3a74f8c9cfdb 100644

[...]

Why is it needed to change the default for these parameters? Is there a
case where it's not possible to specify those values in the netconsole=
parameter?

If the default is set to on, there is no way to disable it via the
command line or module parameter, right?


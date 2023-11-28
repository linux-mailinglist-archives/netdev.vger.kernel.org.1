Return-Path: <netdev+bounces-51616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70847FB605
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B30F282643
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD749F8C;
	Tue, 28 Nov 2023 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B4D1BE9;
	Tue, 28 Nov 2023 01:39:22 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a02d91ab199so713710066b.0;
        Tue, 28 Nov 2023 01:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701164360; x=1701769160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWtYsdEl36R8u+W7yt2kJv3ITv8M1eIh7YbcBgCv930=;
        b=UFsexGa9q3+qzLZ5w6TEgCbdVC6h+coIEpIsHOCWGoOKvvz3dg6AqvkvH9naJuXsYj
         FP1UEtOn4nKXqLfiGe+QZDYIqIEp8H70qbY+NjMcdYgjwnIU5dgtWwrsZObXUNwjGH/m
         NpwmAtA+fYTy/O2jnts6OkjztBNkLuHVfoDZlPAkIjX03IHGat304UYO7remjwoo5BDT
         esRhOApcVSlUHfu8c+dwqmRIY/emWQ/cMLPTzseDvDGY4OZap/4aerpzZWOrjBhSGk0I
         xRIxVsTom8Z1h31Oy+FBXADSQfUVa3V3evsXRBQYjmhw6t4MifgdAatHjjemKQOORKIy
         1R3w==
X-Gm-Message-State: AOJu0YwpWs7CnprYCEZO7KOxNWBn1hn8HVDCDICK1X43Hd/9ZYCwRddu
	J/aUY+EkpFIWC+iRNHHXkdlnaBKKmAI=
X-Google-Smtp-Source: AGHT+IFiRveRsPzrQCVS6aGt04MXmnZgiRfR7mN8nzf226ELw+B/9AtmXf/qx1htSygJ3WndL9zQcQ==
X-Received: by 2002:a17:906:798:b0:a0d:ac30:4963 with SMTP id l24-20020a170906079800b00a0dac304963mr4190286ejc.76.1701164360271;
        Tue, 28 Nov 2023 01:39:20 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id gw4-20020a170906f14400b009e6af2efd77sm6561371ejb.45.2023.11.28.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 01:39:19 -0800 (PST)
Date: Tue, 28 Nov 2023 01:39:18 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: netlink: link to family documentations
 from spec info
Message-ID: <ZWW1Rpwz+Twb1p1L@gmail.com>
References: <20231127205642.2293153-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127205642.2293153-1-kuba@kernel.org>

On Mon, Nov 27, 2023 at 12:56:42PM -0800, Jakub Kicinski wrote:

> diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
> index b6292109e236..2c0b80071bcd 100755
> --- a/tools/net/ynl/ynl-gen-rst.py
> +++ b/tools/net/ynl/ynl-gen-rst.py
> @@ -122,6 +122,11 @@ SPACE_PER_LEVEL = 4
>      return "\n".join(lines)
>  
>  
> +def rst_label(title) -> str:

Please add the type hinting to the "title" argument. Something as:

  def rst_label(title: str) -> str:

Other than that I am good, and feel free to add:

Reviewed-by: Breno Leitao <leitao@debian.org>


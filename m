Return-Path: <netdev+bounces-45027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9AD7DAA0D
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 00:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3BAAB20DDA
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 22:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5685C182C6;
	Sat, 28 Oct 2023 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTUdjj7t"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC45B65C
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 22:04:09 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F47BE;
	Sat, 28 Oct 2023 15:04:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40790b0a224so23795385e9.0;
        Sat, 28 Oct 2023 15:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698530646; x=1699135446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6xAxAgJ8/E1rrp4YMb11CAldnTGshTkVGRolTNv03Y=;
        b=GTUdjj7tdcYyGawfuFz8N3axp/lgQxJpE7gTZ2f4eV/0pFcqsIBurC47gINhRWQHod
         I6AUCujXFOR+cZB/K4MoeDUbFzXa0BAeMx6clyXY7WAeHDaOXevsxHm1eF1MbY0y7q2i
         UIPtZydTxYSJD5LQQkSJrdPCQlN7shsNlbdS1XMDQIfzanNiJrPHr4Zl2TDrIPdynkXK
         wvlnk5Fm0rmaAs4seSMTu3kMcyaeWeVmQjOwyGngHV58qZ9OWuM6bFd4CZoY9J5iQZDV
         W7Qn9tPKEiYnmDTmYSFZd2JTqmq9XrJIOkQsudUa5SH1sRB44d70AJtB3PDPK9qJgM2K
         VsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698530646; x=1699135446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6xAxAgJ8/E1rrp4YMb11CAldnTGshTkVGRolTNv03Y=;
        b=l6fIZenNYS7zq4doRG9XOhMxb3JijL+KPmaR/qHsXwjLWrZR+lyQJcRiZ4kx9Bohr9
         S3F+pb2QlO6UtXckD673ES46ZYJOdqHHEsFtUaFcYk2+yVEtzVC1+2SPf3xT5Dsd/Glw
         83sRJhCbhmqNp+IHP/a3bcY2yNFUUTYk+RyINVGpyRk8OaMrorVk1gSchCyxMKq27pHv
         IHoUfBfSj8OzMgYniQtjLXfjgnWdDZD7GOo89OEFtKt5wfZQbbb5A5Yi1Ek2iR75UwDy
         psE+lfAiXvibIwshSwAy0XJpBL1irlb9rkoJDvcgvMvTOKNO+hvr3SrJaDU8d6M8RWuy
         n/zQ==
X-Gm-Message-State: AOJu0YzVDKWGqQHp3Dcr89CPFyLLLW4wdyJQAsRlYMrnOgOcP5ndIYYd
	/rdQTP9Up2hVTx6QorOl418=
X-Google-Smtp-Source: AGHT+IGCLKsiOFpUOuwmLcFbsoirfIdDeHaZc2OJdfVUAJVeXg6mb8QiXLuLdKX5c4LmBVuLTYJkEQ==
X-Received: by 2002:a5d:64e3:0:b0:32d:8401:404a with SMTP id g3-20020a5d64e3000000b0032d8401404amr4879072wri.10.1698530645910;
        Sat, 28 Oct 2023 15:04:05 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id q26-20020adfb19a000000b0031f82743e25sm4638731wra.67.2023.10.28.15.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 15:04:05 -0700 (PDT)
Date: Sun, 29 Oct 2023 01:04:02 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Mauri Sandberg <sandberg@mailfence.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231028220402.gdsynephzfkpvk4m@skbuf>
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>

On Fri, Oct 27, 2023 at 10:21:39PM +0200, Linus Walleij wrote:
> It was reported that the "LuCI" web UI was not working properly
> with a device using the RTL8366RB switch. Disabling the egress
> port tagging code made the switch work again, but this is not
> a good solution as we want to be able to direct traffic to a
> certain port.
> 
> It turns out that sometimes, but not always, small packets are
> dropped by the switch for no reason.

"For no reason" is a technical statement which means "an unspecific/inconclusive
drop reason in the ethtool -S output on the conduit interface (which also
shows the hardware counters of the CPU port", or is it just a figure of
speech? If just a figure of speech, could you please determine which
counter gets incremented when the switch drops packets?

What user port is being targeted when the switch drops packets? Any user
port, or just specific ones?

What protocol headers do those packets that are dropped have? Is it size
that they have in common, I wonder (given that you say that small
packets are not always dropped), or is it something else?

> If we pad the ethernet frames to a minimum of ETH_FRAME_LEN + FCS
> (1518 bytes) everything starts working fine.
> 
> As we completely lack datasheet or any insight into how this
> switch works, this trial-and-error solution is the best we
> can do.
> 
> I have tested smaller sizes, ETH_FRAME_LEN doesn't work for
> example.
> 
> Fixes: 0e90dfa7a8d8 ("net: dsa: tag_rtl4_a: Fix egress tags")

Have you actually checked out this sha1sum and confirmed that the packet
drop can be reproduced there? Ideally you could also go back to a bit
earlier, to commit 9eb8bc593a5e ("net: dsa: tag_rtl4_a: fix egress tags")
(this is a different commit from Qingfang with the same description) and
test on user port 0 only?

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  net/dsa/tag_rtl4_a.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
> index c327314b95e3..8b1e81a6377b 100644
> --- a/net/dsa/tag_rtl4_a.c
> +++ b/net/dsa/tag_rtl4_a.c
> @@ -41,8 +41,11 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
>  	u8 *tag;
>  	u16 out;
>  
> -	/* Pad out to at least 60 bytes */
> -	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
> +	/* We need to pad out to at least ETH_FRAME_LEN + FCS bytes. This was
> +	 * found by trial-and-error. Sometimes smaller frames work, but sadly
> +	 * not always.
> +	 */
> +	if (unlikely(__skb_put_padto(skb, ETH_FRAME_LEN + ETH_FCS_LEN, false)))
>  		return NULL;
>  
>  	netdev_dbg(dev, "add realtek tag to package to port %d\n",
> 
> ---
> base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
> change-id: 20231027-fix-rtl8366rb-e752bd5901ca
> 
> Best regards,
> -- 
> Linus Walleij <linus.walleij@linaro.org>
> 

Until more is known:

pw-bot: cr


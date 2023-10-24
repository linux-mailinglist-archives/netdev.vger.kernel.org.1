Return-Path: <netdev+bounces-43839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0A17D4F88
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D1D1C20A99
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BC126E0A;
	Tue, 24 Oct 2023 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXU1X5lQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F5262A6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:10:59 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCA9D7D
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:10:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so9124855e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698149454; x=1698754254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RWXQ0JSSHfw7ZxzgnmVrVbqR4LpPWoOYLUETidht14=;
        b=DXU1X5lQdJ0ZDhWmgePKdJTies3c5DI6VB4pkbWQMvqdbTlfPsKr9nq1kcj+K/hKgk
         L8MCfHBbiMFJ63cbpP6Dfm9xoV42Jhv0j+mfRQh+p2SZWxHJloqeJq66M2zvyD2RjGnS
         kWEOEJWVIqqyOu+/g5pgoj6oRmZYv40MMnmtD6JSt+Trsm8ykKQ4pGuhxaM//w+aXWyV
         9ZOR3DUF+pg9LPopuEO1PgoZNO5dEOGw8YWYUgqV7KPEl1ueeboD0pkevQz6+VhOO89W
         qHxxTOSwtN9rnBZ5sog+ndZ8bHTWHTv4XyB2y9OrBuq/ZcWZg/pU807jtjFmfOMv5+tR
         Yeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698149454; x=1698754254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RWXQ0JSSHfw7ZxzgnmVrVbqR4LpPWoOYLUETidht14=;
        b=mgTxOX9bRsnMRURpNrrsFwjPA1p+69WHNgU3+dmemINOwoV0BvyOlM9rseHF2MG7As
         n4+Yl8Iu0jhn/QvRFMLIKhGlk/ArWHmOc9q3/CD0dAzZIgTZ47LxXHC6MUGx/B2MwB6R
         538k3tXtSXM+p/LPCHJW2CfdNkj3mwmDpmB8AqMJEowdP7yCc+vNREmxHfZRS4rBDU5H
         fMD9gtFC81wgxDtja6lqraKqcY66+o4j41SVenv6v6Srg0xQQ+i3J/xx/tc4I8l57gw0
         iVy2KqqCOvYe5Suu6H13pBvVLpL9gZFE7VVEmceSekq7jwzeWb6l4nGE9gfrQD2Bi86Q
         UqYA==
X-Gm-Message-State: AOJu0YzMEd7eXVoDGHe3wBcAqJOFrMuJ8Zw0Dmi/lrKUCWGA6u1cnpN6
	Iza+4dgVWiEhsUvWl9SP4OOIfaah+kGZLDQ2yYg=
X-Google-Smtp-Source: AGHT+IEZMo/ryAx2uGDjLwwW/S0iX9cqin8tD2S+ics6BazIuqX+KkId8mzq4IlvaqTZer+WelDNEQ==
X-Received: by 2002:a05:600c:4f94:b0:408:3e7a:82d8 with SMTP id n20-20020a05600c4f9400b004083e7a82d8mr11572709wmq.19.1698149454612;
        Tue, 24 Oct 2023 05:10:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b00401b242e2e6sm16766305wmq.47.2023.10.24.05.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 05:10:54 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:10:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	veerasenareddy.burru@cavium.com, felix.manlunas@cavium.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net 2/2] liquidio: Simplify octeon_download_firmware()
Message-ID: <9a6d37de-14a4-483a-a515-ac30dbea4d4c@kadam.mountain>
References: <cover.1698007858.git.christophe.jaillet@wanadoo.fr>
 <0278c7dfbc23f78a2d85060369132782f8466090.1698007858.git.christophe.jaillet@wanadoo.fr>
 <f44e4fd716729f1f35ef58895b1acde53adb9b35.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f44e4fd716729f1f35ef58895b1acde53adb9b35.camel@redhat.com>

On Tue, Oct 24, 2023 at 01:11:13PM +0200, Paolo Abeni wrote:
> On Sun, 2023-10-22 at 22:59 +0200, Christophe JAILLET wrote:
> > In order to remove the usage of strncat(), write directly at the rigth
> > place in the 'h->bootcmd' array and check if the output is truncated.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > The goal is to potentially remove the strncat() function from the kernel.
> > Their are only few users and most of them use it wrongly.
> > 
> > This patch is compile tested only.
> 
> Then just switch to strlcat, would be less invasive.

Linus was just complaining about strl* functions.

https://lore.kernel.org/all/CAHk-=wj4BZei4JTiX9qsAwk8PEKnPrvkG5FU0i_HNkcDpy7NGQ@mail.gmail.com/

strlcat() does a strlen(src) so it's BROKEN BY DESIGN as Linus puts it.
The advantage of strlcat() is that it always puts a NUL terminator in
the dest buffer, but the disadvantage is that it introduces a read
overflow.

I would probably have written it like this:

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_console.c b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
index 67c3570f875f..ebe9f7694d8b 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_console.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
@@ -899,13 +899,16 @@ int octeon_download_firmware(struct octeon_device *oct, const u8 *data,
 	ret = snprintf(boottime, MAX_BOOTTIME_SIZE,
 		       " time_sec=%lld time_nsec=%ld",
 		       (s64)ts.tv_sec, ts.tv_nsec);
-	if ((sizeof(h->bootcmd) - strnlen(h->bootcmd, sizeof(h->bootcmd))) <
-		ret) {
+
+	len = strnlen(h->bootcmd, sizeof(h->bootcmd));
+	len += snprintf(h->bootcmd + len, sizeof(h->bootcmd) - len,
+		       " time_sec=%lld time_nsec=%ld",
+		       (s64)ts.tv_sec, ts.tv_nsec);
+	if (len >= sizeof(h->bootcmd)) {
+		h->bootcmd[orig] = '\0';
 		dev_err(&oct->pci_dev->dev, "Boot command buffer too small\n");
 		return -EINVAL;
 	}
-	strncat(h->bootcmd, boottime,
-		sizeof(h->bootcmd) - strnlen(h->bootcmd, sizeof(h->bootcmd)));
 
 	dev_info(&oct->pci_dev->dev, "Writing boot command: %s\n",
 		 h->bootcmd);

Don't involve the "ret" variable.  Just len +=.

In the original code, if there wasn't enough space they truncated it
before the " time_sec=%lld time_nsec=%ld" but keeping that behavior
seems needlessly complicated.  They already created one bug by
complicating stuff.

regards,
dan carpenter



Return-Path: <netdev+bounces-43748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 866247D4821
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9111C20BBC
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 07:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B1014281;
	Tue, 24 Oct 2023 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BZu2rwgE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868A134A1
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:12:54 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B76312B
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:12:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c41e95efcbso590286266b.3
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698131568; x=1698736368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zvyukaVomdS/fMuGR5ERBwkiFtCGAAMyJJ1t0SGYhI=;
        b=BZu2rwgEcvVPv7/q17QXyxT0OCMx6TYuytQWjorucsnqVoNQ+u3+0tb0tAjrLnlHQt
         Ynq/JUQ0d/Sl59L3kLkcShoahh5gw+0PPnmgFDkegtnHSyORUpR9eCc3BV9HLUTKJ5uV
         fu4rZuaWGRiiFSWvl6ZYEOZptlaQ9QsmNXuKUqRUdnahT8H0wmglvq6P4pjO8yKPS6Cm
         AWm/+3HdwsCnp6JCdOtabWWwJD9kiEJS8OLd3uJr8fY60vvkAKKHv2gq19mtNiDyYF6S
         fTy0vaYnyqsO+xxPhbgcwnxVphvrl2vzv2+8JD6KeeXQvETg2Xe94PuSH53Zt1MryrQ6
         dA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698131568; x=1698736368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zvyukaVomdS/fMuGR5ERBwkiFtCGAAMyJJ1t0SGYhI=;
        b=JtlT7oPGAmlch6B2R/VrXBIHzXHlO485gNfJLd1ZKPgn7KoQRGP24T5+BSXQOpED2T
         8+d3aIwYhI3Vw+IJ3dHDrPVL9ZksVGwGGkUICxKOAvitA/cxz/MoBmk7MXIi1Uyx71L6
         289Fg3+hkb5TXlQuJF8MrVq6Nw8jP8LQWQQ/PzOhCr6NUXWbr2i48DfOWJTG2Px3Hgi9
         lUk6O2JxY80NJGaC13WeDksokKp63ZBrsRKa+z8R/5sn5rhjSfs1uLN78B+J1wpYdOzL
         dpvFey6I1GxOMJGeVg5c4SHCpxsvDqPZSVyXNWXOebHgpty8a8At8TDe0n+X6gWNBY7A
         Acww==
X-Gm-Message-State: AOJu0Yy/NXpjLaCuv4AOhGX5elIpmYuO/XV6AJml8b3drIUm2ZWwwvGn
	ig0aKpxkGh0y7oHLkoOIILE0wg==
X-Google-Smtp-Source: AGHT+IGs15vl3i2wEFQawQbH/oMNYkOZ+p4EPrMtRFGl1UAO9p4IosSfYVCY/ZPc+mTWaHbFGRR4Og==
X-Received: by 2002:a17:907:1c2a:b0:9bd:bbc1:1c65 with SMTP id nc42-20020a1709071c2a00b009bdbbc11c65mr9035485ejc.13.1698131568273;
        Tue, 24 Oct 2023 00:12:48 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709067c0600b009b97521b58bsm7886126ejo.39.2023.10.24.00.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:12:47 -0700 (PDT)
Date: Tue, 24 Oct 2023 09:12:46 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes.berg@intel.com, mpe@ellerman.id.au,
	j@w1.fi
Subject: Re: [PATCH net-next v2 4/6] net: trust the bitmap in
 __dev_alloc_name()
Message-ID: <ZTdubh4IhXfQiTkl@nanopsycho>
References: <20231023152346.3639749-1-kuba@kernel.org>
 <20231023152346.3639749-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023152346.3639749-5-kuba@kernel.org>

Mon, Oct 23, 2023 at 05:23:44PM CEST, kuba@kernel.org wrote:
>Prior to restructuring __dev_alloc_name() handled both printf
>and non-printf names. In a clever attempt at code reuse it
>always prints the name into a buffer and checks if it's
>a duplicate.
>
>Trust the bitmap, and return an error if its full.
>
>This shrinks the possible ID space by one from 32K to 32K - 1,
>as previously the max value would have been tried as a valid ID.
>It seems very unlikely that anyone would care as we heard
>no requests to increase the max beyond 32k.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


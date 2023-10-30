Return-Path: <netdev+bounces-45346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257257DC2F6
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 00:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A43281375
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 23:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC612E64;
	Mon, 30 Oct 2023 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPtbu3Gw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB03C3C
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 23:09:14 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D56E1;
	Mon, 30 Oct 2023 16:09:11 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so70779681fa.3;
        Mon, 30 Oct 2023 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698707350; x=1699312150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMsMvT+LexruVVRjy+NI0XADZAHKqrW351bNlfZO4V4=;
        b=WPtbu3GwyU5et7MZ4TwVv/2s3dcbmNYJLZLiNnFL+kzxGRGfPJ4cfImtSWS5J2kbgS
         PIlUndMIL2g4RUrMTh1PfjKE3mtwISrkxZ8vicZ9LSF7qOX6EcYUh9gLVOuX4bpTgGse
         rMxK8r/zoZej3cNwI21uoKQFbJVhIbiRD3yb/+iftoRBwx93lASGD4Pb/FsrKsRygvqF
         BrJBFIRdlkkyPNbcuZkkXN/NSdzS2QZfSCr00RkbQ/JzCjNmiehYIf38CmqurdcOlxhk
         SI2paAPHDvLJGRIq4sKcDgLck8pheCKuFDt0JvAXSRC95QbwXQcjzAokcLT4VoycP3Lb
         KOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698707350; x=1699312150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMsMvT+LexruVVRjy+NI0XADZAHKqrW351bNlfZO4V4=;
        b=XC9O2YRyzkYngqbHbkITOnmFVmhR6WZJwvo8KZy4hqgCBJbzlRoMF/jQajEQQKTb+M
         inTEs/rSn+VZUWNluUucFfkjaobEe8L4acqdl0MBuhKg7eiuL/N6CdgJgsckErw4OkP9
         QNtyNrDV7iwjU3rPON0jRRkFqf671deoV6cTlzz198BhHpJHY+HNnYKcQ02pDdMnVj/X
         0dIb8O0imS4WGHWfr6HbUwh7RZ+XkrsezKLN0xQ2oSFhbjGsOBgw3vjoBOtEhp3Roy/d
         /DR1yEsTLzj4AnOgolzBIL8c7td7vBdw7SH/TvQxi1KiSACh7qMRBYPcQvWjJBgNsb0w
         eU/Q==
X-Gm-Message-State: AOJu0Yy/27k2znzfAIWw0s3DZlW6hRN0KJ0KTj4s7TiHbJxtlo+lMSrA
	FvwGx3GCrZGMVpthgN2P6tM=
X-Google-Smtp-Source: AGHT+IFgRqIx5HLzsBHVxNQCtWo8+o98TaqqXQM0k/MWBmcahKs8sxraQjeOFq2tTtLVmGK8qicSiQ==
X-Received: by 2002:a2e:9bc2:0:b0:2c1:6b9c:48d6 with SMTP id w2-20020a2e9bc2000000b002c16b9c48d6mr8239392ljj.16.1698707349363;
        Mon, 30 Oct 2023 16:09:09 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c479400b004064288597bsm71320wmo.30.2023.10.30.16.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 16:09:09 -0700 (PDT)
Date: Tue, 31 Oct 2023 01:09:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231030230906.s5feepjcvgbg5e7v@skbuf>
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
 <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>

On Mon, Oct 30, 2023 at 11:57:33PM +0100, Linus Walleij wrote:
> This of course make no sense, since the padding function should do nothing
> when the packet is bigger than 60 bytes.

Indeed, this of course makes no sense. Ping doesn't work, or ARP doesn't
work? Could you add a static ARP entry for the 192.168.1.137 IP address?


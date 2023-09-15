Return-Path: <netdev+bounces-34123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6BE7A231F
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF3E1C2096D
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1820011CA3;
	Fri, 15 Sep 2023 15:59:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0F111BA
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 15:59:18 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC142721
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:59:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fcb4dc8a9so2200986b3a.2
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 08:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694793555; x=1695398355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=625PTN5iP3Dr6oBoYQ7/1bjc8m/xWKXKVAqc5lWfFNw=;
        b=CjcsFyb32dYcnhN8NJ/I7Mbdd8VBsgWtwS/npIkzOi8sSpkCTbl5jAmAAV8WGMgHZZ
         1mCzHgE1vZf4w788bD7SY5uTzFRTJmgybyIg2IVQJKc57lhUhIFVdg6TSRds+opTN31A
         IZTElUQFTbgqkCMOsLhhK28u+9lCGw6qNJwsAh90uHYT0xyocacWYnFArcm2lxg+U7ZX
         uZe+uoyYD6ZrXsSPVZh5t0qfJhH1dzMzZe/ErKhDp9ylePHtOcMRhyU97qrgnYVswBgC
         Im9B87PLF5H8M1fNCGT25vA2v8QTt6vgGXfJWIwMEUSd+v9UnKtZTjAA3MRqUN2s55jg
         Gmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694793555; x=1695398355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=625PTN5iP3Dr6oBoYQ7/1bjc8m/xWKXKVAqc5lWfFNw=;
        b=i4YJV0P3m+hQ4b5m/DTh6mDCOKxr7lmOeNocVuJFp9a8uwJOAwbCw41EbgtX/se2uI
         MaWhwNj4nwtvrnM9cSHomcE1/klw2Ls5MPxaKTWS+WD0ERG6Ows0gQdy/4ajvrrFI7Nm
         pUoJ9u4cwjuJzX0+qJxkFCZpZ+htudlHCfSBuiBU839rTcp+El+NeGZtMrJo3E7k1/im
         nZmJebyPqLXAlwsGTts4Bli65n5M8nCwpQ4SZGekHUZqrSTlgmu25QLy0Yqf79MBOuKV
         AQIIrA6sOwZw945OqxWd0Hpfiiq16e/41gXPXz0VDS914Qr+CNcR7qk8ucNthmSzTPc0
         tu0Q==
X-Gm-Message-State: AOJu0Ywfh0lJf5mO0mC3DDifKgDprXhTceoHpvQp+grNCduItIbrEV3g
	029SwBVFcCCaMyldWG/wek2JmSZak0TMAFWihYw=
X-Google-Smtp-Source: AGHT+IHlQjsEpd/kcKbjiSPyEafUVB3sz9Jmtg4RIRoOVLIOycKkvsfjaWmAswtR1K0lVFYcnXh8Vw==
X-Received: by 2002:a05:6a20:3c86:b0:13d:df16:cf29 with SMTP id b6-20020a056a203c8600b0013ddf16cf29mr2803322pzj.15.1694793554716;
        Fri, 15 Sep 2023 08:59:14 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7849a000000b00686bef8e55csm3159946pfn.39.2023.09.15.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:59:14 -0700 (PDT)
Date: Fri, 15 Sep 2023 08:59:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, David
 Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2-next 1/2] configure: add the --color option
Message-ID: <20230915085912.78ffd25c@hermes.local>
In-Reply-To: <844947000ac7744a3b40b10f9cf971fd15572195.1694625043.git.aclaudi@redhat.com>
References: <cover.1694625043.git.aclaudi@redhat.com>
	<844947000ac7744a3b40b10f9cf971fd15572195.1694625043.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 13 Sep 2023 19:58:25 +0200
Andrea Claudi <aclaudi@redhat.com> wrote:

> This commit allows users/packagers to choose a default for the color
> output feature provided by some iproute2 tools.
> 
> The configure script option is documented in the script itself and it is
> pretty much self-explanatory. The default value is set to "never" to
> avoid changes to the current ip, tc, and bridge behaviour.
> 
> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> ---

More build time config is not the answer either.
Don't want complaints from distribution users about the change.
Needs to be an environment variable or config file.


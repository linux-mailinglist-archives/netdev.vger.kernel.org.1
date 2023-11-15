Return-Path: <netdev+bounces-48092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F107EC7FD
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6C1280FF3
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904CE433CF;
	Wed, 15 Nov 2023 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="elQNmp/7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81192C848
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 15:58:03 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9BBA2
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:58:02 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c4ed8eef16so5378824b3a.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700063882; x=1700668682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZD+QVCMTfwt5SQkaapp8sA6RDdyskoGJOT1ImXj0xQ=;
        b=elQNmp/7re7TrhJDAl80u7g9/yk/yLMKYIypiqLd187YaGsyW2QLhLlESuZnmJDL4B
         2y6YY2zJuZKEs9lfKeVM7jMY9klUhDGZDHPRaz2UIKdwCizW7LZ4kZJ9X4ykwNXEk+yH
         S4apGGLDHr1Kw/fNfSHJtXUrq6nbIG7Df73poZoPFR0VjHVJcpC6MamdzFeDxf0tV6fB
         exHy1auLy+6eDWNn1HK20QYp85eayY0AZYg0D98ixgV38SXDkWJbjMf/b5mXrg2jfLWa
         L+zZsCvpxGP9mOGvdyyY8KkUCTGG95ccnLKZmP35z33HAfT0LSdzdLqmQuneXNcPY/1I
         qzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063882; x=1700668682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZD+QVCMTfwt5SQkaapp8sA6RDdyskoGJOT1ImXj0xQ=;
        b=WobWR0UqCq3JI63vDuKF5W6VcWw2TrsaIJzHi0VbdFg9Np+q1275LhjjVLYKU7AMGz
         p9Q3U+WfR36j3sxd9/U5yrmCGsHD8So7JSKksVEv3NAeppZ9NCe7czW/w+eB507FX4tl
         BHebu6dokzzUOquSvpqe35GZGiNeVV4Bxyb2Y4R/Ylro6+gfHGljBIlP/M763tx88jk+
         z1fQqp/7v8g+n1X84wSF4LQMG3gm6k28FRceNu3prDKgKZAp8X4VuOQq2aziZiR2MXTl
         nA1A/xJ5JjDUQGPOb4hA6n6qgZ5+6GddpJDxQAzGZipG07QA95/Qy4TbLyF/Iv7WsyHy
         Y8vQ==
X-Gm-Message-State: AOJu0YxauZ2m0FdayfMP3EvBuQq0/ryYKmZQg5ug9UAclURjOdkP9+Mi
	hKP+n9TPdvXZ1sYQgpJLfYDfSQ==
X-Google-Smtp-Source: AGHT+IEozYd1s+NVHo/yFwGaFR8ZBn/1l+FhWxYvAxe5plJn6hoRA0Ujhz6tqQ9ImGkVp7L13DHrAw==
X-Received: by 2002:a05:6a00:1bca:b0:6c3:5f49:6da7 with SMTP id o10-20020a056a001bca00b006c35f496da7mr14861647pfw.2.1700063881718;
        Wed, 15 Nov 2023 07:58:01 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id t38-20020aa78fa6000000b006bfb9575c53sm2949255pfs.180.2023.11.15.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:58:01 -0800 (PST)
Date: Wed, 15 Nov 2023 07:57:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>, Patrisious
 Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH iproute2-next 3/3] lib: utils: Add
 parse_one_of_deprecated(), parse_on_off_deprecated()
Message-ID: <20231115075759.08921704@hermes.local>
In-Reply-To: <8ca3747c14bacccf87408280663c0598d0dc824e.1700061513.git.petrm@nvidia.com>
References: <cover.1700061513.git.petrm@nvidia.com>
	<8ca3747c14bacccf87408280663c0598d0dc824e.1700061513.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Nov 2023 16:31:59 +0100
Petr Machata <petrm@nvidia.com> wrote:

> The functions parse_on_off() and parse_one_of() currently use matches() for
> string comparison under the hood. This has some odd consequences. In
> particular, "o" can be used as a shorthand for "off", which is not obvious,
> because "o" is the prefix of both. By sheer luck, the end result actually
> makes some sense: "on" means on, anything else means off (or errors out).
> Similar issues are in principle also possible for parse_one_of() uses,
> though currently this does not come up.

If we need to keep accepting shorthands, I would prefer that any
use of shorthand would cause a warning message.


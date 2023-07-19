Return-Path: <netdev+bounces-19286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8C675A2CE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 01:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9969281865
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C1B263A6;
	Wed, 19 Jul 2023 23:24:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA71BB27
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 23:24:59 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E092101
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 16:24:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666ecf9a081so126265b3a.2
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 16:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689809094; x=1690413894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMBXWfDTfMeBEXpKpdrCux7UOxDUWWDJl0r9KLthi7I=;
        b=RitoPG5vg2KH92ckG+V7d8L8L9W7M1MBD8JemTd7YYR3fTJrTOVFYtqqXzUnBKMuir
         5mWALTL5KmWaQJU0sCdTf1pDvm6hLmYvUeYrkwPsO1SZCFet8sGivcjzWo2/jJSQ+69r
         tWFF5/07XRl/q/8uN+rCYjwQhkZBkDDkJmR7gbwa/MDL9f0w0sZGSvooJmm5Ax+0ioy1
         H/sOq8DkuI4B9Gm5OL3DqroseeCwVW7yCWj9quaQcgXz/+7NKt05sQF+GJ9/12jWPXZ6
         8j+EKQKrYcWo0PuWQibJD8tsH5yifa7BtFwNC8Ufe7awQAN0xt48aMlwNrlWN/lcUSoO
         93QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689809094; x=1690413894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMBXWfDTfMeBEXpKpdrCux7UOxDUWWDJl0r9KLthi7I=;
        b=XUqd3lmOeJ+dbDq08dUQ896+fbvM1+9h2V4TJCteWrnZLQaWS/KRK7z16IUWNdD5bh
         Crz01LsRDtHXyXI5LPKDsTjaa0fYa8gp8+Tv21ofWTOoq3OVCxLQjCItDRB/FVrAGsIH
         doyIoB7IMXQmV9Zootdib5D74kskh5hxVleWb7X9Qe2+P4Tf3pa2Lg6YmM3AzExYkyYt
         nejvvhlnhXavm+yRHBq3LI9kxW6y0n9oXdpwW9mUzL6cfDni6PbOlmn7z9Iqm05FISGH
         VsLHCfrY+J02ZJBn7HqX33/3GiagZlWtsvS6AcaBzG9T9ed+ugnh9SDOGFzdkUXnnft+
         6RJw==
X-Gm-Message-State: ABy/qLYQRBNexQ+s+5C/qlVC9TgS2EP0vQLRNt6LcxNAGNGFWY3dqpB/
	fzxD0zyc5CXjeJUU5eOs2ONr0g==
X-Google-Smtp-Source: APBJJlF1RVY7gVrV+x6J0pGqg/vEpRGAJ3WpkIaplw7rwOALVicAHlHdlSUsDv1w5+4aog7vtr7zhQ==
X-Received: by 2002:a05:6a20:840b:b0:126:a80d:4960 with SMTP id c11-20020a056a20840b00b00126a80d4960mr28216893pzd.30.1689809094040;
        Wed, 19 Jul 2023 16:24:54 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78757000000b0067a1f4f4f7dsm3780558pfo.169.2023.07.19.16.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 16:24:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qMGXL-002tBd-Tt;
	Wed, 19 Jul 2023 20:24:51 -0300
Date: Wed, 19 Jul 2023 20:24:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	netdev@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH 00/10] Device Memory TCP
Message-ID: <ZLhww+P+7zhTTUk7@ziepe.ca>
References: <12393cd2-4b09-4956-fff0-93ef3929ee37@kernel.org>
 <CAHS8izNPTwtk+zN7XYt-+ycpT+47LMcRrYXYh=suTXCZQ6-rVQ@mail.gmail.com>
 <ZLbUpdNYvyvkD27P@ziepe.ca>
 <20230718111508.6f0b9a83@kernel.org>
 <35f3ec37-11fe-19c8-9d6f-ae5a789843cb@kernel.org>
 <20230718112940.2c126677@kernel.org>
 <eb34f812-a866-a1a3-9f9b-7d5054d17609@kernel.org>
 <20230718154503.0421b4cd@kernel.org>
 <CAHS8izPORN=r2-hzYSgN4s_Aoo2dnwoJXrU5Hu=43sb8zsWyhQ@mail.gmail.com>
 <20230719105711.448f8cad@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719105711.448f8cad@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 10:57:11AM -0700, Stephen Hemminger wrote:

> Naive idea.
> Would it be possible for process to use mmap() on the GPU memory and then
> do zero copy TCP receive some how? Or is this what is being proposed.

It could be possible, but currently there is no API to recover the
underlying dmabuf from the VMA backing the mmap.

Also you can't just take arbitary struct pages from any old VMA and
make them "netmem"

Jason


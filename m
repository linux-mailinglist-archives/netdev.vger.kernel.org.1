Return-Path: <netdev+bounces-48846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0867EFB44
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668F028134B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 22:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B9C4503B;
	Fri, 17 Nov 2023 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="NYjYoKZi"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEAFB8;
	Fri, 17 Nov 2023 14:17:13 -0800 (PST)
Received: from localhost (unknown [98.53.138.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 48BEA2F3;
	Fri, 17 Nov 2023 22:17:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 48BEA2F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1700259433; bh=+iMSu9G5yo159Da0W+TlYSAqLVEKQPYPsL87vIzTR0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NYjYoKZifeWoc5EeO5E7HW+n4uJV2C8f/PrKyqy39mTB3ngF8SqierEt7ksjRr2nz
	 VLi6Iquf0yQXoNffLE2BACfc9csSE1zUZE4V3Z06JCgeOvBkMaPYRxNR1JMTRzf/wd
	 AKPcCWqdp9/TBLy6SdyEaIeNErljIPYCUeVtvauG7lztG5AZEEZm18D/HLWYWqPghl
	 YuHXK8RtwnOhMcvhPSkPSJRiQ1HMfBMyHzcFutWc0yNaTH1Tv4VlvDArjlej430S5x
	 Y42VIrJvfC/VwVqwG4pXbUZkBk8R1ugwtH4AKiTWBYla507gwMjEUMFovXbtcm3R7j
	 47erXVF184XHQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
 donald.hunter@gmail.com, kuba@kernel.org
Cc: leit@meta.com, linux-doc@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Document each netlink family
In-Reply-To: <20231113202936.242308-1-leitao@debian.org>
References: <20231113202936.242308-1-leitao@debian.org>
Date: Fri, 17 Nov 2023 15:17:02 -0700
Message-ID: <87y1ew6n4x.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> This is a simple script that parses the Netlink YAML spec files
> (Documentation/netlink/specs/), and generates RST files to be rendered
> in the Network -> Netlink Specification documentation page.
>
> Create a python script that is invoked during 'make htmldocs', reads the
> YAML specs located under Documentation/netlink/specs, parses one by one
> and generates a correspondent RST file for each YAML file.
>
> Create a new Documentation/networking/netlink_spec index page, and
> reference each Netlink RST file that was processed above in this main
> index.rst file.
>
> In case of any exception during the parsing, dump the error and skip
> the file.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

In principle I like this approach better.  There is one problem, though:

- In current kernels, on my machine, "make htmldocs" when nothing has
  changed takes about 6s to complete.

- With this patch applied, it takes a little over 5 *minutes*.

Without having delved into it too far, I am guessing that the
unconditional recreation of the netlink RST files is causing the rebuild
of much of the documentation.  Even so, I don't quite get it.

That, clearly, would need to be fixed before this can go in.

Thanks,

jon


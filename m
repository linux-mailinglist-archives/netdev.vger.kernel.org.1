Return-Path: <netdev+bounces-49720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099747F336B
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7245281E6D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0015A0E8;
	Tue, 21 Nov 2023 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcPyiw/L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6F1F93C;
	Tue, 21 Nov 2023 16:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478BBC433BB;
	Tue, 21 Nov 2023 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700583323;
	bh=GkJN6hJwY0IEsFz7BKwOr5uoLUCm7aY7Ss1OnguqbVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jcPyiw/LekP14xSMdqxxkRSbDt4V0bjZcTxCsAREQbejJEya183Ksc3TWESmWAGYj
	 vIPQkJZA4wJPqoQNsg1p9hiuAHZ+XxV/8ikh8loDBxe92L/qpgtvCUlC6C2xQU0U5p
	 GfeKtpAi30IrHuoC0zIP1+qfeeDAWI044/bQ9EVQyGwKgXwKdWNgt6005pCDtY8uV5
	 YO7C8THNQYbuKdru1O2GKDCL0c/s9C0qbvT/ty5oHtCfFu/giDax2WMuPeIX+xmLqY
	 7vwdvkh6uZvCok59a6/EGzZoDp+EEKkGtMVuTyur6ej0fOPJZxSHaPN5AK3kqgpYov
	 JfIaHLTlASZUw==
Date: Tue, 21 Nov 2023 08:15:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH v3] Documentation: Document each netlink family
Message-ID: <20231121081522.6ea6969a@kernel.org>
In-Reply-To: <20231121114831.3033560-1-leitao@debian.org>
References: <20231121114831.3033560-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 03:48:31 -0800 Breno Leitao wrote:
> This is a simple script that parses the Netlink YAML spec files
> (Documentation/netlink/specs/), and generates RST files to be rendered
> in the Network -> Netlink Specification documentation page.
> 
> Create a python script that is invoked during 'make htmldocs', reads the
> YAML specs input file and generate the correspondent RST file.
> 
> Create a new Documentation/networking/netlink_spec index page, and
> reference each Netlink RST file that was processed above in this main
> index.rst file.
> 
> In case of any exception during the parsing, dump the error and skip
> the file.
> 
> Do not regenerate the RST files if the input files (YAML) were not
> changed in-between invocations.

I can confirm that it does what it says and incremental make
htmldocs does not take forever.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!


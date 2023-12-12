Return-Path: <netdev+bounces-56177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FCF80E13B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B716DB21019
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 02:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9A6EDC;
	Tue, 12 Dec 2023 02:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz8DC5Sq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB023A0;
	Tue, 12 Dec 2023 02:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6DAC433C9;
	Tue, 12 Dec 2023 02:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702346677;
	bh=mTxd3NnExIqswI3JfYyfPCct5v9MTCPCUzbB5aTgOr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sz8DC5SqnEdfioxx6lgXcwQV6c9QJbVoiAEdR8b5WJEf2I5x+RUK4U6poELQMSjtQ
	 nO13Mjkfy496W7wRwj+i8/XWJLP3JP3Er48r/hWptpyostu7yBn0TgAyr6EkWGLfO3
	 0sci2BXnLLVuqqhjGEuEHeDMsXI9Hw7hfw/sjrc4Yp+hbN7e3Blna42URKOB1EY251
	 7P8ppr6AQxjGVllM2JULd7ZoC/Xn6BRcWm/hTv1ki5q1+Q7vctwXF97ptpkThbTLBw
	 dBwwlWoaTfSLJtSdSyBtiia8ry+dEEKJ6MOQ+TwhAYdNXVrTpzNyfjHeNozIx0BhvL
	 Qj5uwpTVZxQ1w==
Date: Mon, 11 Dec 2023 18:04:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 08/11] tools/net/ynl: Add binary and pad
 support to structs for tc
Message-ID: <20231211180436.5560720e@kernel.org>
In-Reply-To: <20231211164039.83034-9-donald.hunter@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
	<20231211164039.83034-9-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 16:40:36 +0000 Donald Hunter wrote:
>                  description: The netlink attribute type

We should perhaps "touch up" this doc, and add that for the use of pad
within structs len is required. Would be even better if you could
convince json schema to validate that. The example that starts with 
a comment:

  # type property is only required if not in subset definition

should be pretty close to what we need here?

> -                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary ]
> +                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary, pad ]



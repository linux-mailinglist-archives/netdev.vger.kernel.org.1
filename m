Return-Path: <netdev+bounces-53200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53258019E7
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DAC281E96
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0714407;
	Sat,  2 Dec 2023 02:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqifTGBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA32D15A3;
	Sat,  2 Dec 2023 02:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E12C433C9;
	Sat,  2 Dec 2023 02:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701482807;
	bh=wPE5/utOUPTsgmefw3BF1mfW+IGdNlevAt1jGsnifsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hqifTGBLGd8b1scrmaofq+2sOHRY9uLveYBrd0Rcg7SE6Acgn+veSTaumxyWRQDV2
	 y5afYjwJTffcx7hYrdNEjsGfqX7FJczUGaLCpyhIMkG6NkMTR2WlxbASWmWQ9BXXAr
	 DHNCIR0HdNodlJ9ETlWhWWTsngcydS9jsIEmHZXMFF2DkLc8xc945Rdq+sBVsuq+O2
	 N3WXadZYPhb43cbJ2C/QSMXQSmnDuz54boinBAfeq/8WsEfu35tjWwWTBYMWqCqVcx
	 HG1++YrWW+8dXQJqvQQUYnzeRrF/aW38FkVBaa0PJGTgCZ4UtWrkXENkLYBtv82R2m
	 keD8x+DV0dVig==
Date: Fri, 1 Dec 2023 18:06:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 4/6] tools/net/ynl: Add binary and pad
 support to structs for tc
Message-ID: <20231201180646.7d3c851f@kernel.org>
In-Reply-To: <20231130214959.27377-5-donald.hunter@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231130214959.27377-5-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 21:49:56 +0000 Donald Hunter wrote:
> The tc netlink-raw family needs binary and pad types for several
> qopt C structs. Add support for them to ynl.

Nice reuse of the concept of "pad", I don't see why not:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

> +                value = msg.raw[offset:offset+m.len]

What does Python style guide say about spaces around '+' here?
I tend to use C style, no idea if it's right.


Return-Path: <netdev+bounces-53202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 098908019EB
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECA8B20D84
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDF25245;
	Sat,  2 Dec 2023 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaONHU4D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B7E3D8A;
	Sat,  2 Dec 2023 02:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1D4C433C8;
	Sat,  2 Dec 2023 02:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701483206;
	bh=ppEeBtliXh5uxKLB+Ykskcykb4e8NyftDSjZM0SdqlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FaONHU4Du+eimhetCfF8eE9a9Upr9Y+B1x8PPuQovJWZnDC0naQHctrm2/omyewrp
	 DZNAL502LL7P63/QFHeBUsQZ0fWVBtF17RPoD9GB2hrL/Hl1NzfrvRW7YUP4G6RW6p
	 /iT2fCRMJecSLtR1s3RDwNSkL7QElXrUO6zmfMkCnmddPV7w/5n/xiJixwdpvqjFEo
	 gMdBEH4y0JPe7rz8Xm7X3i5tzG4apsRyZPfiTrSYZ3tLsIgSwClXio7Tly/B/JNtxv
	 3MIEZdY0Bx/Ka8oqfGF6sYAkFq6T5wpE9i/uAT+Cc1A38ewxEIJuxtYTjoH6vBw2+t
	 Cl/pUK1j43/uA==
Date: Fri, 1 Dec 2023 18:13:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 6/6] doc/netlink/specs: Add a spec for tc
Message-ID: <20231201181325.4a12e03b@kernel.org>
In-Reply-To: <20231130214959.27377-7-donald.hunter@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231130214959.27377-7-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 21:49:58 +0000 Donald Hunter wrote:
> +      -
> +        name: app
> +        type: binary # TODO sub-message needs 2+ level deep lookup
> +        sub-message: tca-stats-app-msg
> +        selector: kind

Ugh. Meaning the selector is at a "previous" level of nesting?


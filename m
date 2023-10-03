Return-Path: <netdev+bounces-37709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12FA7B6B2C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 39768B208DA
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BAB30FAC;
	Tue,  3 Oct 2023 14:17:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE12AB3A
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B9AC433C9;
	Tue,  3 Oct 2023 14:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696342627;
	bh=kSy8cr3ZOx+YW40kNqWscNITU4mfjvRvlwOvHDKsVWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1tOg/O43eTvAqg0eVtYLHBWNOqYX1o7L1YKzcJsH/8CpSxp1CgEPzBE4f7z18OLb
	 lWI6cqx4YRAgQD5daubhzYtVTzKOmWOH+w2mB2Lh41c3TgU0yELsZhPAGyXluNc1cE
	 4GMl5NA6bDvBAQCZ4K5drcFhZj79BdLk6ZgdVKx+gjd1XrydOsnRmecOJw0yCKfQdT
	 XAvLJOBfAoXprKoNIVOE8SUkjDOw6z9onIkG1nVXBnDZMeVZo55tP4IW/3pR6iGAAr
	 vkPlyCmA42Bh8ZvDayF4Y4NV5DVHeu9v9wFGf4z60LEYYKGmMgvjG+N4VEtAGbnR8s
	 pESlf/uRjCI3Q==
Date: Tue, 3 Oct 2023 16:17:04 +0200
From: Simon Horman <horms@kernel.org>
To: Michael Pratt <mcpratt@protonmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rafal Milecki <zajec5@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v1 0/2] mac_pton: support more MAC address formats
Message-ID: <ZRwiYOH8wsNqPmED@kernel.org>
References: <20231002233946.16703-1-mcpratt@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002233946.16703-1-mcpratt@protonmail.com>

On Mon, Oct 02, 2023 at 11:39:55PM +0000, Michael Pratt wrote:
> Currently, mac_pton() strictly requires the standard ASCII MAC address format
> with colons as the delimiter, however,
> some hardware vendors don't store the address like that.
> 
> If there is no delimiter, one could use strtoul()
> but that would leave out important checks to make sure
> that each character in the string is hexadecimal.
> 
> This series adds support for other delimiters
> and lack of any delimiter to the mac_pton() function.
> 
> Tested with Openwrt on a MIPS system (ar9344).

Hi Michael,

I am wondering if you considered a different approach where,
via parameters and/or new helpers, callers can specify the
delimiter, or absence thereof.


Return-Path: <netdev+bounces-99231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A198D42A9
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9207B22284
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3870DDC5;
	Thu, 30 May 2024 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcS/5c4W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11BBE58
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031072; cv=none; b=IVPJKkWhGZcM+PYjYCfAHUy1MzOWdi0YZMXh5EVNknI64ZjB6WFCrhZLEXWsBU+wqZKSre4ytE7SAo+FeMWp5uDuKHmksyylAyCB48Eiy47Sma/+dME0ND+48FEn4PmO/qjNRZ5m5ALclbMxuc58VyBW6CXcO0CqgxBKIVW30Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031072; c=relaxed/simple;
	bh=TIve/1QtiRtCrmBVgpV6PaurXsYKrAffqTnH294pPJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZ58f5OznMqPjjut2NvNzm3DTd30H2InJBZxwYOCdvFJtLr7aGmqIuVJEFWGv9zmOH+lrmzHIfpi7g+Q3sv1E558wqxp1RHhnSl3sBL9F0EMvpYMfbmT/DN9nAWD4vJy0uNp18QPm/IPaM2pImuzeAdMcarJtqJXRaoGuJiCEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcS/5c4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B38C32781;
	Thu, 30 May 2024 01:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717031072;
	bh=TIve/1QtiRtCrmBVgpV6PaurXsYKrAffqTnH294pPJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lcS/5c4WTLXdvcDTB55xPW9zGHS6+/oOVd0y4xa+8rcPXq18wgbPc43tnLCYYEzlg
	 p8nrorzmAApDYY2MMp56XYIUhJHYqs4NX+95x8Jum9yxxT8davgZSrUc/nfJI1QlPI
	 pFUDoKpyhHCR1YbtVqXVuUaB4D8/DKur0Om3J2jkwoLa7Z8Yerf8q1HdDqThEb280y
	 SmbPHQHScvXtck/gldKrq/5JhJF88cYBFuvx2ndjWXfzxEK6VT3mNIg1kFBK7tsTw0
	 2r0SDYTh8JF7040TvlkZxyNjMqyrmfGGkxkh6FoPeEOi0TL7LCwe17BLNJojIAPJiK
	 NJb1y9JlP+iJg==
Date: Wed, 29 May 2024 18:04:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Breno Leitao <leitao@debian.org>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/4] doc: netlink: Don't 'sanitize' op
 docstrings in generated .rst
Message-ID: <20240529180431.61bd6f05@kernel.org>
In-Reply-To: <20240528140652.9445-3-donald.hunter@gmail.com>
References: <20240528140652.9445-1-donald.hunter@gmail.com>
	<20240528140652.9445-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 15:06:50 +0100 Donald Hunter wrote:
>        name: pin-get
>        doc: |
>          Get list of pins and its attributes.
> +
>          - dump request without any attributes given - list all the pins in the
>            system
>          - dump request with target dpll - list all the pins registered with

This actually gets rendered as a list now, nice!


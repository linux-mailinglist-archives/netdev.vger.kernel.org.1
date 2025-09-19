Return-Path: <netdev+bounces-224749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E8FB892A6
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC114E0BED
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A4B309EF9;
	Fri, 19 Sep 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLRGk9kh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432A19755B
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279500; cv=none; b=KXioQUBwUdbHmuzMoGlSCB5wl25KT3P48d0ZIE2wJjNENbkR+pgaF2F9rtJVn45M8S5R7yQylewAAOu5k35otdaIfCBfHVFOShCUn1e59NffJdhE2PoOon9IVS5sGgl576cYHMDiUwpxRWm78fT2Kv4KrO9KBQFDkxD3zVC5Giw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279500; c=relaxed/simple;
	bh=L+RvQwtJCTNQUc/QNY9U+ST+/413JNbrge2ndpkh1/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFM2NrMpQNqYMGq0Rpehk74iuk9oYnpY3HKekLxu1EV7pqV4lKD+f9yDZHr+ctNookUhB6yiF1xoHkJdDG5juF8+8FP27nAE+8HXVGOczlDCXSUnp5+py+Bv49picviX34rlD1ONPv9cr+mYsnRcyhF1iJaxQFbTiU+CSRNuw0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLRGk9kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17049C4CEF0;
	Fri, 19 Sep 2025 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758279500;
	bh=L+RvQwtJCTNQUc/QNY9U+ST+/413JNbrge2ndpkh1/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLRGk9khALd2LHtPKfypvsCa7ksiqdINf7kNvjvtQHKpr8RxMvqpwLhPbbGFvU1Xh
	 cNvPcs2X0PRLKm+XWJmqyNu5JxKECZ1ifi/JrJfqtdDagAIucnMyUM7Igc2yYNdX1T
	 5aZpANQUJYusUpGb9ooMopUCDS0R3NqdjEMQFOEbniyDOE/pGw7iAcSxB5bm6aXcsB
	 3MTCpi51gq+aXQWGDb1WBJdQq/4v1YOQgL5Pn9ZotPZmIfgwFFjQb3OsrZ3uHV+3g7
	 /+a2GZDoA1RSCsTPJNaik+cXCLB0lU8My8/LGqHVzBPwIGFXq4rx54/rRv4v5uL6lR
	 /qmffIkST1KgA==
Date: Fri, 19 Sep 2025 11:58:16 +0100
From: Simon Horman <horms@kernel.org>
To: Jan Vaclav <jvaclav@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/hsr: add protocol version to fill_info
 output
Message-ID: <20250919105816.GA589507@horms.kernel.org>
References: <20250918125337.111641-2-jvaclav@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918125337.111641-2-jvaclav@redhat.com>

On Thu, Sep 18, 2025 at 02:53:38PM +0200, Jan Vaclav wrote:
> Currently, it is possible to configure IFLA_HSR_VERSION, but
> there is no way to check in userspace what the currently
> configured HSR protocol version is.
> 
> Add it to the output of hsr_fill_info().

Thanks Jan,

I agree that exposing the version to user-space makes sense
if it can be configured from user-space.

But I also think it would be useful to provide a brief example
of using this feature in the commit message. E.g. an ip command.

> 
> Signed-off-by: Jan Vaclav <jvaclav@redhat.com>

...


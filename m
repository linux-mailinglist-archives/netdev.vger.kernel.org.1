Return-Path: <netdev+bounces-86300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE30D89E543
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91081283748
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F7158D74;
	Tue,  9 Apr 2024 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klmgdmIH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67EA158A3C
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699917; cv=none; b=EyvFyTVeJPv/HvBGFoY43YbjBzFgveFP7aHgHtoLVKvqhLN+A3VFlJglUbnTKRdwDATYJ72/0Ym7C1WKvJlfARmslWORuKeBoQCJ7Hj276zUgkC8C23F58NGZlHqNlUfKLd9By9hqMwK4DGhygYi6NTL2bPU66yK5jOGxKnH/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699917; c=relaxed/simple;
	bh=zt2Xh8ODc/cO9HTY33Ww4VGqw3gEQPhOE+tHFf6VkeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYP/R61r1AB/u3qsTGv2rPlktGCWU10FlfHaNffLfCjA/RxG7pjPbeU44864Mhg8QV4Lij+a686/xqvqmWM+F4dIdlu+0qW8d+UyU7X98TulnW0EZq8P2EHjEXKeZBJpOGXwZKCFOyz1xzEEDFYLZC5BYRv+v+IIhiQgDvmg4iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klmgdmIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66F2C433F1;
	Tue,  9 Apr 2024 21:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712699917;
	bh=zt2Xh8ODc/cO9HTY33Ww4VGqw3gEQPhOE+tHFf6VkeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=klmgdmIHXekn0+ToNP76m/tSz+gmJ9b+pkNtYah52r+88QGsMs/U8X2tH0q0NBIr7
	 1DaRIVgjWFZotcdupviEpvnuIRDlC42PoItszlnlPzuIKGB/DpSEdOP0znTJL9wyX3
	 l715583WQURihXklz46h6Ii+WZv5oXyFfmBC/02fZOUyDjeI6ihuBlZYP+KZnnGGw5
	 7w/M/zAMzTaVhDNj7xw7E4uTjvsgnwZqm62gSzExKpCiuUcGq5XMOxaXDRlaguE1YJ
	 cq+yJAfpWDanYHcg/AH3u9Xu+yS91+b1LsKCFNSRZjWLgftm9ZOA7YVwwqOR6COcQC
	 aD+7nbf67zJXg==
Date: Tue, 9 Apr 2024 14:58:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>, aleksander.lobakin@intel.com
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, jan.kiszka@siemens.com
Subject: Re: [PATCH net-next] net: ethernet: Move eth_*_addr_base to global
 symbols
Message-ID: <20240409145835.71c0ef8e@kernel.org>
In-Reply-To: <20240409160720.154470-2-diogo.ivo@siemens.com>
References: <20240409160720.154470-2-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Apr 2024 17:07:18 +0100 Diogo Ivo wrote:
> Promote IPv4/6 and Ethernet reserved base addresses to global symbols
> to avoid local copies being created when these addresses are referenced.

Did someone bloat-o-meter this?
I agree it's odd but the values are tiny and I'd expect compiler 
to eliminate the dead instances.
I mean, the instances are literally smaller than a pointer we'll
need to refer to them, if they can be inlined..


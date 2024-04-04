Return-Path: <netdev+bounces-84670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DC3897D77
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 03:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EC128C21C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 01:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C2CA40;
	Thu,  4 Apr 2024 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFu/whxi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73CC4C6F
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 01:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712194973; cv=none; b=MCecds/c70WJ5kAOKEJL2kE76h6r7zPShWjuy+CXKPG/yoFWdEKQaw/HC50WczBgZ8Lqeyc/lTdjd9G446pQeidc5VHZW//sYg9BfkT3w8BPvb58zCy+ymrFpYzJzuDVkpYW+odaBMdXcWeANIfx1ylnxT66cADzbmfsvAd/9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712194973; c=relaxed/simple;
	bh=zCaB2dYtjuerklQKFCRzEAyjLZSL0R3Etl5JFJVxM2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wbk0dp0y2NUuwUQeLt9wwhq+kS90DA/FhgZVZk6M1H6qZLSOZ7VvBbik2JkvS5kHCb20Fn5JZTqg+XTD/dSmyyfwivIegz6IvSAHOiK4RQ+l/HP0rB/IMBVhuFjH3vHtWrmF0ozpQMdgfHo5PPFqk2H8hL2aKC74TIlM3kD5/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFu/whxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB1BC433C7;
	Thu,  4 Apr 2024 01:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712194973;
	bh=zCaB2dYtjuerklQKFCRzEAyjLZSL0R3Etl5JFJVxM2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XFu/whxiBptTmuXk9r0701N+Tk+d7rYPaoqixHhB08wUlyF0G52FEw7EHbQOQqR8c
	 azmn8vSKMk3cPpG7GufVXiotvHrYXw6TN+AoODgrxr99jlNfJHpT2U5CYW5X++mPK9
	 B+LNKORoezxFhAetk4k/jopNcMpLPcwQCGQeFH87ebWOWGfTgMI3N0xtSYuFszxMXM
	 p1vPCCZYgrj8dwOTwDwt+/aBd1SDwESIdJfC3hABqLz0H18h83Y9uLmpQH7/TIHFtM
	 f+PgTGEn5HPYmUqb5A5AWbkdVkVLX4FlCmKqfi7bggclhv11R3NCn+kd37Hsxp4sn1
	 vXN/KE9PBgVCQ==
Date: Wed, 3 Apr 2024 18:42:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Fei Qin <fei.qin@corigine.com>,
 netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v3 1/4] devlink: add a new info version tag
Message-ID: <20240403184252.7df774d0@kernel.org>
In-Reply-To: <20240403145700.26881-2-louis.peens@corigine.com>
References: <20240403145700.26881-1-louis.peens@corigine.com>
	<20240403145700.26881-2-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 16:56:57 +0200 Louis Peens wrote:
> +board.part_number
> +-----------

make htmldocs says:

board.part_number
-----------

Documentation/networking/devlink/devlink-info.rst:150: WARNING: Title underline too short.
-- 
pw-bot: cr


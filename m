Return-Path: <netdev+bounces-38089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC517B8EB6
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4A2201C20852
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD77D2375C;
	Wed,  4 Oct 2023 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUT7sm5f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEBD219EB
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 21:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6422BC433C8;
	Wed,  4 Oct 2023 21:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696454654;
	bh=FVWYhbxPfg+NUqYv6k/q0dhpKV2Gxtj/d+mUBUkDx8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DUT7sm5fdUL6LlCc00PPq06Au8x8WuQDckrxoUYP/1Ff7HocvMKxOMYFShvXD2JHV
	 uwDjNVRlj4cQevom8Mmq8u+kNLzIPuCNjnxJLZRSl4IZu1s8gyPu8hTZtXBfPA30IZ
	 HGpTD1KU2SZJPrulahbKzd2C18sNAPRH7ZXwPSUZSawQ90YXwxFqWKX0NAs6niORLg
	 2q8ipQOH89OMS6hsTjhCv5Yak4jsusrXFRtnOf1byLNXfWVK44O66c3M28eR1h5+eJ
	 XTDLftwZphfiFtvZEuFxTzTUBf5eDYVO8WgRByhvjYxJuPTOI56KFfSDk1Yz+RP1LT
	 04QHfdB8IJXdQ==
Date: Wed, 4 Oct 2023 14:24:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wedson Almeida Filho
 <walmeida@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 29/29] net: move sockfs_xattr_handlers to .rodata
Message-ID: <20231004142412.153f2993@kernel.org>
In-Reply-To: <20230930050033.41174-30-wedsonaf@gmail.com>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
	<20230930050033.41174-30-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Sep 2023 02:00:33 -0300 Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This makes it harder for accidental or malicious changes to
> sockfs_xattr_handlers at runtime.

Acked-by: Jakub Kicinski <kuba@kernel.org>


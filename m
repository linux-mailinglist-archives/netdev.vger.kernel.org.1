Return-Path: <netdev+bounces-150290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B724A9E9CDC
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A108618878F2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310FE14AD38;
	Mon,  9 Dec 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnEgHlAO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C100153BFC
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764862; cv=none; b=Do2P4ejjsrhjCsw2+zpLlTDscFhW74vNaJMEFvosUhZUKB+vaROAUZqMTRQYFqCEeEad0P6TqbgGj9NTr6s7HrwmYOk/IRA2InNIhdDkzT+nCYDBsaFXGBAElfOzR3Oav6zjPoEcTujHNdql3t7vEP7DhKlfbIoij3WyUXEtEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764862; c=relaxed/simple;
	bh=5QvFyS38VWK4QvWw0wNsjBO2y+9YwcgX7vY/cUlJRsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ncw9/PYxXtWZfpLcufivco9Icvcj9COJmnT8W/9EOOPopEOcIgXG1I18CV4JyP6Vl3KvYqeEQ1BXnRBCJFr9oCnMFOyiWUrxwE673Uc/RgnzJpe52JQRerz+5WeogrVlGz6N94thx8+VAXovDTTszI4UCofBSaYoa1+n0cHqdHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnEgHlAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0521AC4CED1;
	Mon,  9 Dec 2024 17:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733764861;
	bh=5QvFyS38VWK4QvWw0wNsjBO2y+9YwcgX7vY/cUlJRsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DnEgHlAOpfdh77Wr+bjSHD9+Q62t/2NrvFVnY3qpjQuVIxgwbswEhKVm1YvTcyJSN
	 UjmOaelWPApWmtimY0VqRYzr1xRvPKbf+ZPoAcaYuZA19zMLpfLNkRAz6WC35Qz3TU
	 6HG9d+mYtFBlaS/5oxn+ZNZhFHAU3cXzjP8Vn6t08MAsoulfS601F01IK09QczbT8k
	 tcUey9xkMYYCXgQvMGH/YMz2V5t0FG80XDhLRNlM1JtL6xRE7ljuXPG0Pjlb587dE2
	 +0IZUKPurEhYt+58Biq2NxySPbWbz3ZefIfp0hN7uIE6BJPSrIh6pSBZEsY3xmKFfH
	 Ca4GQusKT3zBQ==
Date: Mon, 9 Dec 2024 17:19:57 +0000
From: Simon Horman <horms@kernel.org>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew+netdev@lunn.ch, pabeni@redhat.com, bharat@chelsio.com
Subject: Re: [PATCH net v2] cxgb4: use port number to set mac addr
Message-ID: <20241209171957.GB2455@kernel.org>
References: <20241206062014.49414-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206062014.49414-1-anumula@chelsio.com>

On Fri, Dec 06, 2024 at 11:50:14AM +0530, Anumula Murali Mohan Reddy wrote:
> t4_set_vf_mac_acl() uses pf to set mac addr, but t4vf_get_vf_mac_acl()
> uses port number to get mac addr, this leads to error when an attempt
> to set MAC address on VF's of PF2 and PF3.
> This patch fixes the issue by using port number to set mac address.
> 
> Fixes: e0cdac65ba26 ("cxgb4vf: configure ports accessible by the VF")
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
> Changes since v1:
> Addressed previous review comments

Reviewed-by: Simon Horman <horms@kernel.org>



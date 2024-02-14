Return-Path: <netdev+bounces-71593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 533C085418B
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 03:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D182B247C6
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 02:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC574C79;
	Wed, 14 Feb 2024 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sadSjh10"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7D1118D
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707877420; cv=none; b=V89K5Hn4tdcfrUxXVwx7MnY8B1XoTCXftPvc6nfcyQPegJqq6nQ97kcxB4cFXSYvErT/yimzneHPG3KvdAFt/kDBRcVyWOvhpY1C0LB5ym4CZvsm5rhqS5Es+KJYFip7a31MTtV270GKo7Cyqeb9gJWErwywp9KEe6KhYkqHK7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707877420; c=relaxed/simple;
	bh=p0/LKn5ORerskP77DXnNvJbLsjhrc1oAzMJzgXAj7Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WS1q8PN5fjmEFXovikiABIkgirFCSZnay1EAlAsirBY2y+ebCvY1/VFgG6BwvIE885VlQVMYIBAOMTDbHayz3vPJmziUMLX64VTalxr0RetxWayjHjf664JOVXmfMhRH54XPRmcQ24BTdQ2ZJT33mM/XnXdGSo71EKWGnI/hvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sadSjh10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23470C433F1;
	Wed, 14 Feb 2024 02:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707877420;
	bh=p0/LKn5ORerskP77DXnNvJbLsjhrc1oAzMJzgXAj7Ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sadSjh10W8nAS/kLsUR0uyXdrXF2xLlTtilS+k8XkO/im9DYL6g4fvDuIAPnk+2bj
	 Kja0ceiC/xf6D1mVC7FD/RcPEt9/Dceb/utHo4A6v+jygoHO9QmKFy9cfeUplwz2h2
	 B3ql+imEnuG/68n3qol7909gh9w0uhQctGpv5Ke5j4gXkNVZMAY3qFC0uLqW5BVXOn
	 2C6ZPIPyWF+/Pb6qX8gP9kBAb1NTJcHT6gbtZqf0cSsXpvz2qu6AVy0gBRjJzeUT28
	 zvgiZNpAY2vF0db1gLZKXonTq5mM9xvIGA1Vu796KA/k1RuYLyr0WMJ8/wWIPhHEba
	 xA7+/X4sii4wA==
Date: Tue, 13 Feb 2024 18:23:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v4 0/6] introduce dropreasons in tcp receive
 path
Message-ID: <20240213182338.397f6d29@kernel.org>
In-Reply-To: <20240213140508.10878-1-kerneljasonxing@gmail.com>
References: <20240213140508.10878-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 22:05:02 +0800 Jason Xing wrote:
> As title said, we're going to refine the NOT_SPECIFIED reason in the
> tcp v4/6 receive fast path.
> 
> This serie is another one of the v2 patchset[1] which are here split
> into six patches. Besides, this patch is made on top of the previous
> serie[2] I submitted some time ago.

Please do not post two similar sets at the same time.


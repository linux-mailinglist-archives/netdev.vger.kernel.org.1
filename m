Return-Path: <netdev+bounces-106940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB86D918374
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFF3B245C2
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD81850A2;
	Wed, 26 Jun 2024 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKHt/1Ll"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C437185090
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410267; cv=none; b=aCyV0WWJ27ZHsKF0FuyqZ8/N+8ToywXmFicPX6xh3tgVAxSD0au6N9EiqpiShgKGXAqtj92Qpi7q71yQyMW9tsJDbxANfcAV64OXJJFl3W04beOShJSfWJ6RhWPxzSbE95sIW+3I4cyrkEbh5NsXN2qrGwZEj88kRhOuUDWjGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410267; c=relaxed/simple;
	bh=Fb9qnoPo3ZJGHdVTGQdBJ3r50yXEqchYRjz8cnEIP1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYB2jx5nx25BwnSi9TXQROHSXGvFjNz45+Nim0teiyZaofZHhWwiCnKSERgNMZxeqjjPwjQCwP09rhnQDAzBXTefGrqdDfQY96JKsA+8yL5S5bv6SHXSScwq52AEsodR8qVHzP9nIAnOuqwYWzScRAfau0xVbW22r7FYPX1jjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKHt/1Ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E955EC116B1;
	Wed, 26 Jun 2024 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719410267;
	bh=Fb9qnoPo3ZJGHdVTGQdBJ3r50yXEqchYRjz8cnEIP1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKHt/1Llcinr2JfjYRBiWtqjXu7Cqzwe6Cu+EnrfegNR3AZFBIQJwMULpAZyTcRH5
	 qX+1IqdOUbx4nHy3FzPKWZiO4WnmzbpUl3IiUB4On1dA0w56cEuQWRhnDGlBsHuSYg
	 l363KwiFQZmiRB2NdTxHRIu0rZO3L03hKkEqEUsiY/AlH7a8opOQcyldLsPkBsrBD7
	 Z+vgoDJNOR776PfZp3aqWL3aGHnKlqjjQsFQ5ZpHQFxnDHHLR9PQqQJOE7RhN3jEG5
	 iuIwdZYECu28/ZSdf2/zU7irm8sQlZeTWiQVUGwOKxnhgpDw92JB9bKIeKsGlbTXWe
	 WSSBFu4DNnadw==
Date: Wed, 26 Jun 2024 09:57:44 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
	borisp@nvidia.com, gal@nvidia.com, cratiu@nvidia.com,
	rrameshbabu@nvidia.com, steffen.klassert@secunet.com,
	tariqt@nvidia.com, mingtao@meta.com, knekritz@meta.com
Subject: Re: [RFC net-next 01/15] psp: add documentation
Message-ID: <ZnweWKSNWu8On2xi@sashalap>
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-2-kuba@kernel.org>
 <Zj6da1nANulG5cb5@x130.lan>
 <20240510171132.557ba47e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240510171132.557ba47e@kernel.org>

On Fri, May 10, 2024 at 05:11:32PM -0700, Jakub Kicinski wrote:
>Yes, I should have CCed Meta's folks who work on TLS [1]. Adding them
>now. More than happy to facilitate the discussion, maybe Willem can
>CC the right Google folks, IDK who else...
>
>We should start moving with the kernel support, IMO, until we do
>the user space implementation is stalled. I don't expect that the
>way we install keys in the kernel would be impacted by the handshake.
>
>[1] https://github.com/facebookincubator/fizz

Having worked on this in the past, I was curious about looking at the
kernel/userspace implementation, and was surprised there's nothing at
all on the userspace side of things.

What's the rush in merging this in prior to having a usable, open
userspace? Can't they be developed side by side and merged in together?

-- 
Thanks,
Sasha


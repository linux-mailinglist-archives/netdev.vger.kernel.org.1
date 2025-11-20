Return-Path: <netdev+bounces-240226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B00C71BC9
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 02:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBF314E0112
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1B8266B6F;
	Thu, 20 Nov 2025 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiBKmjoj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E396266576
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763603790; cv=none; b=a8EcvXQZBrC3/l2k4lJJK6wwtbXpDB9I1W9Z0RDgAQJ4KErOdTvZSd93eYRt42ZtFZ6/3uKoom5kJF4i37EHpRkzTmhoXvVdfBC/wThvqMlOhPjpQ/i2xzliZwaQnXNGRUN6UaPLrmvBQdXh8n2RhNdaecisI565lCy9PWt+vaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763603790; c=relaxed/simple;
	bh=qO7RzxuZs8o1E81bTkJNGnkVdxs0rlzUyVyc4M9w9Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BazKsjGoqOtOjjjNJfrxVILywJmdY/Ii+f7Cg9Bh+V8z/aB8sAcT+mLZHwir+bbgYvH4FSoaYgHAlEQpynxZox34QwycDFRcN4AW3/nL+Cu2CirmuI0APmzxXBe0kVzT3zdMH5FjkMMpDxwqqynBkMFcVjD0+M0AOquLZlseLeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiBKmjoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4626BC4CEF5;
	Thu, 20 Nov 2025 01:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763603789;
	bh=qO7RzxuZs8o1E81bTkJNGnkVdxs0rlzUyVyc4M9w9Hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jiBKmjojqtJ6Cl7CTlCP0GddAsQkQlPggcQd8vJs6qUCJcyATSMIPw6yQRwDxCNh1
	 E43va0AGkQJPDDFrvqba86VIq4AtPEhsdEVBGcLQ99Ricet3xDcfkzFfTw+x9FvyND
	 lNSm+k+Ay1Kh27fL/UHLhPm2sdjCFEpZV+8oB0fyGFjWXEu4btaOwlklOKgSpAkTcF
	 W5fWwYHn7XPddlMvOHRZhvWxCARfEx1LpEmKts/E4k05ubMhn5jWgSPRMUlSAeYKp2
	 82lQB5yF0ooHVXtuv8w8Hmzl7o3ZF+BVOUZiCx8urvm9Oh/Y8Pm/6kS3qIYfR/1TN9
	 Q7Z7cfQjj44bQ==
Date: Wed, 19 Nov 2025 17:56:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>
Subject: Re: [PATCH net-next v1] devlink: Notify eswitch mode changes to
 devlink monitor
Message-ID: <20251119175628.4fe6cd4d@kernel.org>
In-Reply-To: <20251119165936.9061-1-parav@nvidia.com>
References: <20251119165936.9061-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 18:59:36 +0200 Parav Pandit wrote:
> When eswitch mode changes, notify such change to the
> devlink monitoring process.
> 
> After this notification, a devlink monitoring process
> can see following output:
> 
> $ devlink mon
> [eswitch,get] pci/0000:06:00.0: mode switchdev inline-mode none encap-mode basic
> [eswitch,get] pci/0000:06:00.0: mode legacy inline-mode none encap-mode basic
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Jiri, did you have a chance to re-review this or the tag is stale?
I have a slight preference for a new command ID here but if you
think GET is fine then so be it.

Is it possible to add this to the Netlink YAML spec? off the top of 
my head I think it's a "notification":

    -
      name: $name
      doc: $doc
      notify: eswitch-get


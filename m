Return-Path: <netdev+bounces-78223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60402874616
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 03:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441161C21462
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 02:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1051FBB;
	Thu,  7 Mar 2024 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+n6kyrL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6978B1C2D
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709778381; cv=none; b=G9BwhGnJ68V5orPUP3vBPuDBFUE6R+0u8GMVF/jyaoNad4gv6aNWI7UIeoiKW8qCeHHjvfaxR5OinIS5UTVlihG4u+TS7sXNEfu+ObBrssK5sFFdenO3ASIqMwLDrjkve9RcBG68r5IJI8fyZtzOj++QNzYfj88mBPIiK1UUZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709778381; c=relaxed/simple;
	bh=liBnoDdr/ufHPtAp499JfDlHm7qj9Q34SpdqUE9U53U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tj/9CQwOqwXpUpUa6tj+x9cItsVhqj+GcF7VbMQljPZLe4Ag9nE1DZZX4X155pe2PSkpseCfPr0K8BbGP0Pg5lf/80ATk77uGAJL9k6bbNZ45gtHsl9Vt5B12kaG78ysSmv7wBRUA6/A8q4mUr5u9AjAlUOQlwDty2VNP8whAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+n6kyrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00633C433C7;
	Thu,  7 Mar 2024 02:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709778381;
	bh=liBnoDdr/ufHPtAp499JfDlHm7qj9Q34SpdqUE9U53U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y+n6kyrL1D+RfUKZIJPePSL/SiEU4qcCWohnPHNfu35E73OJ6G6ygGzyUdXc1ol57
	 z4D++BoHi4nVnjLVZO1ib7JzKO8rlYBxrgG6EwjTvE7cQYrtXqqbszICyyf3oFipfX
	 pyhTspvuXZ+2esGWydJRMEt69g5KWdJnHJPhezR/a+p/VJs7bP+wFnAvk//prefhci
	 BPU+03ntYOrMIzHU9xwo1rPNTHIaPrhlFtvLQdgPmYATBqydm4xINr3Id+5ERoMvok
	 oW4b8QixUM0ZROzwFubxv9xsrFIDJ0k7pdfeG8IGoeq8tsuYvhT8AQqO5hv7OjjHjE
	 j5zKF5f/sTkuA==
Date: Wed, 6 Mar 2024 18:26:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 5/6] doc/netlink: Allow empty enum-name in
 ynl specs
Message-ID: <20240306182620.5bc5ecc2@kernel.org>
In-Reply-To: <20240306231046.97158-6-donald.hunter@gmail.com>
References: <20240306231046.97158-1-donald.hunter@gmail.com>
	<20240306231046.97158-6-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 23:10:45 +0000 Donald Hunter wrote:
> Update the ynl schemas to allow the specification of empty enum names
> for all enum code generation.

Does ethtool.yaml work for you without this change? 
It has an empty enum.

IDK how the check the exact schema version, I have:

$ rpm -qa | grep jsonschema
python3-jsonschema-specifications-2023.7.1-1.fc39.noarch
python3-jsonschema-4.19.1-1.fc39.noarch

The patch seems legit, but would be good to note for posterity 
what made this fail out of the sudden.


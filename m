Return-Path: <netdev+bounces-83144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 084F089107D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 02:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D5128A775
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 01:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538C91755C;
	Fri, 29 Mar 2024 01:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHHlmWWC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA3514A8F
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711676518; cv=none; b=eFzD/b8CyTlp7Vs0rk4cZZ/N5JO6gjmp41jJCdJd0u9u4hz5xIgZNL1O1GXzII5TPw4AOvmjBNGs9o9mk1nYaJTBBGGi82la0NlI78U7Y4WfEZhbeo43k3pZmM4EA1+HQ4UxroZ/sQrqPbi40cDzXFHDU0CpmIoNY6ecBXuMxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711676518; c=relaxed/simple;
	bh=dRjNlE4tEw254+ZeLmyF4WE39UMYzrATQTHhsJbhNGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNzDx4AmoBXa7QnYpf5RJIuol23iSWwLTSCvljPjyz5a3+uQWRPlbzgAVNQ5m9fBZG8iUdno5Btsq5TUl0Ky7OCxVHMqnljUwP+pELeiEzRP+WiCFnsucc6O2yt2rFXNekhgF/ND5CUH5f6dkgRQvPjnDYnL/l4IYzYkuHMnza4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHHlmWWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD75C43390;
	Fri, 29 Mar 2024 01:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711676517;
	bh=dRjNlE4tEw254+ZeLmyF4WE39UMYzrATQTHhsJbhNGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nHHlmWWCoZXsb3mDhYXbGrxOAZaTUqCDSCKsCzHk9N3WE1SIrIqZGhd1k7nh7Balw
	 gPvoNf5NKvlttCiQCq5zACgOkCVF0Kj+aMNFoRhnxgYCCa7zoYMzM0UYXrWvUkGAH9
	 QDYF9AHpPZ/Qen8Fe24FP8CjODQTj2sIBUfzOKayru6n3wWmEGBodHWktgCBuN7p2D
	 dcRe75s6jwdqdSffweo1DtZRdEp4cNFjX6GjmUSW0aUBKQyFL8jRoKCjzVB/ueHiTZ
	 PIgzeXebJmIiyobjdAgoNIaLDbTbclaXIDXEhmIfFIErUSFDTOyUdYRBeiuTBDDnbK
	 DnF9ENLD1mOJQ==
Date: Thu, 28 Mar 2024 18:41:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv2 net-next 1/4] Documentation: netlink: add a YAML spec
 for team
Message-ID: <20240328184156.02628830@kernel.org>
In-Reply-To: <20240327100318.1085067-2-liuhangbin@gmail.com>
References: <20240327100318.1085067-1-liuhangbin@gmail.com>
	<20240327100318.1085067-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 18:03:15 +0800 Hangbin Liu wrote:
> +        request: &option_attrs
> +          attributes:
> +            - team-ifindex
> +            - list-option
> +            - item-option

item-option is a name of a space, not of an attribute

please test with:

	make -C tools/net/ynl

> +            - attr-option
-- 
pw-bot: cr


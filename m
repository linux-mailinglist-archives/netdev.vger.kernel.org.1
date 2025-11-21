Return-Path: <netdev+bounces-240639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB9C77270
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 04:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB5A1360171
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536002ECE86;
	Fri, 21 Nov 2025 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFc/+bu0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C3278E63
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763695246; cv=none; b=XTFnI5oLCRRtE4d6NsYeNfg1CBu40xQ+CBm5bji48w7+6S+X2C8B4Qy0W7tAAmFyXyf0ylI5OGs6NMIVG+oM03Q5FQt5he2BOYJ6yYER5xjITSqh9o763oFZXizP2+AcV36HHhK6uJjbL4I4XvNv8OlSK0UGBIeUPLAPXTHmUKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763695246; c=relaxed/simple;
	bh=+rG+L5j5N3GDoeJVFgrC8wy8B1Rq26PuY9fRDwwPTB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAK3QUlJDsONM71YjFY9VHSxepe3E16q3JO11K4FointqsH0n2NohC/1w8qfHYQWXpoFaAe8VRRoSiXhqcLi2m9zI2oWjIseMF2ndQH8iEwvsDyx7/DDnyKoJmhLswPn66a9yW0i4PcJqoTdZgRCYXzZQrQYel4niAl9YvLFOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFc/+bu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0979EC4CEF1;
	Fri, 21 Nov 2025 03:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763695246;
	bh=+rG+L5j5N3GDoeJVFgrC8wy8B1Rq26PuY9fRDwwPTB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SFc/+bu0reyisEeSaZOBigbmkwpE1hWD7s3EZaDtXieuM10h36qd37RRIKYYOZsJZ
	 yKmBDFS0zephWApVUx9184tuDx3rIEjSE4xwPvdVa086L4b+/E1YwBY6BQ4zaiH2K9
	 KV6HWvGG+s8VpNdnq349vukhRfB3cfnKHo7o1pYNc6GcmMm/iH08sJqilt2ETSzI02
	 EiD5gNKAb3RLC3keesSTS1sJkE5lMA3VRmfvdfLf2DeTSXQ6hxD+jFPny9JvAeevzq
	 eKPmV6M/sZJ08UddO9BA8YAldunaF3ipH2z1TXxx1axn8JQL/ObERmB2qOBMI2Urz4
	 thPsEFHJslo7w==
Date: Thu, 20 Nov 2025 19:20:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v1 5/7] selftests/net: add bpf skb forwarding
 program
Message-ID: <20251120192045.1eb4a9b0@kernel.org>
In-Reply-To: <20251120033016.3809474-6-dw@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
	<20251120033016.3809474-6-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 19:30:14 -0800 David Wei wrote:
> This is needed for netkit container datapath selftests. Add two things:
> 
>   1. nk_forward.bpf.c, a bpf program that forwards skbs matching some
>      IPv6 prefix received on eth0 ifindex to a specified netkit ifindex.
>   2. nk_forward.c, a C loader program that accepts eth0/netkit ifindex
>      and IPv6 prefix.
> 
> Selftests will load and unload this bpf program via the loader.

Is the skel stuff necessary? For XDP we populate the map with bpftool.


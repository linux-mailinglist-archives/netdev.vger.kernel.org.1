Return-Path: <netdev+bounces-231333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D29D9BF7898
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FDE14EF663
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BF83431ED;
	Tue, 21 Oct 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4+tjBne"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C16253F03;
	Tue, 21 Oct 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062317; cv=none; b=dm9o3OTbcSBwVGwc5KZjnuySirs7KpOCJREwXRBY9uQ+Ft9i7cDnK7T+yFzV92JRFxhv0tw+pa0E0pDD0pj/evVZFB4d59ML9+RJ/GSKpa85MyJlqxjRE3xKJmxgho02lpoEijKVZoawXO6zwIeufVH7qaclEybTkh/0V+kD9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062317; c=relaxed/simple;
	bh=lmlU8LVO19iorKme+ujhGG8hGsfryv4XZ5NuBOKLHIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2NcHIKD17Nw8koQjl6tfFwZUQqTo8YQFNblyYUPMXs42tjvY2XX88RiMMBQjTFywSoURDk/a2fHJQ34qlb4aaY1BYYb62eI0/gVdnaNon+WHZJKhFFlVpeuhbzPZKTk8dpr49U5EOU4xfND1UXtSj0P5QPd+/Z4LH7GMIRNAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4+tjBne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B06C4CEF1;
	Tue, 21 Oct 2025 15:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761062316;
	bh=lmlU8LVO19iorKme+ujhGG8hGsfryv4XZ5NuBOKLHIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4+tjBne/YXL9k7i5Vg7yL3sKDC/Ygdm3z7vnTqeGzI5Ju8qXh/BGFgOtrpp3V/oc
	 kc0qRWFM/AQ8QNgzX2IgrTPyz/StkMxpESL1G753Zv9nwcEIe36J0I8KuXbyNK+Al9
	 /4ok7Ll5QDEqPYZwQKYvjmbn1Lo29AceUWOiv7S0IZTVqG7dH32O45F2IyOajLZCSU
	 9TlwYnVa5dngQ30p7mNwJ8Kun8tbm9cQwlg+ucTTYM+/mBHiu9ndalyj0ZqVev4hHJ
	 gZzjL/e3YAprAIOei/tmpo/Uz2Oa0LHOvHzLfr5G2uvEy5cwjC6livW25ihtGdpFYd
	 62HWrcui3wmng==
Date: Tue, 21 Oct 2025 16:58:32 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: inet_sock.h: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <aPetqHmBYf63AL3p@horms.kernel.org>
References: <aPdx4iPK4-KIhjFq@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPdx4iPK4-KIhjFq@kspp>

On Tue, Oct 21, 2025 at 12:43:30PM +0100, Gustavo A. R. Silva wrote:
> Use the new TRAILING_OVERLAP() helper to fix 2600 of the following
> warnings:
> 
> 2600 ./include/net/inet_sock.h:65:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it (in this case
> `char data[40];) This overlays the trailing members (data) onto the FAM
> (__data) while keeping the FAM and the start of MEMBERS aligned.
> 
> The static_assert() ensures this alignment remains, and it's
> intentionally placed inmediately after `struct ip_options_data`
> (no blank line in between).
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> 
> I think it's worth mentioning that the introduction of the new
> TRAILING_OVERLAP() helper saves us from making changes like the
> following, for this particular case:
> 
> 	https://lore.kernel.org/linux-hardening/ZzK-n_C2yl8mW2Tz@kspp/

Thanks,

I was able to reproduce a (small) subset of those warnings
and agree that this is a very nice way to address them.

Reviewed-by: Simon Horman <horms@kernel.org>

...


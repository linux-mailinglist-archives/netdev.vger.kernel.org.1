Return-Path: <netdev+bounces-217570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92D0B3914A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7905A981ECE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ADC23C4FA;
	Thu, 28 Aug 2025 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn/3VS60"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12AE23B615
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346057; cv=none; b=Ck7OnI1aB1oXheO1UCsniz260Y+h7K4FpK9xTIu8KvpxVW6EGfqFlv/6CTkn5zDlwJwDYB85Tv9WjPIa4oti/7zlAQCi5H1v8JpuKHc0FuzS9/SIPNHTofhtZVl/JVfdml7YRqtL4fUhFw8hQcFuBFVrywC9a8vnSdQE2tcv1PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346057; c=relaxed/simple;
	bh=eR54EGPOJ8krTnKgq2CA2H8cmuhudnaoPcFmzrhjEi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIRODkSg6wwH/OjWuepcquQzgpZxSJPMZQcz0O6aX9ZbOZGC6VoDpXvMXnyxZKghpmLHNcccKMgOw5Zmo2WIDQKMU2GaL5kdR1EAKHaBDS/7gtSLbLwLkkxZB8ZuDrLKmYhDDr8+phKjC/masjo/mBjMAbDmzbSbR/zNI8l29Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn/3VS60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AEBC4CEEB;
	Thu, 28 Aug 2025 01:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756346056;
	bh=eR54EGPOJ8krTnKgq2CA2H8cmuhudnaoPcFmzrhjEi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kn/3VS60svqGn/KHAJ5icASFUVKp3stVsXmYE5lIuS+nHogKqHcQFqy06BmUevld1
	 boXGm1A0IPm0y9UIAaCxLK0YtWwHFMUihJu4JG0A4R9tlFADXMgWutr3HW7u6RTeut
	 QOZK4KUiFZo3WW5MxXRSRzqbkgaKLo+AoSGXIba0o15fcwoCHn1LPqGNU1Ai4AqynP
	 jmEwnLgmmUNU9PKQ8sixBzKwWGzYePSOs7v8AXOMohEuseUgUikveaROrhwXPJqIUU
	 o4p49WdEJIG4oVMjLnIagOtepxI8NbVrv5lgpbLmFNJI1SlYWV2lCajraOIlvyeKJP
	 qZSS1TkjWabZw==
Date: Wed, 27 Aug 2025 18:54:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/13] macsec: use NLA_UINT for
 MACSEC_SA_ATTR_PN
Message-ID: <20250827185415.68d178c3@kernel.org>
In-Reply-To: <c9d32bd479cd4464e09010fbce1becc75377c8a0.1756202772.git.sd@queasysnail.net>
References: <cover.1756202772.git.sd@queasysnail.net>
	<c9d32bd479cd4464e09010fbce1becc75377c8a0.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 15:16:24 +0200 Sabrina Dubroca wrote:
> MACSEC_SA_ATTR_PN is either a u32 or a u64, we can now use NLA_UINT
> for this instead of a custom binary type. We can then use a min check
> within the policy.
> 
> We need to keep the length checks done in macsec_{add,upd}_{rx,tx}sa
> based on whether the device is set up for XPN (with 64b PNs instead of
> 32b).
> 
> On the dump side, keep the existing custom code as userspace may
> expect a u64 when using XPN, and nla_put_uint may only output a u32
> attribute if the value fits.

I think this is a slight functional change on big endian.
I suppose we don't care..


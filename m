Return-Path: <netdev+bounces-218765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AADB3E5AA
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5288443057
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE353375D5;
	Mon,  1 Sep 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3tczblB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4F4335BCD
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734022; cv=none; b=j7o2YjC202VtTMjccrqG1pgQ46k0gIT23AVrleIPRvLWyWfPDHDcJFRki/qGDBwpvL3ahvvGLGzpZAafE1SqfzfasZHyN4DSz61Sn5VmMQlBivR0328RhQfJRWKwNW8pMXjNg27zaZBo271aOktGfDKfbOKA819aSl77WDK8cgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734022; c=relaxed/simple;
	bh=utHg8XqwVAu+eNuse8FzluWq1XCFLYgBd0AV+VD2LDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+WxwEUdqvZWxdmZLcNTE1uDOElhRjbmggIgH7LSzdDhBXzH2s6tzJQXwalzfVBDHZwfdcdVangzV4bSlkvS5UvnUy3jAgYRoBl8in9l+86vfUaeowYoLIrD2tNU5XjK77CKE93TQ7TPmKjBeZqfANTE+5cNvPJM4c9kZYqGaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3tczblB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71603C4CEF0;
	Mon,  1 Sep 2025 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756734022;
	bh=utHg8XqwVAu+eNuse8FzluWq1XCFLYgBd0AV+VD2LDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3tczblByHieUbSKOMSwZPbaqXanyKT3RZuvrmZ7xiWdv5W3NuN9hzrXIZYQ9PB4O
	 9mIhl7TrPq+c0ssUcNZtQHS5nbLY0Tpt3o3kyFXEnLj4csZabUpWWe1xYR79Y9WC09
	 Ir0wGlzI8Vub5HnD2YVLPKBgN+QDM1L72iqTyv1u/pj4DGVJqsoOG4/MSFgDFMI7oN
	 JYUzZIfYEhri0j45IJBIKRZ4XBmLnLVMKI1s2gKHDLXyy5H8dm/4F/VeZNaOCTEyW6
	 Jinq22CQNYaz6jtNDiTnxj6QwcE8XtwwjYrbQBV/1Ip+abxX2NoDz0ev+GuQB7yyHD
	 eKE0tDabxk7qA==
Date: Mon, 1 Sep 2025 14:40:19 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Era Mayflower <mayflowerera@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] macsec: read MACSEC_SA_ATTR_PN with nla_get_uint
Message-ID: <20250901134019.GB15473@horms.kernel.org>
References: <1c1df1661b89238caf5beefb84a10ebfd56c66ea.1756459839.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1df1661b89238caf5beefb84a10ebfd56c66ea.1756459839.git.sd@queasysnail.net>

On Fri, Aug 29, 2025 at 08:55:40PM +0200, Sabrina Dubroca wrote:
> The code currently reads both U32 attributes and U64 attributes as
> U64, so when a U32 attribute is provided by userspace (ie, when not
> using XPN), on big endian systems, we'll load that value into the
> upper 32bits of the next_pn field instead of the lower 32bits. This
> means that the value that userspace provided is ignored (we only care
> about the lower 32bits for non-XPN), and we'll start using PNs from 0.
> 
> Switch to nla_get_uint, which will read the value correctly on all
> arches, whether it's 32b or 64b.
> 
> Fixes: 48ef50fa866a ("macsec: Netlink support of XPN cipher suites (IEEE 802.1AEbw)")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
> I'm submitting it for net since it fixes the behavior on BE, but I'm
> ok if this goes to net-next instead. The patch doesn't conflict with
> my policy rework.

FWIIW, I lean towards net. This is because If I understand things
correctly, it does seem to fix a bug in some scenarios.

Reviewed-by: Simon Horman <horms@kernel.org>


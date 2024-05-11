Return-Path: <netdev+bounces-95624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977D18C2DCA
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054CCB21259
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F64A366;
	Sat, 11 May 2024 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzLAOiTc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A262184
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386294; cv=none; b=kjw4oIrStaml+EKD9C6dQUJc4IA73yHFdAejGKRPeyqrrvpVawqqmkUw5u3/Mf/ZBvIie4JkTLp0scSfUE8jVA9ROXCYq0J2UMQmIVc69dPjYWFsoUrBBXBJOl8xIA+oQTR644ikOBRgyZ4vW9MxNR5XfmDOgrcQgUnRvB1QRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386294; c=relaxed/simple;
	bh=AEJE5DFph4XdpCYcHnz4WVIYoBSEYvmZYkquLTJ/wmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8BT7HtnDGE+0Hl2LJGBClBr4BP7JaLIOMHK3NCTSMrWjmQ9dyBr47WLAJVmbxp4nDBaWj2BNYVPhErrbeBdqn48/ec/S1onr5XrTRtemr4Ckd6qz03Un13fLUVLqjQJbZDIXkp69ReK3cetFrL7Aj3ulblsKbPAix81kAjC8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzLAOiTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D7CC113CC;
	Sat, 11 May 2024 00:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715386293;
	bh=AEJE5DFph4XdpCYcHnz4WVIYoBSEYvmZYkquLTJ/wmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzLAOiTcxLp1nPWBm1P8kr/W7HxNWmCnlQY8YEQgtyQT4aFdrS+rOXA6y9suhjmYk
	 +ra1KxYHTZTkJULimhBBSbqJk1LahKJwkEdhAYYMBlfzIgq5LvNPnZ9KuZKzRVcU6f
	 K7fiAF98pwW9q0PMHdMMR5NP8+9Rse4KhJlR2w2BnHThyVvC0Vv0QnfVwYAIYUFIgx
	 7y7or0g/VNm+0ShW3sLkj6VV213ypAvzC7q1yN9my231DDAsZ3qQzi8LiG5yytPz7U
	 Dg83ZxUHwYES/cglFKzJdtONjwvA1OM0mT6lwPDjVMfsq8hZ/7Pe0IHQlhLLtngMVy
	 c0ZMo2p+647nQ==
Date: Fri, 10 May 2024 17:11:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, borisp@nvidia.com, gal@nvidia.com,
 cratiu@nvidia.com, rrameshbabu@nvidia.com, steffen.klassert@secunet.com,
 tariqt@nvidia.com, mingtao@meta.com, knekritz@meta.com
Subject: Re: [RFC net-next 01/15] psp: add documentation
Message-ID: <20240510171132.557ba47e@kernel.org>
In-Reply-To: <Zj6da1nANulG5cb5@x130.lan>
References: <20240510030435.120935-1-kuba@kernel.org>
	<20240510030435.120935-2-kuba@kernel.org>
	<Zj6da1nANulG5cb5@x130.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 15:19:23 -0700 Saeed Mahameed wrote:
> >+PSP is designed primarily for hardware offloads. There is currently
> >+no software fallback for systems which do not have PSP capable NICs.
> >+There is also no standard (or otherwise defined) way of establishing
> >+a PSP-secured connection or exchanging the symmetric keys.
> >+
> >+The expectation is that higher layer protocols will take care of
> >+protocol and key negotiation. For example one may use TLS key exchange,
> >+announce the PSP capability, and switch to PSP if both endpoints
> >+are PSP-capable.
> 
> The documentation doesn't include anything about userspace, other than
> highlevel remarks on how this is expected to work.

The cover letter does.

> What are we planning for userspace? I know we have kperf basic support and
> some experimental python library, but nothing official or psp centric. 

Remind me, how long did it take for kernel TLS support to be merged
into OpenSSL? ;)

> I propose to start community driven project with a well established
> library, with some concrete sample implementation for key negotiation,
> as a plugin maybe, so anyone can implement their own key-exchange
> mechanisms on top of the official psp library.

Yes, I should have CCed Meta's folks who work on TLS [1]. Adding them
now. More than happy to facilitate the discussion, maybe Willem can
CC the right Google folks, IDK who else...

We should start moving with the kernel support, IMO, until we do 
the user space implementation is stalled. I don't expect that the
way we install keys in the kernel would be impacted by the handshake.

[1] https://github.com/facebookincubator/fizz


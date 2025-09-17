Return-Path: <netdev+bounces-224115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486EDB80EF1
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4004B1C8175E
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D72FC877;
	Wed, 17 Sep 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBFN4zKv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4ED2F8BC0
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125353; cv=none; b=VK3TcJiOeJptSv3GwABM/d/W8CEn03YJNM01z3BYwjn04QlExYRdzizqMqrgEhMrUbl8VFcsYWb+mZ5nZUezZVdt2VARuJbjav44mQaXhYoz29hy2dasHXTFYTOU+e2TjC2KdVR8p/Ia76HTH0aOBBeDD2EEdi7OBblFaSAUe3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125353; c=relaxed/simple;
	bh=zfn3j23EMhHL2IAaa8Euu7RjPxfpSPh8mRxim9rJw9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQiUOMwFTxEtv9ylK6mGbFDUc0HsXwoHq93loCgIWH+ELJtrMkoh2zJeG7zjH8cFvEk9PQYaKwm3P/mfOrOE0s+MDJDJoSB5Whe+X3OiPdfkKUtgZCgWu+1Bpvf1cqucN8xNOLRJr3tMW9drkMa3zQmgiwnTmO6Yd5mUSj+CXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBFN4zKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBA7C4CEE7;
	Wed, 17 Sep 2025 16:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758125353;
	bh=zfn3j23EMhHL2IAaa8Euu7RjPxfpSPh8mRxim9rJw9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBFN4zKv/qvSJN4u9Pm9wX8aZj5FXg149vYbWUJkoeSEsDUBzhXQn6H08IgMG+Omw
	 oKyf0WQX6TTnKYpDI0igRKarodA4MgLkrDwwl+jRZuL3g5LfO7yUXQwNYq6LYq+r5U
	 QwCI3p1DJ4R9OlwAjTZuP6h/YoKQqxdDa4UcuhN/txnCXzVBZxw4wJWow0jWuaJ72b
	 pEk8otiZeY8Nm2QJI8opY5TAYxFYJvBq3NP0GxElDF2pT86wFA0Ya6Up42epWjtdIs
	 m4nIgedP8aBYTlADVJ54fTV3YIYg0rn6yiF53Nd3twzyrdtcNS+MEDHbN/VKtoIKEe
	 3w/hFogq4t+dA==
Date: Wed, 17 Sep 2025 17:09:09 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	lee@trager.us
Subject: Re: [PATCH net-next v3 9/9] eth: fbnic: add OTP health reporter
Message-ID: <20250917160909.GQ394836@horms.kernel.org>
References: <20250916231420.1693955-1-kuba@kernel.org>
 <20250916231420.1693955-10-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916231420.1693955-10-kuba@kernel.org>

On Tue, Sep 16, 2025 at 04:14:20PM -0700, Jakub Kicinski wrote:
> OTP memory ("fuses") are used for secure boot and anti-rollback
> protection. The OTP memory is ECC protected. Check for its health
> periodically to notice when the chip is starting to go bad.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



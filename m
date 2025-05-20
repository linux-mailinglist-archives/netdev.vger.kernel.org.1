Return-Path: <netdev+bounces-192054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14713ABE643
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 23:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA494A7B49
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2A7258CFF;
	Tue, 20 May 2025 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="d25nc40J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB7136351
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777682; cv=none; b=n0gLslSZPiPvmoEziZIe5ChXgiUnpcLssa2uFx1HxjbMn+1Wt+cRTQ71TZniPNEn1lYTw7eHOWo+3BhOuypfDhhVXCPO96J5H1kJGmk1Rt3+7fqei3ILaEN+O+VWBUkdcl1LExqRnkvEunhgHd/vafB2dN65eaRGVPJKqs72BEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777682; c=relaxed/simple;
	bh=1YjcT7c2fuopPJewmDumX0V7dG1E0jv5oVSLWU0Fggo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpaQZvrRl8reoRIqDoT08+tf/8iwyfq3vhUEO+ooLSBlJPkrsh5EZN+0v313rJxJyuM+5CyfMTF9iimWJPQX0faRM/v0GphcAG+TdHH1JiMTfwYy3jinDA1GASZaJVy+j/Na7U4rBXc/kNxjDXWLFze1JQ67VnFI0IlVLmzEfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=d25nc40J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE0BC4CEE9;
	Tue, 20 May 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="d25nc40J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747777679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rCEUlX1/QPV1B7qcEKZTV8HI+MgfKkGTHei7tbjvtws=;
	b=d25nc40JGrnHTRX+30jTPpkkxps69P1wwmlfxiQLZFSBFJAO72QRCB/EJfNlpAl0LWDuOj
	KncLe0vk6xPZHEyJY/oUZ676QPpkci5MaBhI2lB8gbgsSj7xeMev8IezuHSBxmBEcInsLx
	8oKJLk32ChZKTDmXkISR9Vsabu1whnc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 731ccbf0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 May 2025 21:47:58 +0000 (UTC)
Date: Tue, 20 May 2025 23:47:56 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jordan Rife <jordan@jrife.io>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RESEND PATCH v3 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
Message-ID: <aCz4jK9i-N6e5xk-@zx2c4.com>
References: <20250517192955.594735-1-jordan@jrife.io>
 <20250517192955.594735-2-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517192955.594735-2-jordan@jrife.io>

Hi Jakub, Jordan,

On Sat, May 17, 2025 at 12:29:52PM -0700, Jordan Rife wrote:
> * Use NLA_POLICY_MASK for WGALLOWEDIP_A_FLAGS validation (Jakub).
[...]
> +	[WGALLOWEDIP_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, __WGALLOWEDIP_F_ALL),

I wonder... Can we update, in a separate patch, these to also use
NLA_POLICY_MASK?

   ...
        [WGDEVICE_A_FLAGS]              = { .type = NLA_U32 },
   ...
        [WGPEER_A_FLAGS]                = { .type = NLA_U32 },
   ...

Some consistency would be nice.

Regards,
Jason


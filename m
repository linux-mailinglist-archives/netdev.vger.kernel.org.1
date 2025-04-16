Return-Path: <netdev+bounces-183475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73D6A90C80
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3254413C1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098A18DB2F;
	Wed, 16 Apr 2025 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX17vHYJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB651547C0
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832767; cv=none; b=Hc+wfyEfeSBEJguhtrZTTLtbHgakYAK/UqPU1eJDvb0tOpA5ut9vKSpZQ5hExQTrhTPMXZcmfrhpmk4cMkh6wK/16HiVFBJ6dxAPd+ODFdMXSSrA7GWFGiiSVykcYv+UESVkhXnE14/6ZBFNtxB53jr6+AeW3Kxg8CuxQeuvER0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832767; c=relaxed/simple;
	bh=cD77xVMurW1OvqBwLIvz10mk9yd3JdLXmd16f/lxJk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCfnbqZ3cRo34sfCS9WeYD4E/w9PUPahMUr7EhiOT1fCX8uCF1hJfwQhEkjKG5JYCRI+bhHo81A0E54BAuYkuteSlGXIk5TSFpiHSj/20V33Q8AYiI2L5sFzgFI8CjdwzdGsatYiLq9xSUP3VdG05/vYNcuN2wBk2exUNjaHZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sX17vHYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B537EC4CEE2;
	Wed, 16 Apr 2025 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744832766;
	bh=cD77xVMurW1OvqBwLIvz10mk9yd3JdLXmd16f/lxJk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sX17vHYJJ5KNxkAjPHqZ17fqCMK10B4LN8urYpfYk22dCJg0TSlc7LjECM6ta9AbZ
	 B0xhfxvEBPsxAMzalFLdett7j/tvWemUs/7RVmFUN1jVdUw8Q5661NTcgK8xB30jWn
	 eUE93bHwVuPEN72HVqFUdsvKKKoCUlo8/zIXcpC81vskxGZYBxvifvpQxPO0TMIOyt
	 oAIyOKbo3zFAlunlIxSMS66tNEmGpu/1Bfb9t2Rkt9HrnTYHtAVsnHgA9LQs2T6uPY
	 6cwPWyb2jGni/1OrKzdimX1x7XVx2w6F8wY01Z+VCvqoJW/B/SBJIkf482T1b6eL9R
	 MTewImzrmdd9w==
Date: Wed, 16 Apr 2025 20:46:02 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: add RTL_GIGA_MAC_VER_LAST to facilitate
 adding support for new chip versions
Message-ID: <20250416194602.GZ395307@horms.kernel.org>
References: <06991f47-2aec-4aa2-8918-2c6e79332303@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06991f47-2aec-4aa2-8918-2c6e79332303@gmail.com>

On Tue, Apr 15, 2025 at 09:39:23PM +0200, Heiner Kallweit wrote:
> Add a new mac_version enum value RTL_GIGA_MAC_VER_LAST. Benefit is that
> when adding support for a new chip version we have to touch less code,
> except something changes fundamentally.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>



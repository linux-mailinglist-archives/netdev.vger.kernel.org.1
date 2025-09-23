Return-Path: <netdev+bounces-225555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE53B9562F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66E53ADE6F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C764F3112C1;
	Tue, 23 Sep 2025 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP7dVA7f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D5E30F52C;
	Tue, 23 Sep 2025 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622064; cv=none; b=W2L0STcTbRANV9z8g0Wz3Vny1ZSTctV2fKoJtwLiearCrIQ2eKV9A1QdO7AO1Lom9xQFoDiiXsUZn9MhGO4FpWYXhYs11IUE3ldykWRUkRw+xGYcbcEsxWa1eqKj1oXt2uM3CcmZ/WcCeaoLIoz3FTh/kw2ep8v4S5MS8jpKthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622064; c=relaxed/simple;
	bh=JQPAqskccYl3Rxza7uY7Mw27b9b3oqnTfLM5B4pIVVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOLCF068NZTJd3UaXSZdm0SDDkfuAT0BevnJe9DMJKTC0uAVKyXwRfJitWdGmpVPrl96CRb9cUIajORU19LTr3c+qQNEJuozogESrNjQ9+MRpJg+QbSOoDtQgcQyrFRjE7/4GgfgPo4GzreX5c/jDSRTVm6ccYZ3v5Ad/i3i4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP7dVA7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4090C19421;
	Tue, 23 Sep 2025 10:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758622064;
	bh=JQPAqskccYl3Rxza7uY7Mw27b9b3oqnTfLM5B4pIVVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VP7dVA7fiZT+f9JTBX3PYP82imk2wWP29Ua1ssvoaFoS6JAv2rhOL4XneI/s0U1ys
	 fD8BTL3NCaQbOtOYGQvV0/5Yv89uYlLRcmky1kQpZx05UR2RwqR37RAgm5i3CGH6HX
	 Pc0nakqEf7aoddoLep5X5v5ejvdq5m3VnZnAmcW+PkoVoJltOSPnVmVqWcXcgIdAWH
	 7WYa/48+NGJtxrbVpWNhJVls/w9w3ydW4M3Zv6RyswF5Jfzy0nFOKZobvDaTu82sTJ
	 WrGXV5WPzex7tqewFd0ihpEKs+ONE1WNa7v+8HpCXQS0T7+o0tDpdtwqUpjuY5ItUK
	 1Eb11BWHQUeuA==
Date: Tue, 23 Sep 2025 11:07:39 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net-next 1/3] net: dns_resolver: Use reST bullet list for
 features list
Message-ID: <20250923100739.GH836419@horms.kernel.org>
References: <20250922095647.38390-2-bagasdotme@gmail.com>
 <20250922095647.38390-3-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922095647.38390-3-bagasdotme@gmail.com>

On Mon, Sep 22, 2025 at 04:56:46PM +0700, Bagas Sanjaya wrote:
> Features overview list uses an asterisk in parentheses (``(*)``)
> as bullet list marker, which isn't supported by Sphinx as proper
> bullet. Replace it with just asterisk.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks,

I visually inspected the html output in a browser and confirmed
that before '(*)' was rendered, and now a bullet is.

Reviewed-by: Simon Horman <horms@kernel.org>


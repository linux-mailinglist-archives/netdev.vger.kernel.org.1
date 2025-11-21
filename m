Return-Path: <netdev+bounces-240743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C1C78E10
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 456922931A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD072344055;
	Fri, 21 Nov 2025 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPyfbnev"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29633F37C;
	Fri, 21 Nov 2025 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763725454; cv=none; b=dGhDxnO281x4wL5x4gSy3WNZl43KvY3U1W6QngpMq1tXEOzD8/HvXQHR/rUzv/zaHFJFdoUTVKm0X+jXVfxCE1DHhYf7WmAqppM1SGgMgKPtNn6TWM4BiJF2lkQLVpZQ7K6Oavv1opzEsOryMX9j3TEXGW+fdK6X9iZQ/yXOrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763725454; c=relaxed/simple;
	bh=QDaNBy6n2GSXYttwqRi0bNHxzfC+34gcSt70/cuC/T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTSkELqqRXGB5SUisK5rd9f9peiub8JFlA23Dt5uMXWWwvprZGZL93yXgGqfiHjVXzNDsMOR1yfZy6d+0PzQtquPo38aMUxYBLe0fS8NYhCIBjRyvIL8avLZ+ZEALll2sq0aXyB0QLEp6hAJufcJm4I4cyKAzPvFPENnlvyWeOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPyfbnev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DFBC4CEF1;
	Fri, 21 Nov 2025 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763725452;
	bh=QDaNBy6n2GSXYttwqRi0bNHxzfC+34gcSt70/cuC/T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPyfbnev2BwpFpk0kLaNy3z2O8qKYhxUutzsk0uya181bWkUWrEzrwCdIo1czVrnZ
	 ebmpNJ9YqI7wLmg4o14uVHs220UEQWLxSCFGlZywHwE1qhrCF6RFVBQetPi/UZUEPa
	 MeGxgKZV9SEtdKw9fC87l1h70BG/Q/Gdfw2/8YGliBR0uGnn+zUdqFJqJ2ujmtafii
	 EK3q4t7j0r5FOdMiJDFY5ainVhcK4nRAonWYVLnHKVxVsfixcAkTdOykjN/RCrrl7b
	 TLDc2zJuLYUpLNbslVSWe5Eb1t0/LtIz2YxMSUyzBC/fS1bop6xVEoI8dkaRX44wPL
	 bA4ZTEkIYILXA==
Date: Fri, 21 Nov 2025 11:44:07 +0000
From: Simon Horman <horms@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: af_alg - Annotate struct af_alg_iv with
 __counted_by
Message-ID: <aSBQh8yznEgXOELM@horms.kernel.org>
References: <20251114000155.163287-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114000155.163287-1-thorsten.blum@linux.dev>

On Fri, Nov 14, 2025 at 01:01:54AM +0100, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'iv' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>



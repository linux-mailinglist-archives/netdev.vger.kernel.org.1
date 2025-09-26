Return-Path: <netdev+bounces-226636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A6BA34C4
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 12:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB39F6257F1
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B032D4806;
	Fri, 26 Sep 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufKQbARd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8029D289;
	Fri, 26 Sep 2025 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881375; cv=none; b=JB9KUfSUtizBW5GOhyeFaPNbovEfADsRd3lz/FAbHoKrY3uoOdPeqv3FuqiDNQ8Sa0xpJwT6iS4eSGwryBeXi7yAV1QsnFXqlAP+fQHMWwFuZSBtG0PDAiku9LoXTkVR78fVXy7BZI7i5O6DnhifGRlfb50/tTNcOwDfnIB9ZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881375; c=relaxed/simple;
	bh=Z9bSljZTZ2UnYjRfihpmOzJI4SaODvBE6HhWmeh2dGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyClgNC9s9CAqC1PTgOkTzc7IzbsJMj/EYtCeXIs/HJmmHA0J04uPS4RwvTNhYNCnwMRTMpJT1J6OoaYlko6GWExPwrsV22EogBySOpMAEKTK1q8p7HBeVsCcqxRM4pJjyAyv5mLoYXhl/hX5tBfNKaakx5v23A34VFnhGRzHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufKQbARd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2214CC4CEF4;
	Fri, 26 Sep 2025 10:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758881374;
	bh=Z9bSljZTZ2UnYjRfihpmOzJI4SaODvBE6HhWmeh2dGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufKQbARdJTVukLEIE8gSuX1NeaPCsENOvQRLJUW6K9t+mVb5LqA4fjJ9jHp7bND2Z
	 QpvW6VyepJeB01KxCZlZ/0OBx5EAGlAYZmW9s4gsUQrA6KEcfRMG9zE0V5op/Pa0zy
	 n0DsG0pCbFA6g0KZw6GEdqAHKSCSzAW71L5sQ5AMZoGngYMGRQ+H3+Ms0/hnXGT2l4
	 UUivLHLdCxhGcwNtOMbbpGeIiiYlrnRHF6a+HN3EiFeLa4zSw73laSZ1aWCPSFB6bv
	 oBX31tYfQ9NzvojWPBN95p6g6LfGokw3G90LT5J23+mELLQBmOvLPdIyIm5whmJaB6
	 fPhoGSJOUfRoA==
Date: Fri, 26 Sep 2025 11:09:31 +0100
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psp: Expand PSP acronym in INET_PSP help description
Message-ID: <aNZmW4FvKFtOuImC@horms.kernel.org>
References: <ae13c3ed7f80e604b8ae1561437a67b73549e599.1758784164.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae13c3ed7f80e604b8ae1561437a67b73549e599.1758784164.git.geert+renesas@glider.be>

On Thu, Sep 25, 2025 at 09:09:50AM +0200, Geert Uytterhoeven wrote:
> People not very intimate with PSP may not know the meaning of this
> recursive acronym.  Hence replace the half-explanatory "PSP protocol" in
> the help description by the full expansion, like is done in the linked
> PSP Architecture Specification document.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert,

This makes sense to me. And I confirmed that the cited document does indeed
say that, in the opening sentence.

Reviewed-by: Simon Horman <horms@kernel.org>


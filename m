Return-Path: <netdev+bounces-201081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E70AE8090
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E543B9736
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C263729E11F;
	Wed, 25 Jun 2025 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzkXqlxD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1FC2BD03C
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849668; cv=none; b=VOuz47jAVOFVHx/qX2hwF8uXruPIZvj7UHyVW7JuPy5K6CnLgeJWylE3cmlZ0Z/SJ7OtwnZQoo/as83/70Zcsh945vAYJ8WUe2Lj54K64F9HWD6S7ynboVLT88UyPUqtFu2AImtmCNqQ7vyAF9jZnlixJyECpmmKmpUcJsTGZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849668; c=relaxed/simple;
	bh=/3vp6ZxC0UVLPUUgMD07npqLPRexDtaPgnjtWiP5RQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T43aagOgLjks4t4+Xb0WgydWd0P2Dh5eGrcjGxuhQQNwPkSesPEAbi8B0PNrxUomyIPnPLjLiHucczxjsx44Qi845QDRnVnicCi9qB2gMBSNwohkOUbUVPZQcLUnj9myeca91bzkVNjQvWWGB2wsCIus1MjirDmhkCQzMPOidWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzkXqlxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C003C4CEEA;
	Wed, 25 Jun 2025 11:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750849668;
	bh=/3vp6ZxC0UVLPUUgMD07npqLPRexDtaPgnjtWiP5RQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzkXqlxDexbqxXzNaj6Ts55LrkLIzmifa4IvpG84LYV+7+cHTVWgmQ5lJcwegdGCM
	 sq8TLUviE/Ax49b6fn0MUR/HmOtSEWKEfqY1pGEEGTEUH6d42bLLzXLpyi18fwaJpg
	 bj8FU8KYn8g7T9q4ztl6Eocya+9yoclELoNw3+JEz2A89IXhJ5PDhHlOmXc4JXthQq
	 RF7LWsKdxSavl9me2nzljOUtV9avCbc5VnoQ9rh0t3I4/HHHAFnSzE5/VBqk3esubI
	 63w1HL8BNKdsMOp9Bs7NpjXftRHT2V1zkbFZG1uX/gvb6IbGm7Df57wiAxVLDrbFAG
	 9sdrS7mzu2bmg==
Date: Wed, 25 Jun 2025 12:07:44 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	mohsin.bashr@gmail.com
Subject: Re: [PATCH net-next 3/5] eth: fbnic: realign whitespace
Message-ID: <20250625110744.GY1562@horms.kernel.org>
References: <20250624142834.3275164-1-kuba@kernel.org>
 <20250624142834.3275164-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624142834.3275164-4-kuba@kernel.org>

On Tue, Jun 24, 2025 at 07:28:32AM -0700, Jakub Kicinski wrote:
> Relign various whitespace things. Some of it is spaces which should
> be tabs and some is making sure the values are actually correctly
> aligned to "columns" with 8 space tabs. Whitespace changes only.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



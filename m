Return-Path: <netdev+bounces-201043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29C4AE7E8E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6973AF6AF
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A9A29ACE0;
	Wed, 25 Jun 2025 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh+9SbxJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6601F4615;
	Wed, 25 Jun 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845992; cv=none; b=OWKgn7EpexKeLptR0rwgyfxt6aUhrIexxsVmETJkX3547pqWza5+Ef2RgDIYMd1NdJn/B1ox1VycYMZC3HkNfdxSW9DgOUIaIPsXw55h32UcebPDl1HuDG15NxVVoY2Y6lkyq5u1o5nf4vNU1QAhUFeobZCh4pE3z5wMJy2lHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845992; c=relaxed/simple;
	bh=MEsTb8kio6nNINr7ia/BYg8+XaYCIxivIS2ORwlkYg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC8EE3VUA722Jc1xsfazHRknRkskQWvt/M3P9sMog/n+nlgDhJJfH1jNcChBQBCUPeM+AisKc4frOWrZgx+WSCitER2medMeLQhAOgYpGKpeVoMjgviu0QUFUY0j4ENtyW6Uq+/EsxtOTBgNgMopO8kv2OLMeQ+/UjViG3ZkCE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh+9SbxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D109FC4CEEA;
	Wed, 25 Jun 2025 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750845990;
	bh=MEsTb8kio6nNINr7ia/BYg8+XaYCIxivIS2ORwlkYg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dh+9SbxJBv6hbAbh2ly4yQEoPwcJ2PVq08sLHGf8UxEVSyymJ+mqWvrVlDx9uhk+Z
	 3uuyPcPgl0WWs4aQFCvxSyYRDfAFs2Llsj3o8hLUg6LRSbnAaH8Pmx5hLZTQKGPRNg
	 meMADY5eATBqf547gQU21iQeUuEinWXhszC3Yv8pDEKg9K4zmUVL2UutWWJsQ8d+Nz
	 y+hQDDHL6CoLXlcow68iRYpFh3LfI3gEBuvqNjtoEk4+5zAYajPAi2IPEh9Ct4GzSq
	 dTFYZeJl0yoU06pdk+ldrfEeTD5irCdiMi13HOXIvj8d+vZyIgbYL3Hn1cjB7seWX1
	 vDJiZeG1mYJ/Q==
Date: Wed, 25 Jun 2025 11:06:25 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/7] net: splice: Drop unused @flags
Message-ID: <20250625100625.GP1562@horms.kernel.org>
References: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
 <20250624-splice-drop-unused-v1-2-cf641a676d04@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-splice-drop-unused-v1-2-cf641a676d04@rbox.co>

On Tue, Jun 24, 2025 at 11:53:49AM +0200, Michal Luczaj wrote:
> Since commit 79fddc4efd5d ("new helper: add_to_pipe()") which removed
> `spd->flags` check in splice_to_pipe(), skb_splice_bits() does not use the
> @flags argument.
> 
> Remove it and adapt callers. No functional change intended.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <netdev+bounces-79082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB31877C81
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 10:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3584B20A7A
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 09:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398415AF6;
	Mon, 11 Mar 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqVmI5x8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39B14296
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148843; cv=none; b=XZMvn0OwSm450tbUZBhnhbD45of9pP9tigApTG2rgshMqO6BXUBw9su1Wx67pxySrXml1oGIqb9K+4g5wifXiNwbrKCY+JpHorVOZjcyjtb6WxdYXBxAfUD69Uo9r+EGsxr8a3dCRdbZocSKgX3RjDrzi7hB/qRoke6ALLRd7GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148843; c=relaxed/simple;
	bh=qxi5+TOjcyya8fuII4LhWu35JwnGT9JmbLofTAmXndA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohGQxnbPscrVX67psTH1I/9hyma/FYAFT76omOwdE5aYGV2VAJXFCNdFW9T7UZXGES0Icq4IstnwwTbu1KfthRDUacGg6ICqo3plyLTfyOKzpV83yZ7vIpjFRA8XQk0v/hhm5q5ArjuEVfucsbaa1n8sffAQ5FDlHFk0ZIfhOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqVmI5x8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20E6C433C7;
	Mon, 11 Mar 2024 09:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710148843;
	bh=qxi5+TOjcyya8fuII4LhWu35JwnGT9JmbLofTAmXndA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqVmI5x83bTZvZdRgsr3jFXennCqv3MZ9XIVAix9YWqJzPtIRhUr/pVl+zxh+yYdY
	 s9LtpIpAOJVws7PoE2so5rn68s7z69S3vRhwYcx9bmIbvwl1nY1JYmf2mksSAQv7Ju
	 G9bdWTNWT5ujnkCuUbLAVeVHKIo3nhUgtZdVoSl4aoygh7ACYvuF6EvkbDstwM7E90
	 1wQvO0QGhTawmDuMGUzceGQZ/bW3YtyTVN2DBtCA0at+Kwe+otwT4PHft7lh965tmS
	 qQpPGICIWpkw+c+3aszeflXXFAdhG3TM0OLoKNlpy2sQnQ4TvEObKzYDDw8MGaVzvQ
	 k9bHT6uJCwF8g==
Date: Mon, 11 Mar 2024 09:20:37 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: gro: move two declarations to
 include/net/gro.h
Message-ID: <20240311092037.GC24043@kernel.org>
References: <20240308102230.296224-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308102230.296224-1-edumazet@google.com>

On Fri, Mar 08, 2024 at 10:22:30AM +0000, Eric Dumazet wrote:
> Move gro_find_receive_by_type() and gro_find_complete_by_type()
> to include/net/gro.h where they belong.
> 
> Also use _NET_GRO_H instead of _NET_IPV6_GRO_H to protect
> include/net/gro.h from multiple inclusions.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>



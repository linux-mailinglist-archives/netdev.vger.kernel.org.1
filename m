Return-Path: <netdev+bounces-110233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4607492B8EE
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D06F5B2291E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF9B156886;
	Tue,  9 Jul 2024 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMpsLwjy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7C153512
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526412; cv=none; b=uahsDSTWzJMcs1eL61G8KQiCQ9T3z3cEBshFg637zZ3GCbPYsWwy0WM4AtHTP8Iv09Fvvm5UFvi23pAz4MZp3RYtAxP87m9ZtWPqwrlwPYT4krYZak8b0ISaJUHYnxleMX98CDSDtBMqe8INxMhekvKBwMOlfY9+DW8IDFaD2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526412; c=relaxed/simple;
	bh=e1I0a4o+IcHKlRhQkEhaB3P0nLJx5M+rjq/vDJG2ol8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6TugQ0/EgpWN1w8r5opHngp231VZjYgexweyJwKSHME4+Ce+CqrqXrlfu+sOx0YztqAjozg8q7JC+SEnrqzagDUxgJfmFD7x9M9YPI45rALWS0iV7QikD7ps6HmVyJYo0ZMek4jW5ln96k0WC18MFbqdaaJ3D9Q7yoKC9U8kTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMpsLwjy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37E9C3277B;
	Tue,  9 Jul 2024 12:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720526411;
	bh=e1I0a4o+IcHKlRhQkEhaB3P0nLJx5M+rjq/vDJG2ol8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMpsLwjyP3gbkFpmkySVVV6E4bATJXKupNr2PYjt96yls7D7Geq+nSDD8Objcqj3l
	 QUJj26jcbTC6c4fZ8JV7nCQVUcD66q00iiaO+K7+kpIjfTaAo457LoyEZ3Mp4lyuzV
	 8tHXIeN61npbARd8uivPbCriIdorudzGAo1ybD+e7m2V6lyDmqiWtd65IBf3vVbhLU
	 gl+8ukX8scp5vNahUPy4QTIqLHNPO8XEFeIX/kiU9/cg5BdDXxxGGKsD22qp/Aeq+U
	 D2vZ6vvxonK2ItWXj2oazlJIZtnXQv9DFNX7q2xBESs0cf3S5WFPQH80PvSNwsyQkE
	 Ch+ion2sYxi6w==
Date: Tue, 9 Jul 2024 13:00:07 +0100
From: Simon Horman <horms@kernel.org>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc: netdev@vger.kernel.org, Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Debashis Dutt <ddutt@brocade.com>
Subject: Re: [PATCH net-next v2] bna: adjust 'name' buf size of bna_tcb and
 bna_ccb structures
Message-ID: <20240709120007.GG346094@kernel.org>
References: <20240708105008.12022-1-aleksei.kodanev@bell-sw.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708105008.12022-1-aleksei.kodanev@bell-sw.com>

On Mon, Jul 08, 2024 at 10:50:08AM +0000, Alexey Kodanev wrote:
> To have enough space to write all possible sprintf() args. Currently
> 'name' size is 16, but the first '%s' specifier may already need at
> least 16 characters, since 'bnad->netdev->name' is used there.
> 
> For '%d' specifiers, assume that they require:
>  * 1 char for 'tx_id + tx_info->tcb[i]->id' sum, BNAD_MAX_TXQ_PER_TX is 8
>  * 2 chars for 'rx_id + rx_info->rx_ctrl[i].ccb->id', BNAD_MAX_RXP_PER_RX
>    is 16
> 
> And replace sprintf with snprintf.
> 
> Detected using the static analysis tool - Svace.
> 
> Fixes: 8b230ed8ec96 ("bna: Brocade 10Gb Ethernet device driver")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> ---
> 
> v2: * target at net-next
>     * line length fix

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>



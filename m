Return-Path: <netdev+bounces-94905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF6F8C0F7D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCFF1C20BA8
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D8B14B958;
	Thu,  9 May 2024 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlTHlGt6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245014B947
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257129; cv=none; b=g3wM7d2a/RSHrYLl1undC3CDWq8zY+D65eNURoPgnqLvePz+oo9vByi1mxBg4YAXMPBAPN3Qnsm3W7NtODQ/0UzHhV0CKmW240KtjzD7BIHS4sBNHj2bX18AQv+PrMQ+FVhMkWFORwIIb+AvajlNfJ1D4D24NgcwWvrH7sBxjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257129; c=relaxed/simple;
	bh=epZNN4KGmYrFbbtHBjJWoV2pduCbfyPjkZ6OOVYCvz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx0uM++ya85hyjMhfLxMxSds8neGvHv4ntDirX7HeeysCOdsQvZkAsEEbVR8GaKiJfKHGPEK6BuX+vUXkbk7Kj16UJwBvsqWQw92ZOi1YhmHV9qbvXbBUCAOI0TayMibAEryJmedHtYaJFTktSfz8IcBSMY9FuBWdKvw8n6khfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlTHlGt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED74C116B1;
	Thu,  9 May 2024 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715257128;
	bh=epZNN4KGmYrFbbtHBjJWoV2pduCbfyPjkZ6OOVYCvz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LlTHlGt6kzFPXWLG6ZVV7H3XyBZwG56VCfzNIWsMsLWKyE/TDOjYUy+UnMsUTB7bp
	 90NnjvRoKXnJmuuCVnNnvhz4RtWaBXPiRxfWF0krKqGFEBf9Fx0YS+UkNImoUVoIGW
	 z21JK6p5z0S9jvwirzLc6oRr3iSfx8muCW0PurnTPLgldgOOjhR5FgGEWffVUOvME+
	 NY9Mzu0C1RVdaWZM3XQ2QCLl0eBzF+svDGlO1oZfDF7Dk8FZBZeJNxkQZ4+RtP8wVP
	 b5/KZ9d39VLjaK9FCvsrRUClOjDpe39KY1i4oE3lsfW9hKB9d6gOXDpsEn5rb3j67t
	 drrXfNC5ijdHA==
Date: Thu, 9 May 2024 13:18:44 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de
Subject: Re: [PATCH net-next,v3 11/12] gtp: support for IPv4-in-IPv6-GTP and
 IPv6-in-IPv4-GTP
Message-ID: <20240509121844.GU1736038@kernel.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
 <20240506235251.3968262-12-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506235251.3968262-12-pablo@netfilter.org>

On Tue, May 07, 2024 at 01:52:50AM +0200, Pablo Neira Ayuso wrote:
> Add new protocol field to PDP context that determines the transmit path
> IP protocol to encapsulate the original packets, either IPv4 or IPv6.
> 
> Relax existing netlink attribute checks to allow to specify different
> family in MS and peer attributes from the control plane.
> 
> Use build helpers to tx path to encapsulate IPv4-in-IPv6-GTP and
> IPv6-in-IPv4-GTP according to the user-specified configuration.
> 
> >From rx path, snoop for the inner protocol header since outer
> skb->protocol might differ and use this to validate for valid PDP
> context and to restore skb->protocol after decapsulation.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>



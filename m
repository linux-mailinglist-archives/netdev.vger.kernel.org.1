Return-Path: <netdev+bounces-217790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E64B39D7D
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B2968277C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE5F30FC2B;
	Thu, 28 Aug 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZgGU9T/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848DE30FC22
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384824; cv=none; b=hSYBrs3Ub0eaZJX3KibH5HuE5zhIeaC6yPbN32JPGDoWct2PkMNFlgU+EAe648RPM+jIOaAKqQWNP602AmujBJ+E81z8KS7YJe/59kFa+Wb6zM+HgpNSdXevENkvQZMOVI4HmLg+1+qgOPo+bZfsqhqr3Dhi8n00YZuZ6mlOKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384824; c=relaxed/simple;
	bh=NEazeLpd+bcLBHgDTjQnItu68hImoubJuA2kYmpM6OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3yDE0EtpfN++A4l8yuNY43IHzgjmaqB7TlSalXInMiDHj8zW+ChGyUrrelI8o/uYXZXQhHmT33wYZAjMof5YFdtosTPRrDZqRkUkIq5mROzT9VTht9KzERpV7SCZ6bp6BxCRdiIvhGlkwa+5e3r6Hi5AA9KWN5F4NTCVuVB7uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZgGU9T/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5744C4CEF5;
	Thu, 28 Aug 2025 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756384824;
	bh=NEazeLpd+bcLBHgDTjQnItu68hImoubJuA2kYmpM6OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZgGU9T/Al/U2yFHpamwq3pYLADCClEN7Ul/CpTKNMJg+ezp15nx3u6WBD9RyGyBi
	 mjHBa0V+UpQYXtXZDGjGfMWIOpkBdrIGRVLkhy12+6Fddfdb67lOQu/HbJnnLTKpWc
	 KlEUqGGY5kSALTe5oklI58bEiwiRLRqqk+MuZMyCQ/i9HwUf86lI50ztqxWld/py1y
	 tkNK7ZzJEIDvCGIAZyyVzA1hSBbhS1A+hEeloTT+DE453z1bQNYGoBsrXADjjxa4Kn
	 WD+bZhPzS4eCpRuakLdxgjhhvRUAFGdIaxMQmVrW3BKB5rTssrqOQT8TXg/nRSbFYe
	 6oD0Faydmi86A==
Date: Thu, 28 Aug 2025 13:40:14 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com
Subject: Re: [PATCH net-next V2 2/7] net/mlx5: E-Switch, Move vport acls root
 namespaces creation to eswitch
Message-ID: <20250828124014.GD10519@horms.kernel.org>
References: <20250827044516.275267-1-saeed@kernel.org>
 <20250827044516.275267-3-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827044516.275267-3-saeed@kernel.org>

On Tue, Aug 26, 2025 at 09:45:11PM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Move the loop that creates the vports ACLs root name spaces to eswitch,
> since it is the eswitch responsibility to decide when and how many
> vports ACLs root namespaces to create, in the next patches we will use
> the fs_core vport ACL root namespace APIs to create/remove root ns
> ACLs dynamically for dynamically created vports.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>



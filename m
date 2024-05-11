Return-Path: <netdev+bounces-95700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73C18C31DC
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573C82820A3
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E0A55C29;
	Sat, 11 May 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0bWchKX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACCA1E526;
	Sat, 11 May 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715437951; cv=none; b=RgtW4wNRP/SAtYZ7h6iQwHmrh7wBm2NmgG9kWM1LGMq9xLSvfYKSX4+3n/w2I0WThihBVA2WnTLQv/SDy5irltcvbUAnboyyzo43cxMYolEW8JWgcUgPHhxdmlX5wf5LCkUQbakRWdTtnbN3klfDMDs2lxWkJJ8ZW30j8BfF45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715437951; c=relaxed/simple;
	bh=ZiuHNDka16x6oIRNSgu5bdFvGzb9OB9POj/J0eopbA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EslHj+f5MkKJv/UJJghbqjsqekn/PyKNVeERKpVOmWVxdv0Qyhqfup8ttqNWCheY2amUXQGJmYMX79Rp8l4SIKU95KHfyNbwqG8SIj0Pxj8FPakgdSN30Jgzx3uYI+hxXV1Wr50VtSMsQBcqIoLVTpjX83Sr2pTBDwO6SnHmsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0bWchKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48370C2BBFC;
	Sat, 11 May 2024 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715437950;
	bh=ZiuHNDka16x6oIRNSgu5bdFvGzb9OB9POj/J0eopbA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0bWchKX2n3tp0qqQQkUGfAHsvrDiQfGK+GpEpjfyT8ONkKHP+s+VIQf8zZnFx4zT
	 eRk6VnfVMci2xt7lW512fbrQ+zHG7DJsy/EOd1Cvpq8sakvnjblj7EEUjmPRXkwgBG
	 yse4AWeU88txnktKaECxVhj5pH6dP5zlDMCc6vVz4BPJpA5y9MU+M+/uvCfvSaTnl8
	 fYy6axkHJZhgSd6sRq61ULRV1+6Ir2LxHlFHgIkLNV79MnjG1d5NRaTnhNlQ6pjOam
	 ZeU/vVyhJhJVoiROSLpHbmkHBQ9IAZtBwdFBzwsgtXqGUkiCGEx+7fkqcE/cLdb+ad
	 lqHRbO/zVyrug==
Date: Sat, 11 May 2024 15:32:24 +0100
From: Simon Horman <horms@kernel.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
	shailend@google.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
	hramamurthy@google.com, rushilg@google.com, jfraker@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] gve: Add adminq extended command
Message-ID: <20240511143224.GI2347895@kernel.org>
References: <20240507225945.1408516-1-ziweixiao@google.com>
 <20240507225945.1408516-3-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507225945.1408516-3-ziweixiao@google.com>

On Tue, May 07, 2024 at 10:59:42PM +0000, Ziwei Xiao wrote:
> From: Jeroen de Borst <jeroendb@google.com>
> 
> The adminq command is limited to 64 bytes per entry and it's 56 bytes
> for the command itself at maximum. To support larger commands, we need
> to dma_alloc a separate memory to put the command in that memory and
> send the dma memory address instead of the actual command.
> 
> This change introduces an extended adminq command to wrap the real
> command with the inner opcode and the allocated dma memory address
> specified. Once the device receives it, it can get the real command from
> the given dma memory address. As designed with the device, all the
> extended commands will use inner opcode larger than 0xFF.
> 
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 31 ++++++++++++++++++++
>  drivers/net/ethernet/google/gve/gve_adminq.h | 12 ++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 2c3ec5c3b114..514641b3ccc7 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -461,6 +461,8 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
>  
>  	memcpy(cmd, cmd_orig, sizeof(*cmd_orig));
>  	opcode = be32_to_cpu(READ_ONCE(cmd->opcode));
> +	if (opcode == GVE_ADMINQ_EXTENDED_COMMAND)
> +		opcode = be32_to_cpu(cmd->extended_command.inner_opcode);
>  
>  	switch (opcode) {
>  	case GVE_ADMINQ_DESCRIBE_DEVICE:
> @@ -537,6 +539,35 @@ static int gve_adminq_execute_cmd(struct gve_priv *priv,
>  	return err;
>  }
>  
> +static int gve_adminq_execute_extended_cmd(struct gve_priv *priv, u32 opcode,
> +					   size_t cmd_size, void *cmd_orig)

Hi Ziewi Xiaoi and Jeroen,

As of this patch, gve_adminq_execute_extended_cmd is defined but unused.
Which causes an error when compiling with W=1 using gcc-13 or clang-18.

Perhaps it would be better to squash this patch into the patch that
uses gve_adminq_execute_extended_cmd.

...


Return-Path: <netdev+bounces-209368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AB9B0F674
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9D51891E48
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02A302056;
	Wed, 23 Jul 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiJNYob1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546D2FC3B8;
	Wed, 23 Jul 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282478; cv=none; b=UMwGoifYVL3k2iaEDtFOYeyJYYa8G69QtENdPIkyRF1Ra6R4wzgCXpV5yrkKSXffoOyl4kl9+mwYsh78IcpA8DDF9zZ5/pyhNfOLEHUYnk25vpiUoGEoMb8z0/ySMGqKFTdsK7QERb5NXCjUqm6pCm421Tmzn+VGsUaJhMkGVKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282478; c=relaxed/simple;
	bh=c3QXpnSl3eJnVt7501+UkP+7N9yavf+xp78BFKG7fIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eT9HOHbX8dao0lS8hlpN22XEoHiBTb2sV7ML2OtqRx0j10Ie15XEJthWj/KvZqTcsfCpmnvtJF69i/pt9GOc1fLpduOaymyuAgeVCcj8wzuaJkv3qCHzTbknqzg+Ky6xD5Ya69QN5fkxHByHzg3QhjpJs3ywmr5/8+pz7rm808g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiJNYob1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6604AC4CEFC;
	Wed, 23 Jul 2025 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282472;
	bh=c3QXpnSl3eJnVt7501+UkP+7N9yavf+xp78BFKG7fIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tiJNYob1sY7Wmghg0OGhYjh/bZFDBSqSgHgikwgY65mNwxh2SV6SgmZ1Ekjzwnvoc
	 JoXgJ7KwtUuoqIR39eamE4v/4ihDgc3WwsnP7KU2dzYTMHXO4zBfkVLBuQwJ8GXoKC
	 NQywuwDIf6c1ltTzG4k2EgXv/WxoUtMSSsD0/hOKSyXmGYq0h0SWpuQ0lXgvgnNHO1
	 sIWvkxOj2egn0RIyynY4atUvFQOEeKQ6p4l0WBWxjHXxySOtVsz28ZmnZZg7a1NAJz
	 ztoE8ZrOJdXl7ny8UleswHN5XFUrN436/kMcPyJ0rLzBAkYNpqPCQNwBmGzfMMLDUa
	 uyoyMhOLFHEEA==
Date: Wed, 23 Jul 2025 15:54:28 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 5/5] netconsole: use netpoll_parse_ip_addr in
 local_ip_store
Message-ID: <20250723145428.GC1036606@horms.kernel.org>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
 <20250721-netconsole_ref-v2-5-b42f1833565a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-netconsole_ref-v2-5-b42f1833565a@debian.org>

On Mon, Jul 21, 2025 at 06:02:05AM -0700, Breno Leitao wrote:
> Replace manual IP address parsing with a call to netpoll_parse_ip_addr
> in remote_ip_store(), simplifying the code and reducing the chance of
> errors.
> 
> The error message got removed, since it is not a good practice to
> pr_err() if used pass a wrong value in configfs.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>



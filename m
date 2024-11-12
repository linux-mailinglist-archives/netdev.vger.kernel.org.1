Return-Path: <netdev+bounces-144144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036049C5BC9
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBFE288607
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8475E200BB9;
	Tue, 12 Nov 2024 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aft3zHDE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5B2003AE
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425076; cv=none; b=LMYjVxeTJz1nAT+SrYxEclaamSQiN0z/NE5+cfsFwfl3ryXMDeD8xAl9n8KEDvFLnNLzf+3s4mfI1qSgdqaEORldw50JCahQ8sHmgYCd/kqi14L0dKsH1Ksx1xKn9TpmlVTE+v6J6B8LMhGYMGoIZlrSHp1isjbnRecmB3cdDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425076; c=relaxed/simple;
	bh=/V+iRWJCg1vy3rQQzMi0818l1cKVkTwl75vk9Wk2GF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xny1wYHtxEZOE0Thgzzj5LOLQktJWna2nLYWkxtaDnB5e6H4qV/yPUlibdIlcSpraabCQmWZePrpz5UPHIbSrg75KfDrjPG4hJOKSJnfak4RReIpFwg6TZ+EENG4BqbTBGGLbmkxoPz9Rt6ZcKEt7kiOEZ/VG0fWIjvBvnOr3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aft3zHDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95ABFC4CED0;
	Tue, 12 Nov 2024 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731425076;
	bh=/V+iRWJCg1vy3rQQzMi0818l1cKVkTwl75vk9Wk2GF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Aft3zHDEIfwuJDPKYzykYjWKLU76AkYpzFUWXsKd3r5gv+zwIlFQ9NViJBPYuWzAy
	 2dfRS6b0CYBjhGjZlKeMAcUAGwcfwe3gAvpvYlVbAwR+oMu+mVW3xevF2tXQWdIQR8
	 S5GF54tr8bvksbduoMBwiPLLZFP92JNta31GKAjs+kXeuP+TVWA3Bl8d7g+cpcFu91
	 U+llHKrZD8i+1DX9lfh/CZj0a4fCpHhxI4pCwRDx1wBznTzRJG3yfzgRtBJNm9AfYk
	 2l+0E46zSbPE/VMvR/u/ZbXTKE3vwQeGugcuL2GgJ6w+gWh78eqtW2rf1a5uSPk2mV
	 G1mir/OV2o4bg==
Date: Tue, 12 Nov 2024 07:24:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Joe Damato <jdamato@fastly.com>, Daniel Xu <dxu@dxuuu.xyz>,
 davem@davemloft.net, mkubecek@suse.cz, martin.lau@linux.dev,
 netdev@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context
 action explicit
Message-ID: <20241112072434.71dc5236@kernel.org>
In-Reply-To: <7fd1c60a-3514-a880-6f63-7b6dfdc20de4@gmail.com>
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
	<ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
	<Zy516d25BMTUWEo4@LQ3V64L9R2>
	<58302551-352b-2d9e-1914-b9032942cfa3@gmail.com>
	<20241109094209.7e2e63db@kernel.org>
	<7fd1c60a-3514-a880-6f63-7b6dfdc20de4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 09:24:07 +0000 Edward Cree wrote:
> On 09/11/2024 17:42, Jakub Kicinski wrote:
> >  - fixes for helpers used in "is the queue in use" checks like
> >    ethtool_get_max_rss_ctx_channel()  
> 
> If there's an RSS context that names a queue, but no rxnfc filters
>  currently target that context, should the queue be considered "in
>  use" or not?  (Currently it is.)
> I'm trying to figure out how much of ethtool_get_max_rss_ctx_channel
>  can be subsumed by the logic I'll need to add to
>  ethtool_get_max_rxnfc_channel; if we don't count unused contexts as
>  'using' their queues then ethtool_get_max_rss_ctx_channel() can
>  almost entirely disappear.

Hm, interesting idea...
Practically speaking I think it introduces complexity and I'm not sure
anyone will actually benefit (IOW why would anyone want to keep /
create context for inactive queues?).

Drivers may not expect to have contexts pointing to disabled queues.

My gut feeling is that we should just leave a comment for posterity
somewhere in the code but continue to validate both based on rules 
and based on "direct" context membership.


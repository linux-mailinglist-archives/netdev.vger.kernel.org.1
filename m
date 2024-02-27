Return-Path: <netdev+bounces-75395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CBD869BB1
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 17:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABBC288A7E
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4010146E8D;
	Tue, 27 Feb 2024 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBmL7CsF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE21474B0
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050271; cv=none; b=b2EU42ijFBmuiTM3Ci1zYgZZ6pL5R5oM5FeYzNkSMkFJUtEPmQuE40S1A3h/s6CSq/Iu94dZ0WsXBfIZS50g921T1aeHHklOgDS7XW7ka2oBYvoR0cXmBwymkD40sWkUvKsXwd5ZuwiVo4WjX1mAQxM0FHafX8017/cFsPhV6jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050271; c=relaxed/simple;
	bh=+sjtZyKG1EQY3kd920/lzgpqx6JPWvMT6IFfse1fF2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZKSSVB5WTcGt49ZnsTZcDcQHcteWzwN3xhgl2QDEYq+z+xUQIApaq4BUPlr1vHRPoPXQDelx2lNbMCBu2g3dI+imXW17ksI3jaTtk/lUf3jdFmsqQImNVdOaT2nN/7UISRKq3tqrxdlKhbpXTbAkun33laetZdoa74Adff+lsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBmL7CsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33524C43394;
	Tue, 27 Feb 2024 16:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709050270;
	bh=+sjtZyKG1EQY3kd920/lzgpqx6JPWvMT6IFfse1fF2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SBmL7CsFS12DBs7xrcNWp8N8IzjxxUZr7vLrSut4K/IbP47SnKWn3hJxqjz7pRkGq
	 AYj6uQAJG3Lkq6H2G7MTp2yitBmyeXWS8jWOQyVgxHHrV7e4IRUDYXHg+3xrJ6H/WS
	 nr2xdPn3HokPnkVEQqE2G2ALIjBwN1oECE8BNUcRvFZ8JQuJ/up5oIea662smxgyoI
	 tYfY3iLvvF3IrajFwfsfrLf4IVjeU0kgrNNLx4g8Kl5YWusv7rdp+bMmyXRwsxUDL/
	 fluNYfTDK/jIig206w77bfaoWOp0MiIV5+ORZXfm/cdEdqBoO4p3wS72gWpmvhcOrX
	 F/3/159VotMuQ==
Date: Tue, 27 Feb 2024 08:11:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [RFC net-next 1/4] doc/netlink: Add batch op definitions to
 netlink-raw schema
Message-ID: <20240227081109.72536b94@kernel.org>
In-Reply-To: <20240225174619.18990-2-donald.hunter@gmail.com>
References: <20240225174619.18990-1-donald.hunter@gmail.com>
	<20240225174619.18990-2-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 17:46:16 +0000 Donald Hunter wrote:
> The nftables netlink families use batch operations for create update and
> delete operations. Extend the netlink-raw schema so that operations can
> be marked as batch ops. Add definitions of the begin-batch and end-batch
> messages.
> 
> The begin/end messages themselves are defined as ordinary ops, but there
> are new attributes that describe the op name and parameters for the
> begin/end messages.
> 
> The section of yaml spec that defines the begin/end ops looks like this;
> the newtable op is marked 'is-batch: true' so the message needs to be
> wrapped with 'batch-begin(res-id: 10)' and batch-end(res-id: 10) messages:

I'm not familiar with nftables nl. Can you explain what the batch ops
are for and how they function?

Begin / end makes it sound like some form of a transaction, is it?


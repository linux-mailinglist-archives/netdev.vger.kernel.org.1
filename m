Return-Path: <netdev+bounces-114789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2692944166
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08933B33143
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7315136E37;
	Thu,  1 Aug 2024 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAEtwgDG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D322064
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722478545; cv=none; b=uEP+8Tp7oOGhvJ1Nfbks3RtMvSzgjcxkjKMG2PIrVCj+YQ6gH3FD1YH1pDAIJYE1G3hYya9NSQO8LYWFYLgTk2sD6jxWUXJa1pSiTLczrqP0x7zbNHmsh/hYlrjsPz6PHxiR82smGgAe8VNjQkeDkX0cqFIFZ5KfJZzhfwgITV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722478545; c=relaxed/simple;
	bh=/qoTxGgTkyOMWLTJ0YGknZL5SPvJZwpLyhC+Jnx1wWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOBrZkrb/paR7+PL8mHIElJp6mXQiUxwdVuSNLCTMZyvpTmnqSM+wfMq0Eqt2HXVggBAitOrnQUzjRybnPdEdoSVMZ6rQKhViDRVwbmRZAK5ckFn+4IhD5R5aCAWNTIHhMQ1y6DNNG8rzn5Dbb+EEGI9CsaQQNZ5LSwPvfKE+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAEtwgDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921D4C116B1;
	Thu,  1 Aug 2024 02:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722478545;
	bh=/qoTxGgTkyOMWLTJ0YGknZL5SPvJZwpLyhC+Jnx1wWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LAEtwgDGFWsF4f2kzziQI9p1D3MzBi+zE8vKXy1disJuKOpykCLv9b7YuviPncM5c
	 pJ/xLnrYaYLzTakRXIjSUW/xUQU6tbL5v/xRGAesTecfZ9H70OG4yGWe24Fz7+FCAR
	 PE1UD1O5Hb8SKvWvmtDzDYJsdVKn6hzgl+70ZbKRY4BXqeorCt/YRBtRdxQwDtgCM5
	 tMc1XE3DI1ZRL3thzf5kvHOgROGsdHCC8Sq1dZdsVFIQVd9eM05ci1WHib1fHKUeuv
	 jFmjFRqpfAe5o033DNLI4nNETBb+c0uKeoeFghMCXJZJPbkcgiC4t4QidOUhvDGqyf
	 6Z8Yww5Q06Bnw==
Date: Wed, 31 Jul 2024 19:15:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
 angelogioacchino.delregno@collabora.com, benjamin.larsson@genexis.eu,
 rkannoth@marvell.com, sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de,
 horms@kernel.org
Subject: Re: [PATCH net-next 2/9] net: airoha: Move airoha_queues in
 airoha_qdma
Message-ID: <20240731191543.2cc0c985@kernel.org>
In-Reply-To: <4b566f4f6feeb73f195863c01b7c9ae1ad01474a.1722356015.git.lorenzo@kernel.org>
References: <cover.1722356015.git.lorenzo@kernel.org>
	<4b566f4f6feeb73f195863c01b7c9ae1ad01474a.1722356015.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 18:22:41 +0200 Lorenzo Bianconi wrote:
> QDMA controllers available in EN7581 SoC have independent tx/rx hw queues
> so move them in airoha_queues structure.

You seem to be touching a lot of the same lines you touched in the
previous patch here :(
Maybe you can add some of the

+	struct airoha_qdma *qdma = &q->eth->qdma[0];

lines, and propagate qdma pointers in the previous patch already?


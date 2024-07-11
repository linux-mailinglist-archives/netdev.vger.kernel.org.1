Return-Path: <netdev+bounces-110711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5147592DE30
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 04:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0797828172E
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 02:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEBED271;
	Thu, 11 Jul 2024 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjH2SJsS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B7C133;
	Thu, 11 Jul 2024 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720663260; cv=none; b=gssIyiwk08GKqjI3k29+6crsRJgQL3Mde6F5GkmzegqPlXsf5JIwiXY3DC4br1XqRE4MW1BJYfYvXZN/+vDIGpfQmlW1X3S83lW2bK6SE/Yd69ANpOq+PdVbJ5DKcGqyxCk0hvirZH7CKQbrfAsr947+MI5JTrUl7FcXwO70RUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720663260; c=relaxed/simple;
	bh=MZSepU52lrRYbEv6ZHYa+JgA3kjNQlhs4kD+umitfmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+1eYZAJDlmYw5AiZhmBVfQERxl5E2CHI6HuE4H9E6ICcUsNdBpCj7YYh8cfFv2WyKQJy7NfGNpuDdNzifAejg0Kjpe/SsCrSKPKQ+W+CQmbrqo/EnXMTaVVV7Jna/OUi0VnRk3DNJ0qgJnwIHHWEHH9sPLVDGy/cOMdcV9/LzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjH2SJsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3854CC32781;
	Thu, 11 Jul 2024 02:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720663260;
	bh=MZSepU52lrRYbEv6ZHYa+JgA3kjNQlhs4kD+umitfmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hjH2SJsSooZscEaOdziOEK+qw8Eh7PD8vZIDF6sXi1b5JLV4R6chJQaesXO/3SkOO
	 mmV/5GD+tnQS1vaAcLVlQeeQmTHapScHnAo8bbanoUVxnsVA4fTxQ65Q6kvASh4cTK
	 LqU/stt9kR80rKJKk8hs/ekZxnOtffIWLnlhcKl0CEquXQk2OEl74qBeuYhWuUqn4O
	 nBlliKlIW6Ufjw+p8BsoE31aSFaeTfZJYdLFi7D7AsbQ7iqB5b+N9D6zH7s1HdIWca
	 C1j8GmgbLxBNmKHrW4t3W5FWLJyb6axpUNoUaP59ax3CVIgxRyel2FD4ew1pT1wn4Z
	 g95GSXnp+pYEA==
Date: Wed, 10 Jul 2024 19:00:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <20240710190059.06f01a4c@kernel.org>
In-Reply-To: <whgbeixcinqi2dmcfxxy4h7xfzjjx3kpsqsmjiffkkaijlxh6i@ozhumbrjse3c>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
	<twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
	<PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
	<pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
	<PAXPR04MB845955C754284163737BECE788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
	<whgbeixcinqi2dmcfxxy4h7xfzjjx3kpsqsmjiffkkaijlxh6i@ozhumbrjse3c>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 13:58:39 +0200 Stefano Garzarella wrote:
> There is a comment there:
> 
>      # Avoid changing the rest of the logic here and lib.mk.
> 
> Added by commit 17eac6c2db8b2cdfe33d40229bdda2acd86b304a.
> 
> IIUC they re-used INSTALL_PATH, just to avoid too many changes in that 
> file and in tools/testing/selftests/lib.mk
> 
> So, IMHO we should not care about it and only use VSOCK_INSTALL_PATH if 
> you don't want to conflict with INSTALL_PATH.

Any reason why vsock isn't part of selftests in the first place?


Return-Path: <netdev+bounces-44051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 780F97D5EF9
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA021F21942
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CF9197;
	Wed, 25 Oct 2023 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1Xl/JJl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB6180
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C843C433C7;
	Wed, 25 Oct 2023 00:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698192905;
	bh=7DzSBs3yhzCXmpQ2fczjY4U1Gc12sPHBBSETAV0qOqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l1Xl/JJl+iGbGiniqzmoF7fhtzP/KhaICJIxDWa6eIqnABzD9cwujPvHlZDGly3GF
	 /bjD+1APhEhePeokVZpfHhaWCbX3sEq7zQXClu/IBDm4p+YD65Hmio1J902QTsPf0S
	 yrP2w9fM7nqj7WiZTgJJwZxQrI6AWRX/tKTXhQBoej171CBdvASCJPQkBeBjMujlH/
	 sBhCZ4zhjOtF7tTrLVM0ovTDPwWKUQYV7KaOTmdYUobI9NyLUGMlcHmth5rvQ1H81U
	 wEl928LIMe+Ide/FEuTsYCed16QOqz0nu4E33CrXbErL3h3+rOD8ofZusG8/1gdtal
	 0SwMlxjQNR9fg==
Date: Tue, 24 Oct 2023 17:15:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
 <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <davem@davemloft.net>, <wizhao@redhat.com>, <konguyen@redhat.com>,
 "Veerasenareddy Burru" <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 1/4] octeon_ep: add padding for small
 packets
Message-ID: <20231024171504.568e28f0@kernel.org>
In-Reply-To: <20231024145119.2366588-2-srasheed@marvell.com>
References: <20231024145119.2366588-1-srasheed@marvell.com>
	<20231024145119.2366588-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 07:51:16 -0700 Shinas Rasheed wrote:
> Pad small packets to ETH_ZLEN before transmit.

The commit message needs to focus on the "why", rather than "what".
-- 
pw-bot: cr


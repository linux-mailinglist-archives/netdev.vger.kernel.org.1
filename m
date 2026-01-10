Return-Path: <netdev+bounces-248758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2825D0DED1
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 23:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8633530142E8
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 22:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9E422576E;
	Sat, 10 Jan 2026 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyxSnaNC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9A1B4224;
	Sat, 10 Jan 2026 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768085923; cv=none; b=rCZBe7ZzrWUVxU8pg2llaThHGvtcxqgPiIDXlgVhu+a5C94yj+62T2GTVbLzfWuZWcqvrkq5lIo40s5Bo5qO/FZJYM+9rsHvoiOVW+9pHDjCfyXO+ZrZeealvaaOcWs+wJLlyNwtP4p/WyAHb9w7GrcDeTB1SxuRvHgwW4AD3LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768085923; c=relaxed/simple;
	bh=+324RabEwbA/VZH9PrYE1jKMEnbznYGBleMcMlkMXAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPVfZdLVXUPdI2E8R2lRONIv3g6ydn3fIzZGWTYHTpkok9Z9nOJwjxFt1lvV7eHqmY0VwiSYf7YbHfdndbuobNHsEkXY9wB1qOH3U4N8I4AR2NlX+N4uhW8qhCV8VKwAO6T+ebzq3ipXgC9joaru+ECTxDmcTpxCgrtVlo+1MuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyxSnaNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7F2C4CEF1;
	Sat, 10 Jan 2026 22:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768085923;
	bh=+324RabEwbA/VZH9PrYE1jKMEnbznYGBleMcMlkMXAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kyxSnaNC55QX8k8DmmaW+uH5d3lB/+sBNj1aoS0QXJFPZbUFQouafj2lyw+52HWpO
	 jrK0kAjFdN/0f3+Lsi98P/PrLo4NGNx4C/Tsdsp7LonAaUklxiHd0eH/5lktUv+4my
	 xGOftfIHkmwmUNnQhMAqKXPH8qSBXaN29vhlu6GqeJaZwoxgTkAGIMxkKJfcj9kyiA
	 qvAIFHGuCMwF1i5aAenYmm0H6EchWtRjhDEmfOvkkBpreqO2UVBcfdXY7avkWEGv4o
	 z/qv5zpwuFnfLT+jNwdqbFkHlVa4L1fb+bHX0KBDexcgspUT/cXklEjqOSLo/qo4ZE
	 DyGviKE58DvhA==
Date: Sat, 10 Jan 2026 14:58:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v3 01/13] octeontx2-af: npc: cn20k: Index
 management
Message-ID: <20260110145842.2f81ffdc@kernel.org>
In-Reply-To: <20260109054828.1822307-2-rkannoth@marvell.com>
References: <20260109054828.1822307-1-rkannoth@marvell.com>
	<20260109054828.1822307-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 11:18:16 +0530 Ratheesh Kannoth wrote:
> +static int
> +npc_subbank_srch_order_parse_n_fill(struct rvu *rvu, char *options,
> +				    int num_subbanks)

Please avoid writable debugfs files, do you really need them?
The string parsing looks buggy / missing some checks for boundary
conditions...


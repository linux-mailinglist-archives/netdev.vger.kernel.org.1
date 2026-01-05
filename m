Return-Path: <netdev+bounces-247229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B8CF60B7
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 00:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF8B30402F5
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 23:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C242F4A14;
	Mon,  5 Jan 2026 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAC1Kplf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E22EFD95;
	Mon,  5 Jan 2026 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767657408; cv=none; b=PMRkCsLBL8xNVXOR35vAKUwSjqrvqrASB+sY/2bo1E0zXHjsNTYidcPryReZLt9Ngah8f/A7wIMBCxE1mbrMvaKkorUEG6qQBX7XcW2axFmHDt1tJ9C/xn+T4TmNGrcc36zmpBkeEc9aWXPQx7nDK3lKWmZFGNUhf0l4jLr7zUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767657408; c=relaxed/simple;
	bh=pdOI68sYZV2TcsX6a8v+HPiEE/zPOgjVuPIjs8T96/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtpFS+GeUHDPsaVA8tXIXDP4V7MtwNhGt4oz1bK5WxOJNwNAq5Yv7sHCnnswPzyDDNK15x+emRffMJaY6hIVrKrs+mVOJ5sXG1aBH/JNMRjdCbCcF5QC6pzDHwVOO7VIwmSB75Ec3sdoVz9XrPEAzfTu7Wd4dHUxtTQNaQ4ojEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAC1Kplf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4232C19422;
	Mon,  5 Jan 2026 23:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767657408;
	bh=pdOI68sYZV2TcsX6a8v+HPiEE/zPOgjVuPIjs8T96/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bAC1Kplf0QquxvsMRz9NPOQTmYjV361dkTif24V6XlvD4Vq+kOIlcS527PV7evNzF
	 ZCpvnI7FN+epLEwKYVEir5m99LPvwLgIuD4/R5mrMzM24JnqwDHAocq9X1IB48ioN+
	 KE4dRaUKFfaZ1hqyg5io3Z8KAvew9vKHlLfjMoA7y4ys0linLAkjqW2xjGIUKGiBKx
	 5Fg941Vi5deJO4j2BQr3xC3Rv+y1zHGn4Lx7LOrAbg4iuPLJA8pzLI2PdAjVVj1doo
	 wQ4ZT1ZjZcnmFU0ZblPTiS+Vc2n3+mT59TwE/NCCDtWOHlr9s5fCHKEO9Xk53SRZT+
	 eCxTPchM8VWDw==
Date: Mon, 5 Jan 2026 15:56:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear R(G)MII slew rate
Message-ID: <20260105155647.6b797e9c@kernel.org>
In-Reply-To: <3cba9f17436bb3329ff4a54b6d2f8948b2aa7d5d.camel@siemens.com>
References: <20260105175320.2141753-1-alexander.sverdlin@siemens.com>
	<20260105175320.2141753-2-alexander.sverdlin@siemens.com>
	<3cba9f17436bb3329ff4a54b6d2f8948b2aa7d5d.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 18:00:52 +0000 Sverdlin, Alexander wrote:
> Please disregard the two patches without net-next tag, they were meant
> for net-next, I've just re-sent them properly.

Repost to include net-next in the subject are _really_ not necessary.
If you waited 24h according to the rules we'd have saved ourselves
this pointless repost :| Assuming there will be a comment / commit msg
update to answer Vladimir's question - I'm dropping the v3.


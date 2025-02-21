Return-Path: <netdev+bounces-168366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A89A3EAA0
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 03:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A1277A4224
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB861D514C;
	Fri, 21 Feb 2025 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AngtT0LM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8853819D087
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104060; cv=none; b=c22iWJtIRuOE2Txl0W68KMS280uqBMyaC+wDQaNZT0r+qvxyt+9pnoAvkdATf0cbAMPWNY0SxjqBKoSEtTdOsGlysORzrZkNn/GnHHhMXQegYGS9uBKdBH20Z8R+sQ0myD+Z/0fx6Fm/IKa25cgY5z7TsiGmi9g6HLgXG0mMC8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104060; c=relaxed/simple;
	bh=FOfsYnShqbSkumodlbzQ9ZCqG21+RqfCp7zkPUmlpuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7wg5HB56Yw8yi4QwlWBc7KzSCn+tV1fN8zvE7RheFT6wCcNUouheSdQvi165Mpn/4cXZBtmoIjTObFCxRdDSnp7oZAKxo/W6zsIb+/J8Lz0+sL6ZgItZEqtIQP7zavOmhf03pGzHoYfyTVjclYQNY3DcDq743RIA6L9xb5bam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AngtT0LM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0299DC4CED1;
	Fri, 21 Feb 2025 02:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740104060;
	bh=FOfsYnShqbSkumodlbzQ9ZCqG21+RqfCp7zkPUmlpuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AngtT0LMs/1+VOaffnxsi59q3ro2EBEpvAWJVYCtAFMN38Od0WOwayrkuKhaXC0FE
	 ku0oRgtOlqPr9yTx8DR+Shb4uh/VVw3t7UpUEL5Xi3ozeLwBg+aiDxgLdmXCJA/rM1
	 km/AT1YOulMLp6HLOzIcmoxMTN95doqZBAP08XuJOnD7iVo/pVSxkMXVa+c0uClhP1
	 /Cq+CWlsEzYo5R3o84ecto3mkYDdTOTrgJqrzqZng0bzy5612pVZFLs8tpCmg/Gexm
	 4kqMu+BmWisi6bp7uQZxjBV5qCq4P6S9vJ08SlLEbRzDewVPGeXGqqruNanxcSn8nt
	 oliyUdz5VH3HQ==
Date: Thu, 20 Feb 2025 18:14:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 7/8] net: selftests: Add selftests sets with
 fixed speed
Message-ID: <20250220181419.54155bd0@kernel.org>
In-Reply-To: <20250219194213.10448-8-gerhard@engleder-embedded.com>
References: <20250219194213.10448-1-gerhard@engleder-embedded.com>
	<20250219194213.10448-8-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 20:42:12 +0100 Gerhard Engleder wrote:
> Add PHY loopback selftest sets with fixed 100 Mbps and 1000 Mbps speed.

Maybe an obvious question, maybe I'm missing something - but how 
is this going to scale? We have 120-ish link modes.


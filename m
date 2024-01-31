Return-Path: <netdev+bounces-67400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5A6843328
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 03:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9AF1F26D6C
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 02:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC41522A;
	Wed, 31 Jan 2024 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGxaNdjJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A35227
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667061; cv=none; b=WkSavchJP06aaCfrzr8Xt8YCCa0f+IM9Eb4f1xBkJ6wROFQ1zkpc9+Y/vNaZvtGILMWAQU5VB1x58fXjStRKhzdCakx7kROfGb2U6hyOqRRqu4GQPsX69GicJ1utW7ufFcHE31YDmHo8dQtGdPWuEbcGm8Dzx9DxeR3PydpwuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667061; c=relaxed/simple;
	bh=vSwmkPa7rc8q00L/39+bR76EUYlaZEGlJFWyizX5a1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNrUB/FCH4K2KhxrWrPDHhwQDJuzBBMgY6/5oAc6TmKi8SUmP+nb0IfkZtKhKY25wxrUjeYg1xgoVTJh5Ctg6J0Xp9JnNdyhaUqtO/gOmQpFgXZ9GQgHNV77qPybJeJZ606kuDxJ6F1Jjtlfe07dwVMj/8cNR6S4AzR86TXjybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGxaNdjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA35C433F1;
	Wed, 31 Jan 2024 02:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706667061;
	bh=vSwmkPa7rc8q00L/39+bR76EUYlaZEGlJFWyizX5a1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hGxaNdjJNCOeDs6d6AcPykL6qUwC4+TvgIlIODMtj0nGouOwCh7r8LPkOS8dChzVE
	 DNK2FqVsLxEqY/IyjgQy6rUSyhLxE5C9ypdDZ0pr2zOnQXIQYH/TbhZJKLqS0blHiK
	 LINDb5EQP2vlHd1+8I5LenTBJeUL12RQgrN1igi4xdYELzmgjByl3bWWP5PgoyAcUz
	 HDmuDZwHROvep1GFVgBzagyxKE39wNYLgpi8HgjFTdv0F4qJ63Ne+TICfcM0m1nDJo
	 ox1wXoc8CaVI7ksphI5seMnR0x1AgP2sVnw9p98dcaX0LwbdZG4k/CKchLW64ci6BY
	 fTHjNXNPDK4Dw==
Date: Tue, 30 Jan 2024 18:10:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 fancer.lancer@gmail.com, Jose.Abreu@synopsys.com, chenhuacai@loongson.cn,
 linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 00/11] stmmac: Add Loongson platform support
Message-ID: <20240130181056.42944840@kernel.org>
In-Reply-To: <cover.1706601050.git.siyanteng@loongson.cn>
References: <cover.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 16:43:20 +0800 Yanteng Si wrote:
> * The biggest change is according to Serge's comment in the previous
>   edition:

Looks like there's a trivial build issue here:

ERROR: modpost: "dwmac1000_dma_ops"
[drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.ko] undefined!

Please wait for Serge's review before posting v9.
-- 
pw-bot: cr


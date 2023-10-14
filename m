Return-Path: <netdev+bounces-40937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DDC7C920B
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 03:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97B41C209B2
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45181EC5;
	Sat, 14 Oct 2023 01:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNoygbMP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E377E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 01:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED41C433C7;
	Sat, 14 Oct 2023 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697245987;
	bh=n50kcxXI9A3yMV6jxB8NrEwZdjVrYAXqsMjPwBDWtY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rNoygbMPeUIwtR64hZ7Q9YWWviszucUMdTDI1AIStFs/rvaOC69pt3n9quzesBklA
	 QSAIC1b1su7cYyKrsjrSTAbSJNA4+Eq/7vBX5pRwX8JuEkD1u442a7Qz3sYL+tVjH6
	 DtAOwHRgKy++OtzgwGKsxXIbNu+45VYfWHcjhYJQ3c4tcxjIq82FPKlNLawkVoEGyY
	 cl9plrQrT7vQesR4b8c1y7wnQKg5AQQmi5XkP4EyaDQ0pLKwAM/TShTPymf0aWp0Q8
	 x+qbRJu+c+B0N/m1qoJ5lnrHiHRS12f5N8pv67DNwUMkG+F1sdMpEoX2V6CcSyIQ8c
	 9HlJizg1+GI/w==
Date: Fri, 13 Oct 2023 18:13:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Raju Rangoju <rajur@chelsio.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose
 Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>, Simon
 Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri
 Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/4] net: stmmac: move TX timer arm after
 DMA enable
Message-ID: <20231013181305.605fc789@kernel.org>
In-Reply-To: <20231012100459.6158-4-ansuelsmth@gmail.com>
References: <20231012100459.6158-1-ansuelsmth@gmail.com>
	<20231012100459.6158-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 12:04:58 +0200 Christian Marangi wrote:
> +static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue

missing comma at the end, does not build :(
-- 
pw-bot: cr


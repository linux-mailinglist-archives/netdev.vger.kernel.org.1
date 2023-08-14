Return-Path: <netdev+bounces-27528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9AB77C406
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 01:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02442812DF
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB216C140;
	Mon, 14 Aug 2023 23:45:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530E8BEB
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE307C433C7;
	Mon, 14 Aug 2023 23:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692056748;
	bh=7WY5/jjo3v37KPDKPy5xuOgmTghpkqmD80Dxn/A2OIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iqBcKMhoiRXSftTqrbpadPDKuoYY967yhV/gW5p+mW2BPaJd83NA5C5rMLt80GaJc
	 s75ZX6g5WmgznYYQUGCbpiL8kKhASdAZ5B6NTcYSmg7hLtxDk87aqggNr9J8IKQShc
	 s5QTnl4uWElfBBKS9YASvt1kXDm5JdPosmIJd1G5ARyZ4lSXcGuZaWK4A7blZuYiKO
	 K41Q88FvZXVEb59Wexzho0ilL2nYve9ZRokziuKJZu22uDtSbrJWWK5VitWThimgNn
	 1CaOfFPe8h6DjCBgjyQuO1CEWTFI8dAog9LNZqNYXTBKBeMmL/o6pVBYuhzGZRMSTl
	 0pfM73+uhHdOg==
Date: Mon, 14 Aug 2023 16:45:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2023-08-11
Message-ID: <20230814164546.71dbc695@kernel.org>
In-Reply-To: <20230811192256.1988031-1-luiz.dentz@gmail.com>
References: <20230811192256.1988031-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 12:22:56 -0700 Luiz Augusto von Dentz wrote:
> bluetooth-next pull request for net-next:
> 
>  - Add new VID/PID for Mediatek MT7922
>  - Add support multiple BIS/BIG
>  - Add support for Intel Gale Peak
>  - Add support for Qualcomm WCN3988
>  - Add support for BT_PKT_STATUS for ISO sockets
>  - Various fixes for experimental ISO support
>  - Load FW v2 for RTL8852C
>  - Add support for NXP AW693 chipset
>  - Add support for Mediatek MT2925

As indicated by Stephen's complaint about lack of an SoB tag,
it appears that DaveM merged this PR over the weekend :)


Return-Path: <netdev+bounces-43663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780777D42EF
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 00:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349A92812B7
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5602623760;
	Mon, 23 Oct 2023 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgnpWAfj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636522EEA
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 22:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6F6C433C7;
	Mon, 23 Oct 2023 22:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698101855;
	bh=NcFO0RoHUI+tZkl2xCEXAu6+IITo6KXxRTe4jKHtsTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hgnpWAfjhxvX5UBP+WI13CdgaGFP82cPC78j3yqGRdipmpjOBEAsEqTb9owNkXmxv
	 nFM18PcvkMKX1n5DwCqsUFRVlFqEeH2dKVYMdZnocmCroE9IxvSXQHstIAtH1r8aCb
	 QAFDQNO5dANLZegH3PZK/WLDYbgT7RyeIY8k1idWWIBBo6ZD8Q/vdgcNoZbRL8mXGu
	 yvJgcmBD90dQPCXwmvsp6kVeEkPyvchXiWp//Ag7cHEyDYBhXHd8OvTdj6pUfOc8DR
	 tnVYC859JfQWBL9OIhvrWjqN+EFAshU8AS1iZKDWyd/jTAHUqZCdlbsSLhdYJrTW8p
	 lDRzfVjaEKUkw==
Date: Mon, 23 Oct 2023 15:57:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 0/2] Intel Wired LAN Driver Updates
 2023-10-19 (idpf)
Message-ID: <20231023155734.6b8d08e2@kernel.org>
In-Reply-To: <20231023202655.173369-1-jacob.e.keller@intel.com>
References: <20231023202655.173369-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 13:26:53 -0700 Jacob Keller wrote:
> Changes since v1:
> * Corrected subject line

The bot guessed correctly, no need to repost for such minutiae unless
explicitly asked.


Return-Path: <netdev+bounces-189769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6FBAB39CD
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6123E17A707
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD3F1DACA1;
	Mon, 12 May 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTl6wDXp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DD381720;
	Mon, 12 May 2025 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058224; cv=none; b=n38aEBfO9L5Ee2KmD9vaZpqXVbEA6ShDADUGl1LP1VnRt9TAy3vhFep415xfY9aBej7RJJpWWVMdLBdy88vnuO1gZ4a78p3aT5Wf2Z0/IPPppxcJzXmIWo1cAIt14Ihv5fT9dDaor/ysd7r624AgMXtkjDMtPKhmp9jp1VPOuec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058224; c=relaxed/simple;
	bh=G8AvTGDvjUqGmVdkJjxgWL171ZtkhUf5o1ad9gnZTfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auJHZ+ebMCvrkS5hMeYml+rUpcHxTSnAzYqYBcRH7Pog0qPXSOI4gu7sAJbRpklGT3nNzLKfmTaAl+ulouM/MkxPzOtn7y5j+Kgn6zh0ogwVhVvZE4BMWmaPCk1foIaVq7mmU8F8AYh4OpOBCcZpypLj31mwRkL+JrmOj/XL8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTl6wDXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08BAC4CEE7;
	Mon, 12 May 2025 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747058223;
	bh=G8AvTGDvjUqGmVdkJjxgWL171ZtkhUf5o1ad9gnZTfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTl6wDXpZQ4vWQTDNDze2zuklIsc31wMGtaMHWllCfkgpFtn7A+id2QcKT+4lp7rq
	 dxyHvUoHMsgfXF7XZYg7PoA2Isjqp4S8hGH0nMsckAK4SQ//xABEpUvK6OqinQ6kxh
	 1/rpNzxaVwxHGVRNqHB6QM1jdIGD9BLXoYV5K0/I7zfCcUn/rOJ8DHpWPn0KxcsqPh
	 P1Qm/13O4r//RKPr0S3mCD9y8cFaO2dgZ2VeeEfyK0rRuFCEsgRm8p/qysJsP+FIUb
	 QbVvWzwYXoFSyfG/3FMzH2iTyD2w4k+k1pOkhmI3O8eTozkMc7+zuwlDTpypACBc/B
	 OD+vsyUtP/QQQ==
Date: Mon, 12 May 2025 14:56:59 +0100
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net-next v3 5/5] amd-xgbe: add support for new pci device
 id 0x1641
Message-ID: <20250512135659.GH3339421@horms.kernel.org>
References: <20250509155325.720499-1-Raju.Rangoju@amd.com>
 <20250509155325.720499-6-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509155325.720499-6-Raju.Rangoju@amd.com>

On Fri, May 09, 2025 at 09:23:25PM +0530, Raju Rangoju wrote:
> Add support for new pci device id 0x1641 to register
> Renoir device with PCIe.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
> Changes since v2:
> - use the correct device name Renoir instead of Crater

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <netdev+bounces-148260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAB09E0F65
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 00:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE641653FA
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 23:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E771DFE15;
	Mon,  2 Dec 2024 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JADszn2g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC61DFE08;
	Mon,  2 Dec 2024 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733183364; cv=none; b=lR2G/INV8rn/LuFEXnxhCxZGw5l8T82aZW13BYUujzDTrxEZ/fVNwbbpjXW/epgHsFALLQqnNuu6b3hmKNcUQM8ijAKPEL4dxmC3XkKaRDEx6KV9BxDIqCkE+P1u2+4xTdTcF+6ZnX4oq3RG+8cGqCJ+X7d3O2V8iB7UC7NrKm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733183364; c=relaxed/simple;
	bh=FCFwNBxV/SVvxKxgaD3PTa1CKJKgeRB7C0C5ytlAONA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=or/AIffGmo5yh7ZUFyMbq+skctWrtr9N2GXTAM8XJwfQ1iP4bhIKIIcQIC5KL0c3F6DLkB15f1rElNvwUEo7ItLxbvVjpEmA7tD5MkQTMoVoDfQoVFIpA/z0Pl+1x1pYp/kLhMDwOh3O4BvtyMBgLOXQObm2VuLP43FTRGs475g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JADszn2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2831C4CED9;
	Mon,  2 Dec 2024 23:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733183364;
	bh=FCFwNBxV/SVvxKxgaD3PTa1CKJKgeRB7C0C5ytlAONA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JADszn2gNDQe/7tvQhKve7P0gMYOG3ziNZGMoFbI7O149K8rHgdS13hhO/xkWvfwW
	 IfsoxVWXKJj1hzpybp8eNCBhyF//ip51SMENhCH4eV7CiPBPxi3oKPtxNdInQfY1/h
	 DxjSiD8RiJa9rmnkdFewaiduIIh9oBNaKfl+qpQh48bIPSSPAIU2qUmB24c+h9vdGu
	 KqMJIKx1PYWgng7DLAsAdChg+Bixsvc/3jIi4vbTj8I0CJ1ZQvKIHAbXZaMi5tyt7g
	 gZVWPm9WuJVTNIcsViJXUKWs0C2171M/dEmg18A7G34yX2TcgTbPYMzv8os5JVagGf
	 nX+q9/KbWkvKg==
Date: Mon, 2 Dec 2024 15:49:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Patrick Williams
 <patrick@stwcx.xyz>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH] Revert "net/ncsi: change from ndo_set_mac_address to
 dev_set_mac_address"
Message-ID: <20241202154922.0644c7a9@kernel.org>
In-Reply-To: <20241129-potin-revert-ncsi-set-mac-addr-v1-1-94ea2cb596af@gmail.com>
References: <20241129-potin-revert-ncsi-set-mac-addr-v1-1-94ea2cb596af@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 17:12:56 +0800 Potin Lai wrote:
> This reverts commit 790071347a0a1a89e618eedcd51c687ea783aeb3.
> 
> We are seeing kernel panic when enabling two NCSI interfaces at same
> time. It looks like mutex lock is being used in softirq caused the
> issue.

I agree with Andrew that revert makes sense. On top of his suggestions
please add a correctly formatted Fixes tag and make sure you CC the
authors of the buggy change, and post a v2.
-- 
pw-bot: cr


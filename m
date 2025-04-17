Return-Path: <netdev+bounces-183567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511B3A9110E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9F15A3301
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF8185626;
	Thu, 17 Apr 2025 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUH7kI69"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083EB184E
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744852771; cv=none; b=NTkCdghu6OyL1BvuI679RobYAM7H9VxamJvrPZVrtBhO4dpFaQSqfyvcsr/dM+xEqbARRU5uAVIHlvp5RUapyuszXbLYjr8fzwLVUTUEcCd9HdJcYRvXMDwwmlaqONYuTLn64u316I70yB+dJe4E4lXHAttFPbqbSZUw0XkXiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744852771; c=relaxed/simple;
	bh=+pxe+9t/iQeoYajYeFN6hSydVFKNS3Ia++uXhFB6+NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LymOiu/B2th6EGEa27bYUjcHHyzmDHloAj/D5zmurvxQGhBa+7ldICoi1DCU31yCoPvZ/MsF+S7trelMLCHNPt8OQ8I5pUALTdpcFU3wxYM5XS1GYMsS3hZifF1uKir1p49bXB1CJPEy0v3Fgytpzh4pfZraJOrtwl1YqIep82M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUH7kI69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD625C4CEE2;
	Thu, 17 Apr 2025 01:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744852770;
	bh=+pxe+9t/iQeoYajYeFN6hSydVFKNS3Ia++uXhFB6+NQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nUH7kI69n8f3PJwAphXVN3x3XrjT/N9n2oZojuU9ov/ma144v1AYv1U5hmC3gNZp4
	 j7JiunDx6bDxw3PAGTtcN7hlyb9UKjHcW3jXVWYOL7MYJVDeJzk8kFKePueBo1svcC
	 MuJsPNCtD+l49BRCFkt+ore3FkUhXvUNkIyhRqleqA+AJ57L7TMLd8VFiGsQe54f8k
	 ucge92m1K8E9tCHyYo8aPmtau8Qgo1XbSxi0ArmJFLIUIyIuEC80kPQ8S5JIq7E9vl
	 CeaRk5H/qgHIto+hgbjhocW2MGpmv3tWhboaZgIctwSgoVZLUJtqAkFkzGleptatfa
	 Pquob2AKSuEWg==
Date: Wed, 16 Apr 2025 18:19:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 netdev@vger.kernel.org, dw@davidwei.uk, kuniyu@amazon.com, sdf@fomichev.me,
 ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 hongguang.gao@broadcom.com, Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH v3 net-next] eth: bnxt: add support rx side device
 memory TCP
Message-ID: <20250416181929.4846a2ee@kernel.org>
In-Reply-To: <20250415052458.1260575-1-ap420073@gmail.com>
References: <20250415052458.1260575-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 05:24:58 +0000 Taehee Yoo wrote:
>  - Fix wrong truesize for netmem API.

Actually I was wrong about this one BNXT_RX_PAGE_SIZE the way
you had it was correct. I'll change it back when applying.

Thanks for doing this work!


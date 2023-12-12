Return-Path: <netdev+bounces-56599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C2E80F948
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67505B20EED
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1903B63C0F;
	Tue, 12 Dec 2023 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flRSOrwL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5065A9E
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 21:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA31C433C8;
	Tue, 12 Dec 2023 21:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702416398;
	bh=7MZqk1hNPj7r4egGXbPOB+Rztv8D/+/C7L1c9OmJaNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=flRSOrwLQ6Kc4Jr7ORRXvJ9GkwBbbqmpb4qM7hK2Pq5Mo+ix+PgPwknWPbsyLrJk5
	 ATqdQHydWfdFqN7c1//tDtxjet1++b4i1v5AH8a+DDpq4uEldVokQHHzyzTEu4snaE
	 PHEte5nKs1RG9Td3XkE5pZDvwXd0Al1n19rkQeezl55Mbx636qHNcj2XAigiLYP5I1
	 8nZMz9R8VtlS6dMY91F5MT1dyZv+mBHsFOeajqHZy8Z6jSX/NyTnzzkn1GuOQEALCY
	 ujUJz7wtIS2l3TqBZ3cA72Q3XKBddfCGVKWrrvtxdIiQR7WlXf2k+1Tju5sYYLA2Mm
	 J5FjKLntIkB8w==
Date: Tue, 12 Dec 2023 13:26:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH] igb: Add null pointer check to igb_set_fw_version
Message-ID: <20231212132637.1b0fb8aa@kernel.org>
In-Reply-To: <20231211031336.235634-1-chentao@kylinos.cn>
References: <20231211031336.235634-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 11:13:36 +0800 Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fixes: 1978d3ead82c ("intel: fix string truncation warnings")
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

The allocation is rather pointless here.
Can you convert this code to use snprintf() instead?
-- 
pw-bot: cr


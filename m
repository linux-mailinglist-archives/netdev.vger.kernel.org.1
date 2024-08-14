Return-Path: <netdev+bounces-118258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF2F95117D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 03:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4FAFB21028
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 01:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D38B849C;
	Wed, 14 Aug 2024 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti/6ZhXB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B6A1643A
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723598230; cv=none; b=ESJfWooT0CH8fblg/C500bZhs6ipC0sl6N0noHgi9eYqzOTYUJ6iRL2B/oWUB8TZbG2QYuhN6utd9e0m6K/odjsNu0VX0nlFqY8pCsSa9LLfH7/z9nd1lLw1S33JX6wXDW76MvnNDYQjaFAEwIUjYofXT3Bm08tzQF5nMpcQRW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723598230; c=relaxed/simple;
	bh=25lxe6DuewNQxj8dikMK5KLifrMkjcmQaS4UBnFYRG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDY2h0UTxr1VwQWV+wAvAnYZqNvzMUNOJ6X0bbpMsw+erGTz4t/PnxzgI/jMVaLeP1pA4fzdkGUzOfe+jTCCWBDiwr8Iv4qb8cE/2vX3h/ORyoxElKTohhvzpTFmbzuUE4tkHBQErw54tdKZ2cykoXGyku73qm0aAGIRl9IqEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti/6ZhXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AB1C32782;
	Wed, 14 Aug 2024 01:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723598230;
	bh=25lxe6DuewNQxj8dikMK5KLifrMkjcmQaS4UBnFYRG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ti/6ZhXBYkn5QvgIzwE80NeUzt4EuoIWufl9aFiPnRZmetDWJAZN/cg3IC+RsuXwv
	 3EDaSzLkYbWzVhZqMu0X5EX52w8dYbW8XXOMsVo+E/KjnBmnROr3O28Xv/j4jADc3G
	 3ys8O20EPXLpzVe4/LdJyWfkW5OOrOS78KlVUqKi+7t/1S8Z9KipPOzKe35YBaAYXJ
	 WDyVTXtjOJPrHBXO9r3uTCxG7itpsOkz3oIkWci177WMtvUplRbuh7ZGoBa9Y7ZMvw
	 7h6mAsS3Ki3cpCqPckgHZOQhgfov0HT2rz6w3+fEz9mxsq1x0gSkoOxYEO+QC6Oae/
	 yj7vnHyIDzs7Q==
Date: Tue, 13 Aug 2024 18:17:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Michael Chan <michael.chan@broadcom.com>, David Wei <dw@davidwei.uk>,
 Somnath Kotur <somnath.kotur@broadcom.com>, Mina Almasry
 <almasrymina@google.com>, Netdev <netdev@vger.kernel.org>
Subject: Re: Question about TPA/HDS feature of bnxt_en
Message-ID: <20240813181708.5ff6f5de@kernel.org>
In-Reply-To: <CAMArcTXtKGp24EAd6xUva0x=81agVcNkm9rMos+CdEh6V_Ae4g@mail.gmail.com>
References: <CAMArcTXtKGp24EAd6xUva0x=81agVcNkm9rMos+CdEh6V_Ae4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 19:42:51 +0900 Taehee Yoo wrote:
> Hi,
> I'm currently testing the device memory TCP feature with the bnxt_en
> driver because Broadcom NICs support TPA/HDS, which is a mandatory
> feature for the devmem TCP.
> But it doesn't work for short-sized packets(under 300?)
> So, the devmem TCP stops or errors out if it receives non-header-splitted skb.
> 
> I hope the bnxt_en driver or firmware has options that force TPA to
> work for short-sized packets.
> So, Can I get any condition information on TPA?

I don't have any non-public info but look around the driver for
rx_copy_thresh, it seems to be sent to FW. I wonder if setting
it to 1 or 0 would work. Especially this:

static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
...
		req->hds_threshold = cpu_to_le16(bp->rx_copy_thresh);


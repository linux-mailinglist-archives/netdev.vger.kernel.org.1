Return-Path: <netdev+bounces-247946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DF4D00BD1
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE9BC300DA79
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175C22DA1C;
	Thu,  8 Jan 2026 02:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIZi2nkw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271C275AFD
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767840970; cv=none; b=cuAAcmk6Yh3Ce4YqLt2ilppyIxtEuTocGLt9+YdKsGNdeB6Dx0nIJHKeMAeGp+wzwuDrIt10QJrcMr5Sg6/bwH+6UlZcOo+QBqebgykt1Ur8oLRTZ8ezYbkZeT6riOzWCpltAYoJXcPmAt2XxEnz2gg+IiLZ53+g9Uez5Fkem4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767840970; c=relaxed/simple;
	bh=/TJ1sfsXKznY/W++l1f7xuIMx6lahvZwfzkhqvwSLxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVPIrvVEDH1l24GDDKxyv1jWaWIhcvdu8Y/JhoFGviZCShLrhBbjkNEMEhIUTkQBObkOeY0p5IqpHQ4b+3r2VKEL2dDGWuwXfIDA9Bqqnf2tcCjDHxNJjNpyOaRn0AlHPtOoUFueRm7O80CbyFboBzhokk495csKbvKeJOy4pCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIZi2nkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BA7C4CEF1;
	Thu,  8 Jan 2026 02:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767840967;
	bh=/TJ1sfsXKznY/W++l1f7xuIMx6lahvZwfzkhqvwSLxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JIZi2nkwxhe3yadpMdX6t5aMOYvCLPSH3npBi/tWAkM0weg64WEBT59t+R3Cb2AUZ
	 QGuaHw6IK/ZirH2GAnqcs4PC8kEgAN0b+hTx0D+5RAj78MIgoFh7PKjODZqy4uewsp
	 g9cEaHeyJTmft/CkJlzYrqmhHVsteqHxxJCzLKIFxl0IOViSGHQlpuhWRglyqh7qMN
	 zmOolMiNQZ/YVDpbRQVrD3nuHcw//aGr87DaUVAAvNPJ0nlfuZ29+nrpEs2W1o4aJz
	 fjMrgKrRnXj0dYWdOQiWbdAjXBuCiAyl4sSUXDw64zN0wiZWPEmVrCznaaOphbOQ7Y
	 jlM/t12X8sShg==
Date: Wed, 7 Jan 2026 18:56:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ibm: emac: remove unused emac_link_differs
 function
Message-ID: <20260107185605.7932173f@kernel.org>
In-Reply-To: <20260107073601.40829-1-enelsonmoore@gmail.com>
References: <20260107073601.40829-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 23:36:01 -0800 Ethan Nelson-Moore wrote:
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

missing commit message, but also:

$ git grep '#if 0' -- drivers/net/ net/ | wc -l
136

Let's not "clean up" ancient code.
Let's wait until we can remove it completely (like you're attempting
with atp)
-- 
pw-bot: cr


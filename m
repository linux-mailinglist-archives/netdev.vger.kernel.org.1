Return-Path: <netdev+bounces-133756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12590996F7B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720A7B25C7D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97DE1E32CE;
	Wed,  9 Oct 2024 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIYR4HW8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552C1E284C
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486574; cv=none; b=kiNcXLPPA+eRS9iPE5tv2hJZRS0FQDnwxOQ4aQo4bbNtsApoPaU1CMi8EWvq3O/NFpAMnft1sg5jbUbohl7EnSBPPL2y24PdOg0xtCyBr1wFuRyMLdfKFWvUU2ifpNsjWGWG0EvIrdDdUEpiSfzRAc3Exlqlv2UIj7NICMfQOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486574; c=relaxed/simple;
	bh=bkvOoyIWbMZJXy0HOxpPw+w5wUFrWVCUDkRPcLSVvr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDZIm6oZYlZpcbHyZmrXCT5fyke0d1uSiA1LW15oEisPq/C5J7K0wXolDsDn4gCulmcgJUQFxYIMd2S7ndkVUEPu0nkJyRLSKDh6qh0T3vd9d7Yejp0nU6I1aA15LfeaNPSpCndfDRY5rGqaUASyGEd+Zjd75oyPnrZf0RCL0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIYR4HW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08413C4CECF;
	Wed,  9 Oct 2024 15:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728486574;
	bh=bkvOoyIWbMZJXy0HOxpPw+w5wUFrWVCUDkRPcLSVvr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OIYR4HW8RdNHwL0nLKRL4r7Q6gjtJRLtB7tqDNk3YIACLdnNyc86LMOVRXJFVx6M2
	 d1O+jyBxrEGbPsha8KnTdcWvxAajIT5e264yJuosXlI0PSWfUYkbJ7PEN+ehxI6rCn
	 tO+2BfYvQnBpFJ1a2gOFMq2ZUo111zlKDU0CRZuzluJRI3Mpb7tzphNuZTtGcnylmX
	 +ezrTCemJ4gX4GMKoS3EZRQHutNKi882/oKlxAIdPQQVEq2v5PxP+hLJwvNF1lSBSR
	 j2t2Jv/52hjOWT+JeSjdP1JQNGxGXd1axFxuOysz7aB3HUVsATAmomssuDTtcNmY7m
	 Q5qbZ0qJVuZKQ==
Date: Wed, 9 Oct 2024 08:09:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, konstantin@linuxfoundation.org
Subject: Re: [PATCH net] MAINTAINERS: remove Yisen Zhuang from HISILICON
 NETWORK drivers
Message-ID: <20241009080933.7feca424@kernel.org>
In-Reply-To: <20241009121904.GN99782@kernel.org>
References: <20241008153711.1444085-1-kuba@kernel.org>
	<20241009121904.GN99782@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 13:19:04 +0100 Simon Horman wrote:
> On Tue, Oct 08, 2024 at 08:37:11AM -0700, Jakub Kicinski wrote:
> > Konstantin reported that the email address bounces.
> > Delete it, git logs show a single contribution from this person.
> > 
> > Link: https://lore.kernel.org/20240924-muscular-wise-stingray-dce77b@lemur
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Hi Jakub,
> 
> I agree with this fix, but maybe this patch could be considered instead?

Indeed, I realized late and discarded this from PW. 
I should have commented on the list when I did so, sorry.


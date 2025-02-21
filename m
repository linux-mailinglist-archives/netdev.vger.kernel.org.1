Return-Path: <netdev+bounces-168365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBB9A3EA93
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 03:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F86270092F
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88A519D087;
	Fri, 21 Feb 2025 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBNYQIic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B446F1482F2
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740103843; cv=none; b=PwRn9AK1tnxSqHo+amU4PQ5XiCGWWoZwYNMOTrlUFOPEHirnZacew9ZuwkM/6RZcBabJjaUpRXyDDeSnxTxt4X8tr96Pa7Fbi8idoEET89G3W58ssrlGfcuUuQjMpc9q4hgmahTn6Lhsvz+Fama5GfjAn+TpBHsds5JyFTsMMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740103843; c=relaxed/simple;
	bh=YW8b1x3oiRTJm1fFXj6OMDrDy6qHljBjDYcke1m1sak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LME2NA5rx4sT0Tv84QNlHsgZ8gs9k7R11fT9SRBmKKwDnL4Jk2rOVFl8p5eOEFNEvPsGcbytZVoS/fr5THDLFvd66Hz/xWSg5vDJK19vDu8JOCzSwRK6RktyJ/MK0PFAP3N5xhpNGoG3weRDJ4f80vLC+kEB/smsZ009SZtkJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBNYQIic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260B0C4CED1;
	Fri, 21 Feb 2025 02:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740103843;
	bh=YW8b1x3oiRTJm1fFXj6OMDrDy6qHljBjDYcke1m1sak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dBNYQIicLC6M6Z/kHJmR/75iwosc2A8pnSYVlF3gvXp+p1LHEy2lkAg7FSZmcH0Op
	 pOzWcdtSfOlWRSamE9+lFg/HfSFaLyJTgkkFuUl0cuH4+8/xO9vk0/Pc192VQe4Xme
	 3SCoVPgoIO1SXDvd4Z7WouFfp+gySrPAHPkanA/WHH/FWlRySYaRsnmnY1a8hkf1R5
	 Lndg6lZMVRMuvh4YpyTRGd6r7Gc93JY6G8PQWvCoKeG7U0sWcKkBeXC14REp4n5UdV
	 dYoT/0ny6NVzulwItnfLyGlYNJnrpsZgrQJLBaFVazu3lAEu8G4ofFqN1skroxeWyM
	 BfSh0wF94NuPg==
Date: Thu, 20 Feb 2025 18:10:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v7 6/8] net: selftests: Support selftest sets
Message-ID: <20250220181042.0abe4ea0@kernel.org>
In-Reply-To: <20250219194213.10448-7-gerhard@engleder-embedded.com>
References: <20250219194213.10448-1-gerhard@engleder-embedded.com>
	<20250219194213.10448-7-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 20:42:11 +0100 Gerhard Engleder wrote:
> + * @NET_SELFTEST_CARRIER: Loopback tests based on carrier speed
> + */
> +enum net_selftest_set {
> +	NET_TEST_LOOPBACK_CARRIER = 0,

names doesn't match
-- 
pw-bot: cr


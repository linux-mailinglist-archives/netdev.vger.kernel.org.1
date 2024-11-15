Return-Path: <netdev+bounces-145510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F25829CFB1A
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0F01F2322A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92981991DD;
	Fri, 15 Nov 2024 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsBQQmMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007F192B76;
	Fri, 15 Nov 2024 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731712971; cv=none; b=X/4ouXiJp5zP4ISNRaXze7Twtg9ESqwtpml22T6A4AHMRgMP0jfqSnB8sUfgJRpUEhGi2+saPe5HGdlr6OQ9AUH7mJztljYrZQnRxinolPaTJgXKcnJHjpNI39IvW8rzKhMtwbECDU5oKQqQrf18Jojk5QazKyPHGQ4tUujam58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731712971; c=relaxed/simple;
	bh=/VNchZ0z8rF2jN9XWiiiWTCm89iZb+fOgWyID2Eb73U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGPqGS8AkFD4Gjc3Jbu2kZGameCBYTPv7quhwNVW+Zyy6oOnnLbOz+QwJ6DX+f5AsJiimhwoVIMgxrdsk29+lQNi4Q8GAQQBZrPVPlOjpNZX8fY7KbH7+ulDwLnyLPph82J09InDja/R79N/nnVusw9p1B2lqDozxTnuu1Ux+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsBQQmMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF55DC4CECF;
	Fri, 15 Nov 2024 23:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731712971;
	bh=/VNchZ0z8rF2jN9XWiiiWTCm89iZb+fOgWyID2Eb73U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dsBQQmMwKasVzBHbrLp5MX6i/bihH1+EEBUuvUw7rihSRWKvHNww5Ds4p1hQvyKuF
	 MsAflF68XpUvWh+OvvhvavVJZIxWVeLG2pnHCflJUVaenBmkvPBRiLB1KUPcSCcUrH
	 xIFw2HteoF9p1hw0UrJCDkPJEAA9vL9gt/2fGYQAyIdH2AMXYhyLfsOBDnsnrO79yP
	 hHTIQFnxGdD9Ew4HFTOD+JADvyL1dZJCm5vUP++qTeS5NE8Y6vPfIO85++wiljmjdG
	 nK3PgzZHwjilgDhoFzWNQTvM1qVztCM0YUOCIjeKme70RxRyRhKeOZgrjDvtB/inSB
	 eshqAt1jXIdVw==
Date: Fri, 15 Nov 2024 15:22:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <lcherian@marvell.com>,
 <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
 <andrew+netdev@lunn.ch>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v3 0/6] CN20K silicon with mbox support
Message-ID: <20241115152250.2ecec8a6@kernel.org>
In-Reply-To: <20241112185326.819546-1-saikrishnag@marvell.com>
References: <20241112185326.819546-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 00:23:20 +0530 Sai Krishna wrote:
> CN20K is the next generation silicon in the Octeon series with various
> improvements and new features.

does not apply cleanly please respin
-- 
pw-bot: cr


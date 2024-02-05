Return-Path: <netdev+bounces-69168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DE2849E52
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 16:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8624EB282CE
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03852D78A;
	Mon,  5 Feb 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK7+NpQC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB3405FF
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147172; cv=none; b=YevS69WRU9BwHxdBms5O1Ah5nqeXfvDK7cFOJDoFakrBtvnd6CqSzgZQhjOSUALM16GM0oNRLJKgFJNyvwaBM450f5pXwzI6zBgR6YvUH7j4nMdmbWwkiIy+hlfv4jLtEKUZ6whIMhTUI6nQWGiOBmm3wH8zvJvN1Oy07xKGfok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147172; c=relaxed/simple;
	bh=hVUhrs3ub6uwc3pI6GUV9AT9xdpgHCN3K2Q2RI+qTtU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmWlgajyDqZF+ObW5IjRoqPDhME3SiJmnjzc9MgruhrT9p9LMAZfMld+fHcx5Z0LOUBGGN0TKQ/nAzBqd0wNqmWCSelx2nKL69fehcewLq6TxKTCMbf50e0VU7lVap1lgYKemHahmlMYx58zSwttvBH5UR8wJ3AFp4hLnygiqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK7+NpQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1419DC43390;
	Mon,  5 Feb 2024 15:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707147172;
	bh=hVUhrs3ub6uwc3pI6GUV9AT9xdpgHCN3K2Q2RI+qTtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XK7+NpQCmMRytuEmgl3BK1txRCYqAvdOCp3Z6WclhLZQQfSJwsz9pBOeacR76XS5s
	 ymv0FyaOCbVSeFguO7XJEDY1bR2VRXB5LpgFULw5wVzcfjqws3sRKwWJ6P2WCsn29O
	 TtM7HPCKFmebALbcI/Ge1FQsrkxAapuToqaHL7CjXCAiwneddY8DUDafeHOOhHLR4l
	 w1uqhjAR7klqsZGTw1xgbuyRdy+QLVwQIYqdxbji0iWfv+oIaOlcGBSyRFaj0YeeXi
	 rgT5OflxE5ayD41JON2LPk5RGYSbrmRpeA/9A6og0b0h4r1bskhOAd3bcGX1p0edBB
	 amaamHRWWDHZg==
Date: Mon, 5 Feb 2024 07:32:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v8 4/4] netdevsim: add Makefile for selftests
Message-ID: <20240205073251.65702b7e@kernel.org>
In-Reply-To: <20240130214620.3722189-5-dw@davidwei.uk>
References: <20240130214620.3722189-1-dw@davidwei.uk>
	<20240130214620.3722189-5-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 13:46:20 -0800 David Wei wrote:
> Add a Makefile for netdevsim selftests and add selftests path to
> MAINTAINERS
> 
> Signed-off-by: David Wei <dw@davidwei.uk>

Hi David! I'll apply this already. I have to move the current
CI runner for nsim because $$$, and making it more uniform
simplifies things.


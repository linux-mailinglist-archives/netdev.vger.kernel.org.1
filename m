Return-Path: <netdev+bounces-50966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4787F8591
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 22:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E39CB213EA
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 21:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746AC3BB3B;
	Fri, 24 Nov 2023 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AykVqU3v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5732228DB8
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 21:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619BDC433C8;
	Fri, 24 Nov 2023 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700862280;
	bh=LN0eMAmgaeScd22mjSdgcVS3wJbic3/e+LHxy4B37wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AykVqU3vf6hjcL3vs2uO54GDs3A0KHVPJJL7Z51bpNMtazgxyVEF8C2HDTA89T08n
	 D1m019bat3MeyiUVNcl8GQsTJwwX8sCMq9fGSh83xDPjBTi0wOLZoFL05rC2niuxsg
	 RMElKvUfzQjii4LrWwO0bK0Y/VSug/kwU8hYiFIBEm9sbE7xur3/GH+9wPI9mzYWMs
	 xS4JkN3+F4GazeAqe/cPXRaU70HfpCkNJfNdfxD0gVR13zAwbob3NockNwkp8uxB6X
	 qIlLGd6Qk56+Pf19WSxLkVqCIEw6z6TgX4WpOFQrMbThUCYLBe3IXxxUSjJdjXTdb0
	 Ymw0avquWkAog==
Date: Fri, 24 Nov 2023 21:44:37 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 1/8] tcp: Clean up reverse xmas tree in
 cookie_v[46]_check().
Message-ID: <20231124214437.GY50352@kernel.org>
References: <20231123012521.62841-1-kuniyu@amazon.com>
 <20231123012521.62841-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123012521.62841-2-kuniyu@amazon.com>

On Wed, Nov 22, 2023 at 05:25:14PM -0800, Kuniyuki Iwashima wrote:
> We will grow and cut the xmas tree in cookie_v[46]_check().
> This patch cleans it up to make later patches tidy.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>



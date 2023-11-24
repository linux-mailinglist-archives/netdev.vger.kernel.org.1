Return-Path: <netdev+bounces-50967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2968D7F8592
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 22:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2934B1C20975
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 21:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42CB3BB41;
	Fri, 24 Nov 2023 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyLbpN99"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A2364C8
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 21:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8310CC433C8;
	Fri, 24 Nov 2023 21:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700862299;
	bh=XGK/rm2nZ8l0IwrJ1T4IoIDQp0GnpsSLQFt+fmy7Kt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XyLbpN995VD16br9dXG6ZvJAvVJ6o75XXgEFSP+c30mjBsHM190gbFYVQtXFR967s
	 eFRz3x4utuG9lmlDE5cEmYXeDcOuRVOUCMaP1IyBxE50Syp6oyN0Ex5jB5FgyR5Tam
	 bjj80NrUAvOo39mCFQFsAT1ig8qneJ1xwU5uL/NPvtvTlTTbzZ7Ooej16+R9kSnXbh
	 MjLB0CvkH7YOJGjCOju6xW1jTKedQrY/gEovJGTt92mzcqUzRM5D7hl7znbNA1Ys3P
	 3a6rpFr0HFynhAzYicoSnjoG6hVJ3IYnvfCVhx6TIhpZ5MefKXeEqdqYbNXJ3d9b8o
	 33WeuQc2Dh/JA==
Date: Fri, 24 Nov 2023 21:44:55 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 2/8] tcp: Cache sock_net(sk) in
 cookie_v[46]_check().
Message-ID: <20231124214455.GZ50352@kernel.org>
References: <20231123012521.62841-1-kuniyu@amazon.com>
 <20231123012521.62841-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123012521.62841-3-kuniyu@amazon.com>

On Wed, Nov 22, 2023 at 05:25:15PM -0800, Kuniyuki Iwashima wrote:
> sock_net(sk) is used repeatedly in cookie_v[46]_check().
> Let's cache it in a variable.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


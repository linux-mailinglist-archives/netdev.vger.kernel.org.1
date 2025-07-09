Return-Path: <netdev+bounces-205341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00C1AFE37B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 11:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73479541FCE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75034283151;
	Wed,  9 Jul 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICNOyLZL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA8427A90A
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051795; cv=none; b=rjxnCGZZ1DLvHX5eFXI6WQEgSUwJrR1WdjPvEGG01PDBuGK9DL1RR9+pZnzC/6LH+UN9Wsdbb78ymfLpQA6E2UbBU51tPORyRFhJAH4D8kOzQoiCMqN1a16ZKL/fLVs6OgeJ4nYe0sQD6k1r3OhhWlHigwr4VgT9Ix9dJmh9YIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051795; c=relaxed/simple;
	bh=xFtFNX/DlHX/+CSdrNQjnXsS0JV3DW/uHQEalrphf5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJ0vYZKmH2mDKoNB67pGwcWJce+68UrgGP7bNwSkU8CW38GWNe8KjDiUaH3hvq06cGWEntB7Ni2e1ClCgPSUc9WsVmUyJO1tQfbWTyN3Q5b4+uWO6BShQL9tO1xJjcGjSdav4ATZW7dG2JMalaMP9hf22dtxIlC9taHfPQ4ELNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICNOyLZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620DBC4CEEF;
	Wed,  9 Jul 2025 09:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752051794;
	bh=xFtFNX/DlHX/+CSdrNQjnXsS0JV3DW/uHQEalrphf5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICNOyLZL7H6G6g58W7/9Qna6VrtrsBmVyQurn9UxBXQZ5RccyUeepbjn0x2zSJzm+
	 BKGvUk3XUwFRmeyo+5kX+a0mQMuX8/mmTQfBp7S1Dlmo5EV38bAY6kRD/yj6Vr6kvc
	 BSI4ixGXRjnokChtYRVk1o+kElsyGnZiXekX0OwfHE+/vVMbXiV1tawBPJiTLIKPCm
	 NFzbXI8opJ8AyCW5sR9YhCw+LpzX7U9ep4rb1bGlLP7aFcF6YSExcdd87idosqm9ix
	 Ff57etJtLnNfkKn/PbWg6IW7zC8JrEQzKdJeQB0eKtemzDi4XQrxO7pbvOAmAByj8Q
	 cbNa0VOS3oAaQ==
Date: Wed, 9 Jul 2025 10:03:11 +0100
From: Simon Horman <horms@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/8] net: mctp: mctp_test_route_extaddr_input
 cleanup
Message-ID: <20250709090311.GP452973@horms.kernel.org>
References: <20250709-mctp-bind-v3-0-eac98bbf5e95@codeconstruct.com.au>
 <20250709-mctp-bind-v3-1-eac98bbf5e95@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-mctp-bind-v3-1-eac98bbf5e95@codeconstruct.com.au>

On Wed, Jul 09, 2025 at 04:31:02PM +0800, Matt Johnston wrote:
> The sock was not being released. Other than leaking, the stale socket
> will conflict with subsequent bind() calls in unrelated MCTP tests.
> 
> Fixes: 11b67f6f22d6 ("net: mctp: test: Add extaddr routing output test")

Hi Matt,

What I assume is that commit seems to have a different hash in net-next.

Fixes: 46ee16462fed ("net: mctp: test: Add extaddr routing output test")

> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> 
> ---
> Added in v3. The problem was introduced in current net-next so
> this patch isn't needed in the stable tree.

Ack, thanks for noting that.

...


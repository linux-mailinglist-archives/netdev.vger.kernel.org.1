Return-Path: <netdev+bounces-198281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C566ADBC5B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA0B3B831C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3224220F47;
	Mon, 16 Jun 2025 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5ZFIR8I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72DB1E231E;
	Mon, 16 Jun 2025 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111050; cv=none; b=CJydTQmFyC2Hl1oc7RgLadRx2n2nsCmOKOQtpX1JpiqcmTHVNUoOQ46w4I6HqkJvG3vcb/gvXOheN6V51/EA07sFJzaPLaPtD3l7mJHFudMoVzm3Dwh3Q5rxbjEny+I74G61lii8yhJRPZ4f7jX9z7zsOesB5hRVMl/pHyLj/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111050; c=relaxed/simple;
	bh=eyc/gswzHPtBA6IU4zbzxIAE72gnf9Pb80P53cBpKZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aex1dE8QU+u2f6YnwHtVe1OPFEKG5o631D2Vp+iZ7J54EnInob/8dHQQmMTbzxXkMiRmYc3ksruk02663EwEotZBB793vfRHxgsZEQeWmqh5v1hRRik791nrgvs23VuBFtoU0Ef5EsPy4+BT3jIA4U+tiKMzBJPxjwmYH40Gb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5ZFIR8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D213C4CEEE;
	Mon, 16 Jun 2025 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750111050;
	bh=eyc/gswzHPtBA6IU4zbzxIAE72gnf9Pb80P53cBpKZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D5ZFIR8IhcbWH9fc4y5RPfd+OmRo0zDNYPDVBezcZjWENLoOdvTtzknfH3jdBS9+i
	 /255zhjcbWhwVsvUyspw97hyRF46AGRst1pcnerNVdHo0wD7c8y9bOBlP+aF6ej2//
	 5KDYfmDLT/UJ4F8wLYot9ru/ufoDD8VDkJ8Os88yTkgINpye0sQoR7uCq+/WNcQjf4
	 lz132eii7I9rRYYBjTuO6j5Fp7lfI2AOj32W0q5yx2nXolTlRMKyn/aepwchgpijuy
	 jobsTsGgra3MJVrTHInWnsFNKcCaNn6dr+XU+WGiM06/Yn4nhtYQgxcWT2oRcNrPA4
	 gkV7EcMhOVIuQ==
Date: Mon, 16 Jun 2025 14:57:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/3] vsock/test: Improve transport_uaf test
Message-ID: <20250616145729.1a16afdc@kernel.org>
In-Reply-To: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
References: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 21:56:49 +0200 Michal Luczaj wrote:
> Increase the coverage of a test implemented in commit 301a62dfb0d0
> ("vsock/test: Add test for UAF due to socket unbinding"). Take this
> opportunity to factor out some utility code, drop a redundant sync between
> client and server, and introduce a /proc/kallsyms harvesting logic for
> auto-detecting registered vsock transports.

Hi Stefano! Sorry to ping, are these on your radar?
I'm wondering if the delay is because of devconf.cz or you consider 
the Suggested-by tags a strong enough indication of support :)


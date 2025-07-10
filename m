Return-Path: <netdev+bounces-205638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81840AFF720
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 159327BB2B1
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36375280303;
	Thu, 10 Jul 2025 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5gSlwCY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1278B27FD70
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116014; cv=none; b=CjjG/2YM7wW4LN3InjcHHdvjLyw5+72EjNyRKFPO/KmfEFREf+B75szdOAjjFl2e7WC9vPmrWNwOvFWaQ0AvO05+kcpHqw8GSQVbYB/yPZio10dd0laLFzld1RGLueWJlbNhppc3BmoCEBMq8orlBi2yQFZnmKj1MUHeM8dLJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116014; c=relaxed/simple;
	bh=szhD46FA9Jb4pmeNs4mqHyQqIw+xigPwtBfx3ji5DsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N04z5hyjRI16MYqKLBAKb9rw2i7FVpblcGdj6eMRC/KOuu9DWwPG3dEXn92nvd2AUTrs3RxzeWdx90ffquK2Nimk/I2Qx+3ykhHUJ0wAPEbdlTk6pe7q8T1Xlq5fVN9ubuVWlKe/nPkMxRzAff3/0umYP+eUczSQHUhGsQGL5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5gSlwCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7A7C4CEEF;
	Thu, 10 Jul 2025 02:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752116013;
	bh=szhD46FA9Jb4pmeNs4mqHyQqIw+xigPwtBfx3ji5DsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o5gSlwCYy/lOIUrlAPe7e8atRhjFUf9hkXfLKm1s8g61hMx/tH14veoi17i+sR0OT
	 DuY9+xzAR8V7VqXlB4DsC8eiwKAoJ78Tl7MLXLY35c3hBV+iSaV0si9oy4kSQOnOiC
	 jziskmWJrVn/G3BDbUriCQ6hejMG8MVUGscjNaR7yUzq5Ax1kVNb0ZyQk79ng/PZAc
	 NI0IJ9Jt6efU9ZrS7H3Dc/GeOcuhsEwifIxPnR5Ykuh0z4S+YP61t+rvSkciMZTPLm
	 ggaspJRDnKeOn7F/KSKwdplnsZdN8Cd21dk9+d4PUslX8XCNup+FhGYsV4hqXe7OSb
	 2RFWAubne1bag==
Date: Wed, 9 Jul 2025 19:53:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Simon Horman
 <horms@kernel.org>, Vlad Dumitrescu <vdumitrescu@nvidia.com>, Kamal Heib
 <kheib@redhat.com>
Subject: Re: [PATCH net-next V6 01/13] devlink: Add 'total_vfs' generic
 device param
Message-ID: <20250709195331.197b1305@kernel.org>
In-Reply-To: <20250709030456.1290841-2-saeed@kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
	<20250709030456.1290841-2-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Jul 2025 20:04:43 -0700 Saeed Mahameed wrote:
> +   * - ``total_vfs``
> +     - u32
> +     - The total number of Virtual Functions (VFs) supported by the PF.

"supported" is not the right word for a tunable..


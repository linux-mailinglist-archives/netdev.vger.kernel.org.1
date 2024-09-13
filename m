Return-Path: <netdev+bounces-128015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC00977796
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF711C24422
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B31B011C;
	Fri, 13 Sep 2024 03:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhDQRqI/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84BA73478
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199586; cv=none; b=kIoAtKnhJZw8Ss3WlN8wbo/szEa/KBe1fugxDu+jr4TwyxeQuw7GHU1rdhaZ9TWAawIrz8+XJjR8BcM8SJrO2J92It1aWYZjMO4rMY6ONS+mEUFBRk3ixQ4vUfCLF03bqaH+AqzPYG+6QqVRglaclcflSdoIFjwaoj4w5SZRQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199586; c=relaxed/simple;
	bh=wpV0bzVIeHbJi7vhmRd1wzpzolyWqqeFx9rXSasZVX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCg8fKcuqhsICGlh0aQlAqXN9uxe9hOVp3HKUvzyAL/kr9umOK5P2z/xwupr9c6rRi9vrwp7EatyXCFfmDqlT7umNJ5Vv+uqA7YINoRja8k/zfnutsPt4o7FTKe10lToCoGgm69h2lG7hCm7emY4vAIqwOs9sAUqbe+DwoNgJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhDQRqI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CB7C4CEC0;
	Fri, 13 Sep 2024 03:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726199585;
	bh=wpV0bzVIeHbJi7vhmRd1wzpzolyWqqeFx9rXSasZVX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WhDQRqI/0YT4gR37I0DFlZ1Ynj0qxm7fk4ilkS5xTriJQBkr+Gt6pZiVSINnJBKfs
	 bF/N6A66QF//ExJJcbsgyxkgY7fqU0BcaSnvrWLySSZI2yF47s1P2a+El2miZHRslA
	 fSl62z4Y5S2QmlYJKfFaf3qhJh1aX7lMexpVpYen4RCRaCIbRkVC3QbDBVInnbqzcz
	 hY+fUrlIAHfjs+50zF+4JBDNjpuxEEJdK6MndsnzyEf4iQBYinDHHPavF2yEtXEcRo
	 a7fwhmgLlFtfIzqA/BK1b9uRQLgQVg8k686AxYJ1wS3z4h6wk0U/yEiIvPckHCo3GX
	 qeP3yDm+XR8MQ==
Date: Thu, 12 Sep 2024 20:53:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Kalesh Anakkur Purayil
 <kalesh-anakkur.purayil@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>
Subject: Re: [pull request][net-next 00/15] mlx5 updates 2024-09-11
Message-ID: <20240912205304.34107296@kernel.org>
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 13:17:42 -0700 Saeed Mahameed wrote:
> Please pull and let me know if there is any problem.

Commits on the branch are missing your SoBs, I applied from the list.

Jake, Kalesh: thank you for the reviews!


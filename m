Return-Path: <netdev+bounces-57624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2619E813A75
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D301C281C68
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520DA68B9E;
	Thu, 14 Dec 2023 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6YyB8XM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684A63BD
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D752C433C7;
	Thu, 14 Dec 2023 19:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702580762;
	bh=rMMbprCSgIlMQDOFJO2zSoGk4wxg+cuQ04IE/7PyMQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n6YyB8XM4mimLaJ42oY3UMyx6nDDSyinNQci0/3ACt/y32eQklmHkpGYm1mlg8rdB
	 PrMSEuTljuDXuPDCAuX55XHk8xHjuX35iDighXEP5U/aRmcykUr3lSinYdA6xlLZeG
	 JD8n1Xdp1J9hVeb6QtNLQ1x874PjDYCi44pe4HU+MVgf1YnhyPvmSFfFsT+ocN+b3s
	 Qal1GuVPICXlLJXnzSVYg7uGLnD/VkjVjryZhBD30+NKqu4UDJqNd+T7gkmq/RtuRU
	 4QG+7ohmBD6J69fyC+IUZt6Kix2EW4Zl6V4ktFVYB1fjE/U32WDItatJ9v7TPI54ET
	 PdZjmQeZst5EQ==
Date: Thu, 14 Dec 2023 11:06:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <deepakx.nagaraju@intel.com>
Cc: joyce.ooi@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: Re: [PATCH 4/5] net: ethernet: altera: sorting headers in
 alphabetical order
Message-ID: <20231214110601.593f8013@kernel.org>
In-Reply-To: <20231213071112.18242-5-deepakx.nagaraju@intel.com>
References: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
	<20231213071112.18242-5-deepakx.nagaraju@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 15:11:11 +0800 deepakx.nagaraju@intel.com wrote:
> From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
> 
> Re-arrange the headers in alphabetical order and add empty lines
> in between of groups of headers for easier maintenance.

This breaks the build, please make sure allmodconfig build works.
-- 
pw-bot: cr


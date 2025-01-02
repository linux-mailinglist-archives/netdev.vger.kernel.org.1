Return-Path: <netdev+bounces-154776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C48D9FFC4F
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA053A1416
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E807EF09;
	Thu,  2 Jan 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewUkSbp+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFFB219E0;
	Thu,  2 Jan 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836833; cv=none; b=CbVhFFKa2bMie06cvEw+ysIPpOSb3cdrC1V3lcMYWNavRwI+zTdJPqIWskXbIvL/bhr5m43lqQPqgb6+KbQxCq0X1yJoOLT2Wt+0iN/iuw8G/t2/cJGgigU+NL+4HSwGxVM7OlLF6t5lfZ0HYwB0TSrRUtS8UzpeRPLMZZ/qmPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836833; c=relaxed/simple;
	bh=VRMWd0iOC72QqrSsgeH/41MDjS+EyKzx2DS4GO0g+nc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvrY1+x99wMMhvjXDJWjJpUNZagbvG83+6QUZl92AGJ617m/UKNslrCOtEgivxmNpJuYXekbf9je3ulPQ46sDjpM1ezNvCPeYhVbT+DQksGNS1vb6eARiOUmfZUh0I+H8tilx8CNTofS0UWgFWJ2P2IxTXrtp6t5HXgZsXrozP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewUkSbp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AC3C4CED0;
	Thu,  2 Jan 2025 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735836832;
	bh=VRMWd0iOC72QqrSsgeH/41MDjS+EyKzx2DS4GO0g+nc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ewUkSbp+Eo4YjTBtyDTHmLZxHQJchPkQpiOU0JR/D1RMvul/lTUpkP1/nPlg77Rt6
	 yBboO1YyhLrxg4oR4Jgqm3wUQnirYG1TNy1VoT5ktbJOIc+mXrQLK2eCEQNT8FLOJo
	 dqg4hK385vRckE/8q/cAWO9yOC0yxJJh/ksYHycDN4A62vSmsvP9D3A3gK6AjokuRQ
	 /BGk8VOYq2KkmGagca+b91kngnQjY7ZdsmJT3Hs9y+uLE3HVEkpNHVcbupWzo2SBNo
	 OIFKB4j563GEe263bcPvZ2xVwr7WYGes9sY3wvEyahsIz4kH5RXf0p3yCInOF9iW1E
	 RUYJtXMd6wHug==
Date: Thu, 2 Jan 2025 08:53:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: gongfan <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>
Subject: Re: [PATCH net-next v03 0/1] net: hinic3: Add a driver for Huawei
 3rd gen NIC
Message-ID: <20250102085351.3436779b@kernel.org>
In-Reply-To: <cover.1735735608.git.gur.stavi@huawei.com>
References: <cover.1735735608.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Jan 2025 15:04:30 +0200 Gur Stavi wrote:

:(

This two docs are required reading:

https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Please read the mailing list. You posted the patches when net-next was closed.
-- 
pw-bot: defer
pv-bot: closed


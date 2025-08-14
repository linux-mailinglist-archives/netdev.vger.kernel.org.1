Return-Path: <netdev+bounces-213533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0B5B25861
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FC95A09EF
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B12175A5;
	Thu, 14 Aug 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK7CJzmu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E32FF646;
	Thu, 14 Aug 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131692; cv=none; b=obivG2uu4Knc9U5P5qtjOVBejhKUIr1D4/mJebsOURY146q6IdEZzOMT4cC28r9hvP5A0Wv+iBsuaUcLV1d6qaWOUdIf0H+t0R5U7zzc/E2YOaQrZbudFFCAZcjE6OmqB8gpqgr/4d9CGyw69tE4fXT0+3Bjhge9IRD4l8Yoduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131692; c=relaxed/simple;
	bh=wzNHtd9ccrctz/aWGx4JWyWIjs5x7B1LKgR6+oQFN+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frI43cokMIWRTPVXYCt8FT/UX6n1/XHi+jCub6uz1J63kBX61SveBZ+ZMwVkJk1COYGkA0DbeCEEc4SE1ADzFC3QoBOaAf+WK9OcU2S+CRLh7vnUuvuY7o2bnvtbKOzwc37WK6H8WEHBP5aTg9myvAHh+ZYaCLcuw4H/n3/A0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK7CJzmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF67C4CEED;
	Thu, 14 Aug 2025 00:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755131692;
	bh=wzNHtd9ccrctz/aWGx4JWyWIjs5x7B1LKgR6+oQFN+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rK7CJzmuCtkkEXf1UTJ2cFpFlAsqJW1jrjDiqL0kkcyg9F3vJmlwDKObQrxpTUEag
	 w7tkCNUsXf/C561yfm9sM2mLFRbH3RsjCIeqZ+sOQT0fJTmahr7xjjzjvoC8dojnfy
	 /ssd2GrkrzPznT7WgOSBNg3FZKsqu9zSl0P4zuY3/owtAsD06pbFKppFH9To7UZGSo
	 qtiSqWl2bQIBqCtSmTIJ0CzN0YEEVYDha12OlKh0mv7dJku7rmA8KyzoThcn/feo2w
	 SgIJaJeEjL4Z25HJlH8qbkgdVKTAcsZxaOGsAkFvuwlvsLHjn+RWO0T90vnNFbaTdZ
	 Q0ecvMnQvGjKg==
Date: Wed, 13 Aug 2025 17:34:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net/sched: act_api: Remove unnecessary
 nlmsg_trim()
Message-ID: <20250813173450.02715558@kernel.org>
In-Reply-To: <20250813125915.854233-1-yuehaibing@huawei.com>
References: <20250813125915.854233-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 20:59:15 +0800 Yue Haibing wrote:
> If tca_get_fill() fails, all callers free the skb immediately, no need to
> trim it back to the previous size.

Okay, but why do we care enough to change it?
This is a fairly common pattern in netlink message formatting.
-- 
pw-bot: cr


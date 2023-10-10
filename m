Return-Path: <netdev+bounces-39645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B235E7C03F7
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B32281B61
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1599B2FE0D;
	Tue, 10 Oct 2023 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQBzYjiz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7F28F0
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148A1C433C7;
	Tue, 10 Oct 2023 18:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696964376;
	bh=PnfzjcYug3mICMkaoNUs49qRMUOLKRRSY2+iOB1a0CE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JQBzYjizir7HvvH9jItV+KtV1/xZBITXG+C9b5GOIHFNBtINJTjrkCoMfG5kSDZ+x
	 j3T8ybaPEKDxM8Eo/hqiSfAbmQO/OyofbG0ji9QL3oRIX635nvTudei0/1NldC84Np
	 rsxbthdzSiewJ2hs1YZso4UgWcydPLQ6Yqy8QG3ggrjFPFLIGtdzyOKrP1HBYA10R1
	 a+ca8VwnAW/YOEpRmCzyQ8k2az/SVoAfLpMl72PniJRg1O4VMF6bhSTD3xFBZd0ams
	 gHw160SA0j3/3QkGXtLzkFFYlneH99F8P1gqsvTMypfxKVaR+kJI4X32hE7d+OwZWC
	 HQEbswBWCe7pw==
Date: Tue, 10 Oct 2023 11:59:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, johannes@sipsolutions.net
Subject: Re: [patch net-next 05/10] netlink: specs: devlink: fix reply
 command values
Message-ID: <20231010115935.58b4b2ea@kernel.org>
In-Reply-To: <20231010110828.200709-6-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
	<20231010110828.200709-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 13:08:24 +0200 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Make sure that the command values used for replies are correct. This is
> only affecting generated userspace helpers, no change on kernel code.

Still, I think this needs net.


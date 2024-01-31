Return-Path: <netdev+bounces-67734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5BA844D43
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 00:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4CFB36ED2
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 23:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB203BB3D;
	Wed, 31 Jan 2024 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW6j6VTE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869583BB27
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743051; cv=none; b=BiwhoSpE2DTeMIIKj33nIJAEba77YEfRDzE4KRR1YdN5IuzSs8jTw53Oe1l8NbHggVrh1YJN3XJ1HsvgHGXY/7cTsj3eIdpEObR7vkaaFcfYVRCQh0twp4R2TfYO+jFZIFxEhwdyGkEkWXNQe3r78qnOSbRuq6/0U5DNvq66tuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743051; c=relaxed/simple;
	bh=UQFiao/SzdiovwmvdML/dSGgNwshH+ORtnp4fbWcR5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRUre+14NunsrN0C7vlbKwupVzQ/+IdGHyS4ESCgRG3Na+Mw0qghdEQzprb3zHFWS9HyqJ9FHtztgX8q8aaZci3y4LH+FrXoPw4W1Ld8FQIqvvRQSkuIR9JCEIQ1hgx5JNbl52MdAfwDv2qPmSkp8qWm0uLs73COXhH0c/06g9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW6j6VTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEECFC433F1;
	Wed, 31 Jan 2024 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706743050;
	bh=UQFiao/SzdiovwmvdML/dSGgNwshH+ORtnp4fbWcR5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WW6j6VTEfzYn+RCf6RrJJbgqYLeOOwVKVaHwgbAenNF+bdyIW1aaIsUYBnTCHamph
	 GxiT+TZprldOec0szfa+Q7Kpb2ND0o9c3xsrCv0hsb6eudscPg2Sy05VIyae5rMivw
	 4ukyM9uExF/64PxmLG53FHkhyF1oyQY4kXj589BKx2BzDi9ynQ9xOAk9Yj/hlyyiMr
	 6E0zj6oMn6x54Pev+Pb6SXFY56y8rRo1ThFLUeIRN53bfGZ0DggX+ekcM3nVvFXPg7
	 2hQYjsyZqBRUW1UwZumvO51tzeEjwjEWwEhMgkUodo7CfRJWOouf5oM0WLmFMkbzmm
	 HMSoRGFWnQwuQ==
Date: Wed, 31 Jan 2024 15:17:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, bodong@nvidia.com,
 jiri@nvidia.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240131151726.1ddb9bc9@kernel.org>
In-Reply-To: <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
References: <20240125045624.68689-1-witu@nvidia.com>
	<20240125223617.7298-1-witu@nvidia.com>
	<20240130170702.0d80e432@kernel.org>
	<748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
	<20240131110649.100bfe98@kernel.org>
	<6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
	<20240131124545.2616bdb6@kernel.org>
	<2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
	<777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
	<20240131143009.756cc25c@kernel.org>
	<dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 15:02:58 -0800 William Tu wrote:
> > I just did a grep on METADATA_HW_PORT_MUX and assumed bnxt, ice and nfp
> > all do buffer sharing. You're saying you mux Tx queues but not Rx
> > queues? Or I need to actually read the code instead of grepping? :)
> 
> I guess bnxt, ice, nfp are doing tx buffer sharing?

I'm not familiar with ice. I'm 90% sure bnxt shares both Rx and Tx.
I'm 99.9% sure nfp does.

It'd be great if you could do the due diligence rather than guessing
given that you're proposing uAPI extension :(

> This devlink sd is for RX queues not TX queues.
> 
> And devlink-sd creates a pool of shared descriptors only for RX queue.
> 
> The TX queues/ TX path remain unchanged.


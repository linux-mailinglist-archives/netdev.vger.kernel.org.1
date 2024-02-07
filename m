Return-Path: <netdev+bounces-69910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E4884D021
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E393A28EC19
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B3382893;
	Wed,  7 Feb 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tle241d7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268B8002F
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327927; cv=none; b=BBmlqa3T6BUxOga5REwcQ8xVxGKRV9k8gZAGNeO2woDYSw6+nXnBuNQ3Wz7vVAr2JeE4Ba5mwSd8F1NbSw/MnSQhOFvTlXxisv/KKT1qEsjHhmkgGjPZ/9Pq0lvK3VI3uCRsnf0cUj9On0ACjBqV3wsExgzbRmhTYctDUdMh9U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327927; c=relaxed/simple;
	bh=VPpcj6e7iUVnnmpRMPJ3UL/qKwzxx2uFLDlr5+yPzp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dVO05UwklNAkqXB5dcElDT5pW4bVXZBytHyuQefiqPxPF66QnUZCObHa9RsFOFdGRjO9vV9iDeukgqXd+VBwRKf4W2tPPe9Pxf4zh39e4NIp955asmA7r6jxG+CAKzRYNHpWq+lEDPF73AVru3Jgbw3n3gyneP2I+sOTmdMiOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tle241d7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DCCC433F1;
	Wed,  7 Feb 2024 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707327927;
	bh=VPpcj6e7iUVnnmpRMPJ3UL/qKwzxx2uFLDlr5+yPzp4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tle241d7v+DgMwotrSBtCsZv+T2lMOUeql9QkxlQenDz/MyyDAaGsFRMWq7OQ6nC9
	 9MQ41cwjcsj7PLmhAeU+g8m1DEFhQDVVfFS4D58PT8RSLMHtK7qFmm98kwkOUP7QpN
	 D5aGfOuVDsA7kg3cii0UC4koJOmVtjO/tNae3MDZzDYm8VVyOA3ha6y4w1HVdB23xf
	 MdgCDo3xWrxp+R2ZVDZr2aXrgZwYTolhmWSKak/HnZM7olqhEt8j7JRebF+oykUKuC
	 ACFdP3eHRXUKmq7ytxbbfoglxLE8IOF3g1BDlbUbmO29/JSgLPXPrrPa6e45gPDr0E
	 Q0i7E8BRkJCKg==
Message-ID: <c5be3d50-0edb-424b-b592-7c539acd3e3b@kernel.org>
Date: Wed, 7 Feb 2024 10:45:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [TEST] The no-kvm CI instances going away
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240205174136.6056d596@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240205174136.6056d596@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/24 6:41 PM, Jakub Kicinski wrote:
> because cloud computing is expensive I'm shutting down the instances
> which were running without KVM support. We're left with the KVM-enabled
> instances only (metal) - one normal and one with debug configs enabled.


who is covering the cost of the cloud VMs? Have you considered cheaper
alternatives to AWS?


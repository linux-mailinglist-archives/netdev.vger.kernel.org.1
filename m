Return-Path: <netdev+bounces-69652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DB984C100
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 00:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB61F1C217B2
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3D61CAB3;
	Tue,  6 Feb 2024 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRmdTNax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A915E1CD13
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262938; cv=none; b=RBShPoOpcJZVrTxoMBdRmklIPBnT3lIUpLiv3Ys3leMpcnA9iBTi3jRNw82uFMHpO8gkQ+iCdbSQgliDM3hqwExLiZh53KeQQ9dMeLqi2zjUQkFfKHzr74VQ1YaeMfDB4MqW4rfr2q5ftRMBdYKLkz5ycNl/+F2ES27H43i7AUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262938; c=relaxed/simple;
	bh=OlFzD+7EE18a180p/V5l0vGk/NYUREVueVS8QztEBio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bujFp3aN8/4kYQ7gWnVRaLPpMcUSus7hD1fMzqEpLVu4mrn7vW41tqe/RAzSDb9H8L+R1oELmTJealsGFVmQc3YS39TLjIO0LZL4ju/TQzrpzi2UtMaoxwkppQ8UYxZk9CihwqYWbXtvOb293DYW84WhllLtu9M7s+/6JPKOkrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRmdTNax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F57C433C7;
	Tue,  6 Feb 2024 23:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707262938;
	bh=OlFzD+7EE18a180p/V5l0vGk/NYUREVueVS8QztEBio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IRmdTNaxDnRtM4zgidhdninXzZYuYWFVDIIGmOcqR/3mz5wy+hmFh0391ytHNS6VF
	 ZpQNjUIezHoEbEJdkkQgHYHWIB7W2jzyCJLb2qiyBNOuvj7nK5SMG98ZmocpFH5Hg1
	 7OMwWqg6BGxkXJSaeZafoXnKNmkPDGIjv/8xFaXlMISGJa80Oddq51K82AIe+9LN/9
	 +MiDpOzFkOqAtX/GeqwOjRBCXJZer+GAzJR7obLyvveLPYZAzdbsCgZCtjk7AyVvHu
	 3eTwV1Pmaiuhy6J+yO9Zi/kdO2htVLMiI4RVJbwskiy/eLdfaFQTSI/IlzkjQOpQ2L
	 Vs4EdKW/ClEwA==
Date: Tue, 6 Feb 2024 15:42:16 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Tao Liu <taoliu828@163.com>
Cc: saeedm@nvidia.com, roid@nvidia.com, dchumak@nvidia.com,
	cratiu@nvidia.com, vladbu@nvidia.com, paulb@nvidia.com,
	netdev@vger.kernel.org
Subject: Re: Report mlx5_core crash
Message-ID: <ZcLD2Bv9rG-cm7Nk@x130>
References: <3016cbe9-57e9-4ef4-a979-ac0db1b3ef31@163.com>
 <ea5264d6-6b55-4449-a602-214c6f509c1e@163.com>
 <ZcHZYbTGHm7vkkpt@liutao02-mac.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZcHZYbTGHm7vkkpt@liutao02-mac.local>

On 06 Feb 15:01, Tao Liu wrote:
>On 01/31  , Tao Liu wrote:
>> Hi Mellanox team,

[...]

>
>Gentle ping.
>I'll appreciate for your advice.
>

Hi Tao, Thanks for the report, The team is already investigating this.

>
>


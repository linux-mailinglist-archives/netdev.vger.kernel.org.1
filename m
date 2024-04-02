Return-Path: <netdev+bounces-83859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23315894A2C
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 05:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EC328661D
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 03:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20871758D;
	Tue,  2 Apr 2024 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqwl4w+a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30F168B1
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712029977; cv=none; b=cRHJQSW0VUav+FfH7xL11vUT0PMXy7IyyuMoV30pALX6lLM+Q/LAAnFOCxEc0ksOSKIZGFJBE1sNMffqzbBhM4PvrDbbhy+AYK3RU+K60GOHPjexEG9gaUkGq2Q9GgRuBpFUygg9640SMDY4gNGPu8iBSFqSO87hAUCMY2Jz9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712029977; c=relaxed/simple;
	bh=Fpw3cwfi4FqgvF5udbAOi8d2CP4wqBQApk8KfrjOZTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WuIUguSnvWY9Y2YwmG2woBUXkWfu74WeFdEeh9nPgTbJNwuPGBhO/+569O7hBNn9G8iGio0mBMfuvxCP0ZNa8di3VVHaHlIWpO1wKlGFDkvYBTrqp1a0lS/+HUE6GVIZ/7tVUbidyb4iLHRfJGVSJVlsIrdwYVivlMXXq/ZncFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dqwl4w+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64FFC433C7;
	Tue,  2 Apr 2024 03:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712029977;
	bh=Fpw3cwfi4FqgvF5udbAOi8d2CP4wqBQApk8KfrjOZTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dqwl4w+aVypWfS0v9fmMhqfANlA+w988QPP36Qzp5Z6aPOw96tST62R7LupJgsDQ0
	 p6UUZ1i40JixBA6fg8ScIP5ZYu0+UsXoGADOtcuNXG5pwls19VAAQgMeaM+sF9Kqh+
	 xTNw4jX4qNN9OZ5yCiNV859Ml/MX4SqIdsE5GfioOv+CvcHf5tnD+J7MNsId7Ja2fX
	 HBnMmsc+Tu8aTdIo96v6eXfDyhryTBnAOxHueuZwjTwFqX7vOgcJKl8TKMfZnNmQBj
	 WFVK75UESZUTXsM9ek+E4x+kEC+HIu3ZsvO2rgNdPFxmKkKUfQsOMHRBh93ztgLrcX
	 JoYIzm9pi2yjw==
Date: Mon, 1 Apr 2024 20:52:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, <netdev@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next] MAINTAINERS: mlx5: Add Tariq Toukan
Message-ID: <20240401205255.2fe1d2cf@kernel.org>
In-Reply-To: <20240401184347.53884-1-tariqt@nvidia.com>
References: <20240401184347.53884-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Apr 2024 21:43:47 +0300 Tariq Toukan wrote:
> Add myself as mlx5 core and EN maintainer.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Saeed, ack?


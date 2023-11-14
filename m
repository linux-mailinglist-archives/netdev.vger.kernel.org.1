Return-Path: <netdev+bounces-47605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA027EA9ED
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 06:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119A91F23FA3
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA10ABE58;
	Tue, 14 Nov 2023 05:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTD/I6Nz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAFC122
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 05:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2ABC433C8;
	Tue, 14 Nov 2023 05:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699938181;
	bh=NqtOsJq8IJIrnyzwBnW58tRCbxpD7WyocZqlFDj65CY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FTD/I6NzrGKu7++rYj6TbeErjGKMcSkAiSYcK35hDHPao1HSi3vR436hcVbGTJqwf
	 NPisgybhH8sUXgluCP+pxXCDdll/p2l4dmFfVvDc7wfotvxK0whXo3pWoWK8gXgu/e
	 crsbWPo0ERVVArlC1MRVyZzjkXJT0tWUkisaULX4AfGSyTYNRK+U435MBATbb2PJXG
	 mlntEQ+Bd7o9+7T9bU0E2iiuelukY2W+G/OmhMr3c5jQVvyeDDZPiWEsOmMHC0JX1X
	 pcx9+bmsQvW/6OIxKIS6zCJ6r9NdqUJZ839E2IqoDzWUQAkZvFumBBzDbkHoyv04v3
	 EGydKOeuUH0mA==
Date: Tue, 14 Nov 2023 00:02:58 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [pull request][net 00/17] mlx5 fixes 2023-11-13
Message-ID: <20231114000258.076da130@kernel.org>
In-Reply-To: <20231113210826.47593-1-saeed@kernel.org>
References: <20231113210826.47593-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 13:08:09 -0800 Saeed Mahameed wrote:
> Please pull and let me know if there is any problem.

Please obey the limit of the series length, it's in the tl;dr:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html


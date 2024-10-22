Return-Path: <netdev+bounces-137931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FC79AB276
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CCC1F23439
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FEA1A0BE5;
	Tue, 22 Oct 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbckUL6y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D935513957E;
	Tue, 22 Oct 2024 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611999; cv=none; b=bMWidB6ercpzkaYwDh6ylRU4L11sA9wcUxYB2EXTn0359J6CsdyL462DmZf5cNhUk6PVE+eYNUqjNWBwcJF14mjpSq4Ns0jIZGERrnlIg7R3uOT69LueKhDhavinwWWr9UnJe78q5BM7O64vY8sepgR7I79K8uaXPZhfwgRsKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611999; c=relaxed/simple;
	bh=zyJZKVN0iTY7Nmr0uDseghesQFaJZNHnPVmnO4LCLQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMTJubSnUahhdqW6e7UVLjcSUw9KrrXF2jaVH9UQzMuji0UOFwoVB/edvwEOuOeqa5kManWSlFAv0f81JthS5ahqBo5b17RGuv3d1IHqfbfaKOdrGL/IR2nYXfSvKA+oWMg5DNZp1nCjZecE9oz7q6r2iszfNv+Fgiq/TwsCWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbckUL6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8891C4CEC3;
	Tue, 22 Oct 2024 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729611998;
	bh=zyJZKVN0iTY7Nmr0uDseghesQFaJZNHnPVmnO4LCLQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbckUL6yH3TL8sSBHrMq2mrTreedy6KQH7aUKTX7nYtS3puoCPYWfHk3F2vLcJpW+
	 ECJb3wxfKOqpxvCDM15w5tdwg/IBTw7v/flESoR2zWOk+r6zXZbtHlhmfewtGej6a/
	 6VWyMAMqbOwK1MHsRuwgrZOzkoUebfdRnplMy8F9NGjHyhG8DudVVpWh4Ax0g1JHw3
	 Njz4bWNKkrIDS6Uc+xpV2xOteCG/fqTg10R8hQ+onpjC75WE6jZbW+iphMvMlpHiLC
	 z6my7HiL8yw1xGbRx61WP0gQUu010f7MAwGM1sf1RYIlh/ADkf/rz8YNrYni+m9LWc
	 IlM3QyB1FPCSw==
Date: Tue, 22 Oct 2024 16:46:34 +0100
From: Simon Horman <horms@kernel.org>
To: Yunshui Jiang <jiangyunshui@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] tests: hsr: Increase timeout to 10 minutes
Message-ID: <20241022154634.GX402847@kernel.org>
References: <20241022080223.718547-1-jiangyunshui@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022080223.718547-1-jiangyunshui@kylinos.cn>

On Tue, Oct 22, 2024 at 04:02:23PM +0800, Yunshui Jiang wrote:
> The time-consuming HSR test, hsr_ping.sh, actually needs 7 min to run.
> Around 375s to be exact, and even more on a debug kernel or kernel with
> other network security limits. The timeout setting for the kselftest is
> currently 45 seconds, which is way too short to integrate hsr tests to
> run_kselftest infrastructure. So, HSR test needs an explicit setting.
> And to leave us some slack, use 10 min as default timeout.
> 
> Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>



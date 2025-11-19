Return-Path: <netdev+bounces-239782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D26B4C6C68C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D66435BBD4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4F0289378;
	Wed, 19 Nov 2025 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIMi9t9R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9C23D2A1
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519868; cv=none; b=sFkNnDzpEbOIjV2l6exkoy7MWIAYKcIzDPNb9BGtI7+TnXyvTvmVZFvM9hDOLeF0QSDtb9a/RhdnN8p3iV9XMoDewHJvj1pC5BQVtV+DYNPUjR2cy6uN/ABAAu+3TUI0EhvunNtXPz3ARYg3xTjPmOC5/yKlYhZHK+9kVGsmK9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519868; c=relaxed/simple;
	bh=89jNGmJZlLJPtji8jhLCZwnaIUM6NrMsTTsE/Eieiwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZkvNoSb6dc4A2Lk8r/8yvPGvYl2eOUnUhwSH6ISf1gnuep0KO1mtvAZH5sSJ1tXkaqyrMw9k2Okw5zMXQo5VUZkILrgFVafP5iHD4FwS4nbQyTY30zlbO/hhmYbql4Easw2FLCOvaxk/qXlBdFGsZ4k8T1yds0hs9uGZOpB5Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIMi9t9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00C2C4CEF1;
	Wed, 19 Nov 2025 02:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763519866;
	bh=89jNGmJZlLJPtji8jhLCZwnaIUM6NrMsTTsE/Eieiwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BIMi9t9RK/FSRAvqrdSXTBBnlHlRUdydA4wleUMbLDbwvvsZDkDYVczJ50SeFZGpK
	 jHFKI0GJstqI+TFUJyZgFmL1xQk8eA7X0kjDWbNKTslJRBph/R9ASCZUID0nGaO28x
	 DJRxL4/666PuN/dFQJ8mshQwz4fVfQrao4JTu9fZWDi6P4FdG+w/sRdxSX67Aua6Vh
	 sm9KURF0BfnAfEfo6Yge1tGc8sqLjyoq7vWrUx8hUMvQ57H6TUDXk4lzErLpTFzM3f
	 cn+0+61shb1jam+6CHMH4hQ+f5p7HqXoU0QHpCYiEA51KhTDJd43FyyZdxbY9ISqzH
	 K+rtWa8so7QAw==
Date: Tue, 18 Nov 2025 18:37:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 ast@fiberby.net, matttbe@kernel.org, netdev@vger.kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 johannes@sipsolutions.net
Subject: Re: [PATCH v3 1/1] ynl: samples: add tc filter example
Message-ID: <20251118183743.48be61e0@kernel.org>
In-Reply-To: <20251117105708.133020-2-zahari.doychev@linux.com>
References: <20251117105708.133020-1-zahari.doychev@linux.com>
	<20251117105708.133020-2-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 11:57:08 +0100 Zahari Doychev wrote:
> +	if (tc_clsact_add(ys, ifi))
> +		goto err_destroy;
> +
> +	tc_filter_config(ys, ifi);
> +
> +	tc_clsact_del(ys, ifi);
> +
> +err_destroy:
> +	ynl_sock_destroy(ys);
> +	return 2;

Let's return 0 if nothing failed? Maybe:

	if (tc_clsact_add(ys, ifi)) {
		ret = 2;
		goto err_destroy;
	}

	ret = 0;
	if (tc_filter_config(ys, ifi))
		ret = 3;

	if (tc_clsact_del(ys, ifi))
		ret = 4;

err_destroy:
	ynl_sock_destroy(ys);
	return ret;
}
-- 
pw-bot: cr


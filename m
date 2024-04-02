Return-Path: <netdev+bounces-83881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E36894AAB
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6592D286461
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6032217C67;
	Tue,  2 Apr 2024 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMOVRy7G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4CF9DF
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033589; cv=none; b=CKYb9UlG84y5YFx1AoU5acnZUUNh8BnclWIYGYtHo6lxQpIVvoyNU/BB5w+KZugRKiDCtUZUUr4UtbvdA2IOoEw6lfATu/nO8HQ/UsrYxMsOslpeaYvhxc3xUjPsEjEQ+mTweVng8EECKg7gfRSek9Zyks5yQICs2rXM2FY/3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033589; c=relaxed/simple;
	bh=ozDyEikwzlEWA5qTdaqdrlM+WLOHtnhui5XzsiZl3lA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGgFhyBAUJQvi8CZ7sMO+o6e/o55h6gXhZ/QUvtRUvdy+vX96VJjgzRLK9FxpTmhr6pQl5JYRgqKtUdMT1We3ATfirq1KFUsc1QecsYNJmw4o5xO3OGjTY8I64WS4t9dcLWFmq2kUIU8wQ9IKlETTpzsHSRn9RwhLxDMjxC8XLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMOVRy7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB8EC433C7;
	Tue,  2 Apr 2024 04:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033588;
	bh=ozDyEikwzlEWA5qTdaqdrlM+WLOHtnhui5XzsiZl3lA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qMOVRy7G6aK79dWmXri9PyU6pO/4rPF6GqvoG7bGM2SZBO4Fq8ajUPggwGM7ae9er
	 8+BatpM1uC7XG5/Sc1Rq/pFB7+fs1HH2MIW9W3FJCyPNjDe7g2CRSYmIxOe+8yfZ47
	 RZF/4l7d3IzvjqexKLHyLRSCes5Z9je/riRZ/cbgUvwHm/4APLaouyJNbTZ+Bng4S5
	 IngSmq+5JeAQztjetISrsI4kUdJ3hHAp3c8LuKThTuiKmfYn0ff+20mY0Gif+GBvZy
	 0ABM3255hMyJsq+kfdnQeJGxydZ1ShrTAiVSyPkuxM4RmaFvOAICiaZLRZE2nS96u+
	 RRU/pauZU/P7g==
Date: Mon, 1 Apr 2024 21:53:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 gospo@broadcom.com, netdev@vger.kernel.org, pabeni@redhat.com, Somnath
 Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next 2/7] bnxt_en: Enable XPS by default on driver
 load
Message-ID: <20240401215307.5bcb5cb7@kernel.org>
In-Reply-To: <20240401035730.306790-3-pavan.chebbi@broadcom.com>
References: <20240401035730.306790-1-pavan.chebbi@broadcom.com>
	<20240401035730.306790-3-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Mar 2024 20:57:25 -0700 Pavan Chebbi wrote:
> +	for (i = 0;  i < nr_cpus;  i++) {

double spaces here

> +		map_idx = i % bp->tx_nr_rings_per_tc;
> +		cpu = cpumask_local_spread(i, numa_node);
> +		cpu_mask_ptr = get_cpu_mask(cpu);
> +		cpumask_or(&q_map[map_idx], &q_map[map_idx], cpu_mask_ptr);
> +	}
> +
> +	/* Register CPU mask for each TX queue excluding the ones marked for XDP */

don't go over 80 chars when you don't have to


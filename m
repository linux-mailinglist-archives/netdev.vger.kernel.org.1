Return-Path: <netdev+bounces-215944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B38F3B310D1
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856BF1CC72E1
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC052EA470;
	Fri, 22 Aug 2025 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qkaneJXR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y3Ny59KP"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF72EA156
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849126; cv=none; b=aF0v0CLsO7NmjfrbAZQ9Ccd/MhO483TD8hfAndhbyiMJU9Zc42uOq1V74aA+Gn8wDNEswmCAGDGRt63S7WMZZH7RkWuL20z58WPbMPV5H1mvZZac62nH4Eg8OtV+OU5XR5dhgMaVRFo49xsxR6eUZwzZybETz5CyFz38kyIFo/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849126; c=relaxed/simple;
	bh=Pcpbl50wBfCpi+OmANHo4GGazu+sfIyN09F7A1qKNoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKw0CxXQzE7NDAZmI3+CW9kEvIAAzc1OzKz0Izq2TPpiGfSjPRQDWPlhNKbwWVBQOXCpy4GAmBeKO1kuepR2ryTZ8bQ+UCUxAjGnVN3O5eX4JFwyO7KhVprcaGcNRqI4kk0z7S1v6rl1OV3LYBTs0tbw+PzeJ80uLv/NnH392hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qkaneJXR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y3Ny59KP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Aug 2025 09:52:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755849123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LuB0wIddnbP+4zjopaUMUbU6sgEHQXPmThsbxHG7WQ=;
	b=qkaneJXR0AeJbNnQHzhsHKRGhvmpqJpjl6ywTM23njyBMQvjPR1f0Sktqz7VXrzDP5ACQy
	LRrzUREWYwsPxbW4zgdK51+3TmqqShveFhcNCXCrsvmZtUOucBZkA91TZ3Qq0JVpe44RRd
	iQqUWj+kJq72GayNgzQvu8GcK0JKXHHqJDfOAEVilx5NXozLpmFpOD1Tc8zIjmanlOKXqw
	DgIbDW4/FqR9Y+tEGA/wSuhl7Az5YcWO1MxnNrPwTCRonrqAthahgZlTDtNQLeYDwwbISP
	UNn9PTdoe3KTnfRNAx0c/teXFtJ+WxV3QuuEnUjRi1p/NVWlvFrYe3ybXtiNAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755849123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LuB0wIddnbP+4zjopaUMUbU6sgEHQXPmThsbxHG7WQ=;
	b=y3Ny59KPPymX6RcDmJyk6NBNM+AlVWcS/5X9okbyYSna7fWunP1sU1E6kl3kyC8bnaUM+V
	PlPmd6ED/pK7SiBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux
 worker
Message-ID: <20250822075200.L8_GUnk_@linutronix.de>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>

On 2025-08-22 09:28:10 [+0200], Kurt Kanzenbach wrote:
> The current implementation uses schedule_work() which is executed by the
> system work queue to retrieve Tx timestamps. This increases latency and can
> lead to timeouts in case of heavy system load.
> 
> Therefore, switch to the PTP aux worker which can be prioritized and pinned
> according to use case. Tested on Intel i210.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> Changes in v2:
> - Switch from IRQ to PTP aux worker due to NTP performance regression (Miroslav)
> - Link to v1: https://lore.kernel.org/r/20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de

For the i210 it makes sense to read it directly from IRQ avoiding the
context switch and the delay resulting for it. For the e1000_82576 it
makes sense to avoid the system workqueue and use a dedicated thread
which is not CPU bound and could prioritized/ isolated further if
needed.
I don't understand *why* reading the TS in IRQ is causing this packet
loss. This is also what the igc does and the performance improved
	afa141583d827 ("igc: Retrieve TX timestamp during interrupt handling")

and here it causes the opposite?

Sebastian


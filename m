Return-Path: <netdev+bounces-234788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F70CC273C2
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 00:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C03B2A7B
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 23:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A4E330B01;
	Fri, 31 Oct 2025 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNAusNg+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4136632ED5B;
	Fri, 31 Oct 2025 23:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955145; cv=none; b=JpO38GJczoiZQpy8sLhRaFtC1aMY9BGcNYteIHlBYQB2c98WHep7BUIStE6ZjgFIgqlbuRrKFRmISXdPz0SEf7lE7Uyv5AJcbkjI7ryU/99SVsuXuMCS2NKM/C5PZYMa8XJr/as7zhL0GT4iIqN1kvPTOsEgXJPspvDYbbuuWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955145; c=relaxed/simple;
	bh=JGwT6F9oruAfhY5jeIqF9nmUFIJJA6bX/gJldsyQvFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOvebwJGYyqAcutSnjwo7k5JXvEgs+0ktW6AL4F9JxT0vJzrCKRVL6B3Q2Ol2h00agnBXNCVjWqPx4RWPXhZuwRJtiP6UhWwyA92piKnjyC29jGdxxw3F/BH9d5LSFKQh89keTzZwbuklqQAFq4NO/US2bHQ3EoV7grbuTH7lBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNAusNg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8A5C4CEE7;
	Fri, 31 Oct 2025 23:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761955144;
	bh=JGwT6F9oruAfhY5jeIqF9nmUFIJJA6bX/gJldsyQvFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aNAusNg+iF5jSTQEoqvrfibO7wu/fc1TFVPuCCom9o6PKEGgDgUXxcTmkBRLn8hFO
	 Zih2GLZ4e+AjtU1gG89uoA7mbAdePtpAIsfX0g/EdW0R0yp8TCX/gmTnjBaQuKGj82
	 sKc3ZvVAXivgVCqlt2ILgmonhdYL2b0DhZ1G/1TUSOso5R1avLo+Yzg5a8Nl6YhrBI
	 BRT37SK7Qsdn2TLPfI1FrIf4ThyAiwAdh6OMEMJYq2REELZjZYOOq4AgYXy19nfsWH
	 S+AOfrfcNzP9BTg42IaQ9q/7Jfc1c8OrYrcZW1ZewLSbyM1r6arDbh63ehcmsuUOIb
	 mGAh6tFI5TDhA==
Date: Fri, 31 Oct 2025 16:59:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: vadim.fedorenko@linux.dev
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, richardcochran@gmail.com,
 jonathan.lemon@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: ocp: Add newline to sysfs attribute output
Message-ID: <20251031165903.4b94aa66@kernel.org>
In-Reply-To: <20251030124519.1828058-1-zhongqiu.han@oss.qualcomm.com>
References: <20251030124519.1828058-1-zhongqiu.han@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 20:45:19 +0800 Zhongqiu Han wrote:
> Append a newline character to the sysfs_emit() output in ptp_ocp_tty_show.
> This aligns with common kernel conventions and improves readability for
> userspace tools that expect newline-terminated values.

Vadim? Is the backward compat here a concern?


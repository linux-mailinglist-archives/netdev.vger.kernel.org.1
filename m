Return-Path: <netdev+bounces-248310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A2BD06C81
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 03:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A56430115EC
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 02:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0C9205E26;
	Fri,  9 Jan 2026 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhOzb5K1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968A0EAC7;
	Fri,  9 Jan 2026 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924143; cv=none; b=iatxY85octMahK07n+T+4XXwAzUM0jQ4f5K6ocATIdff2/IhHmHLC8amBWA27FT1/6DEO+Knghb7gnfqdlJiXcp0YMGWpWZsbV71n+fv2iRdv07n8WG1xa/PgoKDTDDGZtreBhIXsTq91Hb0V7slV2h5rStlygY+u1w3EjHNToQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924143; c=relaxed/simple;
	bh=/eCUdNyYUdI+5w6t7BPtTqGH0e/ISLcMX+EQQqZiBK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTHpjT/CUTmgfuhfqqNU+inq0ue3SMxcfQ+jeZyLlYwtlsP+zUhxNGZY15vy3AMbWkdXLK9INHoWd17oQwbJXATztngP5xQCT2ODERs8rZRrXfEfNaYif7Em+Q/CzVYJxAFTsa3xHPMAP0js66LOfdKRim5AqrDAn9AoTCNFG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhOzb5K1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0408C116C6;
	Fri,  9 Jan 2026 02:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767924143;
	bh=/eCUdNyYUdI+5w6t7BPtTqGH0e/ISLcMX+EQQqZiBK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MhOzb5K1OqZbh9MBoWBgPE5uG794g5CaQm1U0GLT6EsoVeMo1VMsNX15HUsZ/JALC
	 TphiEbw0U7HfXqno9FKA+Ct8OJZtbmpegbfC51ceZoYy5JFPKMmaMyGT0tloeuyJrn
	 iZMh7AIH6DtZYNsIKO4E1vRz823dkpzvh8nUFCZtZ4A3ZdZf0KdTdUMJZOuaazt239
	 44ICnAxMLU2cMwYwWGGyuM8ktfUEvBdEjONyOA3S1GxSA5Fs9k0Q7A2N5jFRmSKqG5
	 XnWgEpc9gP4Uflw7xifAQYJq0pdV+YsUqjEErCSIVPaNJm5JaaV0CgBdws/ZdOhGGf
	 unB9KnwB3cpYA==
Date: Thu, 8 Jan 2026 18:02:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kathara Sasikumar <katharasasikumar007@gmail.com>
Cc: alex.aring@gmail.com, horms@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-bluetooth@vger.kernel.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: 6lowpan: replace sprintf() with
 scnprintf() in debugfs
Message-ID: <20260108180221.2dbcccf5@kernel.org>
In-Reply-To: <20260106171610.124138-2-katharasasikumar007@gmail.com>
References: <20260106171610.124138-2-katharasasikumar007@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 17:16:11 +0000 Kathara Sasikumar wrote:
> sprintf() does not perform bounds checking on the destination buffer.
> Replace it with scnprintf() to ensure the write stays within bounds.

Aren't compilers clever enough these days to warn about potential
overflows? AFAICT the buffer is 32B so it will definitely fit %d
no matter what.
-- 
pw-bot: reject


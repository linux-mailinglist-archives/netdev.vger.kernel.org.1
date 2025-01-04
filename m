Return-Path: <netdev+bounces-155174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62477A015B4
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 17:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1800A3A36D6
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705DD1C9DD8;
	Sat,  4 Jan 2025 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COsDlN1y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006B1CDA04;
	Sat,  4 Jan 2025 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736007334; cv=none; b=ICVP/bk+m8mpKoN5/xhz/y2opXtYDAI8NOyI4LzYJ/I2XhnXdoRST9GMgSlpfXPDD53/JZFGO88soTnLIfuLhuMgrwMttnE7hOoEt9PBmDqaRPJIMRFl+u9Pbc0EbWLqqmJEABsp9Cib02xG3bN522o2Bb1Xuv8OpcmX8KI+ugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736007334; c=relaxed/simple;
	bh=CzC3HkeHDNX/3MpmOMssKaK78kMCsdyfZ4EaUShTQKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfDplV2ioexv4B3ononOzUgqkHqFX5LtbhwAhUvlEvkKnxbWmAykS8wwOKrcYIRqeL52BX9ixFJwtG2WhxtWAaFjom3hyin5vLYvpnJypDhwHoEZmPbZBwX3H0wcohg8RRKV11Gr6LCNirPBF8j9P5aU+TV1dMpdY+1uDVHgXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COsDlN1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340D9C4CED1;
	Sat,  4 Jan 2025 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736007333;
	bh=CzC3HkeHDNX/3MpmOMssKaK78kMCsdyfZ4EaUShTQKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=COsDlN1ytbEp2sPX8XRvKVebAnnt+LyAebyzntUvIIp18MASGX5HUKi5FKR5P4IKo
	 AQG1+ZX7ttCSS4Iodc1iT1A0YNIbTNDzjL02P5r93/7QscSF9JE6uxabM76LdkPhPb
	 e4o4Da7IHt4GEPlmJVhnS7rClZDUTFFXvPgpk2STloCoN9HIpp3KfD4olxoELQQVWk
	 p1xn0E4oF/O39OCLNHY6WbcN2Qer93vj4VDlmIBhPlqDxZ+ezx38JYFYI6Qs6CjzRj
	 FBjyKC1xkVaZnQf1i7S15HKcbf9HjjX80t2X/8oZoVt4CRllcqRa6+o5q3G2zTQs+z
	 /agb1UtZ3CffA==
Date: Sat, 4 Jan 2025 08:15:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: linux@treblig.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ixgbevf: Remove unused ixgbevf_hv_mbx_ops
Message-ID: <20250104081532.3af26fa1@kernel.org>
In-Reply-To: <20250102174002.200538-1-linux@treblig.org>
References: <20250102174002.200538-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jan 2025 17:40:02 +0000 linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The const struct ixgbevf_hv_mbx_ops was added in 2016 as part of
> commit c6d45171d706 ("ixgbevf: Support Windows hosts (Hyper-V)")
> 
> but has remained unused.
> 
> The functions it references are still referenced elsewhere.
> 
> Remove it.

This one doesn't apply, reportedly.
-- 
pw-bot: cr


Return-Path: <netdev+bounces-155175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF3A015B7
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 17:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482BE3A1CE6
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 16:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7F41C3BF2;
	Sat,  4 Jan 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZhMUqlY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780BF13777E;
	Sat,  4 Jan 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736007398; cv=none; b=I4DyEu/0ms2EM24Utt7/WaWqthL+jaNfsRhEBWZqbzurEib2VdfJ0FE+LpCAJh1Q/OzlJc7pFt3JuZy8a7mqhunKgW64IR2fG6SoJKNAnO1SYjql0r0qOCcfbJNcVSHSj0RVUjWwjpfLhRUf2TRcu6gtrkxVKTJ6JErMIini2Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736007398; c=relaxed/simple;
	bh=Uc6qdJfu66gVhHg+Q7F+ADZ/cf3XWU+07EGpH2Oy4Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgyIjVV6dPtf9fc9k1Xl/7Ngyjhd8Qm9gzlml83PWqkDRUxfSku9hsQXKgFZT2HYQmtHUqjyMrWyD1dgsRcjxgedy+Ze1/S88s5eaPlra7xcGpEIsKek9tk3JADRZ0EtE//xIUolsQYeQrI5sqiV6lhU7kyJVWnRFGgMm/5z22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZhMUqlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50B2C4CED1;
	Sat,  4 Jan 2025 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736007398;
	bh=Uc6qdJfu66gVhHg+Q7F+ADZ/cf3XWU+07EGpH2Oy4Y8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RZhMUqlYLZPo/QJBPdN8XTSQUtpJ+LC6RMeI5gL2fmju3/tSS5wVkg+hgzQx//9W2
	 r5rJPv1nhkgcCIs7gGVIjCl4H6guQn46AqSsoU6//3g0KpdhgEQ3DoD9pEKDFTQPd1
	 Gjl5t807jJ8OIEbs+yEoxexrbhBuuH5aXR5UaJ/OmD1io8utGLrtRMjY+WgtkdyeRF
	 q/vj7B0SMNSGw21D1K19VE6LKQyiWtl/95xcGzYEZr3YHKSU1PODZtsX1LoDN4EVv1
	 M6jI0altwdfEnaQfybV3Ci+d9ygsi1fXed9MyfBLBn2WyVlP5syBegEZZEMmHFnCpW
	 PumPbu0B4Gs6g==
Date: Sat, 4 Jan 2025 08:16:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Cc: linux@treblig.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/9] i40e deadcoding
Message-ID: <20250104081636.67a10134@kernel.org>
In-Reply-To: <20250102173717.200359-1-linux@treblig.org>
References: <20250102173717.200359-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jan 2025 17:37:08 +0000 linux@treblig.org wrote:
>   This is a bunch of deadcoding of functions that
> are entirely uncalled in the i40e driver.
> 
>   Build tested only.

Intel folks, is it okay if we take this (and the igc series) 
in directly? Seems very unlikely to require testing...


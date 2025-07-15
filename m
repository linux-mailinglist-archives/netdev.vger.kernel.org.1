Return-Path: <netdev+bounces-207165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 410EFB0614B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC661C4582B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678EB22D4DC;
	Tue, 15 Jul 2025 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnzS5yZ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4492746A;
	Tue, 15 Jul 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589590; cv=none; b=Y6D2ycJ4KxmdgrywMiN8YuJli66ilTTwGyUe4jCSG9gf5chJPsm+CHzHx0VKkCPEgcNqtg+HsYjjUZ2R3mxeykBxYEUYbejjI1bX5FfHLnRrRxWpjf/VtdUZE3YmnVk5ujyv2kXbnSnVUQsT/BVeCvn7vP4V8QaVNRJqd3uVzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589590; c=relaxed/simple;
	bh=BQT5Anm/LwSdreSD97n0j7a+aRIureUq0ROXs9M/X9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMVB0UEc7K0c/G3sDXqTR3iqL2cDYMtbWR9/zCRXVPM3eKM6eVc/h6rTd91D6Ca+9Dzh4kPZGBiIfgUoUmtpKoRcM/5G9Z3uULlf2Mie9ZPl456DEVVq2NXBaJ/aPxSAUZbf3JQCR9uVCy/QGpikfUDOP7oFa2s57/w5e7rl7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnzS5yZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AF0C4CEF1;
	Tue, 15 Jul 2025 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589589;
	bh=BQT5Anm/LwSdreSD97n0j7a+aRIureUq0ROXs9M/X9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AnzS5yZ7099FCAh3ZYWM8rfGFPc7kGX0AyWSn8r+2TwRiaroKLt6tPjumbACLtEu0
	 xYVA8xELtwo2FtHwlcOtbKbm8JONwBZdppSHb0HNC8+8wf4ZUEIdfvBxBVEr28TmTt
	 ZJrWtgnuwz+2pfue7et7cRh6FxqawEQD4JtWexXgG15VxQpvP2ELRupBsQ5ixY7wzY
	 bsoMgSjIx6dmeKRxfRi6GtKED8Epe2TTN+TzqlTh5DXFubmY9BljDKqHZPqO4qECGa
	 F5P/kGRTlRJfrsuqCba0XgaQkobpkOn0jOlAvSel3akD7LhsJ+54h3M/zYprPpqpVX
	 FKI9hL7z/foKw==
Date: Tue, 15 Jul 2025 07:26:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: Convert Marvell Armada NETA and BM to
 DT schema
Message-ID: <20250715072628.1cf048b7@kernel.org>
In-Reply-To: <20250702222626.2761199-1-robh@kernel.org>
References: <20250702222626.2761199-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 17:26:24 -0500 Rob Herring (Arm) wrote:
> Convert Marvell Armada NETA Ethernet Controller and Buffer Manager
> bindings to schema. It is a straight forward conversion.

This still needs review, and it's getting close to the 2 week threshold
where some patchwork instances will automatically archive the patch.


Return-Path: <netdev+bounces-135706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA9999EF8C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8234A1C2465F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6713212A;
	Tue, 15 Oct 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7Ah1MXA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF991FC7CF
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002400; cv=none; b=NDGI0LL+oU0PCT4sVgZMXSE19OK/bK5789XKg9NQlg1iBEsgjBnaVkOat05bsxsftzWxZKd34vq9n6Ds22KPrLYo7YFvnnC8j5NX4MyVs2HgvBtwi6VoVr7NLRrQ9Xg2LT1Mrp8RfzaiNmEEtVng29Gmjt/sKIwcfTHnsiH7Xo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002400; c=relaxed/simple;
	bh=SwD1LjgpJqRB9NNikJM9tV+R8NMokfWJ9x230kI7cyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oq7m8qV8uJkjTEZIT+OsJY9AYBQ1zpQsVfk0aixijZHS5ULBcwDTGePXX66sGP0mobdFr+AKhtv2cZWA1LSIzAjLNFlLkrvpFaxqlHlZCetuG2lQ8dO3jdT2gIeXOwoBxRXVYL1aFdj/B6qFgbRY5xLjiEH2CCIqxuuvDM+Espc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7Ah1MXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E9BC4CEC6;
	Tue, 15 Oct 2024 14:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729002399;
	bh=SwD1LjgpJqRB9NNikJM9tV+R8NMokfWJ9x230kI7cyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P7Ah1MXAxOZYZDcL3B6au/zoj0D0udUJzSkDNU/Do9DbS/oF9HFWWQFsCf+WqUmBz
	 LDFyNSNYmv2o5p550x1cmvU657Pj0LL3nyML4AXtWqJKwVI9f7bIYWKpv6uDA//czo
	 ICMenEynAb4L+IawwI3KOXJ+BYAjlgqyf4XbQkAxg5YRZtZ8xLl0OcMhrouo6msUb1
	 6iuex+DehCaTXQD5DlqXOYpT+cMURBMPvuNAzif3u0TN5/E/Gj6MTPE1zdla6B+1QV
	 kFZZNe84FP1BY2CcV00xzFI14Yxxhrw+Qu1BUKSkbJuDuw1DnS545pis/+9qlVz/d/
	 PDjjWZ6BvfEMQ==
Date: Tue, 15 Oct 2024 07:26:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Message-ID: <20241015072638.764fb0da@kernel.org>
In-Reply-To: <20241014081133.15366-2-jiri@resnulli.us>
References: <20241014081133.15366-1-jiri@resnulli.us>
	<20241014081133.15366-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 10:11:32 +0200 Jiri Pirko wrote:
> +    type: enum
> +    name: clock-quality-level
> +    doc: |
> +      level of quality of a clock device. This mainly applies when
> +      the dpll lock-status is not DPLL_LOCK_STATUS_LOCKED.
> +      The current list is defined according to the table 11-7 contained
> +      in ITU-T G.8264/Y.1364 document. One may extend this list freely
> +      by other ITU-T defined clock qualities, or different ones defined
> +      by another standardization body (for those, please use
> +      different prefix).

uAPI extensibility aside - doesn't this belong to clock info?
I'm slightly worried we're stuffing this attr into DPLL because
we have netlink for DPLL but no good way to extend clock info.

> +    entries:
> +      -
> +        name: itu-opt1-prc
> +        value: 1
> +      -
> +        name: itu-opt1-ssu-a
> +      -
> +        name: itu-opt1-ssu-b
> +      -
> +        name: itu-opt1-eec1
> +      -
> +        name: itu-opt1-prtc
> +      -
> +        name: itu-opt1-eprtc
> +      -
> +        name: itu-opt1-eeec
> +      -
> +        name: itu-opt1-eprc
> +    render-max: true

Why render max? Just to align with other unnecessary max defines in
the file?


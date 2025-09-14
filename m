Return-Path: <netdev+bounces-222889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5E2B56CA0
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 23:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1F03B9864
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC801FBC92;
	Sun, 14 Sep 2025 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVe0CahP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE00192D8A;
	Sun, 14 Sep 2025 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757886351; cv=none; b=i5bzNzELGx2kZOU0ZdTSJwTsJHVRH6yKGymIaBmKwtDx4nJ5pCQX4ccKN635Rqyp/CF2GqDbdqebXoczqSVq+lqgBaqHpy3KaUfpy+8EJ7mnOl3wHXjhhGpPL8rK/J532wJ4uOpbXObWAIBkg5zBocY6MJlDV0UXyH5hrhJZFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757886351; c=relaxed/simple;
	bh=PYuyqZRGrl0BoDAtblCL5VEywWNNDkx+2UfVtcus59c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfuER6nIRzkfTYOS79fRulRWQSWiDUjZaQSZLWF+drVZseE2/PLExyjRg2w65590hadHw+tXoXQ/QNiLPTQxhAJ3rVjYAJR/I/Ezj/i3Uhjlt0p9lFKSAecht8c59CJ/5HqVma2MrLD2zcOpJCIYWZt7m4F+LKZOUIbm+GyZjg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVe0CahP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8823DC4CEF0;
	Sun, 14 Sep 2025 21:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757886351;
	bh=PYuyqZRGrl0BoDAtblCL5VEywWNNDkx+2UfVtcus59c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MVe0CahPumcseRpF6VvQrIZLiZsPIvXwd7J/gYWncGAW6kzBTmkctFinBAlaXk/Zf
	 yH5zh4TPE6u21DoUmg04B5tLZCqAxDv3TZ6OUOJ/NGMSElXcNSd766ZuvQ7RGeddQ6
	 Lf6GaUSNfJrrYuAWp4qnLcD4SBeOcB+kxUWLM6bjS0TePUaVbiDP6MHaeNTHqusfNP
	 dKtmAs6h5DBXQ5AM4Xw3rhzL2vA4hQB8turt2HkshDreHU2qLOksvhgJ8+qQyTHFYx
	 5N3yMlzgV0xJ56dVI1iWrpNBQdO+l3TJ2qCg/xFwgSLq0DX9ezprfqxTJ1NkgOJn3R
	 A+ClW9j0FEmoQ==
Date: Sun, 14 Sep 2025 14:45:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Prathosh
 Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, Petr
 Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v6 3/5] dpll: zl3073x: Add firmware loading
 functionality
Message-ID: <20250914144549.2c8d7453@kernel.org>
In-Reply-To: <20250909091532.11790-4-ivecera@redhat.com>
References: <20250909091532.11790-1-ivecera@redhat.com>
	<20250909091532.11790-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Sep 2025 11:15:30 +0200 Ivan Vecera wrote:
> +	/* Fetch image name and size from input */
> +	strscpy(buf, *psrc, min(sizeof(buf), *psize));
> +	rc = sscanf(buf, "%15s %u %n", name, &count, &pos);
> +	if (!rc) {
> +		/* No more data */
> +		return 0;
> +	} else if (rc == 1 || count > U32_MAX / sizeof(u32)) {
> +		ZL3073X_FW_ERR_MSG(extack, "invalid component size");
> +		return -EINVAL;
> +	}
> +	*psrc += pos;
> +	*psize -= pos;

Still worried about pos not being bounds checked.
Admin can crash the kernel with invalid FW file.

	if (pos > *psize)
		/* error */

Also what if sscanf() return 2? pos is uninitialized?


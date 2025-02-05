Return-Path: <netdev+bounces-162837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6B4A281E1
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6555B18860EE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 02:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D11200A3;
	Wed,  5 Feb 2025 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAf1OaNH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B7EAD0
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738723037; cv=none; b=hHL2xTA21tnicT0vm1sd5BtMUL/j3qTVv4x/FVYMa3VyiXB1rvibqOadMmeVWKZp+sPEPo/Iyq0B0GPfcmmuEmgjPqH6dAb4IZuFKlvRQf28gh9Pn4L16yS1PGErXldVVCQAqxf6k7J99nVLYeswtwHbHtj2tnBWvYuBnnMkTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738723037; c=relaxed/simple;
	bh=FF85+HxXlWBrw/2UFMwJHB+TGmNDf8/xSe+ql3+lxzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9qrM4oD5R+ChnUC24EDfNZQPxXKXKUO+FZ3ISCSSIL0M9qUEXokoBXrTmOKsv2RI//2xjFn1aV2NM8xMubL+6dBtNa4M2m9AlosfsRtQZB+g+bN8QXHl/du2KIXXYxjDKpkopRG/lIEjK35xSoe7hQFOelLfTdQHP4a3TvU4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAf1OaNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A850CC4CEDF;
	Wed,  5 Feb 2025 02:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738723035;
	bh=FF85+HxXlWBrw/2UFMwJHB+TGmNDf8/xSe+ql3+lxzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VAf1OaNH5pldm/mcRBBkJz1kJ9NWXlewLEj2HnC/P9X6/EbW6FsCDii9R56V2fOXv
	 MGp3d31eJDYDtRFa2VCI7zrEFO7z8/+xMi7m+ThG7BtG1oqv8UZDOrDF7xRWbEz9lm
	 y3Qav1KTa6Qg/ZpnvrKcvnG7kPJg8agO/PWVItL+tMk/Wat+ZU9sOPSWxMQoOHy2eI
	 wKvAQPkY/UxnweAveGP5e6qUDcmPuwk/Rl6Nu25JixQeOgCkba7w+Kwls3C/6IEX0g
	 C47O7+NmpNdT4rh8Egsf6p/vPnEbvwg53JUckIGeI/tgacDTUlCD74RCHwjeJlby3z
	 5FAQ/PmkheBZw==
Date: Tue, 4 Feb 2025 18:37:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <mkubecek@suse.cz>, <matt@traverse.com.au>,
 <daniel.zahka@gmail.com>, <amcohen@nvidia.com>,
 <nbu-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next v3 10/16] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
Message-ID: <20250204183713.5cf64e08@kernel.org>
In-Reply-To: <20250204133957.1140677-11-danieller@nvidia.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
	<20250204133957.1140677-11-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 15:39:51 +0200 Danielle Ratson wrote:
> +	if (is_json_context())
> +		print_string(PRINT_JSON, "description", "%s", description);
> +	else
> +		printf("%s %s\n", pfx, description);
> +
>  	if (map->page_00h[SFF8636_EXT_ID_OFFSET] & SFF8636_EXT_ID_CDR_TX_MASK)
> -		printf("%s CDR present in TX,", pfx);
> +		strncpy(description, "CDR present in TX,", 64);
>  	else
> -		printf("%s No CDR in TX,", pfx);
> +		strncpy(description, "No CDR in TX,", 64);
>  
>  	if (map->page_00h[SFF8636_EXT_ID_OFFSET] & SFF8636_EXT_ID_CDR_RX_MASK)
> -		printf(" CDR present in RX\n");
> +		strcat(description, " CDR present in RX");
> +	else
> +		strcat(description, " No CDR in RX");
> +
> +	if (is_json_context())
> +		print_string(PRINT_JSON, "description", "%s", description);
>  	else
> -		printf(" No CDR in RX\n");
> +		printf("%s %s\n", pfx, description);

I think the description fields need to either be concatenated, or an
array. Otherwise the parser picks one:

from the commit msg:

$ cat tmp
[{
        "extended_identifier": {
            "value": 207,
            "description": "3.5W max. Power consumption",
            "description": "CDR present in TX, CDR present in RX",
            "description": "5.0W max. Power consumption, High Power Class enabled"
        },
}]

$ cat tmp | jq
[
  {
    "extended_identifier": {
      "value": 207,
      "description": "5.0W max. Power consumption, High Power Class enabled"
    }
  }
]


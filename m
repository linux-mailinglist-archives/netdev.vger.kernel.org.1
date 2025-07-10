Return-Path: <netdev+bounces-205957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0B1B00EC1
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259A51C253B9
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AEE29993F;
	Thu, 10 Jul 2025 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc/tWv5E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA32B4C97;
	Thu, 10 Jul 2025 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752186864; cv=none; b=bICGZYdWBCIXj74Y5aQ7ux0vP9S9W9vcHrnzO7EMgfNy1k6sDDWMjn7JdPGChQB90yE3dl/hzfzOx0OET2j880P6gtgfDjSf4eC13D82GpY7GXZ5zO4fzeREje6zGX+qYv+ybnw30oScfLyeI/SFdeFu820qBLd4SxpiMRcK9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752186864; c=relaxed/simple;
	bh=fiQ+r1dEdNFy0rz1u3DLw+SW3/t8Uhox09RRVZ6VsF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e39cCsagfj12IvmYBmlH6VM0F4y9PWboOErlEuRm7Ybt2BLNGKQCnWYx+/pET0T9QmEImU1icCwWOQmB0LB66P52g0Wv1GuBLJMSRvlRKr7Txg+KDIq1WlyzOflrpzwqUeli49OPSX+KA4FQkurIqKNGbqMcSxfexrmturigAW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc/tWv5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2FEC4CEE3;
	Thu, 10 Jul 2025 22:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752186863;
	bh=fiQ+r1dEdNFy0rz1u3DLw+SW3/t8Uhox09RRVZ6VsF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fc/tWv5ExM9kQzZfwreUNrAEzZaXHMZngvuipNISTG215QQvF5cy8amNoKq0FGXMh
	 u26vFaKFi9bvv3hmodKnY/j/jLvkNuR4W9PHtJEwMIiO4ME7mXDiQdipdv/QPnN5d/
	 NiWGZBxjbeXiP+ZjL3Ipjb9aZB48eoDZUt6tX+pCd+m4q64no95Ih/OWJKHk3BUuqM
	 IEdC/0Khd5yw3AA/UAkzcxucHmll5F5uB+WUBMn8O/FsPmbiLo982/HcZKY9GyI7L5
	 ERVknyUfDDyJCAbMlBDIOI9zs69c9o2CQbxENO97Pn617swxj+wLQrNm4Wb+wg1tSJ
	 BOLdeBAMZb7NQ==
Date: Thu, 10 Jul 2025 15:34:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 darren.kenny@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: thunderx: Fix format-truncation
 warning in bgx_acpi_match_id()
Message-ID: <20250710153422.6adae255@kernel.org>
In-Reply-To: <20250708175250.2090112-1-alok.a.tiwari@oracle.com>
References: <20250708175250.2090112-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  8 Jul 2025 10:52:43 -0700 Alok Tiwari wrote:
> Increase the buffer size from 5 to 8 and use sizeof(bgx_sel) in
> snprintf() to ensure safety and suppress the warning.
>=20
> Build warning:
>   CC      drivers/net/ethernet/cavium/thunder/thunder_bgx.o
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function
> =E2=80=98bgx_acpi_match_id=E2=80=99:
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:27: error: =E2=
=80=98%d=E2=80=99
> directive output may be truncated writing between 1 and 3 bytes into a
> region of size 2 [-Werror=3Dformat-truncation=3D]
>     snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
>                              ^~
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:23: note:
> directive argument in the range [0, 255]
>     snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
>                          ^~~~~~~
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:2: note:
> =E2=80=98snprintf=E2=80=99 output between 5 and 7 bytes into a destinatio=
n of size 5
>     snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);

Hm, why are you making it 8 when the max length is 7 ? =F0=9F=A4=94=EF=B8=8F
--=20
pw-bot: cr


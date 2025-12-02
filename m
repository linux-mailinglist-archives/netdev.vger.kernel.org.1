Return-Path: <netdev+bounces-243142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB1FC99F43
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 04:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B7544E0560
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 03:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A8A22A7E0;
	Tue,  2 Dec 2025 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="A2aYpVB8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D6223328
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764645565; cv=none; b=Zmfvxw+z7NKhT46Kn4U3/tX/Mkm2NTnqeJANm5eA2VC69ZfpJasB/6NI3B0XOhtyeConMmxDX/p/cj4ueXlOyP9vVkiVZBuOcyLe5v0vQ9ef72ivylYfaFSmQgwO34cTy/oV7dmevHYal/3NSH1D6OMShaWxopMLQbtRY1dRd8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764645565; c=relaxed/simple;
	bh=PQO8P0EcfdtlmaQNa+wydxm7MvouAUY/73VrshyJLZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZNLQBTgWw49Bw7PNCc0RXmPW+X+FcmA2B2ROgMe0J6laCg2oQq2uhlm0l1Kt9veNd7+yyY3BxmrQ2y9RHJlUgNM9lIssiXWyIMrIB8kc5qQmDGEVeJAvCfHDiFjdcXeUOP66IhyQPtLFTt2/H5lq/vE5/j4xlyrS3xIvgbyeOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=A2aYpVB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704DEC4CEF1;
	Tue,  2 Dec 2025 03:19:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="A2aYpVB8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764645562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwzhGNgaP1nJUO/Y7SABFoMH2bHZZLTilVZVJ05w338=;
	b=A2aYpVB8jWy/+gjAtyKVVFtsO/jNlUeiVcOnViEz3uQlxDPgkcEFzGpVIOSp8ZcmiunXHh
	ftDjRdnHv7qcpPL4dezCql1p1Ra42yPSFH7RYu8xXGK6L/4sgbqHoWD+v4tw8jM/4HwyYE
	X6fEOFFebc7LFeFNKNxSB0gm5aVqZ3c=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5b828229 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 03:19:22 +0000 (UTC)
Date: Tue, 2 Dec 2025 04:19:27 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 00/11] wireguard updates for 6.19
Message-ID: <aS5av6CuCukeFO3G@zx2c4.com>
References: <20251201022849.418666-1-Jason@zx2c4.com>
 <20251201150729.521a927d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251201150729.521a927d@kernel.org>

Hi Jakub,

On Mon, Dec 01, 2025 at 03:07:29PM -0800, Jakub Kicinski wrote:
> On Mon,  1 Dec 2025 03:28:38 +0100 Jason A. Donenfeld wrote:
> > Please find here Asbjørn's yml series. This has been sitting in my
> > testing for the last week or so, since he sent out the latest series,
> > and I haven't found any issues so far. Please pull!
> 
> Hi Jason! Thanks for the quick turn around! You say "please pull"
> did you mean to include a PR in this or should I apply the patches 
> from the list?

I meant from the list, because this is what Dave preferred way back
when, when WireGuard was a young pup. I actually prefer sending pulls,
as it feels less redundant and generally unifies my flow with how I
submit my other trees to Linus, and plus it means you can check a signed
tag. So I'll make a pull here, below. That gives me the opportunity to
drop the buggy 10/11 patch too.

===

Hi Jakub,

Please find here Asbjørn's yml series. This has been sitting in my
testing for the last week or so, since he sent out the latest series.
I've dropped the yml sample code, as he found an issue in that last
minute, but otherwise, we've sat on this code for long enough, so let's
see how it goes.

Thanks,
Jason


The following changes since commit 0177f0f07886e54e12c6f18fa58f63e63ddd3c58:

  Merge tag 'linux-can-next-for-6.19-20251129' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next (2025-11-29 17:45:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/wireguard-linux.git tags/wireguard-6.19-rc1-for-jakub

for you to fetch changes up to 3fd2f3d2f4259df19eec3ea5a188d7c50a37e216:

  wireguard: netlink: generate netlink code (2025-12-02 04:12:49 +0100)

----------------------------------------------------------------
WireGuard updates for Linux 6.19-rc1.
----------------------------------------------------------------

Asbjørn Sloth Tønnesen (10):
      wireguard: netlink: enable strict genetlink validation
      wireguard: netlink: validate nested arrays in policy
      wireguard: netlink: use WG_KEY_LEN in policies
      wireguard: netlink: convert to split ops
      wireguard: netlink: lower .maxattr for WG_CMD_GET_DEVICE
      wireguard: netlink: add YNL specification
      wireguard: uapi: move enum wg_cmd
      wireguard: uapi: move flag enums
      wireguard: uapi: generate header with ynl-gen
      wireguard: netlink: generate netlink code

 Documentation/netlink/specs/wireguard.yaml | 298 +++++++++++++++++++++++++++++
 MAINTAINERS                                |   1 +
 drivers/net/wireguard/Makefile             |   2 +-
 drivers/net/wireguard/generated/netlink.c  |  73 +++++++
 drivers/net/wireguard/generated/netlink.h  |  30 +++
 drivers/net/wireguard/netlink.c            |  68 ++-----
 include/uapi/linux/wireguard.h             | 191 ++++--------------
 7 files changed, 448 insertions(+), 215 deletions(-)
 create mode 100644 Documentation/netlink/specs/wireguard.yaml
 create mode 100644 drivers/net/wireguard/generated/netlink.c
 create mode 100644 drivers/net/wireguard/generated/netlink.h


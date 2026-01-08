Return-Path: <netdev+bounces-248218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCB5D05809
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0996330B8911
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE002ECD2A;
	Thu,  8 Jan 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAhz5yjL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67872EC0B5;
	Thu,  8 Jan 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895195; cv=none; b=hegPA06oYvTmtk5u/lbDl4qmJZ08vnHj7ftQnH/SbtF+ZByxOgS7qjhBEIJZI8JHc+XTdfwnoSG7EydZKkoy+cAbiBzIBr3FuL85vqdeUapjjEp1RrNXV8ECqTVDzd8Ri08ycQi+DL5+mOgF98O0J0RKHBocciTnYB3AbsFDBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895195; c=relaxed/simple;
	bh=VS56+iHIwd0KOuIb+PXgF9rBDOZqhRNZV1FUYSuWDpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWot6GouRu8VL4OL4m/PdcuFuNiNth9IWkEWarxFAaslesQqAOYoCq2CBirhSQYHftMBqrzHSZwtSshN7Pyo1IDhfYOq+mCe+F/xx4xDQvJc1p6jF5WUd0jP9Yju5LrXBua/wT/D2J04CRH3poLXhDqSAvI5GAGMxVDetXFQ6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAhz5yjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE5DC116C6;
	Thu,  8 Jan 2026 17:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767895195;
	bh=VS56+iHIwd0KOuIb+PXgF9rBDOZqhRNZV1FUYSuWDpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAhz5yjL6nQDZ8HKQZuDJVGQHvPKYqPunLwgEMdzrMbcKJrsb656s5iADUgqG3/5O
	 lejfjZ247pUxqt6Szg/mmf6t8sjN6qLnps+LjzEkf9ax2jfUEzMGbxbH5KRbEB4JNU
	 CkpZ+seRXVTg4OBAU1I3Xz8SQVfqiIyKfoKTjZtMdGMPNyoo8uwThvYuO+Z7jmG3IN
	 LvUij3Y9MD7fJekpZDgk8Lgj2TrV8scbrlysPayU6FG8E9fZ0iQl0ohPYYr2GHmJuO
	 +XItFOjC6xdx5o45xZcEZFlxDC9GRZsYu7VJUCZioerife92TPAjV3+fQp6cijT9Kb
	 ayUoRJBbst5YA==
Date: Thu, 8 Jan 2026 17:59:50 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch, sgoutham@marvell.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Suman Ghosh <sumang@marvell.com>
Subject: Re: [PATCH net-next v2 03/13] octeontx2-af: npc: cn20k: Add default
 profile
Message-ID: <20260108175950.GK345651@kernel.org>
References: <20260107033844.437026-1-rkannoth@marvell.com>
 <20260107033844.437026-4-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107033844.437026-4-rkannoth@marvell.com>

On Wed, Jan 07, 2026 at 09:08:34AM +0530, Ratheesh Kannoth wrote:
> From: Suman Ghosh <sumang@marvell.com>
> 
> Default mkex profile for cn20k silicon. This commit
> changes attribute of objects to may_be_unused to
> avoid compiler warning
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 170 +++++++++++++++++-
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  18 ++
>  .../marvell/octeontx2/af/npc_profile.h        |  72 ++++----
>  3 files changed, 223 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index bc52aafeb6a4..8f3f9cb37333 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> @@ -7,9 +7,13 @@
>  #include <linux/xarray.h>
>  #include <linux/bitfield.h>
>  
> +#include "rvu.h"
> +#include "npc.h"
> +#include "npc_profile.h"
> +#include "rvu_npc_hash.h"
> +#include "rvu_npc.h"
>  #include "cn20k/npc.h"
>  #include "cn20k/reg.h"
> -#include "rvu_npc.h"
>  
>  static struct npc_priv_t npc_priv = {
>  	.num_banks = MAX_NUM_BANKS,
> @@ -21,6 +25,170 @@ static const char *npc_kw_name[NPC_MCAM_KEY_MAX] = {
>  	[NPC_MCAM_KEY_X4] = "X4",
>  };
>  
> +#define KEX_EXTR_CFG(bytesm1, hdr_ofs, ena, key_ofs)		\
> +		     (((bytesm1) << 16) | ((hdr_ofs) << 8) | ((ena) << 7) | \
> +		     ((key_ofs) & 0x3F))
> +
> +static struct npc_mcam_kex_extr npc_mkex_extr_default = {
> +	.mkex_sign = MKEX_SIGN,
> +	.name = "default",
> +	.kpu_version = NPC_KPU_PROFILE_VER,
> +	.keyx_cfg = {
> +		/* nibble: LA..LE (ltype only) + Error code + Channel */
> +		[NIX_INTF_RX] = ((u64)NPC_MCAM_KEY_DYN << 32) | NPC_CN20K_PARSE_NIBBLE_INTF_RX |
> +				 NPC_CN20K_PARSE_NIBBLE_ERRCODE,

Hi Suman and Ratheesh,

NPC_CN20K_PARSE_NIBBLE_ERRCODE isn't defined until the following patch,
so this results in a build failure.

...


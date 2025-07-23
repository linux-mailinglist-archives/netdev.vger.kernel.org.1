Return-Path: <netdev+bounces-209483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E61B7B0FAE1
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 21:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AC1188FD8D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D36F212D83;
	Wed, 23 Jul 2025 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="edj+1Zey"
X-Original-To: netdev@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD552208994;
	Wed, 23 Jul 2025 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753298368; cv=none; b=LUcv6yeOUaFDqeh6D+Cv0sZTPzZo6kMD2vN2SRS/pjWMjaV8q/XkppUbDCe3zvFH2D4NvRyOsRdDx17Qrc43xbomcOJCTXsUl7krRDQBKqG3c/Foka+FUPB5bOVOBKk4AMRQSpK8K4ro4Abm2THRjJbOcYxyQUa5pZTPoj2th6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753298368; c=relaxed/simple;
	bh=FvY0SQaUZbTcc7+BcW62wVkk1vw9BfWsz/WTViyM9RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBR+tvYHwaBgximfDVKkYnDTPs0iPBXxXtqVFbK4bBdgdLP3n5wcaS66ej3iN716gzh8pgnSyV0CqOABx6s9r1iLkiHLkl354NOcUrldk737DL3LG7ZQDnX0OoejIAPdze1msnbGQhir6H4zUtgJqnLscKJbd9Zi2R6Z7H21fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=fail smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=edj+1Zey; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1753297854; bh=FvY0SQaUZbTcc7+BcW62wVkk1vw9BfWsz/WTViyM9RY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=edj+1ZeytZ0MfIPn8lOLXBuihtwqJonl+5jIPFB0VXEX/lvX1XbY83pHxGxdodoaT
	 03F4bFCB98ImY/iIjzMLjARYkOpwwIC2GaYHn3ufG5NAAmybf6HM138h8TELeUEuwl
	 hYQFQkUzfNB2Kqng+WfMQ1rLOBFTTc1sA20BAA5o51tMSUUCIQpCI+No01aCywwOmv
	 IYdL2rytX506zEvlxkx7DD3l4Quf5lJzgVf8xqdTI54i6zMo5ivxMsCXTiYIHW91jT
	 X+o6WEpJBLWwKVvIoheeIpQVNYrMKbblJgxyFie4wTyTs/PBdtfN2IdXRHPVffuPtz
	 1plUzHIwgxLsCXboeQu6mkFGltNOAMefk1SornG05k6lM1XtPGl2xJh5Abxuq9YBcs
	 /dO4X5vAh/84MYS3bXfXqNCPZeQAgeQYUfjo9ymdloUXqFO+WvzH9H20SZueGX47U0
	 1Axu9Gpz9i8cEhgk7Ges+F3AxXjUtaDmHYX1+VQEcXHlG0wcP8AbRWjmJ78Xuuvdku
	 /r1JRTtKu6ZB6ov61ptsWWRLqdr2or/wnuCsGsF3QNgQwxszDcoqermU6z+OAJpIWh
	 9suwMzUB3zgJV+vuSCM45tb+iqfggXXFEUzkxk/czDHW2hQzBunok9OpHmVrfHRhJe
	 zWgwsflE4blh/n1vygQhleH4=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 4F54F160433;
	Wed, 23 Jul 2025 21:10:54 +0200 (CEST)
Message-ID: <da2050d1-660c-48ee-8635-0f359880f713@ijzerbout.nl>
Date: Wed, 23 Jul 2025 21:10:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PatchV2 4/4] Octeontx2-af: Debugfs support for firmware
 data
To: Hariprasad Kelam <hkelam@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
 gakula@marvell.com, jerinj@marvell.com, lcherian@marvell.com,
 sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, bbhushan2@marvell.com
References: <20250720163638.1560323-1-hkelam@marvell.com>
 <20250720163638.1560323-5-hkelam@marvell.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20250720163638.1560323-5-hkelam@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 20-07-2025 om 18:36 schreef Hariprasad Kelam:
> MAC address, Link modes (supported and advertised) and eeprom data
> for the Netdev interface are read from the shared firmware data.
> This patch adds debugfs support for the same.
>
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
> V2 *
>      fix max line length warnings and typo
>
>   .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +-
>   .../marvell/octeontx2/af/rvu_debugfs.c        | 162 ++++++++++++++++++
>   2 files changed, 168 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index 0bc0dc79868b..933073cd2280 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -664,7 +664,12 @@ struct cgx_lmac_fwdata_s {
>   	/* Only applicable if SFP/QSFP slot is present */
>   	struct sfp_eeprom_s sfp_eeprom;
>   	struct phy_s phy;
> -#define LMAC_FWDATA_RESERVED_MEM 1021
> +	u32 lmac_type;
> +	u32 portm_idx;
> +	u64 mgmt_port:1;
> +	u64 advertised_an:1;
> +	u64 port;
> +#define LMAC_FWDATA_RESERVED_MEM 1018
>   	u64 reserved[LMAC_FWDATA_RESERVED_MEM];
>   };
>   
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> index 0c20642f81b9..8375f18c8e07 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
> ...
> @@ -2923,6 +2988,97 @@ static int rvu_dbg_cgx_dmac_flt_display(struct seq_file *s, void *unused)
>   
>   RVU_DEBUG_SEQ_FOPS(cgx_dmac_flt, cgx_dmac_flt_display, NULL);
>   
> +static int cgx_print_fwdata(struct seq_file *s, int lmac_id)
> +{
> +	struct cgx_lmac_fwdata_s *fwdata;
> +	void *cgxd = s->private;
> +	struct phy_s *phy;
> +	struct rvu *rvu;
> +	int cgx_id, i;
> +
> +	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
> +					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
> +	if (!rvu)
> +		return -ENODEV;
> +
> +	if (!rvu->fwdata)
> +		return -EAGAIN;
> +
> +	cgx_id = cgx_get_cgxid(cgxd);
You need to check the return value. It can be -EINVAL which you don't
want to use for the array index.
> +
> +	if (rvu->hw->lmac_per_cgx == CGX_LMACS_USX)
> +		fwdata =  &rvu->fwdata->cgx_fw_data_usx[cgx_id][lmac_id];
> +	else
> +		fwdata =  &rvu->fwdata->cgx_fw_data[cgx_id][lmac_id];
> +
>


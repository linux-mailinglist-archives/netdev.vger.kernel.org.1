Return-Path: <netdev+bounces-300199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /hcRJ1i/MmpA5AUAu9opvQ
	(envelope-from <netdev+bounces-300199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:38:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 280B769B0F7
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 17:38:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=eJ3a20Q6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300199-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300199-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B331308E954
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E33348BD4A;
	Wed, 17 Jun 2026 15:31:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B3480DCE;
	Wed, 17 Jun 2026 15:31:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710291; cv=none; b=Ls6RnDG0yWEELEWLZOhkzoNN8azFgqp/VGq1ipeA9d4xxy2AhFzJbmPZwI9KgxM1A8MIzdE813YZCyQSb33e/uZ9ghOiyueeHR4rSpT/U+OhgDTG9DHrwiLXW0kmg+lXUqKpJ+FfF2VC8lIri2ppWjrmOEEonPj+ykZVfLb3Pmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710291; c=relaxed/simple;
	bh=vQQZIbv9SjKiwQBZpR692xKdH2FSf9YEpug9anwuvM8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CREkiPT5XdR8PdJmZT5pENzbg/WOPctncWJxHji++6OEJ3qDG/x2DfCyRXaAP0O+gMlUilmNpBPTy3Okp8+PpWsf3trsl666vjDqN20DAIVvT625uN0X50g82Q+FfJonitNg//9lyeMbtZ6YP/QHOOtjNEjk+0w6jqJWqMYUjjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eJ3a20Q6; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HFU7hW2390655;
	Wed, 17 Jun 2026 08:31:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=J+8ib8IzXgu2okVvQgSR99MzM
	/43FlQRRm27aI1WE9U=; b=eJ3a20Q66YMcE0qRcubb38Ib0twXAk9wBdv2n4/AL
	eps+k6l5gAJf1xfTyt6OqBukOx6NIPG45wCv1tqDKycvbs+frRaWg2ACPfXuHU8h
	Nxfa/DRhrJ10oZ47m3a1FOUceWLhpWPSVs5Qql5pEsvEGrK0h3cMuBAcBwMMff49
	eTq1rupIMusGB6LkPSOK8LZaDzpdRvCBqPVPlvAzTb9rjfeN9pcXpTYLu1PSmHge
	VmS4Hs+t59upfNHcfzDzR9oEx2fyfk6pQ+OAhv8p+TBHhQE+NZbssOrQIl8iXrw1
	3d+cWKGO61eWf6YjhPLtzWimagqzuMOSPVte2D3NH8Tew==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eueg4k4xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 08:31:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 17 Jun 2026 08:31:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 17 Jun 2026 08:31:13 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id E61363F703F;
	Wed, 17 Jun 2026 08:31:09 -0700 (PDT)
Date: Wed, 17 Jun 2026 21:01:06 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>, <rkannoth@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net PATCH v2] octeontx2-af: Validate NIX maximum LFs correctly
Message-ID: <20260617153106.GA573886@kernel-ep2>
References: <1781709750-23218-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1781709750-23218-1-git-send-email-sbhatta@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE0NyBTYWx0ZWRfXz+BzeODuQuJf
 +9Yp3V8OUkR/q4gD+Y7mGYxr938ARzsFAaYp/PMsnVLkFaOTDe/7SnySsSDPhvLa/6Ugk4qEPVC
 Y3eC/4bY+meOLBnsYJ87tLyR8R7wgFsVN7k2Bq59eYU96zstKhkMPYWNDBuKOruDcRGBZOz3+g6
 GwjCtivvaX7iX9SvHCP10nHK8MFLiMTVGFekX/s6HgnGqmuObIlmfaJaYrjPnSbowX5WER4JZDq
 VLfFBdUBiC+khngYbtERUo4J5iCCF3emlP1NHdoAHGfdj3kUQHnURRgTpGnXdxJdwc+3R254b+B
 EPmXWPvn3p0eCbsAbGfU4ZAg2Rji0YrxqPVYyHc1xpYKSQRjjykMxaSGHsXrf14ri6h+keF2cbn
 ZAR+R1BGgZ9rtqk7ZK/hx3PuedixAhI7/RhRqCqbFdqQifBzORdvqkU4mJiEy8nNF4SifaR8Yhx
 PgK0/GEgPqtWV7S5uJg==
X-Proofpoint-ORIG-GUID: c3srgwjRjSyvbkWci_Jo9pRjxFIE_IHy
X-Authority-Analysis: v=2.4 cv=JZqMa0KV c=1 sm=1 tr=0 ts=6a32bdc2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=NxAy9LMzE4iHBXICqBUA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE0NyBTYWx0ZWRfX8yxH9m3fzyhR
 iH91zGpaoEoaVDHcbInsJauerZ8oO+BGOiPtsyvom1RJwyt9poJVhbtY5HlyXN/K0QedZPdXqW+
 8rtKvTqZFNiMpHrf+rfqf2fuL69IqYo=
X-Proofpoint-GUID: c3srgwjRjSyvbkWci_Jo9pRjxFIE_IHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300199-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:dkim,marvell.com:email,marvell.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:rkannoth@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 280B769B0F7

Missed the changelog. Will resend.

Thanks,
Sundeep

pw-bot: changes-requested

On 2026-06-17 at 20:52:30, Subbaraya Sundeep (sbhatta@marvell.com) wrote:
> NIX maximum number of LFs can be set via devlink command
> but that can be done before assigning any LFs to a PF/VF.
> The condition used to check whether any LFs are assigned is
> incorrect. This patch fixes that condition.
> 
> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
>  .../marvell/octeontx2/af/rvu_devlink.c        | 27 +++++++++++++------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> index 6494a9ee2f0d..3b47ecb44d51 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> @@ -1510,7 +1510,9 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
>  	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
>  	struct rvu *rvu = rvu_dl->rvu;
>  	u16 max_nix0_lf, max_nix1_lf;
> -	struct npc_mcam *mcam;
> +	struct rvu_block *block;
> +	int blkaddr = 0;
> +	int free_lfs;
>  	u64 cfg;
>  
>  	cfg = rvu_read64(rvu, BLKADDR_NIX0, NIX_AF_CONST2);
> @@ -1518,14 +1520,23 @@ static int rvu_af_dl_nix_maxlf_validate(struct devlink *devlink, u32 id,
>  	cfg = rvu_read64(rvu, BLKADDR_NIX1, NIX_AF_CONST2);
>  	max_nix1_lf = cfg & 0xFFF;
>  
> -	/* Do not allow user to modify maximum NIX LFs while mcam entries
> -	 * have already been assigned.
> +	/* Do not allow user to modify maximum NIX LFs while NIX LFs
> +	 * have already been assigned. Note that modifying NIX LFs count
> +	 * can be done only before any LF attach requests from PFs and VFs
> +	 * and not later or concurrently.
>  	 */
> -	mcam = &rvu->hw->mcam;
> -	if (mcam->bmap_fcnt < mcam->bmap_entries) {
> -		NL_SET_ERR_MSG_MOD(extack,
> -				   "mcam entries have already been assigned, can't resize");
> -		return -EPERM;
> +	blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
> +	while (blkaddr) {
> +		block = &rvu->hw->block[blkaddr];
> +
> +		free_lfs = rvu_rsrc_free_count(&block->lf);
> +		if (free_lfs != block->lf.max) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "NIX LFs already assigned, can't resize");
> +			return -EPERM;
> +		}
> +
> +		blkaddr = rvu_get_next_nix_blkaddr(rvu, blkaddr);
>  	}
>  
>  	if (max_nix0_lf && val.vu16 > max_nix0_lf) {
> -- 
> 2.48.1
> 


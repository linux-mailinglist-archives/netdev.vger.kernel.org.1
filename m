Return-Path: <netdev+bounces-252245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEbfLNDjcWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:46:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FE863627
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 141F14893FE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A16B3C1FFC;
	Thu, 22 Jan 2026 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEN1lLMN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0173A7E17;
	Thu, 22 Jan 2026 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070976; cv=none; b=jEFfOxwRby4+8+bz9MtW1jtxx35CG/x++WkmwRhk/L1vSVAu5j79814Gb+3UxVAUEgJ2T82qfTLOrmzjpnoAl9KNoIwwbk3uACD6pAePo2krSG3q6+aTfQL+7q8c3cTNj4gsmBQS61BmRCxCkBHGWYIWh6mtddQ1WY5tYx9W6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070976; c=relaxed/simple;
	bh=c5VjwEm9ex9Mg3vUtvDDSl7GAfSR5wtXihmSxg0aZtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+hWOrWJuD1v46x424kupeLbXv7Pai4NsJ0xbQcmof2Me3EslA35iYF3YMhCHZsNqUYBfqQacIjkcZMvUdoWkmkn7nmWaipia2UDPYqARwmqCRigeSvMCZ0jezdnoq/D/QyO9kPCbmgt9vIPsrl2EZ6GYzqa2YSXN1A/l2P17Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEN1lLMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D18AC116C6;
	Thu, 22 Jan 2026 08:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769070974;
	bh=c5VjwEm9ex9Mg3vUtvDDSl7GAfSR5wtXihmSxg0aZtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEN1lLMNDUYenHuV8Z8P9N41F2zTG1JFJAf0G5UF4B0pYCl3cbH0MtJlia0xFRWfE
	 aJlvbVE+816wY2lj/ZzesL0rQzT5YhCSLZmiuE4lVZmPrKl6oIQqerJLbGB4nS++PZ
	 3FxZY6m4xfshuKC4za6SpRiiHLXjhB60mIi8vNC6QBvUYOSxZvi92B6AcBjJ33k00h
	 z9KK2ewaTK1Q8HfEE1cYZOx5b3M1gtg403tbIzXwLlOQvHB1sdEweN1KQcJ7nbITae
	 t80X+9G2Kk9RQ1RbxiLWnE3Hy5eiof2u8ww9wRR59LDHUBTfjsxOf6ClCABWiue07M
	 xJ4gYcfrqufCw==
Date: Thu, 22 Jan 2026 08:36:10 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next v4 07/13] octeontx2-af: npc: cn20k: Prepare for
 new SoC
Message-ID: <aXHhekHJSpTZzHXy@horms.kernel.org>
References: <20260113101658.4144610-1-rkannoth@marvell.com>
 <20260113101658.4144610-8-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113101658.4144610-8-rkannoth@marvell.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-252245-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 66FE863627
X-Rspamd-Action: no action

On Tue, Jan 13, 2026 at 03:46:52PM +0530, Ratheesh Kannoth wrote:

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index 508233876fc1..d73e447bedca 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -903,11 +903,12 @@ static int npc_check_unsupported_flows(struct rvu *rvu, u64 features, u8 intf)
>   * dont care.
>   */
>  void npc_update_entry(struct rvu *rvu, enum key_fields type,
> -		      struct mcam_entry *entry, u64 val_lo,
> +		      struct mcam_entry_mdata *mdata, u64 val_lo,
>  		      u64 val_hi, u64 mask_lo, u64 mask_hi, u8 intf)
>  {
>  	struct npc_mcam *mcam = &rvu->hw->mcam;
>  	struct mcam_entry dummy = { {0} };
> +	u64 *kw, *kw_mask, *val, *mask;
>  	struct npc_key_field *field;
>  	u64 kw1, kw2, kw3;
>  	int i, max_kw;
> @@ -920,10 +921,9 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
>  	if (!field->nr_kws)
>  		return;
>  
> -	if (is_cn20k(rvu->pdev))
> -		max_kw = NPC_MAX_KWS_IN_KEY;
> -	else
> -		max_kw = NPC_MAX_KWS_IN_KEY - 1;
> +	max_kw = NPC_MAX_KWS_IN_KEY;
> +	kw = dummy.kw;
> +	kw_mask = dummy.kw_mask;
>  
>  	for (i = 0; i < max_kw; i++) {
>  		if (!field->kw_mask[i])
> @@ -932,10 +932,10 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
>  		shift = __ffs64(field->kw_mask[i]);
>  		/* update entry value */
>  		kw1 = (val_lo << shift) & field->kw_mask[i];
> -		dummy.kw[i] = kw1;
> +		kw[i] = kw1;
>  		/* update entry mask */
>  		kw1 = (mask_lo << shift) & field->kw_mask[i];
> -		dummy.kw_mask[i] = kw1;
> +		kw_mask[i] = kw1;
>  
>  		if (field->nr_kws == 1)
>  			break;
> @@ -945,12 +945,12 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
>  			kw2 = shift ? val_lo >> (64 - shift) : 0;
>  			kw2 |= (val_hi << shift);
>  			kw2 &= field->kw_mask[i + 1];
> -			dummy.kw[i + 1] = kw2;
> +			kw[i + 1] = kw2;

Hi Ratheesh,

It's not a problem introduced by this patch.
But it seems that this could overrun kw if i is max_kw - 1.
Likewise elsewhere in this loop.

Flagged by Smatch.

>  			/* update entry mask */
>  			kw2 = shift ? mask_lo >> (64 - shift) : 0;
>  			kw2 |= (mask_hi << shift);
>  			kw2 &= field->kw_mask[i + 1];
> -			dummy.kw_mask[i + 1] = kw2;
> +			kw_mask[i + 1] = kw2;
>  			break;
>  		}
>  		/* place remaining bits of key value in kw[x + 1], kw[x + 2] */
> @@ -961,34 +961,40 @@ void npc_update_entry(struct rvu *rvu, enum key_fields type,
>  			kw2 &= field->kw_mask[i + 1];
>  			kw3 = shift ? val_hi >> (64 - shift) : 0;
>  			kw3 &= field->kw_mask[i + 2];
> -			dummy.kw[i + 1] = kw2;
> -			dummy.kw[i + 2] = kw3;
> +			kw[i + 1] = kw2;
> +			kw[i + 2] = kw3;
>  			/* update entry mask */
>  			kw2 = shift ? mask_lo >> (64 - shift) : 0;
>  			kw2 |= (mask_hi << shift);
>  			kw2 &= field->kw_mask[i + 1];
>  			kw3 = shift ? mask_hi >> (64 - shift) : 0;
>  			kw3 &= field->kw_mask[i + 2];
> -			dummy.kw_mask[i + 1] = kw2;
> -			dummy.kw_mask[i + 2] = kw3;
> +			kw_mask[i + 1] = kw2;
> +			kw_mask[i + 2] = kw3;
>  			break;
>  		}
>  	}

...


Return-Path: <netdev+bounces-253937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI7OCibmeGmHtwEAu9opvQ
	(envelope-from <netdev+bounces-253937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:21:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE45B97AD7
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25DEE300BBB1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B302335EDC8;
	Tue, 27 Jan 2026 16:21:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8153161B5
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530914; cv=none; b=j2li9in2bTXclZwWCqQU+HBujIpuPp5HqMnrALy8AdeC4wS1AMLQK7KqCpITk7pq0rbzcDzvUwlkxgV9hA6H+rxzDG+SC38ml3Lb5cepjfCOJaqKsfUx7gBdDzUMuDnqIn+HFK6zn2hNSY5GwbDo2t2fxLRCPmzXLH149zvyuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530914; c=relaxed/simple;
	bh=6aymXQe0lxfSMO6BuldosYgaPzopUrWpGVi5qQZKrFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8TQE5LInrY1VaSS9xd57Q45FjviOb7IqL4PZKsk43QP8nlwxx1gLE0iSTbmoFjpq/QPYcQ5MPirOgqSbgligeUg2mXxsAh7sXfc3YaadyRGpydxhgmafmffE1/R9F5pWjk9zMpX/tyPDGGyFzqXREZVdCGmDRc23KGidq5EWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EB48E4C442F986;
	Tue, 27 Jan 2026 17:21:13 +0100 (CET)
Message-ID: <c8807b34-59d9-4b8c-8b2e-477fa25ef413@molgen.mpg.de>
Date: Tue, 27 Jan 2026 17:21:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Make name member of
 struct ice_cgu_pin_desc const
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
References: <20260127-const-name-v1-1-9c84615c55a4@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260127-const-name-v1-1-9c84615c55a4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253937-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,intel.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.838];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE45B97AD7
X-Rspamd-Action: no action

Dear Simon,


Thank you for your patch.

Am 27.01.26 um 17:16 schrieb Simon Horman:
> The name member of struct ice_cgu_pin_desc never modified.
> Make it const.
> 
> Found by inspection.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> index 93901bccf1c4ae1e1782e7a2af4322a6777d0b6c..87aa4cfc5a463f74509ecc4cfbc00e06f26cab5c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -258,7 +258,7 @@ enum ice_si_cgu_out_pins {
>   };
>   
>   struct ice_cgu_pin_desc {
> -	char *name;
> +	const char *name;
>   	u8 index;
>   	enum dpll_pin_type type;
>   	u32 freq_supp_num;
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul Menzel


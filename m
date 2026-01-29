Return-Path: <netdev+bounces-254949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WELAE0bxe2lFJgIAu9opvQ
	(envelope-from <netdev+bounces-254949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:46:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC5B5C3C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46539300D955
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74EF32720C;
	Thu, 29 Jan 2026 23:45:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB41C5D5E
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769730358; cv=none; b=tAdxjlbck7EduHryWqk4b2qeQSnXVtD/BjL2C8oqYvZkl71GBZjmb49g3oydh+LyGlwTJAue+ALJFejXMQjn7QYzJO2osl+pSLvQGmFWGaoKlLD1zxMWvhG5nXpzUKJsBo/UMHk1W71PwEe/dbLIIcuxit365VGh4rKjyFYCpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769730358; c=relaxed/simple;
	bh=1/lXiteWXk5XKPKunbhACIFcwcWw48Y46EvIG2bZX68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGNFBtvDf1T/eliGSRR1Im7UVUrdz6rmHdemwugwl/7oBEf88oDMQIln6ec8PiNwvvDJeMETAwpgchoFVKDtfm/gy8TGQoBtA/rM/vZ9V873GeFWT1Y0q04GyEDETP4ccxKoVfpafduFFtLiq0j4Cg3cmOJt16cUYqc+R6cMGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af758.dynamic.kabel-deutschland.de [95.90.247.88])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5E8D14C442FB42;
	Fri, 30 Jan 2026 00:45:34 +0100 (CET)
Message-ID: <e5751b33-4650-4b9f-8b9d-7f9297b1e67d@molgen.mpg.de>
Date: Fri, 30 Jan 2026 00:45:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: only timestamp PTP event
 packets
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 przemyslaw.korba@intel.com,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260129-jk-i40e-limit-timestamping-v1-1-0495e6e7d318@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260129-jk-i40e-limit-timestamping-v1-1-0495e6e7d318@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254949-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,molgen.mpg.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3CC5B5C3C
X-Rspamd-Action: no action

Dear Jacob,


Thank you for the patch.

Am 29.01.26 um 22:52 schrieb Jacob Keller:
> The i40e_ptp_set_timestamp_mode() function is responsible for configuring
> hardware timestamping. When programming receive timestamping, the logic
> must determine how to configure the PRTTSYN_CTL1 register for receive
> timestamping.
> 
> The i40e hardware does not support timestamping all frames. Instead,
> timestamps are captured into one of the four PRTTSYN_RXTIME registers.
> 
> Currently, the driver configures hardware to timestamp all V2 packets on
> ports 319 and 320, including all message types. This timestamps
> significantly more packets than is actually requested by the
> HWTSTAMP_FILTER_PTP_V2_EVENT filter type.
> 
> The documentation for HWTSTAMP_FILTER_PTP_V2_EVENT indicates that it should
> timestamp PTP v2 messages on any layer, including any kind of event
> packets.
> 
> Timestamping other packets is acceptable, but not required by the filter.
> Doing so wastes valuable slots in the Rx timestamp registers. For most
> applications this doesn't cause a problem. However, for extremely high
> rates of messages, it becomes possible that one of the critical event
> packets is not timestamped.
> 
> The PTP protocol only requires timestamps for event messages on port 319,
> but hardware is timestamping on both 319 and 320, and timestamping message
> types which do not need a timestamp value.
> 
> The i40e hardware actually has a more strict filtering option. First, only
> timestamp layer 4 messages on port 319 instead of both 319 and 320. Second,
> note that hardware has a specific mode to timestamp only event packets
> (those with message type < 8).
> 
> Update the configuration to use this mode, so that timestamps are captured
> for only event messages. This replaces the use of the 'wildcard' option of
> the V2MESSTYPE field which caused timestamping of all message types
> regardless of whether it was an event message.
> 
> This avoids wasting the valuable Rx timestamp register slots on non-event
> frames, and may reduce faults when operating under high event rates.

Do you have a test case to reproduce this?

Can the other mode be enabled somehow for people needing port 320 and 
timestamps on every message?

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_register.h | 10 ++++++++++
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c      |  9 +++------
>   2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
> index c4051dbcc297..2560c47910d4 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_register.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
> @@ -797,8 +797,18 @@
>   #define I40E_PRTTSYN_CTL1_V2MESSTYPE0_SHIFT 16
>   #define I40E_PRTTSYN_CTL1_V2MESSTYPE0_MASK I40E_MASK(0xF, I40E_PRTTSYN_CTL1_V2MESSTYPE0_SHIFT)
>   #define I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT 24
> +#define I40E_PRTTSYN_CTL1_TSYNTYPE_MASK I40E_MASK(0x3, I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT)
> +/* Timestamp UDP v1 packets */
> +#define I40E_PRTTSYN_CTL1_TSYNTYPE_V1 \
> +	FIELD_PREP(I40E_PRTTSYN_CTL1_TSYNTYPE_MASK, 1)
> +/* Timestamp L2 and UDP v2 packets with message type < 8 */
> +#define I40E_PRTTSYN_CTL1_TSYNTYPE_V2_EVENT \
> +	FIELD_PREP(I40E_PRTTSYN_CTL1_TSYNTYPE_MASK, 3)
>   #define I40E_PRTTSYN_CTL1_UDP_ENA_SHIFT 26
>   #define I40E_PRTTSYN_CTL1_UDP_ENA_MASK I40E_MASK(0x3, I40E_PRTTSYN_CTL1_UDP_ENA_SHIFT)
> +/* Timestamp UDP packets on port 319 */
> +#define I40E_PRTTSYN_CTL1_UDP_ENA_319 \
> +	FIELD_PREP(I40E_PRTTSYN_CTL1_UDP_ENA_MASK, 1)
>   #define I40E_PRTTSYN_CTL1_TSYNENA_SHIFT 31
>   #define I40E_PRTTSYN_CTL1_TSYNENA_MASK I40E_MASK(0x1, I40E_PRTTSYN_CTL1_TSYNENA_SHIFT)
>   #define I40E_PRTTSYN_INC_H 0x001E4060 /* Reset: GLOBR */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 89abe2f22216..d70adf2e5a1c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -24,9 +24,6 @@
>   #define I40E_PTP_1GB_INCVAL_MULT	20
>   #define I40E_ISGN			0x80000000
>   
> -#define I40E_PRTTSYN_CTL1_TSYNTYPE_V1  BIT(I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT)
> -#define I40E_PRTTSYN_CTL1_TSYNTYPE_V2  (2 << \
> -					I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT)
>   #define I40E_SUBDEV_ID_25G_PTP_PIN	0xB
>   
>   enum i40e_ptp_pin {
> @@ -1278,7 +1275,7 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
>   		pf->ptp_rx = true;
>   		tsyntype = I40E_PRTTSYN_CTL1_V1MESSTYPE0_MASK |
>   			   I40E_PRTTSYN_CTL1_TSYNTYPE_V1 |
> -			   I40E_PRTTSYN_CTL1_UDP_ENA_MASK;
> +			   I40E_PRTTSYN_CTL1_UDP_ENA_319;
>   		config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
>   		break;
>   	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> @@ -1295,9 +1292,9 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
>   	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
>   		pf->ptp_rx = true;
>   		tsyntype = I40E_PRTTSYN_CTL1_V2MESSTYPE0_MASK |
> -			   I40E_PRTTSYN_CTL1_TSYNTYPE_V2;
> +			   I40E_PRTTSYN_CTL1_TSYNTYPE_V2_EVENT;
>   		if (test_bit(I40E_HW_CAP_PTP_L4, pf->hw.caps)) {
> -			tsyntype |= I40E_PRTTSYN_CTL1_UDP_ENA_MASK;
> +			tsyntype |= I40E_PRTTSYN_CTL1_UDP_ENA_319;
>   			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
>   		} else {
>   			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;


Kind regards,

Paul


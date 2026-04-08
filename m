Return-Path: <netdev+bounces-276512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI1YDCpQ1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:55:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A324B3BC6F2
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F6153037E70
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B3527F01E;
	Wed,  8 Apr 2026 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y+AJugnT"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC81A4F3C
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652721; cv=none; b=Yx43xRf/b5oFKgW+Fx2/qASvnjEjD19LBEDay/obOUU6D4fZ3t093ZTKtWDXoC0DTA+K/H193Nfs+3ldZNyf3vUaeKo0ZQG6K4fT1NxFpsedu+8qdB2utyFB7fPJWCPuBBzcrbHel5qbaViHMoaLkAykmM/q9NaaU5OdbGAPAbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652721; c=relaxed/simple;
	bh=H1yPARlG5H5Bd1CeZLd0DT7Xb0sEkMdL6KpOuDLFa2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qK0tpbFRAHBFd9lY7niYdvh0rOrZ6EMAYXjDfyj6Tp5+PNGpCYiDTcE1byqinjkPl5TDJh/lFK7DJLcf3R4AJZE2lwSBHHOydWgDn+GLDvt5+6O8GTgbg8zZmI2dFWlwQGHzg1skJ4bqm0Va2bNu2jj3xlYl1cJm0s8Lm47QzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y+AJugnT; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3596a43d-8c8e-47ac-ae73-ee282f3be945@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775652717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gh4szFTSdIUFPVdAHWKhpExq2L0Ni/0kIZ6BEZHAE6E=;
	b=Y+AJugnT+tEKCnRIU3ln/NYqlxqrtB2YnyK+TmrN6AwwNgyv7hzrwPCHTAXDv2LAsbxXKn
	9TSSI4/kr61Vn5Hn0WkXsZWw+I0GzLIWUGwceKEHMqXZ9F9KpnWsjJdkMJj6ZYdJYG24U/
	I8seIGUFjtveGOmiGJxh78O0ZXTQGMU=
Date: Wed, 8 Apr 2026 13:51:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v11 05/10] bng_en: add support for link async
 events
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
References: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
 <20260403073724.194360-6-bhargava.marreddy@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260403073724.194360-6-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276512-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: A324B3BC6F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/04/2026 08:37, Bhargava Marreddy wrote:
> Register for firmware asynchronous events, including link-status,
> link-speed, and PHY configuration changes. Upon event reception,
> re-query the PHY and update ethtool settings accordingly.
> 
> Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
> ---
>   .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 19 +++++++++-
>   .../net/ethernet/broadcom/bnge/bnge_link.c    | 18 ++++++++++
>   .../net/ethernet/broadcom/bnge/bnge_link.h    |  1 +
>   .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 23 ++++++++++++
>   .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 35 ++++++++++++++++---
>   5 files changed, 91 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> index acb712ddbd7e..de51add96ac3 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
> @@ -15,6 +15,13 @@
>   #include "bnge_rmem.h"
>   #include "bnge_resc.h"
>   
> +static const u16 bnge_async_events_arr[] = {
> +	ASYNC_EVENT_CMPL_EVENT_ID_LINK_STATUS_CHANGE,
> +	ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CHANGE,
> +	ASYNC_EVENT_CMPL_EVENT_ID_LINK_SPEED_CFG_CHANGE,
> +	ASYNC_EVENT_CMPL_EVENT_ID_PORT_PHY_CFG_CHANGE,
> +};
> +
>   int bnge_hwrm_ver_get(struct bnge_dev *bd)
>   {
>   	u32 dev_caps_cfg, hwrm_ver, hwrm_spec_code;
> @@ -166,10 +173,12 @@ int bnge_hwrm_fw_set_time(struct bnge_dev *bd)
>   
>   int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd)
>   {
> +	DECLARE_BITMAP(async_events_bmap, 256);
>   	struct hwrm_func_drv_rgtr_output *resp;
>   	struct hwrm_func_drv_rgtr_input *req;
> +	u32 events[8];
>   	u32 flags;
> -	int rc;
> +	int rc, i;
>   
>   	rc = bnge_hwrm_req_init(bd, req, HWRM_FUNC_DRV_RGTR);
>   	if (rc)
> @@ -190,6 +199,14 @@ int bnge_hwrm_func_drv_rgtr(struct bnge_dev *bd)
>   	req->ver_min = cpu_to_le16(DRV_VER_MIN);
>   	req->ver_upd = cpu_to_le16(DRV_VER_UPD);
>   
> +	memset(async_events_bmap, 0, sizeof(async_events_bmap));

bitmap API has bitmap_zero()

> +	for (i = 0; i < ARRAY_SIZE(bnge_async_events_arr); i++)
> +		__set_bit(bnge_async_events_arr[i], async_events_bmap);
> +
> +	bitmap_to_arr32(events, async_events_bmap, 256);
> +	for (i = 0; i < ARRAY_SIZE(req->async_event_fwd); i++)
> +		req->async_event_fwd[i] |= cpu_to_le32(events[i]);
> +
>   	resp = bnge_hwrm_req_hold(bd, req);
>   	rc = bnge_hwrm_req_send(bd, req);
>   	if (!rc) {


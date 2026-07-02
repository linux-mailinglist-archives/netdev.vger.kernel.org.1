Return-Path: <netdev+bounces-304079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fx5cBvA+RmrTMgsAu9opvQ
	(envelope-from <netdev+bounces-304079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:35:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 993416F5FCF
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:35:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LtmD8fG3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304079-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304079-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FD03320168E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A84C77DA;
	Thu,  2 Jul 2026 09:43:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1149480DCE
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:43:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985398; cv=none; b=ZNixAwCKb3mKux6vAjdWs0YruafPWGJWxiCRYJt37mzZM63Qw1Dxz8zFWgXBIZSYJV5+1iFtIqQqjE7L7Xg7CJ+lViMFY6uyrmFRxKeQtCOymgSkwuv3C1tTpziwIy8QnZ8Q2geapbRfwvhNSDXtDygBQ00o6/auyINANAlCQX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985398; c=relaxed/simple;
	bh=/Z5QH5xGIhTuueFEUkqDtjio/PvnL55at3Q56Vk1Qm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZJBL5IsyDBOFj0LiwHj6hqyHAx1T7mvTUCefRnEaEFsL5X8PQ/HNI/U0CuwOsstDotBbi5bTBu9aLNyh3nX6f8RYQI/+h+o0DaQZjNHLxSj3Xx2WfjKjuN+V1eggUKY9iHYBTYm5Hp2P/0HcjzwcjzkwD/GsLjn9KH5GQA25sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtmD8fG3; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782985396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D6xNiSJ7cXeNZHCZuu0zC6iFo82L/QJuzyBnhtWmIGI=;
	b=LtmD8fG3xzlbx0YpLT+GWxtw1HUDf78WxyTo9OodxtBWgQ8S2gfwAo39o4N/DrBuPF9G7l
	Gt2QIMCw5KgqhWTIpBoSniHRK7oKEixUU35pZX1+Wh9xw1co6ugWEf5MiBQfRtoe9OdRdL
	+C3bqjp/lfpPp06q9W+V4xqQCgxU/4Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-9IXg27smPkyfGlOnlKCX_g-1; Thu,
 02 Jul 2026 05:43:12 -0400
X-MC-Unique: 9IXg27smPkyfGlOnlKCX_g-1
X-Mimecast-MFC-AGG-ID: 9IXg27smPkyfGlOnlKCX_g_1782985390
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3418A184B0B6;
	Thu,  2 Jul 2026 09:43:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C387B196B0A3;
	Thu,  2 Jul 2026 09:43:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 net-next 08/10] net/nebula-matrix: add Dispatch layer implementation
Date: Thu,  2 Jul 2026 11:43:01 +0200
Message-ID: <20260702094301.111400-1-pabeni@redhat.com>
In-Reply-To: <20260630010718.4346-9-illusion.wang@nebula-matrix.com>
References: <20260630010718.4346-9-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-304079-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:illusion.wang@nebula-matrix.com,m:dimon.zhao@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 993416F5FCF

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net/nebula-matrix: add Dispatch layer implementation
    
This patch introduces a control-level routing mechanism for the Dispatch layer,
supporting direct and channel routing paths based on declared control levels.
It establishes the message handling framework and sets up the resource layer
locking strategy for operations like MSI-X configuration.

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> index f0b4406ca5601..ca565c6c4819f 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c

[ ... ]

> +static void nbl_disp_chan_configure_msix_map_resp(void *priv, u16 src_id,
> +						  u16 msg_id, void *data,
> +						  u32 data_len)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
> +	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
> +	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
> +	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
> +	struct device *dev = disp_mgt->common->dev;
> +	struct nbl_chan_param_cfg_msix_map param = { 0 };
> +	struct nbl_chan_ack_info chan_ack;
> +	int err = NBL_CHAN_RESP_OK;
> +	int copy_len;
> +	int ret;
> +
> +	copy_len = data_len < sizeof(param) ? data_len : sizeof(param);
> +	memcpy(&param, data, copy_len);
> +	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->configure_msix_map, p,
> +				    src_id, le16_to_cpu(param.num_net_msix),
> +				    le16_to_cpu(param.num_others_msix),
> +				    le16_to_cpu(param.msix_mask_en));

[Severity: High]
This is a pre-existing issue, but does exposing this configuration via
channel messages allow a VM to trigger an unbounded memory leak?

Looking at the underlying nbl_res_intr_configure_msix_map() implementation,
it allocates device-managed memory for the MSI-X map table:

nbl_res_intr_configure_msix_map() {
    ...
    msix_map_table->base_addr = dmam_alloc_coherent(dev,
                                                msix_map_table->size,
                                                &msix_map_table->dma,
                                                GFP_KERNEL);
    ...
}

However, prior to this allocation, it appears to call
nbl_res_intr_destroy_msix_map(), which merely clears the pointer without
freeing the previously allocated memory:

nbl_res_intr_destroy_msix_map() {
    ...
    intr_mgt->func_intr_res[func_id].msix_map_table.base_addr = NULL;
    ...
}

Since this patch wires up nbl_disp_chan_configure_msix_map_resp() to
process NBL_CHAN_MSG_CONFIGURE_MSIX_MAP channel messages from untrusted VMs,
could a compromised VM repeatedly send these messages to exhaust host memory
and DMA mapping space?

> +	if (ret)
> +		err = NBL_CHAN_RESP_ERR;
> +
> +	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_CONFIGURE_MSIX_MAP, msg_id,
> +		     err, NULL, 0);
> +	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);
> +	if (ret)
> +		dev_err(dev,
> +			"channel send ack failed with ret: %d, msg_type: %d\n",
> +			ret, NBL_CHAN_MSG_CONFIGURE_MSIX_MAP);
> +}
-- 
This is an AI-generated review.



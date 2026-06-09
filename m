Return-Path: <netdev+bounces-297351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +qUEIRKiKGrsGwMAu9opvQ
	(envelope-from <netdev+bounces-297351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:30:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E218664CA8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:30:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=osUvNqq1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297351-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297351-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7FD83010DCF
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 23:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29363F5BEF;
	Tue,  9 Jun 2026 23:30:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753421C84BC;
	Tue,  9 Jun 2026 23:30:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047818; cv=none; b=m4Lnh8xXJjZPD2hciNbVXni/e6OZWof+YGr+005xVXkBAAD0x0uIEbAB1tt55m03xcBfH6KVkH9LZyEke6KqzPiApgaBQRGGQLDZtEgT7ma+rkEJnyKssXyNwKaLgfkVwui5YTF34l1kiipJHEXU34Oxah+/wILo+EJ++j4CD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047818; c=relaxed/simple;
	bh=yA4sfY27Ukdc6u6WUuKU+5DRIKxEBZ2KKzxDI9lQZFo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tfJzx5Y3xZpsi0rOgQh13EBGyASnYnBcqnJeSxNsVwMFcUwyOfNZoIu8yfRM3rjiYI4vUPipGnJsnVC3pHM0B3W5QgFiuToHVPefj+hpj/Dza7nyVVofoKICWc9MgNniOpsTGYgK0AjDe2zdXh9/Xgppy36IefgOQXdTalOn/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osUvNqq1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE7F1F0089A;
	Tue,  9 Jun 2026 23:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781047817;
	bh=NeWpghwUoZ3fo4Ugns242Ww+denKn5nJBWGHqwy6UIk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=osUvNqq1pqwmuz1eEWGm3Wu5Mj25Wjab7OrqlySOxnf8JC1jvDMa9qbR0EWaqWn8F
	 D8Vhmijed/6ukgDbNF1ZZ3JKgNZbDbMfgjw69VbF2PDjFMFXL1d3qY8C2o8WEBhYlD
	 8JGSkwdDeSnONhqMZvRPO1M1N8P4jIejACXoW0xOUDIOygT65LeiAAV3Gm/hyV1k/c
	 BhX76gDdb/DRSCp8E3VjsTSZcMA8WtHR5YE89S0pSajF6dHJgLV2pNriJotACxKXjo
	 x7GkIoX6RNk5p4DgaCx19f06xKBgp5tCNyyDsPn+jdikPN7F3ToGaw/pkuHpwlWfGi
	 MZgl/MH+WE2OQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3E6A9F40068;
	Tue,  9 Jun 2026 19:30:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 19:30:16 -0400
X-ME-Sender: <xms:CKIoahPvJdKjJfaPvPaDI7YaBzeurtLGdNlAXC5eHEjJlUn4hI74Jw>
    <xme:CKIoaskgxGX28Jalz3x6XIZtzN65YkayS0ZNAj2cktOFx665UDAY_b--ZM-Pc38h7
    cjJrU33mpVA1_4d8RKSxfPvplq5v4qdbyQD3ZhoZmorn1KpuTcg0gHo>
X-ME-Received: <xmr:CKIoanteJwgjkQn2fRIJFBzHgvCd-bm-QXlnJW9fDhJM6VM0a0FLyv-AiHC4Pm3QjFl3Ou-PYA7Cv2x4-bSBIzS5vgIiOndHS-I>
X-ME-Proxy-Cause: dmFkZTEnlyFetkeZs/O0n2eqAVVm2kyBO4qeONC6iZ9OQRzK0Jhr0ebon2U9b6FlS7jP6/
    XMaHFCe6n7kft7hUNTZqJAZaOYXdTSEuxRlmyGht8V7RYpl/+MVBScCaJO20kSYJDLd2Ih
    2vjK9mK+fACxGHXOVKofvXXwVwoYi6v2/po1QqlGi2nQ3Ven96eRUXkkcCycL0kV9Z9M6Q
    n9sut+SuvniW5ktIpOkZlNNUtwUDGE8AeMesOFLYmrDr1nhv5D3xDN0bhlk++rLJJvCfKJ
    XXMvPtjLI3eUXYnEjDFp3p4DJMLthva3jQe/fDxpW0HOZiwLJa98zJxsCnVB5fciqAigkB
    mmrwom+xpCx8RUBV2Kuf8jN2yMO/2pjhtBs2VJgHyT9LggbxIum7VKJ2mK0vs3hHMKizPR
    pRhvPS2cV/92ScL4oobHp5Ftbk2icoXUzUi+c8O7mHSE1/1P9i5RP208+0M/oyvYbnOtWx
    7JTBiL8dFiBXGxt+Eb5GgiqsynzsDFMbrrY9uH4tOl7XDRD+ibhpsFmLItJ4XIpMkCkBMt
    upZ4CEmEpMG81fnvU3dn5NEv0v7EBtSkOnxHUnYhvaHt8evD3m5OyyUF6JR3Ukgo1a+8gJ
    mbgQWlqm4GR/MzOjT/ydXcMnCHelVDrfcoX5GNWggt1KwDY4lteehKJQkZXw
X-ME-Proxy: <xmx:CKIoanrX1Gr_0idbg5iPWxuA46TdFKvIOlcgMK3t0yZffKMfayWRQg>
    <xmx:CKIoatfF4OOY5m7ILwsndLlMMdMYIBWerYZrAC0njQGFbn0YW9eDYQ>
    <xmx:CKIoavmf-JT4tsJAb282P1YKfI415GATfQllHe2wlb7HwpVcEobE9w>
    <xmx:CKIoakYQ0GefrwuhzbmY6wsTfNp-rULL3r3sYfilmGO_mxfJ9qwnwA>
    <xmx:CKIoak5oSB21190PW5Dc2huwxJ8M0QH6FdTP5Yxh2Ny9kcqbCGec2yWl>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 19:30:15 -0400 (EDT)
Date: Tue, 09 Jun 2026 16:30:14 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: alejandro.lucero-palau@amd.com, 
 linux-cxl@vger.kernel.org, 
 netdev@vger.kernel.org, 
 djbw@kernel.org, 
 edward.cree@amd.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
Message-ID: <6a28a206bf61a_4fa78100e4@djbw-dev.notmuch>
In-Reply-To: <20260609215755.8685-5-alejandro.lucero-palau@amd.com>
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-5-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v27 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[djbw@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297351-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djbw@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E218664CA8

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use core API for safely obtain the CXL range linked to an HDM committed
> by the BIOS. Map such a range for being used as the ctpio buffer.
> 
> A potential user space action through sysfs unbinding or core cxl
> modules remove will trigger sfc driver device detachment, with that case
> not racing with this mapping as this is done during driver probe and
> therefore protected with device lock against those user space actions.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx.c     |  1 +
>  drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 90ccbe310386..578054c21e79 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>  	efx_fini_io(efx);
>  
>  	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	efx_cxl_exit(probe_data);
>  
>  	pci_dbg(efx->pci_dev, "shutdown successful\n");
>  
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 4d55c08cf2a1..d5766a40e2cf 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct range cxl_pio_range;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
>  	int rc;
> @@ -75,9 +76,32 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return -ENODEV;
>  	}
>  
> +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed\n");
> +		return PTR_ERR(cxl->cxlmd);
> +	}
> +
> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
> +				    range_len(&cxl_pio_range));
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> +			&cxl_pio_range);
> +		return -ENOMEM;

Dave caught the iounmap leak, but another concern is since you want to
continue operation if efx_cxl_init() fails then you probably also want
to release the successful attachment to the CXL domain if this happens.

Minor since something else is likely to fail if ioremap is not reliable.

Otherwise this looks good and with those fixed up the Reviewed-by still
stands.


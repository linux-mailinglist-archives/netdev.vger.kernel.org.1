Return-Path: <netdev+bounces-271015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MG0N52BwmlneQQAu9opvQ
	(envelope-from <netdev+bounces-271015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:20:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 599CE30812D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D3930F357E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A773F166A;
	Tue, 24 Mar 2026 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ng8YRZ6s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTPZAIXC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748383F165F
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354479; cv=none; b=rnluRAWGe1IoCQ71PHhVUp/FtmJx/RyGEJcYfQ/Vw4OHZJF/jZYL8uIh8NxcuNARfezfseA797ITPyLgDVSpxWA7IFQRNCTaq0kOdxNftnl/WugeznHCS0b4koYlaOfPdEefS+PHuz14YB46SAvFyFBVM3hL06OSiC+e7n0Hlog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354479; c=relaxed/simple;
	bh=0nweOpQUF7Iy+owNcebuaUY1s9BD82NErGlE6LW5YXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKrMkFra1k1RbSSMP0ubvuUrNo8ta/yk0FCwxF5C1zKkIC1i+RLlNOL41fVP3CG4mdTxNINSbvmlG7yMggsTLTs/qya7pVwZ+RQZnP5NlNCY/KFGCkeaUnmuVvjksfPiAJVKHqp9QiqNnlWXPmsIKvzsVyrtnxfhLAU9l7kdx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ng8YRZ6s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HTPZAIXC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774354474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i878IeteLCFxRLD+ZUMxJT9JCdjyYuc7imdtSz1y2IY=;
	b=Ng8YRZ6sk22aNfy6KuuNXVjCs3nSumeNIbiz0oZt8awuB1gmZpqTRAMzdbe7mUl23ZYJfR
	zj0OxZjCdjcQHhUC2Z+x6fT6PL0qmoMrjbQewUtlIMlx2ejgk/BkyipA6Jt3Gy6FH4Yy6W
	lGkMTlg2P5aoEssQabbjPL3zXAtgWd0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-gckjYsesOWaI5gpbtdbyaQ-1; Tue, 24 Mar 2026 08:14:33 -0400
X-MC-Unique: gckjYsesOWaI5gpbtdbyaQ-1
X-Mimecast-MFC-AGG-ID: gckjYsesOWaI5gpbtdbyaQ_1774354472
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486f89b7f69so38819665e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 05:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774354472; x=1774959272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i878IeteLCFxRLD+ZUMxJT9JCdjyYuc7imdtSz1y2IY=;
        b=HTPZAIXC8Yvw+4QNCDhItzSTJP73OqmBB6TdoAO0rWUB1jXcvyYYIirBCs520RiJTj
         +Tj7HqmI+l7V7L2nwNT6urmo6sAV9pkajjZ8PrPgVwSGwQOefHPUICR29Tx+HIpJIf6i
         Y8rHxm7FR361Y5C177vUaugP5rVE523vNf5YLlgNA9gWXjK4Au2pGmSnbfPtc/MrxiAq
         oDsHJDud9FWdFa3fr+QRD0dA0b8sly3UOdxaRYdVUjmM6kQmAg54Tv3VfLeNA58IzUBl
         A+Pnr3pUy8lxtHdUki/1NsVp0L2BuJqKZsVvsVn8ZZ4rIl1rgQSRJUiFo+YI81az7gns
         rcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774354472; x=1774959272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i878IeteLCFxRLD+ZUMxJT9JCdjyYuc7imdtSz1y2IY=;
        b=QH/2SQsi5/5Dk+FkJzYZYpcDzEkubjf6HRYO1aIo8mpc9OJuGTzb+1gWl4X1v6AL7t
         82bGAXE5pfIKr0Q4u4siIRYl9GsamFyO8LDGrbG2vlbO+loAj7GYsqxYHPcTI0hGbKUI
         B/HzUDnKtLWjGE7GM4GBvULlkvGyWZx8+CnpLYNCyAeGED9e7dBnLM6mNfiCd4lhokdW
         UKby/0eqsdUpFPKPt9wzl4YWMa9pvZYz83JrCBdAUof/HnN8/k3LGdB3a99HiqWIy30A
         J9hQ4S8nbVwgxq4T1d01YCwJmTZYT8e4R8tiaQQxYJtjGlPJs784x6Imz0yCKWUGFppn
         N4lA==
X-Gm-Message-State: AOJu0YxeDcbcmxbPnyRABqn/i9KzR24XW07DE+NYQfQ1VQh37x8pDSTq
	UtQday7IzqLEm8igSgzzxV09k5INudsAEl3il+YzFScGvQGPgqVTw33WJOFiOKYfqKbd8Wa6dsz
	f+BKw9DWeuQ3KJtmdCRQnOawnRzEIGLj3ztutmOlV6mGLApMTg3srVTj1Jw==
X-Gm-Gg: ATEYQzxRygYZU2hogMjvmNpMCfhw0vEE9NkROAGTL9ocRAgF2mB2kkfJl6zIcNyHhEj
	Kf0Ib6zzxzZ/j/DgZfJXVJV3hWt67X3lQczgcymgUn5h8xJniJ+P9tHS0W5894FzdUT3ZKXaBrU
	8VMRGcoWOoWnUBakgjDCfgTJpnZpkjqZ1ov0Nz9dEtqJTuizUbs9gwgFbZ+Wy4AylfqHIeuJLRM
	5ii4zpPqfux7zex3r4/RFxzieiRk52mM3y1hm7+3uzVXV0qdswF+huD/XiVkxL5KuBJwPFOGTa2
	twcipNnX1Ljd5uZoDgthNY0YU64fnn0G3/8fn93ha0pTSFecWjsdKUf3+drJZmMKD+QhwYtx3sa
	tUs8XmMsLa0dpbgWvZRslenJZJoE3uXUSPInCNC5yOPhIg+hHWzqhQhm0
X-Received: by 2002:a05:600c:35c1:b0:485:3b50:fe54 with SMTP id 5b1f17b1804b1-486fedb2545mr263590855e9.11.1774354472326;
        Tue, 24 Mar 2026 05:14:32 -0700 (PDT)
X-Received: by 2002:a05:600c:35c1:b0:485:3b50:fe54 with SMTP id 5b1f17b1804b1-486fedb2545mr263590405e9.11.1774354471864;
        Tue, 24 Mar 2026 05:14:31 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871107eda1sm28749405e9.0.2026.03.24.05.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 05:14:31 -0700 (PDT)
Message-ID: <5e5706bb-0f04-4bb1-94f4-45083a3c76fd@redhat.com>
Date: Tue, 24 Mar 2026 13:14:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
To: Michal Piekos <michal.piekos@mmpsystems.pl>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260321-vlan-restore-error-v2-1-45cf56a5223d@mmpsystems.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271015-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[mmpsystems.pl,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,renesas.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mmpsystems.pl:email]
X-Rspamd-Queue-Id: 599CE30812D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/21/26 6:38 AM, Michal Piekos wrote:
> stmmac_vlan_restore() unconditionally calls stmmac_vlan_update() when
> NETIF_F_VLAN_FEATURES is set. On platforms where priv->hw->vlan (or
> ->update_vlan_hash) is not provided, stmmac_update_vlan_hash() returns
> -EINVAL via stmmac_do_void_callback(), resulting in a spurious
> "Failed to restore VLANs" error even when no VLAN filtering is in use.
> 
> Check presence of VLAN HW FILTER flags before stmmac_vlan_update().
> 
> Tested on Orange Pi Zero 3.
> 
> Fixes: bd7ad51253a7 ("net: stmmac: Fix VLAN HW state restore")
> Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
> ---
> This patch fixes a noisy "Failed to restore VLANs" message on platforms
> where stmmac VLAN hash ops are not implemented.
> stmmac_vlan_restore() calls stmmac_vlan_update() without checking for
> VLAN hash ops presence which results in -EINVAL. 
> ---
> Changes in v2:
> - Replace check for hash ops with check for HW FILTER flags
> - Link to v1: https://lore.kernel.org/r/20260314-vlan-restore-error-v1-1-4fc6c3e2115f@mmpsystems.pl
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 6827c99bde8c..cfc0ce9cec9c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6863,7 +6863,8 @@ static int stmmac_vlan_restore(struct stmmac_priv *priv)
>  {
>  	int ret;
>  
> -	if (!(priv->dev->features & NETIF_F_VLAN_FEATURES))
> +	if (!(priv->dev->features &
> +	      (NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER)))
>  		return 0;
>  
>  	if (priv->hw->num_vlan)
Adding Russell.

It's not obvious to me that with this change the
restore_hw_vlan_rx_fltr() and vlan_update() callback are still invoked
in all the relevant driver/features permutation.

/P



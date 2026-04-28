Return-Path: <netdev+bounces-282030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLPFHs7x8Gn9bAEAu9opvQ
	(envelope-from <netdev+bounces-282030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:43:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 130C848A23F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BB94301D150
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D819F44B67D;
	Tue, 28 Apr 2026 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KPnc7a5k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BFA44DB95
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398220; cv=none; b=lAEFMLAimuBY6U4+PX/rBLVRPP5wLpMEonVFkzPbOxp0HQaT1NhzmELo/6Jb4rADnPuwJn1WOTb66rctFmE959tB1sqbTbjpgCvqc5S+CD5dNBvD9aEJCO8gFdhGjoT8iyqtrRPWxL+HsM2VdXkan+KxnCWKQCsHLjk/5BRUI4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398220; c=relaxed/simple;
	bh=rOxrS3ATkBXcYQlvpQQZGZoXlMvDMFOeqqLHTohAREY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpDdN6mCCl/45dnqOyUdXWxVwzG2TvzthOJC3w5ESGZ7wTVLtjwLzSOK+9LtegP8sfbR/2EXEQAl9fl3yEftSyIT0QHvpIM8pCiqbrc7bVKsfVWvH6hZ9/OdwsSelc9a270W8aIdrirkEiEdC5jUlBxR6enmJk77OwS1tyjay/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KPnc7a5k; arc=none smtp.client-ip=209.85.217.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-612d8a59cc0so3785103137.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777398218; x=1778003018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9u+qF+6aqxOyi7By7zQC9W/ZP4APPc4fxmJWF1UKk6A=;
        b=aUBKQX8pZxksHpaoDK3Qbc2u2jE6gLmpUOsmdMzbgjjJfHsb2lX/vosnRSfgBTj0hr
         lDRTJTt3vHNEdL3tBygWBkCup7YixNpbHyM0WEUcg6htAepSOAXWt81bi03WlqbCeQvO
         RKT8xPRUAJMQyG/nlD6jrHPKV3LwVWI4H3IUfbaVqtgyPfH+77J6YwVv+1K8/kXMQqBx
         VM2BvwQxcw6PGZP+HYNsTcC7PoeRv/ZiI9B8hnaOrI0QlZAOpOpCZd3y7/RQo8m30oux
         68WmY0EaXXEfwHOte+xV05zzIJJ1FvcT69/Tz2+RqU1zEUf6M7XoNb4OGbX34971fT47
         U43w==
X-Forwarded-Encrypted: i=1; AFNElJ/qaV5I0wY4+b+1F8sVz/fdvrq0469MeC0P2H8SGgyX3KaOGzPFyFf1zW0zZ+RKoOy21TmEE84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2S+xFYumprwmCTfj5eG8gFhrjEhXTxtZ67KwWm/zGwEx3u8N6
	oJyBme2WvHoG4RGWYEZ86IJvc9CssaOaG/vmx7QccrLiJ7JQ7cFPgktcz/NGhHmU8xl4dPWT+s3
	QBXpuxSF80w5tMQrK1ic62GB2OdOR6NPD/OZb7QzNk98Z3V+e0OZOHocm4deJ/+IwVE2Dmn+lV2
	xbQcI3U3+yaL7bRSx8neoNkFRdsZxKTPbNHhx06ZfON0cTduvYZ3AjvUvWe5Brg0TsPlXaqExv3
	k4vLBfziw==
X-Gm-Gg: AeBDietMp8+yzOx8+z/vL7otHDA5QDDJMQC0FSeZ2NeUUQo51irKmeRkQ8edFLv7tEY
	Zj/0s5Khos9Z5w9KU+MMjS55007UyafAzoB9CsbDN/GgiNfbvh4FmrYirgYbeYM/SFFPyHwJM3h
	m0oA7m7G+PD2PSbwmtnDJ6HN30eu27XMLKsuiSqvxYt3xUHLYNzM2+br1Y2IHf9oQwuzCax00Hc
	XVmFDb6hmD9KNPCepNN2/4H2iuM3UaN7EKbDbQgCqzq2g/fs/A6thXdelMikFtFMyTJaC5dKNEh
	oIQMHbdxgZhrCFj2to9/dpLXQSVpHsQaJ9wrHbYiRjv1y2d7BgTsSckHUVeFBrEXZWbgkTZ1Y8l
	3466T9rsAlBVGfnfrlX+ZjCfaXdKimXZ8nIp/LWHs6D9HpSwg03kTETaDA930ThFc4hLoV+06dC
	JnVT4Mc2P5skv3wg==
X-Received: by 2002:a05:6102:4245:b0:5ff:cee8:660c with SMTP id ada2fe7eead31-6280b6f1eb6mr2442267137.31.1777398218057;
        Tue, 28 Apr 2026 10:43:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-627f5176038sm233526137.3.2026.04.28.10.43.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2026 10:43:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12c35f2c09dso15020247c88.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777398217; x=1778003017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9u+qF+6aqxOyi7By7zQC9W/ZP4APPc4fxmJWF1UKk6A=;
        b=KPnc7a5kSoml4u3LUH0wM5e/WBSJNy5VfI6VeZJyUaps5ldIBD7CNl27s3NsrFPXRe
         LkraMFvYrZHJCmXH6eH5t2TyhOCQGFUM5dRh1mQpxpEid9soSerePISqJsJlvDiStkQM
         7PUQeV4h6LqgF579UJeahhJRQi2Czw2YvgL5k=
X-Forwarded-Encrypted: i=1; AFNElJ/nKB6+IQ1sE1ugNpqSInQ8BEXjwEfh5WO9Uv2W5FPkpG/pydKQqsLLOXpV7zQXJiJdNuQT6Cc=@vger.kernel.org
X-Received: by 2002:a05:7022:438e:b0:12d:b175:2573 with SMTP id a92af1059eb24-12ddd943b7emr1949511c88.7.1777398216675;
        Tue, 28 Apr 2026 10:43:36 -0700 (PDT)
X-Received: by 2002:a05:7022:438e:b0:12d:b175:2573 with SMTP id a92af1059eb24-12ddd943b7emr1949486c88.7.1777398215982;
        Tue, 28 Apr 2026 10:43:35 -0700 (PDT)
Received: from [10.14.6.173] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd93c1c0sm2500439c88.7.2026.04.28.10.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 10:43:35 -0700 (PDT)
Message-ID: <df793a62-b0a6-4500-94e1-05ad54ba830f@broadcom.com>
Date: Tue, 28 Apr 2026 10:43:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next] net: bcmasp: handle EPROBE_DEFER for MAC
 retrieval
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:BROADCOM ASP 2.0 ETHERNET DRIVER"
 <bcm-kernel-feedback-list@broadcom.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260428014329.779779-1-rosenp@gmail.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260428014329.779779-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 130C848A23F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282030-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/27/26 6:43 PM, Rosen Penev wrote:
> of_get_ethdev_address can return EPROBE_DEFER when using nvmem. To
> handle this, encode the error with ERR_PTR for minimal changes. Adjust
> the only place using bcmasp_interface_create.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   v2: use dev_err_probe.
>   drivers/net/ethernet/broadcom/asp2/bcmasp.c      | 6 +++---
>   drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 6 ++++--
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> index 972474893a6b..e9b11b956344 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> @@ -1333,10 +1333,10 @@ static int bcmasp_probe(struct platform_device *pdev)
>   	i = 0;
>   	for_each_available_child_of_node_scoped(ports_node, intf_node) {
>   		intf = bcmasp_interface_create(priv, intf_node, i);
> -		if (!intf) {
> -			dev_err(dev, "Cannot create eth interface %d\n", i);
> +		if (IS_ERR(intf)) {
>   			of_node_put(ports_node);
> -			ret = -EINVAL;
> +			ret = dev_err_probe(dev, PTR_ERR(intf), "Cannot create eth interface %d\n",
> +					    i);
>   			goto err_cleanup;
>   		}
>   		list_add_tail(&intf->list, &priv->intfs);
> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> index ec63f50a849e..caf0e408e2f7 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> @@ -1254,7 +1254,7 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
>   	struct device *dev = &priv->pdev->dev;
>   	struct bcmasp_intf *intf;
>   	struct net_device *ndev;
> -	int ch, port, ret;
> +	int ch, port, ret = -EINVAL;
>   
>   	if (of_property_read_u32(ndev_dn, "reg", &port)) {
>   		dev_warn(dev, "%s: invalid port number\n", ndev_dn->name);
> @@ -1314,6 +1314,8 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
>   	}
>   
>   	ret = of_get_ethdev_address(ndev_dn, ndev);
> +	if (ret == -EPROBE_DEFER)
> +		return ERR_PTR(-EPROBE_DEFER);

Do we need to hit unwind here? i.e. goto err_deregister_fixed_link.

Thanks,
Justin

>   	if (ret) {
>   		netdev_warn(ndev, "using random Ethernet MAC\n");
>   		eth_hw_addr_random(ndev);
> @@ -1340,7 +1342,7 @@ struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
>   err_free_netdev:
>   	free_netdev(ndev);
>   err:
> -	return NULL;
> +	return ERR_PTR(ret);
>   }
>   
>   void bcmasp_interface_destroy(struct bcmasp_intf *intf)



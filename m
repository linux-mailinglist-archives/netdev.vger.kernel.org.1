Return-Path: <netdev+bounces-273289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBu5INm9ymkb/wUAu9opvQ
	(envelope-from <netdev+bounces-273289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:15:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B2435F9DC
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 897903016EE8
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9184F2FD7D3;
	Mon, 30 Mar 2026 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3VGP6PA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF527A462
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 18:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894540; cv=none; b=mbezfKPthVJT/3C0Tzh95Ay/KMCLP35/culVJrkxhzQI5ibUDzHYSz20HNEbg5+svQBd7XADLquFe1GUnA+dMupwfyAGin9YIMpMEXMWibIJlv1dgFr/X1J5QcvmRpQoyTFkTEhkW7bIdRakUi5fOyzGqxhUiPGL03XfKjq9g80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894540; c=relaxed/simple;
	bh=2Wmykm9TEFQ6qJqutwx5G/WM3MIPHdk0eyShmReCWl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAQIN0KAxsUrcXIhwuzcREfiixjOARh1zyPzyOTThCQPsZe/caj//gYqbxezL9dvz2QYvOQ1Zd/hHrJFszEF5azx4awa8JzvftIy8uchLIT6oKDdyGXNBfcVwPZcmj+vyQ+123xwYgVETVyLEzEBrTKV+HA9OkmltZjtEhawqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3VGP6PA; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b4520f6b32so5244009eec.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894538; x=1775499338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3FCFfolEnP72cZRGyyoWzCdd0oZhy94NWlfVfZ54PQ=;
        b=o3VGP6PAtkMFocHSb0NQ9Vz3JEJ4Um3CZPorVo2enIDFF6JnS7UEPbHM424gXx/Hbw
         u7jgpdf1aFlk08kJ13SByjUe9khZXlsyutYOPiGHj2QqpzZXfTYDMqJiEHp2L4r/ECht
         D2OQMqJ+y+XD+tHen1EXLD5JttWWxN4FWOGoggEVd+nzPwQmysbofKq8Rm/Hv7rBuFDT
         myVjG7mwwCTvkuiLiONvdJRPuyo4aMJrSekL21RK9jRf5CChcnIMafJKqpx9RN3J9KfD
         5OkeRxOrDQ2ByLCGi0ykcdJhYCk2wOrJajH24n68m6DSUH+y7aBxCVLlWbi5mLhDimbS
         ChtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894538; x=1775499338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3FCFfolEnP72cZRGyyoWzCdd0oZhy94NWlfVfZ54PQ=;
        b=c9oRmuLJpQK5xr1rVQW81Psv+slYX7osCaC1mt6UW5jwt+1wEkQyl29cW/5Mt9txgq
         f4PBAQwAagiYI34gv6neMrujHr8vUoQrz15u/L49e7DjqU2GmT1+b2Wp0dceq7Dy6bYV
         1IUZlTHdwLEiIrFjpLtUkvc+CMzqucOUZKzkEM64gH2v5/3ibUxJtdJQlG4ssP0V+12J
         WRn0+HVYzAh+gUBbIv11KgDOYfOp2lYSRXyWMIkjjlnmmbGuTITIHBfqIl8aneHQ138y
         JdeIExWCoJPepGDwOsmJtwLVHrpc/E64CMQoUojBOYsYzkADHiJQlN9ky+RYi/DAvUki
         RGUw==
X-Forwarded-Encrypted: i=1; AJvYcCXMNBIoQj8mOZ8ujpKuKQnMpY1gB1jDgs24hQcjKF2vWNDf5HrbLBRzR2KFpbQ7tSD0YUlsqjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvwcUmbiv9NKoSimDivWEnmY5a8fD5mFTyuf3kmUbT3l/xGeo0
	onzdoE3jD4yHkY1y+k+vNUt4FoRiRjsLhym+w28lvukIpmZXJNBoOB0S
X-Gm-Gg: ATEYQzzoB2CQGS3JQm/Sn476CtwY8dLWttrllEcu3e2IN3S2eZn4AadQaeB/eA+NDhs
	9W6DZqNlKtWo55STbiaZA533HDJi1v04e3O6hbXsA7n7ErkTvoitssXB+n+rWrYdmz3WMXKBnC8
	ERrynZK+1P0iV3dYfTZZsgfdoiGTevUVmD1UM4ESY94o7f3IAQlktge30Vv+zDABtmjS+NblTVv
	XHNxbdMU+BOwu9rPWY/MsYz8Jj2Jz1PqFINQxty6gFAJH3zItt/cXSFoBcy1YuEme11c3/DOolh
	JrDn0ZEbLD1uLGrZzeaAE2w/8Pw+3wqfEnqlsUxUNtq5Hoe+hYHHoenv5kYrjcui5eNsCAVpDgS
	+0NtTflRsuBSYf3YABi2PnD8azlvSEzUGzxKcXpDJh/f7+eTFQ1qCO7d8xSLlOXSIJfNtdqCQwB
	srDkfqXg+MuDL18Be42vrdDsQOApvF6IKgIY0q9trFd30SUnzHZovMVoPB0NEzTL5tdeH+rD5Gf
	rS9U8ZB9Pbc
X-Received: by 2002:a05:693c:3005:b0:2c0:ba91:48b6 with SMTP id 5a478bee46e88-2c185f3295emr7416238eec.26.1774894538329;
        Mon, 30 Mar 2026 11:15:38 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::1:79e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm7758362eec.4.2026.03.30.11.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 11:15:38 -0700 (PDT)
Message-ID: <1d551008-3c42-4b7b-9507-03072740a54a@gmail.com>
Date: Mon, 30 Mar 2026 11:15:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: bcmgenet: add basic XDP support
 (PASS/DROP)
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-4-nb@tipi-net.de>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260319115402.353509-4-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273289-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13B2435F9DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> +static int bcmgenet_xdp_setup(struct net_device *dev,
> +			      struct netdev_bpf *xdp)
> +{
> +	struct bcmgenet_priv *priv = netdev_priv(dev);
> +	struct bpf_prog *old_prog;
> +	struct bpf_prog *prog = xdp->prog;
> +
> +	if (prog && dev->mtu > PAGE_SIZE - GENET_RX_HEADROOM -
> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
> +		NL_SET_ERR_MSG_MOD(xdp->extack,
> +				   "MTU too large for single-page XDP buffer");
> +		return -EOPNOTSUPP;
> +	}

The MTU check here is great. But I do not see support for 
.ndo_change_mtu. This would allow users to change MTU size AFTER the 
program is attached.


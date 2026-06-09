Return-Path: <netdev+bounces-297261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q8DGEw1wKGrKEgMAu9opvQ
	(envelope-from <netdev+bounces-297261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:57:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB851663F5B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:57:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dama-to.20251104.gappssmtp.com header.s=20251104 header.b=UyXqKSNF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297261-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297261-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A7A2313582D
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3470640D59C;
	Tue,  9 Jun 2026 19:51:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CCC48124E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:51:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034684; cv=none; b=nslCcyQftuup2AOSoW3Q8JIEGgdNehxnu3DBJHxIFSl7XNm8WtAS4gxHIuAW5coEFgWsUCHxvEY953BwwnZEsLy7rxtw+IEw7Fta9Zcn+wg1LOjMIkjacgNktCtbb91Z2OpuPP0XgTRloJkAw8Yg3x9ggqcOfD3mL9xYjKgaP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034684; c=relaxed/simple;
	bh=fGch22jZAhUnZc2JB3l1ZbWmjnBlSQCGkHHpCvFs43M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kybQUgzYuyCnKgFKcd/XepUf6fm3HgPdVJaZud4mZHghaL/C1jcKtQDIaQvbnQM6h0YiMjN9E3Pin5DKvZr8DfBnyc/w2M2wsEyakVTTyLoAEy8idvk+15yoAtJZRUmB9/EusGs7BUKPqxl3Zb/yEDY09zzt5omNWbgcrmAivyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=UyXqKSNF; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8421f0e9c5bso2740768b3a.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781034677; x=1781639477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcuzUwojIicQgNYVYeBBnWiTMNVB+UCosfiJT5lPt0I=;
        b=UyXqKSNF7MeRdF+p+a/Q7xA+qqR94IN04PtDH2BybrKhexarRDDXAfF4tdhOmxHZrT
         RlIT5FXzHVn8mYXZfEr57p3iHASMqWqz0grvrUmfMehVf65VlftVCjtoDVLWqKuJ2g9g
         9ntRMpn+aNfBGOf07KdDrVHSl7U16jlIZWlT2DK43BKSPQUuTwCReOjGXHDGdl3IdIKh
         6zSSH7ggMDgL6SSWsEGUT3QNdVktO652YtC3QiGVVZcCBLfQYyp3ClOrutX6WYPXVWlz
         BNBdDphHRGrgneVhKMvz8GzV2KcIL06RS45LwY9HXPKhba+SWOylLOZqSXtO/6/vdshY
         IvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034677; x=1781639477;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcuzUwojIicQgNYVYeBBnWiTMNVB+UCosfiJT5lPt0I=;
        b=MCALDfwgIiWmfbb1/IyaTLBuOIvydc7SRmJaTCDrxmcd353QomH8DlNrTTTTP0RWQ1
         RVQjrYEsRpQxTJJqgjPwl602qIlyxNPpJZOk72Xr400oBkS949VaetLm+TwDBlmQirWy
         ptJ2z7iWo1WEixniTlN68dTJuTdSO04Qpg3JqplRHT0pr7BfopDqOFSXfR7ENvPH+UgA
         GNKMDNqKRBRUdC/snXMq2WYkIB4r0Zw0gGUkkSKlDpzrGtc6Ua8z1Qz/4r6DeEJtSiE3
         poYtafC31NB4/KZETZQqhR1ojcfpyqMGbyXe1G/wxileiZZdM9bNsVlkpZMR8Slw8PHR
         jh2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+VFE7LJgFT5aYZx5UzyteQmUz7kAXBTSFZVRV9u00xUP38b8Y56DPBH8w7K/qWyEs7PI9DBzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBL+WlZ+2ex57bvAa2wGT/weXLgWuAb4i8qcsqia0sXE8+tkVm
	JUSC/TKVB/d5AjgTL+1uPrUMp83CZJGrVNPK7P0msf9PoSUbgNkP34AxlWdVV6duJLM/OccTcGW
	2o87B
X-Gm-Gg: Acq92OGM88mUl3rTZRRuDlCzVl1bE1F3RIjsCwDgB2zu7BJzYUOntpOqenocDfz060b
	8/hL3yHd8QiWsRfiGZ1gqCUCMYT1QABnWXh/yiP4k8XDE3qYdoKyEDe9uYhxMfiAIFtyAaGRlHx
	qp4pxGdhKEhF3E/ZdDLxZCvTzgFfr2WoxI9LxGIONM/8DXAo73ebGMizQDOW309RxKiS9fhDLrg
	acVHlSkwPJbufavZhAuAtcm3taP5bPEujYTNdA7NvkoVlicUihy0/XwkwSoie/0kr+hMzP4Ox6H
	sAB985Afb/00vC48YMDf28JhlWUosaWWRpweglfZTLCcqY7CDGQFE3XN0867WLzWOfavWc+89WJ
	nkogmjYPU/fPyeHYK+Q8S/CXDkSLwIypsL0KTeU8van2bdMT6l0dzozbZttAIXe4NYKFzMCxqUa
	QaN6I80mkcLzsCn+Q=
X-Received: by 2002:a05:6a00:b807:b0:829:8942:2c93 with SMTP id d2e1a72fcca58-842b0e1c7d0mr21125579b3a.9.1781034677416;
        Tue, 09 Jun 2026 12:51:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428325d9a3sm22197411b3a.34.2026.06.09.12.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:51:16 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:51:16 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: networking: add guidance on what to push
 via extack
Message-ID: <aihutHOO7Dwp8aQ/@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org
References: <20260609190919.1139517-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609190919.1139517-1-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297261-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm20253.cco0.facebook.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,dama.to:from_mime,dama.to:email,linuxfoundation.org:email,dama-to.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,lwn.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB851663F5B

On Tue, Jun 09, 2026 at 12:09:19PM -0700, Jakub Kicinski wrote:
> Every now and then someone tries to duplicated extack
> messages to dmesg. Document our guidance against this.
> Also indicate that system level faults should continue
> to go to system logs. The high level thinking is to try
> to distinguish between what's important to the user vs
> system admin.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/networking/driver.rst | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/networking/driver.rst b/Documentation/networking/driver.rst
> index 195a916dc0de..abd366dd5e43 100644
> --- a/Documentation/networking/driver.rst
> +++ b/Documentation/networking/driver.rst
> @@ -128,3 +128,16 @@ to be freed up.
>  If you return NETDEV_TX_BUSY from the ndo_start_xmit method, you
>  must not keep any reference to that SKB and you must not attempt
>  to free it up.
> +
> +Error message reporting
> +=======================
> +
> +Number of driver configuration interfaces pass a Netlink extended ACK

Maybe I'm reading it wrong, but seems like it should be: "A number of" ?

Reviewed-by: Joe Damato <joe@dama.to>


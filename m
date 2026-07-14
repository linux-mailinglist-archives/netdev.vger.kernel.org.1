Return-Path: <netdev+bounces-307468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FIHOD/Y1VmoH1gAAu9opvQ
	(envelope-from <netdev+bounces-307468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:13:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4908754EDE
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:13:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b="VF2gBOr/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307468-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307468-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C482A304DE2A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE1D4657FB;
	Tue, 14 Jul 2026 13:10:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430224657C0
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:10:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034645; cv=none; b=G6ezPbJv/fzAbOTgvQs/vlVOu49GaEjSZ/LdWJYYAc7xlUxynT5l1ohBAcHH3D5SG4lN74gqZlledUO+U6tmxiugmhzhVPTBJAjo4ln1OfBPIBS1U9kWqFIXVQbVYWCz9nq4vjhj7w7DbJKz0vN/YrKtGUIGzd+81+EVuMZlqTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034645; c=relaxed/simple;
	bh=Wt0XsrpFCYOVOMQtdvuVWC8FpSQrK3dbcXgQQELA5E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXZ6LTUFIZ+L7w6lnhAkAFYt/7kinZK2hgeaIp7pdzi6ZM60CAu0ja76WY9wTE5Et04fogpngmiGYwO9c68IDS0PlEYvi2sMawD5vokO+XjFM0ZAwQsm2HMmSpfnk1njGJLQ5ZN8F5oLDeq/m5cp1IS0ZLvt7s+FusuM0MmMIq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=VF2gBOr/; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so31419305e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784034641; x=1784639441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fl2dG+Oml92bsky/TLYXt/NwIn7LAhhgtCJrCDemdtI=;
        b=VF2gBOr/6hwaVX5t7Z/v5+td9WpqPxLIk+n9Iy20iZrynA5ENJ6zeO/1jM5aDp1XD7
         XVv2VCX8zOtyOucd+U1Ymr/6WNixaUqajIoPcJcYjiuYV2DmnmwEECGjbOHvXv9rho9A
         KqW9Z76nH+8cyFA95HRT3gefjXambuXJgepAdDJa87XSOkWrOeHTbX+xxSvp7cndUAAO
         ogZn8LvTbGo1WIygX83ds3gHluGoZqntxKZW5wgOM2/V08aUlwCgOHxJvcbZu5NBxaXt
         OXYmP0KtxfjMly23HeEPGdaebGPaTeLnznPP+GtAg6PUs0s3nqB34itZmnyA49ZDckxC
         IbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034641; x=1784639441;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fl2dG+Oml92bsky/TLYXt/NwIn7LAhhgtCJrCDemdtI=;
        b=eNfQ0zfq44XUpNd+4OR+Rf5y/xqqC+dZ6xxcuM5rFysIS3wux2QiBusSaNv/M67Pjg
         yziMpwxl6wYAtW0lI9P9cTIH71kMRutNx0h/R6AckFjabkRLrJ8Q2WLmQ2TydRNlervL
         HlyRVgZmx0ZpKGuzxG3Gwklcm0UOCxlPhN7bSJhnJzeaq1hr9Perpi546jdmkqFM2Yto
         pgoCndpVoQWwpF6dWYt5GL2xdYPcjP43yUwq8nB72G5MnDi47z3eOaeOCvrLlEYfZD8a
         UZ9nG82h5LbqH9VDXgJsJhx7hS2Cgj2pZx0/1meCRN2ExUmyoFw+eDxCrYUimhCpOxxG
         CdLA==
X-Forwarded-Encrypted: i=1; AHgh+RodVVSAv7G7i7HFQnB1mqi9hBA/AuApHc7cELikKLCa1dAr5BrcaUD0xqgfUdJlyP8thfvwEU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLCs05/7hQr4EAnTBfN/zgct1c6RsmeHS5L1l/i4oFxpmmTXQ
	edPK0lKxJFhJwFzIfTpDg1flMiudiMRIQ+GFVtVDnXGj/8vCzfeNQsCP3olKX7R3Y6s=
X-Gm-Gg: AfdE7cnBeZnfFbJPa70kGrPuFkwt80EEOpZZ3MWKHhr//LqrW++Y1j5uG+rH8ksaLnQ
	a3tTo6Ijsto6Tov83hUDc/gtkuOwRkIKyF55zvPvyu0cmDWUo01VNi9L3qG7u/aNwBrsMB5O+gL
	tF7EUXXCHCrPsSgZ7NrmTQxbsbist6jB2Hw1kkLKe0yRALT+LuF/MBBQBQXZ+DtPFyCO6NMUO4s
	qkSh+CUr9I/6+jM+y5dwbslbmWnolXhn446jVrdz3xsgsP9hVYNGZE04Sz5Vfyw+5NeMaTiL31A
	tP3eKpxEdPF2JngiklAW9LXSUdSFO95aoFH75LKo+N0VIknL5+CKCsH2FBJ4wI1RRNRTiUSOsTe
	xEHoZJyp+ztMjIrdeXGaA4k/dPLJEIdj+7Z12nMJq6b5bEU6Mo3/SataeLBSxXk8l9YDzQaWuts
	DqvIDBrJqvWMa4UREqUKIujw==
X-Received: by 2002:a05:600c:3e1b:b0:493:e890:9e0b with SMTP id 5b1f17b1804b1-493f883157bmr140435405e9.26.1784034641364;
        Tue, 14 Jul 2026 06:10:41 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32b9f3sm85941695e9.13.2026.07.14.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:10:40 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:10:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ran.ming@zte.com.cn, 
	han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v8 2/2] dinghai: add hardware register access
 and PCI? capability scanning
Message-ID: <alY0foKtgceGUCtP@FV6GYCPJ69>
References: <202607132221104795CMBHxJGy8iTj3qc36Qw6@zte.com.cn>
 <20260713222804514zLeRvL3Su1xlklpOdahhF@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713222804514zLeRvL3Su1xlklpOdahhF@zte.com.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307468-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,zte.com.cn:email];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:han.junyang@zte.com.cn,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,m:zhang.yanze@zte.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4908754EDE

Mon, Jul 13, 2026 at 04:28:04PM +0200, han.junyang@zte.com.cn wrote:


[..]

>@@ -48,5 +85,34 @@ struct zxdh_pf_device {
> void *dh_core_alloc_priv(struct dh_core_dev *dh_dev, size_t size);
> void dh_core_free_priv(struct dh_core_dev *dh_dev);
> void dh_pf_pci_close(struct dh_core_dev *dev);
>+int zxdh_pf_pci_find_capability(struct pci_dev *pdev, u8 cfg_type,
>+				u32 ioresource_types, int *bars);
>+void __iomem *zxdh_pf_map_capability(struct dh_core_dev *dh_dev, int off,
>+				     size_t minlen, u32 align,
>+				     u32 start, u32 size,
>+				     size_t *len, resource_size_t *pa,
>+				     u32 *bar_off);
>+int zxdh_pf_common_cfg_init(struct dh_core_dev *dh_dev);
>+int zxdh_pf_notify_cfg_init(struct dh_core_dev *dh_dev);
>+int zxdh_pf_device_cfg_init(struct dh_core_dev *dh_dev);
>+void zxdh_pf_modern_cfg_uninit(struct dh_core_dev *dh_dev);
>+int zxdh_pf_modern_cfg_init(struct dh_core_dev *dh_dev);
>+u16 zxdh_pf_get_queue_notify_off(struct dh_core_dev *dh_dev,
>+				 u16 phy_index, u16 index);
>+void __iomem *zxdh_pf_map_vq_notify(struct dh_core_dev *dh_dev,
>+				     u16 phy_index, u16 index,
>+				     resource_size_t *pa);
>+void zxdh_pf_unmap_vq_notify(struct dh_core_dev *dh_dev, void __iomem *priv);
>+void zxdh_pf_set_status(struct dh_core_dev *dh_dev, u8 status);
>+u8 zxdh_pf_get_status(struct dh_core_dev *dh_dev);
>+u8 zxdh_pf_get_cfg_gen(struct dh_core_dev *dh_dev);
>+void zxdh_pf_get_vf_mac(struct dh_core_dev *dh_dev, u8 *mac, int vf_id);
>+void zxdh_pf_set_vf_mac_reg(struct zxdh_pf_device *pf_dev,
>+			    u8 *mac, int vf_id);
>+void zxdh_pf_set_vf_mac(struct dh_core_dev *dh_dev, u8 *mac, int vf_id);

I don't follow. You introduce functions yet you never use them? When you
introduce some function, you need to use it in the same patchset.

Honestly, I would expect quite different patchset quality in V8 :/


>+void zxdh_set_mac(struct dh_core_dev *dh_dev, u8 *mac);
>+void zxdh_get_mac(struct dh_core_dev *dh_dev, u8 *mac);
>+u64 zxdh_pf_get_features(struct dh_core_dev *dh_dev);
>+void zxdh_pf_set_features(struct dh_core_dev *dh_dev, u64 features);
>
> #endif /* __ZXDH_EN_PF_H__ */
>-- 
>2.27.0
>


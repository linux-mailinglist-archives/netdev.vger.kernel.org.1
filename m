Return-Path: <netdev+bounces-289290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAQgJGYIDGodUAUAu9opvQ
	(envelope-from <netdev+bounces-289290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:51:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05C57861D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 194C0300DD46
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B239DBF8;
	Tue, 19 May 2026 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szNMMRbR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723339D6D9
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173123; cv=none; b=pITsqmym9Hbq3McH4kL2fCLKMnPHcWa8g4lPoYpzY27yRTSr1NX49DEoGnsuLj7puw04cVgCqPVoiYsxSCUXzBEMBTGHwwe8yQk4K4oOPDAAe87d0HCRfxI9kNxsFuS+Nky+hNtjwbEo4+GENri86Ym8lsLHrK/DSZgAehBVLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173123; c=relaxed/simple;
	bh=UOcuMTpdbzoPX4wfvaURAgMpzn1YqSDoIYupHwNwy4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2tR8J/QeZ5UowoOAetoBtoklS9BHbpWUHKtcpD7zcv5OSqmr2Vvibexgdc8u0KfkxfZXasXF0TrGKkH4FsG48Bl55gk3+MhYhgSHmPuWYuNQAyQOvlEgSxeqDKNfsYz2k9BAfarjcx+jM+sYBMYfN0K42bvbf03sHYs0UkdyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szNMMRbR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so1539457b3a.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779173122; x=1779777922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9tSJoOKg/vW50+p43BRksSfoFvz7qTykVby+kYZtXs8=;
        b=szNMMRbRvVGOY2b/MA7V4hhZy4HvHYiULKiwDPmcjPb19BUn/M+63ftLjOdtjwdc8w
         7zNvTAynRJJoQ0oKG9cdpo+I/1tdRgf6kSQiBlpSlQ0dBDMZ+uQLEkvHWFx5X9TKjtZi
         Qevw/hXAFNbEkA26/9GQ8eq23E7f8P80m8HrqBkW+F4Ca8uyuSw+k0DMciczpF27StLi
         Y/tagLx+d8S2ogSWn0cilU02qMhIviodjYfgH6VQG+2ocg79HLstCndE2x/aanvG9XEc
         W8v/XWcBo8UddYROT00S+YzRsgh5j3FMayx7VzELJwri49fEIje/N8F6HO+R36ki96mO
         bXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779173122; x=1779777922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tSJoOKg/vW50+p43BRksSfoFvz7qTykVby+kYZtXs8=;
        b=R9FWpwLWP0x0u6IP1FjgaOaJmetHuO9HRRusKoIp2HsFP1/yC5FSEkza3sYAH9xXyg
         Ym5CvSBi+/rMtnaWLTT5xJ/Z02o27Co1SUmK3ESYZCUTsElmYI33dFsfjkbSCCScTxKD
         WtRQmR3lozppRlLhVaMf+tzCwxwofSuZ4pWG8Nw7b6wZ1IfABiKugHh36CKYsA7CHasi
         vEWsD332wD5S4sstgmD0NdxFZMqLX6C/8UEsFdWAJluTaqhiksqEKyT6gar7mkjyznsr
         j+402SjEEA6GZm5NwAIogKtlVYgQ9ysWh/+q1hh9hETdmAUJlK6x+bsTFS7lMJur0CRC
         OB4w==
X-Forwarded-Encrypted: i=1; AFNElJ+X4TXtsyWCi32WD1QMFwfHk3sypBQutWrrXmMiW+VIw3DpYcERCBS7Oq3bDuQHpKnqKF/6C80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRu+PwgoJ8kiksNsiFjQn9kO6MS42Ztg82FqbGFKCZCyGDE/i9
	DxQBDXnv4SH10lBG0cjtSvAwQuibVQATIwujKUP0ZNulvdJzi4/fJ8Yb
X-Gm-Gg: Acq92OGtrg8mPPvAMVIshXg3mwWddkCbusXonmLcDzNi1XDayhVEmAtgmVQ1fZvi46/
	6hiGvZgS8o4tgAhE5OmhP4cOEAKuVXVTZ+2FAPMMKz4d7jZPZQkDlDMSOhWS/TSQ5ObS5Bg9gic
	3eQfoSFzmHq0deLAAbXORdwZYhmbKfduY1zCMAMhCI+bDQ9uOfuLz1Dyf/HAUgGLZeOGhx05XHQ
	bZc+ez8Ket7MxNk8y7NFhrbDZwTNSqUcChYhzqDkCztuPICPFnAlDQ13TKVo1fbodX+Zl8x51aK
	Iow33+QuukeiAh4M3lios7bz9u0DQK6ur2txZxE9I6q6yAG0ga1Y83sk07ucwKKQbSNVpr+jRAD
	1UAePFO2Lu+4Iva7UybME1zZaGB5KGGUs9w6mf99WQt13BMSDUKyBcmwBTfmlKRTgv6qRvGMsfC
	MdlGWi7uGG9KwHuBTuPLF0HmvBJ5z4srsYYnVMzVVqV2A=
X-Received: by 2002:a05:6a00:4484:b0:829:8cfb:df45 with SMTP id d2e1a72fcca58-83f33c99b07mr18066494b3a.15.1779173121683;
        Mon, 18 May 2026 23:45:21 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c78844sm16002649b3a.47.2026.05.18.23.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:45:21 -0700 (PDT)
Date: Tue, 19 May 2026 15:45:16 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Cc: aaron1esau@gmail.com, ben@decadent.org.uk, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com,
	herbert@gondor.apana.org.au, horms@kernel.org,
	jiayuan.chen@linux.dev, kerneljasonxing@gmail.com, kuba@kernel.org,
	kuniyu@google.com, malin89@huawei.com, mhal@rbox.co,
	netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net,
	stable@vger.kernel.org, steffen.klassert@secunet.com,
	sultan@kerneltoast.com, tanjingguo@huawei.com, imv4bel@gmail.com
Subject: Re: [PATCH net v5] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agwG_G7l9gdT0BsH@v4bel>
References: <ageeJfJHwgzmKXbh@v4bel>
 <20260519040232.1395-1-rajat.gupta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519040232.1395-1-rajat.gupta@oss.qualcomm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289290-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,decadent.org.uk,davemloft.net,kernel.org,google.com,gondor.apana.org.au,linux.dev,huawei.com,rbox.co,vger.kernel.org,redhat.com,queasysnail.net,secunet.com,kerneltoast.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 0F05C57861D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 09:02:32PM -0700, Rajat Gupta wrote:
> The skb_gro_receive() and skb_shift() fixes look correct -- we
> independently reported both to security@kernel.org with working

Thank you for testing. When did you report it? The two PoCs were 
already public.


Best regards,
Hyunwoo Kim

> LPE exploits confirming they are exploitable from unprivileged
> user namespaces.
> 
> Could you add the following tags when respinning or applying?
> 
> Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Tested-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

> 
> Thanks,
> Rajat


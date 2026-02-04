Return-Path: <netdev+bounces-256668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ63MPoig2nWhwMAu9opvQ
	(envelope-from <netdev+bounces-256668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:44:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E0BE4B7D
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F3203002D2F
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DF13E8C64;
	Wed,  4 Feb 2026 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TgdN5U6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F723A7855
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201844; cv=pass; b=gOnrZ1WaTrG/nhIw9UbTjuCQCXFfu7jBfrxY984S8I5ed/S0HAlLfkulQ9jWoYhXy8WVqE2Yhui8hPPXjip57d4ZBPBEHbIu5N/FoB0m9LW/+ApYuM8J1F1OwdCUQDboGz3xkn7qTJaOecSXiItQuF0weX+Dx5HUAiy9C/OO2As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201844; c=relaxed/simple;
	bh=oyWFIMBOaDxU2t8WoC2FuxQuP5QZs4PVnysnh3yu70E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drY4gGgP7s9ewKfdzp5v+qxtFpYOrGHACIdZ374DAAJk3NP8PeS0rANJWYA7cJ21jlbS5+vq8gY5sVp3v4kzH2Jj8FPoKJjFJ4CEPEWpBTG63Ktd76a1Qhi5QgFA4ZVwwYhCOhzaUcTIezTZyjZ6iPNTYTRkZx+KQIUaRi3nmpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TgdN5U6Y; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59ddb31ddcaso7710325e87.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 02:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770201843; cv=none;
        d=google.com; s=arc-20240605;
        b=ZwSuYaykDqqymhesX4TTRdcE0tPkRFnMN/NxO+gNFItMHUbs0A7lcIOXSK4DcyU/zF
         iHtpTxLl9pJC//3EWFalehHtq0637sfvy2pPzdud0jJAjdDPeb6BhRo69LOcUcT020FN
         Qeic0hPh5qxEu5xsoMNzkshdN4tmY6bqEBGMrXH4tLMrgbCTHhuf+i7e0E9auuZn4Rar
         vaA+jGdbPH+RhCo+ZYOgUXPpISBz8YJzFYRN/3RNEdad6e0i3wOlERo/B4mt6m+52F+Z
         Lgtax9MlnRqNVPuzqht7J2yXTc76YxQpDbhHja7AdI5JSY/6Yz1Ps+g4I7/25rqjhJfY
         oftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6GBRTxiaIHYDP0h1M81feHYn0hLowCqghpq/KV73Qic=;
        fh=MQ+82iB7Nx2YR+ChOv84zOqDb2xWWerqRJN7RAKsiZU=;
        b=AUvtJmynWXNftbncZhEojkzJ8vrHssA1OkpYaVAfzZ45/Crste5fvHejP1wf8nopfz
         T1mtp9F7AHF8UlBykTH8XNbU62bCptKmAMJ3JHHFTnyLgZ7d64zBR/InTvpNARJ38nMU
         mbH23m2xtzj09cZZr17SoiiH+V2fOUwSAVugUfuKj1uiHFxqQvKoQg5X3j0YRhyklf1C
         TC6JK7u9w9Gvx+Ytlt6ULJXI2A58uqkgDks4e9FTKHokMIoo60kzIfP/fVp9pUkS7BLK
         cnUxl/XwZz1RGjA22sJKadwerPMC47oNE37UNisEGQUQUjhzYNJ0WjGa/GzRB7bONM0B
         cOLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770201843; x=1770806643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GBRTxiaIHYDP0h1M81feHYn0hLowCqghpq/KV73Qic=;
        b=TgdN5U6YNgMSWVpTdY5E99rQjj8fxIgO9rU8oel7zVABSrB+6RVMuh+iJpLmpcXCeV
         EbP1D/En7GLT4HerPPYbOIKXWP4wuPQpsg/rTZOXyjqmd7ILS/UqClAkhfsqJHJVBE+Y
         aG9HY6DHTLMmF0mOrVT/KjYS+15i57vWzTSkh2ozkmMrwSbb4mwQR/z/CJCrlgJjSMi8
         CSw0FGSlwmWtHmlYSaehYdnqH+FPZh6PfM8C3w1TFrwdqRIQ5K9eQjKw/aT/hRE1dHvQ
         NO/VqXh5k3rWWB+y6SKmknfbcCLlsDbBjGbCpIltDaMI6iwZ2SD17zcDZC0kzHzmhr12
         533A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770201843; x=1770806643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6GBRTxiaIHYDP0h1M81feHYn0hLowCqghpq/KV73Qic=;
        b=JQoE7I2j1UOpNtP1Be73cz8tuqVg03m/Ghmtrfr1qb1Xz0lth7u4DKaezLwnpWzTDq
         VT+yMbXMfzeZIncl3ae34zJYl+YTeTFymmlJnmu/yE2zv4iR+WNJRNSxOiNgEWeXMsf9
         MTsxT9CCUSpE16BMiVYrDITCHfnUzyRcw1HEzASJ3yO6HbzbRJbD9tJrAo3E1M3gN+Pf
         9PgtsDM4AYvDp7LucoNhddwijRvMoyyzLCYW+0oUWAfefydMGPYmcquAZzf44e0I5VYY
         XWdiYs5TCbb0wSMKDY0SUPX9iRlZVsWY/y1uIVxMkotkNg8USlTdVwLMoAcblC4iirjg
         BZpg==
X-Forwarded-Encrypted: i=1; AJvYcCWnNdvC1WitT6y70RvveRQLGTp3Dsogj2LrtV2yNwYUVN6UnOcmd+lXnOqI+e770KQLEgaxX38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxpQ0hIhfssu3IMGDEb71Qwn4WvyAXt9eZRUcaCn+9DGDiwhq
	AWVDFucRLGy7rdBHSeWhhCek/QYlZCyTPO3sjB+cU1jkpLwU9Lv7K1wh1a4d8sbCMjMKwxGxGgi
	PizZD0rf1Vog6vAJ+rSisrU8BIosn6/3TFXBxDc0V9g==
X-Gm-Gg: AZuq6aI9eBdIcVuyk7qbbeDRurtHHbLBVWu9ny9T0UR4cJ+90WLGxBLKEpbWJXlrN/K
	reaz0K3wjkRfCl2jL86EUYN2ebLDG81R6Qrm7TlRGSfc0m+iOFWwDiFiFRSgBHBc0sl0EzQSJ3+
	DftiTtLlftfLh0TWs/ZduFjJntPK150rn0ccn6z73QJTNZvme4dPbAjJBGtrPfRCkF6Y+sznkJV
	ZkNAgzaKem+WUMQsAxkAzFTdyTg9LyccZMGWBl4/gUJ9vn0VC5WJJiE9yHAE8eaZFppFj1A6RpB
	X4kt40EvTHhkpocqJj5Mn60Krzak
X-Received: by 2002:a05:6512:3a8a:b0:59d:ea7c:d93a with SMTP id
 2adb3069b0e04-59e38c2bac9mr967478e87.37.1770201842606; Wed, 04 Feb 2026
 02:44:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224155006.114824-1-marco.crivellari@suse.com>
In-Reply-To: <20251224155006.114824-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 4 Feb 2026 11:43:51 +0100
X-Gm-Features: AZwV_QgV6hgH85WqGpfdI5zwj42b46k5TE9V4UYkPQGAoIIS3m202Do7qW27gok
Message-ID: <CAAofZF4BaifjL_Tn+oRUhAupvydJuUUo9vXf6dOCqhzR6pA7GA@mail.gmail.com>
Subject: Re: [PATCH] ovpn: Replace use of system_wq with system_percpu_wq
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Antonio Quartulli <antonio@openvpn.net>, 
	Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256668-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,openvpn.net,queasysnail.net,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3E0BE4B7D
X-Rspamd-Action: no action

On Wed, Dec 24, 2025 at 4:50=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
>  drivers/net/ovpn/peer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer


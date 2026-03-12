Return-Path: <netdev+bounces-267195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDj+MNkas2mDSAAAu9opvQ
	(envelope-from <netdev+bounces-267195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:58:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B62627862D
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 301CD3018771
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8402FD695;
	Thu, 12 Mar 2026 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1YH5oot"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB23A6EF5
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345493; cv=none; b=XYbME0lHVqWwEoWzcMFpKAbW/yRDdJ+LBvuDgXliuNuJYRGXPRGxYaIaJICcEZS/9FS1qXafidCMx+zLn28nCrzdB8pBfBeKcjI7asSESI5ueldG94S9h9wuEciNhYciIsaiDqoKPKsrC/Gphy6w9YMMkQ2xMZjOllZNdY5740M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345493; c=relaxed/simple;
	bh=5UE/T1jNthcR7b8MiUJ651kstB5njdHGC1t04hlzgwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3adMmpOavYgiprFTP2MJOIErkdhU834uJV16XQyVQ7zNrkjdGOaXj8hyxELvQ0CHAv9Li5DT+3P7D9+cUQhTZD+alBogj1dpYJFa0/YVtsuzuuLKKIfg+9/qfNP8FjY3F7fU9z74InpTl0AEHF/x8UiOrE6J/Zd/kWUxcltjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1YH5oot; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-127380532eeso361372c88.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773345491; x=1773950291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TualOOlomjApqvxcE9/Qtca0qhH3rXH0Vook/Z1l6M8=;
        b=k1YH5ootwcqxWygzIv1u7lXj4tAbXm8jB/ipHxzUd5MoSvZz31ZGpr7nLdVlm8VQ3G
         bJscJR4PgvlIukncGWsS6BTMfCy/6Ubmh7O6FgjGyr85eSOm3OuzIF8fkLoTfq2yVUwW
         sp8ysGYTsy2Dq0Sx2brnNcyeKP8L5dKRaSUxiJeuPUCYz5oEb9qraBOUXReSpqp9dhOK
         DGrjEu6vBRUh2y48KivhiSieSu/Qd2Fqu5xmu3kom7uEGHobbpgJJVaRUmKAxCrbrAha
         r/9iiZCmCdD9yGxiquozxlrd0Hx86xjvCoE2BR4NNC6N34sIw7BI/xfoWLb9KQeaklVu
         LI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345491; x=1773950291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TualOOlomjApqvxcE9/Qtca0qhH3rXH0Vook/Z1l6M8=;
        b=iXEjdJkzVsaHIvRsSi1aHv6c9Jjv34yt8bNbbCVDX/hqw8KXDCG34EMq38Be9vBxf+
         hldCXiq6tuowO23GE5iYhtRBLAkHzLzsaJAbuhT7x9zSVfkhcrbyk1OZQqsoHXDUcbgt
         2FCbfpxu/Nzx04YkM3DueG4zFAwlDnErae9G0o6JXGw+rRyLwseudJCycsf4krGhl0zJ
         MIJ9itZ2O9EN3LMOVL6Z3utpd52aFqRT7TQwgqgzPCSuiNmkHW3b988ONp/TOHfZKp8F
         FZfzHF1ZSf+EKfMKdmeJRIs8H0RASfACiITQIZ4jQTIvkM+o5gOR0TZKiuZz/F+K4s48
         KTWA==
X-Forwarded-Encrypted: i=1; AJvYcCUlWAyz8YGK5EkPF0EguXRpnk3c5DxyRdWE4t/bcBFOQOkui8ZabicCM/SEZxXTZxpYfabtqyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQeiNaZ01owc4JO9hixMGt24j1dCMpRZqSKqYZbtPsYH+xEls
	fy5w9Mv3OOfXvMVDHgrVbMGb8p5rZFHK13dQygbTCk8n/oqWZAcGP1hh
X-Gm-Gg: ATEYQzzVNxgHpu+YJwHSp/Bo66xounL68FUEqpovE1HZydJXW2Y5D6QYzsvt1XRhXer
	eeRhSMX+VK8lMePWl3OdJTpXSlaeGccr6IwOXvFeRubE8Af4cfRoTKGQ3a+RbJLW32MvPPIw/Td
	L8VZQtzBumStjvqAaAmy6vyMxwOQ4JJtoi0togqHNufNa15tmgOadxl+0VsKwSRQbrgy+7yZ+1H
	tF573qHDKEZhNQtB3CLZkbIvo7A05tyqK3PbPUVEzapKeAZY1WyYPfHr/MtEHyxAwFA0mHPtFyO
	PJr0OTbOtS1gFkaZvz53EP83sSLzZiqqX7RGVnHgc6WxwtJRBgegvnF6oPjDoitRR2fc6xRfgjM
	tuykjfAkc5ypv6vX0jS4JVepeN0A631/rQ1wSvWOQZOl6fmJyWvx5CDuD+qagQ/dP7guSez+ehU
	6PNOk9bOxuj0WdnVJ8kaicYYnCPPgbQRuYnGxU/WT9j1+knakpIA==
X-Received: by 2002:a05:7022:eacf:b0:128:bb7e:b5f7 with SMTP id a92af1059eb24-128f3e20421mr378979c88.36.1773345491276;
        Thu, 12 Mar 2026 12:58:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7bf0f69sm8351262c88.1.2026.03.12.12.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 12:58:10 -0700 (PDT)
Message-ID: <5538dd2b-156e-40ee-b34d-2c2952ab13c7@gmail.com>
Date: Thu, 12 Mar 2026 12:58:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: increase WoL poll timeout
To: justin.chen@broadcom.com, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com
References: <20260312191852.3904571-1-justin.chen@broadcom.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260312191852.3904571-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267195-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4B62627862D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 12:18, justin.chen@broadcom.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> Some systems require more than 5ms to get into WoL mode. Increase the
> timeout value to 50ms.
> 
> Fixes: c51de7f3976b ("net: bcmgenet: add Wake-on-LAN support code")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


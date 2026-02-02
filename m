Return-Path: <netdev+bounces-255767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC/9Cp1YgGkd6gIAu9opvQ
	(envelope-from <netdev+bounces-255767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:56:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 823BFC964E
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 08:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1F37302BE93
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 07:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA213314B79;
	Mon,  2 Feb 2026 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJTh01WI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4D312834
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018422; cv=none; b=KcWrGcO2xrzkjufPhuxoKPRQToHtXsMccgyhHH5TT3X9SiP+21txSVahoKGUJTJNz0lUHrX7516yHeJx+yKWY85IDayg1j8Rqw9vG6EvYCt75nbglWj8UzAObIIgIjPm6kyx1+sLpjYcJr4xrv87uySdKgtAyuGiAM4Z3BP0HE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018422; c=relaxed/simple;
	bh=VdDgSvpaieI2p/IyVOSxK0KmRJwvG2dxqD556BPWle8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgiYsIOH72iasu6J+bZho3ADmv6jbOgQNGgcAZ8MehawxqekPhX6moXBDA5QqkMQon60VyRX0PwuOkg0hiVRbu3Y5wTrUFUjaNJn2j9s9BqaSepGN0peW+TyRVy1aalQdsD+Wmkg7ERt4Q9Gcns7x7rWpTnrmC8YuNxHCnooyzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJTh01WI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so33571765e9.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 23:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770018419; x=1770623219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvEh3LdulASC4NAVEE51TIBolXq42cdGqQesFC9LyN8=;
        b=iJTh01WI66x9nchD6SiAAK9nyAbpIoG8n4xXn7LMNqQqHowFCkdllUOw3CXIG/Henn
         Rksz+ezYslkcHp+V4MmmBF5nhXvkpgPJEky6edn1cv4oiwIEaPI9KsfgX0C14S42uT+u
         kKGzzrdHfmmLHo3opQVa8P6cZacuslVQ+ipVghPPfDta2QBFxbJc9OhbmqPG1E6QFQXf
         Oz31esXDYWSlBGR2DLgwS1ThgbhQH+0SI/6ygfu67GjghJENKGiXIZN2ROyyf/DMpc3J
         4rcRRh6vK78xnAoANdM+BgZuwdIrRTaGGd21A/SXX+2YDCTVU3TY1+JOlMNA2raE8YPz
         wdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770018419; x=1770623219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvEh3LdulASC4NAVEE51TIBolXq42cdGqQesFC9LyN8=;
        b=OSA2+svMMmygYeDbZmAd8pORmXFxQnhjY6jYaPZYNk6lV6tl/Dp1M9o3X3N3Vguq98
         nbaoBf17aG9c+AYf7muEacoH5F5xXcK51siWFFOY+UBzUxsTSvbBemlpSMfWCv88rfht
         HNRcZiiv/TJwqbxP3lFaeCkS0kSVxGj95gxxsh2mOQnJHaNGAqQIQjXhPVAmn0BR9CB6
         6TUdPyUw1JrJoe7zO96wsO+5mS3fFzeBscbG5pBsJ6CxI+F5nkIeBJ3NNHbP3tBGauE5
         mkPM4V8WKoi9ezmtIiorz9VIji8ncJqBdK+Rc2+iTMJGdnZX2WV8dyIeIaGeiklStcU/
         nKWg==
X-Gm-Message-State: AOJu0YwdNqGsfg0AE4A/QHQ8XY5xFAyytqObxKObOoKibvddN1/SpcW+
	4g4H6/ag/Y0kVXyCaK5fDfJiIk/XnyfEQ+Vii2M3SazWh+Mulgbh4Cam
X-Gm-Gg: AZuq6aLsMYeUuoG4f4FI3yFo76pl3D5dKlK1v3J15bcFfqAD4yxXpQDTiv27R+rhFHo
	4EX7OASl3fgyPoSZ3xRW4sQBuqQvfUQ40Ls22d+qekksqK2HmyybIBpMm1rsdVDkewUo9aH1PmZ
	3Zogwk2tGY55H+ZAl2LHpxNR2AJF0yu4fU3304NbtK1V4yG4EVoGjQrK0tf1GtKr9nqV5Rf2MWP
	i/iyA5rnOZm4iaRNAXD8BB2YgoX5tUbKe3YxGNOA9p+3WWMY+DJX1rKkZxEuiLgqbbujmDVkQve
	bCCTh7grACcXMhmoMpE215SYQT9NiPssSvmtgtIj3u+H9mBL2gAWfFj3t15Zk+c2ow3r6s5GqUb
	2ZR7rhpJKqSQt6eA7Wdtd0QsisuL11ORKETOzlnxlTxECyYAx34kGlxcE43EAua/lv6G13a4/TF
	XXZBQZ7G31BwfPBRduAMlLbamWuZkEx8tx29S8hDgE5xg76QHO/yfdMQrmipVQjJjhApqamRSHg
	yx5luPKEQOpySzFJ5YuyIhtD6rZdMVDrfJsAm8VqpV5l5r3uXQUzQ==
X-Received: by 2002:a05:600c:4f8a:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-482db4568dbmr144485575e9.2.1770018418392;
        Sun, 01 Feb 2026 23:46:58 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4b:2a00:c9cd:e574:8d91:9180? (p200300ea8f4b2a00c9cde5748d919180.dip0.t-ipconnect.de. [2003:ea:8f4b:2a00:c9cd:e574:8d91:9180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce4c3c6sm370898395e9.10.2026.02.01.23.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 23:46:57 -0800 (PST)
Message-ID: <415271ac-f37b-4efa-97ad-f6da68353e54@gmail.com>
Date: Mon, 2 Feb 2026 08:46:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: add support for RTL8125cp
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260202021800.182-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260202021800.182-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255767-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 823BFC964E
X-Rspamd-Action: no action

On 2/2/2026 3:18 AM, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for chip RTL8125cp. Its XID is 0x708. We apply
> different and firmware for RTL8125cp.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> 
> ---
> v2: This patch fix one mistake on phy_modify_paged(phydev, 0xa43, 0x10,
> 0x0000, 0x1001) which is phy_modify_paged(phydev, 0xa43, 0x00, 0x0000, 0x1001) on patch v1.
> 
0xa43/0x10 is PHYCR1 (at least on RTL8221). There bit 12 is "ALDPS XTAL-OFF", and valid only
if bit 2 is set too. And bits 0 and 1 are marked as reserved, to be 0 always.
What PHY is RTL8125cp using, and has register 0xa43/0x10 a different meaning there?



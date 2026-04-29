Return-Path: <netdev+bounces-282430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI9pLg8l8mlmoQEAu9opvQ
	(envelope-from <netdev+bounces-282430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:34:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC1F497025
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6325131577E0
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4603ACEFF;
	Wed, 29 Apr 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcbpjvF1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9933B0ACD
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476434; cv=none; b=i32WFjpiZtRT7nPsVz+N02+xTsCf5Jc6Sum17cgn1jLueLpScZW1k6lWrvlr+PDYHf+a+lzKtqfOAAxQrLvvTR9NWPT9/7LGJb9v058sdWjkj2hcExFdoHRsnf1zPK8Tq3YhFtaiB0bRhCkgLNgLuk/gnw2CUts/tXWMV3weTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476434; c=relaxed/simple;
	bh=yH3lOS+okcN9lX37K1yKCibq1O8XsuGDUh7KdJIH8tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnMek042P5N9hrWIml6KyxE42svqr9JObMI/sdfrkI8wq7BRyuETUwaTLAj9ytS/kRS+Y/PsxykAfvNivDvNCqQCizl7gzF+UbPKWgAzsyWJlo3dTRYNNPCrM3v6AWrBdzS4cvqTgS+vT3BrWkkaoHvUFuhBY1Lm+qNv0zbyf78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcbpjvF1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso112013835e9.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476429; x=1778081229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y561SdX4ufl2HV+PYvdTDx/yIZUsaqz/jgiYxdaXm/o=;
        b=hcbpjvF1LXMrEmHY7DtpTG/UDFIuRn3vIJS6pKYwLFqRaoQFM+NczeJvj9E3oKg10Q
         hn8UWwqknWgirRpoT9KibsSdFGimSLdFboMKNAd+emW3d1zim41oi5XRyHFbGIvoO7RZ
         SwkkO0tWhUxjabe47kzMaWXXlCJlqJiLwSfsiMKjiswMZkNazhL6do3B+vNReAyrhbAT
         fv+NkKS0fcEl47q0lCp2OZgT7H1wB4E3Ynf+b/kSr+JE17PZRZasOl6uaGdkMciRO01X
         52qAxecgBJf/qk5mHNixc1f9oylt4pH9Idhdzq8houX7EQYzCBrY8uUOdYr6uDGOmnZ2
         cNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476429; x=1778081229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y561SdX4ufl2HV+PYvdTDx/yIZUsaqz/jgiYxdaXm/o=;
        b=LEVE4Zo77cjdNFI/l7zip9Gw45rrtHqTKNB5fDjSmVEnmNT/+OnHTDQFEGtIBsaK0v
         mkP/mukKG3mrycboLrEWxLlzKFaPNuwsV6IZ/mQPdr2y1/zWimjqQi+J9M4AdmHUpTam
         qS1KEJInp7wG4toP3p1l+tY+QL9z5wkaGwiYpS7TMS9HeNgNiChVmpNrzhG/7vI5awAv
         6ds4X6ELw4uXfbR1YhpD9COTnCrZ77qNLTBy4IKKSKnva/XDdhHefr20pHv3YNbALNqF
         sITcuMaKjDlSdNKhiHB7aOp55TkxGSNXRt1+bXJWtOjwgA8fnT1VUAzulT1bBiJSz03Y
         nYfg==
X-Forwarded-Encrypted: i=1; AFNElJ9D9J57AxOQ+8l/lJaUctOBGvlxqQXsBuMbTXYJQY0GXWkmkwc2WAa20wULTuHjdIp9+ZX205I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcPD3/AnT3+jpjQQ6/wgogtC6Hx4AtKHVjOjrjJxVA9ivYAe/T
	CtogThQOyglsrACzFQbsq/ZsZyEdBVT0PcL8aMcxowg2krlb5OmMOFad
X-Gm-Gg: AeBDievOL0n01Iy0ck7FS7PMErvVmPsYjcx87yYxiP+jkxAXZSv+IRN4dEG42XlGuO7
	XXhdEjLlJyeoWyLHBOpFuQiKqOe043hGT9Bb1/PsV2TVTF0WtPJAuORIByRh7E/1ElevieWn0Lz
	1DArxYD3f125Sq2FJuJk06XMBc/cKelfijpgV+Uwx+xXgoctk4N4HGpSyycSyLxNe1lQyOsdZ+c
	aK90+HJMXHt6loYunD78SzQF26r3TdoPXZy0hyZ6Zku/IZz6THG+choztWO5xB3z+VLlVB/pGws
	h93TQqTXlrDrNL8GmJ3yfUQtcaD+aR+tXpZMSoHINhAp1F8UaZvU3hFXRX+WqksKnk4HEhCCKR+
	+MMP3pv5o/F1Nl2wirG6EYgePJZyXWtRPaUzZJGzPlldnleX1Aseu+9RFAOkRT3xWXyonFl7LTe
	sKQ7Ld59BRogJ8ND8ojlX8uIBhBNTesVAdk+klQ9x70/Sy7T7S8epZkiXgyDWob2HbZ2d+cDlHq
	yUnqsuPjS/IWUqWwX+lWgM6
X-Received: by 2002:a05:600c:4713:b0:488:ffb1:494c with SMTP id 5b1f17b1804b1-48a77aed429mr128781245e9.12.1777476429200;
        Wed, 29 Apr 2026 08:27:09 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c584607sm60074975e9.8.2026.04.29.08.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 08:27:08 -0700 (PDT)
Message-ID: <b99eac30-ec61-4b33-9517-3cc2af0cb12b@gmail.com>
Date: Wed, 29 Apr 2026 16:27:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] sfc: fix error code in
 efx_devlink_info_running_versions()
To: Dan Carpenter <error27@gmail.com>,
 Alejandro Lucero <alejandro.lucero-palau@amd.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Martin Habets <habetsm.xilinx@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <afGpsbLRHL4_H0KS@stanley.mountain>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <afGpsbLRHL4_H0KS@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4BC1F497025
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282430-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,vger.kernel.org,amd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 29/04/2026 07:48, Dan Carpenter wrote:
> Return -EIO if efx_mcdi_rpc() doesn't return enough space.
> 
> Fixes: 14743ddd2495 ("sfc: add devlink info support for ef100")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>


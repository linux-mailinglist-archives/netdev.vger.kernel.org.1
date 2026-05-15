Return-Path: <netdev+bounces-288247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Jy0C97iBmrVogIAu9opvQ
	(envelope-from <netdev+bounces-288247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:09:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8147054C0F1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA8DC3164F57
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC0F413236;
	Fri, 15 May 2026 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is7nxtqS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F03407585
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834402; cv=pass; b=EyH/2fHF5XDSWRp6NpPBtL0I0cWPfTBwAI23NAS7WM6x7ISMjVEo+kEBKgSGLnLQf/APQtGyMnTD4+e3nDTCSmaTVpznVAlV2FH9GBfgdrTIw20I2h5pI8gHBG5eYC3h/dDWc6wZWO4fPkf5PcSozlQMFyinAx9zTdjyopp9sYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834402; c=relaxed/simple;
	bh=1lcRrzpWt3IYTyxqjcwZ50t5ZeMwNrUNQTJrko/WnXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0/fQQvVLPw1MLT0O8n0eDh7s3wxxKGTD6TsrnecaUWZ+aCZ6Pnsgg9CbeiQvRhdkZq/ftc4zeQJPHkr9iI22tvMXgBTiDvJzFu09xLzsuaBZLdKy6rMDvnfBfY11PyPpSYYTsD5xVCrdaPG88PZ79eoK7fH+OIU2uzV88LrBxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=is7nxtqS; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so21214020eec.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778834401; cv=none;
        d=google.com; s=arc-20240605;
        b=NgaA7Ia/xAiPXbZl4l/i/X11MScay9xs/C2QAnDeiMzE8nVwTn/uhKgoJHR6n3bL2t
         Cn2O+VZJDmL0TC8KJY23wHccEXZHL2FlKA6gkdPaa3F6aDguIvpMDYxLBZJfvK5uEhPy
         dGuKnGejQRzAOWSIFJIQNUQKvJ1/JiLZSoNwPomv6J/n/LteymN+5sfQ7q0xY8RbpcRJ
         64pdYfzZqGbuex5Aq9NH7NLkCGaCab8QvGEq8PXXZxg3fiU05DmxVFy6RH5sSVXc2pRG
         IekQVIdg3Ep569sm0eI1cYGYQJL8hRf6NJly5LIOjEaZi1r9mPhC6bVu/uS5eHRC0/4Q
         txDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V9o04x0HaWnrCGllcDop+2XHXFTs0K8A0nGkD2mPC7Y=;
        fh=L6IXawrfgZsWrJgVbeOurzAl5WJwt5EbPYj83BeOpSE=;
        b=Ocq5a+EmAmRBYuZ+vrkNngAbhH9fMY+4EtpICZB4R7JLkiYqx3uCL42VKXOMpVBd4j
         i2Gi8CwLiJJzyLVFrn+kYHRZVLgnu1J2dw2kfrLGROomiMZ6Tvu3y8HpnyiPtW/S9CYM
         IqFpGXLTY9g8FvfxbBUz6I0KJVE7UMMoT7nfQiS86YeMsh52HD1Sz2JpUbp1LCEgg2rw
         7gCBvFcKzlIeqij/cKcEyjCVaXixo+MCxcMu96L4GnhFp+NYTjs8cRgenM3/erSwSI/1
         5XjRyMBWzZE1RJCl+/2SLjN5K6IjYudZQrXa1KBgw0GrYKoha8jA/ZB/ghwaw8UtF3oy
         OsUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834401; x=1779439201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9o04x0HaWnrCGllcDop+2XHXFTs0K8A0nGkD2mPC7Y=;
        b=is7nxtqSJzzSE1pIDEQia6X3GSzhFzuBSbS/XUZb/kHd9ERKtuHxKogbrcbJ5GUkNb
         27AYr1G27EkQ/WlQHWkPcWk2sgv7RHeoHkgM+jgiesZPmndMf74tJLUystiYEsPOZzKD
         qrwZhTSICUW9/gXkg6p1bOgYxNGHV92nIorQQcCQWMBs1/nZhbrAiTrh2aNY+vM1rw6G
         h8t0tOp3nMEY5qcXy1+28v2lA+/X2h4SOFTWUc0ML8oTxj5RFr4AOr6hkQDAXy9a4xgo
         B2GTvjziYm5MskgdWfnkp8O3gC+dXWdS72lkrkG0+s+MeyOr1XEWdqzofVqak63doJda
         qAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834401; x=1779439201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V9o04x0HaWnrCGllcDop+2XHXFTs0K8A0nGkD2mPC7Y=;
        b=CylfOYRuQ7VUHg4b6GwcVymjpqrhb3uR9JADKC6Im/eA85iB8TWssb0+LIQh5gb0P8
         ZRP5KpxdLci5DqfxSHjNXo33b2C5eGamyQQS82kytax/SA8vsg82GpYDIhd7FAbkKXXe
         Fk3BJ8oPe/4l30Atq4qmEEtiFJ53Drhu4qij7LcbAgoSViyyKQ+aLgRZfgzXfCyP8bNx
         GvXl/YJO8t5/QziS+oW+aG675AebJhPOZ71mbEqUADjsy4d5Rrpjk9snihqkRhIS7/UT
         qwkBxuaw9Pt9hj2srJHRYb7UN3YumH4j0TsnOv3SlAJkZdD0GJI3CUXLqLPg5vckbRgB
         1GSA==
X-Forwarded-Encrypted: i=1; AFNElJ9JFKFnSMEID02uMj7w7G0WFR0X5nFleQ6sb+O77w3Aul58Y+RZsG8HnGo6P4ZY9t+dGlJfuA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpfKo4IghHnxSCvwC9Tc1V5Bbqo+5RT9TSkGOwVxppJyG49MLx
	VkAaoevQnPBF85VIiCeJ+xnAf9bAEFlxHwX7URVqVh2ejEC9WkbGTaN6sOBSCD+U7pesln8Cmev
	pw6WhQiRJ1K1NdwiIsenXft6wnfTpDGE=
X-Gm-Gg: Acq92OF5Q3GSYMMTotmSN9THgUVYrGPc24OQjuY6gvTh+DD1tDzsO6gGCzJsBlTnxMF
	4D//RKl9F3/YUwXf1e+j59nBwpjDX0KcTqz6OLM5HzJ8FIYwdg3pnQispTuc7wkoGnkG5f2tRBH
	g6UahGZn7WutPHfenPSJ8cxx4pkDGyrNra7uTE7+BJLI6kDU/YTjBteL8U0eUcVX4B5CL/RpiPi
	4OFGAOqzgAI6rbq00TZCBw9nmh8lfu8vdpAizgUxZQWvTKyZPkt43NU/cZK3xDddCbjGrhAc6AQ
	1gUcW5DtdRYZepSdvYo=
X-Received: by 2002:a05:7300:a504:b0:2e5:8ec2:82c9 with SMTP id
 5a478bee46e88-303986a15f3mr1535796eec.26.1778834400799; Fri, 15 May 2026
 01:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511135703.62470-1-clamor95@gmail.com> <20260511135703.62470-4-clamor95@gmail.com>
 <20260515-precious-ginger-lori-d1fde7@quoll>
In-Reply-To: <20260515-precious-ginger-lori-d1fde7@quoll>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 15 May 2026 11:39:49 +0300
X-Gm-Features: AVHnY4LhmWA2BwD0V1_j_6xstdiR56JxjkYZue9zoJ3Q1jLukX8MObrLmKvfP2I
Message-ID: <CAPVz0n3mvBLracMWGNuJ8kKUvAVZ+JRTJVkZGyq5MkuSobd8NQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] dt-bindings: net: Document Infineon/Intel XMM6260 modem
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Chen <peter.chen@kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8147054C0F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288247-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

=D0=BF=D1=82, 15 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:1=
8 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, May 11, 2026 at 04:56:58PM +0300, Svyatoslav Ryhel wrote:
> > +  ap-wake-gpios:
> > +    description: GPIO connected to the EINT3 pin
> > +    maxItems: 1
> > +
> > +  cp-wake-gpios:
> > +    description: GPIO connected to the EINT2 pin
> > +    maxItems: 1
> > +
> > +  phys:
> > +    maxItems: 1
> > +
> > +  vbat-supply:
> > +    description: Supply connected to the VBAT lines.
>
> This should be rather name of the pin on this device, not the provider
> name. VBAT suggests the latter. Please double check.
>

There is no documentation on this device from Infineon, I have used
schematics of the P895 where this modem is used. According to it power
supply is connected to pin with name VBAT (and yes, I am not mixing it
up since supplies have different names)

> Rest looks fine, with respect to Sashiko comment on description:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>
> Best regards,
> Krzysztof
>


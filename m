Return-Path: <netdev+bounces-265955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJH9Csjjr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:26:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A013A2485BA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B61BF303B7F1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DF443CEC2;
	Tue, 10 Mar 2026 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQYzDU2H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3643636F
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133881; cv=none; b=IlcSn81ec5LveuizKikJF1NPeaR9L2wY8aTt+eStmSmUL7TsRhn3j9zfDiIW/WFRKSkrqWPFaSl9K7VH/5chdnLwFM65J3ZhUJK5NE6QL12Jde9HnhmSOJJ1aTOeBaj/UsQwQOxdw5l0x6WNkxwi6XjThV/65/h80vTP33HlJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133881; c=relaxed/simple;
	bh=6f6CTMROKclxCiuBLqyUInbS/438WmkNzB35QP0bqws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNlniyLkxaCTaWI7/waKKUXmkpZVa90VVKweokFJkeZk7zMI+QL3aBsmX56E2mP/RDALk+OX7ex+H2sdZB2Y1pX9+IY0rjDEj2NQSBNxy+43Gi6Crcxg6RQ7SWcX4BdR1DWElMmRvUMgEjbm+c4cfk1gcKW45w60jWB5yC/FYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQYzDU2H; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4853a485721so2242345e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773133878; x=1773738678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRVYnrhnkOAdeAd2Kjlt1+H2Rmi0u5RX+qxn7s2d300=;
        b=iQYzDU2H6P+NXTwOjx/QnpSDx/ci4QfglcAKffpHt+bl0/4MEDbDvW3HDa+Y6OB5GF
         NoCynyU5dDl6GE7vL7V+wGJhr0/l/4BlEb+Tz0H2eRnrSGgo10By3rGFJYA2U25Xvgpc
         ORl+ycxYSIqmdm/ozgZHupRVaQEVoLP5tz2ERzt536RbPZILUItHYW2l7zjZ7G9uLxGS
         h5nnDQYmNgqGEDN4CYCL56SOw8X4Qz3stCZH+pwCXjBQvlOX6OMrAVPJUTdKT5pwFh2H
         j1SgaDAbQzYI63HEZxvsEyZJe8KiztP23TKkk7ggQd2ten5IM2niGk1pJI1ZMMlSlvIr
         pfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773133878; x=1773738678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRVYnrhnkOAdeAd2Kjlt1+H2Rmi0u5RX+qxn7s2d300=;
        b=VvYwfCdWJenGJntQ1CApviutqmmi7WmTFwNw7OAkobFtkh8D0nqVatucn8rWjgIzct
         U1dOKSF3btCfYkjI7FWmBQlfTvzkBeM1++ktoTS3uWlvAjr0lYFK+gkK2HRra+8UNdwk
         4pp2IMBsM4GI3askOCZmieh6vzq9JvA+iqQj8lV/ES98ndjI6yGianSbW22c2XWqDkwk
         +sgA5Eeg2+Ib1Dn0YuU9gIo99y3V/6JIHUmcGEyP3cVjOwvY0zpq3z2PJbblP+gKqVdJ
         y9NhzT43cuof91OPl2Sfzw0sESwHM+8w31bKZvhkJwjznnPSZllRCWyDpKcLtL1046IR
         yJ4A==
X-Forwarded-Encrypted: i=1; AJvYcCW/xvkARRmJAqiJewK5R3EKKlQqaSFU0y38Qld/v+8B68q6Z45P8eLbl0jrIJEbRUedhIUueW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCBnJmXZsbGxI07B60yylEQUtAoBvi1XjTBy+r8GH4toExpRM
	bgk7DAZXo7uDqE9Llfv1iCjbaZ3y+hpV1/ZeI17z93G/o08Bk5/GKVJVTf9MAA==
X-Gm-Gg: ATEYQzwfKSE1e3NxXLrZEoXebQHRXx72RBClKWo4IiS+O+k+0q39QMO4I2SAhsYx3YE
	90wE5smnjCQNfs3GRWvMyoH24SN1T5oxKVU5QavtCb5jSVk+9kAod3s25CBD3CEJaDpfSXV8iF0
	UtDpjqqacL2gUe1L1fWQPZeB4tb3PBHw0f+q+otdPgyssRaYlKycbz9N3XNaPE1f7NcIZNrHawH
	SdNXMcdUBY0pLUSjZ6YRK+4GpGfxT0d2LiV7SNxXeAfe12hKNsnU2NNcYuEPsP5UpyjV048KtWF
	tYh3F9p/DDevaSbRmlZK3jVqOtYG2KtD1kHNu+4Fsb39pxz05MnbSJm7TKnxC3S3J4Pn9vXP2wB
	KeuWQSKIw9TaZEn/SnXzafDKfubOIov/aDzHFLD5E5qRjMlA3K6uR2eYNLsKOcOiuZHas5KuvGi
	QpRT8HAptELpojsw==
X-Received: by 2002:a05:600c:4e8b:b0:485:358b:e7ed with SMTP id 5b1f17b1804b1-485358be94cmr73984075e9.0.1773133878274;
        Tue, 10 Mar 2026 02:11:18 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00a:e00:8799:3a7d:3c86:3200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48535c7fae3sm90439885e9.1.2026.03.10.02.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:11:17 -0700 (PDT)
Date: Tue, 10 Mar 2026 11:11:15 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mxl862xx: don't set user_mii_bus
Message-ID: <20260310091115.j2aqdk3ikodffoei@skbuf>
References: <0f0df310fd8cab57e0e5e3d0831dd057fd05bcd5.1773103271.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f0df310fd8cab57e0e5e3d0831dd057fd05bcd5.1773103271.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: A013A2485BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265955-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:41:56AM +0000, Daniel Golle wrote:
> The PHY addresses in the MII bus are not equal to the port addresses,
> so the bus cannot be assigned as user_mii_bus. Falling back on the
> user_mii_bus in case a PHY isn't declared in device tree will result in
> using the wrong (in this case: off-by-+1) PHY.
> Remove the wrong assignment.
> 
> Fixes: 23794bec1cb60 ("net: dsa: add basic initial driver for MxL862xx switches")
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>


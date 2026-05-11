Return-Path: <netdev+bounces-286592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPTwFjKxAWppigEAu9opvQ
	(envelope-from <netdev+bounces-286592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:36:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D350BF9B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97CA7302164B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770153D9030;
	Mon, 11 May 2026 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5apJdrA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E873D8912
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495783; cv=none; b=SIPQ2/3AI5B8pOXuQRhdS/12bbiTL351FzlM0Y5RMw/Dm/tGw8CkjaR7q3yVPFIxlcR/uqBUiJj+oS1lJ+w95KQ1Al76FuqBaEQxEh2Ba56AjmJLPrg2R5ej8Z/aeyhzs3dGFQPzTA8qdEo5CKR4T70FdlbHeNPU8bdLAAtSf3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495783; c=relaxed/simple;
	bh=IENORfZd5dSYQkrNitKAXWYKfDtZSTBMvfDRDDw/UDU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBtIyWLSs9RlW+BWsia/KsKT9ZCNWR9PvJ1fXLfxGL4bric4XPxG0vJfYXK9WRu7r1sueH/jBHuOqmZpCNMIEwlONGhH71yAgea0rOARe7kjC4E4ielUMC02Rn7sGaOK+9/L7kuBuJEKSgsvtySF+ttLE9udATQmyRo5ImI2C68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5apJdrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FD7C2BD00
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778495783;
	bh=IENORfZd5dSYQkrNitKAXWYKfDtZSTBMvfDRDDw/UDU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=l5apJdrA49uY4v/bTHhH4NFQ7CWM57f59dOtXdEGrLYwpCS1ywrulpD6I3CAgAf5R
	 udIkFkcAMJPz9f9xbehDGPY+rrLy/tUipUUHf231IteL2U5+M+Fe7Tmjf6uyHKA5NS
	 XfZrkhgED5mZ2SN3YroJZ+eEaYUPeP58CAu1uoDA5oAFZsA7KkOqtaIfhpNrCOBoXe
	 HN0LJFu+si9U9t+aUEQ1u1Bq1qqgcBwQoPxit9XSEixu1xy/tobN8YKQHYHNR55Bz3
	 wTGWB7OmdcOW3TgjMZjj6Nwpsa1jD7MisITRNr8vi0COY8+KQ4/7eZwoAoyl1GD1ej
	 uEA8B59Lty7Nw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a525aedb24so4085011e87.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 03:36:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9NUBA/j7eov/leKMcvRtHIda3Ktln70e2tGNTeoCDOFDw86iho8rg9VoqOd6kHY5ncUzSd8hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+o2n7Acf+SmPJ9gTmdvb5hEtennb4xkHs3mY5/7e8DDSVxOp
	tH7qKuzETRugyeTrtfHmsk6zIrhAiFjeYoq8qu7QXUcqr4HrWpvPBGCJr4EVG2BqBJtgzGC7tfR
	rNKvQ59aXNcVZK1bpbEsc9ip7dLDp29BoF88Qvd2vPg==
X-Received: by 2002:a05:6512:3e1c:b0:5a8:b966:7b1f with SMTP id
 2adb3069b0e04-5a8b9667b9amr3508208e87.16.1778495781398; Mon, 11 May 2026
 03:36:21 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 03:36:18 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 03:36:18 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260507-block-as-nvmem-v2-5-bf17edd5134e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com> <20260507-block-as-nvmem-v2-5-bf17edd5134e@oss.qualcomm.com>
Date: Mon, 11 May 2026 03:36:18 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mdi5DuwhewSpaPCJCWWkmw57pLPx3snSyV_gtBN1gWtMw@mail.gmail.com>
X-Gm-Features: AVHnY4LRJOdRAiXXJAqk3x0LB0U9Hhhkl-SHYK7hw0ni4PNj3Dx_sfKHg57uYFk
Message-ID: <CAMRc=Mdi5DuwhewSpaPCJCWWkmw57pLPx3snSyV_gtBN1gWtMw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 138D350BF9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286592-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Thu, 7 May 2026 17:24:40 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Factor out the common NVMEM EUI-48 retrieval logic from
> of_get_mac_address_nvmem() into a new of_get_nvmem_eui48() helper that
> accepts the NVMEM cell name as a parameter. This allows other subsystems
> (e.g. Bluetooth) to reuse the same lookup-validate-copy pattern with a
> different cell name, without duplicating code.
>
> of_get_mac_address_nvmem() is updated to call of_get_nvmem_eui48() with
> "mac-address", preserving its existing behavior.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


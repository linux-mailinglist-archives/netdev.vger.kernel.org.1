Return-Path: <netdev+bounces-254330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH3MB1o3eml+4gEAu9opvQ
	(envelope-from <netdev+bounces-254330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:20:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C8FA5730
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91FF73023007
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1F330CDBE;
	Wed, 28 Jan 2026 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b="lVK/Nu8d"
X-Original-To: netdev@vger.kernel.org
Received: from mail.twlab.de (mail.twlab.de [80.151.39.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C22DF155
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.39.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615625; cv=none; b=uKHbSCsxhMTN1qJJktXlRfOzWR5jnUDvuSwCbMJPEZtbwWFUoUlYgL+u1OJBHNY79a2Bi7tBICuP2pNxd2GB0CI/OQ/b12zWJoTs0ldw3mqiU8ZeBx4vNbbu0LbZyvadjcXa/bBSZZ80cfn9DENY6C0XAPZANdOa1ecV+NDH/Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615625; c=relaxed/simple;
	bh=tPuyJWTnwkqWaGNhZFTBM2EbSUW+2EljRGqc4mTdWTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buN2jKCZ/EuRDL8m88IhTbmwlTvFtqfKe21QZa/lNIu6ik1/BF71z4QdunUTjWDhobYYkDXPycNXBq04UR66oqYXVxHc5D8QfnAQz9wUOqkbt+7LXo80bv624+DR33S8bIIfZnb2NAQpt1qKgX8X67jvUeqLziPHlgz0ETn0mhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de; spf=pass smtp.mailfrom=twx-software.de; dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b=lVK/Nu8d; arc=none smtp.client-ip=80.151.39.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twx-software.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 173F55EAAFF;
	Wed, 28 Jan 2026 16:53:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twx-software.de;
	s=dkim; t=1769615618;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xT01+AFWV1syzTX1xDdDa6N3RaaTkmROC7VQwJ7aBhI=;
	b=lVK/Nu8d8i85F2df5IHSvOrX5HvW6p0YS8mgJZ/ltpUiNNfyWjuXtmw2JhUSw3qumokJml
	E2i0xnQ3gj8xCxAgiBQZceoJ6iRNtjjpUZ7ECzTtT/fnZtYhNhU+TiHgMuzOvyJ4sX+vyl
	AX7DR5BeJpFHjHlda2TNVQdyrh7xuRBYUx9kmgwuzUEcHEhjSFytb+dKEbx53T5vpd8Jnc
	p08+7uTEQ57eIVCcqFaTwdL3WR2M29aXbT5fFvuukyqmpehtfHhkMja+LpT7vmA7aG3q82
	nn79AM1gEAqrOFjYlEnjESgCH9kwItxL6CgnU7bmdiGriJcxGJLTeY8t56Dbkw==
Message-ID: <da974b72-8ba7-46b8-ac21-86a2fa26e22d@twx-software.de>
Date: Wed, 28 Jan 2026 16:53:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: net: dsa: microchip: add
 microchip,single-led-mode flag
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20260128133842.1173406-1-ht@twx-software.de>
 <20260128133842.1173406-2-ht@twx-software.de>
 <6871816c-2732-4c5f-9f10-1f9773d5f23d@lunn.ch>
 <9090d12e-e85e-4827-9dc3-5bbece12c50d@twx-software.de>
 <18c6696a-7874-454d-8032-ca5130e41665@lunn.ch>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Heinrich_T=C3=B6ws_=28TWx=29?= <ht@twx-software.de>
In-Reply-To: <18c6696a-7874-454d-8032-ca5130e41665@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[twx-software.de,quarantine];
	R_DKIM_ALLOW(-0.20)[twx-software.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254330-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ht@twx-software.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[twx-software.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,twx-software.de:mid,twx-software.de:dkim]
X-Rspamd-Queue-Id: 58C8FA5730
X-Rspamd-Action: no action

Hi Andrew,

Am 28.01.26 um 16:22 schrieb Andrew Lunn:
> Is that really true? Generally, what actually happens is the
> configuration is left alone. So if the boot loader, for example, has
> set the configuration, that configuration is left unchanged. So it
> could actually be in single LED mode, not tri-colour.

Oh, you're right. We cannot assume a hardware reset state here.
Since the driver currently does not touch these registers, the 
configuration is indeed "inherited" from the bootloader or the
hardware strapping.

Thanks,

Heinrich.


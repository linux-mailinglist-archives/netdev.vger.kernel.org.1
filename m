Return-Path: <netdev+bounces-268476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGkABTQIuWmEnAEAu9opvQ
	(envelope-from <netdev+bounces-268476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:52:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 802C72A51EF
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 08:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F44D301B158
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15223932D5;
	Tue, 17 Mar 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="XrAQawsI"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA453932E7;
	Tue, 17 Mar 2026 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733932; cv=none; b=GNhiknl2Ru1Z0q8vZrubhCcxRfF7/4Yat+Ug9V6d2y5Xrw0n3wroLTvNp2Qxb6ReHhP0IVxyQxeBdthjXPS7xxT2J2s6FXFPzP6QoIKOOwPznuSjsotcuw9VyGcVKYUur9v746YbmbWRZWqD8XmjIE1hKrs9VpejtHPnnaZgwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733932; c=relaxed/simple;
	bh=nlDp/OQaofvVmTeKBd8P8YRUbxmUZzmTelLZeHk4Dyk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EybGgGvnuP2K6rxuOiNKp3741TSYuIJCVnFkia1AOp6RtYiP3VFnno/NmYxOSoGK+kIACBR3gLx53hMb9GWlmv1yy1aSuJ1+qoSI8Pokn1TWFnfOzk3b8DCFo/ISYbJkDcdTFemfc7VjyOs9TC3T/M8inz5Kliju3wjlvMiIeLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=XrAQawsI; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 178EDA0304;
	Tue, 17 Mar 2026 08:51:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773733920; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4CuW3TgP5Pv0xXFEtiIXFhomHIsmKlDPVuafk3tuISY=;
	b=XrAQawsIryZfvXYdRm4OLavsLHcPnU8SaEC+PpbTI8XkApmWHM2TzvdQvexXLYB5m6b/lv
	H3NtZGsVzRCm1CI5Pt1xf4BYJriBkCh+yRdX1a2p/gnjG93/RTrO626Xb0STEhsgExxmxo
	aACEs+KvHGgDt7V4BYZNXRE3IZdHK7ABoeMG6HY+u7CVDgVFjkuSl9k+F+NN2Tj5iq0TL8
	rvXSPMmOZ+Rwsjz7igufDJoT1iNbmO7rmZ7KJ0+3BTl6aKkuZpcQ3Ajr3jWVCpCuTbBAVO
	iMYNSDR3YlVHjycXo+WiOjTvqxaNFdzlZe+6KU8jnEs7pvcpJjnNkiGEsNDuww==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Mar 2026 08:51:57 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Doug Berger <opendmb@gmail.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bcmgenet: enable EEE TX LPI by default
In-Reply-To: <8b086643-44e1-4c02-9d88-aba369d7d9b7@gmail.com>
References: <20260303160225.542613-1-nb@tipi-net.de>
 <997daf22-260b-40c4-a2d6-8c63f59df9a7@broadcom.com>
 <20260316135915.28c64ec8@kernel.org>
 <8b086643-44e1-4c02-9d88-aba369d7d9b7@gmail.com>
Message-ID: <e14f4a1934610bb0db5ef4b2fd5c0675@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268476-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FREEMAIL_CC(0.00)[kernel.org,broadcom.com,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 802C72A51EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 16.3.2026 22:21, Florian Fainelli wrote:
> On 3/16/26 13:59, Jakub Kicinski wrote:
>> On Mon, 16 Mar 2026 12:54:46 -0700 Florian Fainelli wrote:
>>> On 3/3/26 08:02, Nicolai Buchwitz wrote:
>>>> GENET never initializes priv->eee.eee_enabled or
>>>> priv->eee.tx_lpi_enabled to true, so the link-change callback in
>>>> bcmgenet_mac_config() always calls bcmgenet_eee_enable_set() with
>>>> enable=false.  The result is that EEE is negotiated at the PHY level
>>>> but the MAC never enters Low Power Idle, wasting the power savings
>>>> that EEE is designed to provide.
>>>> 
>>>> Users can work around this with 'ethtool --set-eee eth0 eee on 
>>>> tx-lpi
>>>> on tx-timer 250', but the MAC should enable TX LPI out of the box 
>>>> when
>>>> the hardware supports it, consistent with how phylink-managed MACs
>>>> behave (phylink calls phy_support_eee() which sets eee_enabled=true 
>>>> and
>>>> tx_lpi_enabled=true by default).
>>>> 
>>>> Initialize EEE software state during bcmgenet_open() on GENET v2+ so
>>>> that the link-change path activates EEE in hardware once the PHY
>>>> negotiates it.  Use an LPI timer of 250 us, matching the default 
>>>> used
>>>> by other MAC drivers (mvneta, mvpp2).
>>>> 
>>>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
>>> 
>>> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> 
>> FWIW this patch is set to Changes Requested, I _think_ based on this
>> reply from Andrew:
>> 
>> https://lore.kernel.org/all/d352039f-4cbb-41e6-9aeb-0b4f3941b54c@lunn.ch/
>> 
>> LMK if the patch is good as is.
> 
> It is good after 908c344d5cfac4160f49715da9efacdf5b6a28bd ("net: 
> bcmgenet: fix broken EEE by converting to phylib-managed state") 
> reaches net/next which is what Andrew was commenting on.

908c344d5cfac4160f49715da9efacdf5b6a28bd ("net: bcmgenet: fix broken EEE 
by converting to phylib-managed state") should cover it - phylib handles 
EEE activation automatically and sets the LPI tx timer from the phy 
default. I noted in the new patch that both earlier submissions are 
superseded, but forgot to mention it in the patches themselves. 
Apologies, still getting used to the list-based workflow!

Nicolai


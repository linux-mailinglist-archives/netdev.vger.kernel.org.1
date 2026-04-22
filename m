Return-Path: <netdev+bounces-280324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N42AAVr6GlZKAIAu9opvQ
	(envelope-from <netdev+bounces-280324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:30:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B994426B6
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D44530455C1
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320D310785;
	Wed, 22 Apr 2026 06:30:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.mifritscher.de (mifritscher.de [188.40.170.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0BE30BF66;
	Wed, 22 Apr 2026 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.170.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839408; cv=none; b=b5gHdRejg2ZKEho20gdvVg8Y+XLe1LgpHh0mJuzRu/Hww3CAH3g6j5A62u65TOUvl361nULnxo3Cx64e8kn65/Tz7w/Z32i4qLMseStmXOj5vdjFyVuixknIBgU2RIdneWHy5B30klmelg0SYDQaaKp2EJsEvUMtpT4CBeLziKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839408; c=relaxed/simple;
	bh=PQDH0StJ0KIoBnt92ufDDtB+6lCycOXf+fmbqNg6G80=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=EpczAZYdA5Rn3QoskGtpHiiXrxB5an5crY8bKkzcwqPUPl0UkA54cTQLjlk2tHSiCXuouMc7DyQ8/uY7j9pJBsE/pSKl+C/oH9PNpkis7eXa8VlYbT4d2joVESuiiVxpl6/AwpuS8FNcnLk8xd5ZGwDThsWEmGeP1/lSYrXJF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fritscher.net; spf=pass smtp.mailfrom=fritscher.net; arc=none smtp.client-ip=188.40.170.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fritscher.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritscher.net
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.mifritscher.de (Postfix) with ESMTP id 647263B272A;
	Wed, 22 Apr 2026 08:21:29 +0200 (CEST)
X-Virus-Scanned: Debian amavis at mifritscher.vserverkompetenz.de
Received: from mail.mifritscher.de ([127.0.0.1])
 by localhost (mail.mifritscher.vserverkompetenz.de [127.0.0.1]) (amavis, port 10024)
 with ESMTP id P_bomKo3Iizb; Wed, 22 Apr 2026 08:21:28 +0200 (CEST)
Received: from [IPV6:2001:4091:a244:8430:d203:b460:8d76:8c29] (unknown [IPv6:2001:4091:a244:8430:d203:b460:8d76:8c29])
	by mail.mifritscher.de (Postfix) with ESMTPSA id 5DF253B2613;
	Wed, 22 Apr 2026 08:21:28 +0200 (CEST)
Message-ID: <73e3a34c-f1dc-403b-b007-18ff85d66ea1@fritscher.net>
Date: Wed, 22 Apr 2026 08:21:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michael Fritscher <michael@fritscher.net>
Subject: Re: [PATCH net 14/18] drivers: net: xircom: xirc2ps: Remove this
 driver
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Content-Language: de-DE
Autocrypt: addr=michael@fritscher.net; keydata=
 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
 J8ECEUyP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.36 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[fritscher.net : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280324-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael@fritscher.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fritscher.net:mid]
X-Rspamd-Queue-Id: 93B994426B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Good day,

actually, I do use Xircom PCMCIA network cards (yes, the 16 bit ones) on 
Lenovo X60/X61 laptops as a second LAN card for server maintenances with 
current 64 bit distros (e.g. Debian Trixie, which I plan to update to 
Trixie+1 when available). Why? Because I have them and they are working ;-)

Best regards
Michael Fritscher



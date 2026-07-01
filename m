Return-Path: <netdev+bounces-303799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LAlyOGxjRWoJ/QoAu9opvQ
	(envelope-from <netdev+bounces-303799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 20:58:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE36F0C1C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 20:58:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=NeF93vyT;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=BQIzUKs5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303799-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303799-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B618B3025904
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBC03D6CD7;
	Wed,  1 Jul 2026 18:58:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CDA3A544B;
	Wed,  1 Jul 2026 18:58:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782932289; cv=none; b=doKHbHCQIMSl7NnU18O4SDKIqffycqWKGKtX9Sgk+PL++fRfTK2W11kp6vbnlzIQUU+49O0zF0TcA944wdP1nYfXhSmrd5w2sK4KdfX0c+u1kadHVEfaqAtlw1iheBHBCY8sH+R6M/snGoRDIMjAHucqjRp9HfWLljW/9eKh4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782932289; c=relaxed/simple;
	bh=KUmPq7UDeHQdd/bZibt9AECBVBu3e69eV2q7/LsOgPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAwTp0p86YVDRBi1sGvQeorLUxsVf01RzBvND6yk/OXF1UU0N/j3+vRt1iSa+yJ0OntSahupgcnuRVp612azOqNKYl5V80P+FHLjXc62IW5zHLoXlcJTEqjlL+Zuof1HQqY9XHypG0vCPTFxH/LKZfT0dXUwO2xNJViIDDykJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=NeF93vyT; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=BQIzUKs5; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782932286;
	bh=KUmPq7UDeHQdd/bZibt9AECBVBu3e69eV2q7/LsOgPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NeF93vyTMStdrjvMDusolZoKvu5wb65Es09boIcjBRGSNmzW82U1rT9HjgEkRCSXe
	 eDg3ZOzP47PuBR3bwP0/oYC2yZaD9tmI6aFEGhb9Pl4pouLkELG5rjPV2Lmm/MTXnr
	 Y9R1zzaqbI7si4ANZH3ZDoueN1RJr0nUVRyzVfCF88JIZoD4BZlVo4htbLPCWYXiz1
	 uPesP3xEBz9klF4ND8ZHxITD18AMQGmgPyRDYR3NelBOWLQ2/QiPKXDdCMThl3IfwX
	 HHa0vlkAGS31tZDg3wCrLgyelKdH3vmjothh2ObZp/oQJjE6/+vaK0cLlK06iMTe32
	 H1t4Rc8lZcG5A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 2F9074935B; Wed,  1 Jul 2026 18:58:06 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782932283;
	bh=KUmPq7UDeHQdd/bZibt9AECBVBu3e69eV2q7/LsOgPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BQIzUKs5ZL7zSH3Djp+6JKGLWccZn6J4kcxcgRf3Vmsh4HogWs/2o2uwaOi2WxU6T
	 9EtZkL8VSzwLgPmXt3pfPLGiNhsVwAqrbsZnxZDZzoluesxOuOirXBJtY7RNtK9OEf
	 ymuR7C5BE18BH5pWb6EWl8wB1DKhFnsqoVL/P5ZhH4b8Q1zqjsKVytmlAf/5fOhG86
	 /dn4o3ARPi8PsHXH7MQmNKSfHnOVlCc4vP3N8s3Gs3pSiJ3+yjR4RGX2KvJViGFE96
	 KCFx1xcOMz32PIi1R15nYprSdrtOAVsejYO7pWPelwE06DM3RAKy1vGrOBTJj36IqA
	 riDBOocc8a/0w==
Received: from [IPV6:2003:c6:9f1c:3c00::1c8] (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 9948149354;
	Wed,  1 Jul 2026 18:58:03 +0000 (UTC)
Message-ID: <8a0e6214-1773-4c5a-a570-993b44f21740@birger-koblitz.de>
Date: Wed, 1 Jul 2026 20:58:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8159 firmware
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 hsu.chih.kai@realtek.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, olek2@wp.pl,
 pabeni@redhat.com
References: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
 <20260701171327.2916132-1-kernel@jfarr.cc>
 <5dc0e654-0bdb-422c-9049-94ee6d8867e4@birger-koblitz.de>
 <akVZUQX1V-jAM06U@archlinux>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <akVZUQX1V-jAM06U@archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303799-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kernel@jfarr.cc,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:hsu.chih.kai@realtek.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:olek2@wp.pl,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,realtek.com,kernel.org,vger.kernel.org,wp.pl,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FBE36F0C1C



On 7/1/26 20:15, Jan Hendrik Farr wrote:
> On 01 19:24:13, Birger Koblitz wrote:
>> Hi Jan,
>>
>> On 7/1/26 19:13, Jan Hendrik Farr wrote:
>>> Hi Birger,
>>>
>>> it looks like the firmware file rtl_nic/rtl8159-1.fw isn't in linux-firmware yet.
>>> Could you send it for people to potentially test?
>>>
>>> Jan
>>>
>> The code to create the binary firmware file is at:
>> https://gitlab.com/koblitz-rtlnic/rtlnic_fw
> 
> I'm getting a 404.
That was my mistake, I forgot to make the repository public. Sorry about that, first
time using GitLab...
Here is the link again, I hope it works now:
https://gitlab.com/koblitz-rtlnic/rtlnic_fw

Birger


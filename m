Return-Path: <netdev+bounces-295721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sC9ELa2HImr/ZgEAu9opvQ
	(envelope-from <netdev+bounces-295721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:24:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5098B6465CB
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:24:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295721-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295721-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=kabelmail.de (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B93E23027C63
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 08:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C163C988B;
	Fri,  5 Jun 2026 08:21:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b03.edpnet.be (relay-b03.edpnet.be [212.71.1.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9153C65FE
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 08:21:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647670; cv=none; b=jXtj9e9fTeo3lfavvKr+a0W6g+GUDHMUqb2GaKwhpBSG8WtJtHn1EDzZnxoJY1LKprZUTzQpxYbHfGcV5ULN4Dt7lt9ObAZIAYkTEm3prGpASMOwyfIFvnUUk5rlHu0UUjRLz3a+6G8peOpwAiRHX/WTSFqMvY/WsC2iP6frlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647670; c=relaxed/simple;
	bh=gvOODPje+TEjM+2jIBwQ7IWN5bH+nt1eH6bEsvlWuDE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mMR5a9U3ymiDZ+W4SsNzu19UQKds+aWNMEpAZG8zGe/vf/KXQNgZ8S6boMBY5C2p6fy79s97Ww3b2odMHxbLMW18fGGRsVF7EQC6CqG3ECJZPy0JA4V8Xgp9C99s1XPqB4YtBbjBcnxQRFhCJjTsRRFnTyf4CAEjTYAM/YZluMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.220
Received: from [192.168.177.83] (212.71.13.3.adsl.dyn.edpnet.net [212.71.13.3]) by relay-b03.edpnet.be with ESMTP id BFDwOVlck5m4BoaQ for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 10:09:50 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 212.71.13.3.adsl.dyn.edpnet.net[212.71.13.3]
X-Barracuda-Apparent-Source-IP: 212.71.13.3
Message-ID: <ec5bd768-3f54-4c30-b5a2-1e0b43f789e3@kabelmail.de>
Date: Fri, 5 Jun 2026 10:09:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: nl, en-US
To: netdev@vger.kernel.org
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Subject: SFP/MDIO/I2C: help requested unlocking a SFP+ MCU to expose PHY
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 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
X-ASG-Orig-Subj: SFP/MDIO/I2C: help requested unlocking a SFP+ MCU to expose PHY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: 212.71.13.3.adsl.dyn.edpnet.net[212.71.13.3]
X-Barracuda-Start-Time: 1780646990
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1230
X-Barracuda-BRTS-Status: 1
X-ASG-Debug-ID: 1780646990-24639c1f231c9220001-BZBGGp
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=10.0 QUARANTINE_LEVEL=10.0 KILL_LEVEL=7.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ---------------------- --------------------------------------------------
	
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[kabelmail.de : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-295721-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[janpieter.sollie@kabelmail.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[janpieter.sollie@kabelmail.de,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kabelmail.de:from_mime,kabelmail.de:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5098B6465CB

Hi,

This message is a follow-up on a previous request,
I reverse-engineered a lot of stuff,
and the question has become fundamentally different.

I am trying to access the bcm84891 phy on a 10Gtek ASF-10G-T80 sfp+ transceiver.
According to 10Gtek, these modules contain a bcm84891 phy.
The MDIO commands seem te be sent to a MCU, not the phy itself.

Does anybody know how to make a MCU transparent?
Did he / she found a hack by writing a i2c register or something alike?

I have a rollball password, but initializing MDIO with rollball does not work.
with MDIO_I2C_NONE, the link comes up (and is stable), so the firmware / MCU does a lot on its own.
with MDIO_I2C_C45 (the only method bcm84891 supports) says "no phy detected"
with C22, it shows a buggy ID which isn't even close to the 84891 IDs in the 7.1 patch.

All methods (C22/C45/Rollball (with/without password) can be used to read registers with i2csfp,
but none are actually consistent (and rollball returning 0xffff at best).

Also, writing to those registers, and reading them again, shows no changed value.

Did anybody ever try + succeed making a MCU transparent?
Could he / she teach me how it was done?

Thanks,

Janpieter Sollie



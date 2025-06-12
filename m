Return-Path: <netdev+bounces-196874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7F0AD6C02
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8E53B0144
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D1B223DD4;
	Thu, 12 Jun 2025 09:18:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay-b03.edpnet.be (relay-b03.edpnet.be [212.71.1.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8621C178
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.1.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719888; cv=none; b=Pw240ePCcOXb+bp74RZR7vl0B+DUzVxQ5odMSoPfDCmcx45zqCIKm5gS6D57OY2bi8f1745BRk5XBPRLpOFynJHJOolTpghXaAH7h98AtJrHEqIRKUQnZHRemAiAP71hgEuAZOjWwiXGz1mzWIlfj4qjj/rzOXR0jsz54RHrzuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719888; c=relaxed/simple;
	bh=9cS+uUngAmeL6lbAg4REFestb+sGw0xmGUWR2eX7qW0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=eNR6WbJR+8asl1XNnCLak2qb1+RTdr4hZXhvFsFZgQyVvZuaVAWylDLaAiU7m/5zqbkDdwhrJdGiuRWTB9bqyu9E7OK0kO9R23wsvF11RojzxkxLvRpuZsFjW536qU16L+3Vzk97NEcEL90rsE6lpdFuXqkgh1YG2D09NNMMMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kabelmail.de; spf=fail smtp.mailfrom=kabelmail.de; arc=none smtp.client-ip=212.71.1.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kabelmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kabelmail.de
X-ASG-Debug-ID: 1749718720-24639c6c73f84d0001-BZBGGp
Received: from [192.168.177.53] (213.219.166.145.adsl.dyn.edpnet.net [213.219.166.145]) by relay-b03.edpnet.be with ESMTP id 0NnkNEN4uDODX3oK for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:58:40 +0200 (CEST)
X-Barracuda-Envelope-From: janpieter.sollie@kabelmail.de
X-Barracuda-Effective-Source-IP: 213.219.166.145.adsl.dyn.edpnet.net[213.219.166.145]
X-Barracuda-Apparent-Source-IP: 213.219.166.145
Message-ID: <5568c38c-5c93-493a-96bd-b6537a4d1ad6@kabelmail.de>
Date: Thu, 12 Jun 2025 10:58:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Content-Language: nl
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Subject: [support request]: where should I register this (apparently not
 supported yet) transceiver?
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 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
X-ASG-Orig-Subj: [support request]: where should I register this (apparently not
 supported yet) transceiver?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: 213.219.166.145.adsl.dyn.edpnet.net[213.219.166.145]
X-Barracuda-Start-Time: 1749718720
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1630
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.142749
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Hi Everyone,

I'm looking for support to register my trainsceiver in the phy subsystem.
This RJ45 transceiver (ZK-10G-TX) looks very weird in ethtool:

|> Identifier : 0x03 (SFP)
> Extended identifier : 0x04 (GBIC/SFP defined by 2-wire interface ID)
 > Connector : 0x07 (LC)
 > Transceiver codes : 0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> Transceiver type : 10G Ethernet: 10G Base-SR
 > Encoding : 0x06 (64B/66B) BR
 > Nominal : 10300MBd
> Rate identifier : 0x00 (unspecified)
> Length (SMF) : 0km
> Length (OM2) : 80m
 > Length (OM1) : 20m
 > Length (Copper or Active cable) : 0m
 > Length (OM3) : 300m Laser
 > wavelength : 850nm
> Vendor name : OEM
 > Vendor OUI : 00:1b:21
 > Vendor PN : ZK-10G-TX
 > Vendor rev : 1
 > Option values : 0x00 0x1a
> Option : TX_DISABLE implemented
> BR margin max : 0%
> BR margin min : 0%
> Vendor SN : 2505010443
 > Date code : 250412
> Optical diagnostics support : Yes
> Laser bias current : 6.000 mA
> Laser output power : 0.5000 mW / -3.01 dBm
> Receiver signal average optical power : 0.4000 mW / -3.98 dBm
...

I cannot read its pages with i2c tools.
It has a big "AQR113C" sticker on it,
which is supported by Linux for a long time already.
I'd say it needs some quirk to activate the driver.
So, how do I verify the ZK-10G-TX has a AQR113C chip in the first place?
Does it need extra firmware? can I link it in any way to a AQR113C driver?

I am not a netdev developer, but if everything turns out like it should,
There should be a < 10line patch to let aquantia driver claim this one.

Thank you for your help,

Janpieter Sollie|


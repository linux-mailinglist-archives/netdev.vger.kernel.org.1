Return-Path: <netdev+bounces-203692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498CFAF6C4D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5F83B215C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C752BD5BF;
	Thu,  3 Jul 2025 07:58:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E802BDC02
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529483; cv=none; b=LxFtA0+OfPxJpm1430H8vPuXeWG2i0LRCI99NatGZIQLbn7WCgEpxVekvmeYPidRHJWe85T6bittaixn2pD2NmwZbzmS6OePc/o1VqT1dnnzYcOFD/0HSKf8WvCFTFVL9ziMOYas/VegtAobflKSCeuVPnmZWpiJlRymnY6tyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529483; c=relaxed/simple;
	bh=g19c+IauxYTWsFKQLDRooITj9glGLJ6G4sLtBu8I+po=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DaslC0fCNDivhR+LsCNJs/jS0PREzkpm2MkdsY6a6uIHSp7X+CW8OQdwNbthC3fkX1tAV/EgTKJ3Weo4tkrf//A0haTVf5OUGJpvwiuNhqfznZd3cbQzpz6PkwbQxoa+AkXhX/UOwn8Tm7Q3wxed2pcFDZMmgtgHwHHSmwXqmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lja.fi; spf=pass smtp.mailfrom=lja.fi; arc=none smtp.client-ip=62.142.5.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lja.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lja.fi
Received: from mail.lja.fi (80-186-162-127.elisa-mobile.fi [80.186.162.127])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTPSA
	id 46c29e3e-57e3-11f0-9796-005056bdd08f;
	Thu, 03 Jul 2025 10:56:50 +0300 (EEST)
Received: by mail.lja.fi (Postfix, from userid 120)
	id 5E9F144E1DA0; Thu, 03 Jul 2025 07:56:50 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.1.186] (kytkin.sokeavartija.org [192.168.1.1])
	by mail.lja.fi (Postfix) with ESMTPSA id 6DBD044E1D5E
	for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 07:56:25 +0000 (UTC)
Message-ID: <e348c346-86fb-4f12-bb39-a9367130af1f@lja.fi>
Date: Thu, 3 Jul 2025 10:56:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org
Content-Language: en-US
From: Lauri Jakku <lja@lja.fi>
Subject: New protocol: STCP Module
Autocrypt: addr=lja@lja.fi; keydata=
 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
 A3D2sYz2Kywkz93BSQTb1HXFN5nWuQ==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Copyrighted-Material: https://paxsudos.com/

Hi,


    I'm in process to make kernel module out of my STCP (Secure TCP) 
protocol. The protocol lives on top of

    normal TCP connection, that has AES encryption with elliptic key 
exchange.


    The packet format is [ 16/24/32 bytes of AES IV key ] + [ the 
AES-encrypted payload ] , located at TCP-packet

    payload.


    Packet handling:

       Incoming:

          Fetch the IV-vector of 16/24/32 bytes from incoming packet -> 
use it and predefined AES key to decrypt

          package, prior to handing the TCP-packet payload to receiver.


       Outgoing:

          Generate random IV-vector of 16/24/32 bytes and apply to 
outgoing payload -> use it and predefined

          AES key to encrypt package, prior to handing the sending the 
message to wire.


--Lja

.---<[ Paxsudos IT / Security Screening ]>---------------------------------------------------------------->
| Known viruses: 8707574
| Engine version: 1.4.3
| Scanned directories: 0
| Scanned files: 1
| Infected files: 0
| Data scanned: 0.00 MB
| Data read: 0.00 MB (ratio 1.00:1)
| Time: 22.996 sec (0 m 22 s)
| Start Date: 2025:07:03 07:56:25
| End Date:   2025:07:03 07:56:48
| SPAM hints: []
| SPAM hints: []
| Message not from DMARC.
`-------------------------------------------------------------------->


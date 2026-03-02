Return-Path: <netdev+bounces-262590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPoqEMdepWlc+QUAu9opvQ
	(envelope-from <netdev+bounces-262590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:56:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D95521D5D28
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10F723012B70
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2FC38CFEB;
	Mon,  2 Mar 2026 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bb4n52wz"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B538F62D
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445379; cv=none; b=NzEcKuv8UZOvAHowQwJjXXAN+GLbGoiFsJ9mLCag3/yzYBfMyari8g9IzWBDquqs1kBdCr/xu0+cT+g9fw4YO84NIYDq7RiyftXEwLvpj4/jo6B5lBCUWG1Bp5fLcKo3xEebUEfmztuyGg8e8guXnnb02Pv70GPOexN/O1B+M10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445379; c=relaxed/simple;
	bh=D0KxFnbwvWBXvSUMl04ospP8d1OL33PFIb9//WefRDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJwjrIF5p2YsvhPE0VxncDgzvS+EMkXjt4PfkvAgBH+/4b0XGsYhf+YOyS8CI8JcWWOlrFynzcCLn6U2kiSzx+CrVQAZ+VCf7eKNhMRxaRwf+ebynAhjAdkRU4Z1/XlqWdHcTt6nrFCuwkAYHgb+xcUKMEgCK/Hh9ydH3HlMXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bb4n52wz; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f611be70-8280-44c8-86af-5866c0b302be@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772445375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogbb8izUUOCVr3zds+H/TSHy0gLJv2X2iTVoxOk8pXs=;
	b=Bb4n52wz26KmKLCSgXwjxFWrQXXXxHulLp8dZT6asW/3v4IAcrSlhYYA4LreMSg1xwQltQ
	NLW21yocNyfyzSRldDFTM3AuEefNb44V2YemdwAqks7C5yxZJNWR2AXLhytGNw4gN4CFp9
	JMxmJ9979H/opdEXk0DIRjso9S/Gf34=
Date: Mon, 2 Mar 2026 17:55:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next] tcp: Add net.ipv4.tcp_purge_receive_queue
 sysctl
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Leon Hwang <leon.huangfu@shopee.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, kerneljasonxing@gmail.com,
 lance.yang@linux.dev, jiayuan.chen@linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260225074633.149590-1-leon.huangfu@shopee.com>
 <20260225174354.5a698ddb@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260225174354.5a698ddb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262590-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D95521D5D28
X-Rspamd-Action: no action



On 26/2/26 09:43, Jakub Kicinski wrote:
> On Wed, 25 Feb 2026 15:46:33 +0800 Leon Hwang wrote:
>> Issue:
>> When a TCP socket in the CLOSE_WAIT state receives a RST packet, the
>> current implementation does not clear the socket's receive queue. This
>> causes SKBs in the queue to remain allocated until the socket is
>> explicitly closed by the application. As a consequence:
>>
>> 1. The page pool pages held by these SKBs are not released.
> 
> On what kernel version and driver are you observing this?

# uname -r
6.19.0-061900-generic

# ethtool -i eth0
driver: mlx5_core
version: 6.19.0-061900-generic
firmware-version: 26.43.2566 (MT_0000000531)

In addition, the Python scripts below reproduce that SKBs remain in the
receive queue.

Thanks,
Leon

---

server.py:

import socket
import time

HOST, PORT = "127.0.0.1", 9999

s = socket.socket()
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 8 * 1024)

s.bind((HOST, PORT))
s.listen(1)

conn, addr = s.accept()
print("accepted", addr)

time.sleep(1)

print("Read 1st:", conn.recv(1))

try:
    conn.send(b"A")
    print("sent 1 byte to client")
except Exception as e:
    print("send failed:", e)

time.sleep(1)

conn.settimeout(0.2)
try:
    b = conn.recv(1)
    print("recv(1) after RST:", b, "len=", len(b))
except Exception as e:
    print("recv(1) after RST raised:", repr(e))

print("Conn remains opening..")

try:
    print("Press Ctrl+C to stop...")
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    print("\nProgram interrupted by user. Exiting.")

conn.close()
s.close()


client.py:

import socket
import time

HOST, PORT = "127.0.0.1", 9999

c = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
c.connect((HOST, PORT))

payload = b"x" * (4 * 1024)  # 4KiB
c.sendall(payload)
time.sleep(0.1)
c.close()

time.sleep(3)


